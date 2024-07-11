import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-dom
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def idom_sign_bit_check_edge_dominates_before := [llvmfunc|
  llvm.func @idom_sign_bit_check_edge_dominates(%arg0: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4
  ^bb2:  // pred: ^bb0
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return
  }]

def idom_sign_bit_check_edge_not_dominates_before := [llvmfunc|
  llvm.func @idom_sign_bit_check_edge_not_dominates(%arg0: i64, %arg1: i1) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4, ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return
  }]

def idom_sign_bit_check_edge_dominates_select_before := [llvmfunc|
  llvm.func @idom_sign_bit_check_edge_dominates_select(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4
  ^bb2:  // pred: ^bb0
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    %3 = llvm.select %2, %arg0, %0 : i1, i64
    %4 = llvm.icmp "ne" %3, %arg1 : i64
    llvm.cond_br %4, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return
  }]

def idom_zbranch_before := [llvmfunc|
  llvm.func @idom_zbranch(%arg0: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

def idom_not_zbranch_before := [llvmfunc|
  llvm.func @idom_not_zbranch(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    %4 = llvm.icmp "ne" %3, %arg1 : i32
    llvm.cond_br %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

def trueblock_cmp_eq_before := [llvmfunc|
  llvm.func @trueblock_cmp_eq(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

def trueblock_cmp_is_false_before := [llvmfunc|
  llvm.func @trueblock_cmp_is_false(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }]

def trueblock_cmp_is_false_commute_before := [llvmfunc|
  llvm.func @trueblock_cmp_is_false_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i32
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }]

def trueblock_cmp_is_true_before := [llvmfunc|
  llvm.func @trueblock_cmp_is_true(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }]

def trueblock_cmp_is_true_commute_before := [llvmfunc|
  llvm.func @trueblock_cmp_is_true_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.icmp "ne" %arg1, %arg0 : i32
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }]

def falseblock_cmp_is_false_before := [llvmfunc|
  llvm.func @falseblock_cmp_is_false(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.return %1 : i1
  }]

def falseblock_cmp_is_false_commute_before := [llvmfunc|
  llvm.func @falseblock_cmp_is_false_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "eq" %arg1, %arg0 : i32
    llvm.return %1 : i1
  }]

def falseblock_cmp_is_true_before := [llvmfunc|
  llvm.func @falseblock_cmp_is_true(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.return %1 : i1
  }]

def falseblock_cmp_is_true_commute_before := [llvmfunc|
  llvm.func @falseblock_cmp_is_true_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    %1 = llvm.icmp "sge" %arg1, %arg0 : i32
    llvm.return %1 : i1
  }]

def PR48900_before := [llvmfunc|
  llvm.func @PR48900(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg0, %0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.icmp "ult" %4, %2 : i32
    %7 = llvm.select %6, %4, %2 : i1, i32
    llvm.return %7 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

def PR48900_alt_before := [llvmfunc|
  llvm.func @PR48900_alt(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(-126 : i8) : i8
    %4 = llvm.icmp "sgt" %arg0, %0 : i8
    %5 = llvm.select %4, %arg0, %0 : i1, i8
    %6 = llvm.icmp "ugt" %5, %1 : i8
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.icmp "slt" %5, %3 : i8
    %8 = llvm.select %7, %5, %3 : i1, i8
    llvm.return %8 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i8
  }]

def and_mask1_eq_before := [llvmfunc|
  llvm.func @and_mask1_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }]

def and_mask1_ne_before := [llvmfunc|
  llvm.func @and_mask1_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    llvm.return %7 : i1
  }]

def and_mask2_before := [llvmfunc|
  llvm.func @and_mask2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }]

def and_mask3_before := [llvmfunc|
  llvm.func @and_mask3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }]

def and_mask4_before := [llvmfunc|
  llvm.func @and_mask4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }]

def idom_sign_bit_check_edge_dominates_combined := [llvmfunc|
  llvm.func @idom_sign_bit_check_edge_dominates(%arg0: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4
  ^bb2:  // pred: ^bb0
    %2 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.cond_br %2, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return
  }]

