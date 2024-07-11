import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr31990_wrong_memcpy
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.call @bar(%3) : (!llvm.ptr) -> ()
    "llvm.intr.memcpy"(%3, %2, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.call @gaz(%3) : (!llvm.ptr) -> ()
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%2) : (!llvm.ptr) -> ()
    llvm.store %1, %2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    llvm.call @gaz(%2) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
