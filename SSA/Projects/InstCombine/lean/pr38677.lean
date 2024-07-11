import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr38677
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.addressof @A : !llvm.ptr
    %3 = llvm.mlir.addressof @B : !llvm.ptr
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(2147483647 : i32) : i32
    %7 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %1, ^bb2(%0 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    %8 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    llvm.br ^bb2(%8 : i1)
  ^bb2(%9: i1):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.select %9, %4, %5 : i1, i32
    %11 = llvm.mul %10, %6  : i32
    %12 = llvm.icmp "ule" %11, %7 : i32
    llvm.store %12, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %10 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.store %1, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %2 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
