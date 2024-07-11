import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strcpy_chk-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify_before := [llvmfunc|
  llvm.func @test_no_simplify() {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi16>) : !llvm.array<60 x i16>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("abcdefg\00") : !llvm.array<8 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.call @__strcpy_chk(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> i16
    llvm.return
  }]

def test_no_simplify_combined := [llvmfunc|
  llvm.func @test_no_simplify() {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi16>) : !llvm.array<60 x i16>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant("abcdefg\00") : !llvm.array<8 x i8>
    %4 = llvm.mlir.addressof @".str" : !llvm.ptr
    %5 = llvm.mlir.constant(8 : i32) : i32
    %6 = llvm.call @__strcpy_chk(%2, %4, %5) : (!llvm.ptr, !llvm.ptr, i32) -> i16
    llvm.return
  }]

theorem inst_combine_test_no_simplify   : test_no_simplify_before  ⊑  test_no_simplify_combined := by
  unfold test_no_simplify_before test_no_simplify_combined
  simp_alive_peephole
  sorry
