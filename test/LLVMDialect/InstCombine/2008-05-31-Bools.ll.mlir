module  {
  llvm.func @foo1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @foo2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @foo3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
  llvm.func @foo4(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }
}
