import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2004-11-22-Missed-and-fold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
