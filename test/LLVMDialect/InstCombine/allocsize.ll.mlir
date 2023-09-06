module  {
  llvm.func @my_malloc(!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
  llvm.func @my_calloc(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
  llvm.func @test_malloc(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.null : !llvm.ptr<i8>
    %3 = llvm.call @my_malloc(%2, %1) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.store %3, %arg0 : !llvm.ptr<ptr<i8>>
    %4 = llvm.call @llvm.objectsize.i64.p0i8(%3, %0, %0, %0) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %4, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @test_calloc(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.mlir.null : !llvm.ptr<i8>
    %4 = llvm.call @my_calloc(%3, %3, %2, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.store %4, %arg0 : !llvm.ptr<ptr<i8>>
    %5 = llvm.call @llvm.objectsize.i64.p0i8(%4, %0, %0, %0) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %5, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @test_malloc_fails(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>, %arg2: i32) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.null : !llvm.ptr<i8>
    %2 = llvm.call @my_malloc(%1, %arg2) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.store %2, %arg0 : !llvm.ptr<ptr<i8>>
    %3 = llvm.call @llvm.objectsize.i64.p0i8(%2, %0, %0, %0) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %3, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @test_calloc_fails(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>, %arg2: i32) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.null : !llvm.ptr<i8>
    %4 = llvm.call @my_calloc(%3, %3, %arg2, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.store %4, %arg0 : !llvm.ptr<ptr<i8>>
    %5 = llvm.call @llvm.objectsize.i64.p0i8(%4, %1, %1, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %5, %arg1 : !llvm.ptr<i64>
    %6 = llvm.call @my_calloc(%3, %3, %0, %arg2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.store %6, %arg0 : !llvm.ptr<ptr<i8>>
    %7 = llvm.call @llvm.objectsize.i64.p0i8(%6, %1, %1, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %7, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @my_malloc_outofline(!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
  llvm.func @my_calloc_outofline(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
  llvm.func @test_outofline(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(100 : i32) : i32
    %3 = llvm.mlir.null : !llvm.ptr<i8>
    %4 = llvm.call @my_malloc_outofline(%3, %2) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.store %4, %arg0 : !llvm.ptr<ptr<i8>>
    %5 = llvm.call @llvm.objectsize.i64.p0i8(%4, %1, %1, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %5, %arg1 : !llvm.ptr<i64>
    %6 = llvm.call @my_calloc_outofline(%3, %3, %2, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.store %6, %arg0 : !llvm.ptr<ptr<i8>>
    %7 = llvm.call @llvm.objectsize.i64.p0i8(%6, %1, %1, %1) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %7, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @my_malloc_i64(!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
  llvm.func @my_tiny_calloc(!llvm.ptr<i8>, !llvm.ptr<i8>, i8, i8) -> !llvm.ptr<i8>
  llvm.func @my_varied_calloc(!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i8) -> !llvm.ptr<i8>
  llvm.func @test_overflow(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(1000 : i32) : i32
    %2 = llvm.mlir.constant(8589934592 : i64) : i64
    %3 = llvm.mlir.constant(4 : i8) : i8
    %4 = llvm.mlir.constant(127 : i8) : i8
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.mlir.constant(-2147483647 : i32) : i32
    %8 = llvm.mlir.null : !llvm.ptr<i8>
    %9 = llvm.bitcast %arg1 : !llvm.ptr<i32> to !llvm.ptr<i64>
    %10 = llvm.call @my_calloc(%8, %8, %7, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    llvm.store %10, %arg0 : !llvm.ptr<ptr<i8>>
    %11 = llvm.call @llvm.objectsize.i32.p0i8(%10, %5, %5, %5) : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    llvm.store %11, %arg1 : !llvm.ptr<i32>
    %12 = llvm.call @my_tiny_calloc(%8, %8, %4, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i8, i8) -> !llvm.ptr<i8>
    llvm.store %12, %arg0 : !llvm.ptr<ptr<i8>>
    %13 = llvm.call @llvm.objectsize.i32.p0i8(%12, %5, %5, %5) : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    llvm.store %13, %arg1 : !llvm.ptr<i32>
    %14 = llvm.call @my_malloc_i64(%8, %2) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    llvm.store %14, %arg0 : !llvm.ptr<ptr<i8>>
    %15 = llvm.call @llvm.objectsize.i32.p0i8(%14, %5, %5, %5) : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    llvm.store %15, %arg1 : !llvm.ptr<i32>
    %16 = llvm.call @llvm.objectsize.i64.p0i8(%14, %5, %5, %5) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %16, %9 : !llvm.ptr<i64>
    %17 = llvm.call @my_varied_calloc(%8, %8, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i8) -> !llvm.ptr<i8>
    llvm.store %17, %arg0 : !llvm.ptr<ptr<i8>>
    %18 = llvm.call @llvm.objectsize.i32.p0i8(%17, %5, %5, %5) : (!llvm.ptr<i8>, i1, i1, i1) -> i32
    llvm.store %18, %arg1 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @test_nobuiltin(%arg0: !llvm.ptr<ptr<i8>>, %arg1: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.null : !llvm.ptr<i8>
    %3 = llvm.call @my_malloc(%2, %1) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    llvm.store %3, %arg0 : !llvm.ptr<ptr<i8>>
    %4 = llvm.call @llvm.objectsize.i64.p0i8(%3, %0, %0, %0) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.store %4, %arg1 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @llvm.objectsize.i32.p0i8(!llvm.ptr<i8>, i1, i1, i1) -> i32
  llvm.func @llvm.objectsize.i64.p0i8(!llvm.ptr<i8>, i1, i1, i1) -> i64
}
