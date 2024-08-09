module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @oeq_self(%arg0: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg0 : f64
    llvm.return %0 : i1
  }
  llvm.func @une_self(%arg0: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg0 : f64
    llvm.return %0 : i1
  }
  llvm.func @ord_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %1 : i1
  }
  llvm.func @ord_nonzero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ord" %arg0, %0 : f64
    llvm.return %1 : i1
  }
  llvm.func @ord_self(%arg0: f32) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg0 : f32
    llvm.return %0 : i1
  }
  llvm.func @uno_zero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uno" %arg0, %0 : f64
    llvm.return %1 : i1
  }
  llvm.func @uno_nonzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.return %1 : i1
  }
  llvm.func @uno_self(%arg0: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg0 : f64
    llvm.return %0 : i1
  }
  llvm.func @ord_zero_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "ord" %arg0, %1 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ord_nonzero_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3.000000e+00, 5.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "ord" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @ord_self_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.fcmp "ord" %arg0, %arg0 : vector<2xf64>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @uno_zero_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "uno" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @uno_nonzero_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3.000000e+00, 5.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fcmp "uno" %arg0, %0 : vector<2xf64>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @uno_self_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "uno" %arg0, %arg0 : vector<2xf32>
    llvm.return %0 : vector<2xi1>
  }
  llvm.func @uno_vec_with_nan(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3.000000e+00, 0x7FF00000FFFFFFFF]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fcmp "uno" %arg0, %0 : vector<2xf64>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @uno_vec_with_poison(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.fcmp "uno" %arg0, %6 : vector<2xf64>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @ord_vec_with_poison(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.fcmp "ord" %arg0, %6 : vector<2xf64>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @nnan_ops_to_fcmp_ord(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %1 = llvm.fdiv %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = llvm.fcmp "ord" %0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @nnan_ops_to_fcmp_uno(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %1 = llvm.fdiv %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = llvm.fcmp "uno" %0, %1 : f32
    llvm.return %2 : i1
  }
  llvm.func @negative_zero_oeq(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }
  llvm.func @negative_zero_oge(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f64
    llvm.return %1 : i1
  }
  llvm.func @negative_zero_uge(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f16
    llvm.return %1 : i1
  }
  llvm.func @negative_zero_olt_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @negative_zero_une_vec_poison(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.fcmp "une" %arg0, %6 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf64>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @negative_zero_ule_vec_mixed(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "ule" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }
}
