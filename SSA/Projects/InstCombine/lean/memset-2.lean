import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memset-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> i8 {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> i8
    llvm.return %0 : i8
  }]

def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> i8 {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
