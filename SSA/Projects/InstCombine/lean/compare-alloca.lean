import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  compare-alloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def alloca_argument_compare_before := [llvmfunc|
  llvm.func @alloca_argument_compare(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.icmp "eq" %arg0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }]

def alloca_argument_compare_swapped_before := [llvmfunc|
  llvm.func @alloca_argument_compare_swapped(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def alloca_argument_compare_ne_before := [llvmfunc|
  llvm.func @alloca_argument_compare_ne(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.icmp "ne" %arg0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }]

def alloca_argument_compare_derived_ptrs_before := [llvmfunc|
  llvm.func @alloca_argument_compare_derived_ptrs(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i64) -> !llvm.ptr]

    %3 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %4 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }]

def alloca_argument_compare_escaped_alloca_before := [llvmfunc|
  llvm.func @alloca_argument_compare_escaped_alloca(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.call @escape(%1) : (!llvm.ptr) -> ()
    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def alloca_argument_compare_two_compares_before := [llvmfunc|
  llvm.func @alloca_argument_compare_two_compares(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i64) -> !llvm.ptr]

    %4 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %5 = llvm.getelementptr %3[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    %6 = llvm.icmp "eq" %arg0, %3 : !llvm.ptr
    %7 = llvm.icmp "eq" %4, %5 : !llvm.ptr
    llvm.call @check_compares(%6, %7) : (i1, i1) -> ()
    llvm.return
  }]

def alloca_argument_compare_escaped_through_store_before := [llvmfunc|
  llvm.func @alloca_argument_compare_escaped_through_store(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.icmp "eq" %2, %arg0 : !llvm.ptr
    %4 = llvm.getelementptr %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i64
    llvm.store %4, %arg1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return %3 : i1
  }]

def alloca_argument_compare_benign_instrs_before := [llvmfunc|
  llvm.func @alloca_argument_compare_benign_instrs(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %1 : !llvm.ptr
    %3 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.store %3, %1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.return %2 : i1
  }]

def alloca_call_compare_before := [llvmfunc|
  llvm.func @alloca_call_compare() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.call @allocator() : () -> !llvm.ptr
    %3 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }]

def ptrtoint_single_cmp_before := [llvmfunc|
  llvm.func @ptrtoint_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def offset_single_cmp_before := [llvmfunc|
  llvm.func @offset_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def consistent_fold1_before := [llvmfunc|
  llvm.func @consistent_fold1() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %5 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %6 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }]

def consistent_fold2_before := [llvmfunc|
  llvm.func @consistent_fold2() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %4 = llvm.call @hidden_offset(%2) : (!llvm.ptr) -> !llvm.ptr
    %5 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    %6 = llvm.icmp "eq" %1, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }]

def consistent_fold3_before := [llvmfunc|
  llvm.func @consistent_fold3() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %7 = llvm.icmp "eq" %3, %5 : !llvm.ptr
    llvm.call @witness(%6, %7) : (i1, i1) -> ()
    llvm.return
  }]

def neg_consistent_fold4_before := [llvmfunc|
  llvm.func @neg_consistent_fold4() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }]

