module  {
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1656690544 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.xor %arg0, %2  : i32
    %4 = llvm.srem %1, %3  : i32
    %5 = llvm.shl %4, %0  : i32
    %6 = llvm.ashr %5, %0  : i32
    llvm.return %6 : i32
  }
}
