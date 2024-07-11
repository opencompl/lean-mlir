import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  log-pow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def log_pow_before := [llvmfunc|
  llvm.func @log_pow(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @pow(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def log_powi_const_before := [llvmfunc|
  llvm.func @log_powi_const(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

    %2 = llvm.call @log(%1) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def log_powi_nonconst_before := [llvmfunc|
  llvm.func @log_powi_nonconst(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def logf64_powi_nonconst_before := [llvmfunc|
  llvm.func @logf64_powi_nonconst(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64]

    %1 = llvm.intr.log(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def logf_powfi_const_before := [llvmfunc|
  llvm.func @logf_powfi_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, i32) -> f32]

    %2 = llvm.call @logf(%1) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %2 : f32
  }]

def logf_powfi_nonconst_before := [llvmfunc|
  llvm.func @logf_powfi_nonconst(%arg0: f32, %arg1: i32) -> f32 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, i32) -> f32]

    %1 = llvm.call @logf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def log_powi_not_fast_before := [llvmfunc|
  llvm.func @log_powi_not_fast(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def log10f_powf_before := [llvmfunc|
  llvm.func @log10f_powf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @powf(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    %1 = llvm.intr.log10(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def log2v_powv_before := [llvmfunc|
  llvm.func @log2v_powv(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    %1 = llvm.intr.log2(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def log_pow_not_fast_before := [llvmfunc|
  llvm.func @log_pow_not_fast(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @pow(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def function_pointer_before := [llvmfunc|
  llvm.func @function_pointer(%arg0: !llvm.ptr, %arg1: f32) -> f32 {
    %0 = llvm.call %arg0() : !llvm.ptr, () -> f32
    %1 = llvm.call @logf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def log10_exp_before := [llvmfunc|
  llvm.func @log10_exp(%arg0: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %1 = llvm.call @log10(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def logv_exp2v_before := [llvmfunc|
  llvm.func @logv_exp2v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.exp2(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>) -> vector<2xf32>]

    %1 = llvm.intr.log(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>) -> vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def log2f_exp10f_before := [llvmfunc|
  llvm.func @log2f_exp10f(%arg0: f32) -> f32 {
    %0 = llvm.call @exp10f(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.call @log2f(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def log_exp2_not_fast_before := [llvmfunc|
  llvm.func @log_exp2_not_fast(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def pr43617_before := [llvmfunc|
  llvm.func @pr43617(%arg0: f64, %arg1: i32, %arg2: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call %arg2(%arg1) {fastmathFlags = #llvm.fastmath<fast>} : !llvm.ptr, (i32) -> f64]

    %3 = llvm.intr.log(%2)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %4 = llvm.fmul %3, %1  : f64
    llvm.return %4 : f64
  }]

def log_pow_combined := [llvmfunc|
  llvm.func @log_pow(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.log(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_log_pow   : log_pow_before  ⊑  log_pow_combined := by
  unfold log_pow_before log_pow_combined
  simp_alive_peephole
  sorry
def log_powi_const_combined := [llvmfunc|
  llvm.func @log_powi_const(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-3.000000e+00 : f64) : f64
    %1 = llvm.intr.log(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_log_powi_const   : log_powi_const_before  ⊑  log_powi_const_combined := by
  unfold log_powi_const_before log_powi_const_combined
  simp_alive_peephole
  sorry
def log_powi_nonconst_combined := [llvmfunc|
  llvm.func @log_powi_nonconst(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.log(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.sitofp %arg1 : i32 to f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_log_powi_nonconst   : log_powi_nonconst_before  ⊑  log_powi_nonconst_combined := by
  unfold log_powi_nonconst_before log_powi_nonconst_combined
  simp_alive_peephole
  sorry
def logf64_powi_nonconst_combined := [llvmfunc|
  llvm.func @logf64_powi_nonconst(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.log(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.sitofp %arg1 : i32 to f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_logf64_powi_nonconst   : logf64_powi_nonconst_before  ⊑  logf64_powi_nonconst_combined := by
  unfold logf64_powi_nonconst_before logf64_powi_nonconst_combined
  simp_alive_peephole
  sorry
def logf_powfi_const_combined := [llvmfunc|
  llvm.func @logf_powfi_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-3.000000e+00 : f32) : f32
    %1 = llvm.intr.log(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_logf_powfi_const   : logf_powfi_const_before  ⊑  logf_powfi_const_combined := by
  unfold logf_powfi_const_before logf_powfi_const_combined
  simp_alive_peephole
  sorry
def logf_powfi_nonconst_combined := [llvmfunc|
  llvm.func @logf_powfi_nonconst(%arg0: f32, %arg1: i32) -> f32 {
    %0 = llvm.intr.log(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.sitofp %arg1 : i32 to f32
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_logf_powfi_nonconst   : logf_powfi_nonconst_before  ⊑  logf_powfi_nonconst_combined := by
  unfold logf_powfi_nonconst_before logf_powfi_nonconst_combined
  simp_alive_peephole
  sorry
def log_powi_not_fast_combined := [llvmfunc|
  llvm.func @log_powi_not_fast(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  : (f64, i32) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_log_powi_not_fast   : log_powi_not_fast_before  ⊑  log_powi_not_fast_combined := by
  unfold log_powi_not_fast_before log_powi_not_fast_combined
  simp_alive_peephole
  sorry
def log10f_powf_combined := [llvmfunc|
  llvm.func @log10f_powf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.log10(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_log10f_powf   : log10f_powf_before  ⊑  log10f_powf_combined := by
  unfold log10f_powf_before log10f_powf_combined
  simp_alive_peephole
  sorry
def log2v_powv_combined := [llvmfunc|
  llvm.func @log2v_powv(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.intr.log2(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>) -> vector<2xf64>
    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_log2v_powv   : log2v_powv_before  ⊑  log2v_powv_combined := by
  unfold log2v_powv_before log2v_powv_combined
  simp_alive_peephole
  sorry
def log_pow_not_fast_combined := [llvmfunc|
  llvm.func @log_pow_not_fast(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @pow(%arg0, %arg1) : (f64, f64) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_log_pow_not_fast   : log_pow_not_fast_before  ⊑  log_pow_not_fast_combined := by
  unfold log_pow_not_fast_before log_pow_not_fast_combined
  simp_alive_peephole
  sorry
def function_pointer_combined := [llvmfunc|
  llvm.func @function_pointer(%arg0: !llvm.ptr, %arg1: f32) -> f32 {
    %0 = llvm.call %arg0() : !llvm.ptr, () -> f32
    %1 = llvm.call @logf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_function_pointer   : function_pointer_before  ⊑  function_pointer_combined := by
  unfold function_pointer_before function_pointer_combined
  simp_alive_peephole
  sorry
def log10_exp_combined := [llvmfunc|
  llvm.func @log10_exp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.43429448190325182 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_log10_exp   : log10_exp_before  ⊑  log10_exp_combined := by
  unfold log10_exp_before log10_exp_combined
  simp_alive_peephole
  sorry
def logv_exp2v_combined := [llvmfunc|
  llvm.func @logv_exp2v(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<0.693147182> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_logv_exp2v   : logv_exp2v_before  ⊑  logv_exp2v_combined := by
  unfold logv_exp2v_before logv_exp2v_combined
  simp_alive_peephole
  sorry
def log2f_exp10f_combined := [llvmfunc|
  llvm.func @log2f_exp10f(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.32192802 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_log2f_exp10f   : log2f_exp10f_before  ⊑  log2f_exp10f_combined := by
  unfold log2f_exp10f_before log2f_exp10f_combined
  simp_alive_peephole
  sorry
def log_exp2_not_fast_combined := [llvmfunc|
  llvm.func @log_exp2_not_fast(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_log_exp2_not_fast   : log_exp2_not_fast_before  ⊑  log_exp2_not_fast_combined := by
  unfold log_exp2_not_fast_before log_exp2_not_fast_combined
  simp_alive_peephole
  sorry
def pr43617_combined := [llvmfunc|
  llvm.func @pr43617(%arg0: f64, %arg1: i32, %arg2: !llvm.ptr) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call %arg2(%arg1) {fastmathFlags = #llvm.fastmath<fast>} : !llvm.ptr, (i32) -> f64
    %2 = llvm.intr.log(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %3 = llvm.fmul %2, %0  : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pr43617   : pr43617_before  ⊑  pr43617_combined := by
  unfold pr43617_before pr43617_combined
  simp_alive_peephole
  sorry
