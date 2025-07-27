#!/usr/bin/env sh

# CXXOPTS automatically installs in the CXXOPTS subdirectory
CXXOPTS_BUILD_DIR="build"
CXXOPTS_INSTALL_PREFIX=${1:-"${HOME}/Desktop/third_party_installed"}

mkdir -p "${CXXOPTS_INSTALL_PREFIX}"

_CXX_COMPILER="$2"
_PARALLEL_ARG=${3:-"1"}

# Requires >3.14
cmake -B "${CXXOPTS_BUILD_DIR}" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CXX_COMPILER="${_CXX_COMPILER}" \
	-DCXXOPTS_BUILD_EXAMPLES=OFF \
	-DCXXOPTS_BUILD_TESTS=OFF \
	-S .
cmake --build "${CXXOPTS_BUILD_DIR}" --parallel "${_PARALLEL_ARG}"
cmake --install "${CXXOPTS_BUILD_DIR}" --prefix "${CXXOPTS_INSTALL_PREFIX}"

unset _PARALLEL_ARG
unset _CXX_COMPILER
unset CXXOPTS_BUILD_DIR
unset CXXOPTS_INSTALL_PREFIX
