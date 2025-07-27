#!/usr/bin/env sh

# SPLINE automatically installs in the brigand subdirectory
SPLINE_BUILD_DIR="build"
SPLINE_INSTALL_PREFIX=${1:-"${HOME}/Desktop/third_party_installed"}

mkdir -p "${SPLINE_INSTALL_PREFIX}"

_CXX_COMPILER="$2"
_PARALLEL_ARG=${3:-"1"}

# Requires >3.14
# Spline does not install correctly if install prefix is not passed to the generation step.
cmake -B "${SPLINE_BUILD_DIR}" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CXX_COMPILER="${_CXX_COMPILER}" \
	-DCMAKE_INSTALL_PREFIX="${SPLINE_INSTALL_PREFIX}" \
	-S .
cmake --build "${SPLINE_BUILD_DIR}" --parallel "${_PARALLEL_ARG}"
cmake --install "${SPLINE_BUILD_DIR}" --prefix "${SPLINE_INSTALL_PREFIX}"

unset _PARALLEL_ARG
unset _CXX_COMPILER
unset SPLINE_BUILD_DIR
unset SPLINE_INSTALL_PREFIX
