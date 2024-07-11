import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  simple_phi_condition
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_direct_implication_before := [llvmfunc|
  llvm.func @test_direct_implication(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i1)
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i1
  }]

def test_inverted_implication_before := [llvmfunc|
  llvm.func @test_inverted_implication(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i1)
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i1
  }]

def test_edge_dominance_before := [llvmfunc|
  llvm.func @test_edge_dominance(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb2(%0 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i1)
  ^bb2(%2: i1):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i1
  }]

def test_direct_implication_complex_cfg_before := [llvmfunc|
  llvm.func @test_direct_implication_complex_cfg(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.add %4, %2  : i32
    %6 = llvm.icmp "slt" %5, %arg1 : i32
    llvm.cond_br %6, ^bb2(%5 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%3 : i1)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%0 : i1)
  ^bb5(%7: i1):  // 2 preds: ^bb3, ^bb4
    llvm.return %7 : i1
  }]

def test_inverted_implication_complex_cfg_before := [llvmfunc|
  llvm.func @test_inverted_implication_complex_cfg(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.add %4, %2  : i32
    %6 = llvm.icmp "slt" %5, %arg1 : i32
    llvm.cond_br %6, ^bb2(%5 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%3 : i1)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%0 : i1)
  ^bb5(%7: i1):  // 2 preds: ^bb3, ^bb4
    llvm.return %7 : i1
  }]

def test_multiple_predecessors_before := [llvmfunc|
  llvm.func @test_multiple_predecessors(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%0 : i1)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb5(%0 : i1)
  ^bb5(%2: i1):  // 3 preds: ^bb1, ^bb3, ^bb4
    llvm.return %2 : i1
  }]

def test_multiple_predecessors_wrong_value_before := [llvmfunc|
  llvm.func @test_multiple_predecessors_wrong_value(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%1 : i1)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb5(%0 : i1)
  ^bb5(%2: i1):  // 3 preds: ^bb1, ^bb3, ^bb4
    llvm.return %2 : i1
  }]

def test_multiple_predecessors_no_edge_domination_before := [llvmfunc|
  llvm.func @test_multiple_predecessors_no_edge_domination(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb5(%0 : i1), ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%1 : i1)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb5(%1 : i1)
  ^bb5(%2: i1):  // 3 preds: ^bb1, ^bb3, ^bb4
    llvm.return %2 : i1
  }]

def test_switch_before := [llvmfunc|
  llvm.func @test_switch(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%0 : i8)
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb5(%4: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }]

def test_switch_direct_edge_before := [llvmfunc|
  llvm.func @test_switch_direct_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb4(%0 : i8)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb4(%4: i8):  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return %4 : i8
  }]

def test_switch_duplicate_direct_edge_before := [llvmfunc|
  llvm.func @test_switch_duplicate_direct_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb2 [
      1: ^bb1,
      7: ^bb3(%0 : i8),
      19: ^bb3(%0 : i8)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb3(%3: i8):  // 3 preds: ^bb0, ^bb0, ^bb1
    llvm.return %3 : i8
  }]

def test_switch_subset_before := [llvmfunc|
  llvm.func @test_switch_subset(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.return %0 : i8
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb5(%4: i8):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i8
  }]

def test_switch_wrong_value_before := [llvmfunc|
  llvm.func @test_switch_wrong_value(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%0 : i8)
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb5(%4: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }]

def test_switch_inverted_before := [llvmfunc|
  llvm.func @test_switch_inverted(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%0 : i8)
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb5(%4: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }]

def test_switch_duplicate_edge_before := [llvmfunc|
  llvm.func @test_switch_duplicate_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb2:  // 2 preds: ^bb0, ^bb0
    llvm.br ^bb4(%0 : i8)
  ^bb3:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb4(%3: i8):  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i8
  }]

