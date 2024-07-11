import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-10-20-mask
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.trunc %arg1 : i64 to i32
    %2 = llvm.and %0, %1  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = llvm.and %arg0, %arg1  : i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
