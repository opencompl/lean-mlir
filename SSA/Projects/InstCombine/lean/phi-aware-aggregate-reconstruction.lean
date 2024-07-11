import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-aware-aggregate-reconstruction
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%1, %2 : i32, i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%3, %4 : i32, i32)
  ^bb3(%5: i32, %6: i32):  // 2 preds: ^bb1, ^bb2
    llvm.call @baz() : () -> ()
    %7 = llvm.insertvalue %5, %0[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.struct<(i32, i32)> 
    llvm.return %8 : !llvm.struct<(i32, i32)>
  }]

def negative_test1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%1, %4 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%3, %2 : i32, i32)
  ^bb3(%5: i32, %6: i32):  // 2 preds: ^bb1, ^bb2
    llvm.call @baz() : () -> ()
    %7 = llvm.insertvalue %5, %0[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.struct<(i32, i32)> 
    llvm.return %8 : !llvm.struct<(i32, i32)>
  }]

def negative_test2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%2, %1 : i32, i32)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%3, %4 : i32, i32)
  ^bb3(%5: i32, %6: i32):  // 2 preds: ^bb1, ^bb2
    llvm.call @baz() : () -> ()
    %7 = llvm.insertvalue %5, %0[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.struct<(i32, i32)> 
    llvm.return %8 : !llvm.struct<(i32, i32)>
  }]

def test3(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: !llvm.struct<(i32, i32)>, %arg3: i1, %arg4: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: !llvm.struct<(i32, i32)>, %arg3: i1, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg3, ^bb1, ^bb5
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb4(%1, %2 : i32, i32)
  ^bb3:  // pred: ^bb1
    %3 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb4(%3, %4 : i32, i32)
  ^bb4(%5: i32, %6: i32):  // 2 preds: ^bb2, ^bb3
    llvm.br ^bb6(%5, %6 : i32, i32)
  ^bb5:  // pred: ^bb0
    %7 = llvm.extractvalue %arg2[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.extractvalue %arg2[1] : !llvm.struct<(i32, i32)> 
    llvm.br ^bb6(%7, %8 : i32, i32)
  ^bb6(%9: i32, %10: i32):  // 2 preds: ^bb4, ^bb5
    llvm.call @baz() : () -> ()
    %11 = llvm.insertvalue %9, %0[0] : !llvm.struct<(i32, i32)> 
    %12 = llvm.insertvalue %10, %11[1] : !llvm.struct<(i32, i32)> 
    llvm.return %12 : !llvm.struct<(i32, i32)>
  }]

def test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%1, %2 : i32, i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%3, %4 : i32, i32)
  ^bb3(%5: i32, %6: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.call @baz() : () -> ()
    %7 = llvm.insertvalue %5, %0[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.struct<(i32, i32)> 
    %9 = llvm.call @geni1() : () -> i1
    llvm.cond_br %9, ^bb4, ^bb3(%5, %6 : i32, i32)
  ^bb4:  // pred: ^bb3
    llvm.return %8 : !llvm.struct<(i32, i32)>
  }]

def test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%1, %2 : i32, i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%3, %4 : i32, i32)
  ^bb3(%5: i32, %6: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.call @baz() : () -> ()
    %7 = llvm.insertvalue %5, %0[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.struct<(i32, i32)> 
    %9 = llvm.extractvalue %8[0] : !llvm.struct<(i32, i32)> 
    %10 = llvm.extractvalue %8[1] : !llvm.struct<(i32, i32)> 
    %11 = llvm.call @geni1() : () -> i1
    llvm.cond_br %11, ^bb4, ^bb3(%9, %10 : i32, i32)
  ^bb4:  // pred: ^bb3
    llvm.return %8 : !llvm.struct<(i32, i32)>
  }]

def test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%1, %2 : i32, i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%3, %4 : i32, i32)
  ^bb3(%5: i32, %6: i32):  // 2 preds: ^bb1, ^bb2
    llvm.call @baz() : () -> ()
    llvm.cond_br %arg3, ^bb5, ^bb4
  ^bb4:  // pred: ^bb3
    llvm.call @qux() : () -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.call @quux() : () -> ()
    %7 = llvm.insertvalue %5, %0[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.struct<(i32, i32)> 
    llvm.return %8 : !llvm.struct<(i32, i32)>
  }]

def negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%1) : (i32) -> ()
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%2) : (i32) -> ()
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%3) : (i32) -> ()
    llvm.br ^bb3(%3 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.call @bar() : () -> ()
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.call @baz() : () -> ()
    %5 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.struct<(i32, i32)> 
    llvm.return %6 : !llvm.struct<(i32, i32)>
  }]

def test8(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i32, %arg4: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i32, %arg4: i32) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @foo() : () -> ()
    llvm.switch %arg3 : i32, ^bb3 [
      4294967254: ^bb4(%1, %2 : i32, i32),
      42: ^bb4(%1, %2 : i32, i32)
    ]
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar() : () -> ()
    llvm.switch %arg4 : i32, ^bb3 [
      42: ^bb4(%3, %4 : i32, i32),
      4294967254: ^bb4(%3, %4 : i32, i32)
    ]
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.unreachable
  ^bb4(%5: i32, %6: i32):  // 4 preds: ^bb1, ^bb1, ^bb2, ^bb2
    llvm.call @baz() : () -> ()
    %7 = llvm.insertvalue %5, %0[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.struct<(i32, i32)> 
    llvm.return %8 : !llvm.struct<(i32, i32)>
  }]

def test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %3 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%3, %2 : !llvm.struct<(i32, i32)>, i32)
  ^bb2:  // pred: ^bb0
    %4 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %5 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    %6 = llvm.insertvalue %4, %0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%6, %5 : !llvm.struct<(i32, i32)>, i32)
  ^bb3(%7: !llvm.struct<(i32, i32)>, %8: i32):  // 2 preds: ^bb1, ^bb2
    llvm.call @baz() : () -> ()
    %9 = llvm.insertvalue %8, %7[1] : !llvm.struct<(i32, i32)> 
    llvm.return %9 : !llvm.struct<(i32, i32)>
  }]

