import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow-sqrt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pow_libcall_half_no_FMF_before := [llvmfunc|
  llvm.func @pow_libcall_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def pow_intrinsic_half_no_FMF_before := [llvmfunc|
  llvm.func @pow_intrinsic_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def pow_libcall_half_approx_before := [llvmfunc|
  llvm.func @pow_libcall_half_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_intrinsic_half_approx_before := [llvmfunc|
  llvm.func @pow_intrinsic_half_approx(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def powf_intrinsic_half_fast_before := [llvmfunc|
  llvm.func @powf_intrinsic_half_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_libcall_half_no_FMF_base_ninf_before := [llvmfunc|
  llvm.func @pow_libcall_half_no_FMF_base_ninf(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.call @pow(%1, %0) : (f64, f64) -> f64
    llvm.return %2 : f64
  }]

def pow_libcall_half_ninf_before := [llvmfunc|
  llvm.func @pow_libcall_half_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_intrinsic_half_ninf_before := [llvmfunc|
  llvm.func @pow_intrinsic_half_ninf(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def pow_libcall_half_nsz_before := [llvmfunc|
  llvm.func @pow_libcall_half_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<nsz>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_intrinsic_half_nsz_before := [llvmfunc|
  llvm.func @pow_intrinsic_half_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_libcall_half_ninf_nsz_before := [llvmfunc|
  llvm.func @pow_libcall_half_ninf_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf, nsz>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_intrinsic_half_ninf_nsz_before := [llvmfunc|
  llvm.func @pow_intrinsic_half_ninf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_libcall_half_fast_before := [llvmfunc|
  llvm.func @pow_libcall_half_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_intrinsic_half_fast_before := [llvmfunc|
  llvm.func @pow_intrinsic_half_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_libcall_neghalf_no_FMF_before := [llvmfunc|
  llvm.func @pow_libcall_neghalf_no_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def pow_libcall_neghalf_reassoc_ninf_before := [llvmfunc|
  llvm.func @pow_libcall_neghalf_reassoc_ninf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_libcall_neghalf_afn_before := [llvmfunc|
  llvm.func @pow_libcall_neghalf_afn(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_intrinsic_neghalf_no_FMF_before := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_no_FMF(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

def pow_intrinsic_neghalf_reassoc_before := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_reassoc(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def pow_intrinsic_neghalf_afn_before := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_afn(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def pow_libcall_neghalf_ninf_before := [llvmfunc|
  llvm.func @pow_libcall_neghalf_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_intrinsic_neghalf_ninf_before := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_ninf(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf, afn>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def pow_libcall_neghalf_nsz_before := [llvmfunc|
  llvm.func @pow_libcall_neghalf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<nsz, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_intrinsic_neghalf_nsz_before := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nsz, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_intrinsic_neghalf_ninf_nsz_before := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_ninf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf, nsz, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_libcall_neghalf_ninf_nsz_before := [llvmfunc|
  llvm.func @pow_libcall_neghalf_ninf_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf, nsz, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_libcall_neghalf_fast_before := [llvmfunc|
  llvm.func @pow_libcall_neghalf_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_intrinsic_neghalf_fast_before := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_libcall_half_no_FMF_combined := [llvmfunc|
  llvm.func @pow_libcall_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_libcall_half_no_FMF   : pow_libcall_half_no_FMF_before  ⊑  pow_libcall_half_no_FMF_combined := by
  unfold pow_libcall_half_no_FMF_before pow_libcall_half_no_FMF_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_half_no_FMF_combined := [llvmfunc|
  llvm.func @pow_intrinsic_half_no_FMF(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %2 = llvm.intr.sqrt(%arg0)  : (f64) -> f64
    %3 = llvm.intr.fabs(%2)  : (f64) -> f64
    %4 = llvm.fcmp "oeq" %arg0, %0 : f64
    %5 = llvm.select %4, %1, %3 : i1, f64
    llvm.return %5 : f64
  }]

theorem inst_combine_pow_intrinsic_half_no_FMF   : pow_intrinsic_half_no_FMF_before  ⊑  pow_intrinsic_half_no_FMF_combined := by
  unfold pow_intrinsic_half_no_FMF_before pow_intrinsic_half_no_FMF_combined
  simp_alive_peephole
  sorry
def pow_libcall_half_approx_combined := [llvmfunc|
  llvm.func @pow_libcall_half_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

theorem inst_combine_pow_libcall_half_approx   : pow_libcall_half_approx_before  ⊑  pow_libcall_half_approx_combined := by
  unfold pow_libcall_half_approx_before pow_libcall_half_approx_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_libcall_half_approx   : pow_libcall_half_approx_before  ⊑  pow_libcall_half_approx_combined := by
  unfold pow_libcall_half_approx_before pow_libcall_half_approx_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_half_approx_combined := [llvmfunc|
  llvm.func @pow_intrinsic_half_approx(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0xFFF0000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<0x7FF0000000000000> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<afn>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_half_approx   : pow_intrinsic_half_approx_before  ⊑  pow_intrinsic_half_approx_combined := by
  unfold pow_intrinsic_half_approx_before pow_intrinsic_half_approx_combined
  simp_alive_peephole
  sorry
    %3 = llvm.intr.fabs(%2)  {fastmathFlags = #llvm.fastmath<afn>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_half_approx   : pow_intrinsic_half_approx_before  ⊑  pow_intrinsic_half_approx_combined := by
  unfold pow_intrinsic_half_approx_before pow_intrinsic_half_approx_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fcmp "oeq" %arg0, %0 {fastmathFlags = #llvm.fastmath<afn>} : vector<2xf64>]

theorem inst_combine_pow_intrinsic_half_approx   : pow_intrinsic_half_approx_before  ⊑  pow_intrinsic_half_approx_combined := by
  unfold pow_intrinsic_half_approx_before pow_intrinsic_half_approx_combined
  simp_alive_peephole
  sorry
    %5 = llvm.select %4, %1, %3 {fastmathFlags = #llvm.fastmath<afn>} : vector<2xi1>, vector<2xf64>]

theorem inst_combine_pow_intrinsic_half_approx   : pow_intrinsic_half_approx_before  ⊑  pow_intrinsic_half_approx_combined := by
  unfold pow_intrinsic_half_approx_before pow_intrinsic_half_approx_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : vector<2xf64>
  }]

theorem inst_combine_pow_intrinsic_half_approx   : pow_intrinsic_half_approx_before  ⊑  pow_intrinsic_half_approx_combined := by
  unfold pow_intrinsic_half_approx_before pow_intrinsic_half_approx_combined
  simp_alive_peephole
  sorry
def powf_intrinsic_half_fast_combined := [llvmfunc|
  llvm.func @powf_intrinsic_half_fast(%arg0: f32) -> f32 {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_powf_intrinsic_half_fast   : powf_intrinsic_half_fast_before  ⊑  powf_intrinsic_half_fast_combined := by
  unfold powf_intrinsic_half_fast_before powf_intrinsic_half_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_powf_intrinsic_half_fast   : powf_intrinsic_half_fast_before  ⊑  powf_intrinsic_half_fast_combined := by
  unfold powf_intrinsic_half_fast_before powf_intrinsic_half_fast_combined
  simp_alive_peephole
  sorry
def pow_libcall_half_no_FMF_base_ninf_combined := [llvmfunc|
  llvm.func @pow_libcall_half_no_FMF_base_ninf(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.intr.fabs(%1)  : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_libcall_half_no_FMF_base_ninf   : pow_libcall_half_no_FMF_base_ninf_before  ⊑  pow_libcall_half_no_FMF_base_ninf_combined := by
  unfold pow_libcall_half_no_FMF_base_ninf_before pow_libcall_half_no_FMF_base_ninf_combined
  simp_alive_peephole
  sorry
def pow_libcall_half_ninf_combined := [llvmfunc|
  llvm.func @pow_libcall_half_ninf(%arg0: f64) -> f64 {
    %0 = llvm.call @sqrt(%arg0) {fastmathFlags = #llvm.fastmath<ninf>} : (f64) -> f64]

theorem inst_combine_pow_libcall_half_ninf   : pow_libcall_half_ninf_before  ⊑  pow_libcall_half_ninf_combined := by
  unfold pow_libcall_half_ninf_before pow_libcall_half_ninf_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f64) -> f64]

theorem inst_combine_pow_libcall_half_ninf   : pow_libcall_half_ninf_before  ⊑  pow_libcall_half_ninf_combined := by
  unfold pow_libcall_half_ninf_before pow_libcall_half_ninf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_libcall_half_ninf   : pow_libcall_half_ninf_before  ⊑  pow_libcall_half_ninf_combined := by
  unfold pow_libcall_half_ninf_before pow_libcall_half_ninf_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_half_ninf_combined := [llvmfunc|
  llvm.func @pow_intrinsic_half_ninf(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<ninf>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_half_ninf   : pow_intrinsic_half_ninf_before  ⊑  pow_intrinsic_half_ninf_combined := by
  unfold pow_intrinsic_half_ninf_before pow_intrinsic_half_ninf_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_half_ninf   : pow_intrinsic_half_ninf_before  ⊑  pow_intrinsic_half_ninf_combined := by
  unfold pow_intrinsic_half_ninf_before pow_intrinsic_half_ninf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_pow_intrinsic_half_ninf   : pow_intrinsic_half_ninf_before  ⊑  pow_intrinsic_half_ninf_combined := by
  unfold pow_intrinsic_half_ninf_before pow_intrinsic_half_ninf_combined
  simp_alive_peephole
  sorry
def pow_libcall_half_nsz_combined := [llvmfunc|
  llvm.func @pow_libcall_half_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<nsz>} : (f64, f64) -> f64]

theorem inst_combine_pow_libcall_half_nsz   : pow_libcall_half_nsz_before  ⊑  pow_libcall_half_nsz_combined := by
  unfold pow_libcall_half_nsz_before pow_libcall_half_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_libcall_half_nsz   : pow_libcall_half_nsz_before  ⊑  pow_libcall_half_nsz_combined := by
  unfold pow_libcall_half_nsz_before pow_libcall_half_nsz_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_half_nsz_combined := [llvmfunc|
  llvm.func @pow_intrinsic_half_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %2 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f64) -> f64]

theorem inst_combine_pow_intrinsic_half_nsz   : pow_intrinsic_half_nsz_before  ⊑  pow_intrinsic_half_nsz_combined := by
  unfold pow_intrinsic_half_nsz_before pow_intrinsic_half_nsz_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "oeq" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f64]

theorem inst_combine_pow_intrinsic_half_nsz   : pow_intrinsic_half_nsz_before  ⊑  pow_intrinsic_half_nsz_combined := by
  unfold pow_intrinsic_half_nsz_before pow_intrinsic_half_nsz_combined
  simp_alive_peephole
  sorry
    %4 = llvm.select %3, %1, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

theorem inst_combine_pow_intrinsic_half_nsz   : pow_intrinsic_half_nsz_before  ⊑  pow_intrinsic_half_nsz_combined := by
  unfold pow_intrinsic_half_nsz_before pow_intrinsic_half_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_intrinsic_half_nsz   : pow_intrinsic_half_nsz_before  ⊑  pow_intrinsic_half_nsz_combined := by
  unfold pow_intrinsic_half_nsz_before pow_intrinsic_half_nsz_combined
  simp_alive_peephole
  sorry
def pow_libcall_half_ninf_nsz_combined := [llvmfunc|
  llvm.func @pow_libcall_half_ninf_nsz(%arg0: f32) -> f32 {
    %0 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<ninf, nsz>} : (f32) -> f32]

theorem inst_combine_pow_libcall_half_ninf_nsz   : pow_libcall_half_ninf_nsz_before  ⊑  pow_libcall_half_ninf_nsz_combined := by
  unfold pow_libcall_half_ninf_nsz_before pow_libcall_half_ninf_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_pow_libcall_half_ninf_nsz   : pow_libcall_half_ninf_nsz_before  ⊑  pow_libcall_half_ninf_nsz_combined := by
  unfold pow_libcall_half_ninf_nsz_before pow_libcall_half_ninf_nsz_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_half_ninf_nsz_combined := [llvmfunc|
  llvm.func @pow_intrinsic_half_ninf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : (f64) -> f64]

theorem inst_combine_pow_intrinsic_half_ninf_nsz   : pow_intrinsic_half_ninf_nsz_before  ⊑  pow_intrinsic_half_ninf_nsz_combined := by
  unfold pow_intrinsic_half_ninf_nsz_before pow_intrinsic_half_ninf_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f64
  }]

theorem inst_combine_pow_intrinsic_half_ninf_nsz   : pow_intrinsic_half_ninf_nsz_before  ⊑  pow_intrinsic_half_ninf_nsz_combined := by
  unfold pow_intrinsic_half_ninf_nsz_before pow_intrinsic_half_ninf_nsz_combined
  simp_alive_peephole
  sorry
def pow_libcall_half_fast_combined := [llvmfunc|
  llvm.func @pow_libcall_half_fast(%arg0: f32) -> f32 {
    %0 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_pow_libcall_half_fast   : pow_libcall_half_fast_before  ⊑  pow_libcall_half_fast_combined := by
  unfold pow_libcall_half_fast_before pow_libcall_half_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_pow_libcall_half_fast   : pow_libcall_half_fast_before  ⊑  pow_libcall_half_fast_combined := by
  unfold pow_libcall_half_fast_before pow_libcall_half_fast_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_half_fast_combined := [llvmfunc|
  llvm.func @pow_intrinsic_half_fast(%arg0: f64) -> f64 {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

theorem inst_combine_pow_intrinsic_half_fast   : pow_intrinsic_half_fast_before  ⊑  pow_intrinsic_half_fast_combined := by
  unfold pow_intrinsic_half_fast_before pow_intrinsic_half_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f64
  }]

theorem inst_combine_pow_intrinsic_half_fast   : pow_intrinsic_half_fast_before  ⊑  pow_intrinsic_half_fast_combined := by
  unfold pow_intrinsic_half_fast_before pow_intrinsic_half_fast_combined
  simp_alive_peephole
  sorry
def pow_libcall_neghalf_no_FMF_combined := [llvmfunc|
  llvm.func @pow_libcall_neghalf_no_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_pow_libcall_neghalf_no_FMF   : pow_libcall_neghalf_no_FMF_before  ⊑  pow_libcall_neghalf_no_FMF_combined := by
  unfold pow_libcall_neghalf_no_FMF_before pow_libcall_neghalf_no_FMF_combined
  simp_alive_peephole
  sorry
def pow_libcall_neghalf_reassoc_ninf_combined := [llvmfunc|
  llvm.func @pow_libcall_neghalf_reassoc_ninf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : (f32) -> f32]

theorem inst_combine_pow_libcall_neghalf_reassoc_ninf   : pow_libcall_neghalf_reassoc_ninf_before  ⊑  pow_libcall_neghalf_reassoc_ninf_combined := by
  unfold pow_libcall_neghalf_reassoc_ninf_before pow_libcall_neghalf_reassoc_ninf_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.fabs(%1)  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : (f32) -> f32]

theorem inst_combine_pow_libcall_neghalf_reassoc_ninf   : pow_libcall_neghalf_reassoc_ninf_before  ⊑  pow_libcall_neghalf_reassoc_ninf_combined := by
  unfold pow_libcall_neghalf_reassoc_ninf_before pow_libcall_neghalf_reassoc_ninf_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %0, %2  {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f32]

theorem inst_combine_pow_libcall_neghalf_reassoc_ninf   : pow_libcall_neghalf_reassoc_ninf_before  ⊑  pow_libcall_neghalf_reassoc_ninf_combined := by
  unfold pow_libcall_neghalf_reassoc_ninf_before pow_libcall_neghalf_reassoc_ninf_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f32
  }]

theorem inst_combine_pow_libcall_neghalf_reassoc_ninf   : pow_libcall_neghalf_reassoc_ninf_before  ⊑  pow_libcall_neghalf_reassoc_ninf_combined := by
  unfold pow_libcall_neghalf_reassoc_ninf_before pow_libcall_neghalf_reassoc_ninf_combined
  simp_alive_peephole
  sorry
def pow_libcall_neghalf_afn_combined := [llvmfunc|
  llvm.func @pow_libcall_neghalf_afn(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

theorem inst_combine_pow_libcall_neghalf_afn   : pow_libcall_neghalf_afn_before  ⊑  pow_libcall_neghalf_afn_combined := by
  unfold pow_libcall_neghalf_afn_before pow_libcall_neghalf_afn_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_pow_libcall_neghalf_afn   : pow_libcall_neghalf_afn_before  ⊑  pow_libcall_neghalf_afn_combined := by
  unfold pow_libcall_neghalf_afn_before pow_libcall_neghalf_afn_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_neghalf_no_FMF_combined := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_no_FMF(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-5.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_pow_intrinsic_neghalf_no_FMF   : pow_intrinsic_neghalf_no_FMF_before  ⊑  pow_intrinsic_neghalf_no_FMF_combined := by
  unfold pow_intrinsic_neghalf_no_FMF_before pow_intrinsic_neghalf_no_FMF_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_neghalf_reassoc_combined := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_reassoc(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0xFFF0000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %4 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_reassoc   : pow_intrinsic_neghalf_reassoc_before  ⊑  pow_intrinsic_neghalf_reassoc_combined := by
  unfold pow_intrinsic_neghalf_reassoc_before pow_intrinsic_neghalf_reassoc_combined
  simp_alive_peephole
  sorry
    %5 = llvm.intr.fabs(%4)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_reassoc   : pow_intrinsic_neghalf_reassoc_before  ⊑  pow_intrinsic_neghalf_reassoc_combined := by
  unfold pow_intrinsic_neghalf_reassoc_before pow_intrinsic_neghalf_reassoc_combined
  simp_alive_peephole
  sorry
    %6 = llvm.fcmp "oeq" %arg0, %0 {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_reassoc   : pow_intrinsic_neghalf_reassoc_before  ⊑  pow_intrinsic_neghalf_reassoc_combined := by
  unfold pow_intrinsic_neghalf_reassoc_before pow_intrinsic_neghalf_reassoc_combined
  simp_alive_peephole
  sorry
    %7 = llvm.fdiv %1, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_reassoc   : pow_intrinsic_neghalf_reassoc_before  ⊑  pow_intrinsic_neghalf_reassoc_combined := by
  unfold pow_intrinsic_neghalf_reassoc_before pow_intrinsic_neghalf_reassoc_combined
  simp_alive_peephole
  sorry
    %8 = llvm.select %6, %3, %7 : vector<2xi1>, vector<2xf64>
    llvm.return %8 : vector<2xf64>
  }]

theorem inst_combine_pow_intrinsic_neghalf_reassoc   : pow_intrinsic_neghalf_reassoc_before  ⊑  pow_intrinsic_neghalf_reassoc_combined := by
  unfold pow_intrinsic_neghalf_reassoc_before pow_intrinsic_neghalf_reassoc_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_neghalf_afn_combined := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_afn(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0xFFF0000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %4 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<afn>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_afn   : pow_intrinsic_neghalf_afn_before  ⊑  pow_intrinsic_neghalf_afn_combined := by
  unfold pow_intrinsic_neghalf_afn_before pow_intrinsic_neghalf_afn_combined
  simp_alive_peephole
  sorry
    %5 = llvm.intr.fabs(%4)  {fastmathFlags = #llvm.fastmath<afn>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_afn   : pow_intrinsic_neghalf_afn_before  ⊑  pow_intrinsic_neghalf_afn_combined := by
  unfold pow_intrinsic_neghalf_afn_before pow_intrinsic_neghalf_afn_combined
  simp_alive_peephole
  sorry
    %6 = llvm.fcmp "oeq" %arg0, %0 {fastmathFlags = #llvm.fastmath<afn>} : vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_afn   : pow_intrinsic_neghalf_afn_before  ⊑  pow_intrinsic_neghalf_afn_combined := by
  unfold pow_intrinsic_neghalf_afn_before pow_intrinsic_neghalf_afn_combined
  simp_alive_peephole
  sorry
    %7 = llvm.fdiv %1, %5  {fastmathFlags = #llvm.fastmath<afn>} : vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_afn   : pow_intrinsic_neghalf_afn_before  ⊑  pow_intrinsic_neghalf_afn_combined := by
  unfold pow_intrinsic_neghalf_afn_before pow_intrinsic_neghalf_afn_combined
  simp_alive_peephole
  sorry
    %8 = llvm.select %6, %3, %7 : vector<2xi1>, vector<2xf64>
    llvm.return %8 : vector<2xf64>
  }]

theorem inst_combine_pow_intrinsic_neghalf_afn   : pow_intrinsic_neghalf_afn_before  ⊑  pow_intrinsic_neghalf_afn_combined := by
  unfold pow_intrinsic_neghalf_afn_before pow_intrinsic_neghalf_afn_combined
  simp_alive_peephole
  sorry
def pow_libcall_neghalf_ninf_combined := [llvmfunc|
  llvm.func @pow_libcall_neghalf_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @sqrt(%arg0) {fastmathFlags = #llvm.fastmath<ninf, afn>} : (f64) -> f64]

theorem inst_combine_pow_libcall_neghalf_ninf   : pow_libcall_neghalf_ninf_before  ⊑  pow_libcall_neghalf_ninf_combined := by
  unfold pow_libcall_neghalf_ninf_before pow_libcall_neghalf_ninf_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.fabs(%1)  {fastmathFlags = #llvm.fastmath<ninf, afn>} : (f64) -> f64]

theorem inst_combine_pow_libcall_neghalf_ninf   : pow_libcall_neghalf_ninf_before  ⊑  pow_libcall_neghalf_ninf_combined := by
  unfold pow_libcall_neghalf_ninf_before pow_libcall_neghalf_ninf_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %0, %2  {fastmathFlags = #llvm.fastmath<ninf, afn>} : f64]

theorem inst_combine_pow_libcall_neghalf_ninf   : pow_libcall_neghalf_ninf_before  ⊑  pow_libcall_neghalf_ninf_combined := by
  unfold pow_libcall_neghalf_ninf_before pow_libcall_neghalf_ninf_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_libcall_neghalf_ninf   : pow_libcall_neghalf_ninf_before  ⊑  pow_libcall_neghalf_ninf_combined := by
  unfold pow_libcall_neghalf_ninf_before pow_libcall_neghalf_ninf_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_neghalf_ninf_combined := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_ninf(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<ninf, afn>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_ninf   : pow_intrinsic_neghalf_ninf_before  ⊑  pow_intrinsic_neghalf_ninf_combined := by
  unfold pow_intrinsic_neghalf_ninf_before pow_intrinsic_neghalf_ninf_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.fabs(%1)  {fastmathFlags = #llvm.fastmath<ninf, afn>} : (vector<2xf64>) -> vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_ninf   : pow_intrinsic_neghalf_ninf_before  ⊑  pow_intrinsic_neghalf_ninf_combined := by
  unfold pow_intrinsic_neghalf_ninf_before pow_intrinsic_neghalf_ninf_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %0, %2  {fastmathFlags = #llvm.fastmath<ninf, afn>} : vector<2xf64>]

theorem inst_combine_pow_intrinsic_neghalf_ninf   : pow_intrinsic_neghalf_ninf_before  ⊑  pow_intrinsic_neghalf_ninf_combined := by
  unfold pow_intrinsic_neghalf_ninf_before pow_intrinsic_neghalf_ninf_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<2xf64>
  }]

theorem inst_combine_pow_intrinsic_neghalf_ninf   : pow_intrinsic_neghalf_ninf_before  ⊑  pow_intrinsic_neghalf_ninf_combined := by
  unfold pow_intrinsic_neghalf_ninf_before pow_intrinsic_neghalf_ninf_combined
  simp_alive_peephole
  sorry
def pow_libcall_neghalf_nsz_combined := [llvmfunc|
  llvm.func @pow_libcall_neghalf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<nsz, afn>} : (f64, f64) -> f64]

theorem inst_combine_pow_libcall_neghalf_nsz   : pow_libcall_neghalf_nsz_before  ⊑  pow_libcall_neghalf_nsz_combined := by
  unfold pow_libcall_neghalf_nsz_before pow_libcall_neghalf_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_libcall_neghalf_nsz   : pow_libcall_neghalf_nsz_before  ⊑  pow_libcall_neghalf_nsz_combined := by
  unfold pow_libcall_neghalf_nsz_before pow_libcall_neghalf_nsz_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_neghalf_nsz_combined := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0xFFF0000000000000 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<nsz, afn>} : (f64) -> f64]

theorem inst_combine_pow_intrinsic_neghalf_nsz   : pow_intrinsic_neghalf_nsz_before  ⊑  pow_intrinsic_neghalf_nsz_combined := by
  unfold pow_intrinsic_neghalf_nsz_before pow_intrinsic_neghalf_nsz_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fcmp "oeq" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz, afn>} : f64]

theorem inst_combine_pow_intrinsic_neghalf_nsz   : pow_intrinsic_neghalf_nsz_before  ⊑  pow_intrinsic_neghalf_nsz_combined := by
  unfold pow_intrinsic_neghalf_nsz_before pow_intrinsic_neghalf_nsz_combined
  simp_alive_peephole
  sorry
    %5 = llvm.fdiv %1, %3  {fastmathFlags = #llvm.fastmath<nsz, afn>} : f64]

theorem inst_combine_pow_intrinsic_neghalf_nsz   : pow_intrinsic_neghalf_nsz_before  ⊑  pow_intrinsic_neghalf_nsz_combined := by
  unfold pow_intrinsic_neghalf_nsz_before pow_intrinsic_neghalf_nsz_combined
  simp_alive_peephole
  sorry
    %6 = llvm.select %4, %2, %5 : i1, f64
    llvm.return %6 : f64
  }]

theorem inst_combine_pow_intrinsic_neghalf_nsz   : pow_intrinsic_neghalf_nsz_before  ⊑  pow_intrinsic_neghalf_nsz_combined := by
  unfold pow_intrinsic_neghalf_nsz_before pow_intrinsic_neghalf_nsz_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_neghalf_ninf_nsz_combined := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_ninf_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<ninf, nsz, afn>} : (f64) -> f64]

theorem inst_combine_pow_intrinsic_neghalf_ninf_nsz   : pow_intrinsic_neghalf_ninf_nsz_before  ⊑  pow_intrinsic_neghalf_ninf_nsz_combined := by
  unfold pow_intrinsic_neghalf_ninf_nsz_before pow_intrinsic_neghalf_ninf_nsz_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<ninf, nsz, afn>} : f64]

theorem inst_combine_pow_intrinsic_neghalf_ninf_nsz   : pow_intrinsic_neghalf_ninf_nsz_before  ⊑  pow_intrinsic_neghalf_ninf_nsz_combined := by
  unfold pow_intrinsic_neghalf_ninf_nsz_before pow_intrinsic_neghalf_ninf_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_intrinsic_neghalf_ninf_nsz   : pow_intrinsic_neghalf_ninf_nsz_before  ⊑  pow_intrinsic_neghalf_ninf_nsz_combined := by
  unfold pow_intrinsic_neghalf_ninf_nsz_before pow_intrinsic_neghalf_ninf_nsz_combined
  simp_alive_peephole
  sorry
def pow_libcall_neghalf_ninf_nsz_combined := [llvmfunc|
  llvm.func @pow_libcall_neghalf_ninf_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<ninf, nsz, afn>} : (f32) -> f32]

theorem inst_combine_pow_libcall_neghalf_ninf_nsz   : pow_libcall_neghalf_ninf_nsz_before  ⊑  pow_libcall_neghalf_ninf_nsz_combined := by
  unfold pow_libcall_neghalf_ninf_nsz_before pow_libcall_neghalf_ninf_nsz_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<ninf, nsz, afn>} : f32]

theorem inst_combine_pow_libcall_neghalf_ninf_nsz   : pow_libcall_neghalf_ninf_nsz_before  ⊑  pow_libcall_neghalf_ninf_nsz_combined := by
  unfold pow_libcall_neghalf_ninf_nsz_before pow_libcall_neghalf_ninf_nsz_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_pow_libcall_neghalf_ninf_nsz   : pow_libcall_neghalf_ninf_nsz_before  ⊑  pow_libcall_neghalf_ninf_nsz_combined := by
  unfold pow_libcall_neghalf_ninf_nsz_before pow_libcall_neghalf_ninf_nsz_combined
  simp_alive_peephole
  sorry
def pow_libcall_neghalf_fast_combined := [llvmfunc|
  llvm.func @pow_libcall_neghalf_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_pow_libcall_neghalf_fast   : pow_libcall_neghalf_fast_before  ⊑  pow_libcall_neghalf_fast_combined := by
  unfold pow_libcall_neghalf_fast_before pow_libcall_neghalf_fast_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_pow_libcall_neghalf_fast   : pow_libcall_neghalf_fast_before  ⊑  pow_libcall_neghalf_fast_combined := by
  unfold pow_libcall_neghalf_fast_before pow_libcall_neghalf_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_pow_libcall_neghalf_fast   : pow_libcall_neghalf_fast_before  ⊑  pow_libcall_neghalf_fast_combined := by
  unfold pow_libcall_neghalf_fast_before pow_libcall_neghalf_fast_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_neghalf_fast_combined := [llvmfunc|
  llvm.func @pow_intrinsic_neghalf_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

theorem inst_combine_pow_intrinsic_neghalf_fast   : pow_intrinsic_neghalf_fast_before  ⊑  pow_intrinsic_neghalf_fast_combined := by
  unfold pow_intrinsic_neghalf_fast_before pow_intrinsic_neghalf_fast_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_pow_intrinsic_neghalf_fast   : pow_intrinsic_neghalf_fast_before  ⊑  pow_intrinsic_neghalf_fast_combined := by
  unfold pow_intrinsic_neghalf_fast_before pow_intrinsic_neghalf_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_intrinsic_neghalf_fast   : pow_intrinsic_neghalf_fast_before  ⊑  pow_intrinsic_neghalf_fast_combined := by
  unfold pow_intrinsic_neghalf_fast_before pow_intrinsic_neghalf_fast_combined
  simp_alive_peephole
  sorry
