import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-12-18-AddSelCmpSub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %1, %3 : i1, i32
    %6 = llvm.add %5, %arg0  : i32
    %7 = llvm.add %6, %2  : i32
    llvm.return %7 : i32
  }]

def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.add %4, %arg0  : i32
    llvm.return %5 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.intr.smax(%3, %1)  : (i32, i32) -> i32
    %5 = llvm.add %4, %arg0  : i32
    %6 = llvm.add %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.intr.smax(%2, %1)  : (i32, i32) -> i32
    %4 = llvm.add %3, %arg0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
