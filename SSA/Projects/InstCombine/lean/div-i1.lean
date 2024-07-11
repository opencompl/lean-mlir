import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  div-i1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sdiv_by_zero_indirect_is_poison_before := [llvmfunc|
  llvm.func @sdiv_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %2 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%2 : i1)
  ^bb3(%3: i1):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.sdiv %arg1, %3  : i1
    llvm.return %4 : i1
  }]

def udiv_by_zero_indirect_is_poison_before := [llvmfunc|
  llvm.func @udiv_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %2 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%2 : i1)
  ^bb3(%3: i1):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.udiv %arg1, %3  : i1
    llvm.return %4 : i1
  }]

def srem_by_zero_indirect_is_poison_before := [llvmfunc|
  llvm.func @srem_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %2 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%2 : i1)
  ^bb3(%3: i1):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.srem %arg1, %3  : i1
    llvm.return %4 : i1
  }]

def urem_by_zero_indirect_is_poison_before := [llvmfunc|
  llvm.func @urem_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %2 = llvm.and %arg2, %0  : i1
    llvm.br ^bb3(%2 : i1)
  ^bb3(%3: i1):  // 2 preds: ^bb1, ^bb2
    %4 = llvm.urem %arg1, %3  : i1
    llvm.return %4 : i1
  }]

def sdiv_i1_is_op0_before := [llvmfunc|
  llvm.func @sdiv_i1_is_op0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.sdiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

def udiv_i1_is_op0_before := [llvmfunc|
  llvm.func @udiv_i1_is_op0(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.udiv %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

def srem_i1_is_zero_before := [llvmfunc|
  llvm.func @srem_i1_is_zero(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.srem %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

def urem_i1_is_zero_before := [llvmfunc|
  llvm.func @urem_i1_is_zero(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.urem %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

def pt62607_before := [llvmfunc|
  llvm.func @pt62607() -> i1 {
    %0 = llvm.mlir.constant(109 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.trunc %0 : i8 to i1
    llvm.br ^bb1(%1 : i1)
  ^bb1(%4: i1):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.add %4, %2  : i1
    "llvm.intr.assume"(%5) : (i1) -> ()
    %6 = llvm.udiv %3, %4  : i1
    llvm.cond_br %6, ^bb1(%5 : i1), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %1 : i1
  }]

def sdiv_by_zero_indirect_is_poison_combined := [llvmfunc|
  llvm.func @sdiv_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.poison : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %0 : i1
  }]

theorem inst_combine_sdiv_by_zero_indirect_is_poison   : sdiv_by_zero_indirect_is_poison_before  ⊑  sdiv_by_zero_indirect_is_poison_combined := by
  unfold sdiv_by_zero_indirect_is_poison_before sdiv_by_zero_indirect_is_poison_combined
  simp_alive_peephole
  sorry
def udiv_by_zero_indirect_is_poison_combined := [llvmfunc|
  llvm.func @udiv_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.poison : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %0 : i1
  }]

theorem inst_combine_udiv_by_zero_indirect_is_poison   : udiv_by_zero_indirect_is_poison_before  ⊑  udiv_by_zero_indirect_is_poison_combined := by
  unfold udiv_by_zero_indirect_is_poison_before udiv_by_zero_indirect_is_poison_combined
  simp_alive_peephole
  sorry
def srem_by_zero_indirect_is_poison_combined := [llvmfunc|
  llvm.func @srem_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.poison : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %0 : i1
  }]

theorem inst_combine_srem_by_zero_indirect_is_poison   : srem_by_zero_indirect_is_poison_before  ⊑  srem_by_zero_indirect_is_poison_combined := by
  unfold srem_by_zero_indirect_is_poison_before srem_by_zero_indirect_is_poison_combined
  simp_alive_peephole
  sorry
def urem_by_zero_indirect_is_poison_combined := [llvmfunc|
  llvm.func @urem_by_zero_indirect_is_poison(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.poison : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %0 : i1
  }]

theorem inst_combine_urem_by_zero_indirect_is_poison   : urem_by_zero_indirect_is_poison_before  ⊑  urem_by_zero_indirect_is_poison_combined := by
  unfold urem_by_zero_indirect_is_poison_before urem_by_zero_indirect_is_poison_combined
  simp_alive_peephole
  sorry
def sdiv_i1_is_op0_combined := [llvmfunc|
  llvm.func @sdiv_i1_is_op0(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_sdiv_i1_is_op0   : sdiv_i1_is_op0_before  ⊑  sdiv_i1_is_op0_combined := by
  unfold sdiv_i1_is_op0_before sdiv_i1_is_op0_combined
  simp_alive_peephole
  sorry
def udiv_i1_is_op0_combined := [llvmfunc|
  llvm.func @udiv_i1_is_op0(%arg0: i1, %arg1: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_udiv_i1_is_op0   : udiv_i1_is_op0_before  ⊑  udiv_i1_is_op0_combined := by
  unfold udiv_i1_is_op0_before udiv_i1_is_op0_combined
  simp_alive_peephole
  sorry
def srem_i1_is_zero_combined := [llvmfunc|
  llvm.func @srem_i1_is_zero(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_srem_i1_is_zero   : srem_i1_is_zero_before  ⊑  srem_i1_is_zero_combined := by
  unfold srem_i1_is_zero_before srem_i1_is_zero_combined
  simp_alive_peephole
  sorry
def urem_i1_is_zero_combined := [llvmfunc|
  llvm.func @urem_i1_is_zero(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_urem_i1_is_zero   : urem_i1_is_zero_before  ⊑  urem_i1_is_zero_combined := by
  unfold urem_i1_is_zero_before urem_i1_is_zero_combined
  simp_alive_peephole
  sorry
def pt62607_combined := [llvmfunc|
  llvm.func @pt62607() -> i1 {
    %0 = llvm.mlir.poison : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %1 : i1
  }]

theorem inst_combine_pt62607   : pt62607_before  ⊑  pt62607_combined := by
  unfold pt62607_before pt62607_combined
  simp_alive_peephole
  sorry
