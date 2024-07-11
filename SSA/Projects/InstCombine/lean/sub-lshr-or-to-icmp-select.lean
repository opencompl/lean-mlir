import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-lshr-or-to-icmp-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def neg_or_lshr_i32_before := [llvmfunc|
  llvm.func @neg_or_lshr_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.return %4 : i32
  }]

def neg_or_lshr_i32_commute_before := [llvmfunc|
  llvm.func @neg_or_lshr_i32_commute(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.sdiv %0, %arg0  : i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.lshr %5, %2  : i32
    llvm.return %6 : i32
  }]

def neg_or_lshr_i32_vec_before := [llvmfunc|
  llvm.func @neg_or_lshr_i32_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    %4 = llvm.or %3, %arg0  : vector<4xi32>
    %5 = llvm.lshr %4, %2  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def neg_or_lshr_i32_vec_commute_before := [llvmfunc|
  llvm.func @neg_or_lshr_i32_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.sdiv %0, %arg0  : vector<4xi32>
    %5 = llvm.sub %2, %4  : vector<4xi32>
    %6 = llvm.or %4, %5  : vector<4xi32>
    %7 = llvm.lshr %6, %3  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def neg_extra_use_or_lshr_i32_before := [llvmfunc|
  llvm.func @neg_extra_use_or_lshr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %4 : i32
  }]

def neg_or_extra_use_lshr_i32_before := [llvmfunc|
  llvm.func @neg_or_extra_use_lshr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %4 : i32
  }]

def neg_or_lshr_i32_combined := [llvmfunc|
  llvm.func @neg_or_lshr_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_neg_or_lshr_i32   : neg_or_lshr_i32_before  ⊑  neg_or_lshr_i32_combined := by
  unfold neg_or_lshr_i32_before neg_or_lshr_i32_combined
  simp_alive_peephole
  sorry
def neg_or_lshr_i32_commute_combined := [llvmfunc|
  llvm.func @neg_or_lshr_i32_commute(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_neg_or_lshr_i32_commute   : neg_or_lshr_i32_commute_before  ⊑  neg_or_lshr_i32_commute_combined := by
  unfold neg_or_lshr_i32_commute_before neg_or_lshr_i32_commute_combined
  simp_alive_peephole
  sorry
def neg_or_lshr_i32_vec_combined := [llvmfunc|
  llvm.func @neg_or_lshr_i32_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<4xi32>
    %3 = llvm.zext %2 : vector<4xi1> to vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_neg_or_lshr_i32_vec   : neg_or_lshr_i32_vec_before  ⊑  neg_or_lshr_i32_vec_combined := by
  unfold neg_or_lshr_i32_vec_before neg_or_lshr_i32_vec_combined
  simp_alive_peephole
  sorry
def neg_or_lshr_i32_vec_commute_combined := [llvmfunc|
  llvm.func @neg_or_lshr_i32_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.sdiv %0, %arg0  : vector<4xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<4xi32>
    %5 = llvm.zext %4 : vector<4xi1> to vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_neg_or_lshr_i32_vec_commute   : neg_or_lshr_i32_vec_commute_before  ⊑  neg_or_lshr_i32_vec_commute_combined := by
  unfold neg_or_lshr_i32_vec_commute_before neg_or_lshr_i32_vec_commute_combined
  simp_alive_peephole
  sorry
def neg_extra_use_or_lshr_i32_combined := [llvmfunc|
  llvm.func @neg_extra_use_or_lshr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_neg_extra_use_or_lshr_i32   : neg_extra_use_or_lshr_i32_before  ⊑  neg_extra_use_or_lshr_i32_combined := by
  unfold neg_extra_use_or_lshr_i32_before neg_extra_use_or_lshr_i32_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
  }]

theorem inst_combine_neg_extra_use_or_lshr_i32   : neg_extra_use_or_lshr_i32_before  ⊑  neg_extra_use_or_lshr_i32_combined := by
  unfold neg_extra_use_or_lshr_i32_before neg_extra_use_or_lshr_i32_combined
  simp_alive_peephole
  sorry
def neg_or_extra_use_lshr_i32_combined := [llvmfunc|
  llvm.func @neg_or_extra_use_lshr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.lshr %3, %1  : i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_neg_or_extra_use_lshr_i32   : neg_or_extra_use_lshr_i32_before  ⊑  neg_or_extra_use_lshr_i32_combined := by
  unfold neg_or_extra_use_lshr_i32_before neg_or_extra_use_lshr_i32_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i32
  }]

theorem inst_combine_neg_or_extra_use_lshr_i32   : neg_or_extra_use_lshr_i32_before  ⊑  neg_or_extra_use_lshr_i32_combined := by
  unfold neg_or_extra_use_lshr_i32_before neg_or_extra_use_lshr_i32_combined
  simp_alive_peephole
  sorry
