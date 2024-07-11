import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sink-into-ncd
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.call @use(%0) : (!llvm.ptr) -> i32
    llvm.br ^bb4(%3 : i32)
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @use(%1) : (!llvm.ptr) -> i32
    llvm.cond_br %arg1, ^bb4(%4 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    %5 = llvm.call @use(%1) : (!llvm.ptr) -> i32
    llvm.br ^bb4(%5 : i32)
  ^bb4(%6: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %6 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb5(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %4 = llvm.call @use(%0) : (!llvm.ptr) -> i32
    llvm.br ^bb5(%4 : i32)
  ^bb3:  // pred: ^bb1
    %5 = llvm.call @use(%3) : (!llvm.ptr) -> i32
    llvm.cond_br %arg1, ^bb5(%5 : i32), ^bb4
  ^bb4:  // pred: ^bb3
    %6 = llvm.call @use(%3) : (!llvm.ptr) -> i32
    llvm.br ^bb5(%6 : i32)
  ^bb5(%7: i32):  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    llvm.return %7 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i32
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.call @use(%2) : (!llvm.ptr) -> i32
    llvm.cond_br %arg1, ^bb4(%3 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    %4 = llvm.call @use(%2) : (!llvm.ptr) -> i32
    llvm.br ^bb4(%4 : i32)
  ^bb4(%5: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %5 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb5(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %4 = llvm.call @use(%0) : (!llvm.ptr) -> i32
    llvm.br ^bb5(%4 : i32)
  ^bb3:  // pred: ^bb1
    %5 = llvm.call @use(%3) : (!llvm.ptr) -> i32
    llvm.cond_br %arg1, ^bb5(%5 : i32), ^bb4
  ^bb4:  // pred: ^bb3
    %6 = llvm.call @use(%3) : (!llvm.ptr) -> i32
    llvm.br ^bb5(%6 : i32)
  ^bb5(%7: i32):  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    llvm.return %7 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
