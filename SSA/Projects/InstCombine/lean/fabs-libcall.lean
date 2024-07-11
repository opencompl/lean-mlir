import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fabs-libcall
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def replace_fabs_call_f80_before := [llvmfunc|
  llvm.func @replace_fabs_call_f80(%arg0: f80) -> f80 {
    %0 = llvm.call @fabsl(%arg0) : (f80) -> f80
    llvm.return %0 : f80
  }]

def fmf_replace_fabs_call_f80_before := [llvmfunc|
  llvm.func @fmf_replace_fabs_call_f80(%arg0: f80) -> f80 {
    %0 = llvm.call @fabsl(%arg0) {fastmathFlags = #llvm.fastmath<nnan>} : (f80) -> f80]

    llvm.return %0 : f80
  }]

def replace_fabs_call_f80_combined := [llvmfunc|
  llvm.func @replace_fabs_call_f80(%arg0: f80) -> f80 {
    %0 = llvm.intr.fabs(%arg0)  : (f80) -> f80
    llvm.return %0 : f80
  }]

theorem inst_combine_replace_fabs_call_f80   : replace_fabs_call_f80_before  ⊑  replace_fabs_call_f80_combined := by
  unfold replace_fabs_call_f80_before replace_fabs_call_f80_combined
  simp_alive_peephole
  sorry
def fmf_replace_fabs_call_f80_combined := [llvmfunc|
  llvm.func @fmf_replace_fabs_call_f80(%arg0: f80) -> f80 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f80) -> f80]

theorem inst_combine_fmf_replace_fabs_call_f80   : fmf_replace_fabs_call_f80_before  ⊑  fmf_replace_fabs_call_f80_combined := by
  unfold fmf_replace_fabs_call_f80_before fmf_replace_fabs_call_f80_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f80
  }]

theorem inst_combine_fmf_replace_fabs_call_f80   : fmf_replace_fabs_call_f80_before  ⊑  fmf_replace_fabs_call_f80_combined := by
  unfold fmf_replace_fabs_call_f80_before fmf_replace_fabs_call_f80_combined
  simp_alive_peephole
  sorry
