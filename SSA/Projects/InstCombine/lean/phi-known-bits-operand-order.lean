import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-known-bits-operand-order
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def phi_recurrence_start_first_before := [llvmfunc|
  llvm.func @phi_recurrence_start_first() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(99 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb4
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %5 = llvm.add %3, %1 overflow<nsw>  : i32
    llvm.cond_br %4, ^bb3(%5 : i32), ^bb4
  ^bb3(%6: i32):  // 2 preds: ^bb2, ^bb3
    %7 = llvm.icmp "sle" %6, %2 : i32
    %8 = llvm.add %6, %1 overflow<nsw>  : i32
    llvm.cond_br %7, ^bb3(%8 : i32), ^bb5
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%5 : i32)
  ^bb5:  // 2 preds: ^bb1, ^bb3
    llvm.return
  }]

def phi_recurrence_step_first_before := [llvmfunc|
  llvm.func @phi_recurrence_step_first() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(99 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb4
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %5 = llvm.add %3, %1 overflow<nsw>  : i32
    llvm.cond_br %4, ^bb3(%5 : i32), ^bb4
  ^bb3(%6: i32):  // 2 preds: ^bb2, ^bb3
    %7 = llvm.icmp "sle" %6, %2 : i32
    %8 = llvm.add %6, %1 overflow<nsw>  : i32
    llvm.cond_br %7, ^bb3(%8 : i32), ^bb5
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%5 : i32)
  ^bb5:  // 2 preds: ^bb1, ^bb3
    llvm.return
  }]

def phi_recurrence_start_first_combined := [llvmfunc|
  llvm.func @phi_recurrence_start_first() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb4
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %5 = llvm.add %3, %1 overflow<nsw, nuw>  : i32
    llvm.cond_br %4, ^bb3(%5 : i32), ^bb4
  ^bb3(%6: i32):  // 2 preds: ^bb2, ^bb3
    %7 = llvm.icmp "ult" %6, %2 : i32
    %8 = llvm.add %6, %1 overflow<nsw, nuw>  : i32
    llvm.cond_br %7, ^bb3(%8 : i32), ^bb5
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%5 : i32)
  ^bb5:  // 2 preds: ^bb1, ^bb3
    llvm.return
  }]

theorem inst_combine_phi_recurrence_start_first   : phi_recurrence_start_first_before  ⊑  phi_recurrence_start_first_combined := by
  unfold phi_recurrence_start_first_before phi_recurrence_start_first_combined
  simp_alive_peephole
  sorry
def phi_recurrence_step_first_combined := [llvmfunc|
  llvm.func @phi_recurrence_step_first() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb4
    %4 = llvm.call @cond() : () -> i1
    llvm.cond_br %4, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %5 = llvm.add %3, %1 overflow<nsw, nuw>  : i32
    llvm.cond_br %4, ^bb3(%5 : i32), ^bb4
  ^bb3(%6: i32):  // 2 preds: ^bb2, ^bb3
    %7 = llvm.icmp "ult" %6, %2 : i32
    %8 = llvm.add %6, %1 overflow<nsw, nuw>  : i32
    llvm.cond_br %7, ^bb3(%8 : i32), ^bb5
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%5 : i32)
  ^bb5:  // 2 preds: ^bb1, ^bb3
    llvm.return
  }]

theorem inst_combine_phi_recurrence_step_first   : phi_recurrence_step_first_before  ⊑  phi_recurrence_step_first_combined := by
  unfold phi_recurrence_step_first_before phi_recurrence_step_first_combined
  simp_alive_peephole
  sorry
