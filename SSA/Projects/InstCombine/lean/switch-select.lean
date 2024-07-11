import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  switch-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_ult_rhsc_before := [llvmfunc|
  llvm.func @test_ult_rhsc(%arg0: i8) {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.switch %5 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }]

def test_eq_lhsc_before := [llvmfunc|
  llvm.func @test_eq_lhsc(%arg0: i8) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg0 : i1, i8
    llvm.switch %3 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }]

def test_ult_rhsc_invalid_cond_before := [llvmfunc|
  llvm.func @test_ult_rhsc_invalid_cond(%arg0: i8, %arg1: i8) {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.icmp "ult" %arg1, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.switch %5 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3,
      13: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // 2 preds: ^bb0, ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }]

def test_ult_rhsc_fail_before := [llvmfunc|
  llvm.func @test_ult_rhsc_fail(%arg0: i8) {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.switch %5 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3,
      13: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // 2 preds: ^bb0, ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }]

def test_ult_rhsc_combined := [llvmfunc|
  llvm.func @test_ult_rhsc(%arg0: i8) {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.switch %5 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }]

theorem inst_combine_test_ult_rhsc   : test_ult_rhsc_before  ⊑  test_ult_rhsc_combined := by
  unfold test_ult_rhsc_before test_ult_rhsc_combined
  simp_alive_peephole
  sorry
def test_eq_lhsc_combined := [llvmfunc|
  llvm.func @test_eq_lhsc(%arg0: i8) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg0 : i1, i8
    llvm.switch %3 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }]

theorem inst_combine_test_eq_lhsc   : test_eq_lhsc_before  ⊑  test_eq_lhsc_combined := by
  unfold test_eq_lhsc_before test_eq_lhsc_combined
  simp_alive_peephole
  sorry
def test_ult_rhsc_invalid_cond_combined := [llvmfunc|
  llvm.func @test_ult_rhsc_invalid_cond(%arg0: i8, %arg1: i8) {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.icmp "ult" %arg1, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.switch %5 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3,
      13: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // 2 preds: ^bb0, ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }]

theorem inst_combine_test_ult_rhsc_invalid_cond   : test_ult_rhsc_invalid_cond_before  ⊑  test_ult_rhsc_invalid_cond_combined := by
  unfold test_ult_rhsc_invalid_cond_before test_ult_rhsc_invalid_cond_combined
  simp_alive_peephole
  sorry
def test_ult_rhsc_fail_combined := [llvmfunc|
  llvm.func @test_ult_rhsc_fail(%arg0: i8) {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.switch %5 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3,
      13: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // 2 preds: ^bb0, ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }]

theorem inst_combine_test_ult_rhsc_fail   : test_ult_rhsc_fail_before  ⊑  test_ult_rhsc_fail_combined := by
  unfold test_ult_rhsc_fail_before test_ult_rhsc_fail_combined
  simp_alive_peephole
  sorry
