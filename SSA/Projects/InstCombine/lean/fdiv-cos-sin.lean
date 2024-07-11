import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fdiv-cos-sin
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fdiv_cos_sin_before := [llvmfunc|
  llvm.func @fdiv_cos_sin(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }]

def fdiv_strict_cos_strict_sin_reassoc_before := [llvmfunc|
  llvm.func @fdiv_strict_cos_strict_sin_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }]

def fdiv_reassoc_cos_strict_sin_strict_before := [llvmfunc|
  llvm.func @fdiv_reassoc_cos_strict_sin_strict(%arg0: f64, %arg1: !llvm.ptr {llvm.dereferenceable = 2 : i64}) -> f64 {
    %0 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_reassoc_cos_reassoc_sin_strict_before := [llvmfunc|
  llvm.func @fdiv_reassoc_cos_reassoc_sin_strict(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_cos_sin_reassoc_multiple_uses_before := [llvmfunc|
  llvm.func @fdiv_cos_sin_reassoc_multiple_uses(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def fdiv_cos_sin_reassoc_before := [llvmfunc|
  llvm.func @fdiv_cos_sin_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_cosf16_sinf16_reassoc_before := [llvmfunc|
  llvm.func @fdiv_cosf16_sinf16_reassoc(%arg0: f16) -> f16 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f16) -> f16]

    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f16) -> f16]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f16]

    llvm.return %2 : f16
  }]

def fdiv_cosf_sinf_reassoc_before := [llvmfunc|
  llvm.func @fdiv_cosf_sinf_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32) -> f32]

    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32) -> f32]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_cosfp128_sinfp128_reassoc_before := [llvmfunc|
  llvm.func @fdiv_cosfp128_sinfp128_reassoc(%arg0: f128) -> f128 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f128) -> f128]

    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f128) -> f128]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f128]

    llvm.return %2 : f128
  }]

def fdiv_cos_sin_combined := [llvmfunc|
  llvm.func @fdiv_cos_sin(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_cos_sin   : fdiv_cos_sin_before  ⊑  fdiv_cos_sin_combined := by
  unfold fdiv_cos_sin_before fdiv_cos_sin_combined
  simp_alive_peephole
  sorry
def fdiv_strict_cos_strict_sin_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_strict_cos_strict_sin_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_strict_cos_strict_sin_reassoc   : fdiv_strict_cos_strict_sin_reassoc_before  ⊑  fdiv_strict_cos_strict_sin_reassoc_combined := by
  unfold fdiv_strict_cos_strict_sin_reassoc_before fdiv_strict_cos_strict_sin_reassoc_combined
  simp_alive_peephole
  sorry
def fdiv_reassoc_cos_strict_sin_strict_combined := [llvmfunc|
  llvm.func @fdiv_reassoc_cos_strict_sin_strict(%arg0: f64, %arg1: !llvm.ptr {llvm.dereferenceable = 2 : i64}) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @tan(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_reassoc_cos_strict_sin_strict   : fdiv_reassoc_cos_strict_sin_strict_before  ⊑  fdiv_reassoc_cos_strict_sin_strict_combined := by
  unfold fdiv_reassoc_cos_strict_sin_strict_before fdiv_reassoc_cos_strict_sin_strict_combined
  simp_alive_peephole
  sorry
def fdiv_reassoc_cos_reassoc_sin_strict_combined := [llvmfunc|
  llvm.func @fdiv_reassoc_cos_reassoc_sin_strict(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @tan(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_reassoc_cos_reassoc_sin_strict   : fdiv_reassoc_cos_reassoc_sin_strict_before  ⊑  fdiv_reassoc_cos_reassoc_sin_strict_combined := by
  unfold fdiv_reassoc_cos_reassoc_sin_strict_before fdiv_reassoc_cos_reassoc_sin_strict_combined
  simp_alive_peephole
  sorry
def fdiv_cos_sin_reassoc_multiple_uses_combined := [llvmfunc|
  llvm.func @fdiv_cos_sin_reassoc_multiple_uses(%arg0: f64) -> f64 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_cos_sin_reassoc_multiple_uses   : fdiv_cos_sin_reassoc_multiple_uses_before  ⊑  fdiv_cos_sin_reassoc_multiple_uses_combined := by
  unfold fdiv_cos_sin_reassoc_multiple_uses_before fdiv_cos_sin_reassoc_multiple_uses_combined
  simp_alive_peephole
  sorry
def fdiv_cos_sin_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_cos_sin_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @tan(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_cos_sin_reassoc   : fdiv_cos_sin_reassoc_before  ⊑  fdiv_cos_sin_reassoc_combined := by
  unfold fdiv_cos_sin_reassoc_before fdiv_cos_sin_reassoc_combined
  simp_alive_peephole
  sorry
def fdiv_cosf16_sinf16_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_cosf16_sinf16_reassoc(%arg0: f16) -> f16 {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f16) -> f16
    %1 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f16) -> f16
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f16
    llvm.return %2 : f16
  }]

theorem inst_combine_fdiv_cosf16_sinf16_reassoc   : fdiv_cosf16_sinf16_reassoc_before  ⊑  fdiv_cosf16_sinf16_reassoc_combined := by
  unfold fdiv_cosf16_sinf16_reassoc_before fdiv_cosf16_sinf16_reassoc_combined
  simp_alive_peephole
  sorry
def fdiv_cosf_sinf_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_cosf_sinf_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @tanf(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f32) -> f32
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_cosf_sinf_reassoc   : fdiv_cosf_sinf_reassoc_before  ⊑  fdiv_cosf_sinf_reassoc_combined := by
  unfold fdiv_cosf_sinf_reassoc_before fdiv_cosf_sinf_reassoc_combined
  simp_alive_peephole
  sorry
def fdiv_cosfp128_sinfp128_reassoc_combined := [llvmfunc|
  llvm.func @fdiv_cosfp128_sinfp128_reassoc(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(1.000000e+00 : f128) : f128
    %1 = llvm.call @tanl(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f128) -> f128
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f128
    llvm.return %2 : f128
  }]

theorem inst_combine_fdiv_cosfp128_sinfp128_reassoc   : fdiv_cosfp128_sinfp128_reassoc_before  ⊑  fdiv_cosfp128_sinfp128_reassoc_combined := by
  unfold fdiv_cosfp128_sinfp128_reassoc_before fdiv_cosfp128_sinfp128_reassoc_combined
  simp_alive_peephole
  sorry
