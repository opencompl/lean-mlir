import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-load-call
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.call @test2() : () -> ()
    %2 = llvm.select %arg0, %arg1, %1 : i1, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %3 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i1, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.call @test2() : () -> ()
    llvm.return %0 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