def test_switch_default_edge_before := [llvmfunc|
  llvm.func @test_switch_default_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(1 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4(%0 : i8) [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%3 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%2 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb4(%4: i8):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }]

def test_switch_default_edge_direct_before := [llvmfunc|
  llvm.func @test_switch_default_edge_direct(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3(%0 : i8) [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3(%0 : i8)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%1 : i8)
  ^bb3(%3: i8):  // 4 preds: ^bb0, ^bb0, ^bb1, ^bb2
    llvm.return %3 : i8
  }]

def test_switch_default_edge_duplicate_before := [llvmfunc|
  llvm.func @test_switch_default_edge_duplicate(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(19 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i8)
  ^bb3:  // 2 preds: ^bb0, ^bb0
    llvm.br ^bb4(%2 : i8)
  ^bb4(%3: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %3 : i8
  }]

def test_direct_implication_combined := [llvmfunc|
  llvm.func @test_direct_implication(%arg0: i1) -> i1 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test_direct_implication   : test_direct_implication_before  ⊑  test_direct_implication_combined := by
  unfold test_direct_implication_before test_direct_implication_combined
  simp_alive_peephole
  sorry
def test_inverted_implication_combined := [llvmfunc|
  llvm.func @test_inverted_implication(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %1 = llvm.xor %arg0, %0  : i1
    llvm.return %1 : i1
  }]

theorem inst_combine_test_inverted_implication   : test_inverted_implication_before  ⊑  test_inverted_implication_combined := by
  unfold test_inverted_implication_before test_inverted_implication_combined
  simp_alive_peephole
  sorry
def test_edge_dominance_combined := [llvmfunc|
  llvm.func @test_edge_dominance(%arg0: i1) -> i1 {
    llvm.cond_br %arg0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test_edge_dominance   : test_edge_dominance_before  ⊑  test_edge_dominance_combined := by
  unfold test_edge_dominance_before test_edge_dominance_combined
  simp_alive_peephole
  sorry
def test_direct_implication_complex_cfg_combined := [llvmfunc|
  llvm.func @test_direct_implication_complex_cfg(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %arg1 : i32
    llvm.cond_br %4, ^bb2(%3 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test_direct_implication_complex_cfg   : test_direct_implication_complex_cfg_before  ⊑  test_direct_implication_complex_cfg_combined := by
  unfold test_direct_implication_complex_cfg_before test_direct_implication_complex_cfg_combined
  simp_alive_peephole
  sorry
def test_inverted_implication_complex_cfg_combined := [llvmfunc|
  llvm.func @test_inverted_implication_complex_cfg(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "slt" %4, %arg1 : i32
    llvm.cond_br %5, ^bb2(%4 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    %6 = llvm.xor %arg0, %2  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_test_inverted_implication_complex_cfg   : test_inverted_implication_complex_cfg_before  ⊑  test_inverted_implication_complex_cfg_combined := by
  unfold test_inverted_implication_complex_cfg_before test_inverted_implication_complex_cfg_combined
  simp_alive_peephole
  sorry
def test_multiple_predecessors_combined := [llvmfunc|
  llvm.func @test_multiple_predecessors(%arg0: i1, %arg1: i1) -> i1 {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5
  ^bb4:  // pred: ^bb2
    llvm.br ^bb5
  ^bb5:  // 3 preds: ^bb1, ^bb3, ^bb4
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test_multiple_predecessors   : test_multiple_predecessors_before  ⊑  test_multiple_predecessors_combined := by
  unfold test_multiple_predecessors_before test_multiple_predecessors_combined
  simp_alive_peephole
  sorry
def test_multiple_predecessors_wrong_value_combined := [llvmfunc|
  llvm.func @test_multiple_predecessors_wrong_value(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%1 : i1)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb5(%0 : i1)
  ^bb5(%2: i1):  // 3 preds: ^bb1, ^bb3, ^bb4
    llvm.return %2 : i1
  }]

theorem inst_combine_test_multiple_predecessors_wrong_value   : test_multiple_predecessors_wrong_value_before  ⊑  test_multiple_predecessors_wrong_value_combined := by
  unfold test_multiple_predecessors_wrong_value_before test_multiple_predecessors_wrong_value_combined
  simp_alive_peephole
  sorry
def test_multiple_predecessors_no_edge_domination_combined := [llvmfunc|
  llvm.func @test_multiple_predecessors_no_edge_domination(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb5(%0 : i1), ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%1 : i1)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb5(%1 : i1)
  ^bb5(%2: i1):  // 3 preds: ^bb1, ^bb3, ^bb4
    llvm.return %2 : i1
  }]

theorem inst_combine_test_multiple_predecessors_no_edge_domination   : test_multiple_predecessors_no_edge_domination_before  ⊑  test_multiple_predecessors_no_edge_domination_combined := by
  unfold test_multiple_predecessors_no_edge_domination_before test_multiple_predecessors_no_edge_domination_combined
  simp_alive_peephole
  sorry
def test_switch_combined := [llvmfunc|
  llvm.func @test_switch(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.return %0 : i8
  ^bb5:  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %arg0 : i8
  }]

theorem inst_combine_test_switch   : test_switch_before  ⊑  test_switch_combined := by
  unfold test_switch_before test_switch_combined
  simp_alive_peephole
  sorry
def test_switch_direct_edge_combined := [llvmfunc|
  llvm.func @test_switch_direct_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4
  ^bb3:  // pred: ^bb0
    llvm.return %0 : i8
  ^bb4:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return %arg0 : i8
  }]

theorem inst_combine_test_switch_direct_edge   : test_switch_direct_edge_before  ⊑  test_switch_direct_edge_combined := by
  unfold test_switch_direct_edge_before test_switch_direct_edge_combined
  simp_alive_peephole
  sorry
def test_switch_duplicate_direct_edge_combined := [llvmfunc|
  llvm.func @test_switch_duplicate_direct_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb2 [
      1: ^bb1,
      7: ^bb3(%0 : i8),
      19: ^bb3(%0 : i8)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb3(%3: i8):  // 3 preds: ^bb0, ^bb0, ^bb1
    llvm.return %3 : i8
  }]

theorem inst_combine_test_switch_duplicate_direct_edge   : test_switch_duplicate_direct_edge_before  ⊑  test_switch_duplicate_direct_edge_combined := by
  unfold test_switch_duplicate_direct_edge_before test_switch_duplicate_direct_edge_combined
  simp_alive_peephole
  sorry
def test_switch_subset_combined := [llvmfunc|
  llvm.func @test_switch_subset(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5
  ^bb3:  // pred: ^bb0
    llvm.return %0 : i8
  ^bb4:  // pred: ^bb0
    llvm.return %1 : i8
  ^bb5:  // 2 preds: ^bb1, ^bb2
    llvm.return %arg0 : i8
  }]

theorem inst_combine_test_switch_subset   : test_switch_subset_before  ⊑  test_switch_subset_combined := by
  unfold test_switch_subset_before test_switch_subset_combined
  simp_alive_peephole
  sorry
def test_switch_wrong_value_combined := [llvmfunc|
  llvm.func @test_switch_wrong_value(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%0 : i8)
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb5(%4: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }]

theorem inst_combine_test_switch_wrong_value   : test_switch_wrong_value_before  ⊑  test_switch_wrong_value_combined := by
  unfold test_switch_wrong_value_before test_switch_wrong_value_combined
  simp_alive_peephole
  sorry
def test_switch_inverted_combined := [llvmfunc|
  llvm.func @test_switch_inverted(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.return %1 : i8
  ^bb5:  // 3 preds: ^bb1, ^bb2, ^bb3
    %2 = llvm.xor %arg0, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_test_switch_inverted   : test_switch_inverted_before  ⊑  test_switch_inverted_combined := by
  unfold test_switch_inverted_before test_switch_inverted_combined
  simp_alive_peephole
  sorry
def test_switch_duplicate_edge_combined := [llvmfunc|
  llvm.func @test_switch_duplicate_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb2:  // 2 preds: ^bb0, ^bb0
    llvm.br ^bb4(%0 : i8)
  ^bb3:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb4(%3: i8):  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i8
  }]

theorem inst_combine_test_switch_duplicate_edge   : test_switch_duplicate_edge_before  ⊑  test_switch_duplicate_edge_combined := by
  unfold test_switch_duplicate_edge_before test_switch_duplicate_edge_combined
  simp_alive_peephole
  sorry
def test_switch_default_edge_combined := [llvmfunc|
  llvm.func @test_switch_default_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(1 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4(%0 : i8) [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%3 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%2 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb4(%4: i8):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }]

theorem inst_combine_test_switch_default_edge   : test_switch_default_edge_before  ⊑  test_switch_default_edge_combined := by
  unfold test_switch_default_edge_before test_switch_default_edge_combined
  simp_alive_peephole
  sorry
def test_switch_default_edge_direct_combined := [llvmfunc|
  llvm.func @test_switch_default_edge_direct(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3(%0 : i8) [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3(%0 : i8)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%1 : i8)
  ^bb3(%3: i8):  // 4 preds: ^bb0, ^bb0, ^bb1, ^bb2
    llvm.return %3 : i8
  }]

theorem inst_combine_test_switch_default_edge_direct   : test_switch_default_edge_direct_before  ⊑  test_switch_default_edge_direct_combined := by
  unfold test_switch_default_edge_direct_before test_switch_default_edge_direct_combined
  simp_alive_peephole
  sorry
def test_switch_default_edge_duplicate_combined := [llvmfunc|
  llvm.func @test_switch_default_edge_duplicate(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(19 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i8)
  ^bb3:  // 2 preds: ^bb0, ^bb0
    llvm.br ^bb4(%2 : i8)
  ^bb4(%3: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %3 : i8
  }]

theorem inst_combine_test_switch_default_edge_duplicate   : test_switch_default_edge_duplicate_before  ⊑  test_switch_default_edge_duplicate_combined := by
  unfold test_switch_default_edge_duplicate_before test_switch_default_edge_duplicate_combined
  simp_alive_peephole
  sorry
