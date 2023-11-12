#!/bin/bash

function build_pass() {
    echo "======================"
    echo "Building Debloat Pass"
    echo "======================"
    mkdir -p build
    pushd build
    cmake ..
    make
    popd
}

function print_spaces() {
    echo
    echo
    echo
}

function run_test() {
    echo "========================================="
    echo "Running Debloat Pass on Simple Test Cases"
    echo "========================================="
    pushd test
    for file in *.ll; do
        echo "Processing file: $file"
        pwd
        opt -enable-new-pm=0 -load build/dp-pass/libDebloatPass.so --dp-pass -disable-output "$file" 2> "$file-pass.log"
        mv "$file-pass.log" ../logs
        echo
    done
    popd
}

build_pass
print_spaces
run_test