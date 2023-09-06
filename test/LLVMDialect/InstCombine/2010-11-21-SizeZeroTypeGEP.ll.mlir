module  {
  llvm.func @foo(%arg0: !llvm.ptr<struct<()>>, %arg1: i32) -> !llvm.ptr<struct<()>> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<struct<()>>, i32) -> !llvm.ptr<struct<()>>
    llvm.return %0 : !llvm.ptr<struct<()>>
  }
  llvm.func @bar(%arg0: i64, %arg1: !llvm.ptr<struct<(struct<()>, array<0 x struct<(array<0 x i8>)>>)>>) -> !llvm.ptr<i8> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg1[%arg0, %1, %arg0, %0, %arg0] : (!llvm.ptr<struct<(struct<()>, array<0 x struct<(array<0 x i8>)>>)>>, i64, i32, i64, i32, i64) -> !llvm.ptr<i8>
    llvm.return %2 : !llvm.ptr<i8>
  }
}
