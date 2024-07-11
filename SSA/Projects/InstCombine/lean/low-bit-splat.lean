import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  low-bit-splat
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.return %2 : i8
  }]

def t1_otherbitwidth_before := [llvmfunc|
  llvm.func @t1_otherbitwidth(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    %2 = llvm.ashr %1, %0  : i16
    llvm.return %2 : i16
  }]

def t2_vec_before := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.ashr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def t3_vec_poison0_before := [llvmfunc|
  llvm.func @t3_vec_poison0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<7> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %arg0, %8  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

def t4_vec_poison1_before := [llvmfunc|
  llvm.func @t4_vec_poison1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.shl %arg0, %0  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    llvm.return %11 : vector<3xi8>
  }]

def t5_vec_poison2_before := [llvmfunc|
  llvm.func @t5_vec_poison2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.shl %arg0, %8  : vector<3xi8>
    %10 = llvm.ashr %9, %8  : vector<3xi8>
    llvm.return %10 : vector<3xi8>
  }]

def n6_extrause_before := [llvmfunc|
  llvm.func @n6_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    llvm.return %2 : i8
  }]

def t7_already_masked_before := [llvmfunc|
  llvm.func @t7_already_masked(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.ashr %3, %1  : i8
    llvm.return %4 : i8
  }]

def t8_already_masked_extrause_before := [llvmfunc|
  llvm.func @t8_already_masked_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.ashr %3, %1  : i8
    llvm.return %4 : i8
  }]

def n9_wrongly_masked_extrause_before := [llvmfunc|
  llvm.func @n9_wrongly_masked_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.ashr %3, %1  : i8
    llvm.return %4 : i8
  }]

def n10_before := [llvmfunc|
  llvm.func @n10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }]

def n11_before := [llvmfunc|
  llvm.func @n11(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }]

def n12_before := [llvmfunc|
  llvm.func @n12(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.return %2 : i8
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sub %1, %2 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_otherbitwidth_combined := [llvmfunc|
  llvm.func @t1_otherbitwidth(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.sub %1, %2 overflow<nsw>  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_t1_otherbitwidth   : t1_otherbitwidth_before  ⊑  t1_otherbitwidth_combined := by
  unfold t1_otherbitwidth_before t1_otherbitwidth_combined
  simp_alive_peephole
  sorry
def t2_vec_combined := [llvmfunc|
  llvm.func @t2_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.sub %2, %3 overflow<nsw>  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_t2_vec   : t2_vec_before  ⊑  t2_vec_combined := by
  unfold t2_vec_before t2_vec_combined
  simp_alive_peephole
  sorry
def t3_vec_poison0_combined := [llvmfunc|
  llvm.func @t3_vec_poison0(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(0 : i8) : i8
    %10 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %11 = llvm.and %arg0, %8  : vector<3xi8>
    %12 = llvm.sub %10, %11  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_t3_vec_poison0   : t3_vec_poison0_before  ⊑  t3_vec_poison0_combined := by
  unfold t3_vec_poison0_before t3_vec_poison0_combined
  simp_alive_peephole
  sorry
def t4_vec_poison1_combined := [llvmfunc|
  llvm.func @t4_vec_poison1(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(0 : i8) : i8
    %10 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %11 = llvm.and %arg0, %8  : vector<3xi8>
    %12 = llvm.sub %10, %11  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_t4_vec_poison1   : t4_vec_poison1_before  ⊑  t4_vec_poison1_combined := by
  unfold t4_vec_poison1_before t4_vec_poison1_combined
  simp_alive_peephole
  sorry
def t5_vec_poison2_combined := [llvmfunc|
  llvm.func @t5_vec_poison2(%arg0: vector<3xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(0 : i8) : i8
    %10 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %11 = llvm.and %arg0, %8  : vector<3xi8>
    %12 = llvm.sub %10, %11  : vector<3xi8>
    llvm.return %12 : vector<3xi8>
  }]

theorem inst_combine_t5_vec_poison2   : t5_vec_poison2_before  ⊑  t5_vec_poison2_combined := by
  unfold t5_vec_poison2_before t5_vec_poison2_combined
  simp_alive_peephole
  sorry
def n6_extrause_combined := [llvmfunc|
  llvm.func @n6_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n6_extrause   : n6_extrause_before  ⊑  n6_extrause_combined := by
  unfold n6_extrause_before n6_extrause_combined
  simp_alive_peephole
  sorry
def t7_already_masked_combined := [llvmfunc|
  llvm.func @t7_already_masked(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.sub %1, %3 overflow<nsw>  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t7_already_masked   : t7_already_masked_before  ⊑  t7_already_masked_combined := by
  unfold t7_already_masked_before t7_already_masked_combined
  simp_alive_peephole
  sorry
def t8_already_masked_extrause_combined := [llvmfunc|
  llvm.func @t8_already_masked_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %arg0, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.ashr %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t8_already_masked_extrause   : t8_already_masked_extrause_before  ⊑  t8_already_masked_extrause_combined := by
  unfold t8_already_masked_extrause_before t8_already_masked_extrause_combined
  simp_alive_peephole
  sorry
def n9_wrongly_masked_extrause_combined := [llvmfunc|
  llvm.func @n9_wrongly_masked_extrause(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.shl %arg0, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.ashr %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_n9_wrongly_masked_extrause   : n9_wrongly_masked_extrause_before  ⊑  n9_wrongly_masked_extrause_combined := by
  unfold n9_wrongly_masked_extrause_before n9_wrongly_masked_extrause_combined
  simp_alive_peephole
  sorry
def n10_combined := [llvmfunc|
  llvm.func @n10(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n10   : n10_before  ⊑  n10_combined := by
  unfold n10_before n10_combined
  simp_alive_peephole
  sorry
def n11_combined := [llvmfunc|
  llvm.func @n11(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n11   : n11_before  ⊑  n11_combined := by
  unfold n11_before n11_combined
  simp_alive_peephole
  sorry
def n12_combined := [llvmfunc|
  llvm.func @n12(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_n12   : n12_before  ⊑  n12_combined := by
  unfold n12_before n12_combined
  simp_alive_peephole
  sorry
