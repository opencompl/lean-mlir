import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  multi-use-load-casts
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}, %arg2: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i64]

    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink0(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    %2 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink1(%2) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}, %arg2: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i64]

    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink0(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    %2 = llvm.bitcast %0 : i64 to vector<2xi32>
    llvm.call @sink2(%2) : (vector<2xi32>) -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}, %arg2: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i64]

    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink0(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.call @sink3(%0) : (i64) -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}, %arg2: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink0(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    %2 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink1(%2) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}, %arg2: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink0(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    %2 = llvm.bitcast %0 : i64 to vector<2xi32>
    llvm.call @sink2(%2) : (vector<2xi32>) -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i1 {llvm.zeroext}, %arg1: i1 {llvm.zeroext}, %arg2: !llvm.ptr {llvm.nocapture, llvm.readonly}) {
    %0 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.call @sink0(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.call @sink3(%0) : (i64) -> ()
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
