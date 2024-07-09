module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @pcnt_c("%c\00") {addr_space = 0 : i32}
  llvm.mlir.global external @adst() {addr_space = 0 : i32} : !llvm.array<0 x ptr>
  llvm.mlir.global external @asiz() {addr_space = 0 : i32} : !llvm.array<0 x i32>
  llvm.func @snprintf(!llvm.ptr, i64, !llvm.ptr, ...) -> i32
  llvm.func @fold_snprintf_pcnt_c(%arg0: i32) {
    %0 = llvm.mlir.addressof @adst : !llvm.ptr
    %1 = llvm.mlir.constant(2147483647 : i64) : i64
    %2 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @pcnt_c : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.addressof @asiz : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.getelementptr %0[%6, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %8 = llvm.mlir.constant(2 : i64) : i64
    %9 = llvm.mlir.constant(2 : i8) : i8
    %10 = llvm.getelementptr %5[%6, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %11 = llvm.mlir.constant(2 : i32) : i32
    %12 = llvm.getelementptr %0[%6, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %13 = llvm.mlir.constant(0 : i8) : i8
    %14 = llvm.getelementptr %5[%6, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %15 = llvm.mlir.constant(3 : i32) : i32
    %16 = llvm.getelementptr %0[%6, %15] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %17 = llvm.mlir.constant(1 : i64) : i64
    %18 = llvm.mlir.constant(3 : i16) : i16
    %19 = llvm.getelementptr %5[%6, %15] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %20 = llvm.mlir.constant(4 : i32) : i32
    %21 = llvm.getelementptr %0[%6, %20] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %22 = llvm.mlir.constant(0 : i64) : i64
    %23 = llvm.getelementptr %5[%6, %20] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %24 = llvm.mlir.constant(5 : i32) : i32
    %25 = llvm.getelementptr %0[%6, %24] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %26 = llvm.getelementptr %5[%6, %24] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %27 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %28 = llvm.call @snprintf(%27, %1, %3, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.store %28, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    %29 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %30 = llvm.call @snprintf(%29, %8, %3, %9) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %30, %10 {alignment = 4 : i64} : i32, !llvm.ptr
    %31 = llvm.load %12 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %32 = llvm.call @snprintf(%31, %8, %3, %13) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %32, %14 {alignment = 4 : i64} : i32, !llvm.ptr
    %33 = llvm.load %16 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %34 = llvm.call @snprintf(%33, %17, %3, %18) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i16) -> i32
    llvm.store %34, %19 {alignment = 4 : i64} : i32, !llvm.ptr
    %35 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %36 = llvm.call @snprintf(%35, %22, %3, %20) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.store %36, %23 {alignment = 4 : i64} : i32, !llvm.ptr
    %37 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %38 = llvm.call @snprintf(%37, %8, %3, %arg0) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.store %38, %23 {alignment = 4 : i64} : i32, !llvm.ptr
    %39 = llvm.load %25 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %40 = llvm.call @snprintf(%39, %17, %3, %arg0) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i32) -> i32
    llvm.store %40, %26 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @call_snprintf_pcnt_c_ximax(%arg0: i32) {
    %0 = llvm.mlir.addressof @adst : !llvm.ptr
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @pcnt_c : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.addressof @asiz : !llvm.ptr
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.getelementptr %0[%7, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %9 = llvm.mlir.constant(2147483648 : i64) : i64
    %10 = llvm.mlir.constant(1 : i8) : i8
    %11 = llvm.getelementptr %5[%7, %6] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.getelementptr %0[%7, %12] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x ptr>
    %14 = llvm.mlir.constant(-4294967296 : i64) : i64
    %15 = llvm.getelementptr %5[%7, %12] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<0 x i32>
    %16 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %17 = llvm.call @snprintf(%16, %1, %3, %4) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %17, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    %18 = llvm.load %8 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %19 = llvm.call @snprintf(%18, %9, %3, %10) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %19, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    %20 = llvm.load %13 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %21 = llvm.call @snprintf(%20, %14, %3, %10) vararg(!llvm.func<i32 (ptr, i64, ptr, ...)>) : (!llvm.ptr, i64, !llvm.ptr, i8) -> i32
    llvm.store %21, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
