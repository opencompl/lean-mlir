module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @abcba("abcba\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @abc("abc\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @null(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.func @strspn(!llvm.ptr, !llvm.ptr) -> i64
  llvm.func @test_simplify1(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strspn(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strspn(%2, %arg0) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %3 : i64
  }
  llvm.func @test_simplify3() -> i64 {
    %0 = llvm.mlir.constant("abcba\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @abcba : !llvm.ptr
    %2 = llvm.mlir.constant("abc\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @abc : !llvm.ptr
    %4 = llvm.call @strspn(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %4 : i64
  }
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i64 {
    %0 = llvm.call @strspn(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> i64
    llvm.return %0 : i64
  }
}
