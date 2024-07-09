module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @vector_reduce_maximum_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmaximum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }
  llvm.func @vector_reduce_maximum_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmaximum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }
  llvm.func @vector_reduce_minimum_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fminimum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }
  llvm.func @vector_reduce_minimum_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fminimum(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }
  llvm.func @vector_reduce_max_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmax(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }
  llvm.func @vector_reduce_max_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmax(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }
  llvm.func @vector_reduce_min_signbit(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }
  llvm.func @vector_reduce_min_signbit_fail_maybe_nan(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmin(%1)  : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }
  llvm.func @vector_reduce_min_signbit_nnan_from_fmf(%arg0: vector<4xf64>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %2 = llvm.intr.vector.reduce.fmin(%1)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<4xf64>) -> f64
    %3 = llvm.fcmp "oge" %2, %0 : f64
    llvm.return %3 : i1
  }
}
