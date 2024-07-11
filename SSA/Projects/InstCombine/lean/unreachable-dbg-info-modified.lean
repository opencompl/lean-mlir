import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unreachable-dbg-info-modified
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.undef : i32
    llvm.intr.dbg.value #di_local_variable = %1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.undef : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
