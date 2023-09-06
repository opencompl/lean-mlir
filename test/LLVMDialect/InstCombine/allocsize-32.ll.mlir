module  {
  llvm.func @my_malloc(!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @test_malloc(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(5000000000 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(100 : i64) : i64
    %3 = llvm.mlir.null : !llvm.ptr<i8>
    %4 = llvm.call @my_malloc(%3, %2) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.store %4, %arg0 : !llvm.ptr<ptr<i8>>
    %5 = llvm.call @llvm.objectsize.i32.p0i8(%4, %1, %1, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    llvm.store %5, %arg1 : !llvm.ptr<i32>
    %6 = llvm.call @my_malloc(%3, %0) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.store %6, %arg0 : !llvm.ptr<ptr<i8>>
    %7 = llvm.call @llvm.objectsize.i32.p0i8(%6, %1, %1, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    llvm.store %7, %arg1 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @llvm.objectsize.i32.p0i8(!llvm.ptr<i8>, i1, i1, i1) -> i32
}
