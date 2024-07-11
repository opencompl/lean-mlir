import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strlen-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1() -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(187 : i32) : i32
    %3 = llvm.call @strlen(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }]

def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1() -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(187 : i32) : i32
    %3 = llvm.call @strlen(%1, %2) : (!llvm.ptr, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
