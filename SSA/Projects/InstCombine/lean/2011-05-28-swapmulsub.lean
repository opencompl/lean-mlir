import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2011-05-28-swapmulsub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo1(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @foo1(%arg0: i32) -> (i16 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %4 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %5 = llvm.sub %0, %4  : i32
    %6 = llvm.mul %5, %1  : i32
    llvm.store %6, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.trunc %7 : i32 to i16
    llvm.return %8 : i16
  }]

def foo2(%arg0: i32, %arg1: i32) -> _before := [llvmfunc|
  llvm.func @foo2(%arg0: i32, %arg1: i32) -> (i16 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %arg1, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %7 = llvm.sub %5, %6  : i32
    %8 = llvm.mul %7, %1  : i32
    llvm.store %8, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %9 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %10 = llvm.trunc %9 : i32 to i16
    llvm.return %10 : i16
  }]

def foo3(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @foo3(%arg0: i32) -> (i16 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(-4 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.mul %6, %2  : i32
    llvm.store %7, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %9 = llvm.trunc %8 : i32 to i16
    llvm.return %9 : i16
  }]

def foo1(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @foo1(%arg0: i32) -> (i16 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-2 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.shl %2, %0  : i16
    %4 = llvm.add %3, %1  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_foo1(%arg0: i32) ->    : foo1(%arg0: i32) -> _before  ⊑  foo1(%arg0: i32) -> _combined := by
  unfold foo1(%arg0: i32) -> _before foo1(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def foo2(%arg0: i32, %arg1: i32) -> _combined := [llvmfunc|
  llvm.func @foo2(%arg0: i32, %arg1: i32) -> (i16 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.trunc %1 : i32 to i16
    %3 = llvm.shl %2, %0  : i16
    llvm.return %3 : i16
  }]

theorem inst_combine_foo2(%arg0: i32, %arg1: i32) ->    : foo2(%arg0: i32, %arg1: i32) -> _before  ⊑  foo2(%arg0: i32, %arg1: i32) -> _combined := by
  unfold foo2(%arg0: i32, %arg1: i32) -> _before foo2(%arg0: i32, %arg1: i32) -> _combined
  simp_alive_peephole
  sorry
def foo3(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @foo3(%arg0: i32) -> (i16 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(-28 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.shl %2, %0  : i16
    %4 = llvm.add %3, %1  : i16
    llvm.return %4 : i16
  }]

theorem inst_combine_foo3(%arg0: i32) ->    : foo3(%arg0: i32) -> _before  ⊑  foo3(%arg0: i32) -> _combined := by
  unfold foo3(%arg0: i32) -> _before foo3(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
