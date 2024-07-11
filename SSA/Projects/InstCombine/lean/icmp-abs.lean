import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-abs
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_sge_abs_before := [llvmfunc|
  llvm.func @icmp_sge_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "sge" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_sge_abs_false_before := [llvmfunc|
  llvm.func @icmp_sge_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "sge" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_eq_abs_before := [llvmfunc|
  llvm.func @icmp_eq_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "eq" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_eq_abs_false_before := [llvmfunc|
  llvm.func @icmp_eq_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "eq" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_ne_abs_before := [llvmfunc|
  llvm.func @icmp_ne_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "ne" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_ne_abs_false_before := [llvmfunc|
  llvm.func @icmp_ne_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "ne" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_sle_abs_before := [llvmfunc|
  llvm.func @icmp_sle_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "sle" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_sle_abs_false_before := [llvmfunc|
  llvm.func @icmp_sle_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "sle" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_slt_abs_before := [llvmfunc|
  llvm.func @icmp_slt_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "slt" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_slt_abs_false_before := [llvmfunc|
  llvm.func @icmp_slt_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "slt" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_sgt_abs_before := [llvmfunc|
  llvm.func @icmp_sgt_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "sgt" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_sgt_abs_false_before := [llvmfunc|
  llvm.func @icmp_sgt_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "sgt" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_ugt_abs_before := [llvmfunc|
  llvm.func @icmp_ugt_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "ugt" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_ugt_abs_false_before := [llvmfunc|
  llvm.func @icmp_ugt_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "ugt" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_uge_abs_before := [llvmfunc|
  llvm.func @icmp_uge_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "uge" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_uge_abs_false_before := [llvmfunc|
  llvm.func @icmp_uge_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "uge" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_ule_abs_before := [llvmfunc|
  llvm.func @icmp_ule_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "ule" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_ule_abs_false_before := [llvmfunc|
  llvm.func @icmp_ule_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "ule" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_ult_abs_before := [llvmfunc|
  llvm.func @icmp_ult_abs(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "ult" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_ult_abs_false_before := [llvmfunc|
  llvm.func @icmp_ult_abs_false(%arg0: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i4) -> i4]

    %1 = llvm.icmp "ult" %0, %arg0 : i4
    llvm.return %1 : i1
  }]

def icmp_sge_abs2_before := [llvmfunc|
  llvm.func @icmp_sge_abs2(%arg0: i4) -> i1 {
    %0 = llvm.mul %arg0, %arg0  : i4
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i4) -> i4]

    %2 = llvm.icmp "sge" %0, %1 : i4
    llvm.return %2 : i1
  }]

def icmp_sge_abs_mismatched_op_before := [llvmfunc|
  llvm.func @icmp_sge_abs_mismatched_op(%arg0: i4, %arg1: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4]

    %1 = llvm.icmp "sge" %0, %arg1 : i4
    llvm.return %1 : i1
  }]

def icmp_sge_abs_combined := [llvmfunc|
  llvm.func @icmp_sge_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_sge_abs   : icmp_sge_abs_before  ⊑  icmp_sge_abs_combined := by
  unfold icmp_sge_abs_before icmp_sge_abs_combined
  simp_alive_peephole
  sorry
def icmp_sge_abs_false_combined := [llvmfunc|
  llvm.func @icmp_sge_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_sge_abs_false   : icmp_sge_abs_false_before  ⊑  icmp_sge_abs_false_combined := by
  unfold icmp_sge_abs_false_before icmp_sge_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_eq_abs_combined := [llvmfunc|
  llvm.func @icmp_eq_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_eq_abs   : icmp_eq_abs_before  ⊑  icmp_eq_abs_combined := by
  unfold icmp_eq_abs_before icmp_eq_abs_combined
  simp_alive_peephole
  sorry
def icmp_eq_abs_false_combined := [llvmfunc|
  llvm.func @icmp_eq_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-7 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_eq_abs_false   : icmp_eq_abs_false_before  ⊑  icmp_eq_abs_false_combined := by
  unfold icmp_eq_abs_false_before icmp_eq_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_ne_abs_combined := [llvmfunc|
  llvm.func @icmp_ne_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ne_abs   : icmp_ne_abs_before  ⊑  icmp_ne_abs_combined := by
  unfold icmp_ne_abs_before icmp_ne_abs_combined
  simp_alive_peephole
  sorry
def icmp_ne_abs_false_combined := [llvmfunc|
  llvm.func @icmp_ne_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ne_abs_false   : icmp_ne_abs_false_before  ⊑  icmp_ne_abs_false_combined := by
  unfold icmp_ne_abs_false_before icmp_ne_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_sle_abs_combined := [llvmfunc|
  llvm.func @icmp_sle_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle_abs   : icmp_sle_abs_before  ⊑  icmp_sle_abs_combined := by
  unfold icmp_sle_abs_before icmp_sle_abs_combined
  simp_alive_peephole
  sorry
def icmp_sle_abs_false_combined := [llvmfunc|
  llvm.func @icmp_sle_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-7 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle_abs_false   : icmp_sle_abs_false_before  ⊑  icmp_sle_abs_false_combined := by
  unfold icmp_sle_abs_false_before icmp_sle_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_slt_abs_combined := [llvmfunc|
  llvm.func @icmp_slt_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_slt_abs   : icmp_slt_abs_before  ⊑  icmp_slt_abs_combined := by
  unfold icmp_slt_abs_before icmp_slt_abs_combined
  simp_alive_peephole
  sorry
def icmp_slt_abs_false_combined := [llvmfunc|
  llvm.func @icmp_slt_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_slt_abs_false   : icmp_slt_abs_false_before  ⊑  icmp_slt_abs_false_combined := by
  unfold icmp_slt_abs_false_before icmp_slt_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_sgt_abs_combined := [llvmfunc|
  llvm.func @icmp_sgt_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt_abs   : icmp_sgt_abs_before  ⊑  icmp_sgt_abs_combined := by
  unfold icmp_sgt_abs_before icmp_sgt_abs_combined
  simp_alive_peephole
  sorry
def icmp_sgt_abs_false_combined := [llvmfunc|
  llvm.func @icmp_sgt_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt_abs_false   : icmp_sgt_abs_false_before  ⊑  icmp_sgt_abs_false_combined := by
  unfold icmp_sgt_abs_false_before icmp_sgt_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_ugt_abs_combined := [llvmfunc|
  llvm.func @icmp_ugt_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_ugt_abs   : icmp_ugt_abs_before  ⊑  icmp_ugt_abs_combined := by
  unfold icmp_ugt_abs_before icmp_ugt_abs_combined
  simp_alive_peephole
  sorry
def icmp_ugt_abs_false_combined := [llvmfunc|
  llvm.func @icmp_ugt_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_ugt_abs_false   : icmp_ugt_abs_false_before  ⊑  icmp_ugt_abs_false_combined := by
  unfold icmp_ugt_abs_false_before icmp_ugt_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_uge_abs_combined := [llvmfunc|
  llvm.func @icmp_uge_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_uge_abs   : icmp_uge_abs_before  ⊑  icmp_uge_abs_combined := by
  unfold icmp_uge_abs_before icmp_uge_abs_combined
  simp_alive_peephole
  sorry
def icmp_uge_abs_false_combined := [llvmfunc|
  llvm.func @icmp_uge_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-7 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_uge_abs_false   : icmp_uge_abs_false_before  ⊑  icmp_uge_abs_false_combined := by
  unfold icmp_uge_abs_false_before icmp_uge_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_ule_abs_combined := [llvmfunc|
  llvm.func @icmp_ule_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_ule_abs   : icmp_ule_abs_before  ⊑  icmp_ule_abs_combined := by
  unfold icmp_ule_abs_before icmp_ule_abs_combined
  simp_alive_peephole
  sorry
def icmp_ule_abs_false_combined := [llvmfunc|
  llvm.func @icmp_ule_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_ule_abs_false   : icmp_ule_abs_false_before  ⊑  icmp_ule_abs_false_combined := by
  unfold icmp_ule_abs_false_before icmp_ule_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_ult_abs_combined := [llvmfunc|
  llvm.func @icmp_ult_abs(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ult_abs   : icmp_ult_abs_before  ⊑  icmp_ult_abs_combined := by
  unfold icmp_ult_abs_before icmp_ult_abs_combined
  simp_alive_peephole
  sorry
def icmp_ult_abs_false_combined := [llvmfunc|
  llvm.func @icmp_ult_abs_false(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ult_abs_false   : icmp_ult_abs_false_before  ⊑  icmp_ult_abs_false_combined := by
  unfold icmp_ult_abs_false_before icmp_ult_abs_false_combined
  simp_alive_peephole
  sorry
def icmp_sge_abs2_combined := [llvmfunc|
  llvm.func @icmp_sge_abs2(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.mul %arg0, %arg0  : i4
    %2 = llvm.icmp "sgt" %1, %0 : i4
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_sge_abs2   : icmp_sge_abs2_before  ⊑  icmp_sge_abs2_combined := by
  unfold icmp_sge_abs2_before icmp_sge_abs2_combined
  simp_alive_peephole
  sorry
def icmp_sge_abs_mismatched_op_combined := [llvmfunc|
  llvm.func @icmp_sge_abs_mismatched_op(%arg0: i4, %arg1: i4) -> i1 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i4) -> i4
    %1 = llvm.icmp "sge" %0, %arg1 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sge_abs_mismatched_op   : icmp_sge_abs_mismatched_op_before  ⊑  icmp_sge_abs_mismatched_op_combined := by
  unfold icmp_sge_abs_mismatched_op_before icmp_sge_abs_mismatched_op_combined
  simp_alive_peephole
  sorry
