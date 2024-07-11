import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2003-11-03-VarargsCallBug
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i64) {
    %0 = llvm.inttoptr %arg0 : i64 to !llvm.ptr
    llvm.call @foo(%0) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i64) {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.call @foo(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
