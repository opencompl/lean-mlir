module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @a5("12345") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s5("12345\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @z0(dense<0> : tensor<0xi8>) {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.mlir.global external constant @z5(dense<0> : tensor<5xi8>) {addr_space = 0 : i32} : !llvm.array<5 x i8>
  llvm.func @strlen(!llvm.ptr) -> i64
  llvm.func @fold_strlen_no_nul(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant("12345") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @a5 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant("12345\00") : !llvm.array<6 x i8>
    %6 = llvm.mlir.addressof @s5 : !llvm.ptr
    %7 = llvm.mlir.constant(6 : i32) : i32
    %8 = llvm.mlir.constant(2 : i64) : i64
    %9 = llvm.mlir.constant(3 : i64) : i64
    %10 = llvm.mlir.constant(dense<0> : tensor<0xi8>) : !llvm.array<0 x i8>
    %11 = llvm.mlir.addressof @z0 : !llvm.ptr
    %12 = llvm.mlir.constant(4 : i64) : i64
    %13 = llvm.mlir.constant(5 : i64) : i64
    %14 = llvm.mlir.constant(0 : i8) : i8
    %15 = llvm.mlir.constant(dense<0> : tensor<5xi8>) : !llvm.array<5 x i8>
    %16 = llvm.mlir.addressof @z5 : !llvm.ptr
    %17 = llvm.mlir.constant(6 : i64) : i64
    %18 = llvm.call @strlen(%1) : (!llvm.ptr) -> i64
    llvm.store %18, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    %19 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %20 = llvm.call @strlen(%19) : (!llvm.ptr) -> i64
    %21 = llvm.getelementptr %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %20, %21 {alignment = 4 : i64} : i64, !llvm.ptr
    %22 = llvm.getelementptr %6[%2, %7] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x i8>
    %23 = llvm.call @strlen(%22) : (!llvm.ptr) -> i64
    %24 = llvm.getelementptr %arg0[%8] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %23, %24 {alignment = 4 : i64} : i64, !llvm.ptr
    %25 = llvm.getelementptr %1[%2, %arg1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %26 = llvm.call @strlen(%25) : (!llvm.ptr) -> i64
    %27 = llvm.getelementptr %arg0[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %26, %27 {alignment = 4 : i64} : i64, !llvm.ptr
    %28 = llvm.call @strlen(%11) : (!llvm.ptr) -> i64
    %29 = llvm.getelementptr %arg0[%12] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %28, %29 {alignment = 4 : i64} : i64, !llvm.ptr
    %30 = llvm.getelementptr %11[%2, %arg1] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i8>
    %31 = llvm.call @strlen(%30) : (!llvm.ptr) -> i64
    %32 = llvm.getelementptr %arg0[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %31, %32 {alignment = 4 : i64} : i64, !llvm.ptr
    %33 = llvm.getelementptr %16[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<5 x i8>
    %34 = llvm.call @strlen(%33) : (!llvm.ptr) -> i64
    %35 = llvm.getelementptr %arg0[%17] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %34, %35 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }
}
