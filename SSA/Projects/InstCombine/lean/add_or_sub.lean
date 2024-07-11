import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  add_or_sub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_or_sub_comb_i32_commuted1_nuw_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i32_commuted1_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.or %1, %arg0  : i32
    %3 = llvm.add %2, %arg0 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

def add_or_sub_comb_i8_commuted2_nsw_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_commuted2_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.sub %0, %1  : i8
    %3 = llvm.or %2, %1  : i8
    %4 = llvm.add %1, %3 overflow<nsw>  : i8
    llvm.return %4 : i8
  }]

def add_or_sub_comb_i128_commuted3_nuw_nsw_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i128_commuted3_nuw_nsw(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.mul %arg0, %arg0  : i128
    %2 = llvm.sub %0, %1  : i128
    %3 = llvm.or %1, %2  : i128
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i128
    llvm.return %4 : i128
  }]

def add_or_sub_comb_i64_commuted4_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i64_commuted4(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mul %arg0, %arg0  : i64
    %2 = llvm.sub %0, %1  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.add %1, %3  : i64
    llvm.return %4 : i64
  }]

def add_or_sub_comb_i32vec_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i32vec(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mul %arg0, %arg0  : vector<3xi32>
    %3 = llvm.sub %1, %2  : vector<3xi32>
    %4 = llvm.or %3, %2  : vector<3xi32>
    %5 = llvm.add %4, %2  : vector<3xi32>
    llvm.return %5 : vector<3xi32>
  }]

def add_or_sub_comb_i32vec_poison_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i32vec_poison(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<4xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi16>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi16>
    %11 = llvm.mul %arg0, %arg0  : vector<4xi16>
    %12 = llvm.sub %10, %11  : vector<4xi16>
    %13 = llvm.or %12, %11  : vector<4xi16>
    %14 = llvm.add %13, %11  : vector<4xi16>
    llvm.return %14 : vector<4xi16>
  }]

def add_or_sub_comb_i12_multiuse_only_sub_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i12_multiuse_only_sub(%arg0: i12) -> i12 {
    %0 = llvm.mlir.constant(0 : i12) : i12
    %1 = llvm.mul %arg0, %arg0  : i12
    %2 = llvm.sub %0, %1  : i12
    llvm.call @use12(%2) : (i12) -> ()
    %3 = llvm.or %2, %1  : i12
    %4 = llvm.add %3, %1  : i12
    llvm.return %4 : i12
  }]

def add_or_sub_comb_i8_negative_y_sub_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_negative_y_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def add_or_sub_comb_i8_negative_y_or_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_negative_y_or(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.or %1, %arg1  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def add_or_sub_comb_i8_negative_y_add_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_negative_y_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }]

def add_or_sub_comb_i8_negative_xor_instead_or_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_negative_xor_instead_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.xor %1, %arg0  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def add_or_sub_comb_i16_negative_sub_no_negate_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i16_negative_sub_no_negate(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.sub %0, %arg0  : i16
    %2 = llvm.or %1, %arg0  : i16
    %3 = llvm.add %2, %arg0  : i16
    llvm.return %3 : i16
  }]

def add_or_sub_comb_i2_negative_multiuse_only_or_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i2_negative_multiuse_only_or(%arg0: i2) -> i2 {
    %0 = llvm.mlir.constant(0 : i2) : i2
    %1 = llvm.mul %arg0, %arg0  : i2
    %2 = llvm.sub %0, %1  : i2
    %3 = llvm.or %2, %1  : i2
    llvm.call @use2(%3) : (i2) -> ()
    %4 = llvm.add %3, %1  : i2
    llvm.return %4 : i2
  }]

def add_or_sub_comb_i19_negative_multiuse_both_before := [llvmfunc|
  llvm.func @add_or_sub_comb_i19_negative_multiuse_both(%arg0: i19) -> i19 {
    %0 = llvm.mlir.constant(0 : i19) : i19
    %1 = llvm.mul %arg0, %arg0  : i19
    %2 = llvm.sub %0, %1  : i19
    llvm.call @use19(%2) : (i19) -> ()
    %3 = llvm.or %2, %1  : i19
    llvm.call @use19(%3) : (i19) -> ()
    %4 = llvm.add %3, %1  : i19
    llvm.return %4 : i19
  }]

