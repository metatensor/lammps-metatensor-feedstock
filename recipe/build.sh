#!/bin/bash

PLATFORM=$(uname)

if [[ "$PLATFORM" == 'Darwin' ]]; then
  BUILD_OMP=OFF
elif [[ "$PLATFORM" == 'Linux' ]]; then
  BUILD_OMP=ON
  if [[ ${cuda_compiler_version} != "None" ]]; then
    CMAKE_ARGS="$CMAKE_ARGS -DPKG_KOKKOS=ON -DKokkos_ENABLE_OPENMP=ON -DKokkos_ENABLE_CUDA=ON"
    # inspired by lammps' `cmake/presets/kokkos-cuda.cmake`
    CMAKE_ARGS="$CMAKE_ARGS -DFFT_KOKKOS=CUFFT"
    CMAKE_ARGS="$CMAKE_ARGS -DCMAKE_CXX_COMPILER=$(pwd)/lib/kokkos/bin/nvcc_wrapper"
    CMAKE_ARGS="$CMAKE_ARGS -DKokkos_ENABLE_DEPRECATION_WARNINGS=OFF"
    CMAKE_ARGS="$CMAKE_ARGS -DKokkos_ARCH_${kokkos_arch}=ON"

    # silent a warning about "calling a constexpr __host__ function from a __host__ __device__ function"
    CMAKE_ARGS="$CMAKE_ARGS -DCMAKE_CXX_FLAGS=--expt-relaxed-constexpr"
  else
    # Make sure to link to `libtorch.so` and not just `libtorch_cpu.so`. This
    # way, the code will try to load `libtorch_cuda.so` as well, enabling cuda
    # device where available even when not using kokkos.
    export LDFLAGS="-lm -ldl -Wl,--no-as-needed,$PREFIX/lib/libtorch.so -Wl,--as-needed"
  fi
fi

if [ "${mpi}" == "nompi" ]; then
  ENABLE_MPI=OFF
else
  ENABLE_MPI=TRUE
fi


mkdir build && cd build

cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=TRUE \
      -DLAMMPS_INSTALL_RPATH=ON \
      -DBUILD_OMP=$BUILD_OMP \
      -DENABLE_MPI=$ENABLE_MPI \
      -DWITH_JPEG=OFF \
      -DWITH_PNG=OFF \
      -DPKG_REPLICA=ON \
      -DPKG_MC=ON \
      -DPKG_MOLECULE=ON \
      -DPKG_MISC=ON \
      -DPKG_PLUMED=ON \
      -DDOWNLOAD_PLUMED=OFF \
      -DPLUMED_MODE="shared" \
      -DPKG_KSPACE=ON \
      -DPKG_MANIFOLD=ON \
      -DPKG_ML-METATENSOR=ON \
      -DDOWNLOAD_METATENSOR=OFF \
      -DPKG_QTB=ON \
      -DPKG_REACTION=ON \
      -DPKG_RIGID=ON \
      -DPKG_SHOCK=ON \
      -DPKG_SPIN=ON \
      -DPKG_MPIIO=$ENABLE_MPI \
      -DPKG_EXTRA_PAIR=ON \
      $CMAKE_ARGS \
      ../cmake

cmake --build . --parallel ${CPU_COUNT} -- VERBOSE=1
cmake --build . --target install
