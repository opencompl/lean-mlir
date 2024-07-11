import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  negated-bitmask
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def neg_mask1_lshr_before := [llvmfunc|
  llvm.func @neg_mask1_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4  : i8
    llvm.return %5 : i8
  }]

def sub_mask1_lshr_before := [llvmfunc|
  llvm.func @sub_mask1_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def neg_mask1_lshr_vector_uniform_before := [llvmfunc|
  llvm.func @neg_mask1_lshr_vector_uniform(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.lshr %arg0, %0  : vector<4xi32>
    %5 = llvm.and %4, %1  : vector<4xi32>
    %6 = llvm.sub %3, %5  : vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }]

def neg_mask1_lshr_vector_nonuniform_before := [llvmfunc|
  llvm.func @neg_mask1_lshr_vector_nonuniform(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[3, 4, 5, 6]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.lshr %arg0, %0  : vector<4xi32>
    %5 = llvm.and %4, %1  : vector<4xi32>
    %6 = llvm.sub %3, %5  : vector<4xi32>
    llvm.return %6 : vector<4xi32>
  }]

def sub_mask1_lshr_vector_nonuniform_before := [llvmfunc|
  llvm.func @sub_mask1_lshr_vector_nonuniform(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[3, 4, 5, 6]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[5, 0, -1, 65556]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.lshr %arg0, %0  : vector<4xi32>
    %4 = llvm.and %3, %1  : vector<4xi32>
    %5 = llvm.sub %2, %4  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

def sub_mask1_trunc_lshr_before := [llvmfunc|
  llvm.func @sub_mask1_trunc_lshr(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(10 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.and %4, %1  : i8
    %6 = llvm.sub %2, %5  : i8
    llvm.return %6 : i8
  }]

def sub_sext_mask1_trunc_lshr_before := [llvmfunc|
  llvm.func @sub_sext_mask1_trunc_lshr(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i64
    %4 = llvm.trunc %3 : i64 to i8
    %5 = llvm.and %4, %1  : i8
    %6 = llvm.sext %5 : i8 to i32
    %7 = llvm.sub %2, %6  : i32
    llvm.return %7 : i32
  }]

def sub_zext_trunc_lshr_before := [llvmfunc|
  llvm.func @sub_zext_trunc_lshr(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i1
    %4 = llvm.zext %3 : i1 to i32
    %5 = llvm.sub %1, %4  : i32
    llvm.return %5 : i32
  }]

def neg_mask2_lshr_before := [llvmfunc|
  llvm.func @neg_mask2_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4  : i8
    llvm.return %5 : i8
  }]

def neg_mask2_lshr_outofbounds_before := [llvmfunc|
  llvm.func @neg_mask2_lshr_outofbounds(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4  : i8
    llvm.return %5 : i8
  }]

def neg_mask1_lshr_vector_var_before := [llvmfunc|
  llvm.func @neg_mask1_lshr_vector_var(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.and %3, %0  : vector<2xi32>
    %5 = llvm.sub %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def neg_mask1_lshr_extrause_mask_before := [llvmfunc|
  llvm.func @neg_mask1_lshr_extrause_mask(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4  : i8
    llvm.call @usei8(%4) : (i8) -> ()
    llvm.return %5 : i8
  }]

def neg_mask1_lshr_extrause_lshr_before := [llvmfunc|
  llvm.func @neg_mask1_lshr_extrause_lshr(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.sub %3, %5  : vector<2xi32>
    llvm.call @usev2i32(%4) : (vector<2xi32>) -> ()
    llvm.return %6 : vector<2xi32>
  }]

def neg_signbit_before := [llvmfunc|
  llvm.func @neg_signbit(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def neg_signbit_use1_before := [llvmfunc|
  llvm.func @neg_signbit_use1(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(0 : i64) : i64
    %8 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %9 = llvm.lshr %arg0, %6  : vector<2xi32>
    llvm.call @usev2i32(%9) : (vector<2xi32>) -> ()
    %10 = llvm.zext %9 : vector<2xi32> to vector<2xi64>
    %11 = llvm.sub %8, %10  : vector<2xi64>
    llvm.return %11 : vector<2xi64>
  }]

def neg_signbit_use2_before := [llvmfunc|
  llvm.func @neg_signbit_use2(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i5
    %3 = llvm.zext %2 : i5 to i8
    llvm.call @usei8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def neg_not_signbit1_before := [llvmfunc|
  llvm.func @neg_not_signbit1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def neg_not_signbit2_before := [llvmfunc|
  llvm.func @neg_not_signbit2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def neg_not_signbit3_before := [llvmfunc|
  llvm.func @neg_not_signbit3(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def neg_mask_before := [llvmfunc|
  llvm.func @neg_mask(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sext %arg1 : i16 to i32
    %3 = llvm.sub %arg0, %2 overflow<nsw>  : i32
    %4 = llvm.lshr %arg1, %0  : i16
    %5 = llvm.zext %4 : i16 to i32
    %6 = llvm.sub %1, %5 overflow<nsw>  : i32
    %7 = llvm.and %3, %6  : i32
    llvm.return %7 : i32
  }]

def neg_mask_const_before := [llvmfunc|
  llvm.func @neg_mask_const(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sext %arg0 : i16 to i32
    %4 = llvm.sub %0, %3 overflow<nsw>  : i32
    %5 = llvm.lshr %arg0, %1  : i16
    %6 = llvm.zext %5 : i16 to i32
    %7 = llvm.sub %2, %6 overflow<nsw>  : i32
    %8 = llvm.and %4, %7  : i32
    llvm.return %8 : i32
  }]

def neg_mask1_lshr_combined := [llvmfunc|
  llvm.func @neg_mask1_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_neg_mask1_lshr   : neg_mask1_lshr_before  ⊑  neg_mask1_lshr_combined := by
  unfold neg_mask1_lshr_before neg_mask1_lshr_combined
  simp_alive_peephole
  sorry
def sub_mask1_lshr_combined := [llvmfunc|
  llvm.func @sub_mask1_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(10 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.ashr %3, %1  : i8
    %5 = llvm.add %4, %2 overflow<nsw>  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_sub_mask1_lshr   : sub_mask1_lshr_before  ⊑  sub_mask1_lshr_combined := by
  unfold sub_mask1_lshr_before sub_mask1_lshr_combined
  simp_alive_peephole
  sorry
def neg_mask1_lshr_vector_uniform_combined := [llvmfunc|
  llvm.func @neg_mask1_lshr_vector_uniform(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<28> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.ashr %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_neg_mask1_lshr_vector_uniform   : neg_mask1_lshr_vector_uniform_before  ⊑  neg_mask1_lshr_vector_uniform_combined := by
  unfold neg_mask1_lshr_vector_uniform_before neg_mask1_lshr_vector_uniform_combined
  simp_alive_peephole
  sorry
def neg_mask1_lshr_vector_nonuniform_combined := [llvmfunc|
  llvm.func @neg_mask1_lshr_vector_nonuniform(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[28, 27, 26, 25]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.ashr %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_neg_mask1_lshr_vector_nonuniform   : neg_mask1_lshr_vector_nonuniform_before  ⊑  neg_mask1_lshr_vector_nonuniform_combined := by
  unfold neg_mask1_lshr_vector_nonuniform_before neg_mask1_lshr_vector_nonuniform_combined
  simp_alive_peephole
  sorry
def sub_mask1_lshr_vector_nonuniform_combined := [llvmfunc|
  llvm.func @sub_mask1_lshr_vector_nonuniform(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[28, 27, 26, 25]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[5, 0, -1, 65556]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.shl %arg0, %0  : vector<4xi32>
    %4 = llvm.ashr %3, %1  : vector<4xi32>
    %5 = llvm.add %4, %2 overflow<nsw>  : vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_sub_mask1_lshr_vector_nonuniform   : sub_mask1_lshr_vector_nonuniform_before  ⊑  sub_mask1_lshr_vector_nonuniform_combined := by
  unfold sub_mask1_lshr_vector_nonuniform_before sub_mask1_lshr_vector_nonuniform_combined
  simp_alive_peephole
  sorry
def sub_mask1_trunc_lshr_combined := [llvmfunc|
  llvm.func @sub_mask1_trunc_lshr(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.mlir.constant(10 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i64
    %4 = llvm.ashr %3, %1  : i64
    %5 = llvm.trunc %4 : i64 to i8
    %6 = llvm.add %5, %2 overflow<nsw>  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_sub_mask1_trunc_lshr   : sub_mask1_trunc_lshr_before  ⊑  sub_mask1_trunc_lshr_combined := by
  unfold sub_mask1_trunc_lshr_before sub_mask1_trunc_lshr_combined
  simp_alive_peephole
  sorry
def sub_sext_mask1_trunc_lshr_combined := [llvmfunc|
  llvm.func @sub_sext_mask1_trunc_lshr(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(48 : i64) : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.mlir.constant(10 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i64
    %4 = llvm.ashr %3, %1  : i64
    %5 = llvm.trunc %4 : i64 to i8
    %6 = llvm.add %5, %2 overflow<nsw>  : i8
    %7 = llvm.zext %6 : i8 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_sub_sext_mask1_trunc_lshr   : sub_sext_mask1_trunc_lshr_before  ⊑  sub_sext_mask1_trunc_lshr_combined := by
  unfold sub_sext_mask1_trunc_lshr_before sub_sext_mask1_trunc_lshr_combined
  simp_alive_peephole
  sorry
def sub_zext_trunc_lshr_combined := [llvmfunc|
  llvm.func @sub_zext_trunc_lshr(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.trunc %arg0 : i64 to i32
    %4 = llvm.shl %3, %0  : i32
    %5 = llvm.ashr %4, %1  : i32
    %6 = llvm.add %5, %2 overflow<nsw>  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_sub_zext_trunc_lshr   : sub_zext_trunc_lshr_before  ⊑  sub_zext_trunc_lshr_combined := by
  unfold sub_zext_trunc_lshr_before sub_zext_trunc_lshr_combined
  simp_alive_peephole
  sorry
def neg_mask2_lshr_combined := [llvmfunc|
  llvm.func @neg_mask2_lshr(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4 overflow<nsw>  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_neg_mask2_lshr   : neg_mask2_lshr_before  ⊑  neg_mask2_lshr_combined := by
  unfold neg_mask2_lshr_before neg_mask2_lshr_combined
  simp_alive_peephole
  sorry
def neg_mask2_lshr_outofbounds_combined := [llvmfunc|
  llvm.func @neg_mask2_lshr_outofbounds(%arg0: i8) -> i8 {
    %0 = llvm.mlir.poison : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_neg_mask2_lshr_outofbounds   : neg_mask2_lshr_outofbounds_before  ⊑  neg_mask2_lshr_outofbounds_combined := by
  unfold neg_mask2_lshr_outofbounds_before neg_mask2_lshr_outofbounds_combined
  simp_alive_peephole
  sorry
def neg_mask1_lshr_vector_var_combined := [llvmfunc|
  llvm.func @neg_mask1_lshr_vector_var(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.and %3, %0  : vector<2xi32>
    %5 = llvm.sub %2, %4 overflow<nsw>  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_neg_mask1_lshr_vector_var   : neg_mask1_lshr_vector_var_before  ⊑  neg_mask1_lshr_vector_var_combined := by
  unfold neg_mask1_lshr_vector_var_before neg_mask1_lshr_vector_var_combined
  simp_alive_peephole
  sorry
def neg_mask1_lshr_extrause_mask_combined := [llvmfunc|
  llvm.func @neg_mask1_lshr_extrause_mask(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.sub %2, %4 overflow<nsw>  : i8
    llvm.call @usei8(%4) : (i8) -> ()
    llvm.return %5 : i8
  }]

theorem inst_combine_neg_mask1_lshr_extrause_mask   : neg_mask1_lshr_extrause_mask_before  ⊑  neg_mask1_lshr_extrause_mask_combined := by
  unfold neg_mask1_lshr_extrause_mask_before neg_mask1_lshr_extrause_mask_combined
  simp_alive_peephole
  sorry
def neg_mask1_lshr_extrause_lshr_combined := [llvmfunc|
  llvm.func @neg_mask1_lshr_extrause_lshr(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.sub %3, %5 overflow<nsw>  : vector<2xi32>
    llvm.call @usev2i32(%4) : (vector<2xi32>) -> ()
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_neg_mask1_lshr_extrause_lshr   : neg_mask1_lshr_extrause_lshr_before  ⊑  neg_mask1_lshr_extrause_lshr_combined := by
  unfold neg_mask1_lshr_extrause_lshr_before neg_mask1_lshr_extrause_lshr_combined
  simp_alive_peephole
  sorry
def neg_signbit_combined := [llvmfunc|
  llvm.func @neg_signbit(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_neg_signbit   : neg_signbit_before  ⊑  neg_signbit_combined := by
  unfold neg_signbit_before neg_signbit_combined
  simp_alive_peephole
  sorry
def neg_signbit_use1_combined := [llvmfunc|
  llvm.func @neg_signbit_use1(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.lshr %arg0, %6  : vector<2xi32>
    llvm.call @usev2i32(%8) : (vector<2xi32>) -> ()
    %9 = llvm.ashr %arg0, %7  : vector<2xi32>
    %10 = llvm.sext %9 : vector<2xi32> to vector<2xi64>
    llvm.return %10 : vector<2xi64>
  }]

theorem inst_combine_neg_signbit_use1   : neg_signbit_use1_before  ⊑  neg_signbit_use1_combined := by
  unfold neg_signbit_use1_before neg_signbit_use1_combined
  simp_alive_peephole
  sorry
def neg_signbit_use2_combined := [llvmfunc|
  llvm.func @neg_signbit_use2(%arg0: i5) -> i8 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i5
    %3 = llvm.zext %2 : i5 to i8
    llvm.call @usei8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3 overflow<nsw>  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_neg_signbit_use2   : neg_signbit_use2_before  ⊑  neg_signbit_use2_combined := by
  unfold neg_signbit_use2_before neg_signbit_use2_combined
  simp_alive_peephole
  sorry
def neg_not_signbit1_combined := [llvmfunc|
  llvm.func @neg_not_signbit1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_neg_not_signbit1   : neg_not_signbit1_before  ⊑  neg_not_signbit1_combined := by
  unfold neg_not_signbit1_before neg_not_signbit1_combined
  simp_alive_peephole
  sorry
def neg_not_signbit2_combined := [llvmfunc|
  llvm.func @neg_not_signbit2(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_neg_not_signbit2   : neg_not_signbit2_before  ⊑  neg_not_signbit2_combined := by
  unfold neg_not_signbit2_before neg_not_signbit2_combined
  simp_alive_peephole
  sorry
def neg_not_signbit3_combined := [llvmfunc|
  llvm.func @neg_not_signbit3(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.sub %1, %3 overflow<nsw>  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_neg_not_signbit3   : neg_not_signbit3_before  ⊑  neg_not_signbit3_combined := by
  unfold neg_not_signbit3_before neg_not_signbit3_combined
  simp_alive_peephole
  sorry
def neg_mask_combined := [llvmfunc|
  llvm.func @neg_mask(%arg0: i32, %arg1: i16) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sext %arg1 : i16 to i32
    %3 = llvm.sub %arg0, %2 overflow<nsw>  : i32
    %4 = llvm.icmp "slt" %arg1, %0 : i16
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_neg_mask   : neg_mask_before  ⊑  neg_mask_combined := by
  unfold neg_mask_before neg_mask_combined
  simp_alive_peephole
  sorry
def neg_mask_const_combined := [llvmfunc|
  llvm.func @neg_mask_const(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(1000 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sext %arg0 : i16 to i32
    %4 = llvm.sub %0, %3 overflow<nsw>  : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i16
    %6 = llvm.select %5, %4, %2 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_neg_mask_const   : neg_mask_const_before  ⊑  neg_mask_const_combined := by
  unfold neg_mask_const_before neg_mask_const_combined
  simp_alive_peephole
  sorry
