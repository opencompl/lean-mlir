import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-xor1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i47, %arg1: i47) -> i47 {
    %0 = llvm.mlir.constant(-70368744177664 : i47) : i47
    %1 = llvm.mlir.constant(70368744177661 : i47) : i47
    %2 = llvm.and %arg0, %0  : i47
    %3 = llvm.and %arg1, %1  : i47
    %4 = llvm.xor %2, %3  : i47
    llvm.return %4 : i47
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i15) -> i15 {
    %0 = llvm.mlir.constant(0 : i15) : i15
    %1 = llvm.xor %arg0, %0  : i15
    llvm.return %1 : i15
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i23) -> i23 {
    %0 = llvm.xor %arg0, %arg0  : i23
    llvm.return %0 : i23
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(-1 : i37) : i37
    %1 = llvm.xor %0, %arg0  : i37
    %2 = llvm.xor %arg0, %1  : i37
    llvm.return %2 : i37
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(23 : i7) : i7
    %1 = llvm.or %arg0, %0  : i7
    %2 = llvm.xor %1, %0  : i7
    llvm.return %2 : i7
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(23 : i7) : i7
    %1 = llvm.xor %arg0, %0  : i7
    %2 = llvm.xor %1, %0  : i7
    llvm.return %2 : i7
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(70368744177663 : i47) : i47
    %1 = llvm.mlir.constant(703687463 : i47) : i47
    %2 = llvm.or %arg0, %0  : i47
    %3 = llvm.xor %2, %1  : i47
    llvm.return %3 : i47
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i47, %arg1: i47) -> i47 {
    %0 = llvm.mlir.constant(-70368744177664 : i47) : i47
    %1 = llvm.mlir.constant(70368744177661 : i47) : i47
    %2 = llvm.and %arg0, %0  : i47
    %3 = llvm.and %arg1, %1  : i47
    %4 = llvm.or %2, %3  : i47
    llvm.return %4 : i47
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i15) -> i15 {
    llvm.return %arg0 : i15
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(0 : i23) : i23
    llvm.return %0 : i23
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i37) -> i37 {
    %0 = llvm.mlir.constant(-1 : i37) : i37
    llvm.return %0 : i37
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i7) -> i7 {
    %0 = llvm.mlir.constant(-24 : i7) : i7
    %1 = llvm.and %arg0, %0  : i7
    llvm.return %1 : i7
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i7) -> i7 {
    llvm.return %arg0 : i7
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(-70368744177664 : i47) : i47
    %1 = llvm.mlir.constant(70368040490200 : i47) : i47
    %2 = llvm.and %arg0, %0  : i47
    %3 = llvm.or %2, %1  : i47
    llvm.return %3 : i47
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
