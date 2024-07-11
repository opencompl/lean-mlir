import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fprintf-wrong-sig
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() -> i32 {
    %0 = llvm.mlir.constant("an error: %d\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @fprintf(%1) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() -> i32 {
    %0 = llvm.mlir.constant("an error: %d\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @fprintf(%1) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
