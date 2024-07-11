import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  weak-symbols
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("y\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @fake_init : !llvm.ptr
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strcmp(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

def bar_before := [llvmfunc|
  llvm.func @bar() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("y\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @real_init : !llvm.ptr
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strcmp(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("y\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @fake_init : !llvm.ptr
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strcmp(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
