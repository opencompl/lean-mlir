import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr21210
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.call @foo(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.call @bar(%arg0) : (i32) -> i32
    %5 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.cond_br %5, ^bb1, ^bb3(%4 : i32)
  ^bb1:  // pred: ^bb0
    %6 = llvm.icmp "ult" %4, %1 : i32
    %7 = llvm.select %6, %arg0, %2 : i1, i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    llvm.cond_br %8, ^bb2, ^bb3(%7 : i32)
  ^bb2:  // pred: ^bb1
    llvm.call @foo(%arg0) : (i32) -> ()
    llvm.br ^bb3(%3 : i32)
  ^bb3(%9: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.call @foo(%9) : (i32) -> ()
    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    %2 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    llvm.call @foo(%2) : (i32) -> ()
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.call @bar(%arg0) : (i32) -> i32
    %5 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.cond_br %5, ^bb1, ^bb3(%4 : i32)
  ^bb1:  // pred: ^bb0
    %6 = llvm.icmp "ult" %4, %1 : i32
    %7 = llvm.select %6, %arg0, %2 : i1, i32
    %8 = llvm.icmp "eq" %7, %2 : i32
    llvm.cond_br %8, ^bb2, ^bb3(%7 : i32)
  ^bb2:  // pred: ^bb1
    llvm.call @foo(%arg0) : (i32) -> ()
    llvm.br ^bb3(%3 : i32)
  ^bb3(%9: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    llvm.call @foo(%9) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
