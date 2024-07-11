import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-cast-cast-to-and
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i61) -> i61 {
    %0 = llvm.trunc %arg0 : i61 to i41
    %1 = llvm.zext %0 : i41 to i61
    llvm.return %1 : i61
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i61) -> i61 {
    %0 = llvm.mlir.constant(2199023255551 : i61) : i61
    %1 = llvm.and %arg0, %0  : i61
    llvm.return %1 : i61
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
