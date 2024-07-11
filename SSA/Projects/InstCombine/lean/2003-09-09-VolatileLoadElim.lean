import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2003-09-09-VolatileLoadElim
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
