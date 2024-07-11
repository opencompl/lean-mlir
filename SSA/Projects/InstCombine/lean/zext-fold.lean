import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  zext-fold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f32
    %2 = llvm.zext %1 : i1 to i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.zext %3 : i8 to i32
    llvm.return %4 : i32
  }]

def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: f32, %arg1: f32) -> i32 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f32
    %1 = llvm.zext %0 : i1 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
