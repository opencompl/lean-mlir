import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-10-10-EliminateMemCpy
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("xyz\00") : !llvm.array<4 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %4 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    "llvm.intr.memcpy"(%5, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(2021227008 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
