import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-04-07-MulPromoteToI96
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i96, %arg1: i96) -> i96 {
    %0 = llvm.trunc %arg0 : i96 to i64
    %1 = llvm.trunc %arg1 : i96 to i64
    %2 = llvm.mul %0, %1  : i64
    %3 = llvm.zext %2 : i64 to i96
    llvm.return %3 : i96
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i96, %arg1: i96) -> i96 {
    %0 = llvm.trunc %arg0 : i96 to i64
    %1 = llvm.trunc %arg1 : i96 to i64
    %2 = llvm.mul %0, %1  : i64
    %3 = llvm.zext %2 : i64 to i96
    llvm.return %3 : i96
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
