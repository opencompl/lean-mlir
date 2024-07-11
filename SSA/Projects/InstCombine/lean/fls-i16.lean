import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fls-i16
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_fls_before := [llvmfunc|
  llvm.func @fold_fls(%arg0: i16) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.call @fls(%0) : (i16) -> i16
    llvm.call @sink(%2) : (i16) -> ()
    %3 = llvm.call @fls(%1) : (i16) -> i16
    llvm.call @sink(%3) : (i16) -> ()
    %4 = llvm.call @fls(%arg0) : (i16) -> i16
    llvm.call @sink(%4) : (i16) -> ()
    llvm.return
  }]

def fold_fls_combined := [llvmfunc|
  llvm.func @fold_fls(%arg0: i16) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(16 : i16) : i16
    llvm.call @sink(%0) : (i16) -> ()
    llvm.call @sink(%1) : (i16) -> ()
    %3 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i16) -> i16
    %4 = llvm.sub %2, %3 overflow<nsw, nuw>  : i16
    llvm.call @sink(%4) : (i16) -> ()
    llvm.return
  }]

theorem inst_combine_fold_fls   : fold_fls_before  ⊑  fold_fls_combined := by
  unfold fold_fls_before fold_fls_combined
  simp_alive_peephole
  sorry
