import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  threadlocal_address
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_increase_alignment_before := [llvmfunc|
  llvm.func @func_increase_alignment() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.addressof @tlsvar_a4 : !llvm.ptr
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = "llvm.intr.threadlocal.address"(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %2, %3 {alignment = 2 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def func_add_alignment_before := [llvmfunc|
  llvm.func @func_add_alignment() -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.addressof @tlsvar_a32 : !llvm.ptr
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = "llvm.intr.threadlocal.address"(%1) : (!llvm.ptr) -> !llvm.ptr
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    llvm.return %7 : i1
  }]

def func_dont_reduce_alignment_before := [llvmfunc|
  llvm.func @func_dont_reduce_alignment() -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.addressof @tlsvar_a1 : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = "llvm.intr.threadlocal.address"(%1) : (!llvm.ptr) -> !llvm.ptr
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.icmp "eq" %6, %3 : i32
    llvm.return %7 : i1
  }]

def func_increase_alignment_combined := [llvmfunc|
  llvm.func @func_increase_alignment() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.addressof @tlsvar_a4 : !llvm.ptr
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = "llvm.intr.threadlocal.address"(%1) : (!llvm.ptr) -> !llvm.ptr
    llvm.store %2, %3 {alignment = 2 : i64} : i32, !llvm.ptr]

theorem inst_combine_func_increase_alignment   : func_increase_alignment_before  ⊑  func_increase_alignment_combined := by
  unfold func_increase_alignment_before func_increase_alignment_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_func_increase_alignment   : func_increase_alignment_before  ⊑  func_increase_alignment_combined := by
  unfold func_increase_alignment_before func_increase_alignment_combined
  simp_alive_peephole
  sorry
def func_add_alignment_combined := [llvmfunc|
  llvm.func @func_add_alignment() -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.addressof @tlsvar_a32 : !llvm.ptr
    %2 = llvm.mlir.constant(31 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = "llvm.intr.threadlocal.address"(%1) : (!llvm.ptr) -> !llvm.ptr
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    %6 = llvm.and %5, %2  : i64
    %7 = llvm.icmp "eq" %6, %3 : i64
    llvm.return %7 : i1
  }]

theorem inst_combine_func_add_alignment   : func_add_alignment_before  ⊑  func_add_alignment_combined := by
  unfold func_add_alignment_before func_add_alignment_combined
  simp_alive_peephole
  sorry
def func_dont_reduce_alignment_combined := [llvmfunc|
  llvm.func @func_dont_reduce_alignment() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_func_dont_reduce_alignment   : func_dont_reduce_alignment_before  ⊑  func_dont_reduce_alignment_combined := by
  unfold func_dont_reduce_alignment_before func_dont_reduce_alignment_combined
  simp_alive_peephole
  sorry
