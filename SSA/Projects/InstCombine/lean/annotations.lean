import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  annotations
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_to_new_instruction_before := [llvmfunc|
  llvm.func @fold_to_new_instruction(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

def fold_to_new_instruction2_before := [llvmfunc|
  llvm.func @fold_to_new_instruction2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

def do_not_add_annotation_to_existing_instr_before := [llvmfunc|
  llvm.func @do_not_add_annotation_to_existing_instr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }]

def copy_1_byte_before := [llvmfunc|
  llvm.func @copy_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def libcallcopy_1_byte_before := [llvmfunc|
  llvm.func @libcallcopy_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @memcpy(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

def libcallcopy_1_byte_chk_before := [llvmfunc|
  llvm.func @libcallcopy_1_byte_chk(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @__memcpy_chk(%arg0, %arg1, %0, %0) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return
  }]

def move_1_byte_before := [llvmfunc|
  llvm.func @move_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    "llvm.intr.memmove"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def libcallmove_1_byte_before := [llvmfunc|
  llvm.func @libcallmove_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @memmove(%arg0, %arg1, %0) : (!llvm.ptr, !llvm.ptr, i64) -> !llvm.ptr
    llvm.return
  }]

def libcallmove_1_byte_chk_before := [llvmfunc|
  llvm.func @libcallmove_1_byte_chk(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.call @__memmove_chk(%arg0, %arg1, %0, %0) : (!llvm.ptr, !llvm.ptr, i64, i64) -> !llvm.ptr
    llvm.return
  }]

def set_1_byte_before := [llvmfunc|
  llvm.func @set_1_byte(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    llvm.return
  }]

def libcall_set_1_byte_before := [llvmfunc|
  llvm.func @libcall_set_1_byte(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @memset(%arg0, %0, %1) : (!llvm.ptr, i32, i64) -> !llvm.ptr
    llvm.return
  }]

def libcall_set_1_byte_chk_before := [llvmfunc|
  llvm.func @libcall_set_1_byte_chk(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.call @__memset_chk(%arg0, %0, %1, %1) : (!llvm.ptr, i32, i64, i64) -> !llvm.ptr
    llvm.return
  }]

def fold_to_new_instruction_combined := [llvmfunc|
  llvm.func @fold_to_new_instruction(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_to_new_instruction   : fold_to_new_instruction_before  ⊑  fold_to_new_instruction_combined := by
  unfold fold_to_new_instruction_before fold_to_new_instruction_combined
  simp_alive_peephole
  sorry
def fold_to_new_instruction2_combined := [llvmfunc|
  llvm.func @fold_to_new_instruction2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_fold_to_new_instruction2   : fold_to_new_instruction2_before  ⊑  fold_to_new_instruction2_combined := by
  unfold fold_to_new_instruction2_before fold_to_new_instruction2_combined
  simp_alive_peephole
  sorry
def do_not_add_annotation_to_existing_instr_combined := [llvmfunc|
  llvm.func @do_not_add_annotation_to_existing_instr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_do_not_add_annotation_to_existing_instr   : do_not_add_annotation_to_existing_instr_before  ⊑  do_not_add_annotation_to_existing_instr_combined := by
  unfold do_not_add_annotation_to_existing_instr_before do_not_add_annotation_to_existing_instr_combined
  simp_alive_peephole
  sorry
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
def libcallcopy_1_byte_combined := [llvmfunc|
  llvm.func @libcallcopy_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_libcallcopy_1_byte   : libcallcopy_1_byte_before  ⊑  libcallcopy_1_byte_combined := by
  unfold libcallcopy_1_byte_before libcallcopy_1_byte_combined
  simp_alive_peephole
  sorry
def libcallcopy_1_byte_chk_combined := [llvmfunc|
  llvm.func @libcallcopy_1_byte_chk(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_libcallcopy_1_byte_chk   : libcallcopy_1_byte_chk_before  ⊑  libcallcopy_1_byte_chk_combined := by
  unfold libcallcopy_1_byte_chk_before libcallcopy_1_byte_chk_combined
  simp_alive_peephole
  sorry
def move_1_byte_combined := [llvmfunc|
  llvm.func @move_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_move_1_byte   : move_1_byte_before  ⊑  move_1_byte_combined := by
  unfold move_1_byte_before move_1_byte_combined
  simp_alive_peephole
  sorry
def libcallmove_1_byte_combined := [llvmfunc|
  llvm.func @libcallmove_1_byte(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_libcallmove_1_byte   : libcallmove_1_byte_before  ⊑  libcallmove_1_byte_combined := by
  unfold libcallmove_1_byte_before libcallmove_1_byte_combined
  simp_alive_peephole
  sorry
def libcallmove_1_byte_chk_combined := [llvmfunc|
  llvm.func @libcallmove_1_byte_chk(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_libcallmove_1_byte_chk   : libcallmove_1_byte_chk_before  ⊑  libcallmove_1_byte_chk_combined := by
  unfold libcallmove_1_byte_chk_before libcallmove_1_byte_chk_combined
  simp_alive_peephole
  sorry
def set_1_byte_combined := [llvmfunc|
  llvm.func @set_1_byte(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_set_1_byte   : set_1_byte_before  ⊑  set_1_byte_combined := by
  unfold set_1_byte_before set_1_byte_combined
  simp_alive_peephole
  sorry
def libcall_set_1_byte_combined := [llvmfunc|
  llvm.func @libcall_set_1_byte(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_libcall_set_1_byte   : libcall_set_1_byte_before  ⊑  libcall_set_1_byte_combined := by
  unfold libcall_set_1_byte_before libcall_set_1_byte_combined
  simp_alive_peephole
  sorry
def libcall_set_1_byte_chk_combined := [llvmfunc|
  llvm.func @libcall_set_1_byte_chk(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_libcall_set_1_byte_chk   : libcall_set_1_byte_chk_before  ⊑  libcall_set_1_byte_chk_combined := by
  unfold libcall_set_1_byte_chk_before libcall_set_1_byte_chk_combined
  simp_alive_peephole
  sorry
