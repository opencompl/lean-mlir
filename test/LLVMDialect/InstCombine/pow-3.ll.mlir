module  {
  llvm.func @llvm.pow.f64(f64, f64) -> f64
  llvm.func @pow(f64, f64) -> f64
  llvm.func @sqrt_libcall(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_intrinsic(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @shrink_libcall(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @shrink_intrinsic(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @llvm.pow.f64(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
}
