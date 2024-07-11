import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  infinite-loop-postdom
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i24, %arg1: i24) {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %0 = llvm.icmp "uge" %arg0, %arg1 : i24
    llvm.cond_br %0, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %1 = llvm.add %arg0, %arg1  : i24
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb1
  }]

def "test1-canonicalized"_before := [llvmfunc|
  llvm.func @"test1-canonicalized"(%arg0: i24, %arg1: i24) {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %0 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %1 = llvm.add %arg0, %arg1  : i24
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i24, %arg1: i24) {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %0 = llvm.icmp "uge" %arg0, %arg1 : i24
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb3
    llvm.br ^bb1
  ^bb3:  // pred: ^bb1
    %1 = llvm.add %arg0, %arg1  : i24
    llvm.br ^bb2
  }]

def "test2-canonicalized"_before := [llvmfunc|
  llvm.func @"test2-canonicalized"(%arg0: i24, %arg1: i24) {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %0 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.cond_br %0, ^bb2, ^bb3
  ^bb2:  // 2 preds: ^bb1, ^bb3
    llvm.br ^bb1
  ^bb3:  // pred: ^bb1
    %1 = llvm.add %arg0, %arg1  : i24
    llvm.br ^bb2
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i24, %arg1: i24, %arg2: i32) {
    llvm.switch %arg2 : i32, ^bb8 [
      1: ^bb1,
      2: ^bb5,
      3: ^bb6
    ]
  ^bb1:  // pred: ^bb0
    %0 = llvm.icmp "uge" %arg0, %arg1 : i24
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb4
    llvm.cond_br %0, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %1 = llvm.add %arg0, %arg1  : i24
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    llvm.br ^bb2
  ^bb5:  // pred: ^bb0
    %2 = llvm.icmp "uge" %arg0, %arg1 : i24
    llvm.cond_br %2, ^bb6, ^bb7
  ^bb6:  // 3 preds: ^bb0, ^bb5, ^bb7
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    llvm.br ^bb6
  ^bb8:  // pred: ^bb0
    llvm.return
  }]

def "test3-canonicalized"_before := [llvmfunc|
  llvm.func @"test3-canonicalized"(%arg0: i24, %arg1: i24, %arg2: i32) {
    llvm.switch %arg2 : i32, ^bb8 [
      1: ^bb1,
      2: ^bb5,
      3: ^bb6
    ]
  ^bb1:  // pred: ^bb0
    %0 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb4
    llvm.cond_br %0, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    %1 = llvm.add %arg0, %arg1  : i24
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    llvm.br ^bb2
  ^bb5:  // pred: ^bb0
    %2 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.cond_br %2, ^bb7, ^bb6
  ^bb6:  // 3 preds: ^bb0, ^bb5, ^bb7
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    llvm.br ^bb6
  ^bb8:  // pred: ^bb0
    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i24, %arg1: i24) {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %0 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def "test1-canonicalized"_combined := [llvmfunc|
  llvm.func @"test1-canonicalized"(%arg0: i24, %arg1: i24) {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %0 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.cond_br %0, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb1
  }]

theorem inst_combine_"test1-canonicalized"   : "test1-canonicalized"_before  ⊑  "test1-canonicalized"_combined := by
  unfold "test1-canonicalized"_before "test1-canonicalized"_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i24, %arg1: i24) {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %0 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.cond_br %0, ^bb2, ^bb3
  ^bb2:  // 2 preds: ^bb1, ^bb3
    llvm.br ^bb1
  ^bb3:  // pred: ^bb1
    llvm.br ^bb2
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def "test2-canonicalized"_combined := [llvmfunc|
  llvm.func @"test2-canonicalized"(%arg0: i24, %arg1: i24) {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    %0 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.cond_br %0, ^bb2, ^bb3
  ^bb2:  // 2 preds: ^bb1, ^bb3
    llvm.br ^bb1
  ^bb3:  // pred: ^bb1
    llvm.br ^bb2
  }]

theorem inst_combine_"test2-canonicalized"   : "test2-canonicalized"_before  ⊑  "test2-canonicalized"_combined := by
  unfold "test2-canonicalized"_before "test2-canonicalized"_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i24, %arg1: i24, %arg2: i32) {
    llvm.switch %arg2 : i32, ^bb8 [
      1: ^bb1,
      2: ^bb5,
      3: ^bb6
    ]
  ^bb1:  // pred: ^bb0
    %0 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb4
    llvm.cond_br %0, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    llvm.br ^bb2
  ^bb5:  // pred: ^bb0
    %1 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.cond_br %1, ^bb7, ^bb6
  ^bb6:  // 3 preds: ^bb0, ^bb5, ^bb7
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    llvm.br ^bb6
  ^bb8:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def "test3-canonicalized"_combined := [llvmfunc|
  llvm.func @"test3-canonicalized"(%arg0: i24, %arg1: i24, %arg2: i32) {
    llvm.switch %arg2 : i32, ^bb8 [
      1: ^bb1,
      2: ^bb5,
      3: ^bb6
    ]
  ^bb1:  // pred: ^bb0
    %0 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb1, ^bb4
    llvm.cond_br %0, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb2, ^bb3
    llvm.br ^bb2
  ^bb5:  // pred: ^bb0
    %1 = llvm.icmp "ult" %arg0, %arg1 : i24
    llvm.cond_br %1, ^bb7, ^bb6
  ^bb6:  // 3 preds: ^bb0, ^bb5, ^bb7
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    llvm.br ^bb6
  ^bb8:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_"test3-canonicalized"   : "test3-canonicalized"_before  ⊑  "test3-canonicalized"_combined := by
  unfold "test3-canonicalized"_before "test3-canonicalized"_combined
  simp_alive_peephole
  sorry
