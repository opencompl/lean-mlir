import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fmul-bool
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fmul_bool_before := [llvmfunc|
  llvm.func @fmul_bool(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.uitofp %arg1 : i1 to f32
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    llvm.return %1 : f32
  }]

def fmul_bool_vec_before := [llvmfunc|
  llvm.func @fmul_bool_vec(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.uitofp %arg1 : vector<2xi1> to vector<2xf32>
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def fmul_bool_vec_commute_before := [llvmfunc|
  llvm.func @fmul_bool_vec_commute(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>]

    %1 = llvm.uitofp %arg1 : vector<2xi1> to vector<2xf32>
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fmul_bool_combined := [llvmfunc|
  llvm.func @fmul_bool(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.uitofp %arg1 : i1 to f32
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

theorem inst_combine_fmul_bool   : fmul_bool_before  ⊑  fmul_bool_combined := by
  unfold fmul_bool_before fmul_bool_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_fmul_bool   : fmul_bool_before  ⊑  fmul_bool_combined := by
  unfold fmul_bool_before fmul_bool_combined
  simp_alive_peephole
  sorry
def fmul_bool_vec_combined := [llvmfunc|
  llvm.func @fmul_bool_vec(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.uitofp %arg1 : vector<2xi1> to vector<2xf32>
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>]

theorem inst_combine_fmul_bool_vec   : fmul_bool_vec_before  ⊑  fmul_bool_vec_combined := by
  unfold fmul_bool_vec_before fmul_bool_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fmul_bool_vec   : fmul_bool_vec_before  ⊑  fmul_bool_vec_combined := by
  unfold fmul_bool_vec_before fmul_bool_vec_combined
  simp_alive_peephole
  sorry
def fmul_bool_vec_commute_combined := [llvmfunc|
  llvm.func @fmul_bool_vec_commute(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>]

theorem inst_combine_fmul_bool_vec_commute   : fmul_bool_vec_commute_before  ⊑  fmul_bool_vec_commute_combined := by
  unfold fmul_bool_vec_commute_before fmul_bool_vec_commute_combined
  simp_alive_peephole
  sorry
    %1 = llvm.uitofp %arg1 : vector<2xi1> to vector<2xf32>
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>]

theorem inst_combine_fmul_bool_vec_commute   : fmul_bool_vec_commute_before  ⊑  fmul_bool_vec_commute_combined := by
  unfold fmul_bool_vec_commute_before fmul_bool_vec_commute_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fmul_bool_vec_commute   : fmul_bool_vec_commute_before  ⊑  fmul_bool_vec_commute_combined := by
  unfold fmul_bool_vec_commute_before fmul_bool_vec_commute_combined
  simp_alive_peephole
  sorry
