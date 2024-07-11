import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr43376-getFlippedStrictnessPredicateAndConstant-assert
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def d_before := [llvmfunc|
  llvm.func @d(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(3 : i16) : i16
    %3 = llvm.mlir.constant(-1 : i16) : i16
    %4 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i16]

    %5 = llvm.icmp "ne" %4, %0 : i16
    llvm.cond_br %5, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %6 = llvm.load %arg1 {alignment = 1 : i64} : !llvm.ptr -> i16]

    %7 = llvm.icmp "ult" %6, %0 : i16
    llvm.br ^bb2(%7 : i1)
  ^bb2(%8: i1):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.zext %8 : i1 to i16
    %10 = llvm.mul %9, %2 overflow<nsw>  : i16
    %11 = llvm.xor %10, %3  : i16
    llvm.return %11 : i16
  }]

def d_combined := [llvmfunc|
  llvm.func @d(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i16
    %3 = llvm.icmp "eq" %2, %0 : i16
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i16
  }]

theorem inst_combine_d   : d_before  ⊑  d_combined := by
  unfold d_before d_combined
  simp_alive_peephole
  sorry
