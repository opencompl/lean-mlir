import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-04-08-SingleEltVectorCrash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bork_before := [llvmfunc|
  llvm.func @bork(%arg0: vector<1xi64>) -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.extractelement %arg0[%0 : i32] : vector<1xi64>
    llvm.return %1 : i64
  }]

def bork_combined := [llvmfunc|
  llvm.func @bork(%arg0: vector<1xi64>) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<1xi64>
    llvm.return %1 : i64
  }]

theorem inst_combine_bork   : bork_before  ⊑  bork_combined := by
  unfold bork_before bork_combined
  simp_alive_peephole
  sorry
