import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unsigned-add-lack-of-overflow-check
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def t1_vec_before := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.add %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "uge" %0, %arg1 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def t2_symmetry_before := [llvmfunc|
  llvm.func @t2_symmetry(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def t3_commutative_before := [llvmfunc|
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }]

def t4_commutative_before := [llvmfunc|
  llvm.func @t4_commutative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ule" %arg1, %0 : i8
    llvm.return %1 : i1
  }]

def t5_commutative_before := [llvmfunc|
  llvm.func @t5_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = llvm.add %0, %arg0  : i8
    %2 = llvm.icmp "ule" %0, %1 : i8
    llvm.return %2 : i1
  }]

def t6_extrause_before := [llvmfunc|
  llvm.func @t6_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n7_different_y_before := [llvmfunc|
  llvm.func @n7_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "uge" %0, %arg2 : i8
    llvm.return %1 : i1
  }]

def n8_wrong_pred0_before := [llvmfunc|
  llvm.func @n8_wrong_pred0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ule" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n9_wrong_pred1_before := [llvmfunc|
  llvm.func @n9_wrong_pred1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n10_wrong_pred2_before := [llvmfunc|
  llvm.func @n10_wrong_pred2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "eq" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n11_wrong_pred3_before := [llvmfunc|
  llvm.func @n11_wrong_pred3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "ne" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n12_wrong_pred4_before := [llvmfunc|
  llvm.func @n12_wrong_pred4(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "slt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n13_wrong_pred5_before := [llvmfunc|
  llvm.func @n13_wrong_pred5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "sle" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n14_wrong_pred6_before := [llvmfunc|
  llvm.func @n14_wrong_pred6(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "sgt" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def n15_wrong_pred7_before := [llvmfunc|
  llvm.func @n15_wrong_pred7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.icmp "sge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def low_bitmask_ult_before := [llvmfunc|
  llvm.func @low_bitmask_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def low_bitmask_uge_before := [llvmfunc|
  llvm.func @low_bitmask_uge(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.add %arg0, %6  : vector<2xi8>
    %9 = llvm.and %8, %7  : vector<2xi8>
    %10 = llvm.icmp "uge" %9, %arg0 : vector<2xi8>
    llvm.return %10 : vector<2xi1>
  }]

def low_bitmask_ugt_before := [llvmfunc|
  llvm.func @low_bitmask_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }]

def low_bitmask_ule_before := [llvmfunc|
  llvm.func @low_bitmask_ule(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mul %arg0, %arg0  : vector<2xi8>
    %2 = llvm.add %1, %0  : vector<2xi8>
    %3 = llvm.and %2, %0  : vector<2xi8>
    %4 = llvm.icmp "ule" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def low_bitmask_ult_use_before := [llvmfunc|
  llvm.func @low_bitmask_ult_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def low_bitmask_ugt_use_before := [llvmfunc|
  llvm.func @low_bitmask_ugt_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.add %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }]

def low_bitmask_ult_wrong_mask1_before := [llvmfunc|
  llvm.func @low_bitmask_ult_wrong_mask1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(30 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def low_bitmask_uge_wrong_mask2_before := [llvmfunc|
  llvm.func @low_bitmask_uge_wrong_mask2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "uge" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def low_bitmask_ugt_swapped_before := [llvmfunc|
  llvm.func @low_bitmask_ugt_swapped(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ugt" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def low_bitmask_sgt_before := [llvmfunc|
  llvm.func @low_bitmask_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "sgt" %1, %3 : i8
    llvm.return %4 : i1
  }]

def low_bitmask_ult_specific_op_before := [llvmfunc|
  llvm.func @low_bitmask_ult_specific_op(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.return %3 : i1
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.icmp "uge" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vec_combined := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg1, %0  : vector<2xi8>
    %2 = llvm.icmp "uge" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_t1_vec   : t1_vec_before  ⊑  t1_vec_combined := by
  unfold t1_vec_before t1_vec_combined
  simp_alive_peephole
  sorry
def t2_symmetry_combined := [llvmfunc|
  llvm.func @t2_symmetry(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.icmp "uge" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t2_symmetry   : t2_symmetry_before  ⊑  t2_symmetry_combined := by
  unfold t2_symmetry_before t2_symmetry_combined
  simp_alive_peephole
  sorry
def t3_commutative_combined := [llvmfunc|
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t3_commutative   : t3_commutative_before  ⊑  t3_commutative_combined := by
  unfold t3_commutative_before t3_commutative_combined
  simp_alive_peephole
  sorry
def t4_commutative_combined := [llvmfunc|
  llvm.func @t4_commutative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.icmp "uge" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t4_commutative   : t4_commutative_before  ⊑  t4_commutative_combined := by
  unfold t4_commutative_before t4_commutative_combined
  simp_alive_peephole
  sorry
def t5_commutative_combined := [llvmfunc|
  llvm.func @t5_commutative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t5_commutative   : t5_commutative_before  ⊑  t5_commutative_combined := by
  unfold t5_commutative_before t5_commutative_combined
  simp_alive_peephole
  sorry
def t6_extrause_combined := [llvmfunc|
  llvm.func @t6_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "uge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t6_extrause   : t6_extrause_before  ⊑  t6_extrause_combined := by
  unfold t6_extrause_before t6_extrause_combined
  simp_alive_peephole
  sorry
def n7_different_y_combined := [llvmfunc|
  llvm.func @n7_different_y(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
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
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n10_wrong_pred2   : n10_wrong_pred2_before  ⊑  n10_wrong_pred2_combined := by
  unfold n10_wrong_pred2_before n10_wrong_pred2_combined
  simp_alive_peephole
  sorry
def n11_wrong_pred3_combined := [llvmfunc|
  llvm.func @n11_wrong_pred3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n11_wrong_pred3   : n11_wrong_pred3_before  ⊑  n11_wrong_pred3_combined := by
  unfold n11_wrong_pred3_before n11_wrong_pred3_combined
  simp_alive_peephole
  sorry
def n12_wrong_pred4_combined := [llvmfunc|
  llvm.func @n12_wrong_pred4(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.add %arg0, %arg1  : i8
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
    %1 = llvm.icmp "sge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n15_wrong_pred7   : n15_wrong_pred7_before  ⊑  n15_wrong_pred7_combined := by
  unfold n15_wrong_pred7_before n15_wrong_pred7_combined
  simp_alive_peephole
  sorry
def low_bitmask_ult_combined := [llvmfunc|
  llvm.func @low_bitmask_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_low_bitmask_ult   : low_bitmask_ult_before  ⊑  low_bitmask_ult_combined := by
  unfold low_bitmask_ult_before low_bitmask_ult_combined
  simp_alive_peephole
  sorry
def low_bitmask_uge_combined := [llvmfunc|
  llvm.func @low_bitmask_uge(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_low_bitmask_uge   : low_bitmask_uge_before  ⊑  low_bitmask_uge_combined := by
  unfold low_bitmask_uge_before low_bitmask_uge_combined
  simp_alive_peephole
  sorry
def low_bitmask_ugt_combined := [llvmfunc|
  llvm.func @low_bitmask_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_low_bitmask_ugt   : low_bitmask_ugt_before  ⊑  low_bitmask_ugt_combined := by
  unfold low_bitmask_ugt_before low_bitmask_ugt_combined
  simp_alive_peephole
  sorry
def low_bitmask_ule_combined := [llvmfunc|
  llvm.func @low_bitmask_ule(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %arg0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_low_bitmask_ule   : low_bitmask_ule_before  ⊑  low_bitmask_ule_combined := by
  unfold low_bitmask_ule_before low_bitmask_ule_combined
  simp_alive_peephole
  sorry
def low_bitmask_ult_use_combined := [llvmfunc|
  llvm.func @low_bitmask_ult_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %arg0, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_low_bitmask_ult_use   : low_bitmask_ult_use_before  ⊑  low_bitmask_ult_use_combined := by
  unfold low_bitmask_ult_use_before low_bitmask_ult_use_combined
  simp_alive_peephole
  sorry
def low_bitmask_ugt_use_combined := [llvmfunc|
  llvm.func @low_bitmask_ugt_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mul %arg0, %arg0  : i8
    %3 = llvm.add %2, %0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_low_bitmask_ugt_use   : low_bitmask_ugt_use_before  ⊑  low_bitmask_ugt_use_combined := by
  unfold low_bitmask_ugt_use_before low_bitmask_ugt_use_combined
  simp_alive_peephole
  sorry
def low_bitmask_ult_wrong_mask1_combined := [llvmfunc|
  llvm.func @low_bitmask_ult_wrong_mask1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(30 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_low_bitmask_ult_wrong_mask1   : low_bitmask_ult_wrong_mask1_before  ⊑  low_bitmask_ult_wrong_mask1_combined := by
  unfold low_bitmask_ult_wrong_mask1_before low_bitmask_ult_wrong_mask1_combined
  simp_alive_peephole
  sorry
def low_bitmask_uge_wrong_mask2_combined := [llvmfunc|
  llvm.func @low_bitmask_uge_wrong_mask2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "uge" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_low_bitmask_uge_wrong_mask2   : low_bitmask_uge_wrong_mask2_before  ⊑  low_bitmask_uge_wrong_mask2_combined := by
  unfold low_bitmask_uge_wrong_mask2_before low_bitmask_uge_wrong_mask2_combined
  simp_alive_peephole
  sorry
def low_bitmask_ugt_swapped_combined := [llvmfunc|
  llvm.func @low_bitmask_ugt_swapped(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ugt" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_low_bitmask_ugt_swapped   : low_bitmask_ugt_swapped_before  ⊑  low_bitmask_ugt_swapped_combined := by
  unfold low_bitmask_ugt_swapped_before low_bitmask_ugt_swapped_combined
  simp_alive_peephole
  sorry
def low_bitmask_sgt_combined := [llvmfunc|
  llvm.func @low_bitmask_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "sgt" %1, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_low_bitmask_sgt   : low_bitmask_sgt_before  ⊑  low_bitmask_sgt_combined := by
  unfold low_bitmask_sgt_before low_bitmask_sgt_combined
  simp_alive_peephole
  sorry
def low_bitmask_ult_specific_op_combined := [llvmfunc|
  llvm.func @low_bitmask_ult_specific_op(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_low_bitmask_ult_specific_op   : low_bitmask_ult_specific_op_before  ⊑  low_bitmask_ult_specific_op_combined := by
  unfold low_bitmask_ult_specific_op_before low_bitmask_ult_specific_op_combined
  simp_alive_peephole
  sorry
