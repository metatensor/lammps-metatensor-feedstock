#!/bin/bash

PLATFORM=$(uname)
BUILD_OMP=ON

if [[ "$PLATFORM" == 'Darwin' ]]; then
  BUILD_OMP=OFF
fi

if [ "${mpi}" == "nompi" ]; then
  ENABLE_MPI=OFF
else
  ENABLE_MPI=TRUE
  export LDFLAGS="-lmpi ${LDFLAGS}"
fi

mkdir build && cd build

cmake -DPKG_ML-METATENSOR=ON \
      -DLAMMPS_INSTALL_RPATH=ON \
      -DCMAKE_PREFIX_PATH="$TORCH_PREFIX" \
      -DPKG_REPLICA=OFF \
      -DPKG_PLUMED=OFF \
      -DPKG_MC=OFF \
      -DPKG_MOLECULE=OFF \
      -DBUILD_OMP=$BUILD_OMP \
      -DENABLE_MPI=$ENABLE_MPI \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      ../cmake

cmake --build . --parallel ${CPU_COUNT} -- VERBOSE=1
cmake --build . --target install

cp lmp $PREFIX/bin/lmp

if [ "${mpi}" == "nompi" ]; then
  ln -s lmp ${PREFIX}/bin/lmp_serial
else
  ln -s lmp ${PREFIX}/bin/lmp_mpi
fi
