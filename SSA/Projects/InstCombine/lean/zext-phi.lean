import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  zext-phi
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sink_i1_casts_before := [llvmfunc|
  llvm.func @sink_i1_casts(%arg0: i1, %arg1: i1) -> i64 {
    %0 = llvm.zext %arg0 : i1 to i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i64)
  ^bb1:  // pred: ^bb0
    %1 = llvm.zext %arg1 : i1 to i64
    llvm.br ^bb2(%1 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }]

def sink_i1_casts_combined := [llvmfunc|
  llvm.func @sink_i1_casts(%arg0: i1, %arg1: i1) -> i64 {
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg0 : i1)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : i1)
  ^bb2(%0: i1):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.zext %0 : i1 to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_sink_i1_casts   : sink_i1_casts_before  ⊑  sink_i1_casts_combined := by
  unfold sink_i1_casts_before sink_i1_casts_combined
  simp_alive_peephole
  sorry
