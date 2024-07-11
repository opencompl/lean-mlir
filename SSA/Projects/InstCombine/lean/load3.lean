import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %3 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %5 = llvm.sub %2, %4  : i32
    llvm.return %5 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() -> f32 {
    %0 = llvm.mlir.constant("XYZ\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> f32]

    llvm.return %2 : f32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(29826161 : i32) : i32
    %2 = llvm.mlir.constant(dense<[1, 2, 0, 100, 3, 4, 0, -7, 4, 4, 8, 8, 1, 3, 8, 3, 4, -2, 2, 8, 83, 77, 8, 17, 77, 88, 22, 33, 44, 88, 77, 4, 4, 7, -7, -8]> : tensor<36xi32>) : !llvm.array<36 x i32>
    %3 = llvm.mlir.addressof @expect32 : !llvm.ptr
    %4 = llvm.getelementptr %3[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<36 x i32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(dense<0> : tensor<36xi32>) : !llvm.array<36 x i32>
    %7 = llvm.mlir.addressof @rslts32 : !llvm.ptr
    %8 = llvm.getelementptr %7[%1, %0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<36 x i32>
    %9 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %9, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() -> f32 {
    %0 = llvm.mlir.constant(8.29724515E-39 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : tensor<36xi32>) : !llvm.array<36 x i32>
    %3 = llvm.mlir.addressof @rslts32 : !llvm.ptr
    llvm.store %0, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
