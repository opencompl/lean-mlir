import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bswap-fold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr8_i32_before := [llvmfunc|
  llvm.func @lshr8_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def lshr16_v2i32_before := [llvmfunc|
  llvm.func @lshr16_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def lshr24_i32_before := [llvmfunc|
  llvm.func @lshr24_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def lshr12_i32_before := [llvmfunc|
  llvm.func @lshr12_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def lshr8_i32_use_before := [llvmfunc|
  llvm.func @lshr8_i32_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def shl16_i64_before := [llvmfunc|
  llvm.func @shl16_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def shl16_v2i64_before := [llvmfunc|
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
  }]

def shl56_i64_before := [llvmfunc|
  llvm.func @shl56_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def shl42_i64_before := [llvmfunc|
  llvm.func @shl42_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def shl8_i32_use_before := [llvmfunc|
  llvm.func @shl8_i32_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def swap_shl16_i64_before := [llvmfunc|
  llvm.func @swap_shl16_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    llvm.return %3 : i64
  }]

def variable_lshr_v2i32_before := [llvmfunc|
  llvm.func @variable_lshr_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8, -16]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg1, %0  : vector<2xi32>
    %2 = llvm.shl %arg0, %1  : vector<2xi32>
    %3 = llvm.intr.bswap(%2)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def variable_shl_i64_before := [llvmfunc|
  llvm.func @variable_shl_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(56 : i64) : i64
    %2 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %3 = llvm.shl %arg1, %0  : i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.shl %2, %4  : i64
    %6 = llvm.intr.bswap(%5)  : (i64) -> i64
    llvm.return %6 : i64
  }]

def variable_shl_not_masked_enough_i64_before := [llvmfunc|
  llvm.func @variable_shl_not_masked_enough_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.and %arg1, %0  : i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    llvm.return %3 : i64
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.trunc %0 : i32 to i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def test7_vector_before := [llvmfunc|
  llvm.func @test7_vector(%arg0: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.trunc %0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi16>) -> vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i64) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.trunc %0 : i64 to i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def test8_vector_before := [llvmfunc|
  llvm.func @test8_vector(%arg0: vector<2xi64>) -> vector<2xi16> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %1 = llvm.trunc %0 : vector<2xi64> to vector<2xi16>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi16>) -> vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

def foo_before := [llvmfunc|
  llvm.func @foo() -> i64 {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.intr.bswap(%0)  : (i64) -> i64
    llvm.return %1 : i64
  }]

def bs_and16i_before := [llvmfunc|
  llvm.func @bs_and16i(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(10001 : i16) : i16
    %1 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %2 = llvm.and %1, %0  : i16
    llvm.return %2 : i16
  }]

def bs_and16_before := [llvmfunc|
  llvm.func @bs_and16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %2 = llvm.and %0, %1  : i16
    llvm.return %2 : i16
  }]

def bs_or16_before := [llvmfunc|
  llvm.func @bs_or16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %2 = llvm.or %0, %1  : i16
    llvm.return %2 : i16
  }]

def bs_xor16_before := [llvmfunc|
  llvm.func @bs_xor16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %2 = llvm.xor %0, %1  : i16
    llvm.return %2 : i16
  }]

def bs_and32i_before := [llvmfunc|
  llvm.func @bs_and32i(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(100001 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def bs_and32_before := [llvmfunc|
  llvm.func @bs_and32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }]

def bs_or32_before := [llvmfunc|
  llvm.func @bs_or32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }]

def bs_xor32_before := [llvmfunc|
  llvm.func @bs_xor32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def bs_and64i_before := [llvmfunc|
  llvm.func @bs_and64i(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1000000001 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }]

def bs_and64_before := [llvmfunc|
  llvm.func @bs_and64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    llvm.return %2 : i64
  }]

def bs_or64_before := [llvmfunc|
  llvm.func @bs_or64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.or %0, %1  : i64
    llvm.return %2 : i64
  }]

def bs_xor64_before := [llvmfunc|
  llvm.func @bs_xor64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.xor %0, %1  : i64
    llvm.return %2 : i64
  }]

def bs_and32vec_before := [llvmfunc|
  llvm.func @bs_and32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.and %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_or32vec_before := [llvmfunc|
  llvm.func @bs_or32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.or %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_xor32vec_before := [llvmfunc|
  llvm.func @bs_xor32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_and32ivec_before := [llvmfunc|
  llvm.func @bs_and32ivec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<100001> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_or32ivec_before := [llvmfunc|
  llvm.func @bs_or32ivec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<100001> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.or %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_xor32ivec_before := [llvmfunc|
  llvm.func @bs_xor32ivec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<100001> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_and64_multiuse1_before := [llvmfunc|
  llvm.func @bs_and64_multiuse1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.mul %2, %0  : i64
    %4 = llvm.mul %3, %1  : i64
    llvm.return %4 : i64
  }]

def bs_and64_multiuse2_before := [llvmfunc|
  llvm.func @bs_and64_multiuse2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.mul %2, %0  : i64
    llvm.return %3 : i64
  }]

def bs_and64_multiuse3_before := [llvmfunc|
  llvm.func @bs_and64_multiuse3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.mul %2, %1  : i64
    llvm.return %3 : i64
  }]

def bs_and64i_multiuse_before := [llvmfunc|
  llvm.func @bs_and64i_multiuse(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1000000001 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.mul %2, %1  : i64
    llvm.return %3 : i64
  }]

def bs_and_lhs_bs16_before := [llvmfunc|
  llvm.func @bs_and_lhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.and %0, %arg1  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def bs_or_lhs_bs16_before := [llvmfunc|
  llvm.func @bs_or_lhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.or %0, %arg1  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def bs_xor_lhs_bs16_before := [llvmfunc|
  llvm.func @bs_xor_lhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.xor %0, %arg1  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def bs_and_rhs_bs16_before := [llvmfunc|
  llvm.func @bs_and_rhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def bs_or_rhs_bs16_before := [llvmfunc|
  llvm.func @bs_or_rhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %1 = llvm.or %arg0, %0  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def bs_xor_rhs_bs16_before := [llvmfunc|
  llvm.func @bs_xor_rhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %1 = llvm.xor %arg0, %0  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def bs_and_rhs_bs32_before := [llvmfunc|
  llvm.func @bs_and_rhs_bs32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def bs_or_rhs_bs32_before := [llvmfunc|
  llvm.func @bs_or_rhs_bs32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def bs_xor_rhs_bs32_before := [llvmfunc|
  llvm.func @bs_xor_rhs_bs32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def bs_and_rhs_bs64_before := [llvmfunc|
  llvm.func @bs_and_rhs_bs64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def bs_or_rhs_bs64_before := [llvmfunc|
  llvm.func @bs_or_rhs_bs64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.or %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def bs_xor_rhs_bs64_before := [llvmfunc|
  llvm.func @bs_xor_rhs_bs64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def bs_and_rhs_i32vec_before := [llvmfunc|
  llvm.func @bs_and_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_or_rhs_i32vec_before := [llvmfunc|
  llvm.func @bs_or_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.or %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_xor_rhs_i32vec_before := [llvmfunc|
  llvm.func @bs_xor_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg1)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_and_rhs_bs64_multiuse1_before := [llvmfunc|
  llvm.func @bs_and_rhs_bs64_multiuse1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }]

def bs_and_rhs_bs64_multiuse2_before := [llvmfunc|
  llvm.func @bs_and_rhs_bs64_multiuse2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %0, %2  : i64
    llvm.return %3 : i64
  }]

def bs_all_operand64_before := [llvmfunc|
  llvm.func @bs_all_operand64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    llvm.return %3 : i64
  }]

def bs_all_operand64_multiuse_both_before := [llvmfunc|
  llvm.func @bs_all_operand64_multiuse_both(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @use.i64 : !llvm.ptr
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.intr.bswap(%3)  : (i64) -> i64
    llvm.call %0(%1) : !llvm.ptr, (i64) -> ()
    llvm.call %0(%2) : !llvm.ptr, (i64) -> ()
    llvm.return %4 : i64
  }]

def bs_and_constexpr_before := [llvmfunc|
  llvm.func @bs_and_constexpr(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.addressof @gp : !llvm.ptr
    %1 = llvm.mlir.constant(4095 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.and %2, %1  : i64
    %4 = llvm.intr.bswap(%3)  : (i64) -> i64
    llvm.store %4, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def bs_and_bs_constexpr_before := [llvmfunc|
  llvm.func @bs_and_bs_constexpr(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.addressof @gp : !llvm.ptr
    %1 = llvm.mlir.constant(4095 : i64) : i64
    %2 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    %4 = llvm.and %3, %1  : i64
    %5 = llvm.intr.bswap(%4)  : (i64) -> i64
    llvm.store %5, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def bs_active_high8_before := [llvmfunc|
  llvm.func @bs_active_high8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def bs_active_high7_before := [llvmfunc|
  llvm.func @bs_active_high7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-33554432 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def bs_active_high4_before := [llvmfunc|
  llvm.func @bs_active_high4(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<60> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

def bs_active_high_different_before := [llvmfunc|
  llvm.func @bs_active_high_different(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[56, 57]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

def bs_active_high_different_negative_before := [llvmfunc|
  llvm.func @bs_active_high_different_negative(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[56, 55]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

def bs_active_high_poison_before := [llvmfunc|
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
  }]

def bs_active_high8_multiuse_before := [llvmfunc|
  llvm.func @bs_active_high8_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }]

def bs_active_high7_multiuse_before := [llvmfunc|
  llvm.func @bs_active_high7_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(57 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }]

def bs_active_byte_6h_before := [llvmfunc|
  llvm.func @bs_active_byte_6h(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(280375465082880 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def bs_active_byte_3h_before := [llvmfunc|
  llvm.func @bs_active_byte_3h(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(393216 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def bs_active_byte_3h_v2_before := [llvmfunc|
  llvm.func @bs_active_byte_3h_v2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8388608, 65536]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_active_byte_78h_before := [llvmfunc|
  llvm.func @bs_active_byte_78h(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(108086391056891904 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def bs_active_low1_before := [llvmfunc|
  llvm.func @bs_active_low1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.lshr %arg0, %0  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

def bs_active_low8_before := [llvmfunc|
  llvm.func @bs_active_low8(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_active_low_different_before := [llvmfunc|
  llvm.func @bs_active_low_different(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 128]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_active_low_different_negative_before := [llvmfunc|
  llvm.func @bs_active_low_different_negative(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[256, 255]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def bs_active_low_undef_before := [llvmfunc|
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
  }]

def bs_active_low8_multiuse_before := [llvmfunc|
  llvm.func @bs_active_low8_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }]

def bs_active_low7_multiuse_before := [llvmfunc|
  llvm.func @bs_active_low7_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(127 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }]

def bs_active_byte_4l_before := [llvmfunc|
  llvm.func @bs_active_byte_4l(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1140850688 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def bs_active_byte_2l_before := [llvmfunc|
  llvm.func @bs_active_byte_2l(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

def bs_active_byte_2l_v2_before := [llvmfunc|
  llvm.func @bs_active_byte_2l_v2(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[256, 65280]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.and %arg0, %0  : vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

def bs_active_byte_12l_before := [llvmfunc|
  llvm.func @bs_active_byte_12l(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(384 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def lshr8_i32_combined := [llvmfunc|
  llvm.func @lshr8_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr8_i32   : lshr8_i32_before  ⊑  lshr8_i32_combined := by
  unfold lshr8_i32_before lshr8_i32_combined
  simp_alive_peephole
  sorry
def lshr16_v2i32_combined := [llvmfunc|
  llvm.func @lshr16_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_lshr16_v2i32   : lshr16_v2i32_before  ⊑  lshr16_v2i32_combined := by
  unfold lshr16_v2i32_before lshr16_v2i32_combined
  simp_alive_peephole
  sorry
def lshr24_i32_combined := [llvmfunc|
  llvm.func @lshr24_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_lshr24_i32   : lshr24_i32_before  ⊑  lshr24_i32_combined := by
  unfold lshr24_i32_before lshr24_i32_combined
  simp_alive_peephole
  sorry
def lshr12_i32_combined := [llvmfunc|
  llvm.func @lshr12_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr12_i32   : lshr12_i32_before  ⊑  lshr12_i32_combined := by
  unfold lshr12_i32_before lshr12_i32_combined
  simp_alive_peephole
  sorry
def lshr8_i32_use_combined := [llvmfunc|
  llvm.func @lshr8_i32_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_lshr8_i32_use   : lshr8_i32_use_before  ⊑  lshr8_i32_use_combined := by
  unfold lshr8_i32_use_before lshr8_i32_use_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr8_i32_use   : lshr8_i32_use_before  ⊑  lshr8_i32_use_combined := by
  unfold lshr8_i32_use_before lshr8_i32_use_combined
  simp_alive_peephole
  sorry
def shl16_i64_combined := [llvmfunc|
  llvm.func @shl16_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.lshr %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_shl16_i64   : shl16_i64_before  ⊑  shl16_i64_combined := by
  unfold shl16_i64_before shl16_i64_combined
  simp_alive_peephole
  sorry
def shl16_v2i64_combined := [llvmfunc|
  llvm.func @shl16_v2i64(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.intr.bswap(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %8 = llvm.lshr %7, %6  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

theorem inst_combine_shl16_v2i64   : shl16_v2i64_before  ⊑  shl16_v2i64_combined := by
  unfold shl16_v2i64_before shl16_v2i64_combined
  simp_alive_peephole
  sorry
def shl56_i64_combined := [llvmfunc|
  llvm.func @shl56_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_shl56_i64   : shl56_i64_before  ⊑  shl56_i64_combined := by
  unfold shl56_i64_before shl56_i64_combined
  simp_alive_peephole
  sorry
def shl42_i64_combined := [llvmfunc|
  llvm.func @shl42_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_shl42_i64   : shl42_i64_before  ⊑  shl42_i64_combined := by
  unfold shl42_i64_before shl42_i64_combined
  simp_alive_peephole
  sorry
def shl8_i32_use_combined := [llvmfunc|
  llvm.func @shl8_i32_use(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_shl8_i32_use   : shl8_i32_use_before  ⊑  shl8_i32_use_combined := by
  unfold shl8_i32_use_before shl8_i32_use_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl8_i32_use   : shl8_i32_use_before  ⊑  shl8_i32_use_combined := by
  unfold shl8_i32_use_before shl8_i32_use_combined
  simp_alive_peephole
  sorry
def swap_shl16_i64_combined := [llvmfunc|
  llvm.func @swap_shl16_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_swap_shl16_i64   : swap_shl16_i64_before  ⊑  swap_shl16_i64_combined := by
  unfold swap_shl16_i64_before swap_shl16_i64_combined
  simp_alive_peephole
  sorry
def variable_lshr_v2i32_combined := [llvmfunc|
  llvm.func @variable_lshr_v2i32(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-8, -16]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg1, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_variable_lshr_v2i32   : variable_lshr_v2i32_before  ⊑  variable_lshr_v2i32_combined := by
  unfold variable_lshr_v2i32_before variable_lshr_v2i32_combined
  simp_alive_peephole
  sorry
def variable_shl_i64_combined := [llvmfunc|
  llvm.func @variable_shl_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(56 : i64) : i64
    %2 = llvm.shl %arg1, %0  : i64
    %3 = llvm.and %2, %1  : i64
    %4 = llvm.lshr %arg0, %3  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_variable_shl_i64   : variable_shl_i64_before  ⊑  variable_shl_i64_combined := by
  unfold variable_shl_i64_before variable_shl_i64_combined
  simp_alive_peephole
  sorry
def variable_shl_not_masked_enough_i64_combined := [llvmfunc|
  llvm.func @variable_shl_not_masked_enough_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.and %arg1, %0  : i64
    %2 = llvm.shl %arg0, %1  : i64
    %3 = llvm.intr.bswap(%2)  : (i64) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_variable_shl_not_masked_enough_i64   : variable_shl_not_masked_enough_i64_before  ⊑  variable_shl_not_masked_enough_i64_combined := by
  unfold variable_shl_not_masked_enough_i64_before variable_shl_not_masked_enough_i64_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test7_vector_combined := [llvmfunc|
  llvm.func @test7_vector(%arg0: vector<2xi32>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_test7_vector   : test7_vector_before  ⊑  test7_vector_combined := by
  unfold test7_vector_before test7_vector_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i64) -> i16 {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test8_vector_combined := [llvmfunc|
  llvm.func @test8_vector(%arg0: vector<2xi64>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.lshr %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_test8_vector   : test8_vector_before  ⊑  test8_vector_combined := by
  unfold test8_vector_before test8_vector_combined
  simp_alive_peephole
  sorry
def foo_combined := [llvmfunc|
  llvm.func @foo() -> i64 {
    %0 = llvm.mlir.undef : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bs_and16i_combined := [llvmfunc|
  llvm.func @bs_and16i(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(4391 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.intr.bswap(%1)  : (i16) -> i16
    llvm.return %2 : i16
  }]

theorem inst_combine_bs_and16i   : bs_and16i_before  ⊑  bs_and16i_combined := by
  unfold bs_and16i_before bs_and16i_combined
  simp_alive_peephole
  sorry
def bs_and16_combined := [llvmfunc|
  llvm.func @bs_and16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.and %arg0, %arg1  : i16
    %1 = llvm.intr.bswap(%0)  : (i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_bs_and16   : bs_and16_before  ⊑  bs_and16_combined := by
  unfold bs_and16_before bs_and16_combined
  simp_alive_peephole
  sorry
def bs_or16_combined := [llvmfunc|
  llvm.func @bs_or16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.or %arg0, %arg1  : i16
    %1 = llvm.intr.bswap(%0)  : (i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_bs_or16   : bs_or16_before  ⊑  bs_or16_combined := by
  unfold bs_or16_before bs_or16_combined
  simp_alive_peephole
  sorry
def bs_xor16_combined := [llvmfunc|
  llvm.func @bs_xor16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.xor %arg0, %arg1  : i16
    %1 = llvm.intr.bswap(%0)  : (i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_bs_xor16   : bs_xor16_before  ⊑  bs_xor16_combined := by
  unfold bs_xor16_before bs_xor16_combined
  simp_alive_peephole
  sorry
def bs_and32i_combined := [llvmfunc|
  llvm.func @bs_and32i(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1585053440 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_bs_and32i   : bs_and32i_before  ⊑  bs_and32i_combined := by
  unfold bs_and32i_before bs_and32i_combined
  simp_alive_peephole
  sorry
def bs_and32_combined := [llvmfunc|
  llvm.func @bs_and32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.and %arg0, %arg1  : i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_bs_and32   : bs_and32_before  ⊑  bs_and32_combined := by
  unfold bs_and32_before bs_and32_combined
  simp_alive_peephole
  sorry
def bs_or32_combined := [llvmfunc|
  llvm.func @bs_or32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_bs_or32   : bs_or32_before  ⊑  bs_or32_combined := by
  unfold bs_or32_before bs_or32_combined
  simp_alive_peephole
  sorry
def bs_xor32_combined := [llvmfunc|
  llvm.func @bs_xor32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.intr.bswap(%0)  : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_bs_xor32   : bs_xor32_before  ⊑  bs_xor32_combined := by
  unfold bs_xor32_before bs_xor32_combined
  simp_alive_peephole
  sorry
def bs_and64i_combined := [llvmfunc|
  llvm.func @bs_and64i(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(129085117527228416 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_bs_and64i   : bs_and64i_before  ⊑  bs_and64i_combined := by
  unfold bs_and64i_before bs_and64i_combined
  simp_alive_peephole
  sorry
def bs_and64_combined := [llvmfunc|
  llvm.func @bs_and64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1  : i64
    %1 = llvm.intr.bswap(%0)  : (i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_bs_and64   : bs_and64_before  ⊑  bs_and64_combined := by
  unfold bs_and64_before bs_and64_combined
  simp_alive_peephole
  sorry
def bs_or64_combined := [llvmfunc|
  llvm.func @bs_or64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.or %arg0, %arg1  : i64
    %1 = llvm.intr.bswap(%0)  : (i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_bs_or64   : bs_or64_before  ⊑  bs_or64_combined := by
  unfold bs_or64_before bs_or64_combined
  simp_alive_peephole
  sorry
def bs_xor64_combined := [llvmfunc|
  llvm.func @bs_xor64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.xor %arg0, %arg1  : i64
    %1 = llvm.intr.bswap(%0)  : (i64) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_bs_xor64   : bs_xor64_before  ⊑  bs_xor64_combined := by
  unfold bs_xor64_before bs_xor64_combined
  simp_alive_peephole
  sorry
def bs_and32vec_combined := [llvmfunc|
  llvm.func @bs_and32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.and %arg0, %arg1  : vector<2xi32>
    %1 = llvm.intr.bswap(%0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_bs_and32vec   : bs_and32vec_before  ⊑  bs_and32vec_combined := by
  unfold bs_and32vec_before bs_and32vec_combined
  simp_alive_peephole
  sorry
def bs_or32vec_combined := [llvmfunc|
  llvm.func @bs_or32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi32>
    %1 = llvm.intr.bswap(%0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_bs_or32vec   : bs_or32vec_before  ⊑  bs_or32vec_combined := by
  unfold bs_or32vec_before bs_or32vec_combined
  simp_alive_peephole
  sorry
def bs_xor32vec_combined := [llvmfunc|
  llvm.func @bs_xor32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.xor %arg0, %arg1  : vector<2xi32>
    %1 = llvm.intr.bswap(%0)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_bs_xor32vec   : bs_xor32vec_before  ⊑  bs_xor32vec_combined := by
  unfold bs_xor32vec_before bs_xor32vec_combined
  simp_alive_peephole
  sorry
def bs_and32ivec_combined := [llvmfunc|
  llvm.func @bs_and32ivec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1585053440> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_bs_and32ivec   : bs_and32ivec_before  ⊑  bs_and32ivec_combined := by
  unfold bs_and32ivec_before bs_and32ivec_combined
  simp_alive_peephole
  sorry
def bs_or32ivec_combined := [llvmfunc|
  llvm.func @bs_or32ivec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1585053440> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.or %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_bs_or32ivec   : bs_or32ivec_before  ⊑  bs_or32ivec_combined := by
  unfold bs_or32ivec_before bs_or32ivec_combined
  simp_alive_peephole
  sorry
def bs_xor32ivec_combined := [llvmfunc|
  llvm.func @bs_xor32ivec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1585053440> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_bs_xor32ivec   : bs_xor32ivec_before  ⊑  bs_xor32ivec_combined := by
  unfold bs_xor32ivec_before bs_xor32ivec_combined
  simp_alive_peephole
  sorry
def bs_and64_multiuse1_combined := [llvmfunc|
  llvm.func @bs_and64_multiuse1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.mul %2, %0  : i64
    %4 = llvm.mul %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_bs_and64_multiuse1   : bs_and64_multiuse1_before  ⊑  bs_and64_multiuse1_combined := by
  unfold bs_and64_multiuse1_before bs_and64_multiuse1_combined
  simp_alive_peephole
  sorry
def bs_and64_multiuse2_combined := [llvmfunc|
  llvm.func @bs_and64_multiuse2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.mul %2, %0  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_bs_and64_multiuse2   : bs_and64_multiuse2_before  ⊑  bs_and64_multiuse2_combined := by
  unfold bs_and64_multiuse2_before bs_and64_multiuse2_combined
  simp_alive_peephole
  sorry
def bs_and64_multiuse3_combined := [llvmfunc|
  llvm.func @bs_and64_multiuse3(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %2 = llvm.and %0, %1  : i64
    %3 = llvm.mul %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_bs_and64_multiuse3   : bs_and64_multiuse3_before  ⊑  bs_and64_multiuse3_combined := by
  unfold bs_and64_multiuse3_before bs_and64_multiuse3_combined
  simp_alive_peephole
  sorry
def bs_and64i_multiuse_combined := [llvmfunc|
  llvm.func @bs_and64i_multiuse(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1000000001 : i64) : i64
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.and %1, %0  : i64
    %3 = llvm.mul %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_bs_and64i_multiuse   : bs_and64i_multiuse_before  ⊑  bs_and64i_multiuse_combined := by
  unfold bs_and64i_multiuse_before bs_and64i_multiuse_combined
  simp_alive_peephole
  sorry
def bs_and_lhs_bs16_combined := [llvmfunc|
  llvm.func @bs_and_lhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %1 = llvm.and %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_bs_and_lhs_bs16   : bs_and_lhs_bs16_before  ⊑  bs_and_lhs_bs16_combined := by
  unfold bs_and_lhs_bs16_before bs_and_lhs_bs16_combined
  simp_alive_peephole
  sorry
def bs_or_lhs_bs16_combined := [llvmfunc|
  llvm.func @bs_or_lhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %1 = llvm.or %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_bs_or_lhs_bs16   : bs_or_lhs_bs16_before  ⊑  bs_or_lhs_bs16_combined := by
  unfold bs_or_lhs_bs16_before bs_or_lhs_bs16_combined
  simp_alive_peephole
  sorry
def bs_xor_lhs_bs16_combined := [llvmfunc|
  llvm.func @bs_xor_lhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg1)  : (i16) -> i16
    %1 = llvm.xor %0, %arg0  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_bs_xor_lhs_bs16   : bs_xor_lhs_bs16_before  ⊑  bs_xor_lhs_bs16_combined := by
  unfold bs_xor_lhs_bs16_before bs_xor_lhs_bs16_combined
  simp_alive_peephole
  sorry
def bs_and_rhs_bs16_combined := [llvmfunc|
  llvm.func @bs_and_rhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.and %0, %arg1  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_bs_and_rhs_bs16   : bs_and_rhs_bs16_before  ⊑  bs_and_rhs_bs16_combined := by
  unfold bs_and_rhs_bs16_before bs_and_rhs_bs16_combined
  simp_alive_peephole
  sorry
def bs_or_rhs_bs16_combined := [llvmfunc|
  llvm.func @bs_or_rhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.or %0, %arg1  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_bs_or_rhs_bs16   : bs_or_rhs_bs16_before  ⊑  bs_or_rhs_bs16_combined := by
  unfold bs_or_rhs_bs16_before bs_or_rhs_bs16_combined
  simp_alive_peephole
  sorry
def bs_xor_rhs_bs16_combined := [llvmfunc|
  llvm.func @bs_xor_rhs_bs16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.xor %0, %arg1  : i16
    llvm.return %1 : i16
  }]

theorem inst_combine_bs_xor_rhs_bs16   : bs_xor_rhs_bs16_before  ⊑  bs_xor_rhs_bs16_combined := by
  unfold bs_xor_rhs_bs16_before bs_xor_rhs_bs16_combined
  simp_alive_peephole
  sorry
def bs_and_rhs_bs32_combined := [llvmfunc|
  llvm.func @bs_and_rhs_bs32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.and %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_bs_and_rhs_bs32   : bs_and_rhs_bs32_before  ⊑  bs_and_rhs_bs32_combined := by
  unfold bs_and_rhs_bs32_before bs_and_rhs_bs32_combined
  simp_alive_peephole
  sorry
def bs_or_rhs_bs32_combined := [llvmfunc|
  llvm.func @bs_or_rhs_bs32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.or %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_bs_or_rhs_bs32   : bs_or_rhs_bs32_before  ⊑  bs_or_rhs_bs32_combined := by
  unfold bs_or_rhs_bs32_before bs_or_rhs_bs32_combined
  simp_alive_peephole
  sorry
def bs_xor_rhs_bs32_combined := [llvmfunc|
  llvm.func @bs_xor_rhs_bs32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.xor %0, %arg1  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_bs_xor_rhs_bs32   : bs_xor_rhs_bs32_before  ⊑  bs_xor_rhs_bs32_combined := by
  unfold bs_xor_rhs_bs32_before bs_xor_rhs_bs32_combined
  simp_alive_peephole
  sorry
def bs_and_rhs_bs64_combined := [llvmfunc|
  llvm.func @bs_and_rhs_bs64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.and %0, %arg1  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_bs_and_rhs_bs64   : bs_and_rhs_bs64_before  ⊑  bs_and_rhs_bs64_combined := by
  unfold bs_and_rhs_bs64_before bs_and_rhs_bs64_combined
  simp_alive_peephole
  sorry
def bs_or_rhs_bs64_combined := [llvmfunc|
  llvm.func @bs_or_rhs_bs64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.or %0, %arg1  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_bs_or_rhs_bs64   : bs_or_rhs_bs64_before  ⊑  bs_or_rhs_bs64_combined := by
  unfold bs_or_rhs_bs64_before bs_or_rhs_bs64_combined
  simp_alive_peephole
  sorry
def bs_xor_rhs_bs64_combined := [llvmfunc|
  llvm.func @bs_xor_rhs_bs64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %1 = llvm.xor %0, %arg1  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_bs_xor_rhs_bs64   : bs_xor_rhs_bs64_before  ⊑  bs_xor_rhs_bs64_combined := by
  unfold bs_xor_rhs_bs64_before bs_xor_rhs_bs64_combined
  simp_alive_peephole
  sorry
def bs_and_rhs_i32vec_combined := [llvmfunc|
  llvm.func @bs_and_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.and %0, %arg1  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_bs_and_rhs_i32vec   : bs_and_rhs_i32vec_before  ⊑  bs_and_rhs_i32vec_combined := by
  unfold bs_and_rhs_i32vec_before bs_and_rhs_i32vec_combined
  simp_alive_peephole
  sorry
def bs_or_rhs_i32vec_combined := [llvmfunc|
  llvm.func @bs_or_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.or %0, %arg1  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_bs_or_rhs_i32vec   : bs_or_rhs_i32vec_before  ⊑  bs_or_rhs_i32vec_combined := by
  unfold bs_or_rhs_i32vec_before bs_or_rhs_i32vec_combined
  simp_alive_peephole
  sorry
def bs_xor_rhs_i32vec_combined := [llvmfunc|
  llvm.func @bs_xor_rhs_i32vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %1 = llvm.xor %0, %arg1  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_bs_xor_rhs_i32vec   : bs_xor_rhs_i32vec_before  ⊑  bs_xor_rhs_i32vec_combined := by
  unfold bs_xor_rhs_i32vec_before bs_xor_rhs_i32vec_combined
  simp_alive_peephole
  sorry
def bs_and_rhs_bs64_multiuse1_combined := [llvmfunc|
  llvm.func @bs_and_rhs_bs64_multiuse1(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.and %0, %arg0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %1, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_bs_and_rhs_bs64_multiuse1   : bs_and_rhs_bs64_multiuse1_before  ⊑  bs_and_rhs_bs64_multiuse1_combined := by
  unfold bs_and_rhs_bs64_multiuse1_before bs_and_rhs_bs64_multiuse1_combined
  simp_alive_peephole
  sorry
def bs_and_rhs_bs64_multiuse2_combined := [llvmfunc|
  llvm.func @bs_and_rhs_bs64_multiuse2(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %1 = llvm.and %0, %arg0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    %3 = llvm.mul %0, %2  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_bs_and_rhs_bs64_multiuse2   : bs_and_rhs_bs64_multiuse2_before  ⊑  bs_and_rhs_bs64_multiuse2_combined := by
  unfold bs_and_rhs_bs64_multiuse2_before bs_and_rhs_bs64_multiuse2_combined
  simp_alive_peephole
  sorry
def bs_all_operand64_combined := [llvmfunc|
  llvm.func @bs_all_operand64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.and %arg0, %arg1  : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_bs_all_operand64   : bs_all_operand64_before  ⊑  bs_all_operand64_combined := by
  unfold bs_all_operand64_before bs_all_operand64_combined
  simp_alive_peephole
  sorry
def bs_all_operand64_multiuse_both_combined := [llvmfunc|
  llvm.func @bs_all_operand64_multiuse_both(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.addressof @use.i64 : !llvm.ptr
    %1 = llvm.intr.bswap(%arg0)  : (i64) -> i64
    %2 = llvm.intr.bswap(%arg1)  : (i64) -> i64
    %3 = llvm.and %arg0, %arg1  : i64
    llvm.call %0(%1) : !llvm.ptr, (i64) -> ()
    llvm.call %0(%2) : !llvm.ptr, (i64) -> ()
    llvm.return %3 : i64
  }]

theorem inst_combine_bs_all_operand64_multiuse_both   : bs_all_operand64_multiuse_both_before  ⊑  bs_all_operand64_multiuse_both_combined := by
  unfold bs_all_operand64_multiuse_both_before bs_all_operand64_multiuse_both_combined
  simp_alive_peephole
  sorry
def bs_and_constexpr_combined := [llvmfunc|
  llvm.func @bs_and_constexpr(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.addressof @gp : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(4095 : i64) : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.intr.bswap(%3)  : (i64) -> i64
    llvm.store %4, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_bs_and_constexpr   : bs_and_constexpr_before  ⊑  bs_and_constexpr_combined := by
  unfold bs_and_constexpr_before bs_and_constexpr_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bs_and_constexpr   : bs_and_constexpr_before  ⊑  bs_and_constexpr_combined := by
  unfold bs_and_constexpr_before bs_and_constexpr_combined
  simp_alive_peephole
  sorry
def bs_and_bs_constexpr_combined := [llvmfunc|
  llvm.func @bs_and_bs_constexpr(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.addressof @gp : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(-67835469387268096 : i64) : i64
    %3 = llvm.and %1, %2  : i64
    llvm.store %3, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_bs_and_bs_constexpr   : bs_and_bs_constexpr_before  ⊑  bs_and_bs_constexpr_combined := by
  unfold bs_and_bs_constexpr_before bs_and_bs_constexpr_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_bs_and_bs_constexpr   : bs_and_bs_constexpr_before  ⊑  bs_and_bs_constexpr_combined := by
  unfold bs_and_bs_constexpr_before bs_and_bs_constexpr_combined
  simp_alive_peephole
  sorry
def bs_active_high8_combined := [llvmfunc|
  llvm.func @bs_active_high8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    llvm.return %1 : i64
  }]

theorem inst_combine_bs_active_high8   : bs_active_high8_before  ⊑  bs_active_high8_combined := by
  unfold bs_active_high8_before bs_active_high8_combined
  simp_alive_peephole
  sorry
def bs_active_high7_combined := [llvmfunc|
  llvm.func @bs_active_high7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(254 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_bs_active_high7   : bs_active_high7_before  ⊑  bs_active_high7_combined := by
  unfold bs_active_high7_before bs_active_high7_combined
  simp_alive_peephole
  sorry
def bs_active_high4_combined := [llvmfunc|
  llvm.func @bs_active_high4(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<240> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0  : vector<2xi64>
    %3 = llvm.and %2, %1  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_bs_active_high4   : bs_active_high4_before  ⊑  bs_active_high4_combined := by
  unfold bs_active_high4_before bs_active_high4_combined
  simp_alive_peephole
  sorry
def bs_active_high_different_combined := [llvmfunc|
  llvm.func @bs_active_high_different(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[56, 57]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<56> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.shl %arg0, %0  : vector<2xi64>
    %3 = llvm.lshr %2, %1  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_bs_active_high_different   : bs_active_high_different_before  ⊑  bs_active_high_different_combined := by
  unfold bs_active_high_different_before bs_active_high_different_combined
  simp_alive_peephole
  sorry
def bs_active_high_different_negative_combined := [llvmfunc|
  llvm.func @bs_active_high_different_negative(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[56, 55]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.shl %arg0, %0  : vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    llvm.return %2 : vector<2xi64>
  }]

theorem inst_combine_bs_active_high_different_negative   : bs_active_high_different_negative_before  ⊑  bs_active_high_different_negative_combined := by
  unfold bs_active_high_different_negative_before bs_active_high_different_negative_combined
  simp_alive_peephole
  sorry
def bs_active_high_poison_combined := [llvmfunc|
  llvm.func @bs_active_high_poison(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(56 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.intr.bswap(%arg0)  : (vector<2xi64>) -> vector<2xi64>
    %8 = llvm.lshr %7, %6  : vector<2xi64>
    llvm.return %8 : vector<2xi64>
  }]

theorem inst_combine_bs_active_high_poison   : bs_active_high_poison_before  ⊑  bs_active_high_poison_combined := by
  unfold bs_active_high_poison_before bs_active_high_poison_combined
  simp_alive_peephole
  sorry
def bs_active_high8_multiuse_combined := [llvmfunc|
  llvm.func @bs_active_high8_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(56 : i64) : i64
    %1 = llvm.mlir.constant(255 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.and %arg0, %1  : i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_bs_active_high8_multiuse   : bs_active_high8_multiuse_before  ⊑  bs_active_high8_multiuse_combined := by
  unfold bs_active_high8_multiuse_before bs_active_high8_multiuse_combined
  simp_alive_peephole
  sorry
def bs_active_high7_multiuse_combined := [llvmfunc|
  llvm.func @bs_active_high7_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(57 : i64) : i64
    %1 = llvm.mlir.constant(56 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.lshr %2, %1  : i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_bs_active_high7_multiuse   : bs_active_high7_multiuse_before  ⊑  bs_active_high7_multiuse_combined := by
  unfold bs_active_high7_multiuse_before bs_active_high7_multiuse_combined
  simp_alive_peephole
  sorry
def bs_active_byte_6h_combined := [llvmfunc|
  llvm.func @bs_active_byte_6h(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.constant(16711680 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_bs_active_byte_6h   : bs_active_byte_6h_before  ⊑  bs_active_byte_6h_combined := by
  unfold bs_active_byte_6h_before bs_active_byte_6h_combined
  simp_alive_peephole
  sorry
def bs_active_byte_3h_combined := [llvmfunc|
  llvm.func @bs_active_byte_3h(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(1536 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_bs_active_byte_3h   : bs_active_byte_3h_before  ⊑  bs_active_byte_3h_combined := by
  unfold bs_active_byte_3h_before bs_active_byte_3h_combined
  simp_alive_peephole
  sorry
def bs_active_byte_3h_v2_combined := [llvmfunc|
  llvm.func @bs_active_byte_3h_v2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8388608, 65536]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_bs_active_byte_3h_v2   : bs_active_byte_3h_v2_before  ⊑  bs_active_byte_3h_v2_combined := by
  unfold bs_active_byte_3h_v2_before bs_active_byte_3h_v2_combined
  simp_alive_peephole
  sorry
def bs_active_byte_78h_combined := [llvmfunc|
  llvm.func @bs_active_byte_78h(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(108086391056891904 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_bs_active_byte_78h   : bs_active_byte_78h_before  ⊑  bs_active_byte_78h_combined := by
  unfold bs_active_byte_78h_before bs_active_byte_78h_combined
  simp_alive_peephole
  sorry
def bs_active_low1_combined := [llvmfunc|
  llvm.func @bs_active_low1(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(256 : i16) : i16
    %2 = llvm.lshr %arg0, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_bs_active_low1   : bs_active_low1_before  ⊑  bs_active_low1_combined := by
  unfold bs_active_low1_before bs_active_low1_combined
  simp_alive_peephole
  sorry
def bs_active_low8_combined := [llvmfunc|
  llvm.func @bs_active_low8(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_bs_active_low8   : bs_active_low8_before  ⊑  bs_active_low8_combined := by
  unfold bs_active_low8_before bs_active_low8_combined
  simp_alive_peephole
  sorry
def bs_active_low_different_combined := [llvmfunc|
  llvm.func @bs_active_low_different(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 128]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.shl %2, %1 overflow<nuw>  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_bs_active_low_different   : bs_active_low_different_before  ⊑  bs_active_low_different_combined := by
  unfold bs_active_low_different_before bs_active_low_different_combined
  simp_alive_peephole
  sorry
def bs_active_low_different_negative_combined := [llvmfunc|
  llvm.func @bs_active_low_different_negative(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[256, 255]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_bs_active_low_different_negative   : bs_active_low_different_negative_before  ⊑  bs_active_low_different_negative_combined := by
  unfold bs_active_low_different_negative_before bs_active_low_different_negative_combined
  simp_alive_peephole
  sorry
def bs_active_low_undef_combined := [llvmfunc|
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
  }]

theorem inst_combine_bs_active_low_undef   : bs_active_low_undef_before  ⊑  bs_active_low_undef_combined := by
  unfold bs_active_low_undef_before bs_active_low_undef_combined
  simp_alive_peephole
  sorry
def bs_active_low8_multiuse_combined := [llvmfunc|
  llvm.func @bs_active_low8_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.mlir.constant(56 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.shl %2, %1 overflow<nuw>  : i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_bs_active_low8_multiuse   : bs_active_low8_multiuse_before  ⊑  bs_active_low8_multiuse_combined := by
  unfold bs_active_low8_multiuse_before bs_active_low8_multiuse_combined
  simp_alive_peephole
  sorry
def bs_active_low7_multiuse_combined := [llvmfunc|
  llvm.func @bs_active_low7_multiuse(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(127 : i64) : i64
    %1 = llvm.mlir.constant(56 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : i64
    %4 = llvm.mul %2, %3  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_bs_active_low7_multiuse   : bs_active_low7_multiuse_before  ⊑  bs_active_low7_multiuse_combined := by
  unfold bs_active_low7_multiuse_before bs_active_low7_multiuse_combined
  simp_alive_peephole
  sorry
def bs_active_byte_4l_combined := [llvmfunc|
  llvm.func @bs_active_byte_4l(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(292057776128 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_bs_active_byte_4l   : bs_active_byte_4l_before  ⊑  bs_active_byte_4l_combined := by
  unfold bs_active_byte_4l_before bs_active_byte_4l_combined
  simp_alive_peephole
  sorry
def bs_active_byte_2l_combined := [llvmfunc|
  llvm.func @bs_active_byte_2l(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16711680 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_bs_active_byte_2l   : bs_active_byte_2l_before  ⊑  bs_active_byte_2l_combined := by
  unfold bs_active_byte_2l_before bs_active_byte_2l_combined
  simp_alive_peephole
  sorry
def bs_active_byte_2l_v2_combined := [llvmfunc|
  llvm.func @bs_active_byte_2l_v2(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[256, 65280]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<40> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.and %arg0, %0  : vector<2xi64>
    %3 = llvm.shl %2, %1 overflow<nsw, nuw>  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_bs_active_byte_2l_v2   : bs_active_byte_2l_v2_before  ⊑  bs_active_byte_2l_v2_combined := by
  unfold bs_active_byte_2l_v2_before bs_active_byte_2l_v2_combined
  simp_alive_peephole
  sorry
def bs_active_byte_12l_combined := [llvmfunc|
  llvm.func @bs_active_byte_12l(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(384 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.intr.bswap(%1)  : (i64) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_bs_active_byte_12l   : bs_active_byte_12l_before  ⊑  bs_active_byte_12l_combined := by
  unfold bs_active_byte_12l_before bs_active_byte_12l_combined
  simp_alive_peephole
  sorry
