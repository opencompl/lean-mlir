import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gep-object-size-less-than-or-equal-typesize
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.vec<? x 1 x  i8>, %arg1: i64) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 1 x  i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %1 {alignment = 1 : i64} : !llvm.vec<? x 1 x  i8>, !llvm.ptr]

    %2 = llvm.getelementptr %1[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %3 : i8
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.vec<? x 1 x  i8>, %arg1: i64) -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.vec<? x 1 x  i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 1 : i64} : !llvm.vec<? x 1 x  i8>, !llvm.ptr
    %2 = llvm.getelementptr %1[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
