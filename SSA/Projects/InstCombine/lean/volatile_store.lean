import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  volatile_store
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def self_assign_1_before := [llvmfunc|
  llvm.func @self_assign_1() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @x : !llvm.ptr
    %2 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store volatile %2, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def volatile_store_before_unreachable_before := [llvmfunc|
  llvm.func @volatile_store_before_unreachable(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store volatile %0, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def self_assign_1_combined := [llvmfunc|
  llvm.func @self_assign_1() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @x : !llvm.ptr
    %2 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store volatile %2, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_self_assign_1   : self_assign_1_before  ⊑  self_assign_1_combined := by
  unfold self_assign_1_before self_assign_1_combined
  simp_alive_peephole
  sorry
def volatile_store_before_unreachable_combined := [llvmfunc|
  llvm.func @volatile_store_before_unreachable(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store volatile %0, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_volatile_store_before_unreachable   : volatile_store_before_unreachable_before  ⊑  volatile_store_before_unreachable_combined := by
  unfold volatile_store_before_unreachable_before volatile_store_before_unreachable_combined
  simp_alive_peephole
  sorry
