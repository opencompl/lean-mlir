import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strchr-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_nosimplify1_before := [llvmfunc|
  llvm.func @test_nosimplify1() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.addressof @chr : !llvm.ptr
    %5 = llvm.call @strchr(%1, %2) : (!llvm.ptr, i32) -> i8
    llvm.store %5, %4 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def test_nosimplify1_combined := [llvmfunc|
  llvm.func @test_nosimplify1() {
    %0 = llvm.mlir.constant("hello world\\n\00") : !llvm.array<14 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(119 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.addressof @chr : !llvm.ptr
    %5 = llvm.call @strchr(%1, %2) : (!llvm.ptr, i32) -> i8
    llvm.store %5, %4 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_nosimplify1   : test_nosimplify1_before  ⊑  test_nosimplify1_combined := by
  unfold test_nosimplify1_before test_nosimplify1_combined
  simp_alive_peephole
  sorry
