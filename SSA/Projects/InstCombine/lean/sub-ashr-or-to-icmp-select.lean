import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-ashr-or-to-icmp-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def clamp255_i32_before := [llvmfunc|
  llvm.func @clamp255_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    %4 = llvm.or %3, %arg0  : i32
    %5 = llvm.and %4, %0  : i32
    llvm.return %5 : i32
  }]

def sub_ashr_or_i8_before := [llvmfunc|
  llvm.func @sub_ashr_or_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def sub_ashr_or_i16_before := [llvmfunc|
  llvm.func @sub_ashr_or_i16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i16
    %2 = llvm.ashr %1, %0  : i16
    %3 = llvm.or %2, %arg0  : i16
    llvm.return %3 : i16
  }]

def sub_ashr_or_i32_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_or_i64_before := [llvmfunc|
  llvm.func @sub_ashr_or_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i64
    %2 = llvm.ashr %1, %0  : i64
    %3 = llvm.or %2, %arg0  : i64
    llvm.return %3 : i64
  }]

def neg_or_ashr_i32_before := [llvmfunc|
  llvm.func @neg_or_ashr_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.return %4 : i32
  }]

def sub_ashr_or_i32_nuw_nsw_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw, nuw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_or_i32_commute_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_commute(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    llvm.return %3 : i32
  }]

def neg_or_ashr_i32_commute_before := [llvmfunc|
  llvm.func @neg_or_ashr_i32_commute(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.sdiv %0, %arg0  : i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.or %3, %4  : i32
    %6 = llvm.ashr %5, %2  : i32
    llvm.return %6 : i32
  }]

