module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @null(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.func @strndup(!llvm.ptr, i64) -> !llvm.ptr
  llvm.func @test1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.call @strndup(%2, %3) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test2() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(4 : i64) : i64
    %3 = llvm.call @strndup(%1, %2) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.call @strndup(%1, %2) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test4() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(6 : i64) : i64
    %3 = llvm.call @strndup(%1, %2) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test5() -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.call @strndup(%1, %2) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test6(%arg0: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @strndup(%1, %arg0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
}