def consistent_nocapture_inttoptr_before := [llvmfunc|
  llvm.func @consistent_nocapture_inttoptr() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def consistent_nocapture_offset_before := [llvmfunc|
  llvm.func @consistent_nocapture_offset() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.call @unknown(%1) : (!llvm.ptr) -> ()
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def consistent_nocapture_through_global_before := [llvmfunc|
  llvm.func @consistent_nocapture_through_global() -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.call @unknown(%3) : (!llvm.ptr) -> ()
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }]

def select_alloca_unrelated_ptr_before := [llvmfunc|
  llvm.func @select_alloca_unrelated_ptr(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.icmp "eq" %1, %arg1 : !llvm.ptr
    %3 = llvm.select %arg0, %1, %arg2 : i1, !llvm.ptr
    %4 = llvm.icmp "eq" %3, %arg1 : !llvm.ptr
    llvm.call @witness(%2, %4) : (i1, i1) -> ()
    llvm.return
  }]

def alloca_offset_icmp_before := [llvmfunc|
  llvm.func @alloca_offset_icmp(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<4 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.getelementptr %1[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    %4 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.call @witness(%3, %4) : (i1, i1) -> ()
    llvm.return
  }]

def alloca_argument_compare_combined := [llvmfunc|
  llvm.func @alloca_argument_compare(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_alloca_argument_compare   : alloca_argument_compare_before  ⊑  alloca_argument_compare_combined := by
  unfold alloca_argument_compare_before alloca_argument_compare_combined
  simp_alive_peephole
  sorry
def alloca_argument_compare_swapped_combined := [llvmfunc|
  llvm.func @alloca_argument_compare_swapped(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_alloca_argument_compare_swapped   : alloca_argument_compare_swapped_before  ⊑  alloca_argument_compare_swapped_combined := by
  unfold alloca_argument_compare_swapped_before alloca_argument_compare_swapped_combined
  simp_alive_peephole
  sorry
def alloca_argument_compare_ne_combined := [llvmfunc|
  llvm.func @alloca_argument_compare_ne(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_alloca_argument_compare_ne   : alloca_argument_compare_ne_before  ⊑  alloca_argument_compare_ne_combined := by
  unfold alloca_argument_compare_ne_before alloca_argument_compare_ne_combined
  simp_alive_peephole
  sorry
def alloca_argument_compare_derived_ptrs_combined := [llvmfunc|
  llvm.func @alloca_argument_compare_derived_ptrs(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_alloca_argument_compare_derived_ptrs   : alloca_argument_compare_derived_ptrs_before  ⊑  alloca_argument_compare_derived_ptrs_combined := by
  unfold alloca_argument_compare_derived_ptrs_before alloca_argument_compare_derived_ptrs_combined
  simp_alive_peephole
  sorry
def alloca_argument_compare_escaped_alloca_combined := [llvmfunc|
  llvm.func @alloca_argument_compare_escaped_alloca(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.call @escape(%1) : (!llvm.ptr) -> ()
    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    llvm.return %2 : i1
  }]

theorem inst_combine_alloca_argument_compare_escaped_alloca   : alloca_argument_compare_escaped_alloca_before  ⊑  alloca_argument_compare_escaped_alloca_combined := by
  unfold alloca_argument_compare_escaped_alloca_before alloca_argument_compare_escaped_alloca_combined
  simp_alive_peephole
  sorry
def alloca_argument_compare_two_compares_combined := [llvmfunc|
  llvm.func @alloca_argument_compare_two_compares(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.call @check_compares(%0, %0) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_alloca_argument_compare_two_compares   : alloca_argument_compare_two_compares_before  ⊑  alloca_argument_compare_two_compares_combined := by
  unfold alloca_argument_compare_two_compares_before alloca_argument_compare_two_compares_combined
  simp_alive_peephole
  sorry
def alloca_argument_compare_escaped_through_store_combined := [llvmfunc|
  llvm.func @alloca_argument_compare_escaped_through_store(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %arg0 : !llvm.ptr
    %3 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i64
    llvm.store %3, %arg1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %2 : i1
  }]

theorem inst_combine_alloca_argument_compare_escaped_through_store   : alloca_argument_compare_escaped_through_store_before  ⊑  alloca_argument_compare_escaped_through_store_combined := by
  unfold alloca_argument_compare_escaped_through_store_before alloca_argument_compare_escaped_through_store_combined
  simp_alive_peephole
  sorry
def alloca_argument_compare_benign_instrs_combined := [llvmfunc|
  llvm.func @alloca_argument_compare_benign_instrs(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_alloca_argument_compare_benign_instrs   : alloca_argument_compare_benign_instrs_before  ⊑  alloca_argument_compare_benign_instrs_combined := by
  unfold alloca_argument_compare_benign_instrs_before alloca_argument_compare_benign_instrs_combined
  simp_alive_peephole
  sorry
def alloca_call_compare_combined := [llvmfunc|
  llvm.func @alloca_call_compare() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @allocator() : () -> !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_alloca_call_compare   : alloca_call_compare_before  ⊑  alloca_call_compare_combined := by
  unfold alloca_call_compare_before alloca_call_compare_combined
  simp_alive_peephole
  sorry
def ptrtoint_single_cmp_combined := [llvmfunc|
  llvm.func @ptrtoint_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ptrtoint_single_cmp   : ptrtoint_single_cmp_before  ⊑  ptrtoint_single_cmp_combined := by
  unfold ptrtoint_single_cmp_before ptrtoint_single_cmp_combined
  simp_alive_peephole
  sorry
def offset_single_cmp_combined := [llvmfunc|
  llvm.func @offset_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_offset_single_cmp   : offset_single_cmp_before  ⊑  offset_single_cmp_combined := by
  unfold offset_single_cmp_before offset_single_cmp_combined
  simp_alive_peephole
  sorry
def consistent_fold1_combined := [llvmfunc|
  llvm.func @consistent_fold1() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    llvm.call @witness(%0, %0) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_consistent_fold1   : consistent_fold1_before  ⊑  consistent_fold1_combined := by
  unfold consistent_fold1_before consistent_fold1_combined
  simp_alive_peephole
  sorry
def consistent_fold2_combined := [llvmfunc|
  llvm.func @consistent_fold2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.alloca %0 x !llvm.array<4 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @hidden_offset(%2) : (!llvm.ptr) -> !llvm.ptr
    llvm.call @witness(%1, %1) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_consistent_fold2   : consistent_fold2_before  ⊑  consistent_fold2_combined := by
  unfold consistent_fold2_before consistent_fold2_combined
  simp_alive_peephole
  sorry
def consistent_fold3_combined := [llvmfunc|
  llvm.func @consistent_fold3() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    llvm.call @witness(%0, %0) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_consistent_fold3   : consistent_fold3_before  ⊑  consistent_fold3_combined := by
  unfold consistent_fold3_before consistent_fold3_combined
  simp_alive_peephole
  sorry
def neg_consistent_fold4_combined := [llvmfunc|
  llvm.func @neg_consistent_fold4() {
    %0 = llvm.mlir.constant(false) : i1
    llvm.call @witness(%0, %0) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_neg_consistent_fold4   : neg_consistent_fold4_before  ⊑  neg_consistent_fold4_combined := by
  unfold neg_consistent_fold4_before neg_consistent_fold4_combined
  simp_alive_peephole
  sorry
def consistent_nocapture_inttoptr_combined := [llvmfunc|
  llvm.func @consistent_nocapture_inttoptr() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.alloca %0 x !llvm.array<4 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_consistent_nocapture_inttoptr   : consistent_nocapture_inttoptr_before  ⊑  consistent_nocapture_inttoptr_combined := by
  unfold consistent_nocapture_inttoptr_before consistent_nocapture_inttoptr_combined
  simp_alive_peephole
  sorry
def consistent_nocapture_offset_combined := [llvmfunc|
  llvm.func @consistent_nocapture_offset() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.alloca %0 x !llvm.array<4 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_consistent_nocapture_offset   : consistent_nocapture_offset_before  ⊑  consistent_nocapture_offset_combined := by
  unfold consistent_nocapture_offset_before consistent_nocapture_offset_combined
  simp_alive_peephole
  sorry
def consistent_nocapture_through_global_combined := [llvmfunc|
  llvm.func @consistent_nocapture_through_global() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.alloca %0 x !llvm.array<4 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_consistent_nocapture_through_global   : consistent_nocapture_through_global_before  ⊑  consistent_nocapture_through_global_combined := by
  unfold consistent_nocapture_through_global_before consistent_nocapture_through_global_combined
  simp_alive_peephole
  sorry
def select_alloca_unrelated_ptr_combined := [llvmfunc|
  llvm.func @select_alloca_unrelated_ptr(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %arg1 : !llvm.ptr
    %3 = llvm.select %arg0, %1, %arg2 : i1, !llvm.ptr
    %4 = llvm.icmp "eq" %3, %arg1 : !llvm.ptr
    llvm.call @witness(%2, %4) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_select_alloca_unrelated_ptr   : select_alloca_unrelated_ptr_before  ⊑  select_alloca_unrelated_ptr_combined := by
  unfold select_alloca_unrelated_ptr_before select_alloca_unrelated_ptr_combined
  simp_alive_peephole
  sorry
def alloca_offset_icmp_combined := [llvmfunc|
  llvm.func @alloca_offset_icmp(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg1, %0 : i32
    llvm.call @witness(%1, %2) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_alloca_offset_icmp   : alloca_offset_icmp_before  ⊑  alloca_offset_icmp_combined := by
  unfold alloca_offset_icmp_before alloca_offset_icmp_combined
  simp_alive_peephole
  sorry
