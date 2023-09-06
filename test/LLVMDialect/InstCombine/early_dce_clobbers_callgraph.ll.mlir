module  {
  llvm.func @foo() {
    %0 = llvm.call @bar() : () -> i32
    llvm.return
  }
  llvm.func internal @bar() -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    llvm.return %0 : i32
  }
}
