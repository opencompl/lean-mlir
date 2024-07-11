import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2010-11-21-SizeZeroTypeGEP
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<()>
    llvm.return %0 : !llvm.ptr
  }]

def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: i64, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.getelementptr %arg1[%arg0, 1, %arg0, 0, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.struct<(struct<()>, array<0 x struct<(array<0 x i8>)>>)>
    llvm.return %2 : !llvm.ptr
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    llvm.return %arg0 : !llvm.ptr
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: i64, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr %arg1[%0, 1, %0, 0, %arg0] : (!llvm.ptr, i64, i64, i64) -> !llvm.ptr, !llvm.struct<(struct<()>, array<0 x struct<(array<0 x i8>)>>)>
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
