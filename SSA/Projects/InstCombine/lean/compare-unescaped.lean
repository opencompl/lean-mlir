import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  compare-unescaped
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def compare_global_trivialeq_before := [llvmfunc|
  llvm.func @compare_global_trivialeq() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }]

def compare_global_trivialne_before := [llvmfunc|
  llvm.func @compare_global_trivialne() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.icmp "ne" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }]

def compare_and_call_with_deopt_before := [llvmfunc|
  llvm.func @compare_and_call_with_deopt() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.icmp "eq" %4, %3 : !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %5 : i1
  }]

def compare_ne_and_call_with_deopt_before := [llvmfunc|
  llvm.func @compare_ne_and_call_with_deopt() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %5 : i1
  }]

def compare_ne_global_maybe_null_before := [llvmfunc|
  llvm.func @compare_ne_global_maybe_null() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %5 : i1
  }]

def compare_and_call_after_before := [llvmfunc|
  llvm.func @compare_and_call_after() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %5 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %6 = llvm.icmp "eq" %4, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @escape(%4) : (!llvm.ptr) -> ()
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %6 : i1
  }]

def compare_distinct_mallocs_before := [llvmfunc|
  llvm.func @compare_distinct_mallocs() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }]

def compare_samepointer_under_bitcast_before := [llvmfunc|
  llvm.func @compare_samepointer_under_bitcast() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %1 : !llvm.ptr
    llvm.return %2 : i1
  }]

def compare_samepointer_escaped_before := [llvmfunc|
  llvm.func @compare_samepointer_escaped() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %1 : !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %2 : i1
  }]

def compare_ret_escape_before := [llvmfunc|
  llvm.func @compare_ret_escape(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %arg0 : !llvm.ptr
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // 2 preds: ^bb0, ^bb2
    llvm.return %3 : !llvm.ptr
  ^bb2:  // pred: ^bb0
    %6 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %7 = llvm.icmp "eq" %3, %6 : !llvm.ptr
    llvm.cond_br %7, ^bb1, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return %4 : !llvm.ptr
  }]

def compare_distinct_pointer_escape_before := [llvmfunc|
  llvm.func @compare_distinct_pointer_escape() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @f() : () -> ()
    %3 = llvm.icmp "ne" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }]

def ptrtoint_single_cmp_before := [llvmfunc|
  llvm.func @ptrtoint_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def offset_single_cmp_before := [llvmfunc|
  llvm.func @offset_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %5 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    llvm.return %5 : i1
  }]

def neg_consistent_fold1_before := [llvmfunc|
  llvm.func @neg_consistent_fold1() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %5 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %6 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }]

def neg_consistent_fold2_before := [llvmfunc|
  llvm.func @neg_consistent_fold2() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %5 = llvm.call @hidden_offset(%3) : (!llvm.ptr) -> !llvm.ptr
    %6 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    %7 = llvm.icmp "eq" %2, %5 : !llvm.ptr
    llvm.call @witness(%6, %7) : (i1, i1) -> ()
    llvm.return
  }]

def neg_consistent_fold3_before := [llvmfunc|
  llvm.func @neg_consistent_fold3() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %7 = llvm.icmp "eq" %3, %5 : !llvm.ptr
    llvm.call @witness(%6, %7) : (i1, i1) -> ()
    llvm.return
  }]

def neg_consistent_fold4_before := [llvmfunc|
  llvm.func @neg_consistent_fold4() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }]

def consistent_nocapture_inttoptr_before := [llvmfunc|
  llvm.func @consistent_nocapture_inttoptr() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    %3 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def consistent_nocapture_offset_before := [llvmfunc|
  llvm.func @consistent_nocapture_offset() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %5 = llvm.icmp "eq" %2, %4 : !llvm.ptr
    llvm.return %5 : i1
  }]

def consistent_nocapture_through_global_before := [llvmfunc|
  llvm.func @consistent_nocapture_through_global() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%3) : (!llvm.ptr) -> ()
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.return %5 : i1
  }]

def two_nonnull_mallocs_before := [llvmfunc|
  llvm.func @two_nonnull_mallocs() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }]

def two_nonnull_mallocs2_before := [llvmfunc|
  llvm.func @two_nonnull_mallocs2() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    %3 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.return %3 : i1
  }]

def two_nonnull_mallocs_hidden_before := [llvmfunc|
  llvm.func @two_nonnull_mallocs_hidden() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %5 = llvm.getelementptr %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %6 = llvm.getelementptr %4[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %7 = llvm.icmp "eq" %5, %6 : !llvm.ptr
    llvm.return %7 : i1
  }]

