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

function build_test_logs() {
    echo "========================================="
    echo "Running Debloat Pass on Simple Test Cases - Logs"
    echo "========================================="
    for file in test/*.ll; do
        echo "Processing file: $file"
        result=$(basename "${file%???}")
        opt -enable-new-pm=0 -load build/dp-pass/libDebloatPass.so --dp-pass -o "$result-dp-pass.bc" "$file"  2> "$result-pass.log"
        mv "$result-pass.log" logs
        mv "$result-dp-pass.bc" test
        echo
    done
}
function build_test() {
    echo "========================================="
    echo "Running Debloat Pass on Simple Test Cases"
    echo "========================================="
    for file in test/*.ll; do
        echo "Processing file: $file"
        result=$(basename "${file%???}")
        echo "Processing file: $result"
        opt -enable-new-pm=0 -load ./build/dp-pass/libDebloatPass.so --dp-pass "$file" > test/"$result-dp-pass.bc"
        echo
    done
}

function build_sed() {
    echo "======================"
    echo "Building Sed"
    echo "======================"
    pushd ../../whole-prog-test/sed/sed_build
    ../configure CC=clang CFLAGS='-O3 -flto' LDFLAGS='-flto -fuse-ld=gold -Wl,-plugin-opt=save-temps' RANLIB=llvm-ranlib
    make
    cp sed/sed.0.0.preopt.bc ../../../out-of-tree-pass/debloat-pass/test/sed.ll
    popd
}

function configure_nginx(){
    pushd ../../whole-prog-test/nginx-1.24.0/
    
    ## Configure NGINX with wanted modules
    export RANLIB=llvm-ranlib
    ./configure --with-cc=clang --with-cc-opt="-flto -Wno-deprecated-declarations" --with-ld-opt="-flto -fuse-ld=gold -Wl,-plugin-opt=save-temps"
    make
    ## LLVM File & Executable found in objs/

    popd
}

function debloat_nginx(){
    ## Run pass on nginx/objs/nginx.0.0.preopt.bc
    opt -enable-new-pm=0 -load build/dp-pass/libDebloatPass.so --dp-pass -disable-output ../../whole-prog-test/nginx-1.24.0/objs/nginx.0.0.preopt.bc -o  ../../whole-prog-test/nginx-1.24.0/objs/nginx_dp-pass.bc 2> nginx-pass.log
    mv nginx-pass.log logs/
    ## Turn into executable for running
}



build_pass
#print_spaces
build_test_logs
#build_sed
#build_test
#configure_nginx # Only needed to change options nginx server has
#debloat_nginx