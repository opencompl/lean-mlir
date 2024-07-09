module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_srem_canonicalize_op0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.srem %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_srem_canonicalize_op1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.srem %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test_srem_canonicalize_nonsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.srem %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_srem_canonicalize_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.srem %2, %arg1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test_srem_canonicalize_multiple_uses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.srem %1, %arg1  : i32
    %3 = llvm.srem %2, %1  : i32
    llvm.return %3 : i32
  }
}
