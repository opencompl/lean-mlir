module  {
  llvm.func @test1(%arg0: i33, %arg1: i33) -> i1 {
    %0 = llvm.mlir.constant(65280 : i33) : i33
    %1 = llvm.and %arg0, %0  : i33
    %2 = llvm.and %arg1, %0  : i33
    %3 = llvm.icmp "ne" %1, %2 : i33
    llvm.return %3 : i1
  }
  llvm.func @test2(%arg0: i999, %arg1: i999) -> i1 {
    %0 = llvm.mlir.constant(65280 : i999) : i999
    %1 = llvm.and %arg0, %0  : i999
    %2 = llvm.and %arg1, %0  : i999
    %3 = llvm.icmp "ne" %1, %2 : i999
    llvm.return %3 : i1
  }
}
