import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  lshr-trunc-sext-to-ashr-sext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i3
    %3 = llvm.sext %2 : i3 to i16
    llvm.return %3 : i16
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i7) -> i16 {
    %0 = llvm.mlir.constant(3 : i7) : i7
    %1 = llvm.lshr %arg0, %0  : i7
    %2 = llvm.trunc %1 : i7 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def n3_before := [llvmfunc|
  llvm.func @n3(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def t4_vec_splat_before := [llvmfunc|
  llvm.func @t4_vec_splat(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg0, %0  : vector<2xi8>
    %2 = llvm.trunc %1 : vector<2xi8> to vector<2xi4>
    %3 = llvm.sext %2 : vector<2xi4> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def t5_vec_poison_before := [llvmfunc|
  llvm.func @t5_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }]

def t6_extrause0_before := [llvmfunc|
  llvm.func @t6_extrause0(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i4
    llvm.call @use4(%2) : (i4) -> ()
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def t7_extrause0_vec_poison_before := [llvmfunc|
  llvm.func @t7_extrause0_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    llvm.call @usevec4(%8) : (vector<2xi4>) -> ()
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }]

def t8_extrause1_before := [llvmfunc|
  llvm.func @t8_extrause1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def t9_extrause1_vec_poison_before := [llvmfunc|
  llvm.func @t9_extrause1_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    llvm.call @usevec8(%7) : (vector<2xi8>) -> ()
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }]

def t10_extrause2_before := [llvmfunc|
  llvm.func @t10_extrause2(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    llvm.call @use4(%2) : (i4) -> ()
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def t11_extrause2_vec_poison_before := [llvmfunc|
  llvm.func @t11_extrause2_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    llvm.call @usevec8(%7) : (vector<2xi8>) -> ()
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    llvm.call @usevec4(%8) : (vector<2xi4>) -> ()
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }]

def wide_source_shifted_signbit_before := [llvmfunc|
  llvm.func @wide_source_shifted_signbit(%arg0: vector<2xi32>) -> vector<2xi10> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi8>
    %3 = llvm.sext %2 : vector<2xi8> to vector<2xi10>
    llvm.return %3 : vector<2xi10>
  }]

def wide_source_shifted_signbit_use1_before := [llvmfunc|
  llvm.func @wide_source_shifted_signbit_use1(%arg0: i32) -> i10 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.trunc %1 : i32 to i8
    %3 = llvm.sext %2 : i8 to i10
    llvm.return %3 : i10
  }]

def wide_source_shifted_signbit_use2_before := [llvmfunc|
  llvm.func @wide_source_shifted_signbit_use2(%arg0: i32) -> i10 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i10
    llvm.return %3 : i10
  }]

def same_source_shifted_signbit_before := [llvmfunc|
  llvm.func @same_source_shifted_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }]

def same_source_shifted_signbit_use1_before := [llvmfunc|
  llvm.func @same_source_shifted_signbit_use1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.trunc %1 : i32 to i8
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }]

def same_source_shifted_signbit_use2_before := [llvmfunc|
  llvm.func @same_source_shifted_signbit_use2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.sext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i7) -> i16 {
    %0 = llvm.mlir.constant(3 : i7) : i7
    %1 = llvm.ashr %arg0, %0  : i7
    %2 = llvm.sext %1 : i7 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def n3_combined := [llvmfunc|
  llvm.func @n3(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_n3   : n3_before  ⊑  n3_combined := by
  unfold n3_before n3_combined
  simp_alive_peephole
  sorry
def t4_vec_splat_combined := [llvmfunc|
  llvm.func @t4_vec_splat(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    %2 = llvm.sext %1 : vector<2xi8> to vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_t4_vec_splat   : t4_vec_splat_before  ⊑  t4_vec_splat_combined := by
  unfold t4_vec_splat_before t4_vec_splat_combined
  simp_alive_peephole
  sorry
def t5_vec_poison_combined := [llvmfunc|
  llvm.func @t5_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    %2 = llvm.sext %1 : vector<2xi8> to vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_t5_vec_poison   : t5_vec_poison_before  ⊑  t5_vec_poison_combined := by
  unfold t5_vec_poison_before t5_vec_poison_combined
  simp_alive_peephole
  sorry
def t6_extrause0_combined := [llvmfunc|
  llvm.func @t6_extrause0(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.trunc %1 : i8 to i4
    llvm.call @use4(%2) : (i4) -> ()
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_t6_extrause0   : t6_extrause0_before  ⊑  t6_extrause0_combined := by
  unfold t6_extrause0_before t6_extrause0_combined
  simp_alive_peephole
  sorry
def t7_extrause0_vec_poison_combined := [llvmfunc|
  llvm.func @t7_extrause0_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    llvm.call @usevec4(%8) : (vector<2xi4>) -> ()
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }]

theorem inst_combine_t7_extrause0_vec_poison   : t7_extrause0_vec_poison_before  ⊑  t7_extrause0_vec_poison_combined := by
  unfold t7_extrause0_vec_poison_before t7_extrause0_vec_poison_combined
  simp_alive_peephole
  sorry
def t8_extrause1_combined := [llvmfunc|
  llvm.func @t8_extrause1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.sext %2 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_t8_extrause1   : t8_extrause1_before  ⊑  t8_extrause1_combined := by
  unfold t8_extrause1_before t8_extrause1_combined
  simp_alive_peephole
  sorry
def t9_extrause1_vec_poison_combined := [llvmfunc|
  llvm.func @t9_extrause1_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.lshr %arg0, %6  : vector<2xi8>
    llvm.call @usevec8(%8) : (vector<2xi8>) -> ()
    %9 = llvm.ashr %arg0, %7  : vector<2xi8>
    %10 = llvm.sext %9 : vector<2xi8> to vector<2xi16>
    llvm.return %10 : vector<2xi16>
  }]

theorem inst_combine_t9_extrause1_vec_poison   : t9_extrause1_vec_poison_before  ⊑  t9_extrause1_vec_poison_combined := by
  unfold t9_extrause1_vec_poison_before t9_extrause1_vec_poison_combined
  simp_alive_peephole
  sorry
def t10_extrause2_combined := [llvmfunc|
  llvm.func @t10_extrause2(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    llvm.call @use4(%2) : (i4) -> ()
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_t10_extrause2   : t10_extrause2_before  ⊑  t10_extrause2_combined := by
  unfold t10_extrause2_before t10_extrause2_combined
  simp_alive_peephole
  sorry
def t11_extrause2_vec_poison_combined := [llvmfunc|
  llvm.func @t11_extrause2_vec_poison(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.lshr %arg0, %6  : vector<2xi8>
    llvm.call @usevec8(%7) : (vector<2xi8>) -> ()
    %8 = llvm.trunc %7 : vector<2xi8> to vector<2xi4>
    llvm.call @usevec4(%8) : (vector<2xi4>) -> ()
    %9 = llvm.sext %8 : vector<2xi4> to vector<2xi16>
    llvm.return %9 : vector<2xi16>
  }]

theorem inst_combine_t11_extrause2_vec_poison   : t11_extrause2_vec_poison_before  ⊑  t11_extrause2_vec_poison_combined := by
  unfold t11_extrause2_vec_poison_before t11_extrause2_vec_poison_combined
  simp_alive_peephole
  sorry
def wide_source_shifted_signbit_combined := [llvmfunc|
  llvm.func @wide_source_shifted_signbit(%arg0: vector<2xi32>) -> vector<2xi10> {
    %0 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.ashr %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi10>
    llvm.return %2 : vector<2xi10>
  }]

theorem inst_combine_wide_source_shifted_signbit   : wide_source_shifted_signbit_before  ⊑  wide_source_shifted_signbit_combined := by
  unfold wide_source_shifted_signbit_before wide_source_shifted_signbit_combined
  simp_alive_peephole
  sorry
def wide_source_shifted_signbit_use1_combined := [llvmfunc|
  llvm.func @wide_source_shifted_signbit_use1(%arg0: i32) -> i10 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i10
    llvm.return %3 : i10
  }]

theorem inst_combine_wide_source_shifted_signbit_use1   : wide_source_shifted_signbit_use1_before  ⊑  wide_source_shifted_signbit_use1_combined := by
  unfold wide_source_shifted_signbit_use1_before wide_source_shifted_signbit_use1_combined
  simp_alive_peephole
  sorry
def wide_source_shifted_signbit_use2_combined := [llvmfunc|
  llvm.func @wide_source_shifted_signbit_use2(%arg0: i32) -> i10 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i10
    llvm.return %3 : i10
  }]

theorem inst_combine_wide_source_shifted_signbit_use2   : wide_source_shifted_signbit_use2_before  ⊑  wide_source_shifted_signbit_use2_combined := by
  unfold wide_source_shifted_signbit_use2_before wide_source_shifted_signbit_use2_combined
  simp_alive_peephole
  sorry
def same_source_shifted_signbit_combined := [llvmfunc|
  llvm.func @same_source_shifted_signbit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_same_source_shifted_signbit   : same_source_shifted_signbit_before  ⊑  same_source_shifted_signbit_combined := by
  unfold same_source_shifted_signbit_before same_source_shifted_signbit_combined
  simp_alive_peephole
  sorry
def same_source_shifted_signbit_use1_combined := [llvmfunc|
  llvm.func @same_source_shifted_signbit_use1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.ashr %arg0, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_same_source_shifted_signbit_use1   : same_source_shifted_signbit_use1_before  ⊑  same_source_shifted_signbit_use1_combined := by
  unfold same_source_shifted_signbit_use1_before same_source_shifted_signbit_use1_combined
  simp_alive_peephole
  sorry
def same_source_shifted_signbit_use2_combined := [llvmfunc|
  llvm.func @same_source_shifted_signbit_use2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sext %2 : i8 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_same_source_shifted_signbit_use2   : same_source_shifted_signbit_use2_before  ⊑  same_source_shifted_signbit_use2_combined := by
  unfold same_source_shifted_signbit_use2_before same_source_shifted_signbit_use2_combined
  simp_alive_peephole
  sorry
