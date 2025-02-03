#!/bin/bash

PLATFORM=$(uname)
BUILD_OMP=ON

if [[ "$PLATFORM" == 'Darwin' ]]; then
  BUILD_OMP=OFF
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
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      ../cmake

cmake --build . --parallel ${CPU_COUNT} -- VERBOSE=1
cmake --build . --target install

