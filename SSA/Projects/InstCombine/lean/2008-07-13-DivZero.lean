import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-07-13-DivZero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.icmp "ne" %arg1, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    %4 = llvm.call @b(%3) : (i32) -> i32
    %5 = llvm.udiv %arg0, %3  : i32
    llvm.return %5 : i32
  }]

def a_combined := [llvmfunc|
  llvm.func @a(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.icmp "eq" %arg1, %0 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.call @b(%4) : (i32) -> i32
    %6 = llvm.lshr %arg0, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
