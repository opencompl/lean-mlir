import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-06-16-SRemDemandedBits
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def a_combined := [llvmfunc|
  llvm.func @a(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
