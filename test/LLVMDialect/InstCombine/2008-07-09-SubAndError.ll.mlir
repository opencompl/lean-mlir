module  {
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.sub %1, %arg0  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }
}
