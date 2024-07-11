import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-a-or-b-zero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_or_b_before := [llvmfunc|
  llvm.func @a_or_b(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.icmp "eq" %arg1, %0 : i32
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.or %3, %6  : i1
    llvm.return %7 : i1
  }]

def a_or_b_not_inv_before := [llvmfunc|
  llvm.func @a_or_b_not_inv(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    %6 = llvm.icmp "eq" %arg1, %1 : i32
    %7 = llvm.and %5, %6  : i1
    %8 = llvm.or %4, %7  : i1
    llvm.return %8 : i1
  }]

def a_or_b_const_before := [llvmfunc|
  llvm.func @a_or_b_const(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    %1 = llvm.icmp "ne" %arg1, %arg2 : i32
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "ne" %arg0, %arg2 : i32
    %4 = llvm.icmp "eq" %arg1, %arg2 : i32
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.or %2, %5  : i1
    llvm.return %6 : i1
  }]

def a_or_b_const2_before := [llvmfunc|
  llvm.func @a_or_b_const2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    %1 = llvm.icmp "ne" %arg1, %arg3 : i32
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "ne" %arg0, %arg2 : i32
    %4 = llvm.icmp "eq" %arg1, %arg3 : i32
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.or %2, %5  : i1
    llvm.return %6 : i1
  }]

def a_or_b_nullptr_before := [llvmfunc|
  llvm.func @a_or_b_nullptr(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg1, %0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.icmp "ne" %arg1, %0 : !llvm.ptr
    %5 = llvm.and %1, %4  : i1
    %6 = llvm.and %3, %2  : i1
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }]

def a_or_b_multiple_uses_before := [llvmfunc|
  llvm.func @a_or_b_multiple_uses(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.icmp "eq" %arg1, %0 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.or %3, %6  : i1
    llvm.return %7 : i1
  }]

def a_or_b_multiple_uses_2_before := [llvmfunc|
  llvm.func @a_or_b_multiple_uses_2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.icmp "eq" %arg1, %0 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.call @use(%3) : (i1) -> ()
    %7 = llvm.or %3, %6  : i1
    llvm.return %7 : i1
  }]

def a_or_b_combined := [llvmfunc|
  llvm.func @a_or_b(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.icmp "eq" %arg1, %0 : i32
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.or %3, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_a_or_b   : a_or_b_before  ⊑  a_or_b_combined := by
  unfold a_or_b_before a_or_b_combined
  simp_alive_peephole
  sorry
def a_or_b_not_inv_combined := [llvmfunc|
  llvm.func @a_or_b_not_inv(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.icmp "ne" %arg1, %0 : i32
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    %6 = llvm.icmp "eq" %arg1, %1 : i32
    %7 = llvm.and %5, %6  : i1
    %8 = llvm.or %4, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_a_or_b_not_inv   : a_or_b_not_inv_before  ⊑  a_or_b_not_inv_combined := by
  unfold a_or_b_not_inv_before a_or_b_not_inv_combined
  simp_alive_peephole
  sorry
def a_or_b_const_combined := [llvmfunc|
  llvm.func @a_or_b_const(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    %1 = llvm.icmp "ne" %arg1, %arg2 : i32
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "ne" %arg0, %arg2 : i32
    %4 = llvm.icmp "eq" %arg1, %arg2 : i32
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.or %2, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_a_or_b_const   : a_or_b_const_before  ⊑  a_or_b_const_combined := by
  unfold a_or_b_const_before a_or_b_const_combined
  simp_alive_peephole
  sorry
def a_or_b_const2_combined := [llvmfunc|
  llvm.func @a_or_b_const2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg2 : i32
    %1 = llvm.icmp "ne" %arg1, %arg3 : i32
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "ne" %arg0, %arg2 : i32
    %4 = llvm.icmp "eq" %arg1, %arg3 : i32
    %5 = llvm.and %3, %4  : i1
    %6 = llvm.or %2, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_a_or_b_const2   : a_or_b_const2_before  ⊑  a_or_b_const2_combined := by
  unfold a_or_b_const2_before a_or_b_const2_combined
  simp_alive_peephole
  sorry
def a_or_b_nullptr_combined := [llvmfunc|
  llvm.func @a_or_b_nullptr(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg1, %0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.icmp "ne" %arg1, %0 : !llvm.ptr
    %5 = llvm.and %1, %4  : i1
    %6 = llvm.and %3, %2  : i1
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_a_or_b_nullptr   : a_or_b_nullptr_before  ⊑  a_or_b_nullptr_combined := by
  unfold a_or_b_nullptr_before a_or_b_nullptr_combined
  simp_alive_peephole
  sorry
def a_or_b_multiple_uses_combined := [llvmfunc|
  llvm.func @a_or_b_multiple_uses(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.icmp "eq" %arg1, %0 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.call @use(%6) : (i1) -> ()
    %7 = llvm.or %3, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_a_or_b_multiple_uses   : a_or_b_multiple_uses_before  ⊑  a_or_b_multiple_uses_combined := by
  unfold a_or_b_multiple_uses_before a_or_b_multiple_uses_combined
  simp_alive_peephole
  sorry
def a_or_b_multiple_uses_2_combined := [llvmfunc|
  llvm.func @a_or_b_multiple_uses_2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.and %1, %2  : i1
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.icmp "eq" %arg1, %0 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.call @use(%3) : (i1) -> ()
    %7 = llvm.or %3, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_a_or_b_multiple_uses_2   : a_or_b_multiple_uses_2_before  ⊑  a_or_b_multiple_uses_2_combined := by
  unfold a_or_b_multiple_uses_2_before a_or_b_multiple_uses_2_combined
  simp_alive_peephole
  sorry
