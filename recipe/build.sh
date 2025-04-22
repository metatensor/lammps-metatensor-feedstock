#!/bin/bash

PLATFORM=$(uname)
args=""

if [[ "$PLATFORM" == 'Darwin' ]]; then
  BUILD_OMP=OFF
else
  BUILD_OMP=ON
  # if [[ ${cuda_compiler_version} != "None" ]]; then
  #   CUDA_TOOLKIT_ROOT_DIR=$BUILD_PREFIX/targets/x86_64-linux
  #   args=$args" -DPKG_KOKKOS=ON -DKokkos_ENABLE_OPENMP=ON -DKokkos_ENABLE_CUDA=ON ${Kokkos_OPT_ARGS} -DCUDA_TOOLKIT_ROOT_DIR=$CUDA_TOOLKIT_ROOT_DIR "
  # fi
fi

# Parallel and library
export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
export LD_LIBRARY_PATH="$PREFIX/lib:$LD_LIBRARY_PATH"

if [ "${mpi}" == "nompi" ]; then
  ENABLE_MPI=OFF
else
  ENABLE_MPI=TRUE
  export LDFLAGS="-lmpi ${LDFLAGS}"
fi


mkdir build && cd build

cmake -DLAMMPS_INSTALL_RPATH=ON \
      -DCMAKE_PREFIX_PATH="$TORCH_PREFIX" \
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
      -DBUILD_OMP=$BUILD_OMP \
      -DENABLE_MPI=$ENABLE_MPI \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=TRUE \
      -DCMAKE_INSTALL_RPATH=$PREFIX/lib \
      $args \
      ../cmake

cmake --build . --parallel ${CPU_COUNT} -- VERBOSE=1
cmake --build . --target install

# if [ "${mpi}" == "nompi" ]; then
#   cp lmp ${PREFIX}/bin/lmp_serial
# else
#   cp lmp ${PREFIX}/bin/lmp_mpi
# fi
