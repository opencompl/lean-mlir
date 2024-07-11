import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-direction-in-bit-test
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def t1_ne_before := [llvmfunc|
  llvm.func @t1_ne(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def t2_vec_splat_before := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %3 = llvm.and %2, %arg2  : vector<4xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<4xi32>
    llvm.return %4 : vector<4xi1>
  }]

def t3_vec_splat_undef_before := [llvmfunc|
  llvm.func @t3_vec_splat_undef(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %12 = llvm.and %11, %arg2  : vector<4xi32>
    %13 = llvm.icmp "eq" %12, %10 : vector<4xi32>
    llvm.return %13 : vector<4xi1>
  }]

def t4_commutative_before := [llvmfunc|
  llvm.func @t4_commutative(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t5_twoshifts0_before := [llvmfunc|
  llvm.func @t5_twoshifts0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.shl %1, %arg2  : i32
    %3 = llvm.and %2, %arg3  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t6_twoshifts1_before := [llvmfunc|
  llvm.func @t6_twoshifts1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.shl %arg2, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t7_twoshifts2_before := [llvmfunc|
  llvm.func @t7_twoshifts2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.shl %arg2, %arg3  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t8_twoshifts3_before := [llvmfunc|
  llvm.func @t8_twoshifts3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.shl %0, %arg3  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t9_extrause0_before := [llvmfunc|
  llvm.func @t9_extrause0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def t10_extrause1_before := [llvmfunc|
  llvm.func @t10_extrause1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def t11_extrause2_before := [llvmfunc|
  llvm.func @t11_extrause2(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg2  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def t12_shift_of_const0_before := [llvmfunc|
  llvm.func @t12_shift_of_const0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def t13_shift_of_const1_before := [llvmfunc|
  llvm.func @t13_shift_of_const1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def t14_and_with_const0_before := [llvmfunc|
  llvm.func @t14_and_with_const0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def t15_and_with_const1_before := [llvmfunc|
  llvm.func @t15_and_with_const1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def n16_before := [llvmfunc|
  llvm.func @n16(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_ne_combined := [llvmfunc|
  llvm.func @t1_ne(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_t1_ne   : t1_ne_before  ⊑  t1_ne_combined := by
  unfold t1_ne_before t1_ne_combined
  simp_alive_peephole
  sorry
def t2_vec_splat_combined := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %3 = llvm.and %2, %arg2  : vector<4xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<4xi32>
    llvm.return %4 : vector<4xi1>
  }]

theorem inst_combine_t2_vec_splat   : t2_vec_splat_before  ⊑  t2_vec_splat_combined := by
  unfold t2_vec_splat_before t2_vec_splat_combined
  simp_alive_peephole
  sorry
def t3_vec_splat_undef_combined := [llvmfunc|
  llvm.func @t3_vec_splat_undef(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.shl %arg0, %arg1  : vector<4xi32>
    %12 = llvm.and %11, %arg2  : vector<4xi32>
    %13 = llvm.icmp "eq" %12, %10 : vector<4xi32>
    llvm.return %13 : vector<4xi1>
  }]

theorem inst_combine_t3_vec_splat_undef   : t3_vec_splat_undef_before  ⊑  t3_vec_splat_undef_combined := by
  unfold t3_vec_splat_undef_before t3_vec_splat_undef_combined
  simp_alive_peephole
  sorry
def t4_commutative_combined := [llvmfunc|
  llvm.func @t4_commutative(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.and %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t4_commutative   : t4_commutative_before  ⊑  t4_commutative_combined := by
  unfold t4_commutative_before t4_commutative_combined
  simp_alive_peephole
  sorry
def t5_twoshifts0_combined := [llvmfunc|
  llvm.func @t5_twoshifts0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.shl %1, %arg2  : i32
    %3 = llvm.and %2, %arg3  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t5_twoshifts0   : t5_twoshifts0_before  ⊑  t5_twoshifts0_combined := by
  unfold t5_twoshifts0_before t5_twoshifts0_combined
  simp_alive_peephole
  sorry
def t6_twoshifts1_combined := [llvmfunc|
  llvm.func @t6_twoshifts1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.shl %arg2, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t6_twoshifts1   : t6_twoshifts1_before  ⊑  t6_twoshifts1_combined := by
  unfold t6_twoshifts1_before t6_twoshifts1_combined
  simp_alive_peephole
  sorry
def t7_twoshifts2_combined := [llvmfunc|
  llvm.func @t7_twoshifts2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.shl %arg2, %arg3  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t7_twoshifts2   : t7_twoshifts2_before  ⊑  t7_twoshifts2_combined := by
  unfold t7_twoshifts2_before t7_twoshifts2_combined
  simp_alive_peephole
  sorry
def t8_twoshifts3_combined := [llvmfunc|
  llvm.func @t8_twoshifts3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %arg1  : i32
    %3 = llvm.shl %0, %arg3 overflow<nuw>  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t8_twoshifts3   : t8_twoshifts3_before  ⊑  t8_twoshifts3_combined := by
  unfold t8_twoshifts3_before t8_twoshifts3_combined
  simp_alive_peephole
  sorry
def t9_extrause0_combined := [llvmfunc|
  llvm.func @t9_extrause0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_t9_extrause0   : t9_extrause0_before  ⊑  t9_extrause0_combined := by
  unfold t9_extrause0_before t9_extrause0_combined
  simp_alive_peephole
  sorry
def t10_extrause1_combined := [llvmfunc|
  llvm.func @t10_extrause1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_t10_extrause1   : t10_extrause1_before  ⊑  t10_extrause1_combined := by
  unfold t10_extrause1_before t10_extrause1_combined
  simp_alive_peephole
  sorry
def t11_extrause2_combined := [llvmfunc|
  llvm.func @t11_extrause2(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg2  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_t11_extrause2   : t11_extrause2_before  ⊑  t11_extrause2_combined := by
  unfold t11_extrause2_before t11_extrause2_combined
  simp_alive_peephole
  sorry
def t12_shift_of_const0_combined := [llvmfunc|
  llvm.func @t12_shift_of_const0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t12_shift_of_const0   : t12_shift_of_const0_before  ⊑  t12_shift_of_const0_combined := by
  unfold t12_shift_of_const0_before t12_shift_of_const0_combined
  simp_alive_peephole
  sorry
def t13_shift_of_const1_combined := [llvmfunc|
  llvm.func @t13_shift_of_const1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg2  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t13_shift_of_const1   : t13_shift_of_const1_before  ⊑  t13_shift_of_const1_combined := by
  unfold t13_shift_of_const1_before t13_shift_of_const1_combined
  simp_alive_peephole
  sorry
def t14_and_with_const0_combined := [llvmfunc|
  llvm.func @t14_and_with_const0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t14_and_with_const0   : t14_and_with_const0_before  ⊑  t14_and_with_const0_combined := by
  unfold t14_and_with_const0_before t14_and_with_const0_combined
  simp_alive_peephole
  sorry
def t15_and_with_const1_combined := [llvmfunc|
  llvm.func @t15_and_with_const1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t15_and_with_const1   : t15_and_with_const1_before  ⊑  t15_and_with_const1_combined := by
  unfold t15_and_with_const1_before t15_and_with_const1_combined
  simp_alive_peephole
  sorry
def n16_combined := [llvmfunc|
  llvm.func @n16(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.and %1, %arg2  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_n16   : n16_before  ⊑  n16_combined := by
  unfold n16_before n16_combined
  simp_alive_peephole
  sorry
