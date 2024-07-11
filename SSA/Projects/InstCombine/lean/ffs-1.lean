import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ffs-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @ffs(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @ffsl(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @ffs(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify5_before := [llvmfunc|
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant(2048 : i32) : i32
    %1 = llvm.call @ffs(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify6_before := [llvmfunc|
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.call @ffs(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify7_before := [llvmfunc|
  llvm.func @test_simplify7() -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.call @ffsl(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

def test_simplify8_before := [llvmfunc|
  llvm.func @test_simplify8() -> i32 {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

def test_simplify9_before := [llvmfunc|
  llvm.func @test_simplify9() -> i32 {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

def test_simplify10_before := [llvmfunc|
  llvm.func @test_simplify10() -> i32 {
    %0 = llvm.mlir.constant(17179869184 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

def test_simplify11_before := [llvmfunc|
  llvm.func @test_simplify11() -> i32 {
    %0 = llvm.mlir.constant(281474976710656 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

def test_simplify12_before := [llvmfunc|
  llvm.func @test_simplify12() -> i32 {
    %0 = llvm.mlir.constant(1152921504606846976 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

def test_simplify13_before := [llvmfunc|
  llvm.func @test_simplify13(%arg0: i32) -> i32 {
    %0 = llvm.call @ffs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def test_simplify14_before := [llvmfunc|
  llvm.func @test_simplify14(%arg0: i32) -> i32 {
    %0 = llvm.call @ffsl(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def test_simplify15_before := [llvmfunc|
  llvm.func @test_simplify15(%arg0: i64) -> i32 {
    %0 = llvm.call @ffsll(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @ffsl(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_simplify5_combined := [llvmfunc|
  llvm.func @test_simplify5() -> i32 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify5   : test_simplify5_before  ⊑  test_simplify5_combined := by
  unfold test_simplify5_before test_simplify5_combined
  simp_alive_peephole
  sorry
def test_simplify6_combined := [llvmfunc|
  llvm.func @test_simplify6() -> i32 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
def test_simplify7_combined := [llvmfunc|
  llvm.func @test_simplify7() -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.call @ffsl(%0) : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify7   : test_simplify7_before  ⊑  test_simplify7_combined := by
  unfold test_simplify7_before test_simplify7_combined
  simp_alive_peephole
  sorry
def test_simplify8_combined := [llvmfunc|
  llvm.func @test_simplify8() -> i32 {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify8   : test_simplify8_before  ⊑  test_simplify8_combined := by
  unfold test_simplify8_before test_simplify8_combined
  simp_alive_peephole
  sorry
def test_simplify9_combined := [llvmfunc|
  llvm.func @test_simplify9() -> i32 {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify9   : test_simplify9_before  ⊑  test_simplify9_combined := by
  unfold test_simplify9_before test_simplify9_combined
  simp_alive_peephole
  sorry
def test_simplify10_combined := [llvmfunc|
  llvm.func @test_simplify10() -> i32 {
    %0 = llvm.mlir.constant(17179869184 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify10   : test_simplify10_before  ⊑  test_simplify10_combined := by
  unfold test_simplify10_before test_simplify10_combined
  simp_alive_peephole
  sorry
def test_simplify11_combined := [llvmfunc|
  llvm.func @test_simplify11() -> i32 {
    %0 = llvm.mlir.constant(281474976710656 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify11   : test_simplify11_before  ⊑  test_simplify11_combined := by
  unfold test_simplify11_before test_simplify11_combined
  simp_alive_peephole
  sorry
def test_simplify12_combined := [llvmfunc|
  llvm.func @test_simplify12() -> i32 {
    %0 = llvm.mlir.constant(1152921504606846976 : i64) : i64
    %1 = llvm.call @ffsll(%0) : (i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_simplify12   : test_simplify12_before  ⊑  test_simplify12_combined := by
  unfold test_simplify12_before test_simplify12_combined
  simp_alive_peephole
  sorry
def test_simplify13_combined := [llvmfunc|
  llvm.func @test_simplify13(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32
    %3 = llvm.add %2, %0 overflow<nsw, nuw>  : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_simplify13   : test_simplify13_before  ⊑  test_simplify13_combined := by
  unfold test_simplify13_before test_simplify13_combined
  simp_alive_peephole
  sorry
def test_simplify14_combined := [llvmfunc|
  llvm.func @test_simplify14(%arg0: i32) -> i32 {
    %0 = llvm.call @ffsl(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify14   : test_simplify14_before  ⊑  test_simplify14_combined := by
  unfold test_simplify14_before test_simplify14_combined
  simp_alive_peephole
  sorry
def test_simplify15_combined := [llvmfunc|
  llvm.func @test_simplify15(%arg0: i64) -> i32 {
    %0 = llvm.call @ffsll(%arg0) : (i64) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_simplify15   : test_simplify15_before  ⊑  test_simplify15_combined := by
  unfold test_simplify15_before test_simplify15_combined
  simp_alive_peephole
  sorry