def compare_global_trivialeq_combined := [llvmfunc|
  llvm.func @compare_global_trivialeq() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_compare_global_trivialeq   : compare_global_trivialeq_before  ⊑  compare_global_trivialeq_combined := by
  unfold compare_global_trivialeq_before compare_global_trivialeq_combined
  simp_alive_peephole
  sorry
def compare_global_trivialne_combined := [llvmfunc|
  llvm.func @compare_global_trivialne() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_compare_global_trivialne   : compare_global_trivialne_before  ⊑  compare_global_trivialne_combined := by
  unfold compare_global_trivialne_before compare_global_trivialne_combined
  simp_alive_peephole
  sorry
def compare_and_call_with_deopt_combined := [llvmfunc|
  llvm.func @compare_and_call_with_deopt() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_compare_and_call_with_deopt   : compare_and_call_with_deopt_before  ⊑  compare_and_call_with_deopt_combined := by
  unfold compare_and_call_with_deopt_before compare_and_call_with_deopt_combined
  simp_alive_peephole
  sorry
def compare_ne_and_call_with_deopt_combined := [llvmfunc|
  llvm.func @compare_ne_and_call_with_deopt() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_compare_ne_and_call_with_deopt   : compare_ne_and_call_with_deopt_before  ⊑  compare_ne_and_call_with_deopt_combined := by
  unfold compare_ne_and_call_with_deopt_before compare_ne_and_call_with_deopt_combined
  simp_alive_peephole
  sorry
def compare_ne_global_maybe_null_combined := [llvmfunc|
  llvm.func @compare_ne_global_maybe_null() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.icmp "ne" %4, %3 : !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %5 : i1
  }]

theorem inst_combine_compare_ne_global_maybe_null   : compare_ne_global_maybe_null_before  ⊑  compare_ne_global_maybe_null_combined := by
  unfold compare_ne_global_maybe_null_before compare_ne_global_maybe_null_combined
  simp_alive_peephole
  sorry
def compare_and_call_after_combined := [llvmfunc|
  llvm.func @compare_and_call_after() -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %5 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %6 = llvm.icmp "eq" %4, %5 : !llvm.ptr
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @escape(%4) : (!llvm.ptr) -> ()
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %6 : i1
  }]

theorem inst_combine_compare_and_call_after   : compare_and_call_after_before  ⊑  compare_and_call_after_combined := by
  unfold compare_and_call_after_before compare_and_call_after_combined
  simp_alive_peephole
  sorry
def compare_distinct_mallocs_combined := [llvmfunc|
  llvm.func @compare_distinct_mallocs() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_compare_distinct_mallocs   : compare_distinct_mallocs_before  ⊑  compare_distinct_mallocs_combined := by
  unfold compare_distinct_mallocs_before compare_distinct_mallocs_combined
  simp_alive_peephole
  sorry
def compare_samepointer_under_bitcast_combined := [llvmfunc|
  llvm.func @compare_samepointer_under_bitcast() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_compare_samepointer_under_bitcast   : compare_samepointer_under_bitcast_before  ⊑  compare_samepointer_under_bitcast_combined := by
  unfold compare_samepointer_under_bitcast_before compare_samepointer_under_bitcast_combined
  simp_alive_peephole
  sorry
def compare_samepointer_escaped_combined := [llvmfunc|
  llvm.func @compare_samepointer_escaped() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_compare_samepointer_escaped   : compare_samepointer_escaped_before  ⊑  compare_samepointer_escaped_combined := by
  unfold compare_samepointer_escaped_before compare_samepointer_escaped_combined
  simp_alive_peephole
  sorry
def compare_ret_escape_combined := [llvmfunc|
  llvm.func @compare_ret_escape(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %5 = llvm.icmp "eq" %4, %arg0 : !llvm.ptr
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // 2 preds: ^bb0, ^bb2
    llvm.return %3 : !llvm.ptr
  ^bb2:  // pred: ^bb0
    %6 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.icmp "eq" %3, %6 : !llvm.ptr
    llvm.cond_br %7, ^bb1, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_compare_ret_escape   : compare_ret_escape_before  ⊑  compare_ret_escape_combined := by
  unfold compare_ret_escape_before compare_ret_escape_combined
  simp_alive_peephole
  sorry
def compare_distinct_pointer_escape_combined := [llvmfunc|
  llvm.func @compare_distinct_pointer_escape() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @f() : () -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_compare_distinct_pointer_escape   : compare_distinct_pointer_escape_before  ⊑  compare_distinct_pointer_escape_combined := by
  unfold compare_distinct_pointer_escape_before compare_distinct_pointer_escape_combined
  simp_alive_peephole
  sorry
def ptrtoint_single_cmp_combined := [llvmfunc|
  llvm.func @ptrtoint_single_cmp() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
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
def neg_consistent_fold1_combined := [llvmfunc|
  llvm.func @neg_consistent_fold1() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %5 = llvm.icmp "eq" %3, %2 : !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_neg_consistent_fold1   : neg_consistent_fold1_before  ⊑  neg_consistent_fold1_combined := by
  unfold neg_consistent_fold1_before neg_consistent_fold1_combined
  simp_alive_peephole
  sorry
def neg_consistent_fold2_combined := [llvmfunc|
  llvm.func @neg_consistent_fold2() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.call @hidden_offset(%2) : (!llvm.ptr) -> !llvm.ptr
    %5 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    %6 = llvm.icmp "eq" %1, %4 : !llvm.ptr
    llvm.call @witness(%5, %6) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_neg_consistent_fold2   : neg_consistent_fold2_before  ⊑  neg_consistent_fold2_combined := by
  unfold neg_consistent_fold2_before neg_consistent_fold2_combined
  simp_alive_peephole
  sorry
def neg_consistent_fold3_combined := [llvmfunc|
  llvm.func @neg_consistent_fold3() {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.addressof @gp : !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.call @hidden_inttoptr() : () -> !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %7 = llvm.icmp "eq" %3, %5 : !llvm.ptr
    llvm.call @witness(%6, %7) : (i1, i1) -> ()
    llvm.return
  }]

theorem inst_combine_neg_consistent_fold3   : neg_consistent_fold3_before  ⊑  neg_consistent_fold3_combined := by
  unfold neg_consistent_fold3_before neg_consistent_fold3_combined
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
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(2048 : i64) : i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%3) : (!llvm.ptr) -> ()
    %4 = llvm.icmp "eq" %3, %2 : !llvm.ptr
    llvm.return %4 : i1
  }]

theorem inst_combine_consistent_nocapture_inttoptr   : consistent_nocapture_inttoptr_before  ⊑  consistent_nocapture_inttoptr_combined := by
  unfold consistent_nocapture_inttoptr_before consistent_nocapture_inttoptr_combined
  simp_alive_peephole
  sorry
def consistent_nocapture_offset_combined := [llvmfunc|
  llvm.func @consistent_nocapture_offset() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_consistent_nocapture_offset   : consistent_nocapture_offset_before  ⊑  consistent_nocapture_offset_combined := by
  unfold consistent_nocapture_offset_before consistent_nocapture_offset_combined
  simp_alive_peephole
  sorry
def consistent_nocapture_through_global_combined := [llvmfunc|
  llvm.func @consistent_nocapture_through_global() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_consistent_nocapture_through_global   : consistent_nocapture_through_global_before  ⊑  consistent_nocapture_through_global_combined := by
  unfold consistent_nocapture_through_global_before consistent_nocapture_through_global_combined
  simp_alive_peephole
  sorry
def two_nonnull_mallocs_combined := [llvmfunc|
  llvm.func @two_nonnull_mallocs() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_two_nonnull_mallocs   : two_nonnull_mallocs_before  ⊑  two_nonnull_mallocs_combined := by
  unfold two_nonnull_mallocs_before two_nonnull_mallocs_combined
  simp_alive_peephole
  sorry
def two_nonnull_mallocs2_combined := [llvmfunc|
  llvm.func @two_nonnull_mallocs2() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    llvm.call @unknown(%2) : (!llvm.ptr) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_two_nonnull_mallocs2   : two_nonnull_mallocs2_before  ⊑  two_nonnull_mallocs2_combined := by
  unfold two_nonnull_mallocs2_before two_nonnull_mallocs2_combined
  simp_alive_peephole
  sorry
def two_nonnull_mallocs_hidden_combined := [llvmfunc|
  llvm.func @two_nonnull_mallocs_hidden() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %5 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.getelementptr inbounds %4[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.icmp "eq" %5, %6 : !llvm.ptr
    llvm.return %7 : i1
  }]

theorem inst_combine_two_nonnull_mallocs_hidden   : two_nonnull_mallocs_hidden_before  ⊑  two_nonnull_mallocs_hidden_combined := by
  unfold two_nonnull_mallocs_hidden_before two_nonnull_mallocs_hidden_combined
  simp_alive_peephole
  sorry
