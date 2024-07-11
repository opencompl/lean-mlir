import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-01-27-FloatSelect
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_before := [llvmfunc|
  llvm.func @fold(%arg0: i1, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.select %arg0, %0, %1 : i1, f64
    %3 = llvm.fdiv %arg1, %2  : f64
    llvm.return %3 : f64
  }]

def fold_combined := [llvmfunc|
  llvm.func @fold(%arg0: i1, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.select %arg0, %0, %1 : i1, f64
    %3 = llvm.fdiv %arg1, %2  : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_fold   : fold_before  ⊑  fold_combined := by
  unfold fold_before fold_combined
  simp_alive_peephole
  sorry
