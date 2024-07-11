import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  IntPtrCast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
