import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-pr39595
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ugt" %1, %2 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
