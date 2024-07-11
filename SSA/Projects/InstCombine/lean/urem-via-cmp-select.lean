import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  urem-via-cmp-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def urem_assume_before := [llvmfunc|
  llvm.func @urem_assume(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }]

def urem_assume_without_nuw_before := [llvmfunc|
  llvm.func @urem_assume_without_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }]

def urem_assume_eq_before := [llvmfunc|
  llvm.func @urem_assume_eq(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }]

def urem_assume_ne_before := [llvmfunc|
  llvm.func @urem_assume_ne(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }]

def urem_assume_with_unexpected_const_before := [llvmfunc|
  llvm.func @urem_assume_with_unexpected_const(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }]

def urem_without_assume_before := [llvmfunc|
  llvm.func @urem_without_assume(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.urem %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }]

def urem_with_dominating_condition_before := [llvmfunc|
  llvm.func @urem_with_dominating_condition(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %1  : i8
    %4 = llvm.urem %3, %arg1  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i8
  }]

def urem_with_dominating_condition_false_before := [llvmfunc|
  llvm.func @urem_with_dominating_condition_false(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.urem %3, %arg1  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }]

def urem_with_opposite_condition(%arg0: i8, %arg1: i8) -> _before := [llvmfunc|
  llvm.func @urem_with_opposite_condition(%arg0: i8, %arg1: i8) -> (i8 {llvm.noundef}) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.urem %3, %arg1  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }]

def urem_assume_combined := [llvmfunc|
  llvm.func @urem_assume(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.freeze %arg0 : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.add %2, %0  : i8
    %5 = llvm.icmp "eq" %4, %arg1 : i8
    %6 = llvm.select %5, %1, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_urem_assume   : urem_assume_before  ⊑  urem_assume_combined := by
  unfold urem_assume_before urem_assume_combined
  simp_alive_peephole
  sorry
def urem_assume_without_nuw_combined := [llvmfunc|
  llvm.func @urem_assume_without_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.freeze %arg0 : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.add %2, %0  : i8
    %5 = llvm.icmp "eq" %4, %arg1 : i8
    %6 = llvm.select %5, %1, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_urem_assume_without_nuw   : urem_assume_without_nuw_before  ⊑  urem_assume_without_nuw_combined := by
  unfold urem_assume_without_nuw_before urem_assume_without_nuw_combined
  simp_alive_peephole
  sorry
def urem_assume_eq_combined := [llvmfunc|
  llvm.func @urem_assume_eq(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_urem_assume_eq   : urem_assume_eq_before  ⊑  urem_assume_eq_combined := by
  unfold urem_assume_eq_before urem_assume_eq_combined
  simp_alive_peephole
  sorry
def urem_assume_ne_combined := [llvmfunc|
  llvm.func @urem_assume_ne(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_urem_assume_ne   : urem_assume_ne_before  ⊑  urem_assume_ne_combined := by
  unfold urem_assume_ne_before urem_assume_ne_combined
  simp_alive_peephole
  sorry
def urem_assume_with_unexpected_const_combined := [llvmfunc|
  llvm.func @urem_assume_with_unexpected_const(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.urem %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_urem_assume_with_unexpected_const   : urem_assume_with_unexpected_const_before  ⊑  urem_assume_with_unexpected_const_combined := by
  unfold urem_assume_with_unexpected_const_before urem_assume_with_unexpected_const_combined
  simp_alive_peephole
  sorry
def urem_without_assume_combined := [llvmfunc|
  llvm.func @urem_without_assume(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.urem %arg0, %arg1  : i8
    %3 = llvm.freeze %2 : i8
    %4 = llvm.add %3, %0  : i8
    %5 = llvm.icmp "eq" %4, %arg1 : i8
    %6 = llvm.select %5, %1, %4 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_urem_without_assume   : urem_without_assume_before  ⊑  urem_without_assume_combined := by
  unfold urem_without_assume_before urem_without_assume_combined
  simp_alive_peephole
  sorry
def urem_with_dominating_condition_combined := [llvmfunc|
  llvm.func @urem_with_dominating_condition(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.freeze %arg0 : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.icmp "eq" %4, %arg1 : i8
    %6 = llvm.select %5, %0, %4 : i1, i8
    llvm.return %6 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i8
  }]

theorem inst_combine_urem_with_dominating_condition   : urem_with_dominating_condition_before  ⊑  urem_with_dominating_condition_combined := by
  unfold urem_with_dominating_condition_before urem_with_dominating_condition_combined
  simp_alive_peephole
  sorry
def urem_with_dominating_condition_false_combined := [llvmfunc|
  llvm.func @urem_with_dominating_condition_false(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.freeze %arg0 : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %2, %1  : i8
    %5 = llvm.icmp "eq" %4, %arg1 : i8
    %6 = llvm.select %5, %0, %4 : i1, i8
    llvm.return %6 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i8
  }]

theorem inst_combine_urem_with_dominating_condition_false   : urem_with_dominating_condition_false_before  ⊑  urem_with_dominating_condition_false_combined := by
  unfold urem_with_dominating_condition_false_before urem_with_dominating_condition_false_combined
  simp_alive_peephole
  sorry
def urem_with_opposite_condition(%arg0: i8, %arg1: i8) -> _combined := [llvmfunc|
  llvm.func @urem_with_opposite_condition(%arg0: i8, %arg1: i8) -> (i8 {llvm.noundef}) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.urem %3, %arg1  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }]

theorem inst_combine_urem_with_opposite_condition(%arg0: i8, %arg1: i8) ->    : urem_with_opposite_condition(%arg0: i8, %arg1: i8) -> _before  ⊑  urem_with_opposite_condition(%arg0: i8, %arg1: i8) -> _combined := by
  unfold urem_with_opposite_condition(%arg0: i8, %arg1: i8) -> _before urem_with_opposite_condition(%arg0: i8, %arg1: i8) -> _combined
  simp_alive_peephole
  sorry
