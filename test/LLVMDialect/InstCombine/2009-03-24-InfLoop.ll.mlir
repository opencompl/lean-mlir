module  {
  llvm.func @test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3968 : i32) : i32
    %3 = llvm.lshr %2, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    llvm.return %5 : i1
  }
}
