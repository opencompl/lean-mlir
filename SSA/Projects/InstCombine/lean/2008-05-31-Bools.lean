import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-05-31-Bools
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo1_before := [llvmfunc|
  llvm.func @foo1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

def foo2_before := [llvmfunc|
  llvm.func @foo2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mul %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

def foo3_before := [llvmfunc|
  llvm.func @foo3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

def foo4_before := [llvmfunc|
  llvm.func @foo4(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

def foo1_combined := [llvmfunc|
  llvm.func @foo1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_foo1   : foo1_before  ⊑  foo1_combined := by
  unfold foo1_before foo1_combined
  simp_alive_peephole
  sorry
def foo2_combined := [llvmfunc|
  llvm.func @foo2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_foo2   : foo2_before  ⊑  foo2_combined := by
  unfold foo2_before foo2_combined
  simp_alive_peephole
  sorry
def foo3_combined := [llvmfunc|
  llvm.func @foo3(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_foo3   : foo3_before  ⊑  foo3_combined := by
  unfold foo3_before foo3_combined
  simp_alive_peephole
  sorry
def foo4_combined := [llvmfunc|
  llvm.func @foo4(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_foo4   : foo4_before  ⊑  foo4_combined := by
  unfold foo4_before foo4_combined
  simp_alive_peephole
  sorry
