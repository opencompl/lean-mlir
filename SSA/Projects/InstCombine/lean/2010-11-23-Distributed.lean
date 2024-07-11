import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2010-11-23-Distributed
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg1, %arg0 overflow<nsw>  : i32
    %1 = llvm.mul %0, %arg1 overflow<nsw>  : i32
    %2 = llvm.mul %arg1, %arg1 overflow<nsw>  : i32
    %3 = llvm.sub %1, %2  : i32
    llvm.return %3 : i32
  }]

def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg1, %arg0  : i64
    %3 = llvm.xor %2, %0  : i64
    %4 = llvm.and %arg1, %3  : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    llvm.return %5 : i1
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: i64, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.xor %arg0, %0  : i64
    %3 = llvm.and %2, %arg1  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
