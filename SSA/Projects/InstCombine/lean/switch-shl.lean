import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  switch-shl
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_switch_with_shl_mask_before := [llvmfunc|
  llvm.func @test_switch_with_shl_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0  : i32
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

def test_switch_with_shl_nuw_multiuse_before := [llvmfunc|
  llvm.func @test_switch_with_shl_nuw_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

def test_switch_with_shl_nsw_multiuse_before := [llvmfunc|
  llvm.func @test_switch_with_shl_nsw_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

def test_switch_with_shl_mask_multiuse_before := [llvmfunc|
  llvm.func @test_switch_with_shl_mask_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

def test_switch_with_shl_mask_unknown_shamt_before := [llvmfunc|
  llvm.func @test_switch_with_shl_mask_unknown_shamt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.shl %arg0, %arg1  : i32
    llvm.switch %2 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

def test_switch_with_shl_mask_poison_before := [llvmfunc|
  llvm.func @test_switch_with_shl_mask_poison(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0  : i32
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

def test_switch_with_shl_mask_combined := [llvmfunc|
  llvm.func @test_switch_with_shl_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.trunc %arg0 : i32 to i8
    llvm.switch %2 : i8, ^bb2 [
      0: ^bb1,
      1: ^bb1,
      128: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test_switch_with_shl_mask   : test_switch_with_shl_mask_before  ⊑  test_switch_with_shl_mask_combined := by
  unfold test_switch_with_shl_mask_before test_switch_with_shl_mask_combined
  simp_alive_peephole
  sorry
def test_switch_with_shl_nuw_multiuse_combined := [llvmfunc|
  llvm.func @test_switch_with_shl_nuw_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.switch %arg0 : i32, ^bb2 [
      0: ^bb1,
      1: ^bb1,
      128: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

theorem inst_combine_test_switch_with_shl_nuw_multiuse   : test_switch_with_shl_nuw_multiuse_before  ⊑  test_switch_with_shl_nuw_multiuse_combined := by
  unfold test_switch_with_shl_nuw_multiuse_before test_switch_with_shl_nuw_multiuse_combined
  simp_alive_peephole
  sorry
def test_switch_with_shl_nsw_multiuse_combined := [llvmfunc|
  llvm.func @test_switch_with_shl_nsw_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.switch %arg0 : i32, ^bb2 [
      0: ^bb1,
      1: ^bb1,
      4294967168: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

theorem inst_combine_test_switch_with_shl_nsw_multiuse   : test_switch_with_shl_nsw_multiuse_before  ⊑  test_switch_with_shl_nsw_multiuse_combined := by
  unfold test_switch_with_shl_nsw_multiuse_before test_switch_with_shl_nsw_multiuse_combined
  simp_alive_peephole
  sorry
def test_switch_with_shl_mask_multiuse_combined := [llvmfunc|
  llvm.func @test_switch_with_shl_mask_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

theorem inst_combine_test_switch_with_shl_mask_multiuse   : test_switch_with_shl_mask_multiuse_before  ⊑  test_switch_with_shl_mask_multiuse_combined := by
  unfold test_switch_with_shl_mask_multiuse_before test_switch_with_shl_mask_multiuse_combined
  simp_alive_peephole
  sorry
def test_switch_with_shl_mask_unknown_shamt_combined := [llvmfunc|
  llvm.func @test_switch_with_shl_mask_unknown_shamt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.shl %arg0, %arg1  : i32
    llvm.switch %2 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test_switch_with_shl_mask_unknown_shamt   : test_switch_with_shl_mask_unknown_shamt_before  ⊑  test_switch_with_shl_mask_unknown_shamt_combined := by
  unfold test_switch_with_shl_mask_unknown_shamt_before test_switch_with_shl_mask_unknown_shamt_combined
  simp_alive_peephole
  sorry
def test_switch_with_shl_mask_poison_combined := [llvmfunc|
  llvm.func @test_switch_with_shl_mask_poison(%arg0: i32) -> i1 {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    llvm.switch %0 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }]

theorem inst_combine_test_switch_with_shl_mask_poison   : test_switch_with_shl_mask_poison_before  ⊑  test_switch_with_shl_mask_poison_combined := by
  unfold test_switch_with_shl_mask_poison_before test_switch_with_shl_mask_poison_combined
  simp_alive_peephole
  sorry
