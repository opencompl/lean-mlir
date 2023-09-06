module  {
  llvm.func @src(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.shl %0, %1  : i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.shl %4, %1  : i32
    llvm.return %5 : i32
  }
}
