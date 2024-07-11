import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vec_udiv_to_shift
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def udiv_vec8x16_before := [llvmfunc|
  llvm.func @udiv_vec8x16(%arg0: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<32> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.udiv %arg0, %0  : vector<8xi16>
    llvm.return %1 : vector<8xi16>
  }]

def udiv_vec4x32_before := [llvmfunc|
  llvm.func @udiv_vec4x32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<16> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def udiv_vec8x16_combined := [llvmfunc|
  llvm.func @udiv_vec8x16(%arg0: vector<8xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(dense<5> : vector<8xi16>) : vector<8xi16>
    %1 = llvm.lshr %arg0, %0  : vector<8xi16>
    llvm.return %1 : vector<8xi16>
  }]

theorem inst_combine_udiv_vec8x16   : udiv_vec8x16_before  ⊑  udiv_vec8x16_combined := by
  unfold udiv_vec8x16_before udiv_vec8x16_combined
  simp_alive_peephole
  sorry
def udiv_vec4x32_combined := [llvmfunc|
  llvm.func @udiv_vec4x32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_udiv_vec4x32   : udiv_vec4x32_before  ⊑  udiv_vec4x32_combined := by
  unfold udiv_vec4x32_before udiv_vec4x32_combined
  simp_alive_peephole
  sorry
