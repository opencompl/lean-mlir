module  {
  llvm.func @llvm.annotation.i32(i32, !llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
  llvm.func @annotated(%arg0: !llvm.ptr<i32>) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.undef : !llvm.ptr<i8>
    %2 = llvm.load %arg0 : !llvm.ptr<i32>
    %3 = llvm.call @llvm.annotation.i32(%2, %1, %1, %0) : (i32, !llvm.ptr<i8>, !llvm.ptr<i8>, i32) -> i32
    %4 = llvm.load %arg0 : !llvm.ptr<i32>
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }
}
