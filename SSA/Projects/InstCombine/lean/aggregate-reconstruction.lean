import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  aggregate-reconstruction
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.array<2 x i32>) -> !llvm.array<2 x i32> {
    %0 = llvm.mlir.undef : !llvm.array<2 x i32>
    %1 = llvm.extractvalue %arg0[0] : !llvm.array<2 x i32> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.array<2 x i32> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.array<2 x i32> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.array<2 x i32> 
    llvm.return %4 : !llvm.array<2 x i32>
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.array<3 x i32>) -> !llvm.array<3 x i32> {
    %0 = llvm.mlir.undef : !llvm.array<3 x i32>
    %1 = llvm.extractvalue %arg0[0] : !llvm.array<3 x i32> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.array<3 x i32> 
    %3 = llvm.extractvalue %arg0[2] : !llvm.array<3 x i32> 
    %4 = llvm.insertvalue %1, %0[0] : !llvm.array<3 x i32> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.array<3 x i32> 
    %6 = llvm.insertvalue %3, %5[2] : !llvm.array<3 x i32> 
    llvm.return %6 : !llvm.array<3 x i32>
  }]

def test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<(i32, i32)>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(struct<(i32, i32)>)>
    %1 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>)> 
    %2 = llvm.extractvalue %arg0[0, 1] : !llvm.struct<(struct<(i32, i32)>)> 
    %3 = llvm.insertvalue %1, %0[0, 0] : !llvm.struct<(struct<(i32, i32)>)> 
    %4 = llvm.insertvalue %2, %3[0, 1] : !llvm.struct<(struct<(i32, i32)>)> 
    llvm.return %4 : !llvm.struct<(struct<(i32, i32)>)>
  }]

def test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<(i32)>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, struct<(i32)>)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, struct<(i32)>)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, struct<(i32)>)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, struct<(i32)>)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, struct<(i32)>)> 
    llvm.return %4 : !llvm.struct<(i32, struct<(i32)>)>
  }]

def negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %arg1, %2[1] : !llvm.struct<(i32, i32)> 
    llvm.return %3 : !llvm.struct<(i32, i32)>
  }]

def negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.insertvalue %0, %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : !llvm.struct<(i32, i32)>
  }]

def negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

def negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

def negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %2[1] : !llvm.struct<(i32, i32)> 
    llvm.return %3 : !llvm.struct<(i32, i32)>
  }]

def negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %2, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

def test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%1) : (i32) -> ()
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%2) : (i32) -> ()
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%3) : (!llvm.struct<(i32, i32)>) -> ()
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

def test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %2, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %1, %3[0] : !llvm.struct<(i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<(i32, i32)> 
    llvm.return %5 : !llvm.struct<(i32, i32)>
  }]

def negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

def negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, struct<(i32)>)> 
    %2 = llvm.extractvalue %arg0[1, 0] : !llvm.struct<(i32, struct<(i32)>)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

def test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

def test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb2(%1: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %0[0] : !llvm.struct<(i32, i32)> 
    %5 = llvm.insertvalue %3, %4[1] : !llvm.struct<(i32, i32)> 
    llvm.return %5 : !llvm.struct<(i32, i32)>
  }]

def poison_base_before := [llvmfunc|
  llvm.func @poison_base(%arg0: !llvm.array<3 x i32>) -> !llvm.array<3 x i32> {
    %0 = llvm.mlir.poison : !llvm.array<3 x i32>
    %1 = llvm.extractvalue %arg0[0] : !llvm.array<3 x i32> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.array<3 x i32> 
    %3 = llvm.extractvalue %arg0[2] : !llvm.array<3 x i32> 
    %4 = llvm.insertvalue %1, %0[0] : !llvm.array<3 x i32> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.array<3 x i32> 
    %6 = llvm.insertvalue %3, %5[2] : !llvm.array<3 x i32> 
    llvm.return %6 : !llvm.array<3 x i32>
  }]

def test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    llvm.return %arg0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before test0(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.array<2 x i32>) -> !llvm.array<2 x i32> {
    llvm.return %arg0 : !llvm.array<2 x i32>
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.array<3 x i32>) -> !llvm.array<3 x i32> {
    %0 = llvm.mlir.undef : !llvm.array<3 x i32>
    %1 = llvm.extractvalue %arg0[0] : !llvm.array<3 x i32> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.array<3 x i32> 
    %3 = llvm.extractvalue %arg0[2] : !llvm.array<3 x i32> 
    %4 = llvm.insertvalue %1, %0[0] : !llvm.array<3 x i32> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.array<3 x i32> 
    %6 = llvm.insertvalue %3, %5[2] : !llvm.array<3 x i32> 
    llvm.return %6 : !llvm.array<3 x i32>
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<(i32, i32)>)> {
    %0 = llvm.mlir.undef : !llvm.struct<(struct<(i32, i32)>)>
    %1 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>)> 
    %2 = llvm.extractvalue %arg0[0, 1] : !llvm.struct<(struct<(i32, i32)>)> 
    %3 = llvm.insertvalue %1, %0[0, 0] : !llvm.struct<(struct<(i32, i32)>)> 
    %4 = llvm.insertvalue %2, %3[0, 1] : !llvm.struct<(struct<(i32, i32)>)> 
    llvm.return %4 : !llvm.struct<(struct<(i32, i32)>)>
  }]

theorem inst_combine_test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<   : test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<_before  ⊑  test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<_combined := by
  unfold test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<_before test3(%arg0: !llvm.struct<(struct<(i32, i32)>)>) -> !llvm.struct<(struct<_combined
  simp_alive_peephole
  sorry
def test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<(i32)>)> {
    llvm.return %arg0 : !llvm.struct<(i32, struct<(i32)>)>
  }]

theorem inst_combine_test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<   : test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<_before  ⊑  test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<_combined := by
  unfold test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<_before test4(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, struct<_combined
  simp_alive_peephole
  sorry
def negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %arg1, %2[1] : !llvm.struct<(i32, i32)> 
    llvm.return %3 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<   : negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<_before  ⊑  negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<_combined := by
  unfold negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<_before negative_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.insertvalue %0, %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before negative_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before negative_test8(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %2[1] : !llvm.struct<(i32, i32)> 
    llvm.return %3 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before negative_test9(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before negative_test10(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %2, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before negative_test11(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%1) : (i32) -> ()
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%2) : (i32) -> ()
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%3) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.return %arg0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before test12(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    llvm.return %arg0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before test13(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<   : negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<_before  ⊑  negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<_combined := by
  unfold negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<_before negative_test14(%arg0: !llvm.struct<(i32, i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, struct<(i32)>)> 
    %2 = llvm.extractvalue %arg0[1, 0] : !llvm.struct<(i32, struct<(i32)>)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %2, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.return %4 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<   : negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<_before  ⊑  negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<_combined := by
  unfold negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<_before negative_test15(%arg0: !llvm.struct<(i32, struct<(i32)>)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<(i32, i32)> {
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %arg0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<   : test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before  ⊑  test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined := by
  unfold test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_before test16(%arg0: !llvm.struct<(i32, i32)>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg2, ^bb1, ^bb2(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb2(%0: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<   : test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before  ⊑  test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := by
  unfold test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before test17(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def poison_base_combined := [llvmfunc|
  llvm.func @poison_base(%arg0: !llvm.array<3 x i32>) -> !llvm.array<3 x i32> {
    llvm.return %arg0 : !llvm.array<3 x i32>
  }]

theorem inst_combine_poison_base   : poison_base_before  ⊑  poison_base_combined := by
  unfold poison_base_before poison_base_combined
  simp_alive_peephole
  sorry
