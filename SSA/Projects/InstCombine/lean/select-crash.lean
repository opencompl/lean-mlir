import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-crash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i1, %arg1: vector<4xf32>, %arg2: vector<4xf32>, %arg3: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg1, %arg2  : vector<4xf32>
    %1 = llvm.fsub %arg1, %arg3  : vector<4xf32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i1, %arg1: vector<4xf32>, %arg2: vector<4xf32>, %arg3: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fneg %arg3  : vector<4xf32>
    %1 = llvm.select %arg0, %arg2, %0 : i1, vector<4xf32>
    %2 = llvm.fadd %1, %arg1  : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
