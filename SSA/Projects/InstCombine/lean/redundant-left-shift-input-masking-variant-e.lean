import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  redundant-left-shift-input-masking-variant-e
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def t1_bigger_shift_before := [llvmfunc|
  llvm.func @t1_bigger_shift(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %2, %3  : i32
    llvm.return %4 : i32
  }]

def t2_vec_splat_before := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<3xi32>
    %2 = llvm.lshr %1, %arg1  : vector<3xi32>
    %3 = llvm.add %arg1, %0  : vector<3xi32>
    llvm.call @use3xi32(%1) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    %4 = llvm.shl %2, %3  : vector<3xi32>
    llvm.return %4 : vector<3xi32>
  }]

def t3_vec_nonsplat_before := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[1, 0, 2]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<3xi32>
    %2 = llvm.lshr %1, %arg1  : vector<3xi32>
    %3 = llvm.add %arg1, %0  : vector<3xi32>
    llvm.call @use3xi32(%1) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    %4 = llvm.shl %2, %3  : vector<3xi32>
    llvm.return %4 : vector<3xi32>
  }]

def t4_vec_undef_before := [llvmfunc|
  llvm.func @t4_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.shl %arg0, %arg1  : vector<3xi32>
    %10 = llvm.lshr %9, %arg1  : vector<3xi32>
    %11 = llvm.add %arg1, %8  : vector<3xi32>
    llvm.call @use3xi32(%9) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%10) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%11) : (vector<3xi32>) -> ()
    %12 = llvm.shl %10, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

def t5_nuw_before := [llvmfunc|
  llvm.func @t5_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1 overflow<nuw>  : i32
    llvm.return %2 : i32
  }]

def t6_nsw_before := [llvmfunc|
  llvm.func @t6_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

def t7_nuw_nsw_before := [llvmfunc|
  llvm.func @t7_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }]

def t8_assume_uge_before := [llvmfunc|
  llvm.func @t8_assume_uge(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "uge" %arg2, %arg1 : i32
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %arg2  : i32
    llvm.return %3 : i32
  }]

def n9_different_shamts0_before := [llvmfunc|
  llvm.func @n9_different_shamts0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def n10_different_shamts1_before := [llvmfunc|
  llvm.func @n10_different_shamts1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg2  : i32
    llvm.return %2 : i32
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %0 : i32
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_bigger_shift_combined := [llvmfunc|
  llvm.func @t1_bigger_shift(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    %3 = llvm.add %arg1, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %arg0, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_t1_bigger_shift   : t1_bigger_shift_before  ⊑  t1_bigger_shift_combined := by
  unfold t1_bigger_shift_before t1_bigger_shift_combined
  simp_alive_peephole
  sorry
def t2_vec_splat_combined := [llvmfunc|
  llvm.func @t2_vec_splat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<3xi32>
    %2 = llvm.lshr %1, %arg1  : vector<3xi32>
    %3 = llvm.add %arg1, %0  : vector<3xi32>
    llvm.call @use3xi32(%1) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    %4 = llvm.shl %arg0, %3  : vector<3xi32>
    llvm.return %4 : vector<3xi32>
  }]

theorem inst_combine_t2_vec_splat   : t2_vec_splat_before  ⊑  t2_vec_splat_combined := by
  unfold t2_vec_splat_before t2_vec_splat_combined
  simp_alive_peephole
  sorry
def t3_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t3_vec_nonsplat(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[1, 0, 2]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shl %arg0, %arg1  : vector<3xi32>
    %2 = llvm.lshr %1, %arg1  : vector<3xi32>
    %3 = llvm.add %arg1, %0  : vector<3xi32>
    llvm.call @use3xi32(%1) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%2) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%3) : (vector<3xi32>) -> ()
    %4 = llvm.shl %arg0, %3  : vector<3xi32>
    llvm.return %4 : vector<3xi32>
  }]

theorem inst_combine_t3_vec_nonsplat   : t3_vec_nonsplat_before  ⊑  t3_vec_nonsplat_combined := by
  unfold t3_vec_nonsplat_before t3_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t4_vec_undef_combined := [llvmfunc|
  llvm.func @t4_vec_undef(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.shl %arg0, %arg1  : vector<3xi32>
    %10 = llvm.lshr %9, %arg1  : vector<3xi32>
    %11 = llvm.add %arg1, %8  : vector<3xi32>
    llvm.call @use3xi32(%9) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%10) : (vector<3xi32>) -> ()
    llvm.call @use3xi32(%11) : (vector<3xi32>) -> ()
    %12 = llvm.shl %arg0, %11  : vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

theorem inst_combine_t4_vec_undef   : t4_vec_undef_before  ⊑  t4_vec_undef_combined := by
  unfold t4_vec_undef_before t4_vec_undef_combined
  simp_alive_peephole
  sorry
def t5_nuw_combined := [llvmfunc|
  llvm.func @t5_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %0 : i32
  }]

theorem inst_combine_t5_nuw   : t5_nuw_before  ⊑  t5_nuw_combined := by
  unfold t5_nuw_before t5_nuw_combined
  simp_alive_peephole
  sorry
def t6_nsw_combined := [llvmfunc|
  llvm.func @t6_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %0 : i32
  }]

theorem inst_combine_t6_nsw   : t6_nsw_before  ⊑  t6_nsw_combined := by
  unfold t6_nsw_before t6_nsw_combined
  simp_alive_peephole
  sorry
def t7_nuw_nsw_combined := [llvmfunc|
  llvm.func @t7_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg1  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %0 : i32
  }]

theorem inst_combine_t7_nuw_nsw   : t7_nuw_nsw_before  ⊑  t7_nuw_nsw_combined := by
  unfold t7_nuw_nsw_before t7_nuw_nsw_combined
  simp_alive_peephole
  sorry
def t8_assume_uge_combined := [llvmfunc|
  llvm.func @t8_assume_uge(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "uge" %arg2, %arg1 : i32
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %2, %arg2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t8_assume_uge   : t8_assume_uge_before  ⊑  t8_assume_uge_combined := by
  unfold t8_assume_uge_before t8_assume_uge_combined
  simp_alive_peephole
  sorry
def n9_different_shamts0_combined := [llvmfunc|
  llvm.func @n9_different_shamts0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_n9_different_shamts0   : n9_different_shamts0_before  ⊑  n9_different_shamts0_combined := by
  unfold n9_different_shamts0_before n9_different_shamts0_combined
  simp_alive_peephole
  sorry
def n10_different_shamts1_combined := [llvmfunc|
  llvm.func @n10_different_shamts1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.lshr %0, %arg2  : i32
    llvm.call @use32(%0) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %1, %arg2  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_n10_different_shamts1   : n10_different_shamts1_before  ⊑  n10_different_shamts1_combined := by
  unfold n10_different_shamts1_before n10_different_shamts1_combined
  simp_alive_peephole
  sorry
