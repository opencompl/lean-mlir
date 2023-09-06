module  {
  llvm.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg1, %arg0  : i32
    %1 = llvm.mul %0, %arg1  : i32
    %2 = llvm.mul %arg1, %arg1  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @bar(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.and %arg1, %arg0  : i64
    %3 = llvm.xor %2, %1  : i64
    %4 = llvm.and %arg1, %3  : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    llvm.return %5 : i1
  }
}
