module  {
  llvm.func @test0(%arg0: i39, %arg1: i39) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i39
    %1 = llvm.trunc %0 : i39 to i1
    llvm.return %1 : i1
  }
  llvm.func @test1(%arg0: i799, %arg1: i799) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i799
    %1 = llvm.trunc %0 : i799 to i1
    llvm.return %1 : i1
  }
  llvm.func @test0vec(%arg0: vector<2xi39>, %arg1: vector<2xi39>) -> vector<2xi1> {
    %0 = llvm.lshr %arg0, %arg1  : vector<2xi39>
    %1 = llvm.trunc %0 : vector<2xi39> to vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }
}