def add_or_sub_comb_i32_commuted1_nuw_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i32_commuted1_nuw(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_add_or_sub_comb_i32_commuted1_nuw   : add_or_sub_comb_i32_commuted1_nuw_before  ⊑  add_or_sub_comb_i32_commuted1_nuw_combined := by
  unfold add_or_sub_comb_i32_commuted1_nuw_before add_or_sub_comb_i32_commuted1_nuw_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i8_commuted2_nsw_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_commuted2_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.add %1, %0 overflow<nsw>  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_or_sub_comb_i8_commuted2_nsw   : add_or_sub_comb_i8_commuted2_nsw_before  ⊑  add_or_sub_comb_i8_commuted2_nsw_combined := by
  unfold add_or_sub_comb_i8_commuted2_nsw_before add_or_sub_comb_i8_commuted2_nsw_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i128_commuted3_nuw_nsw_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i128_commuted3_nuw_nsw(%arg0: i128) -> i128 {
    %0 = llvm.mul %arg0, %arg0  : i128
    llvm.return %0 : i128
  }]

theorem inst_combine_add_or_sub_comb_i128_commuted3_nuw_nsw   : add_or_sub_comb_i128_commuted3_nuw_nsw_before  ⊑  add_or_sub_comb_i128_commuted3_nuw_nsw_combined := by
  unfold add_or_sub_comb_i128_commuted3_nuw_nsw_before add_or_sub_comb_i128_commuted3_nuw_nsw_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i64_commuted4_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i64_commuted4(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mul %arg0, %arg0  : i64
    %2 = llvm.add %1, %0  : i64
    %3 = llvm.and %2, %1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_add_or_sub_comb_i64_commuted4   : add_or_sub_comb_i64_commuted4_before  ⊑  add_or_sub_comb_i64_commuted4_combined := by
  unfold add_or_sub_comb_i64_commuted4_before add_or_sub_comb_i64_commuted4_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i32vec_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i32vec(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mul %arg0, %arg0  : vector<3xi32>
    %2 = llvm.add %1, %0  : vector<3xi32>
    %3 = llvm.and %2, %1  : vector<3xi32>
    llvm.return %3 : vector<3xi32>
  }]

theorem inst_combine_add_or_sub_comb_i32vec   : add_or_sub_comb_i32vec_before  ⊑  add_or_sub_comb_i32vec_combined := by
  unfold add_or_sub_comb_i32vec_before add_or_sub_comb_i32vec_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i32vec_poison_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i32vec_poison(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %arg0  : vector<4xi16>
    %2 = llvm.add %1, %0  : vector<4xi16>
    %3 = llvm.and %2, %1  : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

theorem inst_combine_add_or_sub_comb_i32vec_poison   : add_or_sub_comb_i32vec_poison_before  ⊑  add_or_sub_comb_i32vec_poison_combined := by
  unfold add_or_sub_comb_i32vec_poison_before add_or_sub_comb_i32vec_poison_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i12_multiuse_only_sub_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i12_multiuse_only_sub(%arg0: i12) -> i12 {
    %0 = llvm.mlir.constant(0 : i12) : i12
    %1 = llvm.mlir.constant(-1 : i12) : i12
    %2 = llvm.mul %arg0, %arg0  : i12
    %3 = llvm.sub %0, %2  : i12
    llvm.call @use12(%3) : (i12) -> ()
    %4 = llvm.add %2, %1  : i12
    %5 = llvm.and %4, %2  : i12
    llvm.return %5 : i12
  }]

