import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-12-17-SRemNegConstVec
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[2, -2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.srem %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.srem %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
