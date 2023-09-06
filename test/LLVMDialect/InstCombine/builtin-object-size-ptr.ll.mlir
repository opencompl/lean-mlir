module  {
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(28 : i64) : i64
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.alloca %5 x !llvm.struct<"struct.V", (array<10 x i8>, i32, array<10 x i8>)> : (i32) -> !llvm.ptr<struct<"struct.V", (array<10 x i8>, i32, array<10 x i8>)>>
    %7 = llvm.bitcast %6 : !llvm.ptr<struct<"struct.V", (array<10 x i8>, i32, array<10 x i8>)>> to !llvm.ptr<i8>
    llvm.call @llvm.lifetime.start.p0i8(%4, %7) : (i64, !llvm.ptr<i8>) -> ()
    %8 = llvm.getelementptr %6[%3, %3] : (!llvm.ptr<struct<"struct.V", (array<10 x i8>, i32, array<10 x i8>)>>, i32, i32) -> !llvm.ptr<array<10 x i8>>
    %9 = llvm.getelementptr %8[%2, %1] : (!llvm.ptr<array<10 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %10 = llvm.call @llvm.objectsize.i64.p0i8(%9, %0, %0, %0) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    %11 = llvm.trunc %10 : i64 to i32
    llvm.call @llvm.lifetime.end.p0i8(%4, %7) : (i64, !llvm.ptr<i8>) -> ()
    llvm.return %11 : i32
  }
  llvm.func @PR43723() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(9 : i8) : i8
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x !llvm.array<10 x i8> : (i32) -> !llvm.ptr<array<10 x i8>>
    %5 = llvm.bitcast %4 : !llvm.ptr<array<10 x i8>> to !llvm.ptr<i8>
    llvm.call @llvm.memset.p0i8.i64(%5, %2, %1, %0) : (!llvm.ptr<i8>, i8, i64, i1) -> ()
    %6 = llvm.call @llvm.invariant.start.p0i8(%1, %5) : (i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
    llvm.call @llvm.invariant.end.p0i8(%6, %1, %5) : (!llvm.ptr<struct<()>>, i64, !llvm.ptr<i8>) -> ()
    llvm.return
  }
  llvm.func @unknown_use_of_invariant_start(%arg0: !llvm.ptr<ptr<struct<()>>>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(9 : i8) : i8
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x !llvm.array<10 x i8> : (i32) -> !llvm.ptr<array<10 x i8>>
    %5 = llvm.bitcast %4 : !llvm.ptr<array<10 x i8>> to !llvm.ptr<i8>
    llvm.call @llvm.memset.p0i8.i64(%5, %2, %1, %0) : (!llvm.ptr<i8>, i8, i64, i1) -> ()
    %6 = llvm.call @llvm.invariant.start.p0i8(%1, %5) : (i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
    llvm.call @llvm.invariant.end.p0i8(%6, %1, %5) : (!llvm.ptr<struct<()>>, i64, !llvm.ptr<i8>) -> ()
    llvm.store %6, %arg0 : !llvm.ptr<ptr<struct<()>>>
    llvm.return
  }
  llvm.func @minimal_invariant_start_use(%arg0: i8) -> !llvm.ptr<struct<()>> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.alloca %1 x i8 : (i32) -> !llvm.ptr<i8>
    %3 = llvm.call @llvm.invariant.start.p0i8(%0, %2) : (i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
    llvm.return %3 : !llvm.ptr<struct<()>>
  }
  llvm.func @llvm.lifetime.start.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @llvm.lifetime.end.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @llvm.memset.p0i8.i64(!llvm.ptr<i8>, i8, i64, i1)
  llvm.func @llvm.invariant.start.p0i8(i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
  llvm.func @llvm.invariant.end.p0i8(!llvm.ptr<struct<()>>, i64, !llvm.ptr<i8>)
  llvm.func @llvm.objectsize.i64.p0i8(!llvm.ptr<i8>, i1, i1, i1) -> i64
}
