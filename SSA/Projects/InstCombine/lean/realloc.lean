import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  realloc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def realloc_null_ptr_before := [llvmfunc|
  llvm.func @realloc_null_ptr() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(100 : i64) : i64
    %2 = llvm.call @realloc(%0, %1) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def realloc_unknown_ptr_before := [llvmfunc|
  llvm.func @realloc_unknown_ptr(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i64) : i64
    %1 = llvm.call @realloc(%arg0, %0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def realloc_null_ptr_combined := [llvmfunc|
  llvm.func @realloc_null_ptr() -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_realloc_null_ptr   : realloc_null_ptr_before  ⊑  realloc_null_ptr_combined := by
  unfold realloc_null_ptr_before realloc_null_ptr_combined
  simp_alive_peephole
  sorry
def realloc_unknown_ptr_combined := [llvmfunc|
  llvm.func @realloc_unknown_ptr(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(100 : i64) : i64
    %1 = llvm.call @realloc(%arg0, %0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_realloc_unknown_ptr   : realloc_unknown_ptr_before  ⊑  realloc_unknown_ptr_combined := by
  unfold realloc_unknown_ptr_before realloc_unknown_ptr_combined
  simp_alive_peephole
  sorry
