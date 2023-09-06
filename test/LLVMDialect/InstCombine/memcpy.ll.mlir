module  {
  llvm.mlir.global external constant @UnknownConstant() : i128
  llvm.func @llvm.memcpy.p0i8.p0i8.i32(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1)
  llvm.func @llvm.memcpy.p0i8.p0i8.i64(!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1)
  llvm.func @test1(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(100 : i32) : i32
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%arg0, %arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(100 : i32) : i32
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%arg0, %arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @test3(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(17179869184 : i64) : i64
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return
  }
  llvm.func @memcpy_to_constant(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.addressof @UnknownConstant : !llvm.ptr<i128>
    %3 = llvm.bitcast %2 : !llvm.ptr<i128> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%3, %arg0, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
}
