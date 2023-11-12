#function run_nginx(){
#}

#function run_sed() {
#}

function test_sed() {
    pushd test/
    orig_file="sed.ll"
    orig_name=$(basename "${orig_file%???}")
    #echo $orig_name
    altered_file="sed-dp-pass.bc"
    altered_name=$(basename "${altered_file%???}")
    #echo $altered_name

    echo "================="
    echo "Test original Sed"
    echo "================="
    ## Run the original sed function    
    llc -filetype=obj $orig_file
    clang $orig_name.o -o $orig_name.exe
    orig_exe="$orig_name.exe"
    ./$orig_exe 's/unix/linux/' test.txt
    echo

    echo "================="
    echo "Test New Sed"
    echo "================="
    ## Run the new sed function
    llc -filetype=obj $altered_file
    clang $altered_name.o -o $altered_name.exe
    altered_exe="$altered_name.exe"
    ./$altered_exe 's/unix/linux/' test.txt

    popd
}

test_sed