module  {
  llvm.func @test1(%arg0: i57, %arg1: i57, %arg2: i57) -> i57 {
    %0 = llvm.and %arg2, %arg0  : i57
    %1 = llvm.and %arg2, %arg1  : i57
    %2 = llvm.xor %0, %1  : i57
    llvm.return %2 : i57
  }
  llvm.func @test2(%arg0: i23, %arg1: i23, %arg2: i23) -> i23 {
    %0 = llvm.and %arg1, %arg0  : i23
    %1 = llvm.or %arg1, %arg0  : i23
    %2 = llvm.xor %0, %1  : i23
    llvm.return %2 : i23
  }
}
