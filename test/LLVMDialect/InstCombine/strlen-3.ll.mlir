module  {
  llvm.func @strlen(%arg0: !llvm.ptr<i32>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr<i32>) -> i64
    llvm.return %0 : i64
  }
}
