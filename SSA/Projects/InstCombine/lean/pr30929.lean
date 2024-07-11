import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr30929
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.call @acosf(%0) : (f32) -> f32
    llvm.return
  }]

def main_combined := [llvmfunc|
  llvm.func @main() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.cond_br %0 weights([1, 2000]), ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.call @acosf(%1) : (f32) -> f32
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
