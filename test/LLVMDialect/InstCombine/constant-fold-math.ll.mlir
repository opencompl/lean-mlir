module  {
  llvm.func @llvm.fma.f32(f32, f32, f32) -> f32
  llvm.func @llvm.fmuladd.f32(f32, f32, f32) -> f32
  llvm.func @llvm.fma.v4f32(vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
  llvm.func @llvm.fma.f64(f64, f64, f64) -> f64
  llvm.func @llvm.fmuladd.f64(f64, f64, f64) -> f64
  llvm.func @llvm.sqrt.f64(f64) -> f64
  llvm.func @constant_fold_fma_f32() -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.call @llvm.fma.f32(%2, %1, %0) : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @constant_fold_fma_v4f32() -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+01> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<2.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %3 = llvm.call @llvm.fma.v4f32(%2, %1, %0) : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @constant_fold_fmuladd_f32() -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.call @llvm.fmuladd.f32(%2, %1, %0) : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @constant_fold_fma_f64() -> f64 {
    %0 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.call @llvm.fma.f64(%2, %1, %0) : (f64, f64, f64) -> f64
    llvm.return %3 : f64
  }
  llvm.func @constant_fold_fmuladd_f64() -> f64 {
    %0 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.call @llvm.fmuladd.f64(%2, %1, %0) : (f64, f64, f64) -> f64
    llvm.return %3 : f64
  }
  llvm.func @constant_fold_frem_f32() -> f32 {
    %0 = llvm.mlir.constant(-2.50991821E+9 : f32) : f32
    %1 = llvm.mlir.constant(4.03345148E+18 : f32) : f32
    %2 = llvm.frem %1, %0  : f32
    llvm.return %2 : f32
  }
  llvm.func @constant_fold_frem_f64() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(9.2233720368547758E+18 : f64) : f64
    %2 = llvm.frem %1, %0  : f64
    llvm.return %2 : f64
  }
}
