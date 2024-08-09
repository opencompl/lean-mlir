module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello world\\n\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @null(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global external constant @newlines("\0D\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external @chp() {addr_space = 0 : i32} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @strchr(!llvm.ptr, i32) -> !llvm.ptr
  llvm.func @test_simplify1() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @strchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test_simplify2() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(119 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @strchr(%2, %3) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test_simplify3() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @strchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test_simplify4(%arg0: i32) {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.addressof @chp : !llvm.ptr
    %4 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %4, %3 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test_simplify5() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @strchr(%1, %2) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test_simplify6(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @chp : !llvm.ptr
    %3 = llvm.call @strchr(%arg0, %0) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.store %3, %2 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test_simplify7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("\0D\0A\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @newlines : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @strchr(%1, %arg0) : (!llvm.ptr, i32) -> !llvm.ptr
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.call @strchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strchr(%arg0, %arg1) : (!llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
}
