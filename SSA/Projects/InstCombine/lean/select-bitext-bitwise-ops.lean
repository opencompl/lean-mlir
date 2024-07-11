import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-bitext-bitwise-ops
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sel_false_val_is_a_masked_shl_of_true_val1_before := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_shl_of_true_val1(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def sel_false_val_is_a_masked_shl_of_true_val2_before := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_shl_of_true_val2(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %4, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def sel_false_val_is_a_masked_lshr_of_true_val1_before := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_lshr_of_true_val1(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(60 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def sel_false_val_is_a_masked_lshr_of_true_val2_before := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_lshr_of_true_val2(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(60 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %4, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def sel_false_val_is_a_masked_ashr_of_true_val1_before := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_ashr_of_true_val1(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2147483588 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def sel_false_val_is_a_masked_ashr_of_true_val2_before := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_ashr_of_true_val2(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2147483588 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %4, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def sel_false_val_is_a_masked_shl_of_true_val1_combined := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_shl_of_true_val1(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_sel_false_val_is_a_masked_shl_of_true_val1   : sel_false_val_is_a_masked_shl_of_true_val1_before  ⊑  sel_false_val_is_a_masked_shl_of_true_val1_combined := by
  unfold sel_false_val_is_a_masked_shl_of_true_val1_before sel_false_val_is_a_masked_shl_of_true_val1_combined
  simp_alive_peephole
  sorry
def sel_false_val_is_a_masked_shl_of_true_val2_combined := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_shl_of_true_val2(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_sel_false_val_is_a_masked_shl_of_true_val2   : sel_false_val_is_a_masked_shl_of_true_val2_before  ⊑  sel_false_val_is_a_masked_shl_of_true_val2_combined := by
  unfold sel_false_val_is_a_masked_shl_of_true_val2_before sel_false_val_is_a_masked_shl_of_true_val2_combined
  simp_alive_peephole
  sorry
def sel_false_val_is_a_masked_lshr_of_true_val1_combined := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_lshr_of_true_val1(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_sel_false_val_is_a_masked_lshr_of_true_val1   : sel_false_val_is_a_masked_lshr_of_true_val1_before  ⊑  sel_false_val_is_a_masked_lshr_of_true_val1_combined := by
  unfold sel_false_val_is_a_masked_lshr_of_true_val1_before sel_false_val_is_a_masked_lshr_of_true_val1_combined
  simp_alive_peephole
  sorry
def sel_false_val_is_a_masked_lshr_of_true_val2_combined := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_lshr_of_true_val2(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_sel_false_val_is_a_masked_lshr_of_true_val2   : sel_false_val_is_a_masked_lshr_of_true_val2_before  ⊑  sel_false_val_is_a_masked_lshr_of_true_val2_combined := by
  unfold sel_false_val_is_a_masked_lshr_of_true_val2_before sel_false_val_is_a_masked_lshr_of_true_val2_combined
  simp_alive_peephole
  sorry
def sel_false_val_is_a_masked_ashr_of_true_val1_combined := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_ashr_of_true_val1(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-536870897 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_sel_false_val_is_a_masked_ashr_of_true_val1   : sel_false_val_is_a_masked_ashr_of_true_val1_before  ⊑  sel_false_val_is_a_masked_ashr_of_true_val1_combined := by
  unfold sel_false_val_is_a_masked_ashr_of_true_val1_before sel_false_val_is_a_masked_ashr_of_true_val1_combined
  simp_alive_peephole
  sorry
def sel_false_val_is_a_masked_ashr_of_true_val2_combined := [llvmfunc|
  llvm.func @sel_false_val_is_a_masked_ashr_of_true_val2(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-536870897 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_sel_false_val_is_a_masked_ashr_of_true_val2   : sel_false_val_is_a_masked_ashr_of_true_val2_before  ⊑  sel_false_val_is_a_masked_ashr_of_true_val2_combined := by
  unfold sel_false_val_is_a_masked_ashr_of_true_val2_before sel_false_val_is_a_masked_ashr_of_true_val2_combined
  simp_alive_peephole
  sorry
