module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i1)
  llvm.func @test_and_olt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_ole(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 : f32
    %3 = llvm.fcmp "oge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_or_ogt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.fcmp "olt" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_or_oge(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 : f32
    %3 = llvm.fcmp "ole" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_ult(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fcmp "ugt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_ule(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ule" %arg0, %0 : f32
    %3 = llvm.fcmp "uge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_or_ugt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.fcmp "ult" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_or_uge(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "uge" %arg0, %0 : f32
    %3 = llvm.fcmp "ule" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_commuted(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_subnormal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.401300e-45 : f32) : f32
    %1 = llvm.mlir.constant(-1.401300e-45 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_infinity(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_ole_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 : f32
    %3 = llvm.fcmp "oge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_logical(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    %4 = llvm.fcmp "ogt" %arg0, %1 : f32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @test_and_olt_poison(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %8 = llvm.mlir.undef : vector<2xf32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xf32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xf32>
    %13 = llvm.fcmp "olt" %arg0, %6 : vector<2xf32>
    %14 = llvm.fcmp "ogt" %arg0, %12 : vector<2xf32>
    %15 = llvm.and %13, %14  : vector<2xi1>
    llvm.return %15 : vector<2xi1>
  }
  llvm.func @test_and_olt_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.mlir.constant(0xFFC00000 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_ult_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800001 : f32) : f32
    %1 = llvm.mlir.constant(0xFF800001 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fcmp "ugt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_or_ogt_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800001 : f32) : f32
    %1 = llvm.mlir.constant(0xFF800001 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.fcmp "olt" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_or_ugt_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800001 : f32) : f32
    %1 = llvm.mlir.constant(0xFF800001 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.fcmp "ult" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_ogt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.fcmp "olt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_or_olt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_multiuse(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_mismatched_lhs(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg1, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_same_sign(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @test_and_olt_mismatched_mag(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.77555756E-17 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_wrong_pred2(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "oge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_fmf_propagation(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @test_and_olt_fmf_propagation_union(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
}
