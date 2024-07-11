import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  InferAlignAttribute
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def widen_align_from_allocalign_callsite_before := [llvmfunc|
  llvm.func @widen_align_from_allocalign_callsite() -> !llvm.ptr {
    %0 = llvm.mlir.constant(320 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.call @my_aligned_alloc_2(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def widen_align_from_allocalign_before := [llvmfunc|
  llvm.func @widen_align_from_allocalign() -> !llvm.ptr {
    %0 = llvm.mlir.constant(320 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.call @my_aligned_alloc(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def dont_narrow_align_from_allocalign_before := [llvmfunc|
  llvm.func @dont_narrow_align_from_allocalign() -> !llvm.ptr {
    %0 = llvm.mlir.constant(320 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.call @my_aligned_alloc(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def my_aligned_alloc_3_before := [llvmfunc|
  llvm.func @my_aligned_alloc_3(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.allocalign}) -> !llvm.ptr {
    %0 = llvm.call @my_aligned_alloc_2(%arg0, %arg1) : (i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def allocalign_disappears_before := [llvmfunc|
  llvm.func @allocalign_disappears() -> !llvm.ptr {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.call @my_aligned_alloc_3(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def widen_align_from_allocalign_callsite_combined := [llvmfunc|
  llvm.func @widen_align_from_allocalign_callsite() -> !llvm.ptr {
    %0 = llvm.mlir.constant(320 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.call @my_aligned_alloc_2(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_widen_align_from_allocalign_callsite   : widen_align_from_allocalign_callsite_before  ⊑  widen_align_from_allocalign_callsite_combined := by
  unfold widen_align_from_allocalign_callsite_before widen_align_from_allocalign_callsite_combined
  simp_alive_peephole
  sorry
def widen_align_from_allocalign_combined := [llvmfunc|
  llvm.func @widen_align_from_allocalign() -> !llvm.ptr {
    %0 = llvm.mlir.constant(320 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.call @my_aligned_alloc(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_widen_align_from_allocalign   : widen_align_from_allocalign_before  ⊑  widen_align_from_allocalign_combined := by
  unfold widen_align_from_allocalign_before widen_align_from_allocalign_combined
  simp_alive_peephole
  sorry
def dont_narrow_align_from_allocalign_combined := [llvmfunc|
  llvm.func @dont_narrow_align_from_allocalign() -> !llvm.ptr {
    %0 = llvm.mlir.constant(320 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.call @my_aligned_alloc(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_dont_narrow_align_from_allocalign   : dont_narrow_align_from_allocalign_before  ⊑  dont_narrow_align_from_allocalign_combined := by
  unfold dont_narrow_align_from_allocalign_before dont_narrow_align_from_allocalign_combined
  simp_alive_peephole
  sorry
def my_aligned_alloc_3_combined := [llvmfunc|
  llvm.func @my_aligned_alloc_3(%arg0: i32 {llvm.noundef}, %arg1: i32 {llvm.allocalign}) -> !llvm.ptr {
    %0 = llvm.call @my_aligned_alloc_2(%arg0, %arg1) : (i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_my_aligned_alloc_3   : my_aligned_alloc_3_before  ⊑  my_aligned_alloc_3_combined := by
  unfold my_aligned_alloc_3_before my_aligned_alloc_3_combined
  simp_alive_peephole
  sorry
def allocalign_disappears_combined := [llvmfunc|
  llvm.func @allocalign_disappears() -> !llvm.ptr {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.call @my_aligned_alloc_2(%0, %1) : (i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_allocalign_disappears   : allocalign_disappears_before  ⊑  allocalign_disappears_combined := by
  unfold allocalign_disappears_before allocalign_disappears_combined
  simp_alive_peephole
  sorry
