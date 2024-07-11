import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-06-06-AshrSignBit
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def av_cmp_q_cond_true_before := [llvmfunc|
  llvm.func @av_cmp_q_cond_true(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb2
  ^bb1:  // pred: ^bb2
    llvm.return
  ^bb2:  // pred: ^bb0
    %2 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i64]

    %3 = llvm.zext %0 : i32 to i64
    %4 = llvm.ashr %2, %3  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.or %5, %1  : i32
    llvm.store %6, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %7, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb1
  }]

def av_cmp_q_cond_true_combined := [llvmfunc|
  llvm.func @av_cmp_q_cond_true(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb2
  ^bb1:  // pred: ^bb2
    llvm.return
  ^bb2:  // pred: ^bb0
    %2 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i64
    %3 = llvm.ashr %2, %0  : i64
    %4 = llvm.trunc %3 : i64 to i32
    %5 = llvm.or %4, %1  : i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %5, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  }]

theorem inst_combine_av_cmp_q_cond_true   : av_cmp_q_cond_true_before  ⊑  av_cmp_q_cond_true_combined := by
  unfold av_cmp_q_cond_true_before av_cmp_q_cond_true_combined
  simp_alive_peephole
  sorry
