import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fdiv-sin-cos
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fdiv_sin_cos_before := [llvmfunc|
  llvm.func @fdiv_sin_cos(%arg0: f64) -> f64 {
    %0 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %1 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }]

def fdiv_strict_sin_strict_cos_reassoc_before := [llvmfunc|
  llvm.func @fdiv_strict_sin_strict_cos_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %1 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }]

def fdiv_reassoc_sin_strict_cos_strict_before := [llvmfunc|
  llvm.func @fdiv_reassoc_sin_strict_cos_strict(%arg0: f64, %arg1: !llvm.ptr {llvm.dereferenceable = 2 : i64}) -> f64 {
    %0 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %1 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_reassoc_sin_reassoc_cos_strict_before := [llvmfunc|
  llvm.func @fdiv_reassoc_sin_reassoc_cos_strict(%arg0: f64) -> f64 {
    %0 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_sin_cos_reassoc_multiple_uses_before := [llvmfunc|
  llvm.func @fdiv_sin_cos_reassoc_multiple_uses(%arg0: f64) -> f64 {
    %0 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def fdiv_sin_cos_reassoc_before := [llvmfunc|
  llvm.func @fdiv_sin_cos_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_sinf_cosf_reassoc_before := [llvmfunc|
  llvm.func @fdiv_sinf_cosf_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32) -> f32]

    %1 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32) -> f32]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_sinfp128_cosfp128_reassoc_before := [llvmfunc|
  llvm.func @fdiv_sinfp128_cosfp128_reassoc(%arg0: f128) -> f128 {
    %0 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f128) -> f128]

    %1 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f128) -> f128]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f128]

    llvm.return %2 : f128
  }]

