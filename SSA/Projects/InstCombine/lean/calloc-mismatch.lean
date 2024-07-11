import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  calloc-mismatch
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR50846_before := [llvmfunc|
  llvm.func @PR50846() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @calloc(%0, %1) : (i64, i32) -> !llvm.ptr
    llvm.return
  }]

def PR50846_combined := [llvmfunc|
  llvm.func @PR50846() {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @calloc(%0, %1) : (i64, i32) -> !llvm.ptr
    llvm.return
  }]

theorem inst_combine_PR50846   : PR50846_before  ⊑  PR50846_combined := by
  unfold PR50846_before PR50846_combined
  simp_alive_peephole
  sorry
