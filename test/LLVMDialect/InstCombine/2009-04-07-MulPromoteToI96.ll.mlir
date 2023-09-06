module  {
  llvm.func @test(%arg0: i96, %arg1: i96) -> i96 {
    %0 = llvm.trunc %arg0 : i96 to i64
    %1 = llvm.trunc %arg1 : i96 to i64
    %2 = llvm.mul %0, %1  : i64
    %3 = llvm.zext %2 : i64 to i96
    llvm.return %3 : i96
  }
}
