import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitcast-bigendian
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: vector<2xf32>, %arg1: vector<2xi32>) -> f32 {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %1 = llvm.trunc %0 : i64 to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.bitcast %arg1 : vector<2xi32> to i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.bitcast %4 : i32 to f32
    %6 = llvm.fadd %2, %5  : f32
    llvm.return %6 : f32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: vector<2xf32>, %arg1: vector<2xi64>) -> f32 {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(64 : i128) : i128
    %2 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %3 = llvm.lshr %2, %0  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.bitcast %4 : i32 to f32
    %6 = llvm.bitcast %arg1 : vector<2xi64> to i128
    %7 = llvm.lshr %6, %1  : i128
    %8 = llvm.trunc %7 : i128 to i32
    %9 = llvm.bitcast %8 : i32 to f32
    %10 = llvm.fadd %5, %9  : f32
    llvm.return %10 : f32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> vector<2xi32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.zext %arg1 : i32 to i64
    %3 = llvm.shl %2, %0  : i64
    %4 = llvm.or %3, %1  : i64
    %5 = llvm.bitcast %4 : i64 to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: f32, %arg1: f32) -> vector<2xf32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.bitcast %arg1 : f32 to i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.shl %4, %0  : i64
    %6 = llvm.or %5, %2  : i64
    %7 = llvm.bitcast %6 : i64 to vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(1109917696 : i64) : i64
    %2 = llvm.bitcast %arg0 : f32 to i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.shl %3, %0  : i64
    %5 = llvm.or %4, %1  : i64
    %6 = llvm.bitcast %5 : i64 to vector<2xf32>
    llvm.return %6 : vector<2xf32>
  }]

def xor_bitcast_vec_to_vec_before := [llvmfunc|
  llvm.func @xor_bitcast_vec_to_vec(%arg0: vector<1xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<1xi64> to vector<2xi32>
    %2 = llvm.xor %0, %1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def and_bitcast_vec_to_int_before := [llvmfunc|
  llvm.func @and_bitcast_vec_to_int(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xi32> to i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }]

def or_bitcast_int_to_vec_before := [llvmfunc|
  llvm.func @or_bitcast_int_to_vec(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %2 = llvm.or %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: vector<2xf32>, %arg1: vector<2xi32>) -> f32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<2xf32>
    %2 = llvm.bitcast %arg1 : vector<2xi32> to vector<2xf32>
    %3 = llvm.extractelement %2[%0 : i64] : vector<2xf32>
    %4 = llvm.fadd %1, %3  : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: vector<2xf32>, %arg1: vector<2xi64>) -> f32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.extractelement %arg0[%0 : i64] : vector<2xf32>
    %3 = llvm.bitcast %arg1 : vector<2xi64> to vector<4xf32>
    %4 = llvm.extractelement %3[%1 : i64] : vector<4xf32>
    %5 = llvm.fadd %2, %4  : f32
    llvm.return %5 : f32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xi32>
    %4 = llvm.insertelement %arg0, %3[%2 : i64] : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: f32, %arg1: f32) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf32>
    %4 = llvm.insertelement %arg0, %3[%2 : i64] : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: f32) -> vector<2xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.insertelement %arg0, %6[%7 : i64] : vector<2xf32>
    llvm.return %8 : vector<2xf32>
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def xor_bitcast_vec_to_vec_combined := [llvmfunc|
  llvm.func @xor_bitcast_vec_to_vec(%arg0: vector<1xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : vector<1xi64> to vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_xor_bitcast_vec_to_vec   : xor_bitcast_vec_to_vec_before  ⊑  xor_bitcast_vec_to_vec_combined := by
  unfold xor_bitcast_vec_to_vec_before xor_bitcast_vec_to_vec_combined
  simp_alive_peephole
  sorry
def and_bitcast_vec_to_int_combined := [llvmfunc|
  llvm.func @and_bitcast_vec_to_int(%arg0: vector<2xi32>) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xi32> to i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_and_bitcast_vec_to_int   : and_bitcast_vec_to_int_before  ⊑  and_bitcast_vec_to_int_combined := by
  unfold and_bitcast_vec_to_int_before and_bitcast_vec_to_int_combined
  simp_alive_peephole
  sorry
def or_bitcast_int_to_vec_combined := [llvmfunc|
  llvm.func @or_bitcast_int_to_vec(%arg0: i64) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.bitcast %arg0 : i64 to vector<2xi32>
    %2 = llvm.or %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_or_bitcast_int_to_vec   : or_bitcast_int_to_vec_before  ⊑  or_bitcast_int_to_vec_combined := by
  unfold or_bitcast_int_to_vec_before or_bitcast_int_to_vec_combined
  simp_alive_peephole
  sorry
