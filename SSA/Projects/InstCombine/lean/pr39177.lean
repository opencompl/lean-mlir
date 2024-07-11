import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr39177
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def __fwrite_alias_before := [llvmfunc|
  llvm.func @__fwrite_alias(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %5 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.store %arg1, %3 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.store %arg2, %4 {alignment = 8 : i64} : i64, !llvm.ptr]

    llvm.store %arg3, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return %1 : i64
  }]

def foo_before := [llvmfunc|
  llvm.func @foo() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @stderr : !llvm.ptr
    %3 = llvm.mlir.constant("crash!\0A\00") : !llvm.array<8 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %7 = llvm.call @fprintf(%6, %4) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

def __fwrite_alias_combined := [llvmfunc|
  llvm.func @__fwrite_alias(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64, %arg3: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine___fwrite_alias   : __fwrite_alias_before  ⊑  __fwrite_alias_combined := by
  unfold __fwrite_alias_before __fwrite_alias_combined
  simp_alive_peephole
  sorry
def foo_combined := [llvmfunc|
  llvm.func @foo() {
    %0 = llvm.mlir.addressof @stderr : !llvm.ptr
    %1 = llvm.mlir.constant("crash!\0A\00") : !llvm.array<8 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    %4 = llvm.call @fprintf(%3, %2) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
