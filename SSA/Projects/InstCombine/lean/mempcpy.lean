import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  mempcpy
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def memcpy_nonconst_n_before := [llvmfunc|
  llvm.func @memcpy_nonconst_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def memcpy_nonconst_n_copy_attrs_before := [llvmfunc|
  llvm.func @memcpy_nonconst_n_copy_attrs(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def memcpy_nonconst_n_unused_retval_before := [llvmfunc|
  llvm.func @memcpy_nonconst_n_unused_retval(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

def memcpy_small_const_n_before := [llvmfunc|
  llvm.func @memcpy_small_const_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.call @mempcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def memcpy_big_const_n_before := [llvmfunc|
  llvm.func @memcpy_big_const_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    %1 = llvm.call @mempcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def PR48810_before := [llvmfunc|
  llvm.func @PR48810() -> i32 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : i64
    %3 = llvm.mlir.undef : i32
    %4 = llvm.call @mempcpy(%0, %1, %2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %3 : i32
  }]

def memcpy_no_simplify1_before := [llvmfunc|
  llvm.func @memcpy_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

def memcpy_nonconst_n_combined := [llvmfunc|
  llvm.func @memcpy_nonconst_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> !llvm.ptr {
    "llvm.intr.memcpy"(%arg0, %arg1, %arg2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %0 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_memcpy_nonconst_n   : memcpy_nonconst_n_before  ⊑  memcpy_nonconst_n_combined := by
  unfold memcpy_nonconst_n_before memcpy_nonconst_n_combined
  simp_alive_peephole
  sorry
def memcpy_nonconst_n_copy_attrs_combined := [llvmfunc|
  llvm.func @memcpy_nonconst_n_copy_attrs(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> !llvm.ptr {
    "llvm.intr.memcpy"(%arg0, %arg1, %arg2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %0 = llvm.getelementptr inbounds %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_memcpy_nonconst_n_copy_attrs   : memcpy_nonconst_n_copy_attrs_before  ⊑  memcpy_nonconst_n_copy_attrs_combined := by
  unfold memcpy_nonconst_n_copy_attrs_before memcpy_nonconst_n_copy_attrs_combined
  simp_alive_peephole
  sorry
def memcpy_nonconst_n_unused_retval_combined := [llvmfunc|
  llvm.func @memcpy_nonconst_n_unused_retval(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) {
    "llvm.intr.memcpy"(%arg0, %arg1, %arg2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_memcpy_nonconst_n_unused_retval   : memcpy_nonconst_n_unused_retval_before  ⊑  memcpy_nonconst_n_unused_retval_combined := by
  unfold memcpy_nonconst_n_unused_retval_before memcpy_nonconst_n_unused_retval_combined
  simp_alive_peephole
  sorry
def memcpy_small_const_n_combined := [llvmfunc|
  llvm.func @memcpy_small_const_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i64
    llvm.store %1, %arg0 {alignment = 1 : i64} : i64, !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_memcpy_small_const_n   : memcpy_small_const_n_before  ⊑  memcpy_small_const_n_combined := by
  unfold memcpy_small_const_n_before memcpy_small_const_n_combined
  simp_alive_peephole
  sorry
def memcpy_big_const_n_combined := [llvmfunc|
  llvm.func @memcpy_big_const_n(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1024 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %1 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_memcpy_big_const_n   : memcpy_big_const_n_before  ⊑  memcpy_big_const_n_combined := by
  unfold memcpy_big_const_n_before memcpy_big_const_n_combined
  simp_alive_peephole
  sorry
def PR48810_combined := [llvmfunc|
  llvm.func @PR48810() -> i32 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : i64
    %3 = llvm.mlir.undef : i32
    "llvm.intr.memcpy"(%0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_PR48810   : PR48810_before  ⊑  PR48810_combined := by
  unfold PR48810_before PR48810_combined
  simp_alive_peephole
  sorry
def memcpy_no_simplify1_combined := [llvmfunc|
  llvm.func @memcpy_no_simplify1(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.call @mempcpy(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_memcpy_no_simplify1   : memcpy_no_simplify1_before  ⊑  memcpy_no_simplify1_combined := by
  unfold memcpy_no_simplify1_before memcpy_no_simplify1_combined
  simp_alive_peephole
  sorry
