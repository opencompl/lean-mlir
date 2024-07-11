import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-shift-simplify
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0_before := [llvmfunc|
  llvm.func @test0(%arg0: i41, %arg1: i41, %arg2: i41) -> i41 {
    %0 = llvm.shl %arg0, %arg2  : i41
    %1 = llvm.shl %arg1, %arg2  : i41
    %2 = llvm.and %0, %1  : i41
    llvm.return %2 : i41
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i57, %arg1: i57, %arg2: i57) -> i57 {
    %0 = llvm.lshr %arg0, %arg2  : i57
    %1 = llvm.lshr %arg1, %arg2  : i57
    %2 = llvm.or %0, %1  : i57
    llvm.return %2 : i57
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i49, %arg1: i49, %arg2: i49) -> i49 {
    %0 = llvm.ashr %arg0, %arg2  : i49
    %1 = llvm.ashr %arg1, %arg2  : i49
    %2 = llvm.xor %0, %1  : i49
    llvm.return %2 : i49
  }]

def test0_combined := [llvmfunc|
  llvm.func @test0(%arg0: i41, %arg1: i41, %arg2: i41) -> i41 {
    %0 = llvm.and %arg0, %arg1  : i41
    %1 = llvm.shl %0, %arg2  : i41
    llvm.return %1 : i41
  }]

theorem inst_combine_test0   : test0_before  ⊑  test0_combined := by
  unfold test0_before test0_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i57, %arg1: i57, %arg2: i57) -> i57 {
    %0 = llvm.or %arg0, %arg1  : i57
    %1 = llvm.lshr %0, %arg2  : i57
    llvm.return %1 : i57
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i49, %arg1: i49, %arg2: i49) -> i49 {
    %0 = llvm.xor %arg0, %arg1  : i49
    %1 = llvm.ashr %0, %arg2  : i49
    llvm.return %1 : i49
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
