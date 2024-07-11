import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-07-16-fsub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fsub %arg0, %arg0  : f64
    llvm.return %0 : f64
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fsub %arg0, %arg0  : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
