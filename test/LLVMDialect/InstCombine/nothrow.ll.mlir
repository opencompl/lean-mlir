module  {
  llvm.func @t1(i32) -> f64
  llvm.func @t2() {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.call @t1(%0) : (i32) -> f64
    llvm.return
  }
}
