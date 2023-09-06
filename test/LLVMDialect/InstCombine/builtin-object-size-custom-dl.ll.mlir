module  {
  llvm.func @objsize1_custom_idx(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.call @malloc(%arg0) : (i64) -> !llvm.ptr<i8>
    %4 = llvm.getelementptr %3[%2] : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    %5 = llvm.call @llvm.objectsize.i64.p0i8(%4, %1, %0, %0) : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    llvm.return %5 : i64
  }
  llvm.func @objsize2_custom_idx() -> i32 {
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
  llvm.func @llvm.lifetime.start.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @llvm.lifetime.end.p0i8(i64, !llvm.ptr<i8>)
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @llvm.objectsize.i64.p0i8(!llvm.ptr<i8>, i1, i1, i1) -> i64
}
