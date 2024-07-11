import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-or-with-overflow-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ckd_add_unsigned_before := [llvmfunc|
  llvm.func @ckd_add_unsigned(%arg0: i31) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.zext %arg0 : i31 to i32
    %3 = "llvm.intr.sadd.with.overflow"(%2, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def ckd_add_unsigned_commuted_before := [llvmfunc|
  llvm.func @ckd_add_unsigned_commuted(%arg0: i31) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.zext %arg0 : i31 to i32
    %3 = "llvm.intr.sadd.with.overflow"(%2, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %5, %1 : i32
    %7 = llvm.or %6, %4  : i1
    llvm.return %7 : i1
  }]

def ckd_add_unsigned_imply_true_before := [llvmfunc|
  llvm.func @ckd_add_unsigned_imply_true(%arg0: i31) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.zext %arg0 : i31 to i32
    %3 = "llvm.intr.sadd.with.overflow"(%2, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "sgt" %5, %1 : i32
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def canonicalize_or_sadd_with_overflow_icmp_before := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_ssub_with_overflow_icmp_before := [llvmfunc|
  llvm.func @canonicalize_or_ssub_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_uadd_with_overflow_icmp_before := [llvmfunc|
  llvm.func @canonicalize_or_uadd_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_sadd_with_overflow_icmp_eq_before := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_uadd_with_overflow_icmp_ne_before := [llvmfunc|
  llvm.func @canonicalize_or_uadd_with_overflow_icmp_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_sadd_with_overflow_icmp_mismatched_pred_before := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_mismatched_pred(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_sadd_with_overflow_icmp_non_constant1_before := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_non_constant1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def canonicalize_or_sadd_with_overflow_icmp_non_constant2_before := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_non_constant2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "slt" %3, %arg1 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def canonicalize_or_sadd_with_overflow_icmp_multiuse_before := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_sadd_with_overflow_icmp_overflow_before := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_overflow(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_uadd_with_overflow_icmp_overflow_before := [llvmfunc|
  llvm.func @canonicalize_or_uadd_with_overflow_icmp_overflow(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_ssub_with_overflow_icmp_overflow_before := [llvmfunc|
  llvm.func @canonicalize_or_ssub_with_overflow_icmp_overflow(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def canonicalize_or_smul_with_overflow_icmp_before := [llvmfunc|
  llvm.func @canonicalize_or_smul_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

def ckd_add_unsigned_combined := [llvmfunc|
  llvm.func @ckd_add_unsigned(%arg0: i31) -> i1 {
    %0 = llvm.mlir.constant(-1 : i31) : i31
    %1 = llvm.icmp "eq" %arg0, %0 : i31
    llvm.return %1 : i1
  }]

theorem inst_combine_ckd_add_unsigned   : ckd_add_unsigned_before  ⊑  ckd_add_unsigned_combined := by
  unfold ckd_add_unsigned_before ckd_add_unsigned_combined
  simp_alive_peephole
  sorry
def ckd_add_unsigned_commuted_combined := [llvmfunc|
  llvm.func @ckd_add_unsigned_commuted(%arg0: i31) -> i1 {
    %0 = llvm.mlir.constant(-1 : i31) : i31
    %1 = llvm.icmp "eq" %arg0, %0 : i31
    llvm.return %1 : i1
  }]

theorem inst_combine_ckd_add_unsigned_commuted   : ckd_add_unsigned_commuted_before  ⊑  ckd_add_unsigned_commuted_combined := by
  unfold ckd_add_unsigned_commuted_before ckd_add_unsigned_commuted_combined
  simp_alive_peephole
  sorry
def ckd_add_unsigned_imply_true_combined := [llvmfunc|
  llvm.func @ckd_add_unsigned_imply_true(%arg0: i31) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ckd_add_unsigned_imply_true   : ckd_add_unsigned_imply_true_before  ⊑  ckd_add_unsigned_imply_true_combined := by
  unfold ckd_add_unsigned_imply_true_before ckd_add_unsigned_imply_true_combined
  simp_alive_peephole
  sorry
def canonicalize_or_sadd_with_overflow_icmp_combined := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_canonicalize_or_sadd_with_overflow_icmp   : canonicalize_or_sadd_with_overflow_icmp_before  ⊑  canonicalize_or_sadd_with_overflow_icmp_combined := by
  unfold canonicalize_or_sadd_with_overflow_icmp_before canonicalize_or_sadd_with_overflow_icmp_combined
  simp_alive_peephole
  sorry
def canonicalize_or_ssub_with_overflow_icmp_combined := [llvmfunc|
  llvm.func @canonicalize_or_ssub_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_canonicalize_or_ssub_with_overflow_icmp   : canonicalize_or_ssub_with_overflow_icmp_before  ⊑  canonicalize_or_ssub_with_overflow_icmp_combined := by
  unfold canonicalize_or_ssub_with_overflow_icmp_before canonicalize_or_ssub_with_overflow_icmp_combined
  simp_alive_peephole
  sorry
def canonicalize_or_uadd_with_overflow_icmp_combined := [llvmfunc|
  llvm.func @canonicalize_or_uadd_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_canonicalize_or_uadd_with_overflow_icmp   : canonicalize_or_uadd_with_overflow_icmp_before  ⊑  canonicalize_or_uadd_with_overflow_icmp_combined := by
  unfold canonicalize_or_uadd_with_overflow_icmp_before canonicalize_or_uadd_with_overflow_icmp_combined
  simp_alive_peephole
  sorry
def canonicalize_or_sadd_with_overflow_icmp_eq_combined := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_canonicalize_or_sadd_with_overflow_icmp_eq   : canonicalize_or_sadd_with_overflow_icmp_eq_before  ⊑  canonicalize_or_sadd_with_overflow_icmp_eq_combined := by
  unfold canonicalize_or_sadd_with_overflow_icmp_eq_before canonicalize_or_sadd_with_overflow_icmp_eq_combined
  simp_alive_peephole
  sorry
def canonicalize_or_uadd_with_overflow_icmp_ne_combined := [llvmfunc|
  llvm.func @canonicalize_or_uadd_with_overflow_icmp_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_canonicalize_or_uadd_with_overflow_icmp_ne   : canonicalize_or_uadd_with_overflow_icmp_ne_before  ⊑  canonicalize_or_uadd_with_overflow_icmp_ne_combined := by
  unfold canonicalize_or_uadd_with_overflow_icmp_ne_before canonicalize_or_uadd_with_overflow_icmp_ne_combined
  simp_alive_peephole
  sorry
def canonicalize_or_sadd_with_overflow_icmp_mismatched_pred_combined := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_mismatched_pred(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_canonicalize_or_sadd_with_overflow_icmp_mismatched_pred   : canonicalize_or_sadd_with_overflow_icmp_mismatched_pred_before  ⊑  canonicalize_or_sadd_with_overflow_icmp_mismatched_pred_combined := by
  unfold canonicalize_or_sadd_with_overflow_icmp_mismatched_pred_before canonicalize_or_sadd_with_overflow_icmp_mismatched_pred_combined
  simp_alive_peephole
  sorry
def canonicalize_or_sadd_with_overflow_icmp_non_constant1_combined := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_non_constant1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "slt" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_canonicalize_or_sadd_with_overflow_icmp_non_constant1   : canonicalize_or_sadd_with_overflow_icmp_non_constant1_before  ⊑  canonicalize_or_sadd_with_overflow_icmp_non_constant1_combined := by
  unfold canonicalize_or_sadd_with_overflow_icmp_non_constant1_before canonicalize_or_sadd_with_overflow_icmp_non_constant1_combined
  simp_alive_peephole
  sorry
def canonicalize_or_sadd_with_overflow_icmp_non_constant2_combined := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_non_constant2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.icmp "slt" %3, %arg1 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_canonicalize_or_sadd_with_overflow_icmp_non_constant2   : canonicalize_or_sadd_with_overflow_icmp_non_constant2_before  ⊑  canonicalize_or_sadd_with_overflow_icmp_non_constant2_combined := by
  unfold canonicalize_or_sadd_with_overflow_icmp_non_constant2_before canonicalize_or_sadd_with_overflow_icmp_non_constant2_combined
  simp_alive_peephole
  sorry
def canonicalize_or_sadd_with_overflow_icmp_multiuse_combined := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    llvm.call @use(%5) : (i1) -> ()
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_canonicalize_or_sadd_with_overflow_icmp_multiuse   : canonicalize_or_sadd_with_overflow_icmp_multiuse_before  ⊑  canonicalize_or_sadd_with_overflow_icmp_multiuse_combined := by
  unfold canonicalize_or_sadd_with_overflow_icmp_multiuse_before canonicalize_or_sadd_with_overflow_icmp_multiuse_combined
  simp_alive_peephole
  sorry
def canonicalize_or_sadd_with_overflow_icmp_overflow_combined := [llvmfunc|
  llvm.func @canonicalize_or_sadd_with_overflow_icmp_overflow(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.sadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_canonicalize_or_sadd_with_overflow_icmp_overflow   : canonicalize_or_sadd_with_overflow_icmp_overflow_before  ⊑  canonicalize_or_sadd_with_overflow_icmp_overflow_combined := by
  unfold canonicalize_or_sadd_with_overflow_icmp_overflow_before canonicalize_or_sadd_with_overflow_icmp_overflow_combined
  simp_alive_peephole
  sorry
def canonicalize_or_uadd_with_overflow_icmp_overflow_combined := [llvmfunc|
  llvm.func @canonicalize_or_uadd_with_overflow_icmp_overflow(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_canonicalize_or_uadd_with_overflow_icmp_overflow   : canonicalize_or_uadd_with_overflow_icmp_overflow_before  ⊑  canonicalize_or_uadd_with_overflow_icmp_overflow_combined := by
  unfold canonicalize_or_uadd_with_overflow_icmp_overflow_before canonicalize_or_uadd_with_overflow_icmp_overflow_combined
  simp_alive_peephole
  sorry
def canonicalize_or_ssub_with_overflow_icmp_overflow_combined := [llvmfunc|
  llvm.func @canonicalize_or_ssub_with_overflow_icmp_overflow(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_canonicalize_or_ssub_with_overflow_icmp_overflow   : canonicalize_or_ssub_with_overflow_icmp_overflow_before  ⊑  canonicalize_or_ssub_with_overflow_icmp_overflow_combined := by
  unfold canonicalize_or_ssub_with_overflow_icmp_overflow_before canonicalize_or_ssub_with_overflow_icmp_overflow_combined
  simp_alive_peephole
  sorry
def canonicalize_or_smul_with_overflow_icmp_combined := [llvmfunc|
  llvm.func @canonicalize_or_smul_with_overflow_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.icmp "slt" %4, %1 : i32
    %6 = llvm.or %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_canonicalize_or_smul_with_overflow_icmp   : canonicalize_or_smul_with_overflow_icmp_before  ⊑  canonicalize_or_smul_with_overflow_icmp_combined := by
  unfold canonicalize_or_smul_with_overflow_icmp_before canonicalize_or_smul_with_overflow_icmp_combined
  simp_alive_peephole
  sorry
