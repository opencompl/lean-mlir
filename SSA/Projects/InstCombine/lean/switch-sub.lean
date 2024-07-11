import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  switch-sub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_switch_with_neg_before := [llvmfunc|
  llvm.func @test_switch_with_neg(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.sub %0, %arg0  : i32
    llvm.switch %3 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

def test_switch_with_sub_before := [llvmfunc|
  llvm.func @test_switch_with_sub(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(37 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.sub %0, %arg0  : i32
    llvm.switch %3 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

def test_switch_with_sub_nonconst_before := [llvmfunc|
  llvm.func @test_switch_with_sub_nonconst(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg1, %arg0  : i32
    llvm.switch %2 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

def test_switch_with_neg_combined := [llvmfunc|
  llvm.func @test_switch_with_neg(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.switch %arg0 : i32, ^bb2 [
      4294967259: ^bb1,
      4294967258: ^bb1,
      4294967257: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test_switch_with_neg   : test_switch_with_neg_before  ⊑  test_switch_with_neg_combined := by
  unfold test_switch_with_neg_before test_switch_with_neg_combined
  simp_alive_peephole
  sorry
def test_switch_with_sub_combined := [llvmfunc|
  llvm.func @test_switch_with_sub(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.switch %arg0 : i32, ^bb2 [
      0: ^bb1,
      4294967295: ^bb1,
      4294967294: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test_switch_with_sub   : test_switch_with_sub_before  ⊑  test_switch_with_sub_combined := by
  unfold test_switch_with_sub_before test_switch_with_sub_combined
  simp_alive_peephole
  sorry
def test_switch_with_sub_nonconst_combined := [llvmfunc|
  llvm.func @test_switch_with_sub_nonconst(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg1, %arg0  : i32
    llvm.switch %2 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test_switch_with_sub_nonconst   : test_switch_with_sub_nonconst_before  ⊑  test_switch_with_sub_nonconst_combined := by
  unfold test_switch_with_sub_nonconst_before test_switch_with_sub_nonconst_combined
  simp_alive_peephole
  sorry