theorem inst_combine_add_or_sub_comb_i12_multiuse_only_sub   : add_or_sub_comb_i12_multiuse_only_sub_before  ⊑  add_or_sub_comb_i12_multiuse_only_sub_combined := by
  unfold add_or_sub_comb_i12_multiuse_only_sub_before add_or_sub_comb_i12_multiuse_only_sub_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i8_negative_y_sub_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_negative_y_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_or_sub_comb_i8_negative_y_sub   : add_or_sub_comb_i8_negative_y_sub_before  ⊑  add_or_sub_comb_i8_negative_y_sub_combined := by
  unfold add_or_sub_comb_i8_negative_y_sub_before add_or_sub_comb_i8_negative_y_sub_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i8_negative_y_or_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_negative_y_or(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.or %1, %arg1  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_or_sub_comb_i8_negative_y_or   : add_or_sub_comb_i8_negative_y_or_before  ⊑  add_or_sub_comb_i8_negative_y_or_combined := by
  unfold add_or_sub_comb_i8_negative_y_or_before add_or_sub_comb_i8_negative_y_or_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i8_negative_y_add_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_negative_y_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.add %2, %arg1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_or_sub_comb_i8_negative_y_add   : add_or_sub_comb_i8_negative_y_add_before  ⊑  add_or_sub_comb_i8_negative_y_add_combined := by
  unfold add_or_sub_comb_i8_negative_y_add_before add_or_sub_comb_i8_negative_y_add_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i8_negative_xor_instead_or_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i8_negative_xor_instead_or(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.xor %1, %arg0  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_add_or_sub_comb_i8_negative_xor_instead_or   : add_or_sub_comb_i8_negative_xor_instead_or_before  ⊑  add_or_sub_comb_i8_negative_xor_instead_or_combined := by
  unfold add_or_sub_comb_i8_negative_xor_instead_or_before add_or_sub_comb_i8_negative_xor_instead_or_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i16_negative_sub_no_negate_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i16_negative_sub_no_negate(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.sub %0, %arg0  : i16
    %2 = llvm.or %1, %arg0  : i16
    %3 = llvm.add %2, %arg0  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_add_or_sub_comb_i16_negative_sub_no_negate   : add_or_sub_comb_i16_negative_sub_no_negate_before  ⊑  add_or_sub_comb_i16_negative_sub_no_negate_combined := by
  unfold add_or_sub_comb_i16_negative_sub_no_negate_before add_or_sub_comb_i16_negative_sub_no_negate_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i2_negative_multiuse_only_or_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i2_negative_multiuse_only_or(%arg0: i2) -> i2 {
    %0 = llvm.mlir.constant(0 : i2) : i2
    %1 = llvm.mul %arg0, %arg0  : i2
    %2 = llvm.sub %0, %1  : i2
    %3 = llvm.or %1, %2  : i2
    llvm.call @use2(%3) : (i2) -> ()
    %4 = llvm.add %3, %1  : i2
    llvm.return %4 : i2
  }]

theorem inst_combine_add_or_sub_comb_i2_negative_multiuse_only_or   : add_or_sub_comb_i2_negative_multiuse_only_or_before  ⊑  add_or_sub_comb_i2_negative_multiuse_only_or_combined := by
  unfold add_or_sub_comb_i2_negative_multiuse_only_or_before add_or_sub_comb_i2_negative_multiuse_only_or_combined
  simp_alive_peephole
  sorry
def add_or_sub_comb_i19_negative_multiuse_both_combined := [llvmfunc|
  llvm.func @add_or_sub_comb_i19_negative_multiuse_both(%arg0: i19) -> i19 {
    %0 = llvm.mlir.constant(0 : i19) : i19
    %1 = llvm.mul %arg0, %arg0  : i19
    %2 = llvm.sub %0, %1  : i19
    llvm.call @use19(%2) : (i19) -> ()
    %3 = llvm.or %1, %2  : i19
    llvm.call @use19(%3) : (i19) -> ()
    %4 = llvm.add %3, %1  : i19
    llvm.return %4 : i19
  }]

theorem inst_combine_add_or_sub_comb_i19_negative_multiuse_both   : add_or_sub_comb_i19_negative_multiuse_both_before  ⊑  add_or_sub_comb_i19_negative_multiuse_both_combined := by
  unfold add_or_sub_comb_i19_negative_multiuse_both_before add_or_sub_comb_i19_negative_multiuse_both_combined
  simp_alive_peephole
  sorry
