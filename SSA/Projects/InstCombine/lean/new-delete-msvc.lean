import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  new-delete-msvc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test9_before := [llvmfunc|
  llvm.func @test9() {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @"\01??2@YAPEAX_K@Z"(%0) : (i64) -> !llvm.ptr
    llvm.call @"\01??3@YAXPEAX@Z"(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test9_combined := [llvmfunc|
  llvm.func @test9() {
    llvm.return
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
