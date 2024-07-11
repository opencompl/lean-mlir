import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-07-09-SubAndError
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
