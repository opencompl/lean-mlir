import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-shl
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shl_nuw_eq_0_before := [llvmfunc|
  llvm.func @shl_nuw_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_nsw_ne_0_before := [llvmfunc|
  llvm.func @shl_nsw_ne_0(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def shl_eq_0_fail_missing_flags_before := [llvmfunc|
  llvm.func @shl_eq_0_fail_missing_flags(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.shl %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_ne_1_fail_nonzero_before := [llvmfunc|
  llvm.func @shl_ne_1_fail_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_nsw_slt_1_before := [llvmfunc|
  llvm.func @shl_nsw_slt_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_vec_nsw_slt_1_0_todo_non_splat_before := [llvmfunc|
  llvm.func @shl_vec_nsw_slt_1_0_todo_non_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def shl_nsw_sle_n1_before := [llvmfunc|
  llvm.func @shl_nsw_sle_n1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.icmp "sle" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def shl_nsw_sge_1_before := [llvmfunc|
  llvm.func @shl_nsw_sge_1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.icmp "sge" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def shl_nsw_sgt_n1_before := [llvmfunc|
  llvm.func @shl_nsw_sgt_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_nuw_sgt_n1_fail_wrong_flag_before := [llvmfunc|
  llvm.func @shl_nuw_sgt_n1_fail_wrong_flag(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_nsw_nuw_ult_Csle0_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_ult_Csle0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-19 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_nsw_ule_Csle0_fail_missing_flag_before := [llvmfunc|
  llvm.func @shl_nsw_ule_Csle0_fail_missing_flag(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-19 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.icmp "ule" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_nsw_nuw_uge_Csle0_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_uge_Csle0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-120 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_nuw_ugt_Csle0_fail_missing_flag_before := [llvmfunc|
  llvm.func @shl_nuw_ugt_Csle0_fail_missing_flag(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-19 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def shl_nsw_nuw_sgt_Csle0_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_sgt_Csle0(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def shl_nsw_nuw_sge_Csle0_todo_non_splat_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_sge_Csle0_todo_non_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-10, -65]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "sge" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def shl_nsw_nuw_sle_Csle0_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_sle_Csle0(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "sle" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def shl_nsw_nuw_slt_Csle0_fail_positive_before := [llvmfunc|
  llvm.func @shl_nsw_nuw_slt_Csle0_fail_positive(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def shl_nuw_eq_0_combined := [llvmfunc|
  llvm.func @shl_nuw_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_shl_nuw_eq_0   : shl_nuw_eq_0_before  ⊑  shl_nuw_eq_0_combined := by
  unfold shl_nuw_eq_0_before shl_nuw_eq_0_combined
  simp_alive_peephole
  sorry
def shl_nsw_ne_0_combined := [llvmfunc|
  llvm.func @shl_nsw_ne_0(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_shl_nsw_ne_0   : shl_nsw_ne_0_before  ⊑  shl_nsw_ne_0_combined := by
  unfold shl_nsw_ne_0_before shl_nsw_ne_0_combined
  simp_alive_peephole
  sorry
def shl_eq_0_fail_missing_flags_combined := [llvmfunc|
  llvm.func @shl_eq_0_fail_missing_flags(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.shl %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_shl_eq_0_fail_missing_flags   : shl_eq_0_fail_missing_flags_before  ⊑  shl_eq_0_fail_missing_flags_combined := by
  unfold shl_eq_0_fail_missing_flags_before shl_eq_0_fail_missing_flags_combined
  simp_alive_peephole
  sorry
def shl_ne_1_fail_nonzero_combined := [llvmfunc|
  llvm.func @shl_ne_1_fail_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_shl_ne_1_fail_nonzero   : shl_ne_1_fail_nonzero_before  ⊑  shl_ne_1_fail_nonzero_combined := by
  unfold shl_ne_1_fail_nonzero_before shl_ne_1_fail_nonzero_combined
  simp_alive_peephole
  sorry
def shl_nsw_slt_1_combined := [llvmfunc|
  llvm.func @shl_nsw_slt_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_shl_nsw_slt_1   : shl_nsw_slt_1_before  ⊑  shl_nsw_slt_1_combined := by
  unfold shl_nsw_slt_1_before shl_nsw_slt_1_combined
  simp_alive_peephole
  sorry
def shl_vec_nsw_slt_1_0_todo_non_splat_combined := [llvmfunc|
  llvm.func @shl_vec_nsw_slt_1_0_todo_non_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_shl_vec_nsw_slt_1_0_todo_non_splat   : shl_vec_nsw_slt_1_0_todo_non_splat_before  ⊑  shl_vec_nsw_slt_1_0_todo_non_splat_combined := by
  unfold shl_vec_nsw_slt_1_0_todo_non_splat_before shl_vec_nsw_slt_1_0_todo_non_splat_combined
  simp_alive_peephole
  sorry
def shl_nsw_sle_n1_combined := [llvmfunc|
  llvm.func @shl_nsw_sle_n1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_shl_nsw_sle_n1   : shl_nsw_sle_n1_before  ⊑  shl_nsw_sle_n1_combined := by
  unfold shl_nsw_sle_n1_before shl_nsw_sle_n1_combined
  simp_alive_peephole
  sorry
def shl_nsw_sge_1_combined := [llvmfunc|
  llvm.func @shl_nsw_sge_1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "sgt" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_shl_nsw_sge_1   : shl_nsw_sge_1_before  ⊑  shl_nsw_sge_1_combined := by
  unfold shl_nsw_sge_1_before shl_nsw_sge_1_combined
  simp_alive_peephole
  sorry
def shl_nsw_sgt_n1_combined := [llvmfunc|
  llvm.func @shl_nsw_sgt_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_shl_nsw_sgt_n1   : shl_nsw_sgt_n1_before  ⊑  shl_nsw_sgt_n1_combined := by
  unfold shl_nsw_sgt_n1_before shl_nsw_sgt_n1_combined
  simp_alive_peephole
  sorry
def shl_nuw_sgt_n1_fail_wrong_flag_combined := [llvmfunc|
  llvm.func @shl_nuw_sgt_n1_fail_wrong_flag(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_shl_nuw_sgt_n1_fail_wrong_flag   : shl_nuw_sgt_n1_fail_wrong_flag_before  ⊑  shl_nuw_sgt_n1_fail_wrong_flag_combined := by
  unfold shl_nuw_sgt_n1_fail_wrong_flag_before shl_nuw_sgt_n1_fail_wrong_flag_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_ult_Csle0_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_ult_Csle0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-19 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_shl_nsw_nuw_ult_Csle0   : shl_nsw_nuw_ult_Csle0_before  ⊑  shl_nsw_nuw_ult_Csle0_combined := by
  unfold shl_nsw_nuw_ult_Csle0_before shl_nsw_nuw_ult_Csle0_combined
  simp_alive_peephole
  sorry
def shl_nsw_ule_Csle0_fail_missing_flag_combined := [llvmfunc|
  llvm.func @shl_nsw_ule_Csle0_fail_missing_flag(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-18 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_shl_nsw_ule_Csle0_fail_missing_flag   : shl_nsw_ule_Csle0_fail_missing_flag_before  ⊑  shl_nsw_ule_Csle0_fail_missing_flag_combined := by
  unfold shl_nsw_ule_Csle0_fail_missing_flag_before shl_nsw_ule_Csle0_fail_missing_flag_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_uge_Csle0_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_uge_Csle0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-121 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_shl_nsw_nuw_uge_Csle0   : shl_nsw_nuw_uge_Csle0_before  ⊑  shl_nsw_nuw_uge_Csle0_combined := by
  unfold shl_nsw_nuw_uge_Csle0_before shl_nsw_nuw_uge_Csle0_combined
  simp_alive_peephole
  sorry
def shl_nuw_ugt_Csle0_fail_missing_flag_combined := [llvmfunc|
  llvm.func @shl_nuw_ugt_Csle0_fail_missing_flag(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-19 : i8) : i8
    %1 = llvm.shl %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_shl_nuw_ugt_Csle0_fail_missing_flag   : shl_nuw_ugt_Csle0_fail_missing_flag_before  ⊑  shl_nuw_ugt_Csle0_fail_missing_flag_combined := by
  unfold shl_nuw_ugt_Csle0_fail_missing_flag_before shl_nuw_ugt_Csle0_fail_missing_flag_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_sgt_Csle0_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_sgt_Csle0(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-10> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_shl_nsw_nuw_sgt_Csle0   : shl_nsw_nuw_sgt_Csle0_before  ⊑  shl_nsw_nuw_sgt_Csle0_combined := by
  unfold shl_nsw_nuw_sgt_Csle0_before shl_nsw_nuw_sgt_Csle0_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_sge_Csle0_todo_non_splat_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_sge_Csle0_todo_non_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-11, -66]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_shl_nsw_nuw_sge_Csle0_todo_non_splat   : shl_nsw_nuw_sge_Csle0_todo_non_splat_before  ⊑  shl_nsw_nuw_sge_Csle0_todo_non_splat_combined := by
  unfold shl_nsw_nuw_sge_Csle0_todo_non_splat_before shl_nsw_nuw_sge_Csle0_todo_non_splat_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_sle_Csle0_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_sle_Csle0(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_shl_nsw_nuw_sle_Csle0   : shl_nsw_nuw_sle_Csle0_before  ⊑  shl_nsw_nuw_sle_Csle0_combined := by
  unfold shl_nsw_nuw_sle_Csle0_before shl_nsw_nuw_sle_Csle0_combined
  simp_alive_peephole
  sorry
def shl_nsw_nuw_slt_Csle0_fail_positive_combined := [llvmfunc|
  llvm.func @shl_nsw_nuw_slt_Csle0_fail_positive(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : vector<2xi8>
    %2 = llvm.icmp "slt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_shl_nsw_nuw_slt_Csle0_fail_positive   : shl_nsw_nuw_slt_Csle0_fail_positive_before  ⊑  shl_nsw_nuw_slt_Csle0_fail_positive_combined := by
  unfold shl_nsw_nuw_slt_Csle0_fail_positive_before shl_nsw_nuw_slt_Csle0_fail_positive_combined
  simp_alive_peephole
  sorry