def fdiv_sin_cos_combined := [llvmfunc|
  llvm.func @fdiv_sin_cos(%arg0: f64) -> f64 {
    %0 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %1 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_sin_cos   : fdiv_sin_cos_before  ⊑  fdiv_sin_cos_combined := by
  unfold fdiv_sin_cos_before fdiv_sin_cos_combined
  simp_alive_peephole
  sorry
def fdiv_strict_sin_strict_cos_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_strict_sin_strict_cos_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %1 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_fdiv_strict_sin_strict_cos_reassoc   : fdiv_strict_sin_strict_cos_reassoc_before  ⊑  fdiv_strict_sin_strict_cos_reassoc_combined := by
  unfold fdiv_strict_sin_strict_cos_reassoc_before fdiv_strict_sin_strict_cos_reassoc_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_strict_sin_strict_cos_reassoc   : fdiv_strict_sin_strict_cos_reassoc_before  ⊑  fdiv_strict_sin_strict_cos_reassoc_combined := by
  unfold fdiv_strict_sin_strict_cos_reassoc_before fdiv_strict_sin_strict_cos_reassoc_combined
  simp_alive_peephole
  sorry
def fdiv_reassoc_sin_strict_cos_strict_combined := [llvmfunc|
  llvm.func @fdiv_reassoc_sin_strict_cos_strict(%arg0: f64, %arg1: !llvm.ptr {llvm.dereferenceable = 2 : i64}) -> f64 {
    %0 = llvm.call @tan(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_fdiv_reassoc_sin_strict_cos_strict   : fdiv_reassoc_sin_strict_cos_strict_before  ⊑  fdiv_reassoc_sin_strict_cos_strict_combined := by
  unfold fdiv_reassoc_sin_strict_cos_strict_before fdiv_reassoc_sin_strict_cos_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f64
  }]

theorem inst_combine_fdiv_reassoc_sin_strict_cos_strict   : fdiv_reassoc_sin_strict_cos_strict_before  ⊑  fdiv_reassoc_sin_strict_cos_strict_combined := by
  unfold fdiv_reassoc_sin_strict_cos_strict_before fdiv_reassoc_sin_strict_cos_strict_combined
  simp_alive_peephole
  sorry
def fdiv_reassoc_sin_reassoc_cos_strict_combined := [llvmfunc|
  llvm.func @fdiv_reassoc_sin_reassoc_cos_strict(%arg0: f64) -> f64 {
    %0 = llvm.call @tan(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_fdiv_reassoc_sin_reassoc_cos_strict   : fdiv_reassoc_sin_reassoc_cos_strict_before  ⊑  fdiv_reassoc_sin_reassoc_cos_strict_combined := by
  unfold fdiv_reassoc_sin_reassoc_cos_strict_before fdiv_reassoc_sin_reassoc_cos_strict_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f64
  }]

theorem inst_combine_fdiv_reassoc_sin_reassoc_cos_strict   : fdiv_reassoc_sin_reassoc_cos_strict_before  ⊑  fdiv_reassoc_sin_reassoc_cos_strict_combined := by
  unfold fdiv_reassoc_sin_reassoc_cos_strict_before fdiv_reassoc_sin_reassoc_cos_strict_combined
  simp_alive_peephole
  sorry
def fdiv_sin_cos_reassoc_multiple_uses_combined := [llvmfunc|
  llvm.func @fdiv_sin_cos_reassoc_multiple_uses(%arg0: f64) -> f64 {
    %0 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_fdiv_sin_cos_reassoc_multiple_uses   : fdiv_sin_cos_reassoc_multiple_uses_before  ⊑  fdiv_sin_cos_reassoc_multiple_uses_combined := by
  unfold fdiv_sin_cos_reassoc_multiple_uses_before fdiv_sin_cos_reassoc_multiple_uses_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_fdiv_sin_cos_reassoc_multiple_uses   : fdiv_sin_cos_reassoc_multiple_uses_before  ⊑  fdiv_sin_cos_reassoc_multiple_uses_combined := by
  unfold fdiv_sin_cos_reassoc_multiple_uses_before fdiv_sin_cos_reassoc_multiple_uses_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fdiv_sin_cos_reassoc_multiple_uses   : fdiv_sin_cos_reassoc_multiple_uses_before  ⊑  fdiv_sin_cos_reassoc_multiple_uses_combined := by
  unfold fdiv_sin_cos_reassoc_multiple_uses_before fdiv_sin_cos_reassoc_multiple_uses_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_sin_cos_reassoc_multiple_uses   : fdiv_sin_cos_reassoc_multiple_uses_before  ⊑  fdiv_sin_cos_reassoc_multiple_uses_combined := by
  unfold fdiv_sin_cos_reassoc_multiple_uses_before fdiv_sin_cos_reassoc_multiple_uses_combined
  simp_alive_peephole
  sorry
def fdiv_sin_cos_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_sin_cos_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.call @tan(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_fdiv_sin_cos_reassoc   : fdiv_sin_cos_reassoc_before  ⊑  fdiv_sin_cos_reassoc_combined := by
  unfold fdiv_sin_cos_reassoc_before fdiv_sin_cos_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f64
  }]

theorem inst_combine_fdiv_sin_cos_reassoc   : fdiv_sin_cos_reassoc_before  ⊑  fdiv_sin_cos_reassoc_combined := by
  unfold fdiv_sin_cos_reassoc_before fdiv_sin_cos_reassoc_combined
  simp_alive_peephole
  sorry
def fdiv_sinf_cosf_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_sinf_cosf_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.call @tanf(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f32) -> f32]

theorem inst_combine_fdiv_sinf_cosf_reassoc   : fdiv_sinf_cosf_reassoc_before  ⊑  fdiv_sinf_cosf_reassoc_combined := by
  unfold fdiv_sinf_cosf_reassoc_before fdiv_sinf_cosf_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_fdiv_sinf_cosf_reassoc   : fdiv_sinf_cosf_reassoc_before  ⊑  fdiv_sinf_cosf_reassoc_combined := by
  unfold fdiv_sinf_cosf_reassoc_before fdiv_sinf_cosf_reassoc_combined
  simp_alive_peephole
  sorry
def fdiv_sinfp128_cosfp128_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_sinfp128_cosfp128_reassoc(%arg0: f128) -> f128 {
    %0 = llvm.call @tanl(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f128) -> f128]

theorem inst_combine_fdiv_sinfp128_cosfp128_reassoc   : fdiv_sinfp128_cosfp128_reassoc_before  ⊑  fdiv_sinfp128_cosfp128_reassoc_combined := by
  unfold fdiv_sinfp128_cosfp128_reassoc_before fdiv_sinfp128_cosfp128_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f128
  }]

theorem inst_combine_fdiv_sinfp128_cosfp128_reassoc   : fdiv_sinfp128_cosfp128_reassoc_before  ⊑  fdiv_sinfp128_cosfp128_reassoc_combined := by
  unfold fdiv_sinfp128_cosfp128_reassoc_before fdiv_sinfp128_cosfp128_reassoc_combined
  simp_alive_peephole
  sorry
