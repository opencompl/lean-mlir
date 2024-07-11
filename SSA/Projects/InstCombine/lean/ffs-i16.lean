import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ffs-i16
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_ffs_before := [llvmfunc|
  llvm.func @fold_ffs(%arg0: i16) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.call @ffs(%0) : (i16) -> i16
    llvm.call @sink(%2) : (i16) -> ()
    %3 = llvm.call @ffs(%1) : (i16) -> i16
    llvm.call @sink(%3) : (i16) -> ()
    %4 = llvm.call @ffs(%arg0) : (i16) -> i16
    llvm.call @sink(%4) : (i16) -> ()
    llvm.return
  }]

def fold_ffs_combined := [llvmfunc|
  llvm.func @fold_ffs(%arg0: i16) {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    llvm.call @sink(%0) : (i16) -> ()
    llvm.call @sink(%1) : (i16) -> ()
    %2 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i16) -> i16]

theorem inst_combine_fold_ffs   : fold_ffs_before  ⊑  fold_ffs_combined := by
  unfold fold_ffs_before fold_ffs_combined
  simp_alive_peephole
  sorry
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i16
    %4 = llvm.icmp "eq" %arg0, %0 : i16
    %5 = llvm.select %4, %0, %3 : i1, i16
    llvm.call @sink(%5) : (i16) -> ()
    llvm.return
  }]

theorem inst_combine_fold_ffs   : fold_ffs_before  ⊑  fold_ffs_combined := by
  unfold fold_ffs_before fold_ffs_combined
  simp_alive_peephole
  sorry
