#!/usr/bin/env sh

# TBB automatically installs in the TBB subdirectory
TBB_BUILD_DIR="build"
TBB_INSTALL_PREFIX=${1:-"${HOME}/Desktop/third_party_installed"}
mkdir -p "${TBB_INSTALL_PREFIX}"

_CXX_COMPILER="$2"
_PARALLEL_ARG=${3:-"1"}

# >3.14
# -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}
# TBB static build is discouraged for some reason
cmake -B "${TBB_BUILD_DIR}" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CXX_COMPILER="${_CXX_COMPILER}" \
	-DTBB_TEST=OFF \
	-DTBB4PY_BUILD=OFF \
	-DBUILD_SHARED_LIBS=ON \
	-S .
cmake --build "${TBB_BUILD_DIR}" --parallel "${_PARALLEL_ARG}"
cmake --install "${TBB_BUILD_DIR}" --prefix "${TBB_INSTALL_PREFIX}"

unset _PARALLEL_ARG
unset _CXX_COMPILER
unset TBB_BUILD_DIR
unset TBB_INSTALL_PREFIX
