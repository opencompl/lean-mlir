module  {
  llvm.func @test0(%arg0: i41, %arg1: i41, %arg2: i41) -> i41 {
    %0 = llvm.shl %arg0, %arg2  : i41
    %1 = llvm.shl %arg1, %arg2  : i41
    %2 = llvm.and %0, %1  : i41
    llvm.return %2 : i41
  }
  llvm.func @test1(%arg0: i57, %arg1: i57, %arg2: i57) -> i57 {
    %0 = llvm.lshr %arg0, %arg2  : i57
    %1 = llvm.lshr %arg1, %arg2  : i57
    %2 = llvm.or %0, %1  : i57
    llvm.return %2 : i57
  }
  llvm.func @test2(%arg0: i49, %arg1: i49, %arg2: i49) -> i49 {
    %0 = llvm.ashr %arg0, %arg2  : i49
    %1 = llvm.ashr %arg1, %arg2  : i49
    %2 = llvm.xor %0, %1  : i49
    llvm.return %2 : i49
  }
}
