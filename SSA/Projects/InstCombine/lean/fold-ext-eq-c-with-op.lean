import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-ext-eq-c-with-op
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_add_zext_eq_0_before := [llvmfunc|
  llvm.func @fold_add_zext_eq_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.add %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def fold_add_sext_eq_4_6_before := [llvmfunc|
  llvm.func @fold_add_sext_eq_4_6(%arg0: vector<2xi6>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, -127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi6> to vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    %3 = llvm.sext %2 : vector<2xi1> to vector<2xi8>
    %4 = llvm.add %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def fold_add_zext_eq_0_fail_multiuse_exp_before := [llvmfunc|
  llvm.func @fold_add_zext_eq_0_fail_multiuse_exp(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.add %arg0, %2  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i8
  }]

def fold_add_sext_eq_4_fail_wrong_cond_before := [llvmfunc|
  llvm.func @fold_add_sext_eq_4_fail_wrong_cond(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "eq" %arg1, %0 : i8
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.add %arg0, %2  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i8
  }]

def fold_add_zext_eq_0_combined := [llvmfunc|
  llvm.func @fold_add_zext_eq_0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_fold_add_zext_eq_0   : fold_add_zext_eq_0_before  ⊑  fold_add_zext_eq_0_combined := by
  unfold fold_add_zext_eq_0_before fold_add_zext_eq_0_combined
  simp_alive_peephole
  sorry
def fold_add_sext_eq_4_6_combined := [llvmfunc|
  llvm.func @fold_add_sext_eq_4_6(%arg0: vector<2xi6>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, -127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi6> to vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    %3 = llvm.sext %2 : vector<2xi1> to vector<2xi8>
    %4 = llvm.add %3, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_fold_add_sext_eq_4_6   : fold_add_sext_eq_4_6_before  ⊑  fold_add_sext_eq_4_6_combined := by
  unfold fold_add_sext_eq_4_6_before fold_add_sext_eq_4_6_combined
  simp_alive_peephole
  sorry
def fold_add_zext_eq_0_fail_multiuse_exp_combined := [llvmfunc|
  llvm.func @fold_add_zext_eq_0_fail_multiuse_exp(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i8
  }]

theorem inst_combine_fold_add_zext_eq_0_fail_multiuse_exp   : fold_add_zext_eq_0_fail_multiuse_exp_before  ⊑  fold_add_zext_eq_0_fail_multiuse_exp_combined := by
  unfold fold_add_zext_eq_0_fail_multiuse_exp_before fold_add_zext_eq_0_fail_multiuse_exp_combined
  simp_alive_peephole
  sorry
def fold_add_sext_eq_4_fail_wrong_cond_combined := [llvmfunc|
  llvm.func @fold_add_sext_eq_4_fail_wrong_cond(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "eq" %arg1, %0 : i8
    %2 = llvm.sext %1 : i1 to i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i8
  }]

theorem inst_combine_fold_add_sext_eq_4_fail_wrong_cond   : fold_add_sext_eq_4_fail_wrong_cond_before  ⊑  fold_add_sext_eq_4_fail_wrong_cond_combined := by
  unfold fold_add_sext_eq_4_fail_wrong_cond_before fold_add_sext_eq_4_fail_wrong_cond_combined
  simp_alive_peephole
  sorry
