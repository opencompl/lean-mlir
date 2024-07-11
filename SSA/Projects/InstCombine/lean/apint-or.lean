import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(-1 : i23) : i23
    %1 = llvm.xor %0, %arg0  : i23
    %2 = llvm.or %arg0, %1  : i23
    llvm.return %2 : i23
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i39, %arg1: i39) -> i39 {
    %0 = llvm.mlir.constant(274877906943 : i39) : i39
    %1 = llvm.mlir.constant(-1 : i39) : i39
    %2 = llvm.mlir.constant(-274877906944 : i39) : i39
    %3 = llvm.xor %0, %1  : i39
    %4 = llvm.and %arg1, %2  : i39
    %5 = llvm.add %arg0, %4  : i39
    %6 = llvm.and %5, %3  : i39
    %7 = llvm.and %arg0, %0  : i39
    %8 = llvm.or %6, %7  : i39
    llvm.return %8 : i39
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i1023) -> i1023 {
    %0 = llvm.mlir.constant(-1 : i1023) : i1023
    %1 = llvm.xor %0, %arg0  : i1023
    %2 = llvm.or %arg0, %1  : i1023
    llvm.return %2 : i1023
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i399, %arg1: i399) -> i399 {
    %0 = llvm.mlir.constant(274877906943 : i399) : i399
    %1 = llvm.mlir.constant(-1 : i399) : i399
    %2 = llvm.mlir.constant(18446742974197923840 : i399) : i399
    %3 = llvm.xor %0, %1  : i399
    %4 = llvm.and %arg1, %2  : i399
    %5 = llvm.add %arg0, %4  : i399
    %6 = llvm.and %5, %3  : i399
    %7 = llvm.and %arg0, %0  : i399
    %8 = llvm.or %6, %7  : i399
    llvm.return %8 : i399
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i23) -> i23 {
    %0 = llvm.mlir.constant(-1 : i23) : i23
    llvm.return %0 : i23
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i39, %arg1: i39) -> i39 {
    %0 = llvm.mlir.constant(-274877906944 : i39) : i39
    %1 = llvm.and %arg1, %0  : i39
    %2 = llvm.add %1, %arg0  : i39
    llvm.return %2 : i39
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i1023) -> i1023 {
    %0 = llvm.mlir.constant(-1 : i1023) : i1023
    llvm.return %0 : i1023
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i399, %arg1: i399) -> i399 {
    %0 = llvm.mlir.constant(18446742974197923840 : i399) : i399
    %1 = llvm.and %arg1, %0  : i399
    %2 = llvm.add %1, %arg0  : i399
    llvm.return %2 : i399
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
