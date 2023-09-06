module  {
  llvm.func @main() {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @acosf(%0) : (f32) -> f32
    llvm.return
  }
  llvm.func @acosf(f32) -> f32
}
