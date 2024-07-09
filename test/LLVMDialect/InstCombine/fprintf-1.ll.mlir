module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello_world("hello world\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @percent_c("%c\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @percent_d("%d\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @percent_f("%f\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @percent_s("%s\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @percent_m("%m\00") {addr_space = 0 : i32}
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_c : !llvm.ptr
    %2 = llvm.mlir.constant(104 : i8) : i8
    %3 = llvm.call @fprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i8) -> i32
    llvm.return
  }
  llvm.func @test_simplify3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_s : !llvm.ptr
    %2 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %3 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %4 = llvm.call @fprintf(%arg0, %1, %3) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_simplify4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%d\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_d : !llvm.ptr
    %2 = llvm.mlir.constant(187 : i32) : i32
    %3 = llvm.call @fprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return
  }
  llvm.func @test_simplify5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%f\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_f : !llvm.ptr
    %2 = llvm.mlir.constant(1.870000e+00 : f64) : f64
    %3 = llvm.call @fprintf(%arg0, %1, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }
  llvm.func @test_no_simplify2(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.constant("%f\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_f : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, f64) -> i32
    llvm.return
  }
  llvm.func @test_no_simplify3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_no_simplify4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("%m\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @percent_m : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
}
