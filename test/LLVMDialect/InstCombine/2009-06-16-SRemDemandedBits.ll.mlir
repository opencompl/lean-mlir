module  {
  llvm.func @a(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
}
