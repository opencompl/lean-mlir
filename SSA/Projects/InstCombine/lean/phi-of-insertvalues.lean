import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-of-insertvalues
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%0) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%1) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%0) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%1) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg3, %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_before := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb3(%2: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>
  }]

def test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_before := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0, 1] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb3(%2: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>
  }]

def test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.cond_br %arg3, ^bb4(%0 : !llvm.struct<(i32, i32)>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : !llvm.struct<(i32, i32)>)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%1 : !llvm.struct<(i32, i32)>)
  ^bb4(%2: !llvm.struct<(i32, i32)>):  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%0) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.cond_br %arg3, ^bb4(%0 : !llvm.struct<(i32, i32)>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : !llvm.struct<(i32, i32)>)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%1 : !llvm.struct<(i32, i32)>)
  ^bb4(%2: !llvm.struct<(i32, i32)>):  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

def test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.insertvalue %0, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<   : test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before  ⊑  test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := by
  unfold test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%0) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<   : test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before  ⊑  test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := by
  unfold test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%1) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<   : test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before  ⊑  test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := by
  unfold test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%0) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%1) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<   : test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before  ⊑  test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := by
  unfold test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb3(%0: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.insertvalue %arg2, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<   : test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<_before  ⊑  test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := by
  unfold test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<_before test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg2 : !llvm.struct<(i32, i32)>, i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1, %arg3 : !llvm.struct<(i32, i32)>, i32)
  ^bb3(%0: !llvm.struct<(i32, i32)>, %1: i32):  // 2 preds: ^bb1, ^bb2
    %2 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<   : test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<_before  ⊑  test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<_combined := by
  unfold test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<_before test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i32, %arg3: i32, %arg4: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : !llvm.struct<(i32, i32)>)
  ^bb3(%2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<   : test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before  ⊑  test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined := by
  unfold test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_before test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_combined := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : i32)
  ^bb3(%0: i32):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.insertvalue %0, %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.return %1 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>
  }]

theorem inst_combine_test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<   : test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_before  ⊑  test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_combined := by
  unfold test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_before test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_combined
  simp_alive_peephole
  sorry
def test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_combined := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.insertvalue %arg1, %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb2:  // pred: ^bb0
    %1 = llvm.insertvalue %arg2, %arg0[0, 1] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb3(%2: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>
  }]

theorem inst_combine_test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<   : test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_before  ⊑  test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_combined := by
  unfold test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_before test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: i32, %arg2: i32, %arg3: i1) -> !llvm.struct<(struct<(i32, i32)>, struct<_combined
  simp_alive_peephole
  sorry
def test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb4(%arg1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%arg1 : i32)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%arg2 : i32)
  ^bb4(%0: i32):  // 3 preds: ^bb0, ^bb2, ^bb3
    %1 = llvm.insertvalue %0, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<   : test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_before  ⊑  test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_combined := by
  unfold test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_before test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.insertvalue %arg1, %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.insertvalue %arg2, %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32i32agg(%0) : (!llvm.struct<(i32, i32)>) -> ()
    llvm.cond_br %arg3, ^bb4(%0 : !llvm.struct<(i32, i32)>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : !llvm.struct<(i32, i32)>)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%1 : !llvm.struct<(i32, i32)>)
  ^bb4(%2: !llvm.struct<(i32, i32)>):  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return %2 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<   : test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_before  ⊑  test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_combined := by
  unfold test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_before test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: i32, %arg2: i32, %arg3: i1, %arg4: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
