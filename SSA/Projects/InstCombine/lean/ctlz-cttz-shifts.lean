import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ctlz-cttz-shifts
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def lshr_ctlz_true_before := [llvmfunc|
  llvm.func @lshr_ctlz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def shl_nuw_ctlz_true_before := [llvmfunc|
  llvm.func @shl_nuw_ctlz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def shl_nuw_nsw_ctlz_true_before := [llvmfunc|
  llvm.func @shl_nuw_nsw_ctlz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def lshr_exact_cttz_true_before := [llvmfunc|
  llvm.func @lshr_exact_cttz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def shl_cttz_true_before := [llvmfunc|
  llvm.func @shl_cttz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def vec2_lshr_ctlz_true_before := [llvmfunc|
  llvm.func @vec2_lshr_ctlz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def vec2_shl_nuw_ctlz_true_before := [llvmfunc|
  llvm.func @vec2_shl_nuw_ctlz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def vec2_shl_nuw_nsw_ctlz_true_before := [llvmfunc|
  llvm.func @vec2_shl_nuw_nsw_ctlz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def vec2_lshr_exact_cttz_true_before := [llvmfunc|
  llvm.func @vec2_lshr_exact_cttz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def vec2_shl_cttz_true_before := [llvmfunc|
  llvm.func @vec2_shl_cttz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def vec2_shl_nsw_ctlz_true_neg_before := [llvmfunc|
  llvm.func @vec2_shl_nsw_ctlz_true_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def vec2_lshr_ctlz_false_neg_before := [llvmfunc|
  llvm.func @vec2_lshr_ctlz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def vec2_shl_ctlz_false_neg_before := [llvmfunc|
  llvm.func @vec2_shl_ctlz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def vec2_lshr_cttz_false_neg_before := [llvmfunc|
  llvm.func @vec2_lshr_cttz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def vec2_shl_cttz_false_neg_before := [llvmfunc|
  llvm.func @vec2_shl_cttz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

    llvm.return %2 : vector<2xi32>
  }]

def lshr_ctlz_faslse_neg_before := [llvmfunc|
  llvm.func @lshr_ctlz_faslse_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def shl_ctlz_false_neg_before := [llvmfunc|
  llvm.func @shl_ctlz_false_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def lshr_cttz_false_neg_before := [llvmfunc|
  llvm.func @lshr_cttz_false_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def shl_cttz_false_neg_before := [llvmfunc|
  llvm.func @shl_cttz_false_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def lshr_ctlz_true_combined := [llvmfunc|
  llvm.func @lshr_ctlz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_lshr_ctlz_true   : lshr_ctlz_true_before  ⊑  lshr_ctlz_true_combined := by
  unfold lshr_ctlz_true_before lshr_ctlz_true_combined
  simp_alive_peephole
  sorry
def shl_nuw_ctlz_true_combined := [llvmfunc|
  llvm.func @shl_nuw_ctlz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_nuw_ctlz_true   : shl_nuw_ctlz_true_before  ⊑  shl_nuw_ctlz_true_combined := by
  unfold shl_nuw_ctlz_true_before shl_nuw_ctlz_true_combined
  simp_alive_peephole
  sorry
def shl_nuw_nsw_ctlz_true_combined := [llvmfunc|
  llvm.func @shl_nuw_nsw_ctlz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_nuw_nsw_ctlz_true   : shl_nuw_nsw_ctlz_true_before  ⊑  shl_nuw_nsw_ctlz_true_combined := by
  unfold shl_nuw_nsw_ctlz_true_before shl_nuw_nsw_ctlz_true_combined
  simp_alive_peephole
  sorry
def lshr_exact_cttz_true_combined := [llvmfunc|
  llvm.func @lshr_exact_cttz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_lshr_exact_cttz_true   : lshr_exact_cttz_true_before  ⊑  lshr_exact_cttz_true_combined := by
  unfold lshr_exact_cttz_true_before lshr_exact_cttz_true_combined
  simp_alive_peephole
  sorry
def shl_cttz_true_combined := [llvmfunc|
  llvm.func @shl_cttz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_cttz_true   : shl_cttz_true_before  ⊑  shl_cttz_true_combined := by
  unfold shl_cttz_true_before shl_cttz_true_combined
  simp_alive_peephole
  sorry
def vec2_lshr_ctlz_true_combined := [llvmfunc|
  llvm.func @vec2_lshr_ctlz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_vec2_lshr_ctlz_true   : vec2_lshr_ctlz_true_before  ⊑  vec2_lshr_ctlz_true_combined := by
  unfold vec2_lshr_ctlz_true_before vec2_lshr_ctlz_true_combined
  simp_alive_peephole
  sorry
def vec2_shl_nuw_ctlz_true_combined := [llvmfunc|
  llvm.func @vec2_shl_nuw_ctlz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_vec2_shl_nuw_ctlz_true   : vec2_shl_nuw_ctlz_true_before  ⊑  vec2_shl_nuw_ctlz_true_combined := by
  unfold vec2_shl_nuw_ctlz_true_before vec2_shl_nuw_ctlz_true_combined
  simp_alive_peephole
  sorry
def vec2_shl_nuw_nsw_ctlz_true_combined := [llvmfunc|
  llvm.func @vec2_shl_nuw_nsw_ctlz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_vec2_shl_nuw_nsw_ctlz_true   : vec2_shl_nuw_nsw_ctlz_true_before  ⊑  vec2_shl_nuw_nsw_ctlz_true_combined := by
  unfold vec2_shl_nuw_nsw_ctlz_true_before vec2_shl_nuw_nsw_ctlz_true_combined
  simp_alive_peephole
  sorry
def vec2_lshr_exact_cttz_true_combined := [llvmfunc|
  llvm.func @vec2_lshr_exact_cttz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %0, %arg0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_vec2_lshr_exact_cttz_true   : vec2_lshr_exact_cttz_true_before  ⊑  vec2_lshr_exact_cttz_true_combined := by
  unfold vec2_lshr_exact_cttz_true_before vec2_lshr_exact_cttz_true_combined
  simp_alive_peephole
  sorry
def vec2_shl_cttz_true_combined := [llvmfunc|
  llvm.func @vec2_shl_cttz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[10, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_vec2_shl_cttz_true   : vec2_shl_cttz_true_before  ⊑  vec2_shl_cttz_true_combined := by
  unfold vec2_shl_cttz_true_before vec2_shl_cttz_true_combined
  simp_alive_peephole
  sorry
def vec2_shl_nsw_ctlz_true_neg_combined := [llvmfunc|
  llvm.func @vec2_shl_nsw_ctlz_true_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_vec2_shl_nsw_ctlz_true_neg   : vec2_shl_nsw_ctlz_true_neg_before  ⊑  vec2_shl_nsw_ctlz_true_neg_combined := by
  unfold vec2_shl_nsw_ctlz_true_neg_before vec2_shl_nsw_ctlz_true_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_vec2_shl_nsw_ctlz_true_neg   : vec2_shl_nsw_ctlz_true_neg_before  ⊑  vec2_shl_nsw_ctlz_true_neg_combined := by
  unfold vec2_shl_nsw_ctlz_true_neg_before vec2_shl_nsw_ctlz_true_neg_combined
  simp_alive_peephole
  sorry
def vec2_lshr_ctlz_false_neg_combined := [llvmfunc|
  llvm.func @vec2_lshr_ctlz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_vec2_lshr_ctlz_false_neg   : vec2_lshr_ctlz_false_neg_before  ⊑  vec2_lshr_ctlz_false_neg_combined := by
  unfold vec2_lshr_ctlz_false_neg_before vec2_lshr_ctlz_false_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_vec2_lshr_ctlz_false_neg   : vec2_lshr_ctlz_false_neg_before  ⊑  vec2_lshr_ctlz_false_neg_combined := by
  unfold vec2_lshr_ctlz_false_neg_before vec2_lshr_ctlz_false_neg_combined
  simp_alive_peephole
  sorry
def vec2_shl_ctlz_false_neg_combined := [llvmfunc|
  llvm.func @vec2_shl_ctlz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_vec2_shl_ctlz_false_neg   : vec2_shl_ctlz_false_neg_before  ⊑  vec2_shl_ctlz_false_neg_combined := by
  unfold vec2_shl_ctlz_false_neg_before vec2_shl_ctlz_false_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_vec2_shl_ctlz_false_neg   : vec2_shl_ctlz_false_neg_before  ⊑  vec2_shl_ctlz_false_neg_combined := by
  unfold vec2_shl_ctlz_false_neg_before vec2_shl_ctlz_false_neg_combined
  simp_alive_peephole
  sorry
def vec2_lshr_cttz_false_neg_combined := [llvmfunc|
  llvm.func @vec2_lshr_cttz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_vec2_lshr_cttz_false_neg   : vec2_lshr_cttz_false_neg_before  ⊑  vec2_lshr_cttz_false_neg_combined := by
  unfold vec2_lshr_cttz_false_neg_before vec2_lshr_cttz_false_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_vec2_lshr_cttz_false_neg   : vec2_lshr_cttz_false_neg_before  ⊑  vec2_lshr_cttz_false_neg_combined := by
  unfold vec2_lshr_cttz_false_neg_before vec2_lshr_cttz_false_neg_combined
  simp_alive_peephole
  sorry
def vec2_shl_cttz_false_neg_combined := [llvmfunc|
  llvm.func @vec2_shl_cttz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>]

theorem inst_combine_vec2_shl_cttz_false_neg   : vec2_shl_cttz_false_neg_before  ⊑  vec2_shl_cttz_false_neg_combined := by
  unfold vec2_shl_cttz_false_neg_before vec2_shl_cttz_false_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_vec2_shl_cttz_false_neg   : vec2_shl_cttz_false_neg_before  ⊑  vec2_shl_cttz_false_neg_combined := by
  unfold vec2_shl_cttz_false_neg_before vec2_shl_cttz_false_neg_combined
  simp_alive_peephole
  sorry
def lshr_ctlz_faslse_neg_combined := [llvmfunc|
  llvm.func @lshr_ctlz_faslse_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_lshr_ctlz_faslse_neg   : lshr_ctlz_faslse_neg_before  ⊑  lshr_ctlz_faslse_neg_combined := by
  unfold lshr_ctlz_faslse_neg_before lshr_ctlz_faslse_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr_ctlz_faslse_neg   : lshr_ctlz_faslse_neg_before  ⊑  lshr_ctlz_faslse_neg_combined := by
  unfold lshr_ctlz_faslse_neg_before lshr_ctlz_faslse_neg_combined
  simp_alive_peephole
  sorry
def shl_ctlz_false_neg_combined := [llvmfunc|
  llvm.func @shl_ctlz_false_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_shl_ctlz_false_neg   : shl_ctlz_false_neg_before  ⊑  shl_ctlz_false_neg_combined := by
  unfold shl_ctlz_false_neg_before shl_ctlz_false_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_ctlz_false_neg   : shl_ctlz_false_neg_before  ⊑  shl_ctlz_false_neg_combined := by
  unfold shl_ctlz_false_neg_before shl_ctlz_false_neg_combined
  simp_alive_peephole
  sorry
def lshr_cttz_false_neg_combined := [llvmfunc|
  llvm.func @lshr_cttz_false_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_lshr_cttz_false_neg   : lshr_cttz_false_neg_before  ⊑  lshr_cttz_false_neg_combined := by
  unfold lshr_cttz_false_neg_before lshr_cttz_false_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr_cttz_false_neg   : lshr_cttz_false_neg_before  ⊑  lshr_cttz_false_neg_combined := by
  unfold lshr_cttz_false_neg_before lshr_cttz_false_neg_combined
  simp_alive_peephole
  sorry
def shl_cttz_false_neg_combined := [llvmfunc|
  llvm.func @shl_cttz_false_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_shl_cttz_false_neg   : shl_cttz_false_neg_before  ⊑  shl_cttz_false_neg_combined := by
  unfold shl_cttz_false_neg_before shl_cttz_false_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_cttz_false_neg   : shl_cttz_false_neg_before  ⊑  shl_cttz_false_neg_combined := by
  unfold shl_cttz_false_neg_before shl_cttz_false_neg_combined
  simp_alive_peephole
  sorry
