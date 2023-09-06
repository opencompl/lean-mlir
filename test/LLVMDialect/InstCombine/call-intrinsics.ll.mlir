module  {
  llvm.mlir.global external @X(0 : i8) : i8
  llvm.mlir.global external @Y(12 : i8) : i8
  llvm.func @llvm.memmove.p0i8.p0i8.i32(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1)
  llvm.func @llvm.memcpy.p0i8.p0i8.i32(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1)
  llvm.func @llvm.memset.p0i8.i32(!llvm.ptr<i8>, i8, i32, i1)
  llvm.func @zero_byte_test() {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.addressof @X : !llvm.ptr<i8>
    %2 = llvm.mlir.addressof @Y : !llvm.ptr<i8>
    %3 = llvm.mlir.addressof @X : !llvm.ptr<i8>
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.addressof @Y : !llvm.ptr<i8>
    %7 = llvm.mlir.addressof @X : !llvm.ptr<i8>
    llvm.call @llvm.memmove.p0i8.p0i8.i32(%7, %6, %5, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%3, %2, %5, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.call @llvm.memset.p0i8.i32(%1, %0, %5, %4) : (!llvm.ptr<i8>, i8, i32, i1) -> ()
    llvm.return
  }
}
