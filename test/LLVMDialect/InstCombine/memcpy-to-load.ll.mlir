module  {
  llvm.func @llvm.memcpy.p0i8.p0i8.i32(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1)
  llvm.func @copy_1_byte(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @copy_2_bytes(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(2 : i32) : i32
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @copy_3_bytes(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(3 : i32) : i32
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @copy_4_bytes(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(4 : i32) : i32
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @copy_5_bytes(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(5 : i32) : i32
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @copy_8_bytes(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(8 : i32) : i32
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
  llvm.func @copy_16_bytes(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(16 : i32) : i32
    llvm.call @llvm.memcpy.p0i8.p0i8.i32(%arg0, %arg1, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    llvm.return
  }
}
