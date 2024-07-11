import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  stack-overalign
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %3 = llvm.mlir.addressof @dst : !llvm.ptr
    %4 = llvm.mlir.constant(1024 : i32) : i32
    %5 = llvm.alloca %0 x !llvm.array<1024 x i8> {alignment = 64 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%3, %5, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.call @frob(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<1024xi8>) : !llvm.array<1024 x i8>
    %3 = llvm.mlir.addressof @dst : !llvm.ptr
    %4 = llvm.mlir.constant(1024 : i32) : i32
    %5 = llvm.alloca %0 x !llvm.array<1024 x i8> {alignment = 64 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    "llvm.intr.memcpy"(%3, %5, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    llvm.call @frob(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
