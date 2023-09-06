module  {
  llvm.func @bar(%arg0: !llvm.ptr<i8>) -> i8 {
    %0 = llvm.load %arg0 : !llvm.ptr<i8>
    llvm.return %0 : i8
  }
  llvm.func @foo(%arg0: !llvm.ptr<i8>) -> i8 {
    %0 = llvm.call @bar(%arg0) : (!llvm.ptr<i8>) -> i8
    llvm.return %0 : i8
  }
}
