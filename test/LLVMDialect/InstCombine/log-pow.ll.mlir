module  {
  llvm.func @log_pow(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @pow(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @log10f_powf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @powf(%arg0, %arg1) : (f32, f32) -> f32
    %1 = llvm.call @llvm.log10.f32(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @log2v_powv(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.call @llvm.pow.v2f64(%arg0, %arg1) : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    %1 = llvm.call @llvm.log2.v2f64(%0) : (vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @log_pow_not_fast(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @pow(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @function_pointer(%arg0: !llvm.ptr<func<f32 ()>>, %arg1: f32) -> f32 {
    %0 = llvm.call %arg0() : () -> f32
    %1 = llvm.call @logf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @log10_exp(%arg0: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) : (f64) -> f64
    %1 = llvm.call @log10(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @logv_exp2v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.call @llvm.exp2.v2f32(%arg0) : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.call @llvm.log.v2f32(%0) : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @log2f_exp10f(%arg0: f32) -> f32 {
    %0 = llvm.call @exp10f(%arg0) : (f32) -> f32
    %1 = llvm.call @log2f(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @log_exp2_not_fast(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @pr43617(%arg0: f64, %arg1: i32, %arg2: !llvm.ptr<func<f64 (i32)>>) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call %arg2(%arg1) : (i32) -> f64
    %3 = llvm.call @llvm.log.f64(%2) : (f64) -> f64
    %4 = llvm.fmul %3, %1  : f64
    llvm.return %4 : f64
  }
  llvm.func @log(f64) -> f64
  llvm.func @logf(f32) -> f32
  llvm.func @llvm.log.f64(f64) -> f64
  llvm.func @llvm.log.v2f32(vector<2xf32>) -> vector<2xf32>
  llvm.func @log2f(f32) -> f32
  llvm.func @llvm.log2.v2f64(vector<2xf64>) -> vector<2xf64>
  llvm.func @log10(f64) -> f64
  llvm.func @llvm.log10.f32(f32) -> f32
  llvm.func @exp(f64) -> f64
  llvm.func @exp2(f64) -> f64
  llvm.func @exp10f(f32) -> f32
  llvm.func @llvm.exp2.v2f32(vector<2xf32>) -> vector<2xf32>
  llvm.func @pow(f64, f64) -> f64
  llvm.func @powf(f32, f32) -> f32
  llvm.func @llvm.pow.v2f64(vector<2xf64>, vector<2xf64>) -> vector<2xf64>
}
