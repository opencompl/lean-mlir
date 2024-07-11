import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-02-16-SDivOverflow2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def i_before := [llvmfunc|
  llvm.func @i(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    %2 = llvm.sdiv %1, %0  : i8
    llvm.return %2 : i8
  }]

def i_combined := [llvmfunc|
  llvm.func @i(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(9 : i8) : i8
    %1 = llvm.sdiv %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_i   : i_before  ⊑  i_combined := by
  unfold i_before i_combined
  simp_alive_peephole
  sorry
