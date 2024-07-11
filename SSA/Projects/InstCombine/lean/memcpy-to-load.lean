import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcpy-to-load
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def copy_1_byte_before := [llvmfunc|
  llvm.func @copy_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def copy_2_bytes_before := [llvmfunc|
  llvm.func @copy_2_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def copy_3_bytes_before := [llvmfunc|
  llvm.func @copy_3_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(3 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def copy_4_bytes_before := [llvmfunc|
  llvm.func @copy_4_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def copy_5_bytes_before := [llvmfunc|
  llvm.func @copy_5_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def copy_8_bytes_before := [llvmfunc|
  llvm.func @copy_8_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def copy_16_bytes_before := [llvmfunc|
  llvm.func @copy_16_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def copy_8_bytes_noalias_before := [llvmfunc|
  llvm.func @copy_8_bytes_noalias(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{alias_scopes = [#alias_scope], isVolatile = false, noalias_scopes = [#alias_scope1]}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def copy_1_byte_combined := [llvmfunc|
  llvm.func @copy_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_copy_1_byte   : copy_1_byte_before  ⊑  copy_1_byte_combined := by
  unfold copy_1_byte_before copy_1_byte_combined
  simp_alive_peephole
  sorry
def copy_2_bytes_combined := [llvmfunc|
  llvm.func @copy_2_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i16
    llvm.store %0, %arg0 {alignment = 1 : i64} : i16, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_copy_2_bytes   : copy_2_bytes_before  ⊑  copy_2_bytes_combined := by
  unfold copy_2_bytes_before copy_2_bytes_combined
  simp_alive_peephole
  sorry
def copy_3_bytes_combined := [llvmfunc|
  llvm.func @copy_3_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(3 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }]

theorem inst_combine_copy_3_bytes   : copy_3_bytes_before  ⊑  copy_3_bytes_combined := by
  unfold copy_3_bytes_before copy_3_bytes_combined
  simp_alive_peephole
  sorry
def copy_4_bytes_combined := [llvmfunc|
  llvm.func @copy_4_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_copy_4_bytes   : copy_4_bytes_before  ⊑  copy_4_bytes_combined := by
  unfold copy_4_bytes_before copy_4_bytes_combined
  simp_alive_peephole
  sorry
def copy_5_bytes_combined := [llvmfunc|
  llvm.func @copy_5_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(5 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }]

theorem inst_combine_copy_5_bytes   : copy_5_bytes_before  ⊑  copy_5_bytes_combined := by
  unfold copy_5_bytes_before copy_5_bytes_combined
  simp_alive_peephole
  sorry
def copy_8_bytes_combined := [llvmfunc|
  llvm.func @copy_8_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i64
    llvm.store %0, %arg0 {alignment = 1 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_copy_8_bytes   : copy_8_bytes_before  ⊑  copy_8_bytes_combined := by
  unfold copy_8_bytes_before copy_8_bytes_combined
  simp_alive_peephole
  sorry
def copy_16_bytes_combined := [llvmfunc|
  llvm.func @copy_16_bytes(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }]

theorem inst_combine_copy_16_bytes   : copy_16_bytes_before  ⊑  copy_16_bytes_combined := by
  unfold copy_16_bytes_before copy_16_bytes_combined
  simp_alive_peephole
  sorry
def copy_8_bytes_noalias_combined := [llvmfunc|
  llvm.func @copy_8_bytes_noalias(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alias_scopes = [#alias_scope], alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : !llvm.ptr -> i64
    llvm.store %0, %arg0 {alias_scopes = [#alias_scope], alignment = 1 : i64, noalias_scopes = [#alias_scope1]} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_copy_8_bytes_noalias   : copy_8_bytes_noalias_before  ⊑  copy_8_bytes_noalias_combined := by
  unfold copy_8_bytes_noalias_before copy_8_bytes_noalias_combined
  simp_alive_peephole
  sorry
