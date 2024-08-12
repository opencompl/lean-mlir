module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello world\\n\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hellonull("hello\00world\\n\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @null(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global external constant @newlines("\0D\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @single("\1F\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @spaces(" \0D\0A\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @negative("\FF\FE\00") {addr_space = 0 : i32}
  llvm.mlir.global external @chp() {addr_space = 0 : i32} : !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.mlir.global internal constant @s(dense<0> : tensor<1xi8>) {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : !llvm.array<1 x i8>
  llvm.func @memchr(!llvm.ptr, i32, i32) -> !llvm.ptr
  llvm.func @test1() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test2() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(119 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.addressof @chp : !llvm.ptr
    %7 = llvm.call @memchr(%2, %3, %4) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %7, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test3() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test4(%arg0: i32) {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(14 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @chp : !llvm.ptr
    %5 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %5, %4 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test5() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(65280 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test6() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(100 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test7() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(120 : i32) : i32
    %3 = llvm.mlir.constant(100 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test8() {
    %0 = llvm.mlir.constant("hello\00world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hellonull : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(14 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test9() {
    %0 = llvm.mlir.constant("hello\00world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hellonull : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(119 : i32) : i32
    %5 = llvm.mlir.constant(12 : i32) : i32
    %6 = llvm.mlir.zero : !llvm.ptr
    %7 = llvm.mlir.addressof @chp : !llvm.ptr
    %8 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<14 x i8>
    %9 = llvm.call @memchr(%8, %4, %5) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %9, %7 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test10() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(6 : i32) : i32
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.mlir.addressof @chp : !llvm.ptr
    %6 = llvm.call @memchr(%1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.store %6, %5 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @test11(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("\0D\0A\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @newlines : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @test12(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(" \0D\0A\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @spaces : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @test13(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("\1F\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @single : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @test14(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant("\1F\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @single : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.call @memchr(%1, %arg0, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @test15(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant("\FF\FE\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @negative : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.call @memchr(%1, %arg0, %arg1) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }
  llvm.func @pr32124() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @s : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.call @memchr(%2, %3, %4) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @test16(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test17(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memchr(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test18(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test19(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
}
