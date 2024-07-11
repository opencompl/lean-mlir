import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strpbrk-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1() -> i8 {
    %0 = llvm.mlir.constant("hello world\00") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant("w\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @w : !llvm.ptr
    %4 = llvm.call @strpbrk(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i8
    llvm.return %4 : i8
  }]

def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1() -> i8 {
    %0 = llvm.mlir.constant("hello world\00") : !llvm.array<12 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant("w\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @w : !llvm.ptr
    %4 = llvm.call @strpbrk(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
