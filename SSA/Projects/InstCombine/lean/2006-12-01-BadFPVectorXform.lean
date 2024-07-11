import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-12-01-BadFPVectorXform
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg0, %arg1  : vector<4xf32>
    %1 = llvm.fsub %0, %arg1  : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg0, %arg1  : vector<4xf32>
    %1 = llvm.fsub %0, %arg1  : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
