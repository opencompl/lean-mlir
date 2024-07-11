import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-div-constant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def is_rem2_neg_i8_before := [llvmfunc|
  llvm.func @is_rem2_neg_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def is_rem2_pos_v2i8_before := [llvmfunc|
  llvm.func @is_rem2_pos_v2i8(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.srem %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "sgt" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def is_rem32_pos_i8_before := [llvmfunc|
  llvm.func @is_rem32_pos_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def is_rem4_neg_i16_before := [llvmfunc|
  llvm.func @is_rem4_neg_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.srem %arg0, %0  : i16
    %3 = llvm.icmp "slt" %2, %1 : i16
    llvm.return %3 : i1
  }]

def is_rem32_neg_i32_extra_use_before := [llvmfunc|
  llvm.func @is_rem32_neg_i32_extra_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def is_rem8_nonneg_i16_before := [llvmfunc|
  llvm.func @is_rem8_nonneg_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.srem %arg0, %0  : i16
    %3 = llvm.icmp "sgt" %2, %1 : i16
    llvm.return %3 : i1
  }]

def is_rem3_neg_i8_before := [llvmfunc|
  llvm.func @is_rem3_neg_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def is_rem16_something_i8_before := [llvmfunc|
  llvm.func @is_rem16_something_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_div_before := [llvmfunc|
  llvm.func @icmp_div(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.cond_br %4, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %5 = llvm.sdiv %arg1, %2  : i16
    %6 = llvm.icmp "ne" %5, %0 : i16
    llvm.br ^bb2(%6 : i1)
  ^bb2(%7: i1):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.add %8, %3 overflow<nsw>  : i32
    llvm.return %9 : i32
  }]

def icmp_div2_before := [llvmfunc|
  llvm.func @icmp_div2(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.cond_br %3, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %4 = llvm.sdiv %arg1, %0  : i16
    %5 = llvm.icmp "ne" %4, %0 : i16
    llvm.br ^bb2(%5 : i1)
  ^bb2(%6: i1):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.zext %6 : i1 to i32
    %8 = llvm.add %7, %2 overflow<nsw>  : i32
    llvm.return %8 : i32
  }]

def icmp_div3_before := [llvmfunc|
  llvm.func @icmp_div3(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.cond_br %4, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %5 = llvm.sdiv %arg1, %2  : i16
    %6 = llvm.icmp "ne" %5, %0 : i16
    llvm.br ^bb2(%6 : i1)
  ^bb2(%7: i1):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.add %8, %3 overflow<nsw>  : i32
    llvm.return %9 : i32
  }]

def udiv_eq_umax_before := [llvmfunc|
  llvm.func @udiv_eq_umax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def udiv_ne_umax_before := [llvmfunc|
  llvm.func @udiv_ne_umax(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.udiv %arg0, %arg1  : vector<2xi5>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi5>
    llvm.return %3 : vector<2xi1>
  }]

def udiv_eq_big_before := [llvmfunc|
  llvm.func @udiv_eq_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def udiv_ne_big_before := [llvmfunc|
  llvm.func @udiv_ne_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def udiv_eq_not_big_before := [llvmfunc|
  llvm.func @udiv_eq_not_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def udiv_slt_umax_before := [llvmfunc|
  llvm.func @udiv_slt_umax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def udiv_eq_umax_use_before := [llvmfunc|
  llvm.func @udiv_eq_umax_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.udiv %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def sdiv_eq_smin_before := [llvmfunc|
  llvm.func @sdiv_eq_smin(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def sdiv_ne_smin_before := [llvmfunc|
  llvm.func @sdiv_ne_smin(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-16 : i5) : i5
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.sdiv %arg0, %arg1  : vector<2xi5>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi5>
    llvm.return %3 : vector<2xi1>
  }]

def sdiv_eq_small_before := [llvmfunc|
  llvm.func @sdiv_eq_small(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def sdiv_ne_big_before := [llvmfunc|
  llvm.func @sdiv_ne_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def sdiv_eq_not_big_before := [llvmfunc|
  llvm.func @sdiv_eq_not_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def sdiv_ult_smin_before := [llvmfunc|
  llvm.func @sdiv_ult_smin(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

def sdiv_eq_smin_use_before := [llvmfunc|
  llvm.func @sdiv_eq_smin_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.sdiv %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def sdiv_x_by_const_cmp_x_before := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def udiv_x_by_const_cmp_x_before := [llvmfunc|
  llvm.func @udiv_x_by_const_cmp_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.udiv %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def udiv_x_by_const_cmp_x_non_splat_before := [llvmfunc|
  llvm.func @udiv_x_by_const_cmp_x_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[123, -123]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.udiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "slt" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def sdiv_x_by_const_cmp_x_non_splat_before := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_x_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def lshr_x_by_const_cmp_x_before := [llvmfunc|
  llvm.func @lshr_x_by_const_cmp_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def lshr_by_const_cmp_sle_value_before := [llvmfunc|
  llvm.func @lshr_by_const_cmp_sle_value(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sle" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

def lshr_by_const_cmp_sle_value_non_splat_before := [llvmfunc|
  llvm.func @lshr_by_const_cmp_sle_value_non_splat(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[3, 3, 3, 5]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sle" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

def ashr_by_const_cmp_sge_value_non_splat_before := [llvmfunc|
  llvm.func @ashr_by_const_cmp_sge_value_non_splat(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.ashr %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sge" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

def lshr_by_const_cmp_sge_value_before := [llvmfunc|
  llvm.func @lshr_by_const_cmp_sge_value(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def ashr_x_by_const_cmp_sge_x_before := [llvmfunc|
  llvm.func @ashr_x_by_const_cmp_sge_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def udiv_x_by_const_cmp_eq_value_neg_before := [llvmfunc|
  llvm.func @udiv_x_by_const_cmp_eq_value_neg(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.udiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def sdiv_x_by_const_cmp_eq_value_neg_before := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_eq_value_neg(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def lshr_x_by_const_cmp_slt_value_neg_before := [llvmfunc|
  llvm.func @lshr_x_by_const_cmp_slt_value_neg(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "slt" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def sdiv_x_by_const_cmp_ult_value_neg_before := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_ult_value_neg(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def sdiv_x_by_const_cmp_sgt_value_neg_before := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_sgt_value_neg(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sgt" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

def ashr_x_by_const_cmp_sle_value_neg_before := [llvmfunc|
  llvm.func @ashr_x_by_const_cmp_sle_value_neg(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def is_rem2_neg_i8_combined := [llvmfunc|
  llvm.func @is_rem2_neg_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_is_rem2_neg_i8   : is_rem2_neg_i8_before  ⊑  is_rem2_neg_i8_combined := by
  unfold is_rem2_neg_i8_before is_rem2_neg_i8_combined
  simp_alive_peephole
  sorry
def is_rem2_pos_v2i8_combined := [llvmfunc|
  llvm.func @is_rem2_pos_v2i8(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_is_rem2_pos_v2i8   : is_rem2_pos_v2i8_before  ⊑  is_rem2_pos_v2i8_combined := by
  unfold is_rem2_pos_v2i8_before is_rem2_pos_v2i8_combined
  simp_alive_peephole
  sorry
def is_rem32_pos_i8_combined := [llvmfunc|
  llvm.func @is_rem32_pos_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-97 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_is_rem32_pos_i8   : is_rem32_pos_i8_before  ⊑  is_rem32_pos_i8_combined := by
  unfold is_rem32_pos_i8_before is_rem32_pos_i8_combined
  simp_alive_peephole
  sorry
def is_rem4_neg_i16_combined := [llvmfunc|
  llvm.func @is_rem4_neg_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-32765 : i16) : i16
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.icmp "ugt" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_is_rem4_neg_i16   : is_rem4_neg_i16_before  ⊑  is_rem4_neg_i16_combined := by
  unfold is_rem4_neg_i16_before is_rem4_neg_i16_combined
  simp_alive_peephole
  sorry
def is_rem32_neg_i32_extra_use_combined := [llvmfunc|
  llvm.func @is_rem32_neg_i32_extra_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_is_rem32_neg_i32_extra_use   : is_rem32_neg_i32_extra_use_before  ⊑  is_rem32_neg_i32_extra_use_combined := by
  unfold is_rem32_neg_i32_extra_use_before is_rem32_neg_i32_extra_use_combined
  simp_alive_peephole
  sorry
def is_rem8_nonneg_i16_combined := [llvmfunc|
  llvm.func @is_rem8_nonneg_i16(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.srem %arg0, %0  : i16
    %3 = llvm.icmp "sgt" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_is_rem8_nonneg_i16   : is_rem8_nonneg_i16_before  ⊑  is_rem8_nonneg_i16_combined := by
  unfold is_rem8_nonneg_i16_before is_rem8_nonneg_i16_combined
  simp_alive_peephole
  sorry
def is_rem3_neg_i8_combined := [llvmfunc|
  llvm.func @is_rem3_neg_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_is_rem3_neg_i8   : is_rem3_neg_i8_before  ⊑  is_rem3_neg_i8_combined := by
  unfold is_rem3_neg_i8_before is_rem3_neg_i8_combined
  simp_alive_peephole
  sorry
def is_rem16_something_i8_combined := [llvmfunc|
  llvm.func @is_rem16_something_i8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.srem %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_is_rem16_something_i8   : is_rem16_something_i8_before  ⊑  is_rem16_something_i8_combined := by
  unfold is_rem16_something_i8_before is_rem16_something_i8_combined
  simp_alive_peephole
  sorry
def icmp_div_combined := [llvmfunc|
  llvm.func @icmp_div(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.cond_br %2, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "eq" %arg1, %0 : i16
    %4 = llvm.sext %3 : i1 to i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_div   : icmp_div_before  ⊑  icmp_div_combined := by
  unfold icmp_div_before icmp_div_combined
  simp_alive_peephole
  sorry
def icmp_div2_combined := [llvmfunc|
  llvm.func @icmp_div2(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }]

theorem inst_combine_icmp_div2   : icmp_div2_before  ⊑  icmp_div2_combined := by
  unfold icmp_div2_before icmp_div2_combined
  simp_alive_peephole
  sorry
def icmp_div3_combined := [llvmfunc|
  llvm.func @icmp_div3(%arg0: i16, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i16
    llvm.cond_br %2, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "eq" %arg1, %0 : i16
    %4 = llvm.sext %3 : i1 to i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }]

theorem inst_combine_icmp_div3   : icmp_div3_before  ⊑  icmp_div3_combined := by
  unfold icmp_div3_before icmp_div3_combined
  simp_alive_peephole
  sorry
def udiv_eq_umax_combined := [llvmfunc|
  llvm.func @udiv_eq_umax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg1, %1 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_udiv_eq_umax   : udiv_eq_umax_before  ⊑  udiv_eq_umax_combined := by
  unfold udiv_eq_umax_before udiv_eq_umax_combined
  simp_alive_peephole
  sorry
def udiv_ne_umax_combined := [llvmfunc|
  llvm.func @udiv_ne_umax(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(1 : i5) : i5
    %3 = llvm.mlir.constant(dense<1> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.icmp "ne" %arg0, %1 : vector<2xi5>
    %5 = llvm.icmp "ne" %arg1, %3 : vector<2xi5>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_udiv_ne_umax   : udiv_ne_umax_before  ⊑  udiv_ne_umax_combined := by
  unfold udiv_ne_umax_before udiv_ne_umax_combined
  simp_alive_peephole
  sorry
def udiv_eq_big_combined := [llvmfunc|
  llvm.func @udiv_eq_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg1, %1 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_udiv_eq_big   : udiv_eq_big_before  ⊑  udiv_eq_big_combined := by
  unfold udiv_eq_big_before udiv_eq_big_combined
  simp_alive_peephole
  sorry
def udiv_ne_big_combined := [llvmfunc|
  llvm.func @udiv_ne_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.icmp "ne" %arg1, %1 : i8
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_udiv_ne_big   : udiv_ne_big_before  ⊑  udiv_ne_big_combined := by
  unfold udiv_ne_big_before udiv_ne_big_combined
  simp_alive_peephole
  sorry
def udiv_eq_not_big_combined := [llvmfunc|
  llvm.func @udiv_eq_not_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_udiv_eq_not_big   : udiv_eq_not_big_before  ⊑  udiv_eq_not_big_combined := by
  unfold udiv_eq_not_big_before udiv_eq_not_big_combined
  simp_alive_peephole
  sorry
def udiv_slt_umax_combined := [llvmfunc|
  llvm.func @udiv_slt_umax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_udiv_slt_umax   : udiv_slt_umax_before  ⊑  udiv_slt_umax_combined := by
  unfold udiv_slt_umax_before udiv_slt_umax_combined
  simp_alive_peephole
  sorry
def udiv_eq_umax_use_combined := [llvmfunc|
  llvm.func @udiv_eq_umax_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.udiv %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_udiv_eq_umax_use   : udiv_eq_umax_use_before  ⊑  udiv_eq_umax_use_combined := by
  unfold udiv_eq_umax_use_before udiv_eq_umax_use_combined
  simp_alive_peephole
  sorry
def sdiv_eq_smin_combined := [llvmfunc|
  llvm.func @sdiv_eq_smin(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg1, %1 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_sdiv_eq_smin   : sdiv_eq_smin_before  ⊑  sdiv_eq_smin_combined := by
  unfold sdiv_eq_smin_before sdiv_eq_smin_combined
  simp_alive_peephole
  sorry
def sdiv_ne_smin_combined := [llvmfunc|
  llvm.func @sdiv_ne_smin(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-16 : i5) : i5
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(1 : i5) : i5
    %3 = llvm.mlir.constant(dense<1> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.icmp "ne" %arg0, %1 : vector<2xi5>
    %5 = llvm.icmp "ne" %arg1, %3 : vector<2xi5>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_sdiv_ne_smin   : sdiv_ne_smin_before  ⊑  sdiv_ne_smin_combined := by
  unfold sdiv_ne_smin_before sdiv_ne_smin_combined
  simp_alive_peephole
  sorry
def sdiv_eq_small_combined := [llvmfunc|
  llvm.func @sdiv_eq_small(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_sdiv_eq_small   : sdiv_eq_small_before  ⊑  sdiv_eq_small_combined := by
  unfold sdiv_eq_small_before sdiv_eq_small_combined
  simp_alive_peephole
  sorry
def sdiv_ne_big_combined := [llvmfunc|
  llvm.func @sdiv_ne_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_sdiv_ne_big   : sdiv_ne_big_before  ⊑  sdiv_ne_big_combined := by
  unfold sdiv_ne_big_before sdiv_ne_big_combined
  simp_alive_peephole
  sorry
def sdiv_eq_not_big_combined := [llvmfunc|
  llvm.func @sdiv_eq_not_big(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_sdiv_eq_not_big   : sdiv_eq_not_big_before  ⊑  sdiv_eq_not_big_combined := by
  unfold sdiv_eq_not_big_before sdiv_eq_not_big_combined
  simp_alive_peephole
  sorry
def sdiv_ult_smin_combined := [llvmfunc|
  llvm.func @sdiv_ult_smin(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_sdiv_ult_smin   : sdiv_ult_smin_before  ⊑  sdiv_ult_smin_combined := by
  unfold sdiv_ult_smin_before sdiv_ult_smin_combined
  simp_alive_peephole
  sorry
def sdiv_eq_smin_use_combined := [llvmfunc|
  llvm.func @sdiv_eq_smin_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.sdiv %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sdiv_eq_smin_use   : sdiv_eq_smin_use_before  ⊑  sdiv_eq_smin_use_combined := by
  unfold sdiv_eq_smin_use_before sdiv_eq_smin_use_combined
  simp_alive_peephole
  sorry
def sdiv_x_by_const_cmp_x_combined := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sdiv_x_by_const_cmp_x   : sdiv_x_by_const_cmp_x_before  ⊑  sdiv_x_by_const_cmp_x_combined := by
  unfold sdiv_x_by_const_cmp_x_before sdiv_x_by_const_cmp_x_combined
  simp_alive_peephole
  sorry
def udiv_x_by_const_cmp_x_combined := [llvmfunc|
  llvm.func @udiv_x_by_const_cmp_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(123 : i32) : i32
    %1 = llvm.udiv %arg0, %0  : i32
    %2 = llvm.icmp "slt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_udiv_x_by_const_cmp_x   : udiv_x_by_const_cmp_x_before  ⊑  udiv_x_by_const_cmp_x_combined := by
  unfold udiv_x_by_const_cmp_x_before udiv_x_by_const_cmp_x_combined
  simp_alive_peephole
  sorry
def udiv_x_by_const_cmp_x_non_splat_combined := [llvmfunc|
  llvm.func @udiv_x_by_const_cmp_x_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[123, -123]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.udiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "slt" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_udiv_x_by_const_cmp_x_non_splat   : udiv_x_by_const_cmp_x_non_splat_before  ⊑  udiv_x_by_const_cmp_x_non_splat_combined := by
  unfold udiv_x_by_const_cmp_x_non_splat_before udiv_x_by_const_cmp_x_non_splat_combined
  simp_alive_peephole
  sorry
def sdiv_x_by_const_cmp_x_non_splat_combined := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_x_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_sdiv_x_by_const_cmp_x_non_splat   : sdiv_x_by_const_cmp_x_non_splat_before  ⊑  sdiv_x_by_const_cmp_x_non_splat_combined := by
  unfold sdiv_x_by_const_cmp_x_non_splat_before sdiv_x_by_const_cmp_x_non_splat_combined
  simp_alive_peephole
  sorry
def lshr_x_by_const_cmp_x_combined := [llvmfunc|
  llvm.func @lshr_x_by_const_cmp_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_lshr_x_by_const_cmp_x   : lshr_x_by_const_cmp_x_before  ⊑  lshr_x_by_const_cmp_x_combined := by
  unfold lshr_x_by_const_cmp_x_before lshr_x_by_const_cmp_x_combined
  simp_alive_peephole
  sorry
def lshr_by_const_cmp_sle_value_combined := [llvmfunc|
  llvm.func @lshr_by_const_cmp_sle_value(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sle" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

theorem inst_combine_lshr_by_const_cmp_sle_value   : lshr_by_const_cmp_sle_value_before  ⊑  lshr_by_const_cmp_sle_value_combined := by
  unfold lshr_by_const_cmp_sle_value_before lshr_by_const_cmp_sle_value_combined
  simp_alive_peephole
  sorry
def lshr_by_const_cmp_sle_value_non_splat_combined := [llvmfunc|
  llvm.func @lshr_by_const_cmp_sle_value_non_splat(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[3, 3, 3, 5]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sle" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

theorem inst_combine_lshr_by_const_cmp_sle_value_non_splat   : lshr_by_const_cmp_sle_value_non_splat_before  ⊑  lshr_by_const_cmp_sle_value_non_splat_combined := by
  unfold lshr_by_const_cmp_sle_value_non_splat_before lshr_by_const_cmp_sle_value_non_splat_combined
  simp_alive_peephole
  sorry
def ashr_by_const_cmp_sge_value_non_splat_combined := [llvmfunc|
  llvm.func @ashr_by_const_cmp_sge_value_non_splat(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.ashr %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sge" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

theorem inst_combine_ashr_by_const_cmp_sge_value_non_splat   : ashr_by_const_cmp_sge_value_non_splat_before  ⊑  ashr_by_const_cmp_sge_value_non_splat_combined := by
  unfold ashr_by_const_cmp_sge_value_non_splat_before ashr_by_const_cmp_sge_value_non_splat_combined
  simp_alive_peephole
  sorry
def lshr_by_const_cmp_sge_value_combined := [llvmfunc|
  llvm.func @lshr_by_const_cmp_sge_value(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_lshr_by_const_cmp_sge_value   : lshr_by_const_cmp_sge_value_before  ⊑  lshr_by_const_cmp_sge_value_combined := by
  unfold lshr_by_const_cmp_sge_value_before lshr_by_const_cmp_sge_value_combined
  simp_alive_peephole
  sorry
def ashr_x_by_const_cmp_sge_x_combined := [llvmfunc|
  llvm.func @ashr_x_by_const_cmp_sge_x(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.icmp "sge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ashr_x_by_const_cmp_sge_x   : ashr_x_by_const_cmp_sge_x_before  ⊑  ashr_x_by_const_cmp_sge_x_combined := by
  unfold ashr_x_by_const_cmp_sge_x_before ashr_x_by_const_cmp_sge_x_combined
  simp_alive_peephole
  sorry
def udiv_x_by_const_cmp_eq_value_neg_combined := [llvmfunc|
  llvm.func @udiv_x_by_const_cmp_eq_value_neg(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.udiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_udiv_x_by_const_cmp_eq_value_neg   : udiv_x_by_const_cmp_eq_value_neg_before  ⊑  udiv_x_by_const_cmp_eq_value_neg_combined := by
  unfold udiv_x_by_const_cmp_eq_value_neg_before udiv_x_by_const_cmp_eq_value_neg_combined
  simp_alive_peephole
  sorry
def sdiv_x_by_const_cmp_eq_value_neg_combined := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_eq_value_neg(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "eq" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_sdiv_x_by_const_cmp_eq_value_neg   : sdiv_x_by_const_cmp_eq_value_neg_before  ⊑  sdiv_x_by_const_cmp_eq_value_neg_combined := by
  unfold sdiv_x_by_const_cmp_eq_value_neg_before sdiv_x_by_const_cmp_eq_value_neg_combined
  simp_alive_peephole
  sorry
def lshr_x_by_const_cmp_slt_value_neg_combined := [llvmfunc|
  llvm.func @lshr_x_by_const_cmp_slt_value_neg(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "slt" %1, %arg0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_lshr_x_by_const_cmp_slt_value_neg   : lshr_x_by_const_cmp_slt_value_neg_before  ⊑  lshr_x_by_const_cmp_slt_value_neg_combined := by
  unfold lshr_x_by_const_cmp_slt_value_neg_before lshr_x_by_const_cmp_slt_value_neg_combined
  simp_alive_peephole
  sorry
def sdiv_x_by_const_cmp_ult_value_neg_combined := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_ult_value_neg(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.sdiv %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sdiv_x_by_const_cmp_ult_value_neg   : sdiv_x_by_const_cmp_ult_value_neg_before  ⊑  sdiv_x_by_const_cmp_ult_value_neg_combined := by
  unfold sdiv_x_by_const_cmp_ult_value_neg_before sdiv_x_by_const_cmp_ult_value_neg_combined
  simp_alive_peephole
  sorry
def sdiv_x_by_const_cmp_sgt_value_neg_combined := [llvmfunc|
  llvm.func @sdiv_x_by_const_cmp_sgt_value_neg(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.icmp "sgt" %1, %arg0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

theorem inst_combine_sdiv_x_by_const_cmp_sgt_value_neg   : sdiv_x_by_const_cmp_sgt_value_neg_before  ⊑  sdiv_x_by_const_cmp_sgt_value_neg_combined := by
  unfold sdiv_x_by_const_cmp_sgt_value_neg_before sdiv_x_by_const_cmp_sgt_value_neg_combined
  simp_alive_peephole
  sorry
def ashr_x_by_const_cmp_sle_value_neg_combined := [llvmfunc|
  llvm.func @ashr_x_by_const_cmp_sle_value_neg(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.icmp "sle" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ashr_x_by_const_cmp_sle_value_neg   : ashr_x_by_const_cmp_sle_value_neg_before  ⊑  ashr_x_by_const_cmp_sle_value_neg_combined := by
  unfold ashr_x_by_const_cmp_sle_value_neg_before ashr_x_by_const_cmp_sle_value_neg_combined
  simp_alive_peephole
  sorry
