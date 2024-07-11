import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fabs-copysign
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fabs_copysign_before := [llvmfunc|
  llvm.func @fabs_copysign(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f64]

    llvm.return %1 : f64
  }]

def fabs_copysign_commuted_before := [llvmfunc|
  llvm.func @fabs_copysign_commuted(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f64]

    llvm.return %1 : f64
  }]

def fabs_copysign_vec_before := [llvmfunc|
  llvm.func @fabs_copysign_vec(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf64>]

    llvm.return %1 : vector<4xf64>
  }]

def fabs_copysign_vec_commuted_before := [llvmfunc|
  llvm.func @fabs_copysign_vec_commuted(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<4xf64>) -> vector<4xf64>
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf64>]

    llvm.return %1 : vector<4xf64>
  }]

def fabs_copysignf_before := [llvmfunc|
  llvm.func @fabs_copysignf(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f32]

    llvm.return %1 : f32
  }]

def fabs_copysign_use_before := [llvmfunc|
  llvm.func @fabs_copysign_use(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f64]

    llvm.return %1 : f64
  }]

def fabs_copysign_mismatch_before := [llvmfunc|
  llvm.func @fabs_copysign_mismatch(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  : f64
    llvm.return %1 : f64
  }]

def fabs_copysign_commuted_mismatch_before := [llvmfunc|
  llvm.func @fabs_copysign_commuted_mismatch(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %1 = llvm.fdiv %0, %arg0  : f64
    llvm.return %1 : f64
  }]

def fabs_copysign_no_nnan_before := [llvmfunc|
  llvm.func @fabs_copysign_no_nnan(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f64]

    llvm.return %1 : f64
  }]

def fabs_copysign_no_ninf_before := [llvmfunc|
  llvm.func @fabs_copysign_no_ninf(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    llvm.return %1 : f64
  }]

