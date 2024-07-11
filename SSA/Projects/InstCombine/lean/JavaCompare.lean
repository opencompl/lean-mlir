import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  JavaCompare
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def le_before := [llvmfunc|
  llvm.func @le(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i32
    %7 = llvm.icmp "sle" %6, %1 : i32
    llvm.return %7 : i1
  }]

def le_combined := [llvmfunc|
  llvm.func @le(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_le   : le_before  ⊑  le_combined := by
  unfold le_before le_combined
  simp_alive_peephole
  sorry
