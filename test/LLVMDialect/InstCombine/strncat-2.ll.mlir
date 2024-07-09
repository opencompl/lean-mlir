module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @empty(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global common @a(dense<0> : tensor<32xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<32 x i8>
  llvm.func @strncat(!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
  llvm.func @test_simplify1() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(13 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return
  }
  llvm.func @test_simplify2() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @empty : !llvm.ptr
    %5 = llvm.mlir.constant(13 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return
  }
  llvm.func @test_simplify3() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return
  }
  llvm.func @test_nosimplify1() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return
  }
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @strncat(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strncat(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test3(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @strncat(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test4(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strncat(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.call @strncat(%arg0, %1, %2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
}
