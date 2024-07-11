import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr69059
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pr69059_before := [llvmfunc|
  llvm.func @pr69059() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @labs(%0) : (i32) -> i64
    llvm.return %1 : i64
  }]

def pr69059_combined := [llvmfunc|
  llvm.func @pr69059() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @labs(%0) : (i32) -> i64
    llvm.return %1 : i64
  }]

theorem inst_combine_pr69059   : pr69059_before  ⊑  pr69059_combined := by
  unfold pr69059_before pr69059_combined
  simp_alive_peephole
  sorry
