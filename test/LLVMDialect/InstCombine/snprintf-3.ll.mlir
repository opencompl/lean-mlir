module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @pcnt_s("%s\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s("123\00") {addr_space = 0 : i32}
  llvm.mlir.global external @adst() {addr_space = 0 : i32} : !llvm.array<0 x ptr>
  llvm.mlir.global external @asiz() {addr_space = 0 : i32} : !llvm.array<0 x i32>
  llvm.func @snprintf(!llvm.ptr, i64, !llvm.ptr, ...) -> i32
  llvm.func @fold_snprintf_pcnt_s() {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @adst : !llvm.ptr
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %4 = llvm.mlir.constant(2147483647 : i64) : i64
    %5 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %6 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %7 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %8 = llvm.mlir.addressof @s : !llvm.ptr
    %9 = llvm.mlir.addressof @asiz : !llvm.ptr
    %10 = llvm.mlir.constant(5 : i32) : i32
    %11 = llvm.getelementptr %2[%1, %10] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %12 = llvm.mlir.constant(5 : i64) : i64
    %13 = llvm.getelementptr %9[%1, %10] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %14 = llvm.mlir.constant(4 : i32) : i32
    %15 = llvm.getelementptr %2[%1, %14] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %16 = llvm.mlir.constant(4 : i64) : i64
    %17 = llvm.getelementptr %9[%1, %14] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %18 = llvm.mlir.constant(3 : i32) : i32
    %19 = llvm.getelementptr %2[%1, %18] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %20 = llvm.mlir.constant(3 : i64) : i64
    %21 = llvm.getelementptr %9[%1, %18] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %22 = llvm.mlir.constant(2 : i32) : i32
    %23 = llvm.getelementptr %2[%1, %22] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %24 = llvm.mlir.constant(2 : i64) : i64
    %25 = llvm.getelementptr %9[%1, %22] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %26 = llvm.mlir.constant(1 : i32) : i32
    %27 = llvm.getelementptr %2[%1, %26] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %28 = llvm.mlir.constant(1 : i64) : i64
    %29 = llvm.getelementptr %9[%1, %26] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %30 = llvm.mlir.constant(0 : i64) : i64
    %31 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %32 = llvm.call @snprintf(%31, %4, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %32, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    %33 = llvm.load %11 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %34 = llvm.call @snprintf(%33, %12, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %34, %13 {alignment = 4 : i64} : i32, !llvm.ptr
    %35 = llvm.load %15 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %36 = llvm.call @snprintf(%35, %16, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %36, %17 {alignment = 4 : i64} : i32, !llvm.ptr
    %37 = llvm.load %19 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %38 = llvm.call @snprintf(%37, %20, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %38, %21 {alignment = 4 : i64} : i32, !llvm.ptr
    %39 = llvm.load %23 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %40 = llvm.call @snprintf(%39, %24, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %40, %25 {alignment = 4 : i64} : i32, !llvm.ptr
    %41 = llvm.load %27 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %42 = llvm.call @snprintf(%41, %28, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %42, %29 {alignment = 4 : i64} : i32, !llvm.ptr
    %43 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %44 = llvm.call @snprintf(%43, %30, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %44, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @call_snprintf_pcnt_s_ximax() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @adst : !llvm.ptr
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %6 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %7 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %8 = llvm.mlir.addressof @s : !llvm.ptr
    %9 = llvm.mlir.addressof @asiz : !llvm.ptr
    %10 = llvm.getelementptr %9[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %11 = llvm.mlir.constant(2147483648 : i64) : i64
    %12 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %13 = llvm.call @snprintf(%12, %4, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %13, %10 {alignment = 4 : i64} : i32, !llvm.ptr
    %14 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %15 = llvm.call @snprintf(%14, %11, %6, %8) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, !llvm.ptr) -> i32
    llvm.store %15, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
