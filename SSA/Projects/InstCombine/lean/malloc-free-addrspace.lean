import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  malloc-free-addrspace
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def remove_malloc_before := [llvmfunc|
  llvm.func @remove_malloc() -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr<200>
    llvm.call @free(%2) : (!llvm.ptr<200>) -> ()
    llvm.return %1 : i64
  }]

def remove_calloc_before := [llvmfunc|
  llvm.func @remove_calloc() -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr<200>
    llvm.call @free(%3) : (!llvm.ptr<200>) -> ()
    llvm.return %2 : i64
  }]

def remove_aligned_alloc_before := [llvmfunc|
  llvm.func @remove_aligned_alloc() -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @aligned_alloc(%0, %0) : (i64, i64) -> !llvm.ptr<200>
    llvm.call @free(%2) : (!llvm.ptr<200>) -> ()
    llvm.return %1 : i64
  }]

def remove_strdup_before := [llvmfunc|
  llvm.func @remove_strdup(%arg0: !llvm.ptr<200>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @strdup(%arg0) : (!llvm.ptr<200>) -> !llvm.ptr<200>
    llvm.call @free(%1) : (!llvm.ptr<200>) -> ()
    llvm.return %0 : i64
  }]

def remove_new_before := [llvmfunc|
  llvm.func @remove_new(%arg0: !llvm.ptr<200>) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr<200>
    llvm.call @_ZdlPv(%2) : (!llvm.ptr<200>) -> ()
    llvm.return %1 : i64
  }]

def remove_new_array_before := [llvmfunc|
  llvm.func @remove_new_array(%arg0: !llvm.ptr<200>) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr<200>
    llvm.call @_ZdaPv(%2) : (!llvm.ptr<200>) -> ()
    llvm.return %1 : i64
  }]

def remove_malloc_combined := [llvmfunc|
  llvm.func @remove_malloc() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_remove_malloc   : remove_malloc_before  ⊑  remove_malloc_combined := by
  unfold remove_malloc_before remove_malloc_combined
  simp_alive_peephole
  sorry
def remove_calloc_combined := [llvmfunc|
  llvm.func @remove_calloc() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_remove_calloc   : remove_calloc_before  ⊑  remove_calloc_combined := by
  unfold remove_calloc_before remove_calloc_combined
  simp_alive_peephole
  sorry
def remove_aligned_alloc_combined := [llvmfunc|
  llvm.func @remove_aligned_alloc() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_remove_aligned_alloc   : remove_aligned_alloc_before  ⊑  remove_aligned_alloc_combined := by
  unfold remove_aligned_alloc_before remove_aligned_alloc_combined
  simp_alive_peephole
  sorry
def remove_strdup_combined := [llvmfunc|
  llvm.func @remove_strdup(%arg0: !llvm.ptr<200>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_remove_strdup   : remove_strdup_before  ⊑  remove_strdup_combined := by
  unfold remove_strdup_before remove_strdup_combined
  simp_alive_peephole
  sorry
def remove_new_combined := [llvmfunc|
  llvm.func @remove_new(%arg0: !llvm.ptr<200>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_remove_new   : remove_new_before  ⊑  remove_new_combined := by
  unfold remove_new_before remove_new_combined
  simp_alive_peephole
  sorry
def remove_new_array_combined := [llvmfunc|
  llvm.func @remove_new_array(%arg0: !llvm.ptr<200>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_remove_new_array   : remove_new_array_before  ⊑  remove_new_array_combined := by
  unfold remove_new_array_before remove_new_array_combined
  simp_alive_peephole
  sorry
