module  {
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.or %1, %0  : i32
    %3 = llvm.and %arg0, %2  : i32
    llvm.return %3 : i32
  }
}
