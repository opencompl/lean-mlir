import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-10-11-DivCompareFold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def x_before := [llvmfunc|
  llvm.func @x(%arg0: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(-65536 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def x_combined := [llvmfunc|
  llvm.func @x(%arg0: i32) -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_x   : x_before  ⊑  x_combined := by
  unfold x_before x_combined
  simp_alive_peephole
  sorry
