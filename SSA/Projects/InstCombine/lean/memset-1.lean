import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memset-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify1_tail_before := [llvmfunc|
  llvm.func @test_simplify1_tail(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify1_musttail_before := [llvmfunc|
  llvm.func @test_simplify1_musttail(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def pr25892_lite_before := [llvmfunc|
  llvm.func @pr25892_lite(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    %2 = llvm.call @memset(%1, %0, %arg0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def malloc_and_memset_intrinsic_before := [llvmfunc|
  llvm.func @malloc_and_memset_intrinsic(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    "llvm.intr.memset"(%1, %0, %arg0) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    llvm.return %1 : !llvm.ptr
  }]

def notmalloc_memset_before := [llvmfunc|
  llvm.func @notmalloc_memset(%arg0: i32, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call %arg1(%arg0) : !llvm.ptr, (i32) -> !llvm.ptr
    %2 = llvm.call @memset(%1, %0, %arg0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }]

def pr25892_before := [llvmfunc|
  llvm.func @pr25892(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %0 : !llvm.ptr
    llvm.cond_br %3, ^bb2(%0 : !llvm.ptr), ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.call @memset(%2, %1, %arg0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.br ^bb2(%2 : !llvm.ptr)
  ^bb2(%5: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : !llvm.ptr
  }]

def buffer_is_modified_then_memset_before := [llvmfunc|
  llvm.func @buffer_is_modified_then_memset(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    llvm.store %0, %2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %3 = llvm.call @memset(%2, %1, %arg0) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def memset_size_select_before := [llvmfunc|
  llvm.func @memset_size_select(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.call @memset(%arg1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memset_size_select2_before := [llvmfunc|
  llvm.func @memset_size_select2(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.call @memset(%arg1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memset_size_select3_before := [llvmfunc|
  llvm.func @memset_size_select3(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.call @memset(%arg1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memset_size_select4_before := [llvmfunc|
  llvm.func @memset_size_select4(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.call @memset(%arg1, %2, %3) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }]

def memset_size_ashr_before := [llvmfunc|
  llvm.func @memset_size_ashr(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %0, %arg2  : i32
    %3 = llvm.call @memset(%arg1, %1, %2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def memset_attrs1_before := [llvmfunc|
  llvm.func @memset_attrs1(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memset(%arg1, %0, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def memset_attrs2_before := [llvmfunc|
  llvm.func @memset_attrs2(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memset(%arg1, %0, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def memset_attrs3_before := [llvmfunc|
  llvm.func @memset_attrs3(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memset(%arg1, %0, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def memset_attrs4_before := [llvmfunc|
  llvm.func @memset_attrs4(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @memset(%arg1, %0, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def test_no_incompatible_attr_before := [llvmfunc|
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.trunc %arg1 : i32 to i8
    "llvm.intr.memset"(%arg0, %0, %arg2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify1_tail_combined := [llvmfunc|
  llvm.func @test_simplify1_tail(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.trunc %arg1 : i32 to i8
    "llvm.intr.memset"(%arg0, %0, %arg2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify1_tail   : test_simplify1_tail_before  ⊑  test_simplify1_tail_combined := by
  unfold test_simplify1_tail_before test_simplify1_tail_combined
  simp_alive_peephole
  sorry
def test_simplify1_musttail_combined := [llvmfunc|
  llvm.func @test_simplify1_musttail(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.call @memset(%arg0, %arg1, %arg2) : (!llvm.ptr, i32, i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_simplify1_musttail   : test_simplify1_musttail_before  ⊑  test_simplify1_musttail_combined := by
  unfold test_simplify1_musttail_before test_simplify1_musttail_combined
  simp_alive_peephole
  sorry
def pr25892_lite_combined := [llvmfunc|
  llvm.func @pr25892_lite(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    "llvm.intr.memset"(%1, %0, %arg0) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_pr25892_lite   : pr25892_lite_before  ⊑  pr25892_lite_combined := by
  unfold pr25892_lite_before pr25892_lite_combined
  simp_alive_peephole
  sorry
def malloc_and_memset_intrinsic_combined := [llvmfunc|
  llvm.func @malloc_and_memset_intrinsic(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    "llvm.intr.memset"(%1, %0, %arg0) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_malloc_and_memset_intrinsic   : malloc_and_memset_intrinsic_before  ⊑  malloc_and_memset_intrinsic_combined := by
  unfold malloc_and_memset_intrinsic_before malloc_and_memset_intrinsic_combined
  simp_alive_peephole
  sorry
def notmalloc_memset_combined := [llvmfunc|
  llvm.func @notmalloc_memset(%arg0: i32, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call %arg1(%arg0) : !llvm.ptr, (i32) -> !llvm.ptr
    "llvm.intr.memset"(%1, %0, %arg0) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_notmalloc_memset   : notmalloc_memset_before  ⊑  notmalloc_memset_combined := by
  unfold notmalloc_memset_before notmalloc_memset_combined
  simp_alive_peephole
  sorry
def pr25892_combined := [llvmfunc|
  llvm.func @pr25892(%arg0: i32) -> !llvm.ptr attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    %3 = llvm.icmp "eq" %2, %0 : !llvm.ptr
    llvm.cond_br %3, ^bb2(%0 : !llvm.ptr), ^bb1
  ^bb1:  // pred: ^bb0
    "llvm.intr.memset"(%2, %1, %arg0) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.br ^bb2(%2 : !llvm.ptr)
  ^bb2(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_pr25892   : pr25892_before  ⊑  pr25892_combined := by
  unfold pr25892_before pr25892_combined
  simp_alive_peephole
  sorry
def buffer_is_modified_then_memset_combined := [llvmfunc|
  llvm.func @buffer_is_modified_then_memset(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.call @malloc(%arg0) : (i32) -> !llvm.ptr
    llvm.store %0, %2 {alignment = 1 : i64} : i8, !llvm.ptr
    "llvm.intr.memset"(%2, %1, %arg0) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_buffer_is_modified_then_memset   : buffer_is_modified_then_memset_before  ⊑  buffer_is_modified_then_memset_combined := by
  unfold buffer_is_modified_then_memset_before buffer_is_modified_then_memset_combined
  simp_alive_peephole
  sorry
def memset_size_select_combined := [llvmfunc|
  llvm.func @memset_size_select(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    "llvm.intr.memset"(%arg1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg1 : !llvm.ptr
  }]

theorem inst_combine_memset_size_select   : memset_size_select_before  ⊑  memset_size_select_combined := by
  unfold memset_size_select_before memset_size_select_combined
  simp_alive_peephole
  sorry
def memset_size_select2_combined := [llvmfunc|
  llvm.func @memset_size_select2(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    "llvm.intr.memset"(%arg1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg1 : !llvm.ptr
  }]

theorem inst_combine_memset_size_select2   : memset_size_select2_before  ⊑  memset_size_select2_combined := by
  unfold memset_size_select2_before memset_size_select2_combined
  simp_alive_peephole
  sorry
def memset_size_select3_combined := [llvmfunc|
  llvm.func @memset_size_select3(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    "llvm.intr.memset"(%arg1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg1 : !llvm.ptr
  }]

theorem inst_combine_memset_size_select3   : memset_size_select3_before  ⊑  memset_size_select3_combined := by
  unfold memset_size_select3_before memset_size_select3_combined
  simp_alive_peephole
  sorry
def memset_size_select4_combined := [llvmfunc|
  llvm.func @memset_size_select4(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(50 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    "llvm.intr.memset"(%arg1, %2, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg1 : !llvm.ptr
  }]

theorem inst_combine_memset_size_select4   : memset_size_select4_before  ⊑  memset_size_select4_combined := by
  unfold memset_size_select4_before memset_size_select4_combined
  simp_alive_peephole
  sorry
def memset_size_ashr_combined := [llvmfunc|
  llvm.func @memset_size_ashr(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %0, %arg2  : i32
    "llvm.intr.memset"(%arg1, %1, %2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg1 : !llvm.ptr
  }]

theorem inst_combine_memset_size_ashr   : memset_size_ashr_before  ⊑  memset_size_ashr_combined := by
  unfold memset_size_ashr_before memset_size_ashr_combined
  simp_alive_peephole
  sorry
def memset_attrs1_combined := [llvmfunc|
  llvm.func @memset_attrs1(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    "llvm.intr.memset"(%arg1, %0, %arg2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg1 : !llvm.ptr
  }]

theorem inst_combine_memset_attrs1   : memset_attrs1_before  ⊑  memset_attrs1_combined := by
  unfold memset_attrs1_before memset_attrs1_combined
  simp_alive_peephole
  sorry
def memset_attrs2_combined := [llvmfunc|
  llvm.func @memset_attrs2(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    "llvm.intr.memset"(%arg1, %0, %arg2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg1 : !llvm.ptr
  }]

theorem inst_combine_memset_attrs2   : memset_attrs2_before  ⊑  memset_attrs2_combined := by
  unfold memset_attrs2_before memset_attrs2_combined
  simp_alive_peephole
  sorry
def memset_attrs3_combined := [llvmfunc|
  llvm.func @memset_attrs3(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    "llvm.intr.memset"(%arg1, %0, %arg2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg1 : !llvm.ptr
  }]

theorem inst_combine_memset_attrs3   : memset_attrs3_before  ⊑  memset_attrs3_combined := by
  unfold memset_attrs3_before memset_attrs3_combined
  simp_alive_peephole
  sorry
def memset_attrs4_combined := [llvmfunc|
  llvm.func @memset_attrs4(%arg0: i1, %arg1: !llvm.ptr, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    "llvm.intr.memset"(%arg1, %0, %arg2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg1 : !llvm.ptr
  }]

theorem inst_combine_memset_attrs4   : memset_attrs4_before  ⊑  memset_attrs4_combined := by
  unfold memset_attrs4_before memset_attrs4_combined
  simp_alive_peephole
  sorry
def test_no_incompatible_attr_combined := [llvmfunc|
  llvm.func @test_no_incompatible_attr(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> !llvm.ptr {
    %0 = llvm.trunc %arg1 : i32 to i8
    "llvm.intr.memset"(%arg0, %0, %arg2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_test_no_incompatible_attr   : test_no_incompatible_attr_before  ⊑  test_no_incompatible_attr_combined := by
  unfold test_no_incompatible_attr_before test_no_incompatible_attr_combined
  simp_alive_peephole
  sorry
