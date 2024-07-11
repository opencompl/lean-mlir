import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow-cbrt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pow_intrinsic_third_fast_before := [llvmfunc|
  llvm.func @pow_intrinsic_third_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_intrinsic_third_fast_before := [llvmfunc|
  llvm.func @powf_intrinsic_third_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_intrinsic_third_approx_before := [llvmfunc|
  llvm.func @pow_intrinsic_third_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_intrinsic_third_approx_before := [llvmfunc|
  llvm.func @powf_intrinsic_third_approx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_libcall_third_fast_before := [llvmfunc|
  llvm.func @pow_libcall_third_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_libcall_third_fast_before := [llvmfunc|
  llvm.func @powf_libcall_third_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_intrinsic_negthird_fast_before := [llvmfunc|
  llvm.func @pow_intrinsic_negthird_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_intrinsic_negthird_fast_before := [llvmfunc|
  llvm.func @powf_intrinsic_negthird_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_intrinsic_negthird_approx_before := [llvmfunc|
  llvm.func @pow_intrinsic_negthird_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_intrinsic_negthird_approx_before := [llvmfunc|
  llvm.func @powf_intrinsic_negthird_approx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_libcall_negthird_fast_before := [llvmfunc|
  llvm.func @pow_libcall_negthird_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_libcall_negthird_fast_before := [llvmfunc|
  llvm.func @powf_libcall_negthird_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_intrinsic_third_fast_combined := [llvmfunc|
  llvm.func @pow_intrinsic_third_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

theorem inst_combine_pow_intrinsic_third_fast   : pow_intrinsic_third_fast_before  ⊑  pow_intrinsic_third_fast_combined := by
  unfold pow_intrinsic_third_fast_before pow_intrinsic_third_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_intrinsic_third_fast   : pow_intrinsic_third_fast_before  ⊑  pow_intrinsic_third_fast_combined := by
  unfold pow_intrinsic_third_fast_before pow_intrinsic_third_fast_combined
  simp_alive_peephole
  sorry
def powf_intrinsic_third_fast_combined := [llvmfunc|
  llvm.func @powf_intrinsic_third_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_powf_intrinsic_third_fast   : powf_intrinsic_third_fast_before  ⊑  powf_intrinsic_third_fast_combined := by
  unfold powf_intrinsic_third_fast_before powf_intrinsic_third_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_intrinsic_third_fast   : powf_intrinsic_third_fast_before  ⊑  powf_intrinsic_third_fast_combined := by
  unfold powf_intrinsic_third_fast_before powf_intrinsic_third_fast_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_third_approx_combined := [llvmfunc|
  llvm.func @pow_intrinsic_third_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

theorem inst_combine_pow_intrinsic_third_approx   : pow_intrinsic_third_approx_before  ⊑  pow_intrinsic_third_approx_combined := by
  unfold pow_intrinsic_third_approx_before pow_intrinsic_third_approx_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_intrinsic_third_approx   : pow_intrinsic_third_approx_before  ⊑  pow_intrinsic_third_approx_combined := by
  unfold pow_intrinsic_third_approx_before pow_intrinsic_third_approx_combined
  simp_alive_peephole
  sorry
def powf_intrinsic_third_approx_combined := [llvmfunc|
  llvm.func @powf_intrinsic_third_approx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

theorem inst_combine_powf_intrinsic_third_approx   : powf_intrinsic_third_approx_before  ⊑  powf_intrinsic_third_approx_combined := by
  unfold powf_intrinsic_third_approx_before powf_intrinsic_third_approx_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_intrinsic_third_approx   : powf_intrinsic_third_approx_before  ⊑  powf_intrinsic_third_approx_combined := by
  unfold powf_intrinsic_third_approx_before powf_intrinsic_third_approx_combined
  simp_alive_peephole
  sorry
def pow_libcall_third_fast_combined := [llvmfunc|
  llvm.func @pow_libcall_third_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.33333333333333331 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

theorem inst_combine_pow_libcall_third_fast   : pow_libcall_third_fast_before  ⊑  pow_libcall_third_fast_combined := by
  unfold pow_libcall_third_fast_before pow_libcall_third_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_libcall_third_fast   : pow_libcall_third_fast_before  ⊑  pow_libcall_third_fast_combined := by
  unfold pow_libcall_third_fast_before pow_libcall_third_fast_combined
  simp_alive_peephole
  sorry
def powf_libcall_third_fast_combined := [llvmfunc|
  llvm.func @powf_libcall_third_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.333333343 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_powf_libcall_third_fast   : powf_libcall_third_fast_before  ⊑  powf_libcall_third_fast_combined := by
  unfold powf_libcall_third_fast_before powf_libcall_third_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_libcall_third_fast   : powf_libcall_third_fast_before  ⊑  powf_libcall_third_fast_combined := by
  unfold powf_libcall_third_fast_before powf_libcall_third_fast_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_negthird_fast_combined := [llvmfunc|
  llvm.func @pow_intrinsic_negthird_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

theorem inst_combine_pow_intrinsic_negthird_fast   : pow_intrinsic_negthird_fast_before  ⊑  pow_intrinsic_negthird_fast_combined := by
  unfold pow_intrinsic_negthird_fast_before pow_intrinsic_negthird_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_intrinsic_negthird_fast   : pow_intrinsic_negthird_fast_before  ⊑  pow_intrinsic_negthird_fast_combined := by
  unfold pow_intrinsic_negthird_fast_before pow_intrinsic_negthird_fast_combined
  simp_alive_peephole
  sorry
def powf_intrinsic_negthird_fast_combined := [llvmfunc|
  llvm.func @powf_intrinsic_negthird_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_powf_intrinsic_negthird_fast   : powf_intrinsic_negthird_fast_before  ⊑  powf_intrinsic_negthird_fast_combined := by
  unfold powf_intrinsic_negthird_fast_before powf_intrinsic_negthird_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_intrinsic_negthird_fast   : powf_intrinsic_negthird_fast_before  ⊑  powf_intrinsic_negthird_fast_combined := by
  unfold powf_intrinsic_negthird_fast_before powf_intrinsic_negthird_fast_combined
  simp_alive_peephole
  sorry
def pow_intrinsic_negthird_approx_combined := [llvmfunc|
  llvm.func @pow_intrinsic_negthird_approx(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

theorem inst_combine_pow_intrinsic_negthird_approx   : pow_intrinsic_negthird_approx_before  ⊑  pow_intrinsic_negthird_approx_combined := by
  unfold pow_intrinsic_negthird_approx_before pow_intrinsic_negthird_approx_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_intrinsic_negthird_approx   : pow_intrinsic_negthird_approx_before  ⊑  pow_intrinsic_negthird_approx_combined := by
  unfold pow_intrinsic_negthird_approx_before pow_intrinsic_negthird_approx_combined
  simp_alive_peephole
  sorry
def powf_intrinsic_negthird_approx_combined := [llvmfunc|
  llvm.func @powf_intrinsic_negthird_approx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

theorem inst_combine_powf_intrinsic_negthird_approx   : powf_intrinsic_negthird_approx_before  ⊑  powf_intrinsic_negthird_approx_combined := by
  unfold powf_intrinsic_negthird_approx_before powf_intrinsic_negthird_approx_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_intrinsic_negthird_approx   : powf_intrinsic_negthird_approx_before  ⊑  powf_intrinsic_negthird_approx_combined := by
  unfold powf_intrinsic_negthird_approx_before powf_intrinsic_negthird_approx_combined
  simp_alive_peephole
  sorry
def pow_libcall_negthird_fast_combined := [llvmfunc|
  llvm.func @pow_libcall_negthird_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.33333333333333331 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

theorem inst_combine_pow_libcall_negthird_fast   : pow_libcall_negthird_fast_before  ⊑  pow_libcall_negthird_fast_combined := by
  unfold pow_libcall_negthird_fast_before pow_libcall_negthird_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_libcall_negthird_fast   : pow_libcall_negthird_fast_before  ⊑  pow_libcall_negthird_fast_combined := by
  unfold pow_libcall_negthird_fast_before pow_libcall_negthird_fast_combined
  simp_alive_peephole
  sorry
def powf_libcall_negthird_fast_combined := [llvmfunc|
  llvm.func @powf_libcall_negthird_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.333333343 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_powf_libcall_negthird_fast   : powf_libcall_negthird_fast_before  ⊑  powf_libcall_negthird_fast_combined := by
  unfold powf_libcall_negthird_fast_before powf_libcall_negthird_fast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_libcall_negthird_fast   : powf_libcall_negthird_fast_before  ⊑  powf_libcall_negthird_fast_combined := by
  unfold powf_libcall_negthird_fast_before powf_libcall_negthird_fast_combined
  simp_alive_peephole
  sorry
