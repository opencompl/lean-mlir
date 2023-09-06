module  {
  llvm.mlir.global external constant @ia16a(dense<[24930, 25444, 25958, 26472]> : tensor<4xi16>) : !llvm.array<4 x i16>
  llvm.mlir.global external constant @ia16b(dense<[24930, 25444, 25958, 26472, 26992]> : tensor<5xi16>) : !llvm.array<5 x i16>
  llvm.mlir.global external constant @ia16c(dense<[24930, 25444, 25958, 26472, 26993, 29042]> : tensor<6xi16>) : !llvm.array<6 x i16>
  llvm.func @memcmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
  llvm.func @fold_memcmp_mismatch_too_big(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(12 : i64) : i64
    %2 = llvm.mlir.addressof @ia16c : !llvm.ptr<array<6 x i16>>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.addressof @ia16b : !llvm.ptr<array<5 x i16>>
    %5 = llvm.getelementptr %4[%3, %3] : (!llvm.ptr<array<5 x i16>>, i64, i64) -> !llvm.ptr<i16>
    %6 = llvm.bitcast %5 : !llvm.ptr<i16> to !llvm.ptr<i8>
    %7 = llvm.getelementptr %2[%3, %3] : (!llvm.ptr<array<6 x i16>>, i64, i64) -> !llvm.ptr<i16>
    %8 = llvm.bitcast %7 : !llvm.ptr<i16> to !llvm.ptr<i8>
    %9 = llvm.call @memcmp(%6, %8, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %10 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %9, %10 : !llvm.ptr<i32>
    %11 = llvm.call @memcmp(%8, %6, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %12 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %11, %12 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_memcmp_match_too_big(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.addressof @ia16b : !llvm.ptr<array<5 x i16>>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.addressof @ia16a : !llvm.ptr<array<4 x i16>>
    %6 = llvm.getelementptr %5[%4, %4] : (!llvm.ptr<array<4 x i16>>, i64, i64) -> !llvm.ptr<i16>
    %7 = llvm.bitcast %6 : !llvm.ptr<i16> to !llvm.ptr<i8>
    %8 = llvm.getelementptr %3[%4, %4] : (!llvm.ptr<array<5 x i16>>, i64, i64) -> !llvm.ptr<i16>
    %9 = llvm.bitcast %8 : !llvm.ptr<i16> to !llvm.ptr<i8>
    %10 = llvm.call @memcmp(%7, %9, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %11 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %10, %11 : !llvm.ptr<i32>
    %12 = llvm.call @memcmp(%7, %9, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %13 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %12, %13 : !llvm.ptr<i32>
    llvm.return
  }
}
