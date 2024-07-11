import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  signed-mul-overflow-check-via-mul-sdiv
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def t1_vec_before := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mul %arg0, %arg1  : vector<2xi8>
    %1 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %2 = llvm.icmp "ne" %1, %arg1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def t2_commutative_before := [llvmfunc|
  llvm.func @t2_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.mul %0, %arg0  : i8
    %2 = llvm.sdiv %1, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.return %3 : i1
  }]

def t3_commutative_before := [llvmfunc|
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.mul %0, %arg0  : i8
    %2 = llvm.sdiv %1, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.return %3 : i1
  }]

def t4_commutative_before := [llvmfunc|
  llvm.func @t4_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.mul %0, %arg0  : i8
    %2 = llvm.sdiv %1, %arg0  : i8
    %3 = llvm.icmp "ne" %0, %2 : i8
    llvm.return %3 : i1
  }]

def t5_extrause0_before := [llvmfunc|
  llvm.func @t5_extrause0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def t6_extrause1_before := [llvmfunc|
  llvm.func @t6_extrause1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def t7_extrause2_before := [llvmfunc|
  llvm.func @t7_extrause2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sdiv %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def n8_different_x_before := [llvmfunc|
  llvm.func @n8_different_x(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg2  : i8
    %1 = llvm.sdiv %0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %arg2 : i8
    llvm.return %2 : i1
  }]

def n9_different_y_before := [llvmfunc|
  llvm.func @n9_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %arg2 : i8
    llvm.return %2 : i1
  }]

def n10_wrong_pred_before := [llvmfunc|
  llvm.func @n10_wrong_pred(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "ugt" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i8, i1)> 
    llvm.return %1 : i1
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vec_combined := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (vector<2xi8>, vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(vector<2xi8>, vector<2xi1>)> 
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_t1_vec   : t1_vec_before  ⊑  t1_vec_combined := by
  unfold t1_vec_before t1_vec_combined
  simp_alive_peephole
  sorry
def t2_commutative_combined := [llvmfunc|
  llvm.func @t2_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

theorem inst_combine_t2_commutative   : t2_commutative_before  ⊑  t2_commutative_combined := by
  unfold t2_commutative_before t2_commutative_combined
  simp_alive_peephole
  sorry
def t3_commutative_combined := [llvmfunc|
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

theorem inst_combine_t3_commutative   : t3_commutative_before  ⊑  t3_commutative_combined := by
  unfold t3_commutative_before t3_commutative_combined
  simp_alive_peephole
  sorry
def t4_commutative_combined := [llvmfunc|
  llvm.func @t4_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = "llvm.intr.smul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

theorem inst_combine_t4_commutative   : t4_commutative_before  ⊑  t4_commutative_combined := by
  unfold t4_commutative_before t4_commutative_combined
  simp_alive_peephole
  sorry
def t5_extrause0_combined := [llvmfunc|
  llvm.func @t5_extrause0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = "llvm.intr.smul.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i8, i1)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i8, i1)> 
    llvm.call @use8(%1) : (i8) -> ()
    llvm.return %2 : i1
  }]

theorem inst_combine_t5_extrause0   : t5_extrause0_before  ⊑  t5_extrause0_combined := by
  unfold t5_extrause0_before t5_extrause0_combined
  simp_alive_peephole
  sorry
def t6_extrause1_combined := [llvmfunc|
  llvm.func @t6_extrause1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t6_extrause1   : t6_extrause1_before  ⊑  t6_extrause1_combined := by
  unfold t6_extrause1_before t6_extrause1_combined
  simp_alive_peephole
  sorry
def t7_extrause2_combined := [llvmfunc|
  llvm.func @t7_extrause2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sdiv %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t7_extrause2   : t7_extrause2_before  ⊑  t7_extrause2_combined := by
  unfold t7_extrause2_before t7_extrause2_combined
  simp_alive_peephole
  sorry
def n8_different_x_combined := [llvmfunc|
  llvm.func @n8_different_x(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg2  : i8
    %1 = llvm.sdiv %0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %arg2 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n8_different_x   : n8_different_x_before  ⊑  n8_different_x_combined := by
  unfold n8_different_x_before n8_different_x_combined
  simp_alive_peephole
  sorry
def n9_different_y_combined := [llvmfunc|
  llvm.func @n9_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %arg2 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n9_different_y   : n9_different_y_before  ⊑  n9_different_y_combined := by
  unfold n9_different_y_before n9_different_y_combined
  simp_alive_peephole
  sorry
def n10_wrong_pred_combined := [llvmfunc|
  llvm.func @n10_wrong_pred(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.icmp "ugt" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n10_wrong_pred   : n10_wrong_pred_before  ⊑  n10_wrong_pred_combined := by
  unfold n10_wrong_pred_before n10_wrong_pred_combined
  simp_alive_peephole
  sorry
