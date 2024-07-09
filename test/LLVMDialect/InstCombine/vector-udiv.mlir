module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_v4i32_splatconst_pow2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @test_v4i32_const_pow2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @test_v4i32_negconstsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @test_v4i32_negconst(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-3, -5, -7, -9]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @test_v4i32_negconst_undef(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.mlir.constant(-5 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.udiv %arg0, %12  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }
  llvm.func @test_v4i32_shl_splatconst_pow2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %0, %arg1  : vector<4xi32>
    %2 = llvm.udiv %arg0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @test_v4i32_shl_const_pow2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[4, 8, 16, 32]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %0, %arg1  : vector<4xi32>
    %2 = llvm.udiv %arg0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @test_v4i32_zext_shl_splatconst_pow2(%arg0: vector<4xi32>, %arg1: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.shl %0, %arg1  : vector<4xi16>
    %2 = llvm.zext %1 : vector<4xi16> to vector<4xi32>
    %3 = llvm.udiv %arg0, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
  llvm.func @test_v4i32_zext_shl_const_pow2(%arg0: vector<4xi32>, %arg1: vector<4xi16>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[4, 8, 16, 32]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.shl %0, %arg1  : vector<4xi16>
    %2 = llvm.zext %1 : vector<4xi16> to vector<4xi32>
    %3 = llvm.udiv %arg0, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }
}
