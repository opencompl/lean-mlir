module  {
  llvm.func @llvm.ceil.f32(f32) -> f32
  llvm.func @llvm.ceil.f64(f64) -> f64
  llvm.func @llvm.ceil.v4f32(vector<4xf32>) -> vector<4xf32>
  llvm.func @constant_fold_ceil_f32_01() -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @llvm.ceil.f32(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @constant_fold_ceil_f32_02() -> f32 {
    %0 = llvm.mlir.constant(1.250000e+00 : f32) : f32
    %1 = llvm.call @llvm.ceil.f32(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @constant_fold_ceil_f32_03() -> f32 {
    %0 = llvm.mlir.constant(-1.250000e+00 : f32) : f32
    %1 = llvm.call @llvm.ceil.f32(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @constant_fold_ceil_v4f32_01() -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 1.250000e+00, -1.250000e+00, -1.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.call @llvm.ceil.v4f32(%0) : (vector<4xf32>) -> vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }
  llvm.func @constant_fold_ceil_f64_01() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @llvm.ceil.f64(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @constant_fold_ceil_f64_02() -> f64 {
    %0 = llvm.mlir.constant(1.300000e+00 : f64) : f64
    %1 = llvm.call @llvm.ceil.f64(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @constant_fold_ceil_f64_03() -> f64 {
    %0 = llvm.mlir.constant(-1.750000e+00 : f64) : f64
    %1 = llvm.call @llvm.ceil.f64(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
}
