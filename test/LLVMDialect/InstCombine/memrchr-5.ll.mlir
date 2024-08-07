module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a(dense<[1633837924, 1701209960, 1768581996, 1835954032, 1633837924]> : tensor<5xi32>) {addr_space = 0 : i32} : !llvm.array<5 x i32>
  llvm.func @memrchr(!llvm.ptr, i32, i64) -> !llvm.ptr
  llvm.func @fold_memrchr_a_16(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[1633837924, 1701209960, 1768581996, 1835954032, 1633837924]> : tensor<5xi32>) : !llvm.array<5 x i32>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(97 : i32) : i32
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.mlir.constant(98 : i32) : i32
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(99 : i32) : i32
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(100 : i32) : i32
    %9 = llvm.mlir.constant(3 : i64) : i64
    %10 = llvm.mlir.constant(110 : i32) : i32
    %11 = llvm.mlir.constant(4 : i64) : i64
    %12 = llvm.mlir.constant(111 : i32) : i32
    %13 = llvm.mlir.constant(6 : i64) : i64
    %14 = llvm.mlir.constant(112 : i32) : i32
    %15 = llvm.mlir.constant(7 : i64) : i64
    %16 = llvm.mlir.constant(113 : i32) : i32
    %17 = llvm.mlir.constant(8 : i64) : i64
    %18 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %19 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %20 = llvm.ptrtoint %19 : !llvm.ptr to i64
    %21 = llvm.sub %20, %18  : i64
    llvm.store %21, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %22 = llvm.call @memrchr(%1, %4, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %23 = llvm.ptrtoint %22 : !llvm.ptr to i64
    %24 = llvm.sub %23, %18  : i64
    %25 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %24, %25 {alignment = 4 : i64} : i64, !llvm.ptr
    %26 = llvm.call @memrchr(%1, %6, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %27 = llvm.ptrtoint %26 : !llvm.ptr to i64
    %28 = llvm.sub %27, %18  : i64
    %29 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %28, %29 {alignment = 4 : i64} : i64, !llvm.ptr
    %30 = llvm.call @memrchr(%1, %8, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %31 = llvm.ptrtoint %30 : !llvm.ptr to i64
    %32 = llvm.sub %31, %18  : i64
    %33 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %32, %33 {alignment = 4 : i64} : i64, !llvm.ptr
    %34 = llvm.call @memrchr(%1, %10, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %35 = llvm.ptrtoint %34 : !llvm.ptr to i64
    %36 = llvm.sub %35, %18  : i64
    %37 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %36, %37 {alignment = 4 : i64} : i64, !llvm.ptr
    %38 = llvm.call @memrchr(%1, %12, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %39 = llvm.ptrtoint %38 : !llvm.ptr to i64
    %40 = llvm.sub %39, %18  : i64
    %41 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %40, %41 {alignment = 4 : i64} : i64, !llvm.ptr
    %42 = llvm.call @memrchr(%1, %14, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %43 = llvm.ptrtoint %42 : !llvm.ptr to i64
    %44 = llvm.sub %43, %18  : i64
    %45 = llvm.getelementptr %arg0[%15] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %44, %45 {alignment = 4 : i64} : i64, !llvm.ptr
    %46 = llvm.call @memrchr(%1, %16, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %47 = llvm.ptrtoint %46 : !llvm.ptr to i64
    %48 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %47, %48 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_memrchr_a_p1_16(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[1633837924, 1701209960, 1768581996, 1835954032, 1633837924]> : tensor<5xi32>) : !llvm.array<5 x i32>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(101 : i32) : i32
    %5 = llvm.mlir.constant(12 : i64) : i64
    %6 = llvm.mlir.constant(102 : i32) : i32
    %7 = llvm.mlir.constant(103 : i32) : i32
    %8 = llvm.mlir.constant(2 : i64) : i64
    %9 = llvm.mlir.constant(104 : i32) : i32
    %10 = llvm.mlir.constant(3 : i64) : i64
    %11 = llvm.mlir.constant(97 : i32) : i32
    %12 = llvm.mlir.constant(4 : i64) : i64
    %13 = llvm.mlir.constant(100 : i32) : i32
    %14 = llvm.mlir.constant(5 : i64) : i64
    %15 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<5 x i32>
    %16 = llvm.ptrtoint %15 : !llvm.ptr to i64
    %17 = llvm.call @memrchr(%15, %4, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %18 = llvm.ptrtoint %17 : !llvm.ptr to i64
    %19 = llvm.sub %18, %16  : i64
    llvm.store %19, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %20 = llvm.call @memrchr(%15, %6, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %21 = llvm.ptrtoint %20 : !llvm.ptr to i64
    %22 = llvm.sub %21, %16  : i64
    %23 = llvm.getelementptr %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %22, %23 {alignment = 4 : i64} : i64, !llvm.ptr
    %24 = llvm.call @memrchr(%15, %7, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %25 = llvm.ptrtoint %24 : !llvm.ptr to i64
    %26 = llvm.sub %25, %16  : i64
    %27 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %26, %27 {alignment = 4 : i64} : i64, !llvm.ptr
    %28 = llvm.call @memrchr(%15, %9, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %29 = llvm.ptrtoint %28 : !llvm.ptr to i64
    %30 = llvm.sub %29, %16  : i64
    %31 = llvm.getelementptr %arg0[%10] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %30, %31 {alignment = 4 : i64} : i64, !llvm.ptr
    %32 = llvm.call @memrchr(%15, %11, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %33 = llvm.ptrtoint %32 : !llvm.ptr to i64
    %34 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %33, %34 {alignment = 4 : i64} : i64, !llvm.ptr
    %35 = llvm.call @memrchr(%15, %13, %5) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %36 = llvm.ptrtoint %35 : !llvm.ptr to i64
    %37 = llvm.getelementptr %arg0[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %36, %37 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @fold_memrchr_a_20(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<[1633837924, 1701209960, 1768581996, 1835954032, 1633837924]> : tensor<5xi32>) : !llvm.array<5 x i32>
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(97 : i32) : i32
    %3 = llvm.mlir.constant(20 : i64) : i64
    %4 = llvm.mlir.constant(98 : i32) : i32
    %5 = llvm.mlir.constant(1 : i64) : i64
    %6 = llvm.mlir.constant(99 : i32) : i32
    %7 = llvm.mlir.constant(2 : i64) : i64
    %8 = llvm.mlir.constant(100 : i32) : i32
    %9 = llvm.mlir.constant(3 : i64) : i64
    %10 = llvm.mlir.constant(101 : i32) : i32
    %11 = llvm.mlir.constant(4 : i64) : i64
    %12 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %13 = llvm.call @memrchr(%1, %2, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %14 = llvm.ptrtoint %13 : !llvm.ptr to i64
    %15 = llvm.sub %14, %12  : i64
    llvm.store %15, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %16 = llvm.call @memrchr(%1, %4, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %17 = llvm.ptrtoint %16 : !llvm.ptr to i64
    %18 = llvm.sub %17, %12  : i64
    %19 = llvm.getelementptr %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %18, %19 {alignment = 4 : i64} : i64, !llvm.ptr
    %20 = llvm.call @memrchr(%1, %6, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %21 = llvm.ptrtoint %20 : !llvm.ptr to i64
    %22 = llvm.sub %21, %12  : i64
    %23 = llvm.getelementptr %arg0[%7] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %22, %23 {alignment = 4 : i64} : i64, !llvm.ptr
    %24 = llvm.call @memrchr(%1, %8, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %25 = llvm.ptrtoint %24 : !llvm.ptr to i64
    %26 = llvm.sub %25, %12  : i64
    %27 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %26, %27 {alignment = 4 : i64} : i64, !llvm.ptr
    %28 = llvm.call @memrchr(%1, %10, %3) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    %29 = llvm.ptrtoint %28 : !llvm.ptr to i64
    %30 = llvm.sub %29, %12  : i64
    %31 = llvm.getelementptr %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %30, %31 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
}
