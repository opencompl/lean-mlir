module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hell("hell\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @bell("bell\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @null(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.func @strncmp(!llvm.ptr, !llvm.ptr, i32) -> i32
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strncmp(%2, %arg0, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.call @strncmp(%arg0, %2, %3) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test3() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.mlir.constant(10 : i32) : i32
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @null : !llvm.ptr
    %5 = llvm.mlir.constant(10 : i32) : i32
    %6 = llvm.call @strncmp(%1, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %6 : i32
  }
  llvm.func @test5() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.call @strncmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test6(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test7(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test8(%arg0: !llvm.ptr, %arg1: i32) -> i32 {
    %0 = llvm.call @strncmp(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @test9(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 {
    %0 = llvm.call @strncmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @test10(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test11(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test12(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strncmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }
}
