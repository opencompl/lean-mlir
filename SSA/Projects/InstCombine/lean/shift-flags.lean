import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-flags
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shl_add_nuw_before := [llvmfunc|
  llvm.func @shl_add_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }]

def shl_add_nuw_fail_before := [llvmfunc|
  llvm.func @shl_add_nuw_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }]

def shl_add_nuw_and_nsw_before := [llvmfunc|
  llvm.func @shl_add_nuw_and_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }]

def shl_add_nsw_before := [llvmfunc|
  llvm.func @shl_add_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }]

def shl_add_nsw_fail_before := [llvmfunc|
  llvm.func @shl_add_nsw_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }]

def lshr_add_exact_before := [llvmfunc|
  llvm.func @lshr_add_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.lshr %2, %3  : i8
    llvm.return %4 : i8
  }]

def lshr_add_exact_fail_before := [llvmfunc|
  llvm.func @lshr_add_exact_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.lshr %2, %3  : i8
    llvm.return %4 : i8
  }]

def ashr_add_exact_before := [llvmfunc|
  llvm.func @ashr_add_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-14 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }]

def ashr_add_exact_fail_before := [llvmfunc|
  llvm.func @ashr_add_exact_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-14 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }]

def shl_add_nuw_combined := [llvmfunc|
  llvm.func @shl_add_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3 overflow<nuw>  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_add_nuw   : shl_add_nuw_before  ⊑  shl_add_nuw_combined := by
  unfold shl_add_nuw_before shl_add_nuw_combined
  simp_alive_peephole
  sorry
def shl_add_nuw_fail_combined := [llvmfunc|
  llvm.func @shl_add_nuw_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_add_nuw_fail   : shl_add_nuw_fail_before  ⊑  shl_add_nuw_fail_combined := by
  unfold shl_add_nuw_fail_before shl_add_nuw_fail_combined
  simp_alive_peephole
  sorry
def shl_add_nuw_and_nsw_combined := [llvmfunc|
  llvm.func @shl_add_nuw_and_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3 overflow<nsw, nuw>  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_add_nuw_and_nsw   : shl_add_nuw_and_nsw_before  ⊑  shl_add_nuw_and_nsw_combined := by
  unfold shl_add_nuw_and_nsw_before shl_add_nuw_and_nsw_combined
  simp_alive_peephole
  sorry
def shl_add_nsw_combined := [llvmfunc|
  llvm.func @shl_add_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3 overflow<nsw>  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_add_nsw   : shl_add_nsw_before  ⊑  shl_add_nsw_combined := by
  unfold shl_add_nsw_before shl_add_nsw_combined
  simp_alive_peephole
  sorry
def shl_add_nsw_fail_combined := [llvmfunc|
  llvm.func @shl_add_nsw_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.shl %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_add_nsw_fail   : shl_add_nsw_fail_before  ⊑  shl_add_nsw_fail_combined := by
  unfold shl_add_nsw_fail_before shl_add_nsw_fail_combined
  simp_alive_peephole
  sorry
def lshr_add_exact_combined := [llvmfunc|
  llvm.func @lshr_add_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.lshr %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_lshr_add_exact   : lshr_add_exact_before  ⊑  lshr_add_exact_combined := by
  unfold lshr_add_exact_before lshr_add_exact_combined
  simp_alive_peephole
  sorry
def lshr_add_exact_fail_combined := [llvmfunc|
  llvm.func @lshr_add_exact_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.lshr %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_lshr_add_exact_fail   : lshr_add_exact_fail_before  ⊑  lshr_add_exact_fail_combined := by
  unfold lshr_add_exact_fail_before lshr_add_exact_fail_combined
  simp_alive_peephole
  sorry
def ashr_add_exact_combined := [llvmfunc|
  llvm.func @ashr_add_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-14 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_ashr_add_exact   : ashr_add_exact_before  ⊑  ashr_add_exact_combined := by
  unfold ashr_add_exact_before ashr_add_exact_combined
  simp_alive_peephole
  sorry
def ashr_add_exact_fail_combined := [llvmfunc|
  llvm.func @ashr_add_exact_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-14 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_ashr_add_exact_fail   : ashr_add_exact_fail_before  ⊑  ashr_add_exact_fail_combined := by
  unfold ashr_add_exact_fail_before ashr_add_exact_fail_combined
  simp_alive_peephole
  sorry
