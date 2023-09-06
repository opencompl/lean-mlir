module  {
  llvm.func @use(%arg0: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr<i8>) -> i64
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }
  llvm.func @strlen(!llvm.ptr<i8>) -> i64
}
