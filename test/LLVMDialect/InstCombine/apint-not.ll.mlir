module  {
  llvm.func @test1(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(-1 : i33) : i33
    %1 = llvm.xor %arg0, %0  : i33
    %2 = llvm.xor %1, %0  : i33
    llvm.return %2 : i33
  }
  llvm.func @test2(%arg0: i52, %arg1: i52) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ule" %arg0, %arg1 : i52
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
}
