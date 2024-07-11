import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  readnone-maythrow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_0_before := [llvmfunc|
  llvm.func @f_0(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.call @readnone_but_may_throw() : () -> ()
    llvm.store %1, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def f_1_before := [llvmfunc|
  llvm.func @f_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.call @readnone_but_may_throw() : () -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }]

def f_0_combined := [llvmfunc|
  llvm.func @f_0(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_f_0   : f_0_before  ⊑  f_0_combined := by
  unfold f_0_before f_0_combined
  simp_alive_peephole
  sorry
    llvm.call @readnone_but_may_throw() : () -> ()
    llvm.store %1, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_f_0   : f_0_before  ⊑  f_0_combined := by
  unfold f_0_before f_0_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_f_0   : f_0_before  ⊑  f_0_combined := by
  unfold f_0_before f_0_combined
  simp_alive_peephole
  sorry
def f_1_combined := [llvmfunc|
  llvm.func @f_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_f_1   : f_1_before  ⊑  f_1_combined := by
  unfold f_1_before f_1_combined
  simp_alive_peephole
  sorry
    llvm.call @readnone_but_may_throw() : () -> ()
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_f_1   : f_1_before  ⊑  f_1_combined := by
  unfold f_1_before f_1_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }]

theorem inst_combine_f_1   : f_1_before  ⊑  f_1_combined := by
  unfold f_1_before f_1_combined
  simp_alive_peephole
  sorry
