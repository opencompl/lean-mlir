import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-icmp-and-zero-shl
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_eq_before := [llvmfunc|
  llvm.func @test_eq(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.shl %arg0, %2  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_eq_vect_before := [llvmfunc|
  llvm.func @test_eq_vect(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.shl %arg0, %3  : vector<2xi32>
    %7 = llvm.select %5, %2, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test_ne_before := [llvmfunc|
  llvm.func @test_ne(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.shl %arg0, %2  : i32
    %6 = llvm.select %4, %5, %1 : i1, i32
    llvm.return %6 : i32
  }]

def test_ne_vect_before := [llvmfunc|
  llvm.func @test_ne_vect(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.shl %arg0, %3  : vector<2xi32>
    %7 = llvm.select %5, %6, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test_nuw_dropped_before := [llvmfunc|
  llvm.func @test_nuw_dropped(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.shl %arg0, %2 overflow<nuw>  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_nsw_dropped_before := [llvmfunc|
  llvm.func @test_nsw_dropped(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.shl %arg0, %2 overflow<nsw>  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_multi_use_before := [llvmfunc|
  llvm.func @test_multi_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.shl %arg0, %2  : i32
    %6 = llvm.select %4, %5, %1 : i1, i32
    llvm.call @use_multi(%3, %4, %5) : (i32, i1, i32) -> ()
    llvm.return %6 : i32
  }]

def test_multi_use_nuw_dropped_before := [llvmfunc|
  llvm.func @test_multi_use_nuw_dropped(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.shl %arg0, %2 overflow<nuw>  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.call @use_multi(%3, %4, %5) : (i32, i1, i32) -> ()
    llvm.return %6 : i32
  }]

def neg_test_bits_not_match_before := [llvmfunc|
  llvm.func @neg_test_bits_not_match(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.shl %arg0, %2  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def neg_test_icmp_non_equality_before := [llvmfunc|
  llvm.func @neg_test_icmp_non_equality(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.shl %arg0, %2  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def neg_test_select_non_zero_constant_before := [llvmfunc|
  llvm.func @neg_test_select_non_zero_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def neg_test_icmp_non_zero_constant_before := [llvmfunc|
  llvm.func @neg_test_icmp_non_zero_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_eq_combined := [llvmfunc|
  llvm.func @test_eq(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_eq   : test_eq_before  ⊑  test_eq_combined := by
  unfold test_eq_before test_eq_combined
  simp_alive_peephole
  sorry
def test_eq_vect_combined := [llvmfunc|
  llvm.func @test_eq_vect(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_test_eq_vect   : test_eq_vect_before  ⊑  test_eq_vect_combined := by
  unfold test_eq_vect_before test_eq_vect_combined
  simp_alive_peephole
  sorry
def test_ne_combined := [llvmfunc|
  llvm.func @test_ne(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_ne   : test_ne_before  ⊑  test_ne_combined := by
  unfold test_ne_before test_ne_combined
  simp_alive_peephole
  sorry
def test_ne_vect_combined := [llvmfunc|
  llvm.func @test_ne_vect(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_test_ne_vect   : test_ne_vect_before  ⊑  test_ne_vect_combined := by
  unfold test_ne_vect_before test_ne_vect_combined
  simp_alive_peephole
  sorry
def test_nuw_dropped_combined := [llvmfunc|
  llvm.func @test_nuw_dropped(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_nuw_dropped   : test_nuw_dropped_before  ⊑  test_nuw_dropped_combined := by
  unfold test_nuw_dropped_before test_nuw_dropped_combined
  simp_alive_peephole
  sorry
def test_nsw_dropped_combined := [llvmfunc|
  llvm.func @test_nsw_dropped(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_nsw_dropped   : test_nsw_dropped_before  ⊑  test_nsw_dropped_combined := by
  unfold test_nsw_dropped_before test_nsw_dropped_combined
  simp_alive_peephole
  sorry
def test_multi_use_combined := [llvmfunc|
  llvm.func @test_multi_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.shl %arg0, %2  : i32
    llvm.call @use_multi(%3, %4, %5) : (i32, i1, i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_test_multi_use   : test_multi_use_before  ⊑  test_multi_use_combined := by
  unfold test_multi_use_before test_multi_use_combined
  simp_alive_peephole
  sorry
def test_multi_use_nuw_dropped_combined := [llvmfunc|
  llvm.func @test_multi_use_nuw_dropped(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.shl %arg0, %2  : i32
    llvm.call @use_multi(%3, %4, %5) : (i32, i1, i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_test_multi_use_nuw_dropped   : test_multi_use_nuw_dropped_before  ⊑  test_multi_use_nuw_dropped_combined := by
  unfold test_multi_use_nuw_dropped_before test_multi_use_nuw_dropped_combined
  simp_alive_peephole
  sorry
def neg_test_bits_not_match_combined := [llvmfunc|
  llvm.func @neg_test_bits_not_match(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.shl %arg0, %2  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_neg_test_bits_not_match   : neg_test_bits_not_match_before  ⊑  neg_test_bits_not_match_combined := by
  unfold neg_test_bits_not_match_before neg_test_bits_not_match_combined
  simp_alive_peephole
  sorry
def neg_test_icmp_non_equality_combined := [llvmfunc|
  llvm.func @neg_test_icmp_non_equality(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_neg_test_icmp_non_equality   : neg_test_icmp_non_equality_before  ⊑  neg_test_icmp_non_equality_combined := by
  unfold neg_test_icmp_non_equality_before neg_test_icmp_non_equality_combined
  simp_alive_peephole
  sorry
def neg_test_select_non_zero_constant_combined := [llvmfunc|
  llvm.func @neg_test_select_non_zero_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_neg_test_select_non_zero_constant   : neg_test_select_non_zero_constant_before  ⊑  neg_test_select_non_zero_constant_combined := by
  unfold neg_test_select_non_zero_constant_before neg_test_select_non_zero_constant_combined
  simp_alive_peephole
  sorry
def neg_test_icmp_non_zero_constant_combined := [llvmfunc|
  llvm.func @neg_test_icmp_non_zero_constant(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %arg0, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_neg_test_icmp_non_zero_constant   : neg_test_icmp_non_zero_constant_before  ⊑  neg_test_icmp_non_zero_constant_combined := by
  unfold neg_test_icmp_non_zero_constant_before neg_test_icmp_non_zero_constant_combined
  simp_alive_peephole
  sorry
