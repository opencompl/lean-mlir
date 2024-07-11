import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-12-05-fp-to-int-ext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: f64) -> i64 {
    %0 = llvm.fptoui %arg0 : f64 to i32
    %1 = llvm.zext %0 : i32 to i64
    llvm.return %1 : i64
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: f64) -> i64 {
    %0 = llvm.fptoui %arg0 : f64 to i32
    %1 = llvm.zext %0 : i32 to i64
    llvm.return %1 : i64
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
