module  {
  llvm.func @fold(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.urem %1, %0  : i32
    llvm.return %2 : i32
  }
}
