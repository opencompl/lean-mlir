import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-ctpop-of-not
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_sub_c_ctpop_before := [llvmfunc|
  llvm.func @fold_sub_c_ctpop(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def fold_sub_var_ctpop_fail_before := [llvmfunc|
  llvm.func @fold_sub_var_ctpop_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.sub %arg1, %2  : i8
    llvm.return %3 : i8
  }]

def fold_sub_ctpop_c_before := [llvmfunc|
  llvm.func @fold_sub_ctpop_c(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[63, 64]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.sub %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def fold_add_ctpop_c_before := [llvmfunc|
  llvm.func @fold_add_ctpop_c(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.add %3, %1  : i8
    llvm.return %4 : i8
  }]

def fold_distjoint_or_ctpop_c_before := [llvmfunc|
  llvm.func @fold_distjoint_or_ctpop_c(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }]

def fold_or_ctpop_c_fail_before := [llvmfunc|
  llvm.func @fold_or_ctpop_c_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(65 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }]

def fold_add_ctpop_var_fail_before := [llvmfunc|
  llvm.func @fold_add_ctpop_var_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }]

def fold_icmp_sgt_ctpop_c_i2_fail_before := [llvmfunc|
  llvm.func @fold_icmp_sgt_ctpop_c_i2_fail(%arg0: i2, %arg1: i2) -> i1 {
    %0 = llvm.mlir.constant(-1 : i2) : i2
    %1 = llvm.mlir.constant(1 : i2) : i2
    %2 = llvm.xor %arg0, %0  : i2
    %3 = llvm.intr.ctpop(%2)  : (i2) -> i2
    %4 = llvm.icmp "sgt" %3, %1 : i2
    llvm.return %4 : i1
  }]

def fold_cmp_eq_ctpop_c_before := [llvmfunc|
  llvm.func @fold_cmp_eq_ctpop_c(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def fold_cmp_eq_ctpop_c_multiuse_fail_before := [llvmfunc|
  llvm.func @fold_cmp_eq_ctpop_c_multiuse_fail(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    llvm.return %4 : i1
  }]

def fold_cmp_ne_ctpop_c_before := [llvmfunc|
  llvm.func @fold_cmp_ne_ctpop_c(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[44, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %1 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def fold_cmp_ne_ctpop_var_fail_before := [llvmfunc|
  llvm.func @fold_cmp_ne_ctpop_var_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "ne" %2, %arg1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def fold_cmp_ult_ctpop_c_before := [llvmfunc|
  llvm.func @fold_cmp_ult_ctpop_c(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.select %arg2, %3, %4 : i1, i8
    %6 = llvm.intr.ctpop(%5)  : (i8) -> i8
    %7 = llvm.icmp "ult" %6, %2 : i8
    llvm.return %7 : i1
  }]

def fold_cmp_sle_ctpop_c_before := [llvmfunc|
  llvm.func @fold_cmp_sle_ctpop_c(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.select %arg2, %3, %4 : i1, i8
    %6 = llvm.intr.ctpop(%5)  : (i8) -> i8
    %7 = llvm.icmp "sle" %6, %2 : i8
    llvm.return %7 : i1
  }]

def fold_cmp_ult_ctpop_c_no_not_inst_save_fail_before := [llvmfunc|
  llvm.func @fold_cmp_ult_ctpop_c_no_not_inst_save_fail(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }]

def fold_cmp_ugt_ctpop_c_before := [llvmfunc|
  llvm.func @fold_cmp_ugt_ctpop_c(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[8, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def fold_cmp_ugt_ctpop_c_out_of_range_fail_before := [llvmfunc|
  llvm.func @fold_cmp_ugt_ctpop_c_out_of_range_fail(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 10]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def fold_sub_c_ctpop_combined := [llvmfunc|
  llvm.func @fold_sub_c_ctpop(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_fold_sub_c_ctpop   : fold_sub_c_ctpop_before  ⊑  fold_sub_c_ctpop_combined := by
  unfold fold_sub_c_ctpop_before fold_sub_c_ctpop_combined
  simp_alive_peephole
  sorry
def fold_sub_var_ctpop_fail_combined := [llvmfunc|
  llvm.func @fold_sub_var_ctpop_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.sub %arg1, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_fold_sub_var_ctpop_fail   : fold_sub_var_ctpop_fail_before  ⊑  fold_sub_var_ctpop_fail_combined := by
  unfold fold_sub_var_ctpop_fail_before fold_sub_var_ctpop_fail_combined
  simp_alive_peephole
  sorry
def fold_sub_ctpop_c_combined := [llvmfunc|
  llvm.func @fold_sub_ctpop_c(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-55, -56]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_fold_sub_ctpop_c   : fold_sub_ctpop_c_before  ⊑  fold_sub_ctpop_c_combined := by
  unfold fold_sub_ctpop_c_before fold_sub_ctpop_c_combined
  simp_alive_peephole
  sorry
def fold_add_ctpop_c_combined := [llvmfunc|
  llvm.func @fold_add_ctpop_c(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(71 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_fold_add_ctpop_c   : fold_add_ctpop_c_before  ⊑  fold_add_ctpop_c_combined := by
  unfold fold_add_ctpop_c_before fold_add_ctpop_c_combined
  simp_alive_peephole
  sorry
def fold_distjoint_or_ctpop_c_combined := [llvmfunc|
  llvm.func @fold_distjoint_or_ctpop_c(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(72 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_fold_distjoint_or_ctpop_c   : fold_distjoint_or_ctpop_c_before  ⊑  fold_distjoint_or_ctpop_c_combined := by
  unfold fold_distjoint_or_ctpop_c_before fold_distjoint_or_ctpop_c_combined
  simp_alive_peephole
  sorry
def fold_or_ctpop_c_fail_combined := [llvmfunc|
  llvm.func @fold_or_ctpop_c_fail(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(65 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_fold_or_ctpop_c_fail   : fold_or_ctpop_c_fail_before  ⊑  fold_or_ctpop_c_fail_combined := by
  unfold fold_or_ctpop_c_fail_before fold_or_ctpop_c_fail_combined
  simp_alive_peephole
  sorry
def fold_add_ctpop_var_fail_combined := [llvmfunc|
  llvm.func @fold_add_ctpop_var_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_fold_add_ctpop_var_fail   : fold_add_ctpop_var_fail_before  ⊑  fold_add_ctpop_var_fail_combined := by
  unfold fold_add_ctpop_var_fail_before fold_add_ctpop_var_fail_combined
  simp_alive_peephole
  sorry
def fold_icmp_sgt_ctpop_c_i2_fail_combined := [llvmfunc|
  llvm.func @fold_icmp_sgt_ctpop_c_i2_fail(%arg0: i2, %arg1: i2) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_icmp_sgt_ctpop_c_i2_fail   : fold_icmp_sgt_ctpop_c_i2_fail_before  ⊑  fold_icmp_sgt_ctpop_c_i2_fail_combined := by
  unfold fold_icmp_sgt_ctpop_c_i2_fail_before fold_icmp_sgt_ctpop_c_i2_fail_combined
  simp_alive_peephole
  sorry
def fold_cmp_eq_ctpop_c_combined := [llvmfunc|
  llvm.func @fold_cmp_eq_ctpop_c(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_fold_cmp_eq_ctpop_c   : fold_cmp_eq_ctpop_c_before  ⊑  fold_cmp_eq_ctpop_c_combined := by
  unfold fold_cmp_eq_ctpop_c_before fold_cmp_eq_ctpop_c_combined
  simp_alive_peephole
  sorry
def fold_cmp_eq_ctpop_c_multiuse_fail_combined := [llvmfunc|
  llvm.func @fold_cmp_eq_ctpop_c_multiuse_fail(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    llvm.return %4 : i1
  }]

theorem inst_combine_fold_cmp_eq_ctpop_c_multiuse_fail   : fold_cmp_eq_ctpop_c_multiuse_fail_before  ⊑  fold_cmp_eq_ctpop_c_multiuse_fail_combined := by
  unfold fold_cmp_eq_ctpop_c_multiuse_fail_before fold_cmp_eq_ctpop_c_multiuse_fail_combined
  simp_alive_peephole
  sorry
def fold_cmp_ne_ctpop_c_combined := [llvmfunc|
  llvm.func @fold_cmp_ne_ctpop_c(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-36, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fold_cmp_ne_ctpop_c   : fold_cmp_ne_ctpop_c_before  ⊑  fold_cmp_ne_ctpop_c_combined := by
  unfold fold_cmp_ne_ctpop_c_before fold_cmp_ne_ctpop_c_combined
  simp_alive_peephole
  sorry
def fold_cmp_ne_ctpop_var_fail_combined := [llvmfunc|
  llvm.func @fold_cmp_ne_ctpop_var_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.intr.ctpop(%1)  : (vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "ne" %2, %arg1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_fold_cmp_ne_ctpop_var_fail   : fold_cmp_ne_ctpop_var_fail_before  ⊑  fold_cmp_ne_ctpop_var_fail_combined := by
  unfold fold_cmp_ne_ctpop_var_fail_before fold_cmp_ne_ctpop_var_fail_combined
  simp_alive_peephole
  sorry
def fold_cmp_ult_ctpop_c_combined := [llvmfunc|
  llvm.func @fold_cmp_ult_ctpop_c(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.select %arg2, %arg0, %2 : i1, i8
    %4 = llvm.intr.ctpop(%3)  : (i8) -> i8
    %5 = llvm.icmp "ugt" %4, %1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_fold_cmp_ult_ctpop_c   : fold_cmp_ult_ctpop_c_before  ⊑  fold_cmp_ult_ctpop_c_combined := by
  unfold fold_cmp_ult_ctpop_c_before fold_cmp_ult_ctpop_c_combined
  simp_alive_peephole
  sorry
def fold_cmp_sle_ctpop_c_combined := [llvmfunc|
  llvm.func @fold_cmp_sle_ctpop_c(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.select %arg2, %arg0, %2 : i1, i8
    %4 = llvm.intr.ctpop(%3)  : (i8) -> i8
    %5 = llvm.icmp "ugt" %4, %1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_fold_cmp_sle_ctpop_c   : fold_cmp_sle_ctpop_c_before  ⊑  fold_cmp_sle_ctpop_c_combined := by
  unfold fold_cmp_sle_ctpop_c_before fold_cmp_sle_ctpop_c_combined
  simp_alive_peephole
  sorry
def fold_cmp_ult_ctpop_c_no_not_inst_save_fail_combined := [llvmfunc|
  llvm.func @fold_cmp_ult_ctpop_c_no_not_inst_save_fail(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.intr.ctpop(%2)  : (i8) -> i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_fold_cmp_ult_ctpop_c_no_not_inst_save_fail   : fold_cmp_ult_ctpop_c_no_not_inst_save_fail_before  ⊑  fold_cmp_ult_ctpop_c_no_not_inst_save_fail_combined := by
  unfold fold_cmp_ult_ctpop_c_no_not_inst_save_fail_before fold_cmp_ult_ctpop_c_no_not_inst_save_fail_combined
  simp_alive_peephole
  sorry
def fold_cmp_ugt_ctpop_c_combined := [llvmfunc|
  llvm.func @fold_cmp_ugt_ctpop_c(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fold_cmp_ugt_ctpop_c   : fold_cmp_ugt_ctpop_c_before  ⊑  fold_cmp_ugt_ctpop_c_combined := by
  unfold fold_cmp_ugt_ctpop_c_before fold_cmp_ugt_ctpop_c_combined
  simp_alive_peephole
  sorry
def fold_cmp_ugt_ctpop_c_out_of_range_fail_combined := [llvmfunc|
  llvm.func @fold_cmp_ugt_ctpop_c_out_of_range_fail(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 10]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fold_cmp_ugt_ctpop_c_out_of_range_fail   : fold_cmp_ugt_ctpop_c_out_of_range_fail_before  ⊑  fold_cmp_ugt_ctpop_c_out_of_range_fail_combined := by
  unfold fold_cmp_ugt_ctpop_c_out_of_range_fail_before fold_cmp_ugt_ctpop_c_out_of_range_fail_combined
  simp_alive_peephole
  sorry
