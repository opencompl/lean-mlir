import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  div-by-0-guard-before-smul_ov
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_smul_before := [llvmfunc|
  llvm.func @t0_smul(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i4
    %3 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.select %4, %2, %1 : i1, i1
    llvm.return %5 : i1
  }]

def t1_commutative_before := [llvmfunc|
  llvm.func @t1_commutative(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i4
    %3 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.select %2, %4, %1 : i1, i1
    llvm.return %5 : i1
  }]

def n2_wrong_size_before := [llvmfunc|
  llvm.func @n2_wrong_size(%arg0: i4, %arg1: i4, %arg2: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg1, %0 : i4
    %3 = "llvm.intr.smul.with.overflow"(%arg0, %arg2) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.select %4, %2, %1 : i1, i1
    llvm.return %5 : i1
  }]

def n3_wrong_pred_before := [llvmfunc|
  llvm.func @n3_wrong_pred(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : i4
    %3 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.select %4, %2, %1 : i1, i1
    llvm.return %5 : i1
  }]

def n4_not_and_before := [llvmfunc|
  llvm.func @n4_not_and(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i4
    %3 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.select %4, %1, %2 : i1, i1
    llvm.return %5 : i1
  }]

def n5_not_zero_before := [llvmfunc|
  llvm.func @n5_not_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %0 : i4
    %3 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.select %4, %2, %1 : i1, i1
    llvm.return %5 : i1
  }]

def t0_smul_combined := [llvmfunc|
  llvm.func @t0_smul(%arg0: i4, %arg1: i4) -> i1 {
    %0 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i4, i1)> 
    llvm.return %1 : i1
  }]

theorem inst_combine_t0_smul   : t0_smul_before  ⊑  t0_smul_combined := by
  unfold t0_smul_before t0_smul_combined
  simp_alive_peephole
  sorry
def t1_commutative_combined := [llvmfunc|
  llvm.func @t1_commutative(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.freeze %arg1 : i4
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i4, i1)> 
    llvm.return %2 : i1
  }]

theorem inst_combine_t1_commutative   : t1_commutative_before  ⊑  t1_commutative_combined := by
  unfold t1_commutative_before t1_commutative_combined
  simp_alive_peephole
  sorry
def n2_wrong_size_combined := [llvmfunc|
  llvm.func @n2_wrong_size(%arg0: i4, %arg1: i4, %arg2: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg1, %0 : i4
    %3 = "llvm.intr.smul.with.overflow"(%arg0, %arg2) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i4, i1)> 
    %5 = llvm.select %4, %2, %1 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_n2_wrong_size   : n2_wrong_size_before  ⊑  n2_wrong_size_combined := by
  unfold n2_wrong_size_before n2_wrong_size_combined
  simp_alive_peephole
  sorry
def n3_wrong_pred_combined := [llvmfunc|
  llvm.func @n3_wrong_pred(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_n3_wrong_pred   : n3_wrong_pred_before  ⊑  n3_wrong_pred_combined := by
  unfold n3_wrong_pred_before n3_wrong_pred_combined
  simp_alive_peephole
  sorry
def n4_not_and_combined := [llvmfunc|
  llvm.func @n4_not_and(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_n4_not_and   : n4_not_and_before  ⊑  n4_not_and_combined := by
  unfold n4_not_and_before n4_not_and_combined
  simp_alive_peephole
  sorry
def n5_not_zero_combined := [llvmfunc|
  llvm.func @n5_not_zero(%arg0: i4, %arg1: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.icmp "ne" %arg0, %0 : i4
    %2 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (i4, i4) -> !llvm.struct<(i4, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i4, i1)> 
    %4 = llvm.and %3, %1  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_n5_not_zero   : n5_not_zero_before  ⊑  n5_not_zero_combined := by
  unfold n5_not_zero_before n5_not_zero_combined
  simp_alive_peephole
  sorry