theorem inst_combine_idom_sign_bit_check_edge_dominates   : idom_sign_bit_check_edge_dominates_before  ⊑  idom_sign_bit_check_edge_dominates_combined := by
  unfold idom_sign_bit_check_edge_dominates_before idom_sign_bit_check_edge_dominates_combined
  simp_alive_peephole
  sorry
def idom_sign_bit_check_edge_not_dominates_combined := [llvmfunc|
  llvm.func @idom_sign_bit_check_edge_not_dominates(%arg0: i64, %arg1: i1) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4, ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %2 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return
  }]

theorem inst_combine_idom_sign_bit_check_edge_not_dominates   : idom_sign_bit_check_edge_not_dominates_before  ⊑  idom_sign_bit_check_edge_not_dominates_combined := by
  unfold idom_sign_bit_check_edge_not_dominates_before idom_sign_bit_check_edge_not_dominates_combined
  simp_alive_peephole
  sorry
def idom_sign_bit_check_edge_dominates_select_combined := [llvmfunc|
  llvm.func @idom_sign_bit_check_edge_dominates_select(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4
  ^bb2:  // pred: ^bb0
    %2 = llvm.icmp "eq" %arg0, %arg1 : i64
    llvm.cond_br %2, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return
  }]

theorem inst_combine_idom_sign_bit_check_edge_dominates_select   : idom_sign_bit_check_edge_dominates_select_before  ⊑  idom_sign_bit_check_edge_dominates_select_combined := by
  unfold idom_sign_bit_check_edge_dominates_select_before idom_sign_bit_check_edge_dominates_select_combined
  simp_alive_peephole
  sorry
