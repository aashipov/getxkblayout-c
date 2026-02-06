#!/bin/sh

with_clang_and_lld() {
    export CC=/usr/bin/clang CXX=/usr/bin/clang++ LDFLAGS="-fuse-ld=lld"
}

with_cmake() {
    cd ${_SCRIPT_DIR}
    rm -rf ${BUILD_DIR_NAME}
    mkdir ${BUILD_DIR_NAME} && cd ${BUILD_DIR_NAME}
    cmake .. -DCMAKE_INSTALL_PREFIX=${HOME}/.local/ -DCMAKE_BUILD_TYPE=Debug
    make
}

with_meson_and_ninja() {
    cd ${_SCRIPT_DIR}
    rm -rf ${BUILD_DIR_NAME}
    meson setup ${BUILD_DIR_NAME} -Dbuildtype=debug -Ddebug=true --prefix=${HOME}/.local/
    meson compile -C ${BUILD_DIR_NAME}
}

closure() {
    # https://stackoverflow.com/a/1482133
    # Consistent across Linux bash, Cygwin terminal and Git Bash
    local _SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0")")

    local BUILD_DIR_NAME="build"
    
    with_cmake
    with_clang_and_lld
    with_meson_and_ninja
}

closure
