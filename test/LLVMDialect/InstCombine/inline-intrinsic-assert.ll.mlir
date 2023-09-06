module  {
  llvm.func @foo(%arg0: f32) -> f32 {
    %0 = llvm.call @bar(%arg0) : (f32) -> f32
    llvm.return %0 : f32
  }
  llvm.func @bar(%arg0: f32) -> f32 {
    %0 = llvm.call @sqr(%arg0) : (f32) -> f32
    %1 = llvm.call @sqrtf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @sqr(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  : f32
    llvm.return %0 : f32
  }
  llvm.func @sqrtf(f32) -> f32
}
