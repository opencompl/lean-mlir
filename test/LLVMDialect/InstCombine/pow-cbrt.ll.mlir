module  {
  llvm.func @pow_intrinsic_third_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_intrinsic_third_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_third_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_intrinsic_third_approx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_third_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_libcall_third_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_negthird_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_intrinsic_negthird_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_intrinsic_negthird_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.call @llvm.pow.f64(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_intrinsic_negthird_approx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.call @llvm.pow.f32(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @pow_libcall_negthird_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @powf_libcall_negthird_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @llvm.pow.f64(f64, f64) -> f64
  llvm.func @llvm.pow.f32(f32, f32) -> f32
  llvm.func @pow(f64, f64) -> f64
  llvm.func @powf(f32, f32) -> f32
}
