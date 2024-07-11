import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  mul-pow2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mul_selectp2_x_before := [llvmfunc|
  llvm.func @mul_selectp2_x(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.mul %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def mul_selectp2_x_propegate_nuw_before := [llvmfunc|
  llvm.func @mul_selectp2_x_propegate_nuw(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.mul %2, %arg0 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }]

def mul_selectp2_x_multiuse_fixme_before := [llvmfunc|
  llvm.func @mul_selectp2_x_multiuse_fixme(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.mul %2, %arg0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    llvm.return %3 : i8
  }]

def mul_selectp2_x_non_const_before := [llvmfunc|
  llvm.func @mul_selectp2_x_non_const(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.mul %3, %arg0  : i8
    llvm.return %4 : i8
  }]

def mul_selectp2_x_non_const_multiuse_before := [llvmfunc|
  llvm.func @mul_selectp2_x_non_const_multiuse(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %0, %arg2  : i8
    %3 = llvm.select %arg1, %1, %2 : i1, i8
    %4 = llvm.mul %3, %arg0  : i8
    llvm.call @use_i8(%2) : (i8) -> ()
    llvm.return %4 : i8
  }]

def mul_x_selectp2_before := [llvmfunc|
  llvm.func @mul_x_selectp2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mul %arg0, %arg0  : i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.mul %2, %3  : i8
    llvm.return %4 : i8
  }]

def mul_select_nonp2_x_fail_before := [llvmfunc|
  llvm.func @mul_select_nonp2_x_fail(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.mul %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def mul_x_selectp2_vec_before := [llvmfunc|
  llvm.func @mul_x_selectp2_vec(%arg0: vector<2xi8>, %arg1: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[4, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %arg0  : vector<2xi8>
    %3 = llvm.select %arg1, %0, %1 : i1, vector<2xi8>
    %4 = llvm.mul %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def shl_add_log_may_cause_poison_pr62175_fail_before := [llvmfunc|
  llvm.func @shl_add_log_may_cause_poison_pr62175_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.mul %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def shl_add_log_may_cause_poison_pr62175_with_nuw_before := [llvmfunc|
  llvm.func @shl_add_log_may_cause_poison_pr62175_with_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    %2 = llvm.mul %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def shl_add_log_may_cause_poison_pr62175_with_nsw_before := [llvmfunc|
  llvm.func @shl_add_log_may_cause_poison_pr62175_with_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.mul %arg1, %1  : i8
    llvm.return %2 : i8
  }]

def mul_selectp2_x_combined := [llvmfunc|
  llvm.func @mul_selectp2_x(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.shl %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_mul_selectp2_x   : mul_selectp2_x_before  ⊑  mul_selectp2_x_combined := by
  unfold mul_selectp2_x_before mul_selectp2_x_combined
  simp_alive_peephole
  sorry
def mul_selectp2_x_propegate_nuw_combined := [llvmfunc|
  llvm.func @mul_selectp2_x_propegate_nuw(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.shl %arg0, %2 overflow<nuw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_mul_selectp2_x_propegate_nuw   : mul_selectp2_x_propegate_nuw_before  ⊑  mul_selectp2_x_propegate_nuw_combined := by
  unfold mul_selectp2_x_propegate_nuw_before mul_selectp2_x_propegate_nuw_combined
  simp_alive_peephole
  sorry
def mul_selectp2_x_multiuse_fixme_combined := [llvmfunc|
  llvm.func @mul_selectp2_x_multiuse_fixme(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.select %arg1, %2, %0 : i1, i8
    %5 = llvm.shl %arg0, %4  : i8
    llvm.call @use_i8(%3) : (i8) -> ()
    llvm.return %5 : i8
  }]

theorem inst_combine_mul_selectp2_x_multiuse_fixme   : mul_selectp2_x_multiuse_fixme_before  ⊑  mul_selectp2_x_multiuse_fixme_combined := by
  unfold mul_selectp2_x_multiuse_fixme_before mul_selectp2_x_multiuse_fixme_combined
  simp_alive_peephole
  sorry
def mul_selectp2_x_non_const_combined := [llvmfunc|
  llvm.func @mul_selectp2_x_non_const(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.select %arg1, %0, %arg2 : i1, i8
    %2 = llvm.shl %arg0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_mul_selectp2_x_non_const   : mul_selectp2_x_non_const_before  ⊑  mul_selectp2_x_non_const_combined := by
  unfold mul_selectp2_x_non_const_before mul_selectp2_x_non_const_combined
  simp_alive_peephole
  sorry
def mul_selectp2_x_non_const_multiuse_combined := [llvmfunc|
  llvm.func @mul_selectp2_x_non_const_multiuse(%arg0: i8, %arg1: i1, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg2 overflow<nuw>  : i8
    %2 = llvm.select %arg1, %0, %arg2 : i1, i8
    %3 = llvm.shl %arg0, %2  : i8
    llvm.call @use_i8(%1) : (i8) -> ()
    llvm.return %3 : i8
  }]

theorem inst_combine_mul_selectp2_x_non_const_multiuse   : mul_selectp2_x_non_const_multiuse_before  ⊑  mul_selectp2_x_non_const_multiuse_combined := by
  unfold mul_selectp2_x_non_const_multiuse_before mul_selectp2_x_non_const_multiuse_combined
  simp_alive_peephole
  sorry
def mul_x_selectp2_combined := [llvmfunc|
  llvm.func @mul_x_selectp2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mul %arg0, %arg0  : i8
    %3 = llvm.select %arg1, %0, %1 : i1, i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_mul_x_selectp2   : mul_x_selectp2_before  ⊑  mul_x_selectp2_combined := by
  unfold mul_x_selectp2_before mul_x_selectp2_combined
  simp_alive_peephole
  sorry
def mul_select_nonp2_x_fail_combined := [llvmfunc|
  llvm.func @mul_select_nonp2_x_fail(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.mul %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_mul_select_nonp2_x_fail   : mul_select_nonp2_x_fail_before  ⊑  mul_select_nonp2_x_fail_combined := by
  unfold mul_select_nonp2_x_fail_before mul_select_nonp2_x_fail_combined
  simp_alive_peephole
  sorry
def mul_x_selectp2_vec_combined := [llvmfunc|
  llvm.func @mul_x_selectp2_vec(%arg0: vector<2xi8>, %arg1: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %arg0  : vector<2xi8>
    %3 = llvm.select %arg1, %0, %1 : i1, vector<2xi8>
    %4 = llvm.shl %2, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_mul_x_selectp2_vec   : mul_x_selectp2_vec_before  ⊑  mul_x_selectp2_vec_combined := by
  unfold mul_x_selectp2_vec_before mul_x_selectp2_vec_combined
  simp_alive_peephole
  sorry
def shl_add_log_may_cause_poison_pr62175_fail_combined := [llvmfunc|
  llvm.func @shl_add_log_may_cause_poison_pr62175_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.mul %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_shl_add_log_may_cause_poison_pr62175_fail   : shl_add_log_may_cause_poison_pr62175_fail_before  ⊑  shl_add_log_may_cause_poison_pr62175_fail_combined := by
  unfold shl_add_log_may_cause_poison_pr62175_fail_before shl_add_log_may_cause_poison_pr62175_fail_combined
  simp_alive_peephole
  sorry
def shl_add_log_may_cause_poison_pr62175_with_nuw_combined := [llvmfunc|
  llvm.func @shl_add_log_may_cause_poison_pr62175_with_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.shl %arg1, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_shl_add_log_may_cause_poison_pr62175_with_nuw   : shl_add_log_may_cause_poison_pr62175_with_nuw_before  ⊑  shl_add_log_may_cause_poison_pr62175_with_nuw_combined := by
  unfold shl_add_log_may_cause_poison_pr62175_with_nuw_before shl_add_log_may_cause_poison_pr62175_with_nuw_combined
  simp_alive_peephole
  sorry
def shl_add_log_may_cause_poison_pr62175_with_nsw_combined := [llvmfunc|
  llvm.func @shl_add_log_may_cause_poison_pr62175_with_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.shl %arg1, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_shl_add_log_may_cause_poison_pr62175_with_nsw   : shl_add_log_may_cause_poison_pr62175_with_nsw_before  ⊑  shl_add_log_may_cause_poison_pr62175_with_nsw_combined := by
  unfold shl_add_log_may_cause_poison_pr62175_with_nsw_before shl_add_log_may_cause_poison_pr62175_with_nsw_combined
  simp_alive_peephole
  sorry
