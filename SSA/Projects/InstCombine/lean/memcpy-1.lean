import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcpy-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr attributes {passthrough = ["strictfp"]} {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.call @get_dest() : () -> !llvm.ptr
    %1 = llvm.call @memcpy(%0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test_no_incompatible_attr_before := [llvmfunc|
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    "llvm.intr.memcpy"(%arg0, %arg1, %arg2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr attributes {passthrough = ["strictfp"]} {
    "llvm.intr.memcpy"(%arg0, %arg1, %arg2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.call @get_dest() : () -> !llvm.ptr
    "llvm.intr.memcpy"(%0, %arg0, %arg1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_no_incompatible_attr_combined := [llvmfunc|
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    "llvm.intr.memcpy"(%arg0, %arg1, %arg2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_test_no_incompatible_attr   : test_no_incompatible_attr_before  ⊑  test_no_incompatible_attr_combined := by
  unfold test_no_incompatible_attr_before test_no_incompatible_attr_combined
  simp_alive_peephole
  sorry
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test_no_incompatible_attr   : test_no_incompatible_attr_before  ⊑  test_no_incompatible_attr_combined := by
  unfold test_no_incompatible_attr_before test_no_incompatible_attr_combined
  simp_alive_peephole
  sorry
def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
