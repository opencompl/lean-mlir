module  {
  llvm.func @test1(%arg0: i47, %arg1: i47) -> i47 {
    %0 = llvm.mlir.constant(70368744177661 : i47) : i47
    %1 = llvm.mlir.constant(-70368744177664 : i47) : i47
    %2 = llvm.and %arg0, %1  : i47
    %3 = llvm.and %arg1, %0  : i47
    %4 = llvm.xor %2, %3  : i47
    llvm.return %4 : i47
  }
  llvm.func @test2(%arg0: i15) -> i15 {
    %0 = llvm.mlir.constant(0 : i15) : i15
    %1 = llvm.xor %arg0, %0  : i15
    llvm.return %1 : i15
  }
  llvm.func @test3(%arg0: i23) -> i23 {
    %0 = llvm.xor %arg0, %arg0  : i23
    llvm.return %0 : i23
  }
  llvm.func @test4(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(-1 : i37) : i37
    %1 = llvm.xor %0, %arg0  : i37
    %2 = llvm.xor %arg0, %1  : i37
    llvm.return %2 : i37
  }
  llvm.func @test5(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(23 : i7) : i7
    %1 = llvm.or %arg0, %0  : i7
    %2 = llvm.xor %1, %0  : i7
    llvm.return %2 : i7
  }
  llvm.func @test6(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(23 : i7) : i7
    %1 = llvm.xor %arg0, %0  : i7
    %2 = llvm.xor %1, %0  : i7
    llvm.return %2 : i7
  }
  llvm.func @test7(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(703687463 : i47) : i47
    %1 = llvm.mlir.constant(70368744177663 : i47) : i47
    %2 = llvm.or %arg0, %1  : i47
    %3 = llvm.xor %2, %0  : i47
    llvm.return %3 : i47
  }
}
