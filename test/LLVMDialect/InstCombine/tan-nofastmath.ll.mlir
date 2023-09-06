module  {
  llvm.func @mytan(%arg0: f32) -> f32 {
    %0 = llvm.call @atanf(%arg0) : (f32) -> f32
    %1 = llvm.call @tanf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @tanf(f32) -> f32
  llvm.func @atanf(f32) -> f32
}
