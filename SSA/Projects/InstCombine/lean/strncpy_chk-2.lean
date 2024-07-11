import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncpy_chk-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify_before := [llvmfunc|
  llvm.func @test_no_simplify() {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi16>) : !llvm.array<60 x i16>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.constant(60 : i32) : i32
    %7 = llvm.call @__strncpy_chk(%2, %5, %6, %6) : (!llvm.ptr, !llvm.ptr, i32, i32) -> i16
    llvm.return
  }]

def test_no_simplify_combined := [llvmfunc|
  llvm.func @test_no_simplify() {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi16>) : !llvm.array<60 x i16>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.constant(60 : i32) : i32
    %7 = llvm.call @__strncpy_chk(%2, %5, %6, %6) : (!llvm.ptr, !llvm.ptr, i32, i32) -> i16
    llvm.return
  }]

theorem inst_combine_test_no_simplify   : test_no_simplify_before  ⊑  test_no_simplify_combined := by
  unfold test_no_simplify_before test_no_simplify_combined
  simp_alive_peephole
  sorry
