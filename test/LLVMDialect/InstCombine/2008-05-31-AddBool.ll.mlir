module  {
  llvm.func @test(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
}
