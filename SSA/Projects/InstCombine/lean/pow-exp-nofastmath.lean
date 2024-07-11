import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow-exp-nofastmath
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mypow_before := [llvmfunc|
  llvm.func @mypow(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) : (f64) -> f64
    %1 = llvm.intr.pow(%0, %arg1)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def mypow_combined := [llvmfunc|
  llvm.func @mypow(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) : (f64) -> f64
    %1 = llvm.intr.pow(%0, %arg1)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_mypow   : mypow_before  ⊑  mypow_combined := by
  unfold mypow_before mypow_combined
  simp_alive_peephole
  sorry
