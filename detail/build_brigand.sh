#!/usr/bin/env sh

# BRIGAND automatically installs in the brigand subdirectory
BRIGAND_BUILD_DIR="build"
BRIGAND_INSTALL_PREFIX=${1:-"${HOME}/Desktop/third_party_installed"}

mkdir -p "${BRIGAND_INSTALL_PREFIX}"

_CXX_COMPILER="$2"
_PARALLEL_ARG=${3:-"1"}

# Requires >3.14
cmake -B "${BRIGAND_BUILD_DIR}" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CXX_COMPILER="${_CXX_COMPILER}" \
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
	-DBUILD_TESTING=OFF \
	-S .
cmake --build "${BRIGAND_BUILD_DIR}" --parallel "${_PARALLEL_ARG}"
cmake --install "${BRIGAND_BUILD_DIR}" --prefix "${BRIGAND_INSTALL_PREFIX}"

unset _PARALLEL_ARG
unset _CXX_COMPILER
unset BRIGAND_BUILD_DIR
unset BRIGAND_INSTALL_PREFIX
