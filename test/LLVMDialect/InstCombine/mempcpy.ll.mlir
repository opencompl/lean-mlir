module  {
  llvm.func @memcpy_nonconst_n(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) -> !llvm.ptr<i8> {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @memcpy_nonconst_n_copy_attrs(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) -> !llvm.ptr<i8> {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @memcpy_nonconst_n_unused_retval(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return
  }
  llvm.func @memcpy_small_const_n(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.call @mempcpy(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @memcpy_big_const_n(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = llvm.call @mempcpy(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @PR48810() -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.undef : i64
    %2 = llvm.mlir.null : !llvm.ptr<i8>
    %3 = llvm.mlir.undef : !llvm.ptr<i8>
    %4 = llvm.call @mempcpy(%3, %2, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %0 : i32
  }
  llvm.func @memcpy_no_simplify1(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) -> !llvm.ptr<i8> {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %0 : !llvm.ptr<i8>
  }
  llvm.func @mempcpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
}
