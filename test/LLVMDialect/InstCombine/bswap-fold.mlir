module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @gp() {addr_space = 0 : i32} : !llvm.array<0 x i8>
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @lshr8_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @lshr16_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @lshr24_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @lshr12_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @lshr8_i32_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @shl16_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @shl16_v2i64(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.shl %arg0, %6  : vector<2xi64>
    %8 = llvm.intr.bswap(%7)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }
  llvm.func @shl56_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @shl42_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @shl8_i32_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @swap_shl16_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @variable_lshr_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8, -16]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg1, %0  : vector<2xi32>
    %2 = llvm.shl %arg0, %1  : vector<2xi32>
    %3 = llvm.intr.bswap(%2)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @variable_shl_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(56 : i64) : i64
    %2 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %3 = llvm.shl %arg1, %0  : i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.shl %2, %4  : i64
    %6 = llvm.intr.bswap(%5)  : (i64) -> i64
    llvm.return %6 : i64
  }
  llvm.func @variable_shl_not_masked_enough_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.and %arg1, %0  : i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @test7(%arg0: i32) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.trunc %0 : i32 to i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }
  llvm.func @test7_vector(%arg0: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.trunc %0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi16>) -> vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }
  llvm.func @test8(%arg0: i64) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.trunc %0 : i64 to i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }
  llvm.func @test8_vector(%arg0: vector<2xi64>) -> vector<2xi16> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = llvm.trunc %0 : vector<2xi64> to vector<2xi16>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi16>) -> vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }
  llvm.func @foo() -> i64 {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.intr.bswap(%0)  : (i64) -> i64
    llvm.return %1 : i64
  }
  llvm.func @bs_and16i(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(10001 : i16) : i16
    %1 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %2 = llvm.and %1, %0  : i16
    llvm.return %2 : i16
  }
  llvm.func @bs_and16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %2 = llvm.and %0, %1  : i16
    llvm.return %2 : i16
  }
  llvm.func @bs_or16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %2 = llvm.or %0, %1  : i16
    llvm.return %2 : i16
  }
  llvm.func @bs_xor16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %2 = llvm.xor %0, %1  : i16
    llvm.return %2 : i16
  }
  llvm.func @bs_and32i(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(100001 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @bs_and32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @bs_or32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @bs_xor32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @bs_and64i(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1000000001 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @bs_and64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @bs_or64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.or %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @bs_xor64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.xor %0, %1  : i64
    llvm.return %2 : i64
  }
  llvm.func @bs_and32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.and %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_or32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.or %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_xor32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_and32ivec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<100001> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_or32ivec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<100001> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.or %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_xor32ivec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<100001> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_and64_multiuse1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.mul %2, %0  : i64
    %4 = llvm.mul %3, %1  : i64
    llvm.return %4 : i64
  }
  llvm.func @bs_and64_multiuse2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.mul %2, %0  : i64
    llvm.return %3 : i64
  }
  llvm.func @bs_and64_multiuse3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.mul %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @bs_and64i_multiuse(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1000000001 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.mul %2, %1  : i64
    llvm.return %3 : i64
  }
  llvm.func @bs_and_lhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.and %0, %arg1  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }
  llvm.func @bs_or_lhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.or %0, %arg1  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }
  llvm.func @bs_xor_lhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.xor %0, %arg1  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }
  llvm.func @bs_and_rhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }
  llvm.func @bs_or_rhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %1 = llvm.or %arg0, %0  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }
  llvm.func @bs_xor_rhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %1 = llvm.xor %arg0, %0  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }
  llvm.func @bs_and_rhs_bs32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @bs_or_rhs_bs32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @bs_xor_rhs_bs32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @bs_and_rhs_bs64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @bs_or_rhs_bs64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.or %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @bs_xor_rhs_bs64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @bs_and_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_or_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.or %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_xor_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_and_rhs_bs64_multiuse1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @bs_and_rhs_bs64_multiuse2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %0, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @bs_all_operand64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @bs_all_operand64_multiuse_both(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @use.i64 : !llvm.ptr
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.intr.bswap(%3)  : (i64) -> i64
    llvm.call %0(%1) : !llvm.ptr, (i64) -> ()
    llvm.call %0(%2) : !llvm.ptr, (i64) -> ()
    llvm.return %4 : i64
  }
  llvm.func @bs_and_constexpr(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.addressof @gp : !llvm.ptr
    %1 = llvm.mlir.constant(4095 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.and %2, %1  : i64
    %4 = llvm.intr.bswap(%3)  : (i64) -> i64
    llvm.store %4, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @bs_and_bs_constexpr(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.addressof @gp : !llvm.ptr
    %1 = llvm.mlir.constant(4095 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.intr.bswap(%4)  : (i64) -> i64
    llvm.store %5, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @bs_active_high8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @bs_active_high7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33554432 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @bs_active_high4(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<60> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @bs_active_high_different(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[56, 57]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @bs_active_high_different_negative(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[56, 55]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @bs_active_high_poison(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(56 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.shl %arg0, %6  : vector<2xi64>
    %8 = llvm.intr.bswap(%7)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }
  llvm.func @bs_active_high8_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @bs_active_high7_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(57 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @bs_active_byte_6h(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(280375465082880 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @bs_active_byte_3h(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(393216 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @bs_active_byte_3h_v2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8388608, 65536]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_active_byte_78h(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(108086391056891904 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @bs_active_low1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.lshr %arg0, %0  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }
  llvm.func @bs_active_low8(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_active_low_different(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 128]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_active_low_different_negative(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[256, 255]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @bs_active_low_undef(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.and %arg0, %6  : vector<2xi32>
    %8 = llvm.intr.bswap(%7)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @bs_active_low8_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @bs_active_low7_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(127 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @bs_active_byte_4l(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1140850688 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @bs_active_byte_2l(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @bs_active_byte_2l_v2(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[256, 65280]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.and %arg0, %0  : vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }
  llvm.func @bs_active_byte_12l(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(384 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }
  llvm.func @use.i64(i64) -> i64
}
