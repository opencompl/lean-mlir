import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strlen-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def strlen_before := [llvmfunc|
  llvm.func @strlen(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i64
    llvm.return %0 : i64
  }]

def strlen_combined := [llvmfunc|
  llvm.func @strlen(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_strlen   : strlen_before  ⊑  strlen_combined := by
  unfold strlen_before strlen_combined
  simp_alive_peephole
  sorry
