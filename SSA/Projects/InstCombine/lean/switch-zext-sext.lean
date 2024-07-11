import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  switch-zext-sext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_switch_with_zext_before := [llvmfunc|
  llvm.func @test_switch_with_zext(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def test_switch_with_sext_before := [llvmfunc|
  llvm.func @test_switch_with_sext(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def test_switch_with_zext_unreachable_case_before := [llvmfunc|
  llvm.func @test_switch_with_zext_unreachable_case(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1,
      65537: ^bb1
    ]
  ^bb1:  // 4 preds: ^bb0, ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def test_switch_with_sext_unreachable_case_before := [llvmfunc|
  llvm.func @test_switch_with_sext_unreachable_case(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1,
      4294901759: ^bb1
    ]
  ^bb1:  // 4 preds: ^bb0, ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def test_switch_with_zext_combined := [llvmfunc|
  llvm.func @test_switch_with_zext(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    llvm.switch %arg0 : i16, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_test_switch_with_zext   : test_switch_with_zext_before  ⊑  test_switch_with_zext_combined := by
  unfold test_switch_with_zext_before test_switch_with_zext_combined
  simp_alive_peephole
  sorry
def test_switch_with_sext_combined := [llvmfunc|
  llvm.func @test_switch_with_sext(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    llvm.switch %arg0 : i16, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_test_switch_with_sext   : test_switch_with_sext_before  ⊑  test_switch_with_sext_combined := by
  unfold test_switch_with_sext_before test_switch_with_sext_combined
  simp_alive_peephole
  sorry
def test_switch_with_zext_unreachable_case_combined := [llvmfunc|
  llvm.func @test_switch_with_zext_unreachable_case(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1,
      65537: ^bb1
    ]
  ^bb1:  // 4 preds: ^bb0, ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_test_switch_with_zext_unreachable_case   : test_switch_with_zext_unreachable_case_before  ⊑  test_switch_with_zext_unreachable_case_combined := by
  unfold test_switch_with_zext_unreachable_case_before test_switch_with_zext_unreachable_case_combined
  simp_alive_peephole
  sorry
def test_switch_with_sext_unreachable_case_combined := [llvmfunc|
  llvm.func @test_switch_with_sext_unreachable_case(%arg0: i16, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.switch %0 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1,
      4294901759: ^bb1
    ]
  ^bb1:  // 4 preds: ^bb0, ^bb0, ^bb0, ^bb0
    llvm.return %arg1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_test_switch_with_sext_unreachable_case   : test_switch_with_sext_unreachable_case_before  ⊑  test_switch_with_sext_unreachable_case_combined := by
  unfold test_switch_with_sext_unreachable_case_before test_switch_with_sext_unreachable_case_combined
  simp_alive_peephole
  sorry
