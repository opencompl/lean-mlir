import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  preserve-sminmax
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sdiv %arg0, %0  : i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
