import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  wcslen-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1() -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1() -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
