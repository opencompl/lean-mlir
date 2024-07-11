import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  addnegneg
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def l_before := [llvmfunc|
  llvm.func @l(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.sub %0, %arg2  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.add %3, %arg3  : i32
    llvm.return %4 : i32
  }]

def l_combined := [llvmfunc|
  llvm.func @l(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.add %arg2, %arg1  : i32
    %1 = llvm.sub %arg3, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_l   : l_before  ⊑  l_combined := by
  unfold l_before l_combined
  simp_alive_peephole
  sorry
