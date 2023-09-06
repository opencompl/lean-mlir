module  {
  llvm.func @f(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<i64>) -> i64 {
    %0 = llvm.load %arg0 : !llvm.ptr<i64>
    llvm.store %0, %arg1 : !llvm.ptr<i64>
    %1 = llvm.load %arg1 : !llvm.ptr<i64>
    llvm.return %1 : i64
  }
}
