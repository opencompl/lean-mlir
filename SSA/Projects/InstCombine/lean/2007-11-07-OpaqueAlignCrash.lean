import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-11-07-OpaqueAlignCrash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.addressof @h : !llvm.ptr
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.zext %2 : i8 to i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.addressof @h : !llvm.ptr
    %2 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %4 = llvm.zext %2 : i8 to i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
