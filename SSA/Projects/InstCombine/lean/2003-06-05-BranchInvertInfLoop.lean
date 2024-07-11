import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2003-06-05-BranchInvertInfLoop
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }]

def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i1) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i8
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
