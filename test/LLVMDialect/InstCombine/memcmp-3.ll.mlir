module  {
  llvm.mlir.global external constant @ia16a(dense<[24930, 25444, 25958, 26472]> : tensor<4xi16>) : !llvm.array<4 x i16>
  llvm.mlir.global external constant @i8a("abcdefgg")
  llvm.func @memcmp(!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
  llvm.func @fold_memcmp_ia16a_i8a(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.mlir.constant(5 : i64) : i64
    %4 = llvm.mlir.constant(4 : i64) : i64
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(1 : i64) : i64
    %8 = llvm.mlir.addressof @i8a : !llvm.ptr<array<8 x i8>>
    %9 = llvm.mlir.constant(0 : i64) : i64
    %10 = llvm.mlir.addressof @ia16a : !llvm.ptr<array<4 x i16>>
    %11 = llvm.getelementptr %10[%9, %9] : (!llvm.ptr<array<4 x i16>>, i64, i64) -> !llvm.ptr<i16>
    %12 = llvm.bitcast %11 : !llvm.ptr<i16> to !llvm.ptr<i8>
    %13 = llvm.getelementptr %8[%9, %9] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %14 = llvm.call @memcmp(%12, %13, %9) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %15 = llvm.getelementptr %arg0[%9] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %14, %15 : !llvm.ptr<i32>
    %16 = llvm.call @memcmp(%12, %13, %7) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %17 = llvm.getelementptr %arg0[%7] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %16, %17 : !llvm.ptr<i32>
    %18 = llvm.call @memcmp(%12, %13, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %19 = llvm.getelementptr %arg0[%6] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %18, %19 : !llvm.ptr<i32>
    %20 = llvm.call @memcmp(%12, %13, %5) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = llvm.getelementptr %arg0[%5] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %20, %21 : !llvm.ptr<i32>
    %22 = llvm.call @memcmp(%12, %13, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %23 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %22, %23 : !llvm.ptr<i32>
    %24 = llvm.call @memcmp(%12, %13, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %25 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %24, %25 : !llvm.ptr<i32>
    %26 = llvm.call @memcmp(%12, %13, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %27 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %26, %27 : !llvm.ptr<i32>
    %28 = llvm.call @memcmp(%12, %13, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %29 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %28, %29 : !llvm.ptr<i32>
    %30 = llvm.call @memcmp(%12, %13, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %31 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %30, %31 : !llvm.ptr<i32>
    llvm.return
  }
  llvm.func @fold_memcmp_ia16a_p1_i8a_p1(%arg0: !llvm.ptr<i32>) {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(2 : i64) : i64
    %5 = llvm.mlir.addressof @i8a : !llvm.ptr<array<8 x i8>>
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.addressof @ia16a : !llvm.ptr<array<4 x i16>>
    %9 = llvm.getelementptr %8[%7, %6] : (!llvm.ptr<array<4 x i16>>, i64, i64) -> !llvm.ptr<i16>
    %10 = llvm.bitcast %9 : !llvm.ptr<i16> to !llvm.ptr<i8>
    %11 = llvm.getelementptr %5[%7, %6] : (!llvm.ptr<array<8 x i8>>, i64, i64) -> !llvm.ptr<i8>
    %12 = llvm.call @memcmp(%10, %11, %7) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %13 = llvm.getelementptr %arg0[%7] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %12, %13 : !llvm.ptr<i32>
    %14 = llvm.call @memcmp(%10, %11, %6) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %15 = llvm.getelementptr %arg0[%6] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %14, %15 : !llvm.ptr<i32>
    %16 = llvm.call @memcmp(%10, %11, %4) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %17 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %16, %17 : !llvm.ptr<i32>
    %18 = llvm.call @memcmp(%10, %11, %3) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %19 = llvm.getelementptr %arg0[%3] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %18, %19 : !llvm.ptr<i32>
    %20 = llvm.call @memcmp(%10, %11, %2) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %21 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %20, %21 : !llvm.ptr<i32>
    %22 = llvm.call @memcmp(%10, %11, %1) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %23 = llvm.getelementptr %arg0[%1] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %22, %23 : !llvm.ptr<i32>
    %24 = llvm.call @memcmp(%10, %11, %0) : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> i32
    %25 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    llvm.store %24, %25 : !llvm.ptr<i32>
    llvm.return
  }
}
