import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-02-23-PhiFoldInfLoop
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ggenorien_before := [llvmfunc|
  llvm.func @ggenorien() {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.icmp "eq" %0, %0 : !llvm.ptr
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.cond_br %2, ^bb5(%1 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%1 : i32)
  ^bb4(%5: i32):  // 2 preds: ^bb3, ^bb5
    %6 = llvm.add %5, %3  : i32
    llvm.br ^bb5(%6 : i32)
  ^bb5(%7: i32):  // 2 preds: ^bb2, ^bb4
    llvm.br ^bb4(%7 : i32)
  }]

def ggenorien_combined := [llvmfunc|
  llvm.func @ggenorien() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.cond_br %2, ^bb5(%1 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%3 : i32)
  ^bb4(%5: i32):  // 2 preds: ^bb3, ^bb5
    %6 = llvm.add %5, %4  : i32
    llvm.br ^bb5(%6 : i32)
  ^bb5(%7: i32):  // 2 preds: ^bb2, ^bb4
    llvm.br ^bb4(%7 : i32)
  }]

theorem inst_combine_ggenorien   : ggenorien_before  ⊑  ggenorien_combined := by
  unfold ggenorien_before ggenorien_combined
  simp_alive_peephole
  sorry
