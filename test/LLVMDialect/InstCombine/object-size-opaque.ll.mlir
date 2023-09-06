module  {
  llvm.func @foo(%arg0: !llvm.ptr<struct<"opaque", opaque>>, %arg1: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.bitcast %arg0 : !llvm.ptr<struct<"opaque", opaque>> to !llvm.ptr<i8>
    %2 = llvm.call @llvm.objectsize.i64.p0i8(%1, %0, %0, %0) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %2, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @llvm.objectsize.i64.p0i8(!llvm.ptr<i8>, i1, i1, i1) -> i64
}
