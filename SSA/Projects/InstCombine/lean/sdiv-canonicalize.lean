import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sdiv-canonicalize
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_sdiv_canonicalize_op0_before := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_op0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test_sdiv_canonicalize_op0_exact_before := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_op0_exact(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test_sdiv_canonicalize_op1_before := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_op1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.sdiv %2, %3  : i32
    llvm.return %4 : i32
  }]

def test_sdiv_canonicalize_nonsw_before := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_nonsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def test_sdiv_canonicalize_vec_before := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.sdiv %2, %arg1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test_sdiv_canonicalize_multiple_uses_before := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_multiple_uses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    %3 = llvm.sdiv %2, %1  : i32
    llvm.return %3 : i32
  }]

def test_sdiv_canonicalize_constexpr_before := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_constexpr(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.addressof @X : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3 overflow<nsw>  : i64
    %5 = llvm.sdiv %arg0, %4  : i64
    llvm.return %5 : i64
  }]

def sdiv_abs_nsw_before := [llvmfunc|
  llvm.func @sdiv_abs_nsw(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def sdiv_abs_nsw_vec_before := [llvmfunc|
  llvm.func @sdiv_abs_nsw_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<4xi32>) -> vector<4xi32>]

    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def sdiv_abs_before := [llvmfunc|
  llvm.func @sdiv_abs(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def sdiv_abs_extra_use_before := [llvmfunc|
  llvm.func @sdiv_abs_extra_use(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def test_sdiv_canonicalize_op0_combined := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_op0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sdiv %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_sdiv_canonicalize_op0   : test_sdiv_canonicalize_op0_before  ⊑  test_sdiv_canonicalize_op0_combined := by
  unfold test_sdiv_canonicalize_op0_before test_sdiv_canonicalize_op0_combined
  simp_alive_peephole
  sorry
def test_sdiv_canonicalize_op0_exact_combined := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_op0_exact(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sdiv %arg0, %arg1  : i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_sdiv_canonicalize_op0_exact   : test_sdiv_canonicalize_op0_exact_before  ⊑  test_sdiv_canonicalize_op0_exact_combined := by
  unfold test_sdiv_canonicalize_op0_exact_before test_sdiv_canonicalize_op0_exact_combined
  simp_alive_peephole
  sorry
def test_sdiv_canonicalize_op1_combined := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_op1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.sdiv %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test_sdiv_canonicalize_op1   : test_sdiv_canonicalize_op1_before  ⊑  test_sdiv_canonicalize_op1_combined := by
  unfold test_sdiv_canonicalize_op1_before test_sdiv_canonicalize_op1_combined
  simp_alive_peephole
  sorry
def test_sdiv_canonicalize_nonsw_combined := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_nonsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_sdiv_canonicalize_nonsw   : test_sdiv_canonicalize_nonsw_before  ⊑  test_sdiv_canonicalize_nonsw_combined := by
  unfold test_sdiv_canonicalize_nonsw_before test_sdiv_canonicalize_nonsw_combined
  simp_alive_peephole
  sorry
def test_sdiv_canonicalize_vec_combined := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sdiv %arg0, %arg1  : vector<2xi32>
    %3 = llvm.sub %1, %2 overflow<nsw>  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_test_sdiv_canonicalize_vec   : test_sdiv_canonicalize_vec_before  ⊑  test_sdiv_canonicalize_vec_combined := by
  unfold test_sdiv_canonicalize_vec_before test_sdiv_canonicalize_vec_combined
  simp_alive_peephole
  sorry
def test_sdiv_canonicalize_multiple_uses_combined := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_multiple_uses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    %3 = llvm.sdiv %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sdiv_canonicalize_multiple_uses   : test_sdiv_canonicalize_multiple_uses_before  ⊑  test_sdiv_canonicalize_multiple_uses_combined := by
  unfold test_sdiv_canonicalize_multiple_uses_before test_sdiv_canonicalize_multiple_uses_combined
  simp_alive_peephole
  sorry
def test_sdiv_canonicalize_constexpr_combined := [llvmfunc|
  llvm.func @test_sdiv_canonicalize_constexpr(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.addressof @X : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.sub %3, %2  : i64
    %5 = llvm.sdiv %arg0, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_sdiv_canonicalize_constexpr   : test_sdiv_canonicalize_constexpr_before  ⊑  test_sdiv_canonicalize_constexpr_combined := by
  unfold test_sdiv_canonicalize_constexpr_before test_sdiv_canonicalize_constexpr_combined
  simp_alive_peephole
  sorry
def sdiv_abs_nsw_combined := [llvmfunc|
  llvm.func @sdiv_abs_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_sdiv_abs_nsw   : sdiv_abs_nsw_before  ⊑  sdiv_abs_nsw_combined := by
  unfold sdiv_abs_nsw_before sdiv_abs_nsw_combined
  simp_alive_peephole
  sorry
def sdiv_abs_nsw_vec_combined := [llvmfunc|
  llvm.func @sdiv_abs_nsw_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<4xi32>
    %3 = llvm.select %2, %1, %0 : vector<4xi1>, vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_sdiv_abs_nsw_vec   : sdiv_abs_nsw_vec_before  ⊑  sdiv_abs_nsw_vec_combined := by
  unfold sdiv_abs_nsw_vec_before sdiv_abs_nsw_vec_combined
  simp_alive_peephole
  sorry
def sdiv_abs_combined := [llvmfunc|
  llvm.func @sdiv_abs(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_sdiv_abs   : sdiv_abs_before  ⊑  sdiv_abs_combined := by
  unfold sdiv_abs_before sdiv_abs_combined
  simp_alive_peephole
  sorry
    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sdiv_abs   : sdiv_abs_before  ⊑  sdiv_abs_combined := by
  unfold sdiv_abs_before sdiv_abs_combined
  simp_alive_peephole
  sorry
def sdiv_abs_extra_use_combined := [llvmfunc|
  llvm.func @sdiv_abs_extra_use(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_sdiv_abs_extra_use   : sdiv_abs_extra_use_before  ⊑  sdiv_abs_extra_use_combined := by
  unfold sdiv_abs_extra_use_before sdiv_abs_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sdiv_abs_extra_use   : sdiv_abs_extra_use_before  ⊑  sdiv_abs_extra_use_combined := by
  unfold sdiv_abs_extra_use_before sdiv_abs_extra_use_combined
  simp_alive_peephole
  sorry
