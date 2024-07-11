import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-and-xor-merge
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i57, %arg1: i57, %arg2: i57) -> i57 {
    %0 = llvm.and %arg2, %arg0  : i57
    %1 = llvm.and %arg2, %arg1  : i57
    %2 = llvm.xor %0, %1  : i57
    llvm.return %2 : i57
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i23, %arg1: i23, %arg2: i23) -> i23 {
    %0 = llvm.and %arg1, %arg0  : i23
    %1 = llvm.or %arg1, %arg0  : i23
    %2 = llvm.xor %0, %1  : i23
    llvm.return %2 : i23
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i57, %arg1: i57, %arg2: i57) -> i57 {
    %0 = llvm.xor %arg0, %arg1  : i57
    %1 = llvm.and %0, %arg2  : i57
    llvm.return %1 : i57
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i23, %arg1: i23, %arg2: i23) -> i23 {
    %0 = llvm.xor %arg1, %arg0  : i23
    llvm.return %0 : i23
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
