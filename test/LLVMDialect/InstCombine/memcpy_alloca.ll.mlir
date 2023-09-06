module  {
  llvm.func @test(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x !llvm.array<7 x i8> : (i32) -> !llvm.ptr<array<7 x i8>>
    %5 = llvm.getelementptr %4[%2, %2] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%arg0, %5, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.alloca %4 x !llvm.array<7 x i8> : (i32) -> !llvm.ptr<array<7 x i8>>
    %6 = llvm.getelementptr %5[%3, %3] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.store %2, %6 : !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%arg0, %6, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return
  }
  llvm.func @test3(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x !llvm.array<7 x i8> : (i32) -> !llvm.ptr<array<7 x i8>>
    %5 = llvm.getelementptr %4[%2, %2] : (!llvm.ptr<array<7 x i8>>, i64, i64) -> !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%arg0, %5, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return
  }
  llvm.func @test4(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x !llvm.array<7 x i8> : (i32) -> !llvm.ptr<array<7 x i8>>
    %4 = llvm.bitcast %3 : !llvm.ptr<array<7 x i8>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%arg0, %4, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return
  }
  llvm.func @test5(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.alloca %2 x !llvm.array<7 x i8> : (i32) -> !llvm.ptr<array<7 x i8>>
    %4 = llvm.bitcast %3 : !llvm.ptr<array<7 x i8>> to !llvm.ptr<i32>
    %5 = llvm.getelementptr %4[%2] : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %6 = llvm.bitcast %5 : !llvm.ptr<i32> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%arg0, %6, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return
  }
  llvm.func @test6(%arg0: !llvm.ptr<i8>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(42 : i16) : i16
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.alloca %3 x !llvm.array<7 x i8> : (i32) -> !llvm.ptr<array<7 x i8>>
    %5 = llvm.bitcast %4 : !llvm.ptr<array<7 x i8>> to !llvm.ptr<i16>
    %6 = llvm.getelementptr %5[%3] : (!llvm.ptr<i16>, i32) -> !llvm.ptr<i16>
    llvm.store %2, %6 : !llvm.ptr<i16>
    %7 = llvm.bitcast %6 : !llvm.ptr<i16> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%arg0, %7, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return
  }
  llvm.func @llvm.memcpy.p0i8.p0i8.i64(!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1)
}
