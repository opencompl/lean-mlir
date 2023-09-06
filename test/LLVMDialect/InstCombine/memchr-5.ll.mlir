module  {
  llvm.mlir.global external constant @a(dense<[1633837924, 1701209960, 1768581996, 1835954032]> : tensor<4xi32>) : !llvm.array<4 x i32>
  llvm.func @memchr(!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
  llvm.func @fold_memchr_a(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(113 : i32) : i32
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.mlir.constant(112 : i32) : i32
    %4 = llvm.mlir.constant(6 : i64) : i64
    %5 = llvm.mlir.constant(111 : i32) : i32
    %6 = llvm.mlir.constant(4 : i64) : i64
    %7 = llvm.mlir.constant(110 : i32) : i32
    %8 = llvm.mlir.constant(3 : i64) : i64
    %9 = llvm.mlir.constant(100 : i32) : i32
    %10 = llvm.mlir.constant(2 : i64) : i64
    %11 = llvm.mlir.constant(99 : i32) : i32
    %12 = llvm.mlir.constant(1 : i64) : i64
    %13 = llvm.mlir.constant(98 : i32) : i32
    %14 = llvm.mlir.constant(16 : i64) : i64
    %15 = llvm.mlir.constant(97 : i32) : i32
    %16 = llvm.mlir.addressof @a : !llvm.ptr<array<4 x i32>>
    %17 = llvm.mlir.constant(0 : i64) : i64
    %18 = llvm.mlir.addressof @a : !llvm.ptr<array<4 x i32>>
    %19 = llvm.getelementptr %18[%17, %17] : (!llvm.ptr<array<4 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %20 = llvm.bitcast %19 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %21 = llvm.ptrtoint %16 : !llvm.ptr<array<4 x i32>> to i64
    %22 = llvm.call @memchr(%20, %15, %14) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %23 = llvm.ptrtoint %22 : !llvm.ptr<i8> to i64
    %24 = llvm.sub %23, %21  : i64
    %25 = llvm.getelementptr %arg0[%17] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %24, %25 : !llvm.ptr<i64>
    %26 = llvm.call @memchr(%20, %13, %14) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %27 = llvm.ptrtoint %26 : !llvm.ptr<i8> to i64
    %28 = llvm.sub %27, %21  : i64
    %29 = llvm.getelementptr %arg0[%12] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %28, %29 : !llvm.ptr<i64>
    %30 = llvm.call @memchr(%20, %11, %14) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %31 = llvm.ptrtoint %30 : !llvm.ptr<i8> to i64
    %32 = llvm.sub %31, %21  : i64
    %33 = llvm.getelementptr %arg0[%10] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %32, %33 : !llvm.ptr<i64>
    %34 = llvm.call @memchr(%20, %9, %14) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %35 = llvm.ptrtoint %34 : !llvm.ptr<i8> to i64
    %36 = llvm.sub %35, %21  : i64
    %37 = llvm.getelementptr %arg0[%8] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %36, %37 : !llvm.ptr<i64>
    %38 = llvm.call @memchr(%20, %7, %14) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %39 = llvm.ptrtoint %38 : !llvm.ptr<i8> to i64
    %40 = llvm.sub %39, %21  : i64
    %41 = llvm.getelementptr %arg0[%6] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %40, %41 : !llvm.ptr<i64>
    %42 = llvm.call @memchr(%20, %5, %14) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %43 = llvm.ptrtoint %42 : !llvm.ptr<i8> to i64
    %44 = llvm.sub %43, %21  : i64
    %45 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %44, %45 : !llvm.ptr<i64>
    %46 = llvm.call @memchr(%20, %3, %14) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %47 = llvm.ptrtoint %46 : !llvm.ptr<i8> to i64
    %48 = llvm.sub %47, %21  : i64
    %49 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %48, %49 : !llvm.ptr<i64>
    %50 = llvm.call @memchr(%20, %1, %14) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %51 = llvm.ptrtoint %50 : !llvm.ptr<i8> to i64
    %52 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %51, %52 : !llvm.ptr<i64>
    llvm.return
  }
  llvm.func @fold_memchr_a_p1(%arg0: !llvm.ptr<i64>) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.mlir.constant(97 : i32) : i32
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.mlir.constant(104 : i32) : i32
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.mlir.constant(103 : i32) : i32
    %8 = llvm.mlir.constant(102 : i32) : i32
    %9 = llvm.mlir.constant(12 : i64) : i64
    %10 = llvm.mlir.constant(101 : i32) : i32
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.mlir.constant(0 : i64) : i64
    %13 = llvm.mlir.addressof @a : !llvm.ptr<array<4 x i32>>
    %14 = llvm.getelementptr %13[%12, %11] : (!llvm.ptr<array<4 x i32>>, i64, i64) -> !llvm.ptr<i32>
    %15 = llvm.bitcast %14 : !llvm.ptr<i32> to !llvm.ptr<i8>
    %16 = llvm.ptrtoint %15 : !llvm.ptr<i8> to i64
    %17 = llvm.call @memchr(%15, %10, %9) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %18 = llvm.ptrtoint %17 : !llvm.ptr<i8> to i64
    %19 = llvm.sub %18, %16  : i64
    %20 = llvm.getelementptr %arg0[%12] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %19, %20 : !llvm.ptr<i64>
    %21 = llvm.call @memchr(%15, %8, %9) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i8> to i64
    %23 = llvm.sub %22, %16  : i64
    %24 = llvm.getelementptr %arg0[%11] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %23, %24 : !llvm.ptr<i64>
    %25 = llvm.call @memchr(%15, %7, %9) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %26 = llvm.ptrtoint %25 : !llvm.ptr<i8> to i64
    %27 = llvm.sub %26, %16  : i64
    %28 = llvm.getelementptr %arg0[%6] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %27, %28 : !llvm.ptr<i64>
    %29 = llvm.call @memchr(%15, %5, %9) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %30 = llvm.ptrtoint %29 : !llvm.ptr<i8> to i64
    %31 = llvm.sub %30, %16  : i64
    %32 = llvm.getelementptr %arg0[%4] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %31, %32 : !llvm.ptr<i64>
    %33 = llvm.call @memchr(%15, %3, %9) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %34 = llvm.ptrtoint %33 : !llvm.ptr<i8> to i64
    %35 = llvm.getelementptr %arg0[%2] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %34, %35 : !llvm.ptr<i64>
    %36 = llvm.call @memchr(%15, %1, %9) : (!llvm.ptr<i8>, i32, i64) -> !llvm.ptr<i8>
    %37 = llvm.ptrtoint %36 : !llvm.ptr<i8> to i64
    %38 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %37, %38 : !llvm.ptr<i64>
    llvm.return
  }
}
