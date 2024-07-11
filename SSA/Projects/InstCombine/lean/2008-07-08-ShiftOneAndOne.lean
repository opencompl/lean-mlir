import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-07-08-ShiftOneAndOne
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR2330_before := [llvmfunc|
  llvm.func @PR2330(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def PR2330_combined := [llvmfunc|
  llvm.func @PR2330(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR2330   : PR2330_before  ⊑  PR2330_combined := by
  unfold PR2330_before PR2330_combined
  simp_alive_peephole
  sorry
