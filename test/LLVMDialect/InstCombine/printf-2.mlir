module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello_world("hello world\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @h("h\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @percent_s("%s\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @format_str("%s\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @charstr("a\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @empty(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @test_simplify1() {
    %0 = llvm.mlir.constant("h\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @h : !llvm.ptr
    %2 = llvm.call @printf(%1) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify2() {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @printf(%1) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify6() {
    %0 = llvm.mlir.constant("%s\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %3 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %4 = llvm.call @printf(%1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify7() {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @format_str : !llvm.ptr
    %2 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @charstr : !llvm.ptr
    %4 = llvm.call @printf(%1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify8() {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @format_str : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @empty : !llvm.ptr
    %5 = llvm.call @printf(%1, %4) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify9() {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @format_str : !llvm.ptr
    %2 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %3 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %4 = llvm.call @printf(%1, %3) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify10() {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @format_str : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @empty : !llvm.ptr
    %5 = llvm.mlir.constant(42 : i32) : i32
    %6 = llvm.mlir.constant(3.1400001049041748 : f64) : f64
    %7 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %8 = llvm.mlir.addressof @charstr : !llvm.ptr
    %9 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %10 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %11 = llvm.call @printf(%1, %4, %5, %6) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32, f64) -> i32
    %12 = llvm.call @printf(%1, %8, %5, %6) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32, f64) -> i32
    %13 = llvm.call @printf(%1, %10, %5, %6) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32, f64) -> i32
    llvm.return
  }
}
