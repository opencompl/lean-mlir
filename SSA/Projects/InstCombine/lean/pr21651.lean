import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr21651
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR21651_before := [llvmfunc|
  llvm.func @PR21651() {
    %0 = llvm.mlir.constant(0 : i2) : i2
    llvm.switch %0 : i2, ^bb1 [
      0: ^bb1,
      1: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return
  }]

def PR21651_combined := [llvmfunc|
  llvm.func @PR21651() {
    %0 = llvm.mlir.constant(false) : i1
    llvm.switch %0 : i1, ^bb1 [
      0: ^bb1,
      1: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return
  }]

theorem inst_combine_PR21651   : PR21651_before  ⊑  PR21651_combined := by
  unfold PR21651_before PR21651_combined
  simp_alive_peephole
  sorry