def test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb3(%0: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.call @baz() : () -> ()
    llvm.return %0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<   : test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before  ⊑  test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := by
  unfold test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before test0(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%arg0, %arg1 : !llvm.struct<(i32, i32)>, !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%arg1, %arg0 : !llvm.struct<(i32, i32)>, !llvm.struct<(i32, i32)>)
  ^bb3(%1: !llvm.struct<(i32, i32)>, %2: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i32)> 
    llvm.call @baz() : () -> ()
    %5 = llvm.insertvalue %4, %0[0] : !llvm.struct<(i32, i32)> 
    %6 = llvm.insertvalue %3, %5[1] : !llvm.struct<(i32, i32)> 
    llvm.return %6 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<   : negative_test1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before  ⊑  negative_test1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := by
  unfold negative_test1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before negative_test1(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%1, %2 : i32, i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%4, %3 : i32, i32)
  ^bb3(%5: i32, %6: i32):  // 2 preds: ^bb1, ^bb2
    llvm.call @baz() : () -> ()
    %7 = llvm.insertvalue %5, %0[0] : !llvm.struct<(i32, i32)> 
    %8 = llvm.insertvalue %6, %7[1] : !llvm.struct<(i32, i32)> 
    llvm.return %8 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<   : negative_test2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before  ⊑  negative_test2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := by
  unfold negative_test2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before negative_test2(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test3(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: !llvm.struct<(i32, i32)>, %arg3: i1, %arg4: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: !llvm.struct<(i32, i32)>, %arg3: i1, %arg4: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg3, ^bb1, ^bb5
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb4(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb4(%0: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb2, ^bb3
    llvm.br ^bb6(%0 : !llvm.struct<(i32, i32)>)
  ^bb5:  // pred: ^bb0
    llvm.br ^bb6(%arg2 : !llvm.struct<(i32, i32)>)
  ^bb6(%1: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb4, ^bb5
    llvm.call @baz() : () -> ()
    llvm.return %1 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test3(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: !llvm.struct<(i32, i32)>, %arg3: i1, %arg4: i1) -> !llvm.struct<   : test3(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: !llvm.struct<(i32, i32)>, %arg3: i1, %arg4: i1) -> !llvm.struct<_before  ⊑  test3(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: !llvm.struct<(i32, i32)>, %arg3: i1, %arg4: i1) -> !llvm.struct<_combined := by
  unfold test3(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: !llvm.struct<(i32, i32)>, %arg3: i1, %arg4: i1) -> !llvm.struct<_before test3(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: !llvm.struct<(i32, i32)>, %arg3: i1, %arg4: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%1, %2 : i32, i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractvalue %arg1[0] : !llvm.struct<(i32, i32)> 
    %4 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%3, %4 : i32, i32)
  ^bb3(%5: i32, %6: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.call @baz() : () -> ()
    %7 = llvm.call @geni1() : () -> i1
    llvm.cond_br %7, ^bb4, ^bb3(%5, %6 : i32, i32)
  ^bb4:  // pred: ^bb3
    %8 = llvm.insertvalue %5, %0[0] : !llvm.struct<(i32, i32)> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.struct<(i32, i32)> 
    llvm.return %9 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<   : test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before  ⊑  test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := by
  unfold test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before test4(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb3(%0: !llvm.struct<(i32, i32)>):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.call @baz() : () -> ()
    %1 = llvm.call @geni1() : () -> i1
    llvm.cond_br %1, ^bb4, ^bb3(%0 : !llvm.struct<(i32, i32)>)
  ^bb4:  // pred: ^bb3
    llvm.return %0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<   : test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before  ⊑  test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := by
  unfold test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before test5(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb3(%0: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.call @baz() : () -> ()
    llvm.cond_br %arg3, ^bb5, ^bb4
  ^bb4:  // pred: ^bb3
    llvm.call @qux() : () -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.call @quux() : () -> ()
    llvm.return %0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<   : test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_before  ⊑  test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_combined := by
  unfold test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_before test6(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<(i32, i32)> {
    %0 = llvm.mlir.undef : !llvm.struct<(i32, i32)>
    %1 = llvm.extractvalue %arg0[0] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%1) : (i32) -> ()
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.extractvalue %arg0[1] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%2) : (i32) -> ()
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.extractvalue %arg1[1] : !llvm.struct<(i32, i32)> 
    llvm.call @usei32(%3) : (i32) -> ()
    llvm.br ^bb3(%3 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.call @bar() : () -> ()
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.call @baz() : () -> ()
    %5 = llvm.insertvalue %1, %0[0] : !llvm.struct<(i32, i32)> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.struct<(i32, i32)> 
    llvm.return %6 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<   : negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_before  ⊑  negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_combined := by
  unfold negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_before negative_test7(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test8(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i32, %arg4: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test8(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i32, %arg4: i32) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.switch %arg3 : i32, ^bb3 [
      4294967254: ^bb4(%arg0 : !llvm.struct<(i32, i32)>),
      42: ^bb4(%arg0 : !llvm.struct<(i32, i32)>)
    ]
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.switch %arg4 : i32, ^bb3 [
      42: ^bb4(%arg1 : !llvm.struct<(i32, i32)>),
      4294967254: ^bb4(%arg1 : !llvm.struct<(i32, i32)>)
    ]
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.unreachable
  ^bb4(%0: !llvm.struct<(i32, i32)>):  // 4 preds: ^bb1, ^bb1, ^bb2, ^bb2
    llvm.call @baz() : () -> ()
    llvm.return %0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test8(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i32, %arg4: i32) -> !llvm.struct<   : test8(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i32, %arg4: i32) -> !llvm.struct<_before  ⊑  test8(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i32, %arg4: i32) -> !llvm.struct<_combined := by
  unfold test8(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i32, %arg4: i32) -> !llvm.struct<_before test8(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1, %arg3: i32, %arg4: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<(i32, i32)> {
    llvm.cond_br %arg2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.br ^bb3(%arg0 : !llvm.struct<(i32, i32)>)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%arg1 : !llvm.struct<(i32, i32)>)
  ^bb3(%0: !llvm.struct<(i32, i32)>):  // 2 preds: ^bb1, ^bb2
    llvm.call @baz() : () -> ()
    llvm.return %0 : !llvm.struct<(i32, i32)>
  }]

theorem inst_combine_test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<   : test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before  ⊑  test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined := by
  unfold test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_before test9(%arg0: !llvm.struct<(i32, i32)>, %arg1: !llvm.struct<(i32, i32)>, %arg2: i1) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
