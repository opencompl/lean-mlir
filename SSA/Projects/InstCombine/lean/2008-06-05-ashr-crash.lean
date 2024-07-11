import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-06-05-ashr-crash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i65) -> i65 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(65 : i65) : i65
    %1 = llvm.ashr %arg0, %0  : i65
    llvm.return %1 : i65
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i65) -> i65 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.poison : i65
    llvm.return %0 : i65
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
