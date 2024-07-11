import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  deref-alloc-fns
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def malloc_nonconstant_size(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @malloc_nonconstant_size(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @malloc(%arg0) : (i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def malloc_constant_size() -> _before := [llvmfunc|
  llvm.func @malloc_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def aligned_alloc_constant_size() -> _before := [llvmfunc|
  llvm.func @aligned_alloc_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(512 : i64) : i64
    %2 = llvm.call @aligned_alloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def aligned_alloc_unknown_size_nonzero(%arg0: i1) -> _before := [llvmfunc|
  llvm.func @aligned_alloc_unknown_size_nonzero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(128 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @aligned_alloc(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def aligned_alloc_unknown_size_possibly_zero(%arg0: i1) -> _before := [llvmfunc|
  llvm.func @aligned_alloc_unknown_size_possibly_zero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @aligned_alloc(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def aligned_alloc_unknown_align(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @aligned_alloc_unknown_align(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.call @aligned_alloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) -> _before := [llvmfunc|
  llvm.func @aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.call @aligned_alloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    %4 = llvm.call @aligned_alloc(%1, %0) : (i64, i64) -> !llvm.ptr
    %5 = llvm.call @aligned_alloc(%2, %arg1) : (i64, i64) -> !llvm.ptr
    %6 = llvm.call @foo(%3, %4, %5) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def memalign_constant_size() -> _before := [llvmfunc|
  llvm.func @memalign_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(512 : i64) : i64
    %2 = llvm.call @memalign(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def memalign_unknown_size_nonzero(%arg0: i1) -> _before := [llvmfunc|
  llvm.func @memalign_unknown_size_nonzero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(128 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @memalign(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memalign_unknown_size_possibly_zero(%arg0: i1) -> _before := [llvmfunc|
  llvm.func @memalign_unknown_size_possibly_zero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @memalign(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memalign_unknown_align(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @memalign_unknown_align(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.call @memalign(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def malloc_constant_size2() -> _before := [llvmfunc|
  llvm.func @malloc_constant_size2() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def malloc_constant_size3() -> _before := [llvmfunc|
  llvm.func @malloc_constant_size3() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def malloc_constant_zero_size() -> _before := [llvmfunc|
  llvm.func @malloc_constant_zero_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) -> _before := [llvmfunc|
  llvm.func @realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @realloc(%arg0, %arg1) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def realloc_constant_zero_size(%arg0: !llvm.ptr) -> _before := [llvmfunc|
  llvm.func @realloc_constant_zero_size(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @realloc(%arg0, %0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def realloc_constant_size(%arg0: !llvm.ptr) -> _before := [llvmfunc|
  llvm.func @realloc_constant_size(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @realloc(%arg0, %0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def calloc_nonconstant_size(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @calloc_nonconstant_size(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @calloc(%0, %arg0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def calloc_nonconstant_size2(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @calloc_nonconstant_size2(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def calloc_nonconstant_size3(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @calloc_nonconstant_size3(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @calloc(%arg0, %arg0) : (i64, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def calloc_constant_zero_size() -> _before := [llvmfunc|
  llvm.func @calloc_constant_zero_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def calloc_constant_zero_size2(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @calloc_constant_zero_size2(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def calloc_constant_zero_size3(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @calloc_constant_zero_size3(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%0, %arg0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def calloc_constant_zero_size4(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @calloc_constant_zero_size4(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def calloc_constant_zero_size5(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @calloc_constant_zero_size5(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def calloc_constant_size() -> _before := [llvmfunc|
  llvm.func @calloc_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def calloc_constant_size_overflow() -> _before := [llvmfunc|
  llvm.func @calloc_constant_size_overflow() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(2000000000000 : i64) : i64
    %1 = llvm.mlir.constant(80000000000 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def op_new_nonconstant_size(%arg0: i64) -> _before := [llvmfunc|
  llvm.func @op_new_nonconstant_size(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @_Znam(%arg0) : (i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def op_new_constant_size() -> _before := [llvmfunc|
  llvm.func @op_new_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def op_new_constant_size2() -> _before := [llvmfunc|
  llvm.func @op_new_constant_size2() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def op_new_constant_zero_size() -> _before := [llvmfunc|
  llvm.func @op_new_constant_zero_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def strdup_constant_str() -> _before := [llvmfunc|
  llvm.func @strdup_constant_str() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @strdup(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def strdup_notconstant_str(%arg0: !llvm.ptr) -> _before := [llvmfunc|
  llvm.func @strdup_notconstant_str(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @strdup(%arg0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def ossfuzz_23214() -> _before := [llvmfunc|
  llvm.func @ossfuzz_23214() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %2 = llvm.mlir.constant(512 : i64) : i64
    %3 = llvm.and %0, %1  : i64
    %4 = llvm.call @aligned_alloc(%3, %2) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def op_new_align() -> _before := [llvmfunc|
  llvm.func @op_new_align() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @_ZnamSt11align_val_t(%0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def my_malloc_constant_size_before := [llvmfunc|
  llvm.func @my_malloc_constant_size() -> !llvm.ptr {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @my_malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def my_calloc_constant_size_before := [llvmfunc|
  llvm.func @my_calloc_constant_size() -> !llvm.ptr {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.call @my_calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def malloc_nonconstant_size(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @malloc_nonconstant_size(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @malloc(%arg0) : (i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_malloc_nonconstant_size(%arg0: i64) ->    : malloc_nonconstant_size(%arg0: i64) -> _before  ⊑  malloc_nonconstant_size(%arg0: i64) -> _combined := by
  unfold malloc_nonconstant_size(%arg0: i64) -> _before malloc_nonconstant_size(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def malloc_constant_size() -> _combined := [llvmfunc|
  llvm.func @malloc_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_malloc_constant_size() ->    : malloc_constant_size() -> _before  ⊑  malloc_constant_size() -> _combined := by
  unfold malloc_constant_size() -> _before malloc_constant_size() -> _combined
  simp_alive_peephole
  sorry
def aligned_alloc_constant_size() -> _combined := [llvmfunc|
  llvm.func @aligned_alloc_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(512 : i64) : i64
    %2 = llvm.call @aligned_alloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_aligned_alloc_constant_size() ->    : aligned_alloc_constant_size() -> _before  ⊑  aligned_alloc_constant_size() -> _combined := by
  unfold aligned_alloc_constant_size() -> _before aligned_alloc_constant_size() -> _combined
  simp_alive_peephole
  sorry
def aligned_alloc_unknown_size_nonzero(%arg0: i1) -> _combined := [llvmfunc|
  llvm.func @aligned_alloc_unknown_size_nonzero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(128 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @aligned_alloc(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_aligned_alloc_unknown_size_nonzero(%arg0: i1) ->    : aligned_alloc_unknown_size_nonzero(%arg0: i1) -> _before  ⊑  aligned_alloc_unknown_size_nonzero(%arg0: i1) -> _combined := by
  unfold aligned_alloc_unknown_size_nonzero(%arg0: i1) -> _before aligned_alloc_unknown_size_nonzero(%arg0: i1) -> _combined
  simp_alive_peephole
  sorry
def aligned_alloc_unknown_size_possibly_zero(%arg0: i1) -> _combined := [llvmfunc|
  llvm.func @aligned_alloc_unknown_size_possibly_zero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @aligned_alloc(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_aligned_alloc_unknown_size_possibly_zero(%arg0: i1) ->    : aligned_alloc_unknown_size_possibly_zero(%arg0: i1) -> _before  ⊑  aligned_alloc_unknown_size_possibly_zero(%arg0: i1) -> _combined := by
  unfold aligned_alloc_unknown_size_possibly_zero(%arg0: i1) -> _before aligned_alloc_unknown_size_possibly_zero(%arg0: i1) -> _combined
  simp_alive_peephole
  sorry
def aligned_alloc_unknown_align(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @aligned_alloc_unknown_align(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.call @aligned_alloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_aligned_alloc_unknown_align(%arg0: i64) ->    : aligned_alloc_unknown_align(%arg0: i64) -> _before  ⊑  aligned_alloc_unknown_align(%arg0: i64) -> _combined := by
  unfold aligned_alloc_unknown_align(%arg0: i64) -> _before aligned_alloc_unknown_align(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) -> _combined := [llvmfunc|
  llvm.func @aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.call @aligned_alloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    %4 = llvm.call @aligned_alloc(%1, %0) : (i64, i64) -> !llvm.ptr
    %5 = llvm.call @aligned_alloc(%2, %arg1) : (i64, i64) -> !llvm.ptr
    %6 = llvm.call @foo(%3, %4, %5) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) ->    : aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) -> _before  ⊑  aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) -> _combined := by
  unfold aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) -> _before aligned_alloc_dynamic_args(%arg0: i64, %arg1: i64) -> _combined
  simp_alive_peephole
  sorry
def memalign_constant_size() -> _combined := [llvmfunc|
  llvm.func @memalign_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(512 : i64) : i64
    %2 = llvm.call @memalign(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_memalign_constant_size() ->    : memalign_constant_size() -> _before  ⊑  memalign_constant_size() -> _combined := by
  unfold memalign_constant_size() -> _before memalign_constant_size() -> _combined
  simp_alive_peephole
  sorry
def memalign_unknown_size_nonzero(%arg0: i1) -> _combined := [llvmfunc|
  llvm.func @memalign_unknown_size_nonzero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(128 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @memalign(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_memalign_unknown_size_nonzero(%arg0: i1) ->    : memalign_unknown_size_nonzero(%arg0: i1) -> _before  ⊑  memalign_unknown_size_nonzero(%arg0: i1) -> _combined := by
  unfold memalign_unknown_size_nonzero(%arg0: i1) -> _before memalign_unknown_size_nonzero(%arg0: i1) -> _combined
  simp_alive_peephole
  sorry
def memalign_unknown_size_possibly_zero(%arg0: i1) -> _combined := [llvmfunc|
  llvm.func @memalign_unknown_size_possibly_zero(%arg0: i1) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.select %arg0, %0, %1 : i1, i64
    %4 = llvm.call @memalign(%2, %3) : (i64, i64) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_memalign_unknown_size_possibly_zero(%arg0: i1) ->    : memalign_unknown_size_possibly_zero(%arg0: i1) -> _before  ⊑  memalign_unknown_size_possibly_zero(%arg0: i1) -> _combined := by
  unfold memalign_unknown_size_possibly_zero(%arg0: i1) -> _before memalign_unknown_size_possibly_zero(%arg0: i1) -> _combined
  simp_alive_peephole
  sorry
def memalign_unknown_align(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @memalign_unknown_align(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.call @memalign(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_memalign_unknown_align(%arg0: i64) ->    : memalign_unknown_align(%arg0: i64) -> _before  ⊑  memalign_unknown_align(%arg0: i64) -> _combined := by
  unfold memalign_unknown_align(%arg0: i64) -> _before memalign_unknown_align(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def malloc_constant_size2() -> _combined := [llvmfunc|
  llvm.func @malloc_constant_size2() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_malloc_constant_size2() ->    : malloc_constant_size2() -> _before  ⊑  malloc_constant_size2() -> _combined := by
  unfold malloc_constant_size2() -> _before malloc_constant_size2() -> _combined
  simp_alive_peephole
  sorry
def malloc_constant_size3() -> _combined := [llvmfunc|
  llvm.func @malloc_constant_size3() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_malloc_constant_size3() ->    : malloc_constant_size3() -> _before  ⊑  malloc_constant_size3() -> _combined := by
  unfold malloc_constant_size3() -> _before malloc_constant_size3() -> _combined
  simp_alive_peephole
  sorry
def malloc_constant_zero_size() -> _combined := [llvmfunc|
  llvm.func @malloc_constant_zero_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_malloc_constant_zero_size() ->    : malloc_constant_zero_size() -> _before  ⊑  malloc_constant_zero_size() -> _combined := by
  unfold malloc_constant_zero_size() -> _before malloc_constant_zero_size() -> _combined
  simp_alive_peephole
  sorry
def realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) -> _combined := [llvmfunc|
  llvm.func @realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @realloc(%arg0, %arg1) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) ->    : realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) -> _before  ⊑  realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) -> _combined := by
  unfold realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) -> _before realloc_nonconstant_size(%arg0: !llvm.ptr, %arg1: i64) -> _combined
  simp_alive_peephole
  sorry
def realloc_constant_zero_size(%arg0: !llvm.ptr) -> _combined := [llvmfunc|
  llvm.func @realloc_constant_zero_size(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @realloc(%arg0, %0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_realloc_constant_zero_size(%arg0: !llvm.ptr) ->    : realloc_constant_zero_size(%arg0: !llvm.ptr) -> _before  ⊑  realloc_constant_zero_size(%arg0: !llvm.ptr) -> _combined := by
  unfold realloc_constant_zero_size(%arg0: !llvm.ptr) -> _before realloc_constant_zero_size(%arg0: !llvm.ptr) -> _combined
  simp_alive_peephole
  sorry
def realloc_constant_size(%arg0: !llvm.ptr) -> _combined := [llvmfunc|
  llvm.func @realloc_constant_size(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @realloc(%arg0, %0) : (!llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_realloc_constant_size(%arg0: !llvm.ptr) ->    : realloc_constant_size(%arg0: !llvm.ptr) -> _before  ⊑  realloc_constant_size(%arg0: !llvm.ptr) -> _combined := by
  unfold realloc_constant_size(%arg0: !llvm.ptr) -> _before realloc_constant_size(%arg0: !llvm.ptr) -> _combined
  simp_alive_peephole
  sorry
def calloc_nonconstant_size(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @calloc_nonconstant_size(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @calloc(%0, %arg0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_calloc_nonconstant_size(%arg0: i64) ->    : calloc_nonconstant_size(%arg0: i64) -> _before  ⊑  calloc_nonconstant_size(%arg0: i64) -> _combined := by
  unfold calloc_nonconstant_size(%arg0: i64) -> _before calloc_nonconstant_size(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def calloc_nonconstant_size2(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @calloc_nonconstant_size2(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_calloc_nonconstant_size2(%arg0: i64) ->    : calloc_nonconstant_size2(%arg0: i64) -> _before  ⊑  calloc_nonconstant_size2(%arg0: i64) -> _combined := by
  unfold calloc_nonconstant_size2(%arg0: i64) -> _before calloc_nonconstant_size2(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def calloc_nonconstant_size3(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @calloc_nonconstant_size3(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @calloc(%arg0, %arg0) : (i64, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_calloc_nonconstant_size3(%arg0: i64) ->    : calloc_nonconstant_size3(%arg0: i64) -> _before  ⊑  calloc_nonconstant_size3(%arg0: i64) -> _combined := by
  unfold calloc_nonconstant_size3(%arg0: i64) -> _before calloc_nonconstant_size3(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def calloc_constant_zero_size() -> _combined := [llvmfunc|
  llvm.func @calloc_constant_zero_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_calloc_constant_zero_size() ->    : calloc_constant_zero_size() -> _before  ⊑  calloc_constant_zero_size() -> _combined := by
  unfold calloc_constant_zero_size() -> _before calloc_constant_zero_size() -> _combined
  simp_alive_peephole
  sorry
def calloc_constant_zero_size2(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @calloc_constant_zero_size2(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%arg0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_calloc_constant_zero_size2(%arg0: i64) ->    : calloc_constant_zero_size2(%arg0: i64) -> _before  ⊑  calloc_constant_zero_size2(%arg0: i64) -> _combined := by
  unfold calloc_constant_zero_size2(%arg0: i64) -> _before calloc_constant_zero_size2(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def calloc_constant_zero_size3(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @calloc_constant_zero_size3(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @calloc(%0, %arg0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_calloc_constant_zero_size3(%arg0: i64) ->    : calloc_constant_zero_size3(%arg0: i64) -> _before  ⊑  calloc_constant_zero_size3(%arg0: i64) -> _combined := by
  unfold calloc_constant_zero_size3(%arg0: i64) -> _before calloc_constant_zero_size3(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def calloc_constant_zero_size4(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @calloc_constant_zero_size4(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_calloc_constant_zero_size4(%arg0: i64) ->    : calloc_constant_zero_size4(%arg0: i64) -> _before  ⊑  calloc_constant_zero_size4(%arg0: i64) -> _combined := by
  unfold calloc_constant_zero_size4(%arg0: i64) -> _before calloc_constant_zero_size4(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def calloc_constant_zero_size5(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @calloc_constant_zero_size5(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_calloc_constant_zero_size5(%arg0: i64) ->    : calloc_constant_zero_size5(%arg0: i64) -> _before  ⊑  calloc_constant_zero_size5(%arg0: i64) -> _combined := by
  unfold calloc_constant_zero_size5(%arg0: i64) -> _before calloc_constant_zero_size5(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def calloc_constant_size() -> _combined := [llvmfunc|
  llvm.func @calloc_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_calloc_constant_size() ->    : calloc_constant_size() -> _before  ⊑  calloc_constant_size() -> _combined := by
  unfold calloc_constant_size() -> _before calloc_constant_size() -> _combined
  simp_alive_peephole
  sorry
def calloc_constant_size_overflow() -> _combined := [llvmfunc|
  llvm.func @calloc_constant_size_overflow() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(2000000000000 : i64) : i64
    %1 = llvm.mlir.constant(80000000000 : i64) : i64
    %2 = llvm.call @calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_calloc_constant_size_overflow() ->    : calloc_constant_size_overflow() -> _before  ⊑  calloc_constant_size_overflow() -> _combined := by
  unfold calloc_constant_size_overflow() -> _before calloc_constant_size_overflow() -> _combined
  simp_alive_peephole
  sorry
def op_new_nonconstant_size(%arg0: i64) -> _combined := [llvmfunc|
  llvm.func @op_new_nonconstant_size(%arg0: i64) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @_Znam(%arg0) : (i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_op_new_nonconstant_size(%arg0: i64) ->    : op_new_nonconstant_size(%arg0: i64) -> _before  ⊑  op_new_nonconstant_size(%arg0: i64) -> _combined := by
  unfold op_new_nonconstant_size(%arg0: i64) -> _before op_new_nonconstant_size(%arg0: i64) -> _combined
  simp_alive_peephole
  sorry
def op_new_constant_size() -> _combined := [llvmfunc|
  llvm.func @op_new_constant_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_op_new_constant_size() ->    : op_new_constant_size() -> _before  ⊑  op_new_constant_size() -> _combined := by
  unfold op_new_constant_size() -> _before op_new_constant_size() -> _combined
  simp_alive_peephole
  sorry
def op_new_constant_size2() -> _combined := [llvmfunc|
  llvm.func @op_new_constant_size2() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.call @_Znwm(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_op_new_constant_size2() ->    : op_new_constant_size2() -> _before  ⊑  op_new_constant_size2() -> _combined := by
  unfold op_new_constant_size2() -> _before op_new_constant_size2() -> _combined
  simp_alive_peephole
  sorry
def op_new_constant_zero_size() -> _combined := [llvmfunc|
  llvm.func @op_new_constant_zero_size() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @_Znam(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_op_new_constant_zero_size() ->    : op_new_constant_zero_size() -> _before  ⊑  op_new_constant_zero_size() -> _combined := by
  unfold op_new_constant_zero_size() -> _before op_new_constant_zero_size() -> _combined
  simp_alive_peephole
  sorry
def strdup_constant_str() -> _combined := [llvmfunc|
  llvm.func @strdup_constant_str() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @strdup(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_strdup_constant_str() ->    : strdup_constant_str() -> _before  ⊑  strdup_constant_str() -> _combined := by
  unfold strdup_constant_str() -> _before strdup_constant_str() -> _combined
  simp_alive_peephole
  sorry
def strdup_notconstant_str(%arg0: !llvm.ptr) -> _combined := [llvmfunc|
  llvm.func @strdup_notconstant_str(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.call @strdup(%arg0) : (!llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_strdup_notconstant_str(%arg0: !llvm.ptr) ->    : strdup_notconstant_str(%arg0: !llvm.ptr) -> _before  ⊑  strdup_notconstant_str(%arg0: !llvm.ptr) -> _combined := by
  unfold strdup_notconstant_str(%arg0: !llvm.ptr) -> _before strdup_notconstant_str(%arg0: !llvm.ptr) -> _combined
  simp_alive_peephole
  sorry
def ossfuzz_23214() -> _combined := [llvmfunc|
  llvm.func @ossfuzz_23214() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %1 = llvm.mlir.constant(512 : i64) : i64
    %2 = llvm.call @aligned_alloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_ossfuzz_23214() ->    : ossfuzz_23214() -> _before  ⊑  ossfuzz_23214() -> _combined := by
  unfold ossfuzz_23214() -> _before ossfuzz_23214() -> _combined
  simp_alive_peephole
  sorry
def op_new_align() -> _combined := [llvmfunc|
  llvm.func @op_new_align() -> (!llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @_ZnamSt11align_val_t(%0, %0) : (i64, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_op_new_align() ->    : op_new_align() -> _before  ⊑  op_new_align() -> _combined := by
  unfold op_new_align() -> _before op_new_align() -> _combined
  simp_alive_peephole
  sorry
def my_malloc_constant_size_combined := [llvmfunc|
  llvm.func @my_malloc_constant_size() -> !llvm.ptr {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.call @my_malloc(%0) : (i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_my_malloc_constant_size   : my_malloc_constant_size_before  ⊑  my_malloc_constant_size_combined := by
  unfold my_malloc_constant_size_before my_malloc_constant_size_combined
  simp_alive_peephole
  sorry
def my_calloc_constant_size_combined := [llvmfunc|
  llvm.func @my_calloc_constant_size() -> !llvm.ptr {
    %0 = llvm.mlir.constant(32 : i64) : i64
    %1 = llvm.mlir.constant(4 : i64) : i64
    %2 = llvm.call @my_calloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_my_calloc_constant_size   : my_calloc_constant_size_before  ⊑  my_calloc_constant_size_combined := by
  unfold my_calloc_constant_size_before my_calloc_constant_size_combined
  simp_alive_peephole
  sorry
