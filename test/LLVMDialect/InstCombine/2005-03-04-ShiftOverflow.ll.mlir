module  {
  llvm.func @test(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.lshr %arg0, %1  : i64
    %3 = llvm.icmp "ugt" %2, %0 : i64
    llvm.return %3 : i1
  }
}
