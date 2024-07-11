import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  call_nonnull_arg
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "eq" %arg1, %1 : i32
    llvm.cond_br %3, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.call @dummy(%arg0, %arg1) : (!llvm.ptr, i32) -> ()
    llvm.return
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.unreachable
  }]

def deduce_nonnull_from_another_call_before := [llvmfunc|
  llvm.func @deduce_nonnull_from_another_call(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    llvm.call @bar(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @baz(%arg1, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def deduce_nonnull_from_another_call2_before := [llvmfunc|
  llvm.func @deduce_nonnull_from_another_call2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    llvm.call @bar_without_noundef(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @baz(%arg1, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "eq" %arg1, %1 : i32
    llvm.cond_br %3, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.call @dummy(%arg0, %arg1) : (!llvm.ptr, i32) -> ()
    llvm.return
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.unreachable
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def deduce_nonnull_from_another_call_combined := [llvmfunc|
  llvm.func @deduce_nonnull_from_another_call(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    llvm.call @bar(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @baz(%arg1, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_deduce_nonnull_from_another_call   : deduce_nonnull_from_another_call_before  ⊑  deduce_nonnull_from_another_call_combined := by
  unfold deduce_nonnull_from_another_call_before deduce_nonnull_from_another_call_combined
  simp_alive_peephole
  sorry
def deduce_nonnull_from_another_call2_combined := [llvmfunc|
  llvm.func @deduce_nonnull_from_another_call2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    llvm.call @bar_without_noundef(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.call @baz(%arg1, %arg1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_deduce_nonnull_from_another_call2   : deduce_nonnull_from_another_call2_before  ⊑  deduce_nonnull_from_another_call2_combined := by
  unfold deduce_nonnull_from_another_call2_before deduce_nonnull_from_another_call2_combined
  simp_alive_peephole
  sorry
