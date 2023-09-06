module  {
  llvm.func @llvm.memcpy.p0i8.p0i8.i64(!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1)
  llvm.func @test1(%arg0: !llvm.ptr<struct<"struct.test1", (f32)>>, %arg1: !llvm.ptr<struct<"struct.test1", (f32)>>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.bitcast %arg0 : !llvm.ptr<struct<"struct.test1", (f32)>> to !llvm.ptr<i8>
    %3 = llvm.bitcast %arg1 : !llvm.ptr<struct<"struct.test1", (f32)>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%2, %3, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    llvm.return
  }
  llvm.func @test2() -> !llvm.ptr<ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.mlir.undef : !llvm.ptr<i8>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.alloca %4 x !llvm.struct<"struct.test2", (ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>)> : (i32) -> !llvm.ptr<struct<"struct.test2", (ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>)>>
    %6 = llvm.bitcast %5 : !llvm.ptr<struct<"struct.test2", (ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>)>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p0i8.i64(%6, %3, %2, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    %7 = llvm.getelementptr %5[%0, %0] : (!llvm.ptr<struct<"struct.test2", (ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>)>>, i32, i32) -> !llvm.ptr<ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>>
    %8 = llvm.load %7 : !llvm.ptr<ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>>
    llvm.return %7 : !llvm.ptr<ptr<ptr<func<i32 (ptr<i8>, ptr<i32>, ptr<f64>)>>>>
  }
}
