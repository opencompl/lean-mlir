import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-11-10-ashr-miscompile
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.lshr %0, %1  : i32
    llvm.return %2 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.lshr %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
