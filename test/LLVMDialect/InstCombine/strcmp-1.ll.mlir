module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hell("hell\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @bell("bell\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @null(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.func @strcmp(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strcmp(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strcmp(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test3() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.call @strcmp(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %4 = llvm.mlir.addressof @null : !llvm.ptr
    %5 = llvm.call @strcmp(%1, %4) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test5(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("bell\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @bell : !llvm.ptr
    %4 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %5 = llvm.mlir.addressof @hello : !llvm.ptr
    %6 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %7 = llvm.call @strcmp(%5, %6) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %7 : i32
  }
  llvm.func @test6(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.call @strcmp(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %0 : i32
  }
  llvm.func @test7(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("bell\00") : !llvm.array<5 x i8>
    %3 = llvm.mlir.addressof @bell : !llvm.ptr
    %4 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %5 = llvm.mlir.addressof @hello : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %8 = llvm.call @strcmp(%5, %7) : (!llvm.ptr, !llvm.ptr) -> i32
    %9 = llvm.icmp "eq" %8, %6 : i32
    llvm.return %9 : i1
  }
}
