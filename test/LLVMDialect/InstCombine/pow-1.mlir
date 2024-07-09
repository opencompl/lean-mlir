module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @powf(f32, f32) -> f32
  llvm.func @pow(f64, f64) -> f64
  llvm.func @test_simplify1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify1_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify1v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @test_simplify2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify2_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify2v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_simplify3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify3_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify3n_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.500000e-01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify3v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @test_simplify3vn(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<4.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_simplify4(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify4_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify4n(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(8.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify4n_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(8.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify4v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_simplify4vn(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @test_simplify5(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify5_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify5v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.pow(%arg0, %1)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }
  llvm.func @test_simplify6(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify6_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify6v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.pow(%arg0, %1)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }
  llvm.func @powf_libcall_half_ninf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_libcall_half_ninf_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_libcall_half_assume_ninf_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %2 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %3 = llvm.fcmp "one" %2, %0 : f32
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.call @powf(%arg0, %1) : (f32, f32) -> f32
    llvm.return %4 : f32
  }
  llvm.func @powf_libcall_half_ninf_tail(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_libcall_half_ninf_tail_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_libcall_half_ninf_musttail(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @powf_libcall_half_ninf_musttail_noerrno(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_libcall_half_no_FMF_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify9(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }
  llvm.func @test_simplify10(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %2 = llvm.intr.pow(%0, %1)  : (f64, f64) -> f64
    llvm.return %2 : f64
  }
  llvm.func @test_simplify11(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify11_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify11v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @test_simplify12(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify12_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify12v(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow2_strict(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow2_strict_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow2_strictv(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @pow2_double_strict(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow2_double_strict_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow2_double_strictv(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow2_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow2_fast_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_neg1_strict(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_neg1_strict_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_neg1_strictv(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @pow_neg1_double_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_neg1_double_fast_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pow_neg1_double_fastv(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @pow_intrinsic_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify18(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify18_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_simplify19(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_simplify19_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_libcall_powf_10_f32_noerrno(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_libcall_pow_10_f64_noerrno(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_pow_10_f16(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+01 : f16) : f16
    %1 = llvm.intr.pow(%0, %arg0)  : (f16, f16) -> f16
    llvm.return %1 : f16
  }
  llvm.func @test_pow_10_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.intr.pow(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @test_pow_10_f64(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.intr.pow(%0, %arg0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_pow_10_fp128(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.fpext %0 : f64 to f128
    %2 = llvm.intr.pow(%1, %arg0)  : (f128, f128) -> f128
    llvm.return %2 : f128
  }
  llvm.func @test_pow_10_bf16(%arg0: bf16) -> bf16 {
    %0 = llvm.mlir.constant(1.000000e+01 : bf16) : bf16
    %1 = llvm.intr.pow(%0, %arg0)  : (bf16, bf16) -> bf16
    llvm.return %1 : bf16
  }
  llvm.func @test_pow_10_v2f16(%arg0: vector<2xf16>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf16>, vector<2xf16>) -> vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }
  llvm.func @test_pow_10_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @test_pow_10_v2f64(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @test_pow_10_v2bf16(%arg0: vector<2xbf16>) -> vector<2xbf16> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<2xbf16>) : vector<2xbf16>
    %1 = llvm.intr.pow(%0, %arg0)  : (vector<2xbf16>, vector<2xbf16>) -> vector<2xbf16>
    llvm.return %1 : vector<2xbf16>
  }
}
