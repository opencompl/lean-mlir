module  {
  llvm.mlir.global private constant @test.data(dense<[0, 1, 2, 3, 4, 5, 6, 7]> : tensor<8xi32>) : !llvm.array<8 x i32>
  llvm.func @test_load(%arg0: !llvm.ptr<i32, 1>, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.mlir.addressof @test.data : !llvm.ptr<array<8 x i32>>
    %4 = llvm.bitcast %3 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8, 2>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.alloca %5 x !llvm.array<8 x i32> : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = llvm.bitcast %6 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p2i8.i64(%7, %4, %2, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = llvm.getelementptr %6[%0, %arg1] : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = llvm.load %8 : !llvm.ptr<i32>
    %10 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    llvm.store %9, %10 : !llvm.ptr<i32, 1>
    llvm.return
  }
  llvm.func @test_load_bitcast_chain(%arg0: !llvm.ptr<i32, 1>, %arg1: i64) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(32 : i64) : i64
    %2 = llvm.mlir.addressof @test.data : !llvm.ptr<array<8 x i32>>
    %3 = llvm.bitcast %2 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8, 2>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.alloca %4 x !llvm.array<8 x i32> : (i32) -> !llvm.ptr<array<8 x i32>>
    %6 = llvm.bitcast %5 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p2i8.i64(%6, %3, %1, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %7 = llvm.bitcast %6 : !llvm.ptr<i8> to !llvm.ptr<i32>
    %8 = llvm.getelementptr %7[%arg1] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %9 = llvm.load %8 : !llvm.ptr<i32>
    %10 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    llvm.store %9, %10 : !llvm.ptr<i32, 1>
    llvm.return
  }
  llvm.func @test_call(%arg0: !llvm.ptr<i32, 1>, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.mlir.addressof @test.data : !llvm.ptr<array<8 x i32>>
    %4 = llvm.bitcast %3 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8, 2>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.alloca %5 x !llvm.array<8 x i32> : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = llvm.bitcast %6 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p2i8.i64(%7, %4, %2, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = llvm.getelementptr %6[%0, %arg1] : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = llvm.call @foo(%8) : (!llvm.ptr<i32>) -> i32
    %10 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    llvm.store %9, %10 : !llvm.ptr<i32, 1>
    llvm.return
  }
  llvm.func @test_call_no_null_opt(%arg0: !llvm.ptr<i32, 1>, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.mlir.addressof @test.data : !llvm.ptr<array<8 x i32>>
    %4 = llvm.bitcast %3 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8, 2>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.alloca %5 x !llvm.array<8 x i32> : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = llvm.bitcast %6 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p2i8.i64(%7, %4, %2, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = llvm.getelementptr %6[%0, %arg1] : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = llvm.call @foo(%8) : (!llvm.ptr<i32>) -> i32
    %10 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    llvm.store %9, %10 : !llvm.ptr<i32, 1>
    llvm.return
  }
  llvm.func @test_load_and_call(%arg0: !llvm.ptr<i32, 1>, %arg1: i64, %arg2: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.mlir.addressof @test.data : !llvm.ptr<array<8 x i32>>
    %4 = llvm.bitcast %3 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8, 2>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.alloca %5 x !llvm.array<8 x i32> : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = llvm.bitcast %6 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p2i8.i64(%7, %4, %2, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = llvm.getelementptr %6[%0, %arg1] : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = llvm.load %8 : !llvm.ptr<i32>
    %10 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    llvm.store %9, %10 : !llvm.ptr<i32, 1>
    %11 = llvm.call @foo(%8) : (!llvm.ptr<i32>) -> i32
    %12 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    llvm.store %11, %12 : !llvm.ptr<i32, 1>
    llvm.return
  }
  llvm.func @test_load_and_call_no_null_opt(%arg0: !llvm.ptr<i32, 1>, %arg1: i64, %arg2: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.mlir.addressof @test.data : !llvm.ptr<array<8 x i32>>
    %4 = llvm.bitcast %3 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8, 2>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.alloca %5 x !llvm.array<8 x i32> : (i32) -> !llvm.ptr<array<8 x i32>>
    %7 = llvm.bitcast %6 : !llvm.ptr<array<8 x i32>> to !llvm.ptr<i8>
    llvm.call @llvm.memcpy.p0i8.p2i8.i64(%7, %4, %2, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1) -> ()
    %8 = llvm.getelementptr %6[%0, %arg1] : (!llvm.ptr<array<8 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %9 = llvm.load %8 : !llvm.ptr<i32>
    %10 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    llvm.store %9, %10 : !llvm.ptr<i32, 1>
    %11 = llvm.call @foo(%8) : (!llvm.ptr<i32>) -> i32
    %12 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr<i32, 1>, i64) -> !llvm.ptr<i32, 1>
    llvm.store %11, %12 : !llvm.ptr<i32, 1>
    llvm.return
  }
  llvm.func @llvm.memcpy.p0i8.p2i8.i64(!llvm.ptr<i8>, !llvm.ptr<i8, 2>, i64, i1)
  llvm.func @foo(!llvm.ptr<i32>) -> i32
}
