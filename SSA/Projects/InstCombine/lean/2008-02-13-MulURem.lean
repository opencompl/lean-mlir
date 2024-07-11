import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-02-13-MulURem
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_before := [llvmfunc|
  llvm.func @fold(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.urem %1, %0  : i32
    llvm.return %2 : i32
  }]

def fold_combined := [llvmfunc|
  llvm.func @fold(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.urem %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fold   : fold_before  ⊑  fold_combined := by
  unfold fold_before fold_combined
  simp_alive_peephole
  sorry
