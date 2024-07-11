import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  recurrence
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_or_before := [llvmfunc|
  llvm.func @test_or(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%1: i64):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.or %1, %0  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }]

def test_or2_before := [llvmfunc|
  llvm.func @test_or2(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.or %0, %arg1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }]

def test_or3_before := [llvmfunc|
  llvm.func @test_or3(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.or %arg1, %0  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }]

def test_or4_before := [llvmfunc|
  llvm.func @test_or4(%arg0: i64, %arg1: !llvm.ptr) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %2 = llvm.or %0, %1  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }]

def test_and_before := [llvmfunc|
  llvm.func @test_and(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%1: i64):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.and %1, %0  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }]

def test_and2_before := [llvmfunc|
  llvm.func @test_and2(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.and %0, %arg1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }]

def test_and3_before := [llvmfunc|
  llvm.func @test_and3(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.and %arg1, %0  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }]

def test_and4_before := [llvmfunc|
  llvm.func @test_and4(%arg0: i64, %arg1: !llvm.ptr) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %2 = llvm.and %0, %1  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }]

def test_or_combined := [llvmfunc|
  llvm.func @test_or(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.or %arg0, %0  : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_test_or   : test_or_before  ⊑  test_or_combined := by
  unfold test_or_before test_or_combined
  simp_alive_peephole
  sorry
def test_or2_combined := [llvmfunc|
  llvm.func @test_or2(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.or %arg0, %arg1  : i64
    llvm.call @use(%0) : (i64) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_test_or2   : test_or2_before  ⊑  test_or2_combined := by
  unfold test_or2_before test_or2_combined
  simp_alive_peephole
  sorry
def test_or3_combined := [llvmfunc|
  llvm.func @test_or3(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.or %arg0, %arg1  : i64
    llvm.call @use(%0) : (i64) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_test_or3   : test_or3_before  ⊑  test_or3_combined := by
  unfold test_or3_before test_or3_combined
  simp_alive_peephole
  sorry
def test_or4_combined := [llvmfunc|
  llvm.func @test_or4(%arg0: i64, %arg1: !llvm.ptr) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i64]

theorem inst_combine_test_or4   : test_or4_before  ⊑  test_or4_combined := by
  unfold test_or4_before test_or4_combined
  simp_alive_peephole
  sorry
    %2 = llvm.or %0, %1  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }]

theorem inst_combine_test_or4   : test_or4_before  ⊑  test_or4_combined := by
  unfold test_or4_before test_or4_combined
  simp_alive_peephole
  sorry
def test_and_combined := [llvmfunc|
  llvm.func @test_and(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_test_and   : test_and_before  ⊑  test_and_combined := by
  unfold test_and_before test_and_combined
  simp_alive_peephole
  sorry
def test_and2_combined := [llvmfunc|
  llvm.func @test_and2(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.and %arg0, %arg1  : i64
    llvm.call @use(%0) : (i64) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_test_and2   : test_and2_before  ⊑  test_and2_combined := by
  unfold test_and2_before test_and2_combined
  simp_alive_peephole
  sorry
def test_and3_combined := [llvmfunc|
  llvm.func @test_and3(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %0 = llvm.and %arg0, %arg1  : i64
    llvm.call @use(%0) : (i64) -> ()
    llvm.br ^bb1
  }]

theorem inst_combine_test_and3   : test_and3_before  ⊑  test_and3_combined := by
  unfold test_and3_before test_and3_combined
  simp_alive_peephole
  sorry
def test_and4_combined := [llvmfunc|
  llvm.func @test_and4(%arg0: i64, %arg1: !llvm.ptr) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i64]

theorem inst_combine_test_and4   : test_and4_before  ⊑  test_and4_combined := by
  unfold test_and4_before test_and4_combined
  simp_alive_peephole
  sorry
    %2 = llvm.and %0, %1  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }]

theorem inst_combine_test_and4   : test_and4_before  ⊑  test_and4_combined := by
  unfold test_and4_before test_and4_combined
  simp_alive_peephole
  sorry
