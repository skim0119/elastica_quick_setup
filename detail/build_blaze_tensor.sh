#!/usr/bin/env sh

# Blaze automatically installs in the blaze subdirectory
BLAZE_TENSOR_BUILD_DIR="build"
BLAZE_TENSOR_INSTALL_PREFIX=${1:-"${HOME}/Desktop/third_party_installed"}

BLAZE_PATH="${1}/share/blaze/cmake/"
mkdir -p "${BLAZE_TENSOR_INSTALL_PREFIX}"

_CXX_COMPILER="$2"
_PARALLEL_ARG=${3:-"1"}

# Requires >3.14
function fail() {
	printf '%s\n' "$1" >&2 ## Send message to stderr.
	exit "${2-1}"          ## Return a code specified by $2, or 1 by default.
}

# Apply patches before building the project
patch -p0 <dtenstransposer.patch || fail "Could not apply patch"
cmake -B "${BLAZE_TENSOR_BUILD_DIR}" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CXX_COMPILER="${_CXX_COMPILER}" \
	-Dblaze_DIR="${BLAZE_PATH}" \
	-S .
cmake --build "${BLAZE_TENSOR_BUILD_DIR}" --parallel "${_PARALLEL_ARG}"
cmake --install "${BLAZE_TENSOR_BUILD_DIR}" --prefix "${BLAZE_TENSOR_INSTALL_PREFIX}"

unset _PARALLEL_ARG
unset _CXX_COMPILER
unset BLAZE_PATH
unset BLAZE_TENSOR_BUILD_DIR
unset BLAZE_TENSOR_INSTALL_PREFIX
