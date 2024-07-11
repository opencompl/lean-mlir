import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sink-alloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i32) {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.call @cond() : () -> i1
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.alloca %arg0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.intr.stacksave : !llvm.ptr
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.call @use_and_return(%2) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %0, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.intr.stackrestore %3 : !llvm.ptr
    %6 = llvm.call @use_and_return(%5) : (!llvm.ptr) -> !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i32) {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.call @cond() : () -> i1
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.alloca %arg0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.intr.stacksave : !llvm.ptr
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.call @use_and_return(%2) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %0, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.intr.stackrestore %3 : !llvm.ptr
    %6 = llvm.call @use_and_return(%5) : (!llvm.ptr) -> !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
