import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sext-of-trunc-nsw
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def t3_vec_before := [llvmfunc|
  llvm.func @t3_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.call @usevec(%1) : (vector<2xi8>) -> ()
    %2 = llvm.trunc %1 : vector<2xi8> to vector<2xi4>
    %3 = llvm.sext %2 : vector<2xi4> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def t4_vec_nonsplat_before := [llvmfunc|
  llvm.func @t4_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[4, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.call @usevec(%1) : (vector<2xi8>) -> ()
    %2 = llvm.trunc %1 : vector<2xi8> to vector<2xi4>
    %3 = llvm.sext %2 : vector<2xi4> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

def t5_extrause_before := [llvmfunc|
  llvm.func @t5_extrause(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    llvm.call @use4(%2) : (i4) -> ()
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

def narrow_source_matching_signbits_before := [llvmfunc|
  llvm.func @narrow_source_matching_signbits(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i64
    llvm.return %5 : i64
  }]

def narrow_source_not_matching_signbits_before := [llvmfunc|
  llvm.func @narrow_source_not_matching_signbits(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i64
    llvm.return %5 : i64
  }]

def wide_source_matching_signbits_before := [llvmfunc|
  llvm.func @wide_source_matching_signbits(%arg0: i32) -> i24 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i24
    llvm.return %5 : i24
  }]

def wide_source_not_matching_signbits_before := [llvmfunc|
  llvm.func @wide_source_not_matching_signbits(%arg0: i32) -> i24 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i24
    llvm.return %5 : i24
  }]

def same_source_matching_signbits_before := [llvmfunc|
  llvm.func @same_source_matching_signbits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i32
    llvm.return %5 : i32
  }]

def same_source_not_matching_signbits_before := [llvmfunc|
  llvm.func @same_source_not_matching_signbits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i32
    llvm.return %5 : i32
  }]

def same_source_matching_signbits_extra_use_before := [llvmfunc|
  llvm.func @same_source_matching_signbits_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.sext %4 : i8 to i32
    llvm.return %5 : i32
  }]

def same_source_not_matching_signbits_extra_use_before := [llvmfunc|
  llvm.func @same_source_not_matching_signbits_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.sext %4 : i8 to i32
    llvm.return %5 : i32
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sext %1 : i8 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def t3_vec_combined := [llvmfunc|
  llvm.func @t3_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.call @usevec(%1) : (vector<2xi8>) -> ()
    %2 = llvm.sext %1 : vector<2xi8> to vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_t3_vec   : t3_vec_before  ⊑  t3_vec_combined := by
  unfold t3_vec_before t3_vec_combined
  simp_alive_peephole
  sorry
def t4_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t4_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[4, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.call @usevec(%1) : (vector<2xi8>) -> ()
    %2 = llvm.trunc %1 : vector<2xi8> to vector<2xi4>
    %3 = llvm.sext %2 : vector<2xi4> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }]

theorem inst_combine_t4_vec_nonsplat   : t4_vec_nonsplat_before  ⊑  t4_vec_nonsplat_combined := by
  unfold t4_vec_nonsplat_before t4_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t5_extrause_combined := [llvmfunc|
  llvm.func @t5_extrause(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    llvm.call @use4(%2) : (i4) -> ()
    %3 = llvm.sext %1 : i8 to i16
    llvm.return %3 : i16
  }]

theorem inst_combine_t5_extrause   : t5_extrause_before  ⊑  t5_extrause_combined := by
  unfold t5_extrause_before t5_extrause_combined
  simp_alive_peephole
  sorry
def narrow_source_matching_signbits_combined := [llvmfunc|
  llvm.func @narrow_source_matching_signbits(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.sext %3 : i32 to i64
    llvm.return %4 : i64
  }]

theorem inst_combine_narrow_source_matching_signbits   : narrow_source_matching_signbits_before  ⊑  narrow_source_matching_signbits_combined := by
  unfold narrow_source_matching_signbits_before narrow_source_matching_signbits_combined
  simp_alive_peephole
  sorry
def narrow_source_not_matching_signbits_combined := [llvmfunc|
  llvm.func @narrow_source_not_matching_signbits(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i64
    llvm.return %5 : i64
  }]

theorem inst_combine_narrow_source_not_matching_signbits   : narrow_source_not_matching_signbits_before  ⊑  narrow_source_not_matching_signbits_combined := by
  unfold narrow_source_not_matching_signbits_before narrow_source_not_matching_signbits_combined
  simp_alive_peephole
  sorry
def wide_source_matching_signbits_combined := [llvmfunc|
  llvm.func @wide_source_matching_signbits(%arg0: i32) -> i24 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i24
    llvm.return %4 : i24
  }]

theorem inst_combine_wide_source_matching_signbits   : wide_source_matching_signbits_before  ⊑  wide_source_matching_signbits_combined := by
  unfold wide_source_matching_signbits_before wide_source_matching_signbits_combined
  simp_alive_peephole
  sorry
def wide_source_not_matching_signbits_combined := [llvmfunc|
  llvm.func @wide_source_not_matching_signbits(%arg0: i32) -> i24 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i24
    llvm.return %5 : i24
  }]

theorem inst_combine_wide_source_not_matching_signbits   : wide_source_not_matching_signbits_before  ⊑  wide_source_not_matching_signbits_combined := by
  unfold wide_source_not_matching_signbits_before wide_source_not_matching_signbits_combined
  simp_alive_peephole
  sorry
def same_source_matching_signbits_combined := [llvmfunc|
  llvm.func @same_source_matching_signbits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_same_source_matching_signbits   : same_source_matching_signbits_before  ⊑  same_source_matching_signbits_combined := by
  unfold same_source_matching_signbits_before same_source_matching_signbits_combined
  simp_alive_peephole
  sorry
def same_source_not_matching_signbits_combined := [llvmfunc|
  llvm.func @same_source_not_matching_signbits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.mlir.constant(24 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %1, %3  : i32
    %5 = llvm.ashr %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_same_source_not_matching_signbits   : same_source_not_matching_signbits_before  ⊑  same_source_not_matching_signbits_combined := by
  unfold same_source_not_matching_signbits_before same_source_not_matching_signbits_combined
  simp_alive_peephole
  sorry
def same_source_matching_signbits_extra_use_combined := [llvmfunc|
  llvm.func @same_source_matching_signbits_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.call @use8(%4) : (i8) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_same_source_matching_signbits_extra_use   : same_source_matching_signbits_extra_use_before  ⊑  same_source_matching_signbits_extra_use_combined := by
  unfold same_source_matching_signbits_extra_use_before same_source_matching_signbits_extra_use_combined
  simp_alive_peephole
  sorry
def same_source_not_matching_signbits_extra_use_combined := [llvmfunc|
  llvm.func @same_source_not_matching_signbits_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.sext %4 : i8 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_same_source_not_matching_signbits_extra_use   : same_source_not_matching_signbits_extra_use_before  ⊑  same_source_not_matching_signbits_extra_use_combined := by
  unfold same_source_not_matching_signbits_extra_use_before same_source_not_matching_signbits_extra_use_combined
  simp_alive_peephole
  sorry
