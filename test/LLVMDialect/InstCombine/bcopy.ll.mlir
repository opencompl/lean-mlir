module  {
  llvm.func @bcopy(!llvm.ptr<i8>, !llvm.ptr<i8>, i32)
  llvm.func @bcopy_memmove(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    llvm.call @bcopy(%arg0, %arg1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> ()
    llvm.return
  }
  llvm.func @bcopy_memmove2(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32) {
    llvm.call @bcopy(%arg0, %arg1, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> ()
    llvm.return
  }
}
