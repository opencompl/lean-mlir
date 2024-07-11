import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-06-13-ReadOnlyCallStore
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a(%arg0: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

    %2 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

def a_combined := [llvmfunc|
  llvm.func @a(%arg0: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %2 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
