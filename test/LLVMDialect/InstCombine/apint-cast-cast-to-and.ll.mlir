module  {
  llvm.func @test1(%arg0: i61) -> i61 {
    %0 = llvm.trunc %arg0 : i61 to i41
    %1 = llvm.zext %0 : i41 to i61
    llvm.return %1 : i61
  }
}