def sub_ashr_or_i32_vec_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<4xi32>
    %2 = llvm.ashr %1, %0  : vector<4xi32>
    %3 = llvm.or %2, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def sub_ashr_or_i32_vec_nuw_nsw_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec_nuw_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw, nuw>  : vector<4xi32>
    %2 = llvm.ashr %1, %0  : vector<4xi32>
    %3 = llvm.or %2, %arg0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def neg_or_ashr_i32_vec_before := [llvmfunc|
  llvm.func @neg_or_ashr_i32_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    %4 = llvm.or %3, %arg0  : vector<4xi32>
    %5 = llvm.ashr %4, %2  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def sub_ashr_or_i32_vec_commute_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec_commute(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<4xi32>
    %2 = llvm.ashr %1, %0  : vector<4xi32>
    %3 = llvm.or %arg0, %2  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def neg_or_ashr_i32_vec_commute_before := [llvmfunc|
  llvm.func @neg_or_ashr_i32_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.sdiv %0, %arg0  : vector<4xi32>
    %5 = llvm.sub %2, %4  : vector<4xi32>
    %6 = llvm.or %4, %5  : vector<4xi32>
    %7 = llvm.ashr %6, %3  : vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def sub_ashr_or_i32_extra_use_sub_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_extra_use_sub(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_or_i32_extra_use_or_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_extra_use_or(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %3 : i32
  }]

def neg_extra_use_or_ashr_i32_before := [llvmfunc|
  llvm.func @neg_extra_use_or_ashr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %4 : i32
  }]

def sub_ashr_or_i32_extra_use_ashr_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_extra_use_ashr(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def sub_ashr_or_i32_no_nsw_nuw_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_no_nsw_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def neg_or_extra_use_ashr_i32_before := [llvmfunc|
  llvm.func @neg_or_extra_use_ashr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %4 : i32
  }]

def sub_ashr_or_i32_vec_undef1_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec_undef1(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(255 : i32) : i32
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
    %11 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.sub %10, %arg0  : vector<4xi32>
    %13 = llvm.ashr %12, %11  : vector<4xi32>
    %14 = llvm.or %13, %arg0  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

def sub_ashr_or_i32_vec_undef2_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec_undef2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<255> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.sub %0, %arg0 overflow<nsw>  : vector<4xi32>
    %13 = llvm.ashr %12, %11  : vector<4xi32>
    %14 = llvm.or %13, %arg0  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

def sub_ashr_or_i32_shift_wrong_bit_before := [llvmfunc|
  llvm.func @sub_ashr_or_i32_shift_wrong_bit(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

def clamp255_i32_combined := [llvmfunc|
  llvm.func @clamp255_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_clamp255_i32   : clamp255_i32_before  ⊑  clamp255_i32_combined := by
  unfold clamp255_i32_before clamp255_i32_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i8_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.select %1, %0, %arg0 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_ashr_or_i8   : sub_ashr_or_i8_before  ⊑  sub_ashr_or_i8_combined := by
  unfold sub_ashr_or_i8_before sub_ashr_or_i8_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i16_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i16(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.icmp "slt" %arg1, %arg0 : i16
    %2 = llvm.select %1, %0, %arg0 : i1, i16
    llvm.return %2 : i16
  }]

theorem inst_combine_sub_ashr_or_i16   : sub_ashr_or_i16_before  ⊑  sub_ashr_or_i16_combined := by
  unfold sub_ashr_or_i16_before sub_ashr_or_i16_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_or_i32   : sub_ashr_or_i32_before  ⊑  sub_ashr_or_i32_combined := by
  unfold sub_ashr_or_i32_before sub_ashr_or_i32_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i64_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.icmp "slt" %arg1, %arg0 : i64
    %2 = llvm.select %1, %0, %arg0 : i1, i64
    llvm.return %2 : i64
  }]

theorem inst_combine_sub_ashr_or_i64   : sub_ashr_or_i64_before  ⊑  sub_ashr_or_i64_combined := by
  unfold sub_ashr_or_i64_before sub_ashr_or_i64_combined
  simp_alive_peephole
  sorry
def neg_or_ashr_i32_combined := [llvmfunc|
  llvm.func @neg_or_ashr_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.sext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_neg_or_ashr_i32   : neg_or_ashr_i32_before  ⊑  neg_or_ashr_i32_combined := by
  unfold neg_or_ashr_i32_before neg_or_ashr_i32_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_nuw_nsw_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_or_i32_nuw_nsw   : sub_ashr_or_i32_nuw_nsw_before  ⊑  sub_ashr_or_i32_nuw_nsw_combined := by
  unfold sub_ashr_or_i32_nuw_nsw_before sub_ashr_or_i32_nuw_nsw_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_commute_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_commute(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_or_i32_commute   : sub_ashr_or_i32_commute_before  ⊑  sub_ashr_or_i32_commute_combined := by
  unfold sub_ashr_or_i32_commute_before sub_ashr_or_i32_commute_combined
  simp_alive_peephole
  sorry
def neg_or_ashr_i32_commute_combined := [llvmfunc|
  llvm.func @neg_or_ashr_i32_commute(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sdiv %0, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.sext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_neg_or_ashr_i32_commute   : neg_or_ashr_i32_commute_before  ⊑  neg_or_ashr_i32_commute_combined := by
  unfold neg_or_ashr_i32_commute_before neg_or_ashr_i32_commute_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_vec_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "slt" %arg1, %arg0 : vector<4xi32>
    %2 = llvm.select %1, %0, %arg0 : vector<4xi1>, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_sub_ashr_or_i32_vec   : sub_ashr_or_i32_vec_before  ⊑  sub_ashr_or_i32_vec_combined := by
  unfold sub_ashr_or_i32_vec_before sub_ashr_or_i32_vec_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_vec_nuw_nsw_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec_nuw_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "slt" %arg1, %arg0 : vector<4xi32>
    %2 = llvm.select %1, %0, %arg0 : vector<4xi1>, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_sub_ashr_or_i32_vec_nuw_nsw   : sub_ashr_or_i32_vec_nuw_nsw_before  ⊑  sub_ashr_or_i32_vec_nuw_nsw_combined := by
  unfold sub_ashr_or_i32_vec_nuw_nsw_before sub_ashr_or_i32_vec_nuw_nsw_combined
  simp_alive_peephole
  sorry
def neg_or_ashr_i32_vec_combined := [llvmfunc|
  llvm.func @neg_or_ashr_i32_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<4xi32>
    %3 = llvm.sext %2 : vector<4xi1> to vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_neg_or_ashr_i32_vec   : neg_or_ashr_i32_vec_before  ⊑  neg_or_ashr_i32_vec_combined := by
  unfold neg_or_ashr_i32_vec_before neg_or_ashr_i32_vec_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_vec_commute_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec_commute(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "slt" %arg1, %arg0 : vector<4xi32>
    %2 = llvm.select %1, %0, %arg0 : vector<4xi1>, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_sub_ashr_or_i32_vec_commute   : sub_ashr_or_i32_vec_commute_before  ⊑  sub_ashr_or_i32_vec_commute_combined := by
  unfold sub_ashr_or_i32_vec_commute_before sub_ashr_or_i32_vec_commute_combined
  simp_alive_peephole
  sorry
def neg_or_ashr_i32_vec_commute_combined := [llvmfunc|
  llvm.func @neg_or_ashr_i32_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.sdiv %0, %arg0  : vector<4xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<4xi32>
    %5 = llvm.sext %4 : vector<4xi1> to vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_neg_or_ashr_i32_vec_commute   : neg_or_ashr_i32_vec_commute_before  ⊑  neg_or_ashr_i32_vec_commute_combined := by
  unfold neg_or_ashr_i32_vec_commute_before neg_or_ashr_i32_vec_commute_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_extra_use_sub_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_extra_use_sub(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_sub_ashr_or_i32_extra_use_sub   : sub_ashr_or_i32_extra_use_sub_before  ⊑  sub_ashr_or_i32_extra_use_sub_combined := by
  unfold sub_ashr_or_i32_extra_use_sub_before sub_ashr_or_i32_extra_use_sub_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_ashr_or_i32_extra_use_sub   : sub_ashr_or_i32_extra_use_sub_before  ⊑  sub_ashr_or_i32_extra_use_sub_combined := by
  unfold sub_ashr_or_i32_extra_use_sub_before sub_ashr_or_i32_extra_use_sub_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_extra_use_or_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_extra_use_or(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_sub_ashr_or_i32_extra_use_or   : sub_ashr_or_i32_extra_use_or_before  ⊑  sub_ashr_or_i32_extra_use_or_combined := by
  unfold sub_ashr_or_i32_extra_use_or_before sub_ashr_or_i32_extra_use_or_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_or_i32_extra_use_or   : sub_ashr_or_i32_extra_use_or_before  ⊑  sub_ashr_or_i32_extra_use_or_combined := by
  unfold sub_ashr_or_i32_extra_use_or_before sub_ashr_or_i32_extra_use_or_combined
  simp_alive_peephole
  sorry
def neg_extra_use_or_ashr_i32_combined := [llvmfunc|
  llvm.func @neg_extra_use_or_ashr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.sext %2 : i1 to i32
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_neg_extra_use_or_ashr_i32   : neg_extra_use_or_ashr_i32_before  ⊑  neg_extra_use_or_ashr_i32_combined := by
  unfold neg_extra_use_or_ashr_i32_before neg_extra_use_or_ashr_i32_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
  }]

theorem inst_combine_neg_extra_use_or_ashr_i32   : neg_extra_use_or_ashr_i32_before  ⊑  neg_extra_use_or_ashr_i32_combined := by
  unfold neg_extra_use_or_ashr_i32_before neg_extra_use_or_ashr_i32_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_extra_use_ashr_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_extra_use_ashr(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i32
    %1 = llvm.sext %0 : i1 to i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_sub_ashr_or_i32_extra_use_ashr   : sub_ashr_or_i32_extra_use_ashr_before  ⊑  sub_ashr_or_i32_extra_use_ashr_combined := by
  unfold sub_ashr_or_i32_extra_use_ashr_before sub_ashr_or_i32_extra_use_ashr_combined
  simp_alive_peephole
  sorry
    %2 = llvm.or %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_ashr_or_i32_extra_use_ashr   : sub_ashr_or_i32_extra_use_ashr_before  ⊑  sub_ashr_or_i32_extra_use_ashr_combined := by
  unfold sub_ashr_or_i32_extra_use_ashr_before sub_ashr_or_i32_extra_use_ashr_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_no_nsw_nuw_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_no_nsw_nuw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_ashr_or_i32_no_nsw_nuw   : sub_ashr_or_i32_no_nsw_nuw_before  ⊑  sub_ashr_or_i32_no_nsw_nuw_combined := by
  unfold sub_ashr_or_i32_no_nsw_nuw_before sub_ashr_or_i32_no_nsw_nuw_combined
  simp_alive_peephole
  sorry
def neg_or_extra_use_ashr_i32_combined := [llvmfunc|
  llvm.func @neg_or_extra_use_ashr_i32(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.ashr %3, %1  : i32
    llvm.store %3, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_neg_or_extra_use_ashr_i32   : neg_or_extra_use_ashr_i32_before  ⊑  neg_or_extra_use_ashr_i32_combined := by
  unfold neg_or_extra_use_ashr_i32_before neg_or_extra_use_ashr_i32_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i32
  }]

theorem inst_combine_neg_or_extra_use_ashr_i32   : neg_or_extra_use_ashr_i32_before  ⊑  neg_or_extra_use_ashr_i32_combined := by
  unfold neg_or_extra_use_ashr_i32_before neg_or_extra_use_ashr_i32_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_vec_undef1_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec_undef1(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(255 : i32) : i32
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
    %11 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.sub %10, %arg0  : vector<4xi32>
    %13 = llvm.ashr %12, %11  : vector<4xi32>
    %14 = llvm.or %13, %arg0  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_sub_ashr_or_i32_vec_undef1   : sub_ashr_or_i32_vec_undef1_before  ⊑  sub_ashr_or_i32_vec_undef1_combined := by
  unfold sub_ashr_or_i32_vec_undef1_before sub_ashr_or_i32_vec_undef1_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_vec_undef2_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_vec_undef2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<255> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.sub %0, %arg0 overflow<nsw>  : vector<4xi32>
    %13 = llvm.ashr %12, %11  : vector<4xi32>
    %14 = llvm.or %13, %arg0  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_sub_ashr_or_i32_vec_undef2   : sub_ashr_or_i32_vec_undef2_before  ⊑  sub_ashr_or_i32_vec_undef2_combined := by
  unfold sub_ashr_or_i32_vec_undef2_before sub_ashr_or_i32_vec_undef2_combined
  simp_alive_peephole
  sorry
def sub_ashr_or_i32_shift_wrong_bit_combined := [llvmfunc|
  llvm.func @sub_ashr_or_i32_shift_wrong_bit(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.or %2, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_ashr_or_i32_shift_wrong_bit   : sub_ashr_or_i32_shift_wrong_bit_before  ⊑  sub_ashr_or_i32_shift_wrong_bit_combined := by
  unfold sub_ashr_or_i32_shift_wrong_bit_before sub_ashr_or_i32_shift_wrong_bit_combined
  simp_alive_peephole
  sorry
