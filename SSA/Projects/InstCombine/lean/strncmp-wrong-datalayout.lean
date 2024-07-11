import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncmp-wrong-datalayout
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.call @strncmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
