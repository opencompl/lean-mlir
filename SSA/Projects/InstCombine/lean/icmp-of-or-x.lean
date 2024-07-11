import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-of-or-x
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def or_ugt_before := [llvmfunc|
  llvm.func @or_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def or_ule_before := [llvmfunc|
  llvm.func @or_ule(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ule" %0, %arg0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def or_slt_pos_before := [llvmfunc|
  llvm.func @or_slt_pos(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg2  : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.or %1, %2  : vector<2xi8>
    %4 = llvm.icmp "slt" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def or_sle_pos_before := [llvmfunc|
  llvm.func @or_sle_pos(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.or %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def or_sle_fail_maybe_neg_before := [llvmfunc|
  llvm.func @or_sle_fail_maybe_neg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "sle" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def or_eq_noundef_before := [llvmfunc|
  llvm.func @or_eq_noundef(%arg0: i8, %arg1: i8 {llvm.noundef}) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def or_eq_notY_eq_0_before := [llvmfunc|
  llvm.func @or_eq_notY_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def or_eq_notY_eq_0_fail_multiuse_before := [llvmfunc|
  llvm.func @or_eq_notY_eq_0_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def or_ne_notY_eq_1s_before := [llvmfunc|
  llvm.func @or_ne_notY_eq_1s(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def or_ne_notY_eq_1s_fail_bad_not_before := [llvmfunc|
  llvm.func @or_ne_notY_eq_1s_fail_bad_not(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def or_ne_vecC_before := [llvmfunc|
  llvm.func @or_ne_vecC(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[9, 42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def or_eq_fail_maybe_undef_before := [llvmfunc|
  llvm.func @or_eq_fail_maybe_undef(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def or_ne_noundef_before := [llvmfunc|
  llvm.func @or_ne_noundef(%arg0: vector<2xi8>, %arg1: vector<2xi8> {llvm.noundef}) -> vector<2xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ne" %0, %arg0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def or_ne_noundef_fail_reuse_before := [llvmfunc|
  llvm.func @or_ne_noundef_fail_reuse(%arg0: vector<2xi8>, %arg1: vector<2xi8> {llvm.noundef}) -> vector<2xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ne" %0, %arg0 : vector<2xi8>
    llvm.call @use.v2i8(%0) : (vector<2xi8>) -> ()
    llvm.return %1 : vector<2xi1>
  }]

def or_slt_intmin_before := [llvmfunc|
  llvm.func @or_slt_intmin(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "slt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def or_slt_intmin_2_before := [llvmfunc|
  llvm.func @or_slt_intmin_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg1  : vector<2xi8>
    %2 = llvm.or %1, %0  : vector<2xi8>
    %3 = llvm.icmp "slt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def or_sle_intmin_indirect_2_before := [llvmfunc|
  llvm.func @or_sle_intmin_indirect_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg2  : i8
    %3 = llvm.sub %0, %arg1  : i8
    %4 = llvm.and %arg1, %3  : i8
    %5 = llvm.icmp "slt" %4, %0 : i8
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.or %2, %4  : i8
    %7 = llvm.icmp "sle" %2, %6 : i8
    llvm.return %7 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %1 : i1
  }]

def or_sge_intmin_before := [llvmfunc|
  llvm.func @or_sge_intmin(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "sge" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def or_sgt_intmin_indirect_before := [llvmfunc|
  llvm.func @or_sgt_intmin_indirect(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.and %arg1, %2  : i8
    %4 = llvm.icmp "sge" %3, %0 : i8
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.or %arg0, %3  : i8
    %6 = llvm.icmp "sgt" %5, %arg0 : i8
    llvm.return %6 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %1 : i1
  }]

def or_sgt_intmin_2_before := [llvmfunc|
  llvm.func @or_sgt_intmin_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg1  : vector<2xi8>
    %2 = llvm.or %1, %0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def or_simplify_ule_before := [llvmfunc|
  llvm.func @or_simplify_ule(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ule" %4, %3 : i8
    llvm.return %5 : i1
  }]

def or_simplify_uge_before := [llvmfunc|
  llvm.func @or_simplify_uge(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "uge" %3, %4 : i8
    llvm.return %5 : i1
  }]

def or_simplify_ule_fail_before := [llvmfunc|
  llvm.func @or_simplify_ule_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ule" %4, %3 : i8
    llvm.return %5 : i1
  }]

def or_simplify_ugt_before := [llvmfunc|
  llvm.func @or_simplify_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ugt" %4, %3 : i8
    llvm.return %5 : i1
  }]

def or_simplify_ult_before := [llvmfunc|
  llvm.func @or_simplify_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(36 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ult" %3, %4 : i8
    llvm.return %5 : i1
  }]

def or_simplify_ugt_fail_before := [llvmfunc|
  llvm.func @or_simplify_ugt_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "ugt" %4, %3 : i8
    llvm.return %5 : i1
  }]

def pr64610_before := [llvmfunc|
  llvm.func @pr64610(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(74 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.load %arg0 {alignment = 2 : i64} : !llvm.ptr -> i1]

    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.or %4, %2  : i32
    %6 = llvm.icmp "ugt" %5, %4 : i32
    llvm.return %6 : i1
  }]

def icmp_eq_x_invertable_y2_todo_before := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y2_todo(%arg0: i8, %arg1: i1, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.or %arg0, %3  : i8
    %5 = llvm.icmp "eq" %3, %4 : i8
    llvm.return %5 : i1
  }]

def icmp_eq_x_invertable_y2_before := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %arg0, %1  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

def PR38139_before := [llvmfunc|
  llvm.func @PR38139(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "ne" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def or_ugt_combined := [llvmfunc|
  llvm.func @or_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "ne" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_or_ugt   : or_ugt_before  ⊑  or_ugt_combined := by
  unfold or_ugt_before or_ugt_combined
  simp_alive_peephole
  sorry
def or_ule_combined := [llvmfunc|
  llvm.func @or_ule(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "eq" %0, %arg0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_or_ule   : or_ule_before  ⊑  or_ule_combined := by
  unfold or_ule_before or_ule_combined
  simp_alive_peephole
  sorry
def or_slt_pos_combined := [llvmfunc|
  llvm.func @or_slt_pos(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg2  : vector<2xi8>
    %2 = llvm.and %arg1, %0  : vector<2xi8>
    %3 = llvm.or %1, %2  : vector<2xi8>
    %4 = llvm.icmp "slt" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_or_slt_pos   : or_slt_pos_before  ⊑  or_slt_pos_combined := by
  unfold or_slt_pos_before or_slt_pos_combined
  simp_alive_peephole
  sorry
def or_sle_pos_combined := [llvmfunc|
  llvm.func @or_sle_pos(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.or %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_sle_pos   : or_sle_pos_before  ⊑  or_sle_pos_combined := by
  unfold or_sle_pos_before or_sle_pos_combined
  simp_alive_peephole
  sorry
def or_sle_fail_maybe_neg_combined := [llvmfunc|
  llvm.func @or_sle_fail_maybe_neg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "sle" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_or_sle_fail_maybe_neg   : or_sle_fail_maybe_neg_before  ⊑  or_sle_fail_maybe_neg_combined := by
  unfold or_sle_fail_maybe_neg_before or_sle_fail_maybe_neg_combined
  simp_alive_peephole
  sorry
def or_eq_noundef_combined := [llvmfunc|
  llvm.func @or_eq_noundef(%arg0: i8, %arg1: i8 {llvm.noundef}) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_or_eq_noundef   : or_eq_noundef_before  ⊑  or_eq_noundef_combined := by
  unfold or_eq_noundef_before or_eq_noundef_combined
  simp_alive_peephole
  sorry
def or_eq_notY_eq_0_combined := [llvmfunc|
  llvm.func @or_eq_notY_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.and %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_or_eq_notY_eq_0   : or_eq_notY_eq_0_before  ⊑  or_eq_notY_eq_0_combined := by
  unfold or_eq_notY_eq_0_before or_eq_notY_eq_0_combined
  simp_alive_peephole
  sorry
def or_eq_notY_eq_0_fail_multiuse_combined := [llvmfunc|
  llvm.func @or_eq_notY_eq_0_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_eq_notY_eq_0_fail_multiuse   : or_eq_notY_eq_0_fail_multiuse_before  ⊑  or_eq_notY_eq_0_fail_multiuse_combined := by
  unfold or_eq_notY_eq_0_fail_multiuse_before or_eq_notY_eq_0_fail_multiuse_combined
  simp_alive_peephole
  sorry
def or_ne_notY_eq_1s_combined := [llvmfunc|
  llvm.func @or_ne_notY_eq_1s(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_or_ne_notY_eq_1s   : or_ne_notY_eq_1s_before  ⊑  or_ne_notY_eq_1s_combined := by
  unfold or_ne_notY_eq_1s_before or_ne_notY_eq_1s_combined
  simp_alive_peephole
  sorry
def or_ne_notY_eq_1s_fail_bad_not_combined := [llvmfunc|
  llvm.func @or_ne_notY_eq_1s_fail_bad_not(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_or_ne_notY_eq_1s_fail_bad_not   : or_ne_notY_eq_1s_fail_bad_not_before  ⊑  or_ne_notY_eq_1s_fail_bad_not_combined := by
  unfold or_ne_notY_eq_1s_fail_bad_not_before or_ne_notY_eq_1s_fail_bad_not_combined
  simp_alive_peephole
  sorry
def or_ne_vecC_combined := [llvmfunc|
  llvm.func @or_ne_vecC(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-10, -43]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_or_ne_vecC   : or_ne_vecC_before  ⊑  or_ne_vecC_combined := by
  unfold or_ne_vecC_before or_ne_vecC_combined
  simp_alive_peephole
  sorry
def or_eq_fail_maybe_undef_combined := [llvmfunc|
  llvm.func @or_eq_fail_maybe_undef(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_or_eq_fail_maybe_undef   : or_eq_fail_maybe_undef_before  ⊑  or_eq_fail_maybe_undef_combined := by
  unfold or_eq_fail_maybe_undef_before or_eq_fail_maybe_undef_combined
  simp_alive_peephole
  sorry
def or_ne_noundef_combined := [llvmfunc|
  llvm.func @or_ne_noundef(%arg0: vector<2xi8>, %arg1: vector<2xi8> {llvm.noundef}) -> vector<2xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ne" %0, %arg0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_or_ne_noundef   : or_ne_noundef_before  ⊑  or_ne_noundef_combined := by
  unfold or_ne_noundef_before or_ne_noundef_combined
  simp_alive_peephole
  sorry
def or_ne_noundef_fail_reuse_combined := [llvmfunc|
  llvm.func @or_ne_noundef_fail_reuse(%arg0: vector<2xi8>, %arg1: vector<2xi8> {llvm.noundef}) -> vector<2xi1> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "ne" %0, %arg0 : vector<2xi8>
    llvm.call @use.v2i8(%0) : (vector<2xi8>) -> ()
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_or_ne_noundef_fail_reuse   : or_ne_noundef_fail_reuse_before  ⊑  or_ne_noundef_fail_reuse_combined := by
  unfold or_ne_noundef_fail_reuse_before or_ne_noundef_fail_reuse_combined
  simp_alive_peephole
  sorry
def or_slt_intmin_combined := [llvmfunc|
  llvm.func @or_slt_intmin(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "slt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_or_slt_intmin   : or_slt_intmin_before  ⊑  or_slt_intmin_combined := by
  unfold or_slt_intmin_before or_slt_intmin_combined
  simp_alive_peephole
  sorry
def or_slt_intmin_2_combined := [llvmfunc|
  llvm.func @or_slt_intmin_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg1  : vector<2xi8>
    %2 = llvm.or %1, %0  : vector<2xi8>
    %3 = llvm.icmp "slt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_or_slt_intmin_2   : or_slt_intmin_2_before  ⊑  or_slt_intmin_2_combined := by
  unfold or_slt_intmin_2_before or_slt_intmin_2_combined
  simp_alive_peephole
  sorry
def or_sle_intmin_indirect_2_combined := [llvmfunc|
  llvm.func @or_sle_intmin_indirect_2(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %arg2  : i8
    %4 = llvm.or %3, %0  : i8
    %5 = llvm.icmp "sle" %3, %4 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_or_sle_intmin_indirect_2   : or_sle_intmin_indirect_2_before  ⊑  or_sle_intmin_indirect_2_combined := by
  unfold or_sle_intmin_indirect_2_before or_sle_intmin_indirect_2_combined
  simp_alive_peephole
  sorry
def or_sge_intmin_combined := [llvmfunc|
  llvm.func @or_sge_intmin(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "sge" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_or_sge_intmin   : or_sge_intmin_before  ⊑  or_sge_intmin_combined := by
  unfold or_sge_intmin_before or_sge_intmin_combined
  simp_alive_peephole
  sorry
def or_sgt_intmin_indirect_combined := [llvmfunc|
  llvm.func @or_sgt_intmin_indirect(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %0 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.or %arg0, %0  : i8
    %4 = llvm.icmp "sgt" %3, %arg0 : i8
    llvm.return %4 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_or_sgt_intmin_indirect   : or_sgt_intmin_indirect_before  ⊑  or_sgt_intmin_indirect_combined := by
  unfold or_sgt_intmin_indirect_before or_sgt_intmin_indirect_combined
  simp_alive_peephole
  sorry
def or_sgt_intmin_2_combined := [llvmfunc|
  llvm.func @or_sgt_intmin_2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg1  : vector<2xi8>
    %2 = llvm.or %1, %0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_or_sgt_intmin_2   : or_sgt_intmin_2_before  ⊑  or_sgt_intmin_2_combined := by
  unfold or_sgt_intmin_2_before or_sgt_intmin_2_combined
  simp_alive_peephole
  sorry
def or_simplify_ule_combined := [llvmfunc|
  llvm.func @or_simplify_ule(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.or %arg0, %arg1  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.icmp "ule" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_or_simplify_ule   : or_simplify_ule_before  ⊑  or_simplify_ule_combined := by
  unfold or_simplify_ule_before or_simplify_ule_combined
  simp_alive_peephole
  sorry
def or_simplify_uge_combined := [llvmfunc|
  llvm.func @or_simplify_uge(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_or_simplify_uge   : or_simplify_uge_before  ⊑  or_simplify_uge_combined := by
  unfold or_simplify_uge_before or_simplify_uge_combined
  simp_alive_peephole
  sorry
def or_simplify_ule_fail_combined := [llvmfunc|
  llvm.func @or_simplify_ule_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.icmp "ule" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_or_simplify_ule_fail   : or_simplify_ule_fail_before  ⊑  or_simplify_ule_fail_combined := by
  unfold or_simplify_ule_fail_before or_simplify_ule_fail_combined
  simp_alive_peephole
  sorry
def or_simplify_ugt_combined := [llvmfunc|
  llvm.func @or_simplify_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.or %arg0, %arg1  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.icmp "ugt" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_or_simplify_ugt   : or_simplify_ugt_before  ⊑  or_simplify_ugt_combined := by
  unfold or_simplify_ugt_before or_simplify_ugt_combined
  simp_alive_peephole
  sorry
def or_simplify_ult_combined := [llvmfunc|
  llvm.func @or_simplify_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(36 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.or %arg0, %arg1  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.icmp "ult" %2, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_or_simplify_ult   : or_simplify_ult_before  ⊑  or_simplify_ult_combined := by
  unfold or_simplify_ult_before or_simplify_ult_combined
  simp_alive_peephole
  sorry
def or_simplify_ugt_fail_combined := [llvmfunc|
  llvm.func @or_simplify_ugt_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg1, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_simplify_ugt_fail   : or_simplify_ugt_fail_before  ⊑  or_simplify_ugt_fail_combined := by
  unfold or_simplify_ugt_fail_before or_simplify_ugt_fail_combined
  simp_alive_peephole
  sorry
def pr64610_combined := [llvmfunc|
  llvm.func @pr64610(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_pr64610   : pr64610_before  ⊑  pr64610_combined := by
  unfold pr64610_before pr64610_combined
  simp_alive_peephole
  sorry
def icmp_eq_x_invertable_y2_todo_combined := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y2_todo(%arg0: i8, %arg1: i1, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.or %3, %arg0  : i8
    %5 = llvm.icmp "eq" %3, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_icmp_eq_x_invertable_y2_todo   : icmp_eq_x_invertable_y2_todo_before  ⊑  icmp_eq_x_invertable_y2_todo_combined := by
  unfold icmp_eq_x_invertable_y2_todo_before icmp_eq_x_invertable_y2_todo_combined
  simp_alive_peephole
  sorry
def icmp_eq_x_invertable_y2_combined := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.and %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_eq_x_invertable_y2   : icmp_eq_x_invertable_y2_before  ⊑  icmp_eq_x_invertable_y2_combined := by
  unfold icmp_eq_x_invertable_y2_before icmp_eq_x_invertable_y2_combined
  simp_alive_peephole
  sorry
def PR38139_combined := [llvmfunc|
  llvm.func @PR38139(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_PR38139   : PR38139_before  ⊑  PR38139_combined := by
  unfold PR38139_before PR38139_combined
  simp_alive_peephole
  sorry
