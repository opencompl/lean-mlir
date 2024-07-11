import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  known-phi-br
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def limit_i64_eq_7_before := [llvmfunc|
  llvm.func @limit_i64_eq_7(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.cond_br %1, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }]

def limit_i64_ne_255_before := [llvmfunc|
  llvm.func @limit_i64_ne_255(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.call @use(%1) : (i1) -> ()
    llvm.cond_br %1, ^bb1, ^bb2(%arg0 : i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }]

def limit_i64_ule_15_before := [llvmfunc|
  llvm.func @limit_i64_ule_15(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.icmp "ule" %arg0, %0 : i64
    llvm.cond_br %1, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %0  : i64
    llvm.br ^bb2(%2 : i64)
  ^bb2(%3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %3, %0  : i64
    llvm.return %4 : i64
  }]

def limit_i64_uge_8_before := [llvmfunc|
  llvm.func @limit_i64_uge_8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.icmp "uge" %arg0, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2(%arg0 : i64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.and %arg0, %1  : i64
    llvm.br ^bb2(%3 : i64)
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.and %4, %1  : i64
    llvm.return %5 : i64
  }]

def limit_i64_ult_8_before := [llvmfunc|
  llvm.func @limit_i64_ult_8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.and %arg0, %1  : i64
    llvm.br ^bb2(%3 : i64)
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.and %4, %1  : i64
    llvm.return %5 : i64
  }]

def limit_i64_ugt_7_before := [llvmfunc|
  llvm.func @limit_i64_ugt_7(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2(%arg0 : i64)
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %0  : i64
    llvm.br ^bb2(%2 : i64)
  ^bb2(%3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %3, %0  : i64
    llvm.return %4 : i64
  }]

def limit_i64_ule_15_mask3_before := [llvmfunc|
  llvm.func @limit_i64_ule_15_mask3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.icmp "ule" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.and %arg0, %0  : i64
    llvm.br ^bb2(%3 : i64)
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.and %4, %1  : i64
    llvm.return %5 : i64
  }]

def limit_i64_ult_8_mask1_before := [llvmfunc|
  llvm.func @limit_i64_ult_8_mask1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.cond_br %3, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %1  : i64
    llvm.br ^bb2(%4 : i64)
  ^bb2(%5: i64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.and %5, %2  : i64
    llvm.return %6 : i64
  }]

def limit_i64_eq_7_combined := [llvmfunc|
  llvm.func @limit_i64_eq_7(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.icmp "eq" %arg0, %0 : i64
    llvm.cond_br %1, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }]

theorem inst_combine_limit_i64_eq_7   : limit_i64_eq_7_before  ⊑  limit_i64_eq_7_combined := by
  unfold limit_i64_eq_7_before limit_i64_eq_7_combined
  simp_alive_peephole
  sorry
def limit_i64_ne_255_combined := [llvmfunc|
  llvm.func @limit_i64_ne_255(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.icmp "ne" %arg0, %0 : i64
    llvm.call @use(%1) : (i1) -> ()
    llvm.cond_br %1, ^bb1, ^bb2(%arg0 : i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }]

theorem inst_combine_limit_i64_ne_255   : limit_i64_ne_255_before  ⊑  limit_i64_ne_255_combined := by
  unfold limit_i64_ne_255_before limit_i64_ne_255_combined
  simp_alive_peephole
  sorry
def limit_i64_ule_15_combined := [llvmfunc|
  llvm.func @limit_i64_ule_15(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(15 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.and %arg0, %1  : i64
    llvm.br ^bb2(%3 : i64)
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i64
  }]

theorem inst_combine_limit_i64_ule_15   : limit_i64_ule_15_before  ⊑  limit_i64_ule_15_combined := by
  unfold limit_i64_ule_15_before limit_i64_ule_15_combined
  simp_alive_peephole
  sorry
def limit_i64_uge_8_combined := [llvmfunc|
  llvm.func @limit_i64_uge_8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2(%arg0 : i64)
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %0  : i64
    llvm.br ^bb2(%2 : i64)
  ^bb2(%3: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i64
  }]

theorem inst_combine_limit_i64_uge_8   : limit_i64_uge_8_before  ⊑  limit_i64_uge_8_combined := by
  unfold limit_i64_uge_8_before limit_i64_uge_8_combined
  simp_alive_peephole
  sorry
def limit_i64_ult_8_combined := [llvmfunc|
  llvm.func @limit_i64_ult_8(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.cond_br %2, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.and %arg0, %1  : i64
    llvm.br ^bb2(%3 : i64)
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i64
  }]

theorem inst_combine_limit_i64_ult_8   : limit_i64_ult_8_before  ⊑  limit_i64_ult_8_combined := by
  unfold limit_i64_ult_8_before limit_i64_ult_8_combined
  simp_alive_peephole
  sorry
def limit_i64_ugt_7_combined := [llvmfunc|
  llvm.func @limit_i64_ugt_7(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    llvm.cond_br %1, ^bb1, ^bb2(%arg0 : i64)
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %0  : i64
    llvm.br ^bb2(%2 : i64)
  ^bb2(%3: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i64
  }]

theorem inst_combine_limit_i64_ugt_7   : limit_i64_ugt_7_before  ⊑  limit_i64_ugt_7_combined := by
  unfold limit_i64_ugt_7_before limit_i64_ugt_7_combined
  simp_alive_peephole
  sorry
def limit_i64_ule_15_mask3_combined := [llvmfunc|
  llvm.func @limit_i64_ule_15_mask3(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(15 : i64) : i64
    %2 = llvm.mlir.constant(3 : i64) : i64
    %3 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.cond_br %3, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %1  : i64
    llvm.br ^bb2(%4 : i64)
  ^bb2(%5: i64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.and %5, %2  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_limit_i64_ule_15_mask3   : limit_i64_ule_15_mask3_before  ⊑  limit_i64_ule_15_mask3_combined := by
  unfold limit_i64_ule_15_mask3_before limit_i64_ule_15_mask3_combined
  simp_alive_peephole
  sorry
def limit_i64_ult_8_mask1_combined := [llvmfunc|
  llvm.func @limit_i64_ult_8_mask1(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.cond_br %3, ^bb2(%arg0 : i64), ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %1  : i64
    llvm.br ^bb2(%4 : i64)
  ^bb2(%5: i64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.and %5, %2  : i64
    llvm.return %6 : i64
  }]

theorem inst_combine_limit_i64_ult_8_mask1   : limit_i64_ult_8_mask1_before  ⊑  limit_i64_ult_8_mask1_combined := by
  unfold limit_i64_ult_8_mask1_before limit_i64_ult_8_mask1_combined
  simp_alive_peephole
  sorry
