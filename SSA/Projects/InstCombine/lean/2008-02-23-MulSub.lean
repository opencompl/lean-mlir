import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-02-23-MulSub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i26) -> i26 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2885 : i26) : i26
    %1 = llvm.mlir.constant(2884 : i26) : i26
    %2 = llvm.mul %arg0, %0  : i26
    %3 = llvm.mul %arg0, %1  : i26
    %4 = llvm.sub %2, %3  : i26
    llvm.return %4 : i26
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i26) -> i26 attributes {passthrough = ["nounwind"]} {
    llvm.return %arg0 : i26
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
