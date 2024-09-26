uname -a
cat /proc/cpuinfo | grep 'model name' | head -1
echo
executables=(
"gemm_gmp_10_naive_ijl"
"gemm_gmp_11_naive_jli"
"gemm_gmp_12_naive_jli_openmp"
"gemm_gmp_20_mpblas_orig"
"gemm_gmp_20_mpblas_compat"
"gemm_gmp_20_mpblas_mkII"
"gemm_gmp_20_mpblas_mkIISR"
"gemm_gmp_21_mpblas_openmp_orig"
"gemm_gmp_21_mpblas_openmp_compat"
"gemm_gmp_21_mpblas_openmp_mkII"
"gemm_gmp_21_mpblas_openmp_mkIISR"
"gemm_gmp_30_mpblaslike_naive_ijl_compat"
"gemm_gmp_30_mpblaslike_naive_ijl_mkII"
"gemm_gmp_30_mpblaslike_naive_ijl_mkIISR"
"gemm_gmp_30_mpblaslike_naive_ijl_orig"
)
for exe in "${executables[@]}"; do
    echo "./$exe 1000 1000 1000 512"
    ./$exe 1000 1000 1000 512
    if [ -f gmon.out ]; then
        mv gmon.out "gmon_${exe}.out"
        gprof ./$exe "gmon_${exe}.out" > "gprof_${exe}.txt"
    fi
    echo
done
