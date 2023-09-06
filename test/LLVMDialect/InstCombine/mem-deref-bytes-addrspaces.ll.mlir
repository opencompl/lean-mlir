module  {
  llvm.func @memcmp(!llvm.ptr<i8, 1>, !llvm.ptr<i8, 1>, i64) -> i32
  llvm.func @memcmp_const_size_update_deref(%arg0: !llvm.ptr<i8, 1>, %arg1: !llvm.ptr<i8, 1>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8, 1>, !llvm.ptr<i8, 1>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_nonconst_size_nonnnull(%arg0: !llvm.ptr<i8, 1>, %arg1: !llvm.ptr<i8, 1>, %arg2: i64) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr<i8, 1>, !llvm.ptr<i8, 1>, i64) -> i32
    llvm.return %0 : i32
  }
}
