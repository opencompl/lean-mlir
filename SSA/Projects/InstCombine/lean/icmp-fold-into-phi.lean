import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-fold-into-phi
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def SwitchTest_before := [llvmfunc|
  llvm.func @SwitchTest(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.switch %arg0 : i32, ^bb1 [
      0: ^bb2(%0 : i32),
      1: ^bb3(%1 : i32)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb3(%2 : i32)
  ^bb3(%3: i32):  // 2 preds: ^bb0, ^bb2
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def BranchTest_before := [llvmfunc|
  llvm.func @BranchTest(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(134 : i32) : i32
    %3 = llvm.mlir.constant(128 : i32) : i32
    %4 = llvm.mlir.constant(127 : i32) : i32
    %5 = llvm.mlir.constant(126 : i32) : i32
    llvm.cond_br %arg0, ^bb6(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb6(%1 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.cond_br %arg2, ^bb6(%2 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.cond_br %arg3, ^bb5(%3 : i32), ^bb4
  ^bb4:  // pred: ^bb3
    %6 = llvm.select %arg4, %4, %5 : i1, i32
    llvm.br ^bb5(%6 : i32)
  ^bb5(%7: i32):  // 2 preds: ^bb3, ^bb4
    llvm.br ^bb6(%7 : i32)
  ^bb6(%8: i32):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb5
    %9 = llvm.icmp "ult" %8, %1 : i32
    llvm.return %9 : i1
  }]

def SwitchTest_combined := [llvmfunc|
  llvm.func @SwitchTest(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.switch %arg0 : i32, ^bb1 [
      0: ^bb2(%0 : i1),
      1: ^bb3(%0 : i1)
    ]
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "ugt" %arg1, %1 : i32
    llvm.br ^bb2(%2 : i1)
  ^bb2(%3: i1):  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb3(%3 : i1)
  ^bb3(%4: i1):  // 2 preds: ^bb0, ^bb2
    llvm.return %4 : i1
  }]

theorem inst_combine_SwitchTest   : SwitchTest_before  ⊑  SwitchTest_combined := by
  unfold SwitchTest_before SwitchTest_combined
  simp_alive_peephole
  sorry
def BranchTest_combined := [llvmfunc|
  llvm.func @BranchTest(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    llvm.cond_br %arg0, ^bb6, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb6, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.cond_br %arg2, ^bb6, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.cond_br %arg3, ^bb5, ^bb4
  ^bb4:  // pred: ^bb3
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.br ^bb6
  ^bb6:  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb5
    llvm.return %arg0 : i1
  }]

theorem inst_combine_BranchTest   : BranchTest_before  ⊑  BranchTest_combined := by
  unfold BranchTest_before BranchTest_combined
  simp_alive_peephole
  sorry
