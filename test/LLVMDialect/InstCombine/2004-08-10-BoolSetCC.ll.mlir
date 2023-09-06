module  {
  llvm.func @test(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ult" %arg0, %0 : i1
    llvm.return %1 : i1
  }
}
