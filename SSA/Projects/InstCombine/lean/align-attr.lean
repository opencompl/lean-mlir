import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  align-attr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo1_before := [llvmfunc|
  llvm.func @foo1(%arg0: !llvm.ptr {llvm.align = 32 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %0 : i32
  }]

def foo2_before := [llvmfunc|
  llvm.func @foo2(%arg0: !llvm.ptr {llvm.align = 32 : i64}) -> i32 {
    %0 = llvm.call @func1(%arg0) : (!llvm.ptr) -> !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %1 : i32
  }]

def foo1_combined := [llvmfunc|
  llvm.func @foo1(%arg0: !llvm.ptr {llvm.align = 32 : i64}) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_foo1   : foo1_before  ⊑  foo1_combined := by
  unfold foo1_before foo1_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_foo1   : foo1_before  ⊑  foo1_combined := by
  unfold foo1_before foo1_combined
  simp_alive_peephole
  sorry
def foo2_combined := [llvmfunc|
  llvm.func @foo2(%arg0: !llvm.ptr {llvm.align = 32 : i64}) -> i32 {
    %0 = llvm.call @func1(%arg0) : (!llvm.ptr) -> !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_foo2   : foo2_before  ⊑  foo2_combined := by
  unfold foo2_before foo2_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_foo2   : foo2_before  ⊑  foo2_combined := by
  unfold foo2_before foo2_combined
  simp_alive_peephole
  sorry
