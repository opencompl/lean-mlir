import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncat-3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_nosimplify1_before := [llvmfunc|
  llvm.func @test_nosimplify1() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(13 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> i16
    llvm.return
  }]

def test_nosimplify1_combined := [llvmfunc|
  llvm.func @test_nosimplify1() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %4 = llvm.mlir.addressof @hello : !llvm.ptr
    %5 = llvm.mlir.constant(13 : i32) : i32
    %6 = llvm.call @strncat(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> i16
    llvm.return
  }]

theorem inst_combine_test_nosimplify1   : test_nosimplify1_before  ⊑  test_nosimplify1_combined := by
  unfold test_nosimplify1_before test_nosimplify1_combined
  simp_alive_peephole
  sorry
