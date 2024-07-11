import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  mem-deref-bytes
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def memcmp_const_size_set_deref_before := [llvmfunc|
  llvm.func @memcmp_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_const_size_update_deref_before := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_const_size_update_deref2_before := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref2(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_const_size_update_deref3_before := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref3(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_const_size_update_deref4_before := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref4(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_const_size_update_deref5_before := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref5(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_const_size_update_deref6_before := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref6(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_const_size_update_deref7_before := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref7(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_const_size_no_update_deref_before := [llvmfunc|
  llvm.func @memcmp_const_size_no_update_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

def memcmp_nonconst_size_before := [llvmfunc|
  llvm.func @memcmp_nonconst_size(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %0 : i32
  }]

def memcpy_const_size_set_deref_before := [llvmfunc|
  llvm.func @memcpy_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def memmove_const_size_set_deref_before := [llvmfunc|
  llvm.func @memmove_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memmove(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def memset_const_size_set_deref_before := [llvmfunc|
  llvm.func @memset_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memset(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def memchr_const_size_set_deref_before := [llvmfunc|
  llvm.func @memchr_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def llvm_memcpy_const_size_set_deref_before := [llvmfunc|
  llvm.func @llvm_memcpy_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return %arg0 : !llvm.ptr
  }]

def llvm_memmove_const_size_set_deref_before := [llvmfunc|
  llvm.func @llvm_memmove_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memmove"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return %arg0 : !llvm.ptr
  }]

def llvm_memset_const_size_set_deref_before := [llvmfunc|
  llvm.func @llvm_memset_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i8) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()]

    llvm.return %arg0 : !llvm.ptr
  }]

def memcmp_const_size_set_deref_combined := [llvmfunc|
  llvm.func @memcmp_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_set_deref   : memcmp_const_size_set_deref_before  ⊑  memcmp_const_size_set_deref_combined := by
  unfold memcmp_const_size_set_deref_before memcmp_const_size_set_deref_combined
  simp_alive_peephole
  sorry
def memcmp_const_size_update_deref_combined := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_update_deref   : memcmp_const_size_update_deref_before  ⊑  memcmp_const_size_update_deref_combined := by
  unfold memcmp_const_size_update_deref_before memcmp_const_size_update_deref_combined
  simp_alive_peephole
  sorry
def memcmp_const_size_update_deref2_combined := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref2(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_update_deref2   : memcmp_const_size_update_deref2_before  ⊑  memcmp_const_size_update_deref2_combined := by
  unfold memcmp_const_size_update_deref2_before memcmp_const_size_update_deref2_combined
  simp_alive_peephole
  sorry
def memcmp_const_size_update_deref3_combined := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref3(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_update_deref3   : memcmp_const_size_update_deref3_before  ⊑  memcmp_const_size_update_deref3_combined := by
  unfold memcmp_const_size_update_deref3_before memcmp_const_size_update_deref3_combined
  simp_alive_peephole
  sorry
def memcmp_const_size_update_deref4_combined := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref4(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_update_deref4   : memcmp_const_size_update_deref4_before  ⊑  memcmp_const_size_update_deref4_combined := by
  unfold memcmp_const_size_update_deref4_before memcmp_const_size_update_deref4_combined
  simp_alive_peephole
  sorry
def memcmp_const_size_update_deref5_combined := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref5(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_update_deref5   : memcmp_const_size_update_deref5_before  ⊑  memcmp_const_size_update_deref5_combined := by
  unfold memcmp_const_size_update_deref5_before memcmp_const_size_update_deref5_combined
  simp_alive_peephole
  sorry
def memcmp_const_size_update_deref6_combined := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref6(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_update_deref6   : memcmp_const_size_update_deref6_before  ⊑  memcmp_const_size_update_deref6_combined := by
  unfold memcmp_const_size_update_deref6_before memcmp_const_size_update_deref6_combined
  simp_alive_peephole
  sorry
def memcmp_const_size_update_deref7_combined := [llvmfunc|
  llvm.func @memcmp_const_size_update_deref7(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_update_deref7   : memcmp_const_size_update_deref7_before  ⊑  memcmp_const_size_update_deref7_combined := by
  unfold memcmp_const_size_update_deref7_before memcmp_const_size_update_deref7_combined
  simp_alive_peephole
  sorry
def memcmp_const_size_no_update_deref_combined := [llvmfunc|
  llvm.func @memcmp_const_size_no_update_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.call @memcmp(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_memcmp_const_size_no_update_deref   : memcmp_const_size_no_update_deref_before  ⊑  memcmp_const_size_no_update_deref_combined := by
  unfold memcmp_const_size_no_update_deref_before memcmp_const_size_no_update_deref_combined
  simp_alive_peephole
  sorry
def memcmp_nonconst_size_combined := [llvmfunc|
  llvm.func @memcmp_nonconst_size(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg2: i64) -> i32 {
    %0 = llvm.call @memcmp(%arg0, %arg1, %arg2) : (!llvm.ptr, !llvm.ptr, i64) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_memcmp_nonconst_size   : memcmp_nonconst_size_before  ⊑  memcmp_nonconst_size_combined := by
  unfold memcmp_nonconst_size_before memcmp_nonconst_size_combined
  simp_alive_peephole
  sorry
def memcpy_const_size_set_deref_combined := [llvmfunc|
  llvm.func @memcpy_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_memcpy_const_size_set_deref   : memcpy_const_size_set_deref_before  ⊑  memcpy_const_size_set_deref_combined := by
  unfold memcpy_const_size_set_deref_before memcpy_const_size_set_deref_combined
  simp_alive_peephole
  sorry
def memmove_const_size_set_deref_combined := [llvmfunc|
  llvm.func @memmove_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    "llvm.intr.memmove"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_memmove_const_size_set_deref   : memmove_const_size_set_deref_before  ⊑  memmove_const_size_set_deref_combined := by
  unfold memmove_const_size_set_deref_before memmove_const_size_set_deref_combined
  simp_alive_peephole
  sorry
def memset_const_size_set_deref_combined := [llvmfunc|
  llvm.func @memset_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.trunc %arg1 : i32 to i8
    "llvm.intr.memset"(%arg0, %1, %0) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_memset_const_size_set_deref   : memset_const_size_set_deref_before  ⊑  memset_const_size_set_deref_combined := by
  unfold memset_const_size_set_deref_before memset_const_size_set_deref_combined
  simp_alive_peephole
  sorry
def memchr_const_size_set_deref_combined := [llvmfunc|
  llvm.func @memchr_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(64 : i64) : i64
    %1 = llvm.call @memchr(%arg0, %arg1, %0) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_memchr_const_size_set_deref   : memchr_const_size_set_deref_before  ⊑  memchr_const_size_set_deref_combined := by
  unfold memchr_const_size_set_deref_before memchr_const_size_set_deref_combined
  simp_alive_peephole
  sorry
def llvm_memcpy_const_size_set_deref_combined := [llvmfunc|
  llvm.func @llvm_memcpy_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_llvm_memcpy_const_size_set_deref   : llvm_memcpy_const_size_set_deref_before  ⊑  llvm_memcpy_const_size_set_deref_combined := by
  unfold llvm_memcpy_const_size_set_deref_before llvm_memcpy_const_size_set_deref_combined
  simp_alive_peephole
  sorry
def llvm_memmove_const_size_set_deref_combined := [llvmfunc|
  llvm.func @llvm_memmove_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr {llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memmove"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_llvm_memmove_const_size_set_deref   : llvm_memmove_const_size_set_deref_before  ⊑  llvm_memmove_const_size_set_deref_combined := by
  unfold llvm_memmove_const_size_set_deref_before llvm_memmove_const_size_set_deref_combined
  simp_alive_peephole
  sorry
def llvm_memset_const_size_set_deref_combined := [llvmfunc|
  llvm.func @llvm_memset_const_size_set_deref(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: i8) -> !llvm.ptr {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_llvm_memset_const_size_set_deref   : llvm_memset_const_size_set_deref_before  ⊑  llvm_memset_const_size_set_deref_combined := by
  unfold llvm_memset_const_size_set_deref_before llvm_memset_const_size_set_deref_combined
  simp_alive_peephole
  sorry
