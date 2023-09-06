module  {
  llvm.func @memcmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
  llvm.func @memcpy(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @memmove(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @memset(!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
  llvm.func @memchr(!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
  llvm.func @llvm.memcpy.p0i8.p0i8.i64(!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1)
  llvm.func @llvm.memmove.p0i8.p0i8.i64(!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1)
  llvm.func @llvm.memset.p0i8.i64(!llvm.ptr<i8>, i8, i64, i1)
  llvm.func @memcmp_const_size_set_deref(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref2(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref3(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref4(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref5(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref6(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_update_deref7(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_const_size_no_update_deref(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %1 : i32
  }
  llvm.func @memcmp_nonconst_size(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i64) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    llvm.return %0 : i32
  }
  llvm.func @memcpy_const_size_set_deref(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memcpy(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @memmove_const_size_set_deref(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memmove(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @memset_const_size_set_deref(%arg0: !llvm.ptr<i8>, %arg1: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memset(%arg0, %arg1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @memchr_const_size_set_deref(%arg0: !llvm.ptr<i8>, %arg1: i32) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    llvm.return %1 : !llvm.ptr<i8>
  }
  llvm.func @llvm_memcpy_const_size_set_deref(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(16 : i64) : i64
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return %arg0 : !llvm.ptr<i8>
  }
  llvm.func @llvm_memmove_const_size_set_deref(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(16 : i64) : i64
    llvm.call @llvm.memmove.p0i8.p0i8.i64(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return %arg0 : !llvm.ptr<i8>
  }
  llvm.func @llvm_memset_const_size_set_deref(%arg0: !llvm.ptr<i8>, %arg1: i8) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(16 : i64) : i64
    llvm.call @llvm.memset.p0i8.i64(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, i8, i64, i1) -> ()
    llvm.return %arg0 : !llvm.ptr<i8>
  }
}
