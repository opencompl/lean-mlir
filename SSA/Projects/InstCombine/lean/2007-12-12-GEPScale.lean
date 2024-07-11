import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-12-12-GEPScale
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %1 : !llvm.ptr
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
