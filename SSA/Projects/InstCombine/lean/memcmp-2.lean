import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcmp-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.call @memcmp(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.call @memcmp(%arg0, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
