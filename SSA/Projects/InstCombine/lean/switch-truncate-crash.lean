import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  switch-truncate-crash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.switch %0 : i32, ^bb1 [
      0: ^bb1
    ]
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.switch %0 : i32, ^bb1 [
      0: ^bb1
    ]
  ^bb1:  // 2 preds: ^bb0, ^bb0
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
