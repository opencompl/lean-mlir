import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  range-check
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_and1_before := [llvmfunc|
  llvm.func @test_and1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sge" %arg0, %1 : i32
    %4 = llvm.icmp "slt" %arg0, %2 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def test_and1_logical_before := [llvmfunc|
  llvm.func @test_and1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.icmp "slt" %arg0, %3 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def test_and2_before := [llvmfunc|
  llvm.func @test_and2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.icmp "sle" %arg0, %2 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def test_and2_logical_before := [llvmfunc|
  llvm.func @test_and2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.icmp "sle" %arg0, %3 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def test_and3_before := [llvmfunc|
  llvm.func @test_and3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sgt" %2, %arg0 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def test_and3_logical_before := [llvmfunc|
  llvm.func @test_and3_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sgt" %3, %arg0 : i32
    %5 = llvm.icmp "sge" %arg0, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def test_and4_before := [llvmfunc|
  llvm.func @test_and4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sge" %2, %arg0 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def test_and4_logical_before := [llvmfunc|
  llvm.func @test_and4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sge" %3, %arg0 : i32
    %5 = llvm.icmp "sge" %arg0, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def test_or1_before := [llvmfunc|
  llvm.func @test_or1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.icmp "sge" %arg0, %2 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def test_or1_logical_before := [llvmfunc|
  llvm.func @test_or1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.icmp "sge" %arg0, %3 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def test_or2_before := [llvmfunc|
  llvm.func @test_or2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sle" %arg0, %1 : i32
    %4 = llvm.icmp "sgt" %arg0, %2 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def test_or2_logical_before := [llvmfunc|
  llvm.func @test_or2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sle" %arg0, %1 : i32
    %5 = llvm.icmp "sgt" %arg0, %3 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def test_or3_before := [llvmfunc|
  llvm.func @test_or3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sle" %2, %arg0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def test_or3_logical_before := [llvmfunc|
  llvm.func @test_or3_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sle" %3, %arg0 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def test_or4_before := [llvmfunc|
  llvm.func @test_or4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "slt" %2, %arg0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def test_or4_logical_before := [llvmfunc|
  llvm.func @test_or4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %3, %arg0 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def negative1_before := [llvmfunc|
  llvm.func @negative1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def negative1_logical_before := [llvmfunc|
  llvm.func @negative1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %3 : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def negative2_before := [llvmfunc|
  llvm.func @negative2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def negative2_logical_before := [llvmfunc|
  llvm.func @negative2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def negative3_before := [llvmfunc|
  llvm.func @negative3(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg2, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.icmp "sge" %arg1, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def negative3_logical_before := [llvmfunc|
  llvm.func @negative3_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg2, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %3 : i32
    %5 = llvm.icmp "sge" %arg1, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def negative4_before := [llvmfunc|
  llvm.func @negative4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "ne" %arg0, %2 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def negative4_logical_before := [llvmfunc|
  llvm.func @negative4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "ne" %arg0, %3 : i32
    %5 = llvm.icmp "sge" %arg0, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def negative5_before := [llvmfunc|
  llvm.func @negative5(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def negative5_logical_before := [llvmfunc|
  llvm.func @negative5_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %3 : i32
    %5 = llvm.icmp "sge" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def test_and1_combined := [llvmfunc|
  llvm.func @test_and1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_and1   : test_and1_before  ⊑  test_and1_combined := by
  unfold test_and1_before test_and1_combined
  simp_alive_peephole
  sorry
def test_and1_logical_combined := [llvmfunc|
  llvm.func @test_and1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.icmp "sgt" %3, %arg0 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_test_and1_logical   : test_and1_logical_before  ⊑  test_and1_logical_combined := by
  unfold test_and1_logical_before test_and1_logical_combined
  simp_alive_peephole
  sorry
def test_and2_combined := [llvmfunc|
  llvm.func @test_and2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "uge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_and2   : test_and2_before  ⊑  test_and2_combined := by
  unfold test_and2_before test_and2_combined
  simp_alive_peephole
  sorry
def test_and2_logical_combined := [llvmfunc|
  llvm.func @test_and2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.icmp "sge" %3, %arg0 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_test_and2_logical   : test_and2_logical_before  ⊑  test_and2_logical_combined := by
  unfold test_and2_logical_before test_and2_logical_combined
  simp_alive_peephole
  sorry
def test_and3_combined := [llvmfunc|
  llvm.func @test_and3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_and3   : test_and3_before  ⊑  test_and3_combined := by
  unfold test_and3_before test_and3_combined
  simp_alive_peephole
  sorry
def test_and3_logical_combined := [llvmfunc|
  llvm.func @test_and3_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_and3_logical   : test_and3_logical_before  ⊑  test_and3_logical_combined := by
  unfold test_and3_logical_before test_and3_logical_combined
  simp_alive_peephole
  sorry
def test_and4_combined := [llvmfunc|
  llvm.func @test_and4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "uge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_and4   : test_and4_before  ⊑  test_and4_combined := by
  unfold test_and4_before test_and4_combined
  simp_alive_peephole
  sorry
def test_and4_logical_combined := [llvmfunc|
  llvm.func @test_and4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "uge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_and4_logical   : test_and4_logical_before  ⊑  test_and4_logical_combined := by
  unfold test_and4_logical_before test_and4_logical_combined
  simp_alive_peephole
  sorry
def test_or1_combined := [llvmfunc|
  llvm.func @test_or1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "ule" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_or1   : test_or1_before  ⊑  test_or1_combined := by
  unfold test_or1_before test_or1_combined
  simp_alive_peephole
  sorry
def test_or1_logical_combined := [llvmfunc|
  llvm.func @test_or1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.icmp "sle" %3, %arg0 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_test_or1_logical   : test_or1_logical_before  ⊑  test_or1_logical_combined := by
  unfold test_or1_logical_before test_or1_logical_combined
  simp_alive_peephole
  sorry
def test_or2_combined := [llvmfunc|
  llvm.func @test_or2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_or2   : test_or2_before  ⊑  test_or2_combined := by
  unfold test_or2_before test_or2_combined
  simp_alive_peephole
  sorry
def test_or2_logical_combined := [llvmfunc|
  llvm.func @test_or2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.icmp "slt" %3, %arg0 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_test_or2_logical   : test_or2_logical_before  ⊑  test_or2_logical_combined := by
  unfold test_or2_logical_before test_or2_logical_combined
  simp_alive_peephole
  sorry
def test_or3_combined := [llvmfunc|
  llvm.func @test_or3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "ule" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_or3   : test_or3_before  ⊑  test_or3_combined := by
  unfold test_or3_before test_or3_combined
  simp_alive_peephole
  sorry
def test_or3_logical_combined := [llvmfunc|
  llvm.func @test_or3_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "ule" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_or3_logical   : test_or3_logical_before  ⊑  test_or3_logical_combined := by
  unfold test_or3_logical_before test_or3_logical_combined
  simp_alive_peephole
  sorry
def test_or4_combined := [llvmfunc|
  llvm.func @test_or4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_or4   : test_or4_before  ⊑  test_or4_combined := by
  unfold test_or4_before test_or4_combined
  simp_alive_peephole
  sorry
def test_or4_logical_combined := [llvmfunc|
  llvm.func @test_or4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_or4_logical   : test_or4_logical_before  ⊑  test_or4_logical_combined := by
  unfold test_or4_logical_before test_or4_logical_combined
  simp_alive_peephole
  sorry
def negative1_combined := [llvmfunc|
  llvm.func @negative1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sgt" %2, %arg0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_negative1   : negative1_before  ⊑  negative1_combined := by
  unfold negative1_before negative1_combined
  simp_alive_peephole
  sorry
def negative1_logical_combined := [llvmfunc|
  llvm.func @negative1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sgt" %2, %arg0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_negative1_logical   : negative1_logical_before  ⊑  negative1_logical_combined := by
  unfold negative1_logical_before negative1_logical_combined
  simp_alive_peephole
  sorry
def negative2_combined := [llvmfunc|
  llvm.func @negative2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_negative2   : negative2_before  ⊑  negative2_combined := by
  unfold negative2_before negative2_combined
  simp_alive_peephole
  sorry
def negative2_logical_combined := [llvmfunc|
  llvm.func @negative2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_negative2_logical   : negative2_logical_before  ⊑  negative2_logical_combined := by
  unfold negative2_logical_before negative2_logical_combined
  simp_alive_peephole
  sorry
def negative3_combined := [llvmfunc|
  llvm.func @negative3(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg2, %0  : i32
    %3 = llvm.icmp "sgt" %2, %arg0 : i32
    %4 = llvm.icmp "sgt" %arg1, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_negative3   : negative3_before  ⊑  negative3_combined := by
  unfold negative3_before negative3_combined
  simp_alive_peephole
  sorry
def negative3_logical_combined := [llvmfunc|
  llvm.func @negative3_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg2, %0  : i32
    %4 = llvm.icmp "sgt" %3, %arg0 : i32
    %5 = llvm.icmp "sgt" %arg1, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_negative3_logical   : negative3_logical_before  ⊑  negative3_logical_combined := by
  unfold negative3_logical_before negative3_logical_combined
  simp_alive_peephole
  sorry
def negative4_combined := [llvmfunc|
  llvm.func @negative4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_negative4   : negative4_before  ⊑  negative4_combined := by
  unfold negative4_before negative4_combined
  simp_alive_peephole
  sorry
def negative4_logical_combined := [llvmfunc|
  llvm.func @negative4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_negative4_logical   : negative4_logical_before  ⊑  negative4_logical_combined := by
  unfold negative4_logical_before negative4_logical_combined
  simp_alive_peephole
  sorry
def negative5_combined := [llvmfunc|
  llvm.func @negative5(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sgt" %2, %arg0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_negative5   : negative5_before  ⊑  negative5_combined := by
  unfold negative5_before negative5_combined
  simp_alive_peephole
  sorry
def negative5_logical_combined := [llvmfunc|
  llvm.func @negative5_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sgt" %2, %arg0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_negative5_logical   : negative5_logical_before  ⊑  negative5_logical_combined := by
  unfold negative5_logical_before negative5_logical_combined
  simp_alive_peephole
  sorry
