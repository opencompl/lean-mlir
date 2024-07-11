import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trunc-demand
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def trunc_lshr_before := [llvmfunc|
  llvm.func @trunc_lshr(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(14 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }]

def trunc_lshr_exact_mask_before := [llvmfunc|
  llvm.func @trunc_lshr_exact_mask(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(15 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }]

def trunc_lshr_big_mask_before := [llvmfunc|
  llvm.func @trunc_lshr_big_mask(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(31 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }]

def trunc_lshr_use1_before := [llvmfunc|
  llvm.func @trunc_lshr_use1(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(15 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }]

def trunc_lshr_use2_before := [llvmfunc|
  llvm.func @trunc_lshr_use2(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(15 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    llvm.call @use6(%3) : (i6) -> ()
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }]

def trunc_lshr_vec_splat_before := [llvmfunc|
  llvm.func @trunc_lshr_vec_splat(%arg0: vector<2xi16>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.mlir.constant(dense<1> : vector<2xi7>) : vector<2xi7>
    %3 = llvm.lshr %arg0, %0  : vector<2xi16>
    %4 = llvm.trunc %3 : vector<2xi16> to vector<2xi7>
    %5 = llvm.and %4, %2  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }]

def trunc_lshr_vec_splat_exact_mask_before := [llvmfunc|
  llvm.func @trunc_lshr_vec_splat_exact_mask(%arg0: vector<2xi16>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.mlir.constant(dense<1> : vector<2xi7>) : vector<2xi7>
    %3 = llvm.lshr %arg0, %0  : vector<2xi16>
    %4 = llvm.trunc %3 : vector<2xi16> to vector<2xi7>
    %5 = llvm.and %4, %2  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }]

def trunc_lshr_big_shift_before := [llvmfunc|
  llvm.func @trunc_lshr_big_shift(%arg0: vector<2xi16>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.mlir.constant(dense<1> : vector<2xi7>) : vector<2xi7>
    %3 = llvm.lshr %arg0, %0  : vector<2xi16>
    %4 = llvm.trunc %3 : vector<2xi16> to vector<2xi7>
    %5 = llvm.and %4, %2  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }]

def or_trunc_lshr_before := [llvmfunc|
  llvm.func @or_trunc_lshr(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.or %3, %1  : i6
    llvm.return %4 : i6
  }]

def or_trunc_lshr_more_before := [llvmfunc|
  llvm.func @or_trunc_lshr_more(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.or %3, %1  : i6
    llvm.return %4 : i6
  }]

def or_trunc_lshr_small_mask_before := [llvmfunc|
  llvm.func @or_trunc_lshr_small_mask(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.or %3, %1  : i6
    llvm.return %4 : i6
  }]

def trunc_lshr_combined := [llvmfunc|
  llvm.func @trunc_lshr(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i6) : i6
    %1 = llvm.mlir.constant(14 : i6) : i6
    %2 = llvm.trunc %arg0 : i8 to i6
    %3 = llvm.lshr %2, %0  : i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }]

theorem inst_combine_trunc_lshr   : trunc_lshr_before  ⊑  trunc_lshr_combined := by
  unfold trunc_lshr_before trunc_lshr_combined
  simp_alive_peephole
  sorry
def trunc_lshr_exact_mask_combined := [llvmfunc|
  llvm.func @trunc_lshr_exact_mask(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i6) : i6
    %1 = llvm.trunc %arg0 : i8 to i6
    %2 = llvm.lshr %1, %0  : i6
    llvm.return %2 : i6
  }]

theorem inst_combine_trunc_lshr_exact_mask   : trunc_lshr_exact_mask_before  ⊑  trunc_lshr_exact_mask_combined := by
  unfold trunc_lshr_exact_mask_before trunc_lshr_exact_mask_combined
  simp_alive_peephole
  sorry
def trunc_lshr_big_mask_combined := [llvmfunc|
  llvm.func @trunc_lshr_big_mask(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(31 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }]

theorem inst_combine_trunc_lshr_big_mask   : trunc_lshr_big_mask_before  ⊑  trunc_lshr_big_mask_combined := by
  unfold trunc_lshr_big_mask_before trunc_lshr_big_mask_combined
  simp_alive_peephole
  sorry
def trunc_lshr_use1_combined := [llvmfunc|
  llvm.func @trunc_lshr_use1(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(15 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }]

theorem inst_combine_trunc_lshr_use1   : trunc_lshr_use1_before  ⊑  trunc_lshr_use1_combined := by
  unfold trunc_lshr_use1_before trunc_lshr_use1_combined
  simp_alive_peephole
  sorry
def trunc_lshr_use2_combined := [llvmfunc|
  llvm.func @trunc_lshr_use2(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(15 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    llvm.call @use6(%3) : (i6) -> ()
    %4 = llvm.and %3, %1  : i6
    llvm.return %4 : i6
  }]

theorem inst_combine_trunc_lshr_use2   : trunc_lshr_use2_before  ⊑  trunc_lshr_use2_combined := by
  unfold trunc_lshr_use2_before trunc_lshr_use2_combined
  simp_alive_peephole
  sorry
def trunc_lshr_vec_splat_combined := [llvmfunc|
  llvm.func @trunc_lshr_vec_splat(%arg0: vector<2xi16>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(5 : i7) : i7
    %1 = llvm.mlir.constant(dense<5> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(1 : i7) : i7
    %3 = llvm.mlir.constant(dense<1> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.trunc %arg0 : vector<2xi16> to vector<2xi7>
    %5 = llvm.lshr %4, %1  : vector<2xi7>
    %6 = llvm.and %5, %3  : vector<2xi7>
    llvm.return %6 : vector<2xi7>
  }]

theorem inst_combine_trunc_lshr_vec_splat   : trunc_lshr_vec_splat_before  ⊑  trunc_lshr_vec_splat_combined := by
  unfold trunc_lshr_vec_splat_before trunc_lshr_vec_splat_combined
  simp_alive_peephole
  sorry
def trunc_lshr_vec_splat_exact_mask_combined := [llvmfunc|
  llvm.func @trunc_lshr_vec_splat_exact_mask(%arg0: vector<2xi16>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(6 : i7) : i7
    %1 = llvm.mlir.constant(dense<6> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.trunc %arg0 : vector<2xi16> to vector<2xi7>
    %3 = llvm.lshr %2, %1  : vector<2xi7>
    llvm.return %3 : vector<2xi7>
  }]

theorem inst_combine_trunc_lshr_vec_splat_exact_mask   : trunc_lshr_vec_splat_exact_mask_before  ⊑  trunc_lshr_vec_splat_exact_mask_combined := by
  unfold trunc_lshr_vec_splat_exact_mask_before trunc_lshr_vec_splat_exact_mask_combined
  simp_alive_peephole
  sorry
def trunc_lshr_big_shift_combined := [llvmfunc|
  llvm.func @trunc_lshr_big_shift(%arg0: vector<2xi16>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(1 : i7) : i7
    %2 = llvm.mlir.constant(dense<1> : vector<2xi7>) : vector<2xi7>
    %3 = llvm.lshr %arg0, %0  : vector<2xi16>
    %4 = llvm.trunc %3 : vector<2xi16> to vector<2xi7>
    %5 = llvm.and %4, %2  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }]

theorem inst_combine_trunc_lshr_big_shift   : trunc_lshr_big_shift_before  ⊑  trunc_lshr_big_shift_combined := by
  unfold trunc_lshr_big_shift_before trunc_lshr_big_shift_combined
  simp_alive_peephole
  sorry
def or_trunc_lshr_combined := [llvmfunc|
  llvm.func @or_trunc_lshr(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(1 : i6) : i6
    %1 = llvm.mlir.constant(-32 : i6) : i6
    %2 = llvm.trunc %arg0 : i8 to i6
    %3 = llvm.lshr %2, %0  : i6
    %4 = llvm.or %3, %1  : i6
    llvm.return %4 : i6
  }]

theorem inst_combine_or_trunc_lshr   : or_trunc_lshr_before  ⊑  or_trunc_lshr_combined := by
  unfold or_trunc_lshr_before or_trunc_lshr_combined
  simp_alive_peephole
  sorry
def or_trunc_lshr_more_combined := [llvmfunc|
  llvm.func @or_trunc_lshr_more(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(4 : i6) : i6
    %1 = llvm.mlir.constant(-4 : i6) : i6
    %2 = llvm.trunc %arg0 : i8 to i6
    %3 = llvm.lshr %2, %0  : i6
    %4 = llvm.or %3, %1  : i6
    llvm.return %4 : i6
  }]

theorem inst_combine_or_trunc_lshr_more   : or_trunc_lshr_more_before  ⊑  or_trunc_lshr_more_combined := by
  unfold or_trunc_lshr_more_before or_trunc_lshr_more_combined
  simp_alive_peephole
  sorry
def or_trunc_lshr_small_mask_combined := [llvmfunc|
  llvm.func @or_trunc_lshr_small_mask(%arg0: i8) -> i6 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i6) : i6
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.trunc %2 : i8 to i6
    %4 = llvm.or %3, %1  : i6
    llvm.return %4 : i6
  }]

theorem inst_combine_or_trunc_lshr_small_mask   : or_trunc_lshr_small_mask_before  ⊑  or_trunc_lshr_small_mask_combined := by
  unfold or_trunc_lshr_small_mask_before or_trunc_lshr_small_mask_combined
  simp_alive_peephole
  sorry
