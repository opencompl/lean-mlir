import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2003-08-12-AllocaNonNull
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def oof_before := [llvmfunc|
  llvm.func @oof() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.icmp "ne" %3, %1 : !llvm.ptr
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.call @bitmap_clear(%3) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr) -> i32
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

def oof_combined := [llvmfunc|
  llvm.func @oof() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @bitmap_clear(%2) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_oof   : oof_before  ⊑  oof_combined := by
  unfold oof_before oof_combined
  simp_alive_peephole
  sorry
