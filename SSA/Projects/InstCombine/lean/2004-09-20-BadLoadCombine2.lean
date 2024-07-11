import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2004-09-20-BadLoadCombine2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %0, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb2(%4 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%3 : !llvm.ptr)
  ^bb2(%5: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %6 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %0, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.select %arg0, %3, %4 : i1, !llvm.ptr
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
