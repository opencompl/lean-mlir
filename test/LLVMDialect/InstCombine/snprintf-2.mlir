module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @s("123\00") {addr_space = 0 : i32}
  llvm.mlir.global external @adst() {addr_space = 0 : i32} : !llvm.array<0 x ptr>
  llvm.mlir.global external @asiz() {addr_space = 0 : i32} : !llvm.array<0 x i32>
  llvm.func @snprintf(!llvm.ptr, i64, !llvm.ptr, ...) -> i32
  llvm.func @fold_snprintf_fmt() {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @adst : !llvm.ptr
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %4 = llvm.mlir.constant(2147483647 : i64) : i64
    %5 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %6 = llvm.mlir.addressof @s : !llvm.ptr
    %7 = llvm.mlir.addressof @asiz : !llvm.ptr
    %8 = llvm.mlir.constant(5 : i32) : i32
    %9 = llvm.getelementptr %2[%1, %8] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %10 = llvm.mlir.constant(5 : i64) : i64
    %11 = llvm.getelementptr %7[%1, %8] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %12 = llvm.mlir.constant(4 : i32) : i32
    %13 = llvm.getelementptr %2[%1, %12] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %14 = llvm.mlir.constant(4 : i64) : i64
    %15 = llvm.getelementptr %7[%1, %12] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %16 = llvm.mlir.constant(3 : i32) : i32
    %17 = llvm.getelementptr %2[%1, %16] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %18 = llvm.mlir.constant(3 : i64) : i64
    %19 = llvm.getelementptr %7[%1, %16] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %20 = llvm.mlir.constant(2 : i32) : i32
    %21 = llvm.getelementptr %2[%1, %20] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %22 = llvm.mlir.constant(2 : i64) : i64
    %23 = llvm.getelementptr %7[%1, %20] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %24 = llvm.mlir.constant(1 : i32) : i32
    %25 = llvm.getelementptr %2[%1, %24] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %26 = llvm.mlir.constant(1 : i64) : i64
    %27 = llvm.getelementptr %7[%1, %24] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %28 = llvm.mlir.constant(0 : i64) : i64
    %29 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %30 = llvm.call @snprintf(%29, %4, %6) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %30, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %31 = llvm.load %9 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %32 = llvm.call @snprintf(%31, %10, %6) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %32, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    %33 = llvm.load %13 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %34 = llvm.call @snprintf(%33, %14, %6) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %34, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    %35 = llvm.load %17 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %36 = llvm.call @snprintf(%35, %18, %6) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %36, %19 {alignment = 4 : i64} : i32, !llvm.ptr
    %37 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %38 = llvm.call @snprintf(%37, %22, %6) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %38, %23 {alignment = 4 : i64} : i32, !llvm.ptr
    %39 = llvm.load %25 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %40 = llvm.call @snprintf(%39, %26, %6) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %40, %27 {alignment = 4 : i64} : i32, !llvm.ptr
    %41 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %42 = llvm.call @snprintf(%41, %28, %6) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %42, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @call_snprintf_fmt_ximax() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @adst : !llvm.ptr
    %3 = llvm.getelementptr %2[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %4 = llvm.mlir.constant(-1 : i64) : i64
    %5 = llvm.mlir.constant("123\00") : !llvm.array<4 x i8>
    %6 = llvm.mlir.addressof @s : !llvm.ptr
    %7 = llvm.mlir.addressof @asiz : !llvm.ptr
    %8 = llvm.getelementptr %7[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %9 = llvm.mlir.constant(2147483648 : i64) : i64
    %10 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %11 = llvm.call @snprintf(%10, %4, %6) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %11, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %13 = llvm.call @snprintf(%12, %9, %6) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr) -> i32
    llvm.store %13, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