def idom_zbranch_combined := [llvmfunc|
  llvm.func @idom_zbranch(%arg0: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

theorem inst_combine_idom_zbranch   : idom_zbranch_before  ⊑  idom_zbranch_combined := by
  unfold idom_zbranch_before idom_zbranch_combined
  simp_alive_peephole
  sorry
def idom_not_zbranch_combined := [llvmfunc|
  llvm.func @idom_not_zbranch(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %1, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %2, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

theorem inst_combine_idom_not_zbranch   : idom_not_zbranch_before  ⊑  idom_not_zbranch_combined := by
  unfold idom_not_zbranch_before idom_not_zbranch_combined
  simp_alive_peephole
  sorry
def trueblock_cmp_eq_combined := [llvmfunc|
  llvm.func @trueblock_cmp_eq(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return
  }]

theorem inst_combine_trueblock_cmp_eq   : trueblock_cmp_eq_before  ⊑  trueblock_cmp_eq_combined := by
  unfold trueblock_cmp_eq_before trueblock_cmp_eq_combined
  simp_alive_peephole
  sorry
def trueblock_cmp_is_false_combined := [llvmfunc|
  llvm.func @trueblock_cmp_is_false(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_trueblock_cmp_is_false   : trueblock_cmp_is_false_before  ⊑  trueblock_cmp_is_false_combined := by
  unfold trueblock_cmp_is_false_before trueblock_cmp_is_false_combined
  simp_alive_peephole
  sorry
def trueblock_cmp_is_false_commute_combined := [llvmfunc|
  llvm.func @trueblock_cmp_is_false_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_trueblock_cmp_is_false_commute   : trueblock_cmp_is_false_commute_before  ⊑  trueblock_cmp_is_false_commute_combined := by
  unfold trueblock_cmp_is_false_commute_before trueblock_cmp_is_false_commute_combined
  simp_alive_peephole
  sorry
def trueblock_cmp_is_true_combined := [llvmfunc|
  llvm.func @trueblock_cmp_is_true(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_trueblock_cmp_is_true   : trueblock_cmp_is_true_before  ⊑  trueblock_cmp_is_true_combined := by
  unfold trueblock_cmp_is_true_before trueblock_cmp_is_true_combined
  simp_alive_peephole
  sorry
def trueblock_cmp_is_true_commute_combined := [llvmfunc|
  llvm.func @trueblock_cmp_is_true_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_trueblock_cmp_is_true_commute   : trueblock_cmp_is_true_commute_before  ⊑  trueblock_cmp_is_true_commute_combined := by
  unfold trueblock_cmp_is_true_commute_before trueblock_cmp_is_true_commute_combined
  simp_alive_peephole
  sorry
def falseblock_cmp_is_false_combined := [llvmfunc|
  llvm.func @falseblock_cmp_is_false(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }]

theorem inst_combine_falseblock_cmp_is_false   : falseblock_cmp_is_false_before  ⊑  falseblock_cmp_is_false_combined := by
  unfold falseblock_cmp_is_false_before falseblock_cmp_is_false_combined
  simp_alive_peephole
  sorry
def falseblock_cmp_is_false_commute_combined := [llvmfunc|
  llvm.func @falseblock_cmp_is_false_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }]

theorem inst_combine_falseblock_cmp_is_false_commute   : falseblock_cmp_is_false_commute_before  ⊑  falseblock_cmp_is_false_commute_combined := by
  unfold falseblock_cmp_is_false_commute_before falseblock_cmp_is_false_commute_combined
  simp_alive_peephole
  sorry
def falseblock_cmp_is_true_combined := [llvmfunc|
  llvm.func @falseblock_cmp_is_true(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }]

theorem inst_combine_falseblock_cmp_is_true   : falseblock_cmp_is_true_before  ⊑  falseblock_cmp_is_true_combined := by
  unfold falseblock_cmp_is_true_before falseblock_cmp_is_true_combined
  simp_alive_peephole
  sorry
def falseblock_cmp_is_true_commute_combined := [llvmfunc|
  llvm.func @falseblock_cmp_is_true_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i1
  }]

theorem inst_combine_falseblock_cmp_is_true_commute   : falseblock_cmp_is_true_commute_before  ⊑  falseblock_cmp_is_true_commute_combined := by
  unfold falseblock_cmp_is_true_commute_before falseblock_cmp_is_true_commute_combined
  simp_alive_peephole
  sorry
def PR48900_combined := [llvmfunc|
  llvm.func @PR48900(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.intr.umin(%3, %2)  : (i32, i32) -> i32
    llvm.return %5 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_PR48900   : PR48900_before  ⊑  PR48900_combined := by
  unfold PR48900_before PR48900_combined
  simp_alive_peephole
  sorry
def PR48900_alt_combined := [llvmfunc|
  llvm.func @PR48900_alt(%arg0: i8, %arg1: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(-126 : i8) : i8
    %4 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    %5 = llvm.icmp "ugt" %4, %1 : i8
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.intr.smin(%4, %3)  : (i8, i8) -> i8
    llvm.return %6 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i8
  }]

theorem inst_combine_PR48900_alt   : PR48900_alt_before  ⊑  PR48900_alt_combined := by
  unfold PR48900_alt_before PR48900_alt_combined
  simp_alive_peephole
  sorry
def and_mask1_eq_combined := [llvmfunc|
  llvm.func @and_mask1_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_and_mask1_eq   : and_mask1_eq_before  ⊑  and_mask1_eq_combined := by
  unfold and_mask1_eq_before and_mask1_eq_combined
  simp_alive_peephole
  sorry
def and_mask1_ne_combined := [llvmfunc|
  llvm.func @and_mask1_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_and_mask1_ne   : and_mask1_ne_before  ⊑  and_mask1_ne_combined := by
  unfold and_mask1_ne_before and_mask1_ne_combined
  simp_alive_peephole
  sorry
def and_mask2_combined := [llvmfunc|
  llvm.func @and_mask2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_and_mask2   : and_mask2_before  ⊑  and_mask2_combined := by
  unfold and_mask2_before and_mask2_combined
  simp_alive_peephole
  sorry
def and_mask3_combined := [llvmfunc|
  llvm.func @and_mask3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_and_mask3   : and_mask3_before  ⊑  and_mask3_combined := by
  unfold and_mask3_before and_mask3_combined
  simp_alive_peephole
  sorry
def and_mask4_combined := [llvmfunc|
  llvm.func @and_mask4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %6 = llvm.and %arg0, %2  : i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_and_mask4   : and_mask4_before  ⊑  and_mask4_combined := by
  unfold and_mask4_before and_mask4_combined
  simp_alive_peephole
  sorry
