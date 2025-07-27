#!/usr/bin/env sh

# Blaze automatically installs in the blaze subdirectory
BLAZE_BUILD_DIR="build"
BLAZE_INSTALL_PREFIX=${1:-"${HOME}/Desktop/third_party_installed"}
mkdir -p "${BLAZE_INSTALL_PREFIX}"

_CXX_COMPILER="$2"
_PARALLEL_ARG=${3:-"1"}

# The last commit of blaze seems faulty and leads to segfault
# within elastica++. We revert that here just to be sure.
git fetch --unshallow # undo depth 1
git checkout cb472ee  # Declare the 'rows()', 'columns()', 'spacing()', and 'capacity()' functions of all adapters as 'constexpr'

# >3.14
# -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}
cmake -B "${BLAZE_BUILD_DIR}" \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_CXX_COMPILER="${_CXX_COMPILER}" \
	-DBLAZE_SHARED_MEMORY_PARALLELIZATION=OFF \
	-DUSE_LAPACK=OFF \
	-S .
cmake --build "${BLAZE_BUILD_DIR}" --parallel "${_PARALLEL_ARG}"
cmake --install "${BLAZE_BUILD_DIR}" --prefix "${BLAZE_INSTALL_PREFIX}"

unset _PARALLEL_ARG
unset _CXX_COMPILER
unset BLAZE_BUILD_DIR
unset BLAZE_INSTALL_PREFIX