def fabs_copysign_combined := [llvmfunc|
  llvm.func @fabs_copysign(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.copysign(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f64, f64) -> f64]

theorem inst_combine_fabs_copysign   : fabs_copysign_before  ⊑  fabs_copysign_combined := by
  unfold fabs_copysign_before fabs_copysign_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_fabs_copysign   : fabs_copysign_before  ⊑  fabs_copysign_combined := by
  unfold fabs_copysign_before fabs_copysign_combined
  simp_alive_peephole
  sorry
def fabs_copysign_commuted_combined := [llvmfunc|
  llvm.func @fabs_copysign_commuted(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.copysign(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f64, f64) -> f64]

theorem inst_combine_fabs_copysign_commuted   : fabs_copysign_commuted_before  ⊑  fabs_copysign_commuted_combined := by
  unfold fabs_copysign_commuted_before fabs_copysign_commuted_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_fabs_copysign_commuted   : fabs_copysign_commuted_before  ⊑  fabs_copysign_commuted_combined := by
  unfold fabs_copysign_commuted_before fabs_copysign_commuted_combined
  simp_alive_peephole
  sorry
def fabs_copysign_vec_combined := [llvmfunc|
  llvm.func @fabs_copysign_vec(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.intr.copysign(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (vector<4xf64>, vector<4xf64>) -> vector<4xf64>]

theorem inst_combine_fabs_copysign_vec   : fabs_copysign_vec_before  ⊑  fabs_copysign_vec_combined := by
  unfold fabs_copysign_vec_before fabs_copysign_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<4xf64>
  }]

theorem inst_combine_fabs_copysign_vec   : fabs_copysign_vec_before  ⊑  fabs_copysign_vec_combined := by
  unfold fabs_copysign_vec_before fabs_copysign_vec_combined
  simp_alive_peephole
  sorry
def fabs_copysign_vec_commuted_combined := [llvmfunc|
  llvm.func @fabs_copysign_vec_commuted(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.intr.copysign(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (vector<4xf64>, vector<4xf64>) -> vector<4xf64>]

theorem inst_combine_fabs_copysign_vec_commuted   : fabs_copysign_vec_commuted_before  ⊑  fabs_copysign_vec_commuted_combined := by
  unfold fabs_copysign_vec_commuted_before fabs_copysign_vec_commuted_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<4xf64>
  }]

theorem inst_combine_fabs_copysign_vec_commuted   : fabs_copysign_vec_commuted_before  ⊑  fabs_copysign_vec_commuted_combined := by
  unfold fabs_copysign_vec_commuted_before fabs_copysign_vec_commuted_combined
  simp_alive_peephole
  sorry
def fabs_copysignf_combined := [llvmfunc|
  llvm.func @fabs_copysignf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32, f32) -> f32]

theorem inst_combine_fabs_copysignf   : fabs_copysignf_before  ⊑  fabs_copysignf_combined := by
  unfold fabs_copysignf_before fabs_copysignf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_fabs_copysignf   : fabs_copysignf_before  ⊑  fabs_copysignf_combined := by
  unfold fabs_copysignf_before fabs_copysignf_combined
  simp_alive_peephole
  sorry
def fabs_copysign_use_combined := [llvmfunc|
  llvm.func @fabs_copysign_use(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.intr.copysign(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f64, f64) -> f64]

theorem inst_combine_fabs_copysign_use   : fabs_copysign_use_before  ⊑  fabs_copysign_use_combined := by
  unfold fabs_copysign_use_before fabs_copysign_use_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_fabs_copysign_use   : fabs_copysign_use_before  ⊑  fabs_copysign_use_combined := by
  unfold fabs_copysign_use_before fabs_copysign_use_combined
  simp_alive_peephole
  sorry
def fabs_copysign_mismatch_combined := [llvmfunc|
  llvm.func @fabs_copysign_mismatch(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fabs_copysign_mismatch   : fabs_copysign_mismatch_before  ⊑  fabs_copysign_mismatch_combined := by
  unfold fabs_copysign_mismatch_before fabs_copysign_mismatch_combined
  simp_alive_peephole
  sorry
def fabs_copysign_commuted_mismatch_combined := [llvmfunc|
  llvm.func @fabs_copysign_commuted_mismatch(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %1 = llvm.fdiv %0, %arg0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fabs_copysign_commuted_mismatch   : fabs_copysign_commuted_mismatch_before  ⊑  fabs_copysign_commuted_mismatch_combined := by
  unfold fabs_copysign_commuted_mismatch_before fabs_copysign_commuted_mismatch_combined
  simp_alive_peephole
  sorry
def fabs_copysign_no_nnan_combined := [llvmfunc|
  llvm.func @fabs_copysign_no_nnan(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf>} : f64]

theorem inst_combine_fabs_copysign_no_nnan   : fabs_copysign_no_nnan_before  ⊑  fabs_copysign_no_nnan_combined := by
  unfold fabs_copysign_no_nnan_before fabs_copysign_no_nnan_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_fabs_copysign_no_nnan   : fabs_copysign_no_nnan_before  ⊑  fabs_copysign_no_nnan_combined := by
  unfold fabs_copysign_no_nnan_before fabs_copysign_no_nnan_combined
  simp_alive_peephole
  sorry
def fabs_copysign_no_ninf_combined := [llvmfunc|
  llvm.func @fabs_copysign_no_ninf(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

theorem inst_combine_fabs_copysign_no_ninf   : fabs_copysign_no_ninf_before  ⊑  fabs_copysign_no_ninf_combined := by
  unfold fabs_copysign_no_ninf_before fabs_copysign_no_ninf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_fabs_copysign_no_ninf   : fabs_copysign_no_ninf_before  ⊑  fabs_copysign_no_ninf_combined := by
  unfold fabs_copysign_no_ninf_before fabs_copysign_no_ninf_combined
  simp_alive_peephole
  sorry
