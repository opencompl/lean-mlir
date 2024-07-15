module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @str(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global external constant @empty(dense<0> : tensor<0xi8>) {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.func @fwrite(!llvm.ptr, i64, i64, !llvm.ptr) -> i64
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @str : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @fwrite(%2, %3, %3, %arg0) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.return
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<0> : tensor<0xi8>) : !llvm.array<0 x i8>
    %1 = llvm.mlir.addressof @empty : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.call @fwrite(%1, %2, %3, %arg0) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.return
  }
  llvm.func @test_simplify3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(dense<0> : tensor<0xi8>) : !llvm.array<0 x i8>
    %1 = llvm.mlir.addressof @empty : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @fwrite(%1, %2, %3, %arg0) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.return
  }
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @str : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @fwrite(%2, %3, %3, %arg0) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.return %4 : i64
  }
  llvm.func @test_no_simplify2(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @str : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.call @fwrite(%2, %arg1, %3, %arg0) : (!llvm.ptr, i64, i64, !llvm.ptr) -> i64
    llvm.return
  }
}
