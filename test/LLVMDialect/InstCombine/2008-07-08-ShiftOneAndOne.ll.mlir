module  {
  llvm.func @PR2330(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %1, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }
}
