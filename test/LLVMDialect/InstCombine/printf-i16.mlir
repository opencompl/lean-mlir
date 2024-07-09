module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @s1("\01\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s7f("\7F\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @s80("\80\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @sff("\FF\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @pcnt_c("%c\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @pcnt_s("%s\00") {addr_space = 0 : i32}
  llvm.func @putchar(i16) -> i16
  llvm.func @puts(!llvm.ptr) -> i16
  llvm.func @printf(!llvm.ptr, ...) -> i16
  llvm.func @xform_printf(%arg0: i8, %arg1: i16) {
    %0 = llvm.mlir.constant("\01\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @s1 : !llvm.ptr
    %2 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %3 = llvm.mlir.addressof @pcnt_c : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i16) : i16
    %5 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %6 = llvm.mlir.addressof @pcnt_s : !llvm.ptr
    %7 = llvm.mlir.constant("\7F\00") : !llvm.array<2 x i8>
    %8 = llvm.mlir.addressof @s7f : !llvm.ptr
    %9 = llvm.mlir.constant(127 : i16) : i16
    %10 = llvm.mlir.constant("\80\00") : !llvm.array<2 x i8>
    %11 = llvm.mlir.addressof @s80 : !llvm.ptr
    %12 = llvm.mlir.constant(128 : i16) : i16
    %13 = llvm.mlir.constant("\FF\00") : !llvm.array<2 x i8>
    %14 = llvm.mlir.addressof @sff : !llvm.ptr
    %15 = llvm.mlir.constant(255 : i16) : i16
    %16 = llvm.call @printf(%1) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr) -> i16
    %17 = llvm.call @printf(%3, %4) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    %18 = llvm.call @printf(%6, %1) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i16
    %19 = llvm.call @printf(%8) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr) -> i16
    %20 = llvm.call @printf(%3, %9) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    %21 = llvm.call @printf(%6, %8) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i16
    %22 = llvm.call @printf(%11) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr) -> i16
    %23 = llvm.call @printf(%3, %12) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    %24 = llvm.call @printf(%6, %11) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i16
    %25 = llvm.call @printf(%14) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr) -> i16
    %26 = llvm.call @printf(%3, %15) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    %27 = llvm.call @printf(%6, %14) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i16
    %28 = llvm.call @printf(%3, %arg0) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i8) -> i16
    %29 = llvm.call @printf(%3, %arg1) vararg(!llvm.func<i16 (ptr, ...)>) : (!llvm.ptr, i16) -> i16
    llvm.return
  }
}
