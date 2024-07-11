import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  malloc_free_delete_nvptx
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def malloc_then_free_not_needed_before := [llvmfunc|
  llvm.func @malloc_then_free_not_needed() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.call @free(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

def malloc_then_free_needed_before := [llvmfunc|
  llvm.func @malloc_then_free_needed() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @user(%1) : (!llvm.ptr) -> ()
    llvm.call @free(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def malloc_then_free_not_needed_combined := [llvmfunc|
  llvm.func @malloc_then_free_not_needed() {
    llvm.return
  }]

theorem inst_combine_malloc_then_free_not_needed   : malloc_then_free_not_needed_before  ⊑  malloc_then_free_not_needed_combined := by
  unfold malloc_then_free_not_needed_before malloc_then_free_not_needed_combined
  simp_alive_peephole
  sorry
def malloc_then_free_needed_combined := [llvmfunc|
  llvm.func @malloc_then_free_needed() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @user(%1) : (!llvm.ptr) -> ()
    llvm.call @free(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_malloc_then_free_needed   : malloc_then_free_needed_before  ⊑  malloc_then_free_needed_combined := by
  unfold malloc_then_free_needed_before malloc_then_free_needed_combined
  simp_alive_peephole
  sorry
