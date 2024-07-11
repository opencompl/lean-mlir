import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcmp-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_nosimplify_before := [llvmfunc|
  llvm.func @test_nosimplify() -> i16 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.call @strcmp(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i16
    llvm.return %4 : i16
  }]

def test_nosimplify_combined := [llvmfunc|
  llvm.func @test_nosimplify() -> i16 {
    %0 = llvm.mlir.constant("hell\00") : !llvm.array<5 x i8>
    %1 = llvm.mlir.addressof @hell : !llvm.ptr
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.call @strcmp(%1, %3) : (!llvm.ptr, !llvm.ptr) -> i16
    llvm.return %4 : i16
  }]

theorem inst_combine_test_nosimplify   : test_nosimplify_before  ⊑  test_nosimplify_combined := by
  unfold test_nosimplify_before test_nosimplify_combined
  simp_alive_peephole
  sorry
