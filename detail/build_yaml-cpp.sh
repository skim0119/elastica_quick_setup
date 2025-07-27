#!/usr/bin/env sh

# YAML_CPP automatically installs in the YAML_CPP subdirectory
YAML_CPP_BUILD_DIR="build"
YAML_CPP_INSTALL_PREFIX=${1:-"${HOME}/Desktop/third_party_installed"}
mkdir -p "${YAML_CPP_INSTALL_PREFIX}"

_CXX_COMPILER="$2"
_PARALLEL_ARG=${3:-"1"}

# >3.14
# -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}
cmake -B "${YAML_CPP_BUILD_DIR}" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CXX_COMPILER="${_CXX_COMPILER}" \
	-DYAML_BUILD_SHARED_LIBS=on \
	-S .
cmake --build "${YAML_CPP_BUILD_DIR}" --parallel "${_PARALLEL_ARG}"
cmake --install "${YAML_CPP_BUILD_DIR}" --prefix "${YAML_CPP_INSTALL_PREFIX}"

unset _PARALLEL_ARG
unset _CXX_COMPILER
unset YAML_CPP_BUILD_DIR
unset YAML_CPP_INSTALL_PREFIX
