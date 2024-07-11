import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unsigned-add-lack-of-overflow-check-via-add
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def t1_vec_before := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.add %arg0, %arg1  : vector<2xi8>
    llvm.call @use2x8(%0) : (vector<2xi8>) -> ()
    %1 = llvm.icmp "uge" %0, %arg1 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def t2_symmetry_before := [llvmfunc|
  llvm.func @t2_symmetry(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def t3_commutative_before := [llvmfunc|
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }]

def t4_commutative_before := [llvmfunc|
  llvm.func @t4_commutative() -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.add %0, %1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %1, %2 : i8
    llvm.return %3 : i1
  }]

def t5_commutative_before := [llvmfunc|
  llvm.func @t5_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %0, %1 : i8
    llvm.return %2 : i1
  }]

def t6_no_extrause_before := [llvmfunc|
  llvm.func @t6_no_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n7_different_y_before := [llvmfunc|
  llvm.func @n7_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg2 : i8
    llvm.return %1 : i1
  }]

def n8_wrong_pred0_before := [llvmfunc|
  llvm.func @n8_wrong_pred0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n9_wrong_pred1_before := [llvmfunc|
  llvm.func @n9_wrong_pred1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ugt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n10_wrong_pred2_before := [llvmfunc|
  llvm.func @n10_wrong_pred2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "eq" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n11_wrong_pred3_before := [llvmfunc|
  llvm.func @n11_wrong_pred3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ne" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n12_wrong_pred4_before := [llvmfunc|
  llvm.func @n12_wrong_pred4(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "slt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n13_wrong_pred5_before := [llvmfunc|
  llvm.func @n13_wrong_pred5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "sle" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n14_wrong_pred6_before := [llvmfunc|
  llvm.func @n14_wrong_pred6(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "sgt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n15_wrong_pred7_before := [llvmfunc|
  llvm.func @n15_wrong_pred7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "sge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vec_combined := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.add %arg0, %arg1  : vector<2xi8>
    llvm.call @use2x8(%0) : (vector<2xi8>) -> ()
    %1 = llvm.icmp "uge" %0, %arg1 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_t1_vec   : t1_vec_before  ⊑  t1_vec_combined := by
  unfold t1_vec_before t1_vec_combined
  simp_alive_peephole
  sorry
def t2_symmetry_combined := [llvmfunc|
  llvm.func @t2_symmetry(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t2_symmetry   : t2_symmetry_before  ⊑  t2_symmetry_combined := by
  unfold t2_symmetry_before t2_symmetry_combined
  simp_alive_peephole
  sorry
def t3_commutative_combined := [llvmfunc|
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t3_commutative   : t3_commutative_before  ⊑  t3_commutative_combined := by
  unfold t3_commutative_before t3_commutative_combined
  simp_alive_peephole
  sorry
def t4_commutative_combined := [llvmfunc|
  llvm.func @t4_commutative() -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.add %0, %1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %1, %2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t4_commutative   : t4_commutative_before  ⊑  t4_commutative_combined := by
  unfold t4_commutative_before t4_commutative_combined
  simp_alive_peephole
  sorry
def t5_commutative_combined := [llvmfunc|
  llvm.func @t5_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t5_commutative   : t5_commutative_before  ⊑  t5_commutative_combined := by
  unfold t5_commutative_before t5_commutative_combined
  simp_alive_peephole
  sorry
def t6_no_extrause_combined := [llvmfunc|
  llvm.func @t6_no_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.icmp "uge" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t6_no_extrause   : t6_no_extrause_before  ⊑  t6_no_extrause_combined := by
  unfold t6_no_extrause_before t6_no_extrause_combined
  simp_alive_peephole
  sorry
def n7_different_y_combined := [llvmfunc|
  llvm.func @n7_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg2 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n7_different_y   : n7_different_y_before  ⊑  n7_different_y_combined := by
  unfold n7_different_y_before n7_different_y_combined
  simp_alive_peephole
  sorry
def n8_wrong_pred0_combined := [llvmfunc|
  llvm.func @n8_wrong_pred0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ule" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n8_wrong_pred0   : n8_wrong_pred0_before  ⊑  n8_wrong_pred0_combined := by
  unfold n8_wrong_pred0_before n8_wrong_pred0_combined
  simp_alive_peephole
  sorry
def n9_wrong_pred1_combined := [llvmfunc|
  llvm.func @n9_wrong_pred1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ugt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n9_wrong_pred1   : n9_wrong_pred1_before  ⊑  n9_wrong_pred1_combined := by
  unfold n9_wrong_pred1_before n9_wrong_pred1_combined
  simp_alive_peephole
  sorry
def n10_wrong_pred2_combined := [llvmfunc|
  llvm.func @n10_wrong_pred2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n10_wrong_pred2   : n10_wrong_pred2_before  ⊑  n10_wrong_pred2_combined := by
  unfold n10_wrong_pred2_before n10_wrong_pred2_combined
  simp_alive_peephole
  sorry
def n11_wrong_pred3_combined := [llvmfunc|
  llvm.func @n11_wrong_pred3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n11_wrong_pred3   : n11_wrong_pred3_before  ⊑  n11_wrong_pred3_combined := by
  unfold n11_wrong_pred3_before n11_wrong_pred3_combined
  simp_alive_peephole
  sorry
def n12_wrong_pred4_combined := [llvmfunc|
  llvm.func @n12_wrong_pred4(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "slt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n12_wrong_pred4   : n12_wrong_pred4_before  ⊑  n12_wrong_pred4_combined := by
  unfold n12_wrong_pred4_before n12_wrong_pred4_combined
  simp_alive_peephole
  sorry
def n13_wrong_pred5_combined := [llvmfunc|
  llvm.func @n13_wrong_pred5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "sle" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n13_wrong_pred5   : n13_wrong_pred5_before  ⊑  n13_wrong_pred5_combined := by
  unfold n13_wrong_pred5_before n13_wrong_pred5_combined
  simp_alive_peephole
  sorry
def n14_wrong_pred6_combined := [llvmfunc|
  llvm.func @n14_wrong_pred6(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "sgt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n14_wrong_pred6   : n14_wrong_pred6_before  ⊑  n14_wrong_pred6_combined := by
  unfold n14_wrong_pred6_before n14_wrong_pred6_combined
  simp_alive_peephole
  sorry
def n15_wrong_pred7_combined := [llvmfunc|
  llvm.func @n15_wrong_pred7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "sge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n15_wrong_pred7   : n15_wrong_pred7_before  ⊑  n15_wrong_pred7_combined := by
  unfold n15_wrong_pred7_before n15_wrong_pred7_combined
  simp_alive_peephole
  sorry
