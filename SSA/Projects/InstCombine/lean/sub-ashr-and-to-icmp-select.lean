import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-ashr-and-to-icmp-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sub_ashr_and_i8_before := [llvmfunc|
  llvm.func @sub_ashr_and_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def sub_ashr_and_i16_before := [llvmfunc|
  llvm.func @sub_ashr_and_i16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i16
    %2 = llvm.ashr %1, %0  : i16
    %3 = llvm.and %2, %arg0  : i16
    llvm.return %3 : i16
  }]

def sub_ashr_and_i32_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_and_i64_before := [llvmfunc|
  llvm.func @sub_ashr_and_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i64
    %2 = llvm.ashr %1, %0  : i64
    %3 = llvm.and %2, %arg0  : i64
    llvm.return %3 : i64
  }]

def sub_ashr_and_i32_nuw_nsw_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw, nuw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_and_i32_commute_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_commute(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.and %arg0, %2  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_and_i32_vec_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<4xi32>
    %2 = llvm.ashr %1, %0  : vector<4xi32>
    %3 = llvm.and %2, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def sub_ashr_and_i32_vec_nuw_nsw_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_vec_nuw_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw, nuw>  : vector<4xi32>
    %2 = llvm.ashr %1, %0  : vector<4xi32>
    %3 = llvm.and %2, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def sub_ashr_and_i32_vec_commute_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_vec_commute(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<4xi32>
    %2 = llvm.ashr %1, %0  : vector<4xi32>
    %3 = llvm.and %arg0, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def sub_ashr_and_i32_extra_use_sub_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_extra_use_sub(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_and_i32_extra_use_and_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_extra_use_and(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %3 : i32
  }]

def sub_ashr_and_i32_extra_use_ashr_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_extra_use_ashr(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_and_i32_no_nuw_nsw_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_no_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_and_i32_vec_poison_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_vec_poison(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<4xi32>
    %12 = llvm.ashr %11, %10  : vector<4xi32>
    %13 = llvm.and %12, %arg0  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

def sub_ashr_and_i32_shift_wrong_bit_before := [llvmfunc|
  llvm.func @sub_ashr_and_i32_shift_wrong_bit(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_and_i8_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.select %1, %arg0, %0 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_ashr_and_i8   : sub_ashr_and_i8_before  ⊑  sub_ashr_and_i8_combined := by
  unfold sub_ashr_and_i8_before sub_ashr_and_i8_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i16_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.icmp "slt" %arg1, %arg0 : i16
    %2 = llvm.select %1, %arg0, %0 : i1, i16
    llvm.return %2 : i16
  }]

theorem inst_combine_sub_ashr_and_i16   : sub_ashr_and_i16_before  ⊑  sub_ashr_and_i16_combined := by
  unfold sub_ashr_and_i16_before sub_ashr_and_i16_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_and_i32   : sub_ashr_and_i32_before  ⊑  sub_ashr_and_i32_combined := by
  unfold sub_ashr_and_i32_before sub_ashr_and_i32_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i64_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.icmp "slt" %arg1, %arg0 : i64
    %2 = llvm.select %1, %arg0, %0 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sub_ashr_and_i64   : sub_ashr_and_i64_before  ⊑  sub_ashr_and_i64_combined := by
  unfold sub_ashr_and_i64_before sub_ashr_and_i64_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_nuw_nsw_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_and_i32_nuw_nsw   : sub_ashr_and_i32_nuw_nsw_before  ⊑  sub_ashr_and_i32_nuw_nsw_combined := by
  unfold sub_ashr_and_i32_nuw_nsw_before sub_ashr_and_i32_nuw_nsw_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_commute_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_commute(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_and_i32_commute   : sub_ashr_and_i32_commute_before  ⊑  sub_ashr_and_i32_commute_combined := by
  unfold sub_ashr_and_i32_commute_before sub_ashr_and_i32_commute_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_vec_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "slt" %arg1, %arg0 : vector<4xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_sub_ashr_and_i32_vec   : sub_ashr_and_i32_vec_before  ⊑  sub_ashr_and_i32_vec_combined := by
  unfold sub_ashr_and_i32_vec_before sub_ashr_and_i32_vec_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_vec_nuw_nsw_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_vec_nuw_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "slt" %arg1, %arg0 : vector<4xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_sub_ashr_and_i32_vec_nuw_nsw   : sub_ashr_and_i32_vec_nuw_nsw_before  ⊑  sub_ashr_and_i32_vec_nuw_nsw_combined := by
  unfold sub_ashr_and_i32_vec_nuw_nsw_before sub_ashr_and_i32_vec_nuw_nsw_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_vec_commute_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_vec_commute(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "slt" %arg1, %arg0 : vector<4xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_sub_ashr_and_i32_vec_commute   : sub_ashr_and_i32_vec_commute_before  ⊑  sub_ashr_and_i32_vec_commute_combined := by
  unfold sub_ashr_and_i32_vec_commute_before sub_ashr_and_i32_vec_commute_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_extra_use_sub_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_extra_use_sub(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_sub_ashr_and_i32_extra_use_sub   : sub_ashr_and_i32_extra_use_sub_before  ⊑  sub_ashr_and_i32_extra_use_sub_combined := by
  unfold sub_ashr_and_i32_extra_use_sub_before sub_ashr_and_i32_extra_use_sub_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.select %2, %arg0, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_ashr_and_i32_extra_use_sub   : sub_ashr_and_i32_extra_use_sub_before  ⊑  sub_ashr_and_i32_extra_use_sub_combined := by
  unfold sub_ashr_and_i32_extra_use_sub_before sub_ashr_and_i32_extra_use_sub_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_extra_use_and_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_extra_use_and(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_sub_ashr_and_i32_extra_use_and   : sub_ashr_and_i32_extra_use_and_before  ⊑  sub_ashr_and_i32_extra_use_and_combined := by
  unfold sub_ashr_and_i32_extra_use_and_before sub_ashr_and_i32_extra_use_and_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_and_i32_extra_use_and   : sub_ashr_and_i32_extra_use_and_before  ⊑  sub_ashr_and_i32_extra_use_and_combined := by
  unfold sub_ashr_and_i32_extra_use_and_before sub_ashr_and_i32_extra_use_and_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_extra_use_ashr_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_extra_use_ashr(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.sext %0 : i1 to i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_sub_ashr_and_i32_extra_use_ashr   : sub_ashr_and_i32_extra_use_ashr_before  ⊑  sub_ashr_and_i32_extra_use_ashr_combined := by
  unfold sub_ashr_and_i32_extra_use_ashr_before sub_ashr_and_i32_extra_use_ashr_combined
  simp_alive_peephole
  sorry
    %2 = llvm.and %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_and_i32_extra_use_ashr   : sub_ashr_and_i32_extra_use_ashr_before  ⊑  sub_ashr_and_i32_extra_use_ashr_combined := by
  unfold sub_ashr_and_i32_extra_use_ashr_before sub_ashr_and_i32_extra_use_ashr_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_no_nuw_nsw_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_no_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_ashr_and_i32_no_nuw_nsw   : sub_ashr_and_i32_no_nuw_nsw_before  ⊑  sub_ashr_and_i32_no_nuw_nsw_combined := by
  unfold sub_ashr_and_i32_no_nuw_nsw_before sub_ashr_and_i32_no_nuw_nsw_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_vec_poison_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_vec_poison(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "slt" %arg1, %arg0 : vector<4xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_sub_ashr_and_i32_vec_poison   : sub_ashr_and_i32_vec_poison_before  ⊑  sub_ashr_and_i32_vec_poison_combined := by
  unfold sub_ashr_and_i32_vec_poison_before sub_ashr_and_i32_vec_poison_combined
  simp_alive_peephole
  sorry
def sub_ashr_and_i32_shift_wrong_bit_combined := [llvmfunc|
  llvm.func @sub_ashr_and_i32_shift_wrong_bit(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_ashr_and_i32_shift_wrong_bit   : sub_ashr_and_i32_shift_wrong_bit_before  ⊑  sub_ashr_and_i32_shift_wrong_bit_combined := by
  unfold sub_ashr_and_i32_shift_wrong_bit_before sub_ashr_and_i32_shift_wrong_bit_combined
  simp_alive_peephole
  sorry
