import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  hoist_instr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.sdiv %2, %1  : i32
    llvm.return %3 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sdiv %arg1, %1  : i32
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
