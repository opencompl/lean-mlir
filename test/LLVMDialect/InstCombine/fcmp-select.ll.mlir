module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i1)
  llvm.func @usef64(f64)
  llvm.func @oeq(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "oeq" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %0 : i1, f64
    llvm.return %2 : f64
  }
  llvm.func @oeq_swapped(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %0, %arg0 : i1, f32
    llvm.return %2 : f32
  }
  llvm.func @une(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "une" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %0 : i1, f64
    llvm.return %2 : f64
  }
  llvm.func @une_swapped(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "une" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %0, %arg0 : i1, f64
    llvm.return %2 : f64
  }
  llvm.func @une_could_be_negzero(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg0, %arg1 : i1, f64
    llvm.return %1 : f64
  }
  llvm.func @une_swapped_could_be_negzero(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg1, %arg0 : i1, f64
    llvm.return %1 : f64
  }
  llvm.func @one(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.fcmp "one" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %0 : i1, f64
    llvm.return %2 : f64
  }
  llvm.func @one_swapped(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.fcmp "one" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %0, %arg0 : i1, f64
    llvm.return %2 : f64
  }
  llvm.func @fcmp_oeq_select(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, f32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, f32
    %2 = llvm.fcmp "oeq" %0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_uno_select(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, f32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, f32
    %2 = llvm.fcmp "uno" %0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @fcmp_ogt_select(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, f32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, f32
    %2 = llvm.fcmp "ogt" %0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @test_fcmp_select_const_const(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %2 = llvm.fcmp "ord" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %0 : i1, f64
    %4 = llvm.fcmp "oeq" %3, %0 : f64
    llvm.return %4 : i1
  }
  llvm.func @test_fcmp_select_var_const(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.1920928955078125E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %arg1, %1 : i1, f64
    %4 = llvm.fcmp "olt" %3, %0 : f64
    llvm.return %4 : i1
  }
  llvm.func @test_fcmp_select_var_const_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.1920928955078125E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %arg1, %1 : i1, f64
    %4 = llvm.fcmp "olt" %3, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f64
    llvm.return %4 : i1
  }
  llvm.func @test_fcmp_select_const_const_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<0xFFFFFFFFFFFFFFFF> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.fcmp "ord" %arg0, %1 : vector<2xf64>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xf64>
    %5 = llvm.fcmp "oeq" %4, %1 : vector<2xf64>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @test_fcmp_select_clamp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(9.000000e-01 : f64) : f64
    %1 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %0, %arg0 : i1, f64
    %4 = llvm.fcmp "olt" %3, %1 : f64
    %5 = llvm.select %4, %1, %3 : i1, f64
    llvm.return %5 : f64
  }
  llvm.func @test_fcmp_select_maxnum(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.550000e+02 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    %4 = llvm.fcmp "olt" %3, %1 : f64
    %5 = llvm.select %4, %3, %1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64
    llvm.return %5 : f64
  }
  llvm.func @test_fcmp_select_const_const_multiuse(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %2 = llvm.fcmp "ord" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %0 : i1, f64
    llvm.call @usef64(%3) : (f64) -> ()
    %4 = llvm.fcmp "oeq" %3, %0 : f64
    llvm.return %4 : i1
  }
  llvm.func @test_fcmp_select_const_const_unordered(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %2 = llvm.fcmp "uno" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %0 : i1, f64
    %4 = llvm.fcmp "oeq" %3, %0 : f64
    llvm.return %4 : i1
  }
  llvm.func @test_fcmp_select_var_const_unordered(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.1920928955078125E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f64
    %3 = llvm.select %2, %arg1, %1 : i1, f64
    %4 = llvm.fcmp "ugt" %3, %0 : f64
    llvm.return %4 : i1
  }
}
