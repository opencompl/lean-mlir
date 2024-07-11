import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-01-13-ExtCompareMiscompile
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
