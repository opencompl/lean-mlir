module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @foo("foo\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hel("hel\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hello_u("hello_u\00") {addr_space = 0 : i32}
  llvm.func @memcmp(!llvm.ptr, !llvm.ptr, i32) -> i32
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: i32) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %0 : i32
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @hel : !llvm.ptr
    %2 = llvm.mlir.constant("hello_u\00") : !llvm.array<8 x i8>
    %3 = llvm.mlir.addressof @hello_u : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @hel : !llvm.ptr
    %2 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @foo : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant("foo\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @foo : !llvm.ptr
    %2 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @hel : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.call @memcmp(%1, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test_simplify7(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %3 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.store %arg1, %4 {alignment = 8 : i64} : i64, !llvm.ptr
    %5 = llvm.call @memcmp(%3, %4, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @test_simplify8(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %arg1, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.call @memcmp(%3, %4, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @test_simplify9(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i16 {alignment = 2 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i16 {alignment = 2 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %3 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.store %arg1, %4 {alignment = 2 : i64} : i16, !llvm.ptr
    %5 = llvm.call @memcmp(%3, %4, %1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }
  llvm.func @test_simplify10(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
}
