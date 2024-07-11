import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  dbg-scalable-store-fixed-frag
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.vec<? x 2 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : !llvm.vec<? x 2 x  i32>, !llvm.ptr]

    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def foo2_before := [llvmfunc|
  llvm.func @foo2(%arg0: !llvm.vec<? x 2 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<4 x i32> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.dbg.declare #di_local_variable1 = %1 : !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : !llvm.vec<? x 2 x  i32>, !llvm.ptr]

    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.vec<? x 2 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.vec<? x 2 x  i32>
    llvm.intr.dbg.value #di_local_variable = %1 : !llvm.vec<? x 2 x  i32>
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %2 {alignment = 4 : i64} : !llvm.vec<? x 2 x  i32>, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def foo2_combined := [llvmfunc|
  llvm.func @foo2(%arg0: !llvm.vec<? x 2 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<4 x i32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable1 = %1 : !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : !llvm.vec<? x 2 x  i32>, !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_foo2   : foo2_before  ⊑  foo2_combined := by
  unfold foo2_before foo2_combined
  simp_alive_peephole
  sorry
