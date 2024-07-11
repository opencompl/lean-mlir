import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-extractvalue
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before := [llvmfunc|
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before := [llvmfunc|
  llvm.func @test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%0) : (i32) -> ()
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before := [llvmfunc|
  llvm.func @test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%1) : (i32) -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before := [llvmfunc|
  llvm.func @test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%0) : (i32) -> ()
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%1) : (i32) -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test5(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test6(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0, 1] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[1, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[1, 1] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, struct<_before := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

def test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before := [llvmfunc|
  llvm.func @test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> i32 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.cond_br %arg2, ^bb4(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%1 : i32)
  ^bb4(%2: i32):  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return %2 : i32
  }]

def test11(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before := [llvmfunc|
  llvm.func @test11(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> i32 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%0) : (i32) -> ()
    llvm.cond_br %arg2, ^bb4(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%1 : i32)
  ^bb4(%2: i32):  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return %2 : i32
  }]

def extractvalue_of_constant_phi_before := [llvmfunc|
  llvm.func @extractvalue_of_constant_phi(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i32)> 
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(i32, i32)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<(i32, i32)> 
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%9 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%4 : !llvm.struct<(i32, i32)>)
  ^bb3(%10: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    %11 = llvm.extractvalue %10[0] : !llvm.struct<(i32, i32)> 
    llvm.return %11 : i32
  }]

def extractvalue_of_one_constant_phi(%arg0: i1, %arg1: !llvm.struct<_before := [llvmfunc|
  llvm.func @extractvalue_of_one_constant_phi(%arg0: i1, %arg1: !llvm.struct<(i32, i32)>) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i32)> 
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%4 : !llvm.struct<(i32, i32)>)
  ^bb3(%5: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    %6 = llvm.extractvalue %5[0] : !llvm.struct<(i32, i32)> 
    llvm.return %6 : i32
  }]

