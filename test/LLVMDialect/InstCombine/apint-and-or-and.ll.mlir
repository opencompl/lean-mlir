module  {
  llvm.func @test1(%arg0: i17, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(8 : i17) : i17
    %1 = llvm.mlir.constant(7 : i17) : i17
    %2 = llvm.and %arg0, %1  : i17
    %3 = llvm.and %arg1, %0  : i17
    %4 = llvm.or %2, %3  : i17
    %5 = llvm.and %4, %1  : i17
    llvm.return %5 : i17
  }
  llvm.func @test3(%arg0: i49, %arg1: i49) -> i49 {
    %0 = llvm.mlir.constant(1 : i49) : i49
    %1 = llvm.shl %arg1, %0  : i49
    %2 = llvm.or %arg0, %1  : i49
    %3 = llvm.and %2, %0  : i49
    llvm.return %3 : i49
  }
  llvm.func @test4(%arg0: i67, %arg1: i67) -> i67 {
    %0 = llvm.mlir.constant(2 : i67) : i67
    %1 = llvm.mlir.constant(66 : i67) : i67
    %2 = llvm.lshr %arg1, %1  : i67
    %3 = llvm.or %arg0, %2  : i67
    %4 = llvm.and %3, %0  : i67
    llvm.return %4 : i67
  }
  llvm.func @or_test1(%arg0: i231, %arg1: i231) -> i231 {
    %0 = llvm.mlir.constant(1 : i231) : i231
    %1 = llvm.and %arg0, %0  : i231
    %2 = llvm.or %1, %0  : i231
    llvm.return %2 : i231
  }
  llvm.func @or_test2(%arg0: i7, %arg1: i7) -> i7 {
    %0 = llvm.mlir.constant(-64 : i7) : i7
    %1 = llvm.mlir.constant(6 : i7) : i7
    %2 = llvm.shl %arg0, %1  : i7
    %3 = llvm.or %2, %0  : i7
    llvm.return %3 : i7
  }
}
