import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-04-30-SRem
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1656690544 : i32) : i32
    %2 = llvm.mlir.constant(24 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.srem %1, %3  : i32
    %5 = llvm.shl %4, %2  : i32
    %6 = llvm.ashr %5, %2  : i32
    llvm.return %6 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1656690544 : i32) : i32
    %2 = llvm.mlir.constant(24 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.srem %1, %3  : i32
    %5 = llvm.shl %4, %2  : i32
    %6 = llvm.ashr %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