def extractvalue_of_constant_phi_multi_index_before := [llvmfunc|
  llvm.func @extractvalue_of_constant_phi_multi_index(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i32)> 
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.mlir.undef : !llvm.struct<(i32, struct<(i32, i32)>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %8 = llvm.insertvalue %4, %7[1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(i32, i32)> 
    %13 = llvm.insertvalue %9, %12[1] : !llvm.struct<(i32, i32)> 
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.mlir.undef : !llvm.struct<(i32, struct<(i32, i32)>)>
    %16 = llvm.insertvalue %14, %15[0] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %17 = llvm.insertvalue %13, %16[1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%17 : !llvm.struct<(i32, struct<(i32, i32)>)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%8 : !llvm.struct<(i32, struct<(i32, i32)>)>)
  ^bb3(%18: !llvm.struct<(i32, struct<(i32, i32)>)>):  // 2 preds: ^bb1, ^bb2
    %19 = llvm.extractvalue %18[1, 1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.return %19 : i32
  }]

def extractvalue_of_one_constant_phi_multi_index(%arg0: i1, %arg1: !llvm.struct<(i32, struct<_before := [llvmfunc|
  llvm.func @extractvalue_of_one_constant_phi_multi_index(%arg0: i1, %arg1: !llvm.struct<(i32, struct<(i32, i32)>)>) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i32)> 
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.mlir.undef : !llvm.struct<(i32, struct<(i32, i32)>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    %8 = llvm.insertvalue %4, %7[1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.struct<(i32, struct<(i32, i32)>)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%8 : !llvm.struct<(i32, struct<(i32, i32)>)>)
  ^bb3(%9: !llvm.struct<(i32, struct<(i32, i32)>)>):  // 2 preds: ^bb1, ^bb2
    %10 = llvm.extractvalue %9[1, 1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.return %10 : i32
  }]

def extractvalue_of_constant_phi_multiuse_before := [llvmfunc|
  llvm.func @extractvalue_of_constant_phi_multiuse(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i32)> 
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(i32, i32)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<(i32, i32)> 
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%9 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%4 : !llvm.struct<(i32, i32)>)
  ^bb3(%10: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    %11 = llvm.extractvalue %10[0] : !llvm.struct<(i32, i32)> 
    %12 = llvm.extractvalue %10[1] : !llvm.struct<(i32, i32)> 
    %13 = llvm.add %11, %12  : i32
    llvm.return %13 : i32
  }]

def test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := [llvmfunc|
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb3(%0: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : i32
  }]

theorem inst_combine_test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<   : test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before  ⊑  test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := by
  unfold test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := [llvmfunc|
  llvm.func @test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%0) : (i32) -> ()
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<   : test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before  ⊑  test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := by
  unfold test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before test1_extrause0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := [llvmfunc|
  llvm.func @test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%1) : (i32) -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<   : test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before  ⊑  test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := by
  unfold test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before test2_extrause1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := [llvmfunc|
  llvm.func @test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%0) : (i32) -> ()
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%1) : (i32) -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<   : test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before  ⊑  test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := by
  unfold test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before test3_extrause2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<   : test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before  ⊑  test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := by
  unfold test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test5(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg0 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>)
  ^bb3(%0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.extractvalue %0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.return %1 : i32
  }]

theorem inst_combine_test5(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<   : test5(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before  ⊑  test5(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined := by
  unfold test5(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before test5(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined
  simp_alive_peephole
  sorry
def test6(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0, 1] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_test6(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<   : test6(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before  ⊑  test6(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined := by
  unfold test6(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before test6(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined
  simp_alive_peephole
  sorry
def test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined := [llvmfunc|
  llvm.func @test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[1, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<   : test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before  ⊑  test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined := by
  unfold test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before test7(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined
  simp_alive_peephole
  sorry
def test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0, 0] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[1, 1] : !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<   : test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before  ⊑  test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined := by
  unfold test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_before test8(%arg0: !llvm.struct<(struct<(i32, i32)>, struct<(i32, i32)>)>, %arg1: !llvm.struct<(struct<(i32, i32)>, struct<_combined
  simp_alive_peephole
  sorry
def test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, struct<_combined := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, struct<(i32, i32)>)>, %arg2: i1) -> i32 {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%0 : i32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, struct<   : test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, struct<_before  ⊑  test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, struct<_combined := by
  unfold test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, struct<_before test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, struct<_combined
  simp_alive_peephole
  sorry
def test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := [llvmfunc|
  llvm.func @test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> i32 {
    llvm.cond_br %arg2, ^bb4(%arg0 : !llvm.struct<(i32, i32)>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb4(%0: !llvm.struct<(i32, i32)>):  // 3 preds: ^bb0, ^bb2, ^bb3
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i32, i32)> 
    llvm.return %1 : i32
  }]

theorem inst_combine_test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<   : test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before  ⊑  test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := by
  unfold test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before test10(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test11(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := [llvmfunc|
  llvm.func @test11(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> i32 {
    %0 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%0) : (i32) -> ()
    llvm.cond_br %arg2, ^bb4(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%1 : i32)
  ^bb4(%2: i32):  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return %2 : i32
  }]

theorem inst_combine_test11(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<   : test11(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before  ⊑  test11(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined := by
  unfold test11(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_before test11(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<_combined
  simp_alive_peephole
  sorry
def extractvalue_of_constant_phi_combined := [llvmfunc|
  llvm.func @extractvalue_of_constant_phi(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_extractvalue_of_constant_phi   : extractvalue_of_constant_phi_before  ⊑  extractvalue_of_constant_phi_combined := by
  unfold extractvalue_of_constant_phi_before extractvalue_of_constant_phi_combined
  simp_alive_peephole
  sorry
def extractvalue_of_one_constant_phi(%arg0: i1, %arg1: !llvm.struct<_combined := [llvmfunc|
  llvm.func @extractvalue_of_one_constant_phi(%arg0: i1, %arg1: !llvm.struct<(i32, i32)>) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_extractvalue_of_one_constant_phi(%arg0: i1, %arg1: !llvm.struct<   : extractvalue_of_one_constant_phi(%arg0: i1, %arg1: !llvm.struct<_before  ⊑  extractvalue_of_one_constant_phi(%arg0: i1, %arg1: !llvm.struct<_combined := by
  unfold extractvalue_of_one_constant_phi(%arg0: i1, %arg1: !llvm.struct<_before extractvalue_of_one_constant_phi(%arg0: i1, %arg1: !llvm.struct<_combined
  simp_alive_peephole
  sorry
def extractvalue_of_constant_phi_multi_index_combined := [llvmfunc|
  llvm.func @extractvalue_of_constant_phi_multi_index(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_extractvalue_of_constant_phi_multi_index   : extractvalue_of_constant_phi_multi_index_before  ⊑  extractvalue_of_constant_phi_multi_index_combined := by
  unfold extractvalue_of_constant_phi_multi_index_before extractvalue_of_constant_phi_multi_index_combined
  simp_alive_peephole
  sorry
def extractvalue_of_one_constant_phi_multi_index(%arg0: i1, %arg1: !llvm.struct<(i32, struct<_combined := [llvmfunc|
  llvm.func @extractvalue_of_one_constant_phi_multi_index(%arg0: i1, %arg1: !llvm.struct<(i32, struct<(i32, i32)>)>) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg1[1, 1] : !llvm.struct<(i32, struct<(i32, i32)>)> 
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i32
  }]

theorem inst_combine_extractvalue_of_one_constant_phi_multi_index(%arg0: i1, %arg1: !llvm.struct<(i32, struct<   : extractvalue_of_one_constant_phi_multi_index(%arg0: i1, %arg1: !llvm.struct<(i32, struct<_before  ⊑  extractvalue_of_one_constant_phi_multi_index(%arg0: i1, %arg1: !llvm.struct<(i32, struct<_combined := by
  unfold extractvalue_of_one_constant_phi_multi_index(%arg0: i1, %arg1: !llvm.struct<(i32, struct<_before extractvalue_of_one_constant_phi_multi_index(%arg0: i1, %arg1: !llvm.struct<(i32, struct<_combined
  simp_alive_peephole
  sorry
def extractvalue_of_constant_phi_multiuse_combined := [llvmfunc|
  llvm.func @extractvalue_of_constant_phi_multiuse(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i32, i32)> 
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(i32, i32)> 
    %9 = llvm.insertvalue %5, %8[1] : !llvm.struct<(i32, i32)> 
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%9 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%4 : !llvm.struct<(i32, i32)>)
  ^bb3(%10: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    %11 = llvm.extractvalue %10[0] : !llvm.struct<(i32, i32)> 
    %12 = llvm.extractvalue %10[1] : !llvm.struct<(i32, i32)> 
    %13 = llvm.add %11, %12  : i32
    llvm.return %13 : i32
  }]

theorem inst_combine_extractvalue_of_constant_phi_multiuse   : extractvalue_of_constant_phi_multiuse_before  ⊑  extractvalue_of_constant_phi_multiuse_combined := by
  unfold extractvalue_of_constant_phi_multiuse_before extractvalue_of_constant_phi_multiuse_combined
  simp_alive_peephole
  sorry
