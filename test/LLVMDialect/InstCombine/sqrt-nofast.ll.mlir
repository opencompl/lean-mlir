module  {
  llvm.func @mysqrt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr<f32>
    %2 = llvm.alloca %0 x f32 : (i32) -> !llvm.ptr<f32>
    llvm.store %arg0, %1 : !llvm.ptr<f32>
    llvm.store %arg1, %2 : !llvm.ptr<f32>
    %3 = llvm.load %1 : !llvm.ptr<f32>
    %4 = llvm.load %1 : !llvm.ptr<f32>
    %5 = llvm.fmul %3, %4  : f32
    %6 = llvm.call @llvm.sqrt.f32(%5) : (f32) -> f32
    llvm.return %6 : f32
  }
  llvm.func @llvm.sqrt.f32(f32) -> f32
  llvm.func @fake_sqrt(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  : f64
    %1 = llvm.call @sqrtf(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrtf(f64) -> f64
}
