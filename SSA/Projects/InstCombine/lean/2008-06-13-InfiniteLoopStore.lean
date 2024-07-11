import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-06-13-InfiniteLoopStore
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_56_before := [llvmfunc|
  llvm.func @func_56(%arg0: i32) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g_139 : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.zext %4 : i1 to i8
    %6 = llvm.icmp "ne" %5, %3 : i8
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def func_56_combined := [llvmfunc|
  llvm.func @func_56(%arg0: i32) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g_139 : !llvm.ptr
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_func_56   : func_56_before  ⊑  func_56_combined := by
  unfold func_56_before func_56_combined
  simp_alive_peephole
  sorry
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_func_56   : func_56_before  ⊑  func_56_combined := by
  unfold func_56_before func_56_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb1
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_func_56   : func_56_before  ⊑  func_56_combined := by
  unfold func_56_before func_56_combined
  simp_alive_peephole
  sorry
