import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow-exp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def powf_expf_before := [llvmfunc|
  llvm.func @powf_expf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @expf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_expf_libcall_before := [llvmfunc|
  llvm.func @powf_expf_libcall(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @expf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.call @powf(%0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_exp_before := [llvmfunc|
  llvm.func @pow_exp(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_exp_not_intrinsic_before := [llvmfunc|
  llvm.func @pow_exp_not_intrinsic(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %1 = llvm.call @pow(%0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powl_expl_before := [llvmfunc|
  llvm.func @powl_expl(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @expl(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128]

    llvm.return %1 : f128
  }]

def powl_expl_not_fast_before := [llvmfunc|
  llvm.func @powl_expl_not_fast(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @expl(%arg0) : (f128) -> f128
    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128]

    llvm.return %1 : f128
  }]

def powf_exp2f_before := [llvmfunc|
  llvm.func @powf_exp2f(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @exp2f(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_exp2f_not_intrinsic_before := [llvmfunc|
  llvm.func @powf_exp2f_not_intrinsic(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @exp2f(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.call @powf(%0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_exp2_before := [llvmfunc|
  llvm.func @pow_exp2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_exp2_libcall_before := [llvmfunc|
  llvm.func @pow_exp2_libcall(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %1 = llvm.call @pow(%0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powl_exp2l_before := [llvmfunc|
  llvm.func @powl_exp2l(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @exp2l(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128]

    llvm.return %1 : f128
  }]

def powl_exp2l_not_fast_before := [llvmfunc|
  llvm.func @powl_exp2l_not_fast(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @exp2l(%arg0) : (f128) -> f128
    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128]

    llvm.return %1 : f128
  }]

def powf_exp10f_before := [llvmfunc|
  llvm.func @powf_exp10f(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @exp10f(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_exp10_before := [llvmfunc|
  llvm.func @pow_exp10(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp10(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_exp10l_before := [llvmfunc|
  llvm.func @pow_exp10l(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @exp10l(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128]

    llvm.return %1 : f128
  }]

def reuse_fast_before := [llvmfunc|
  llvm.func @reuse_fast(%arg0: f32, %arg1: f32, %arg2: !llvm.ptr) -> f32 {
    %0 = llvm.call @expf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.call @powf(%0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.store %0, %arg2 {alignment = 4 : i64} : f32, !llvm.ptr]

    llvm.return %1 : f32
  }]

def reuse_libcall_before := [llvmfunc|
  llvm.func @reuse_libcall(%arg0: f128, %arg1: f128, %arg2: !llvm.ptr) -> f128 {
    %0 = llvm.call @expl(%arg0) : (f128) -> f128
    %1 = llvm.call @powl(%0, %arg1) : (f128, f128) -> f128
    llvm.store %0, %arg2 {alignment = 16 : i64} : f128, !llvm.ptr]

    llvm.return %1 : f128
  }]

def function_pointer_before := [llvmfunc|
  llvm.func @function_pointer(%arg0: !llvm.ptr, %arg1: f64) -> f64 {
    %0 = llvm.call %arg0() {fastmathFlags = #llvm.fastmath<fast>} : !llvm.ptr, () -> f64]

    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_ok_base_before := [llvmfunc|
  llvm.func @pow_ok_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_ok_base_fast_before := [llvmfunc|
  llvm.func @pow_ok_base_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_ok_base2_before := [llvmfunc|
  llvm.func @pow_ok_base2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.770000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_ok_base3_before := [llvmfunc|
  llvm.func @pow_ok_base3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.010000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_ok_ten_base_before := [llvmfunc|
  llvm.func @pow_ok_ten_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_ok_denorm_base_before := [llvmfunc|
  llvm.func @pow_ok_denorm_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.1219957904712067E-314 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_ok_base_before := [llvmfunc|
  llvm.func @powf_ok_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.699999988 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_ok_base2_before := [llvmfunc|
  llvm.func @powf_ok_base2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.770000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_ok_base3_before := [llvmfunc|
  llvm.func @powf_ok_base3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.010000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_ok_ten_base_before := [llvmfunc|
  llvm.func @powf_ok_ten_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_ok_denorm_base_before := [llvmfunc|
  llvm.func @powf_ok_denorm_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.295890e-41 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def pow_zero_base_before := [llvmfunc|
  llvm.func @pow_zero_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_zero_base2_before := [llvmfunc|
  llvm.func @pow_zero_base2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_inf_base_before := [llvmfunc|
  llvm.func @pow_inf_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_nan_base_before := [llvmfunc|
  llvm.func @pow_nan_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_negative_base_before := [llvmfunc|
  llvm.func @pow_negative_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_multiuse_before := [llvmfunc|
  llvm.func @pow_multiuse(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64]

    llvm.call @use_d(%1) : (f64) -> ()
    llvm.return %1 : f64
  }]

def pow_ok_base_no_afn_before := [llvmfunc|
  llvm.func @pow_ok_base_no_afn(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_ok_base_no_nnan_before := [llvmfunc|
  llvm.func @pow_ok_base_no_nnan(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<ninf, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_ok_base_no_ninf_before := [llvmfunc|
  llvm.func @pow_ok_base_no_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_zero_base_before := [llvmfunc|
  llvm.func @powf_zero_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_zero_base2_before := [llvmfunc|
  llvm.func @powf_zero_base2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_inf_base_before := [llvmfunc|
  llvm.func @powf_inf_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_nan_base_before := [llvmfunc|
  llvm.func @powf_nan_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_negative_base_before := [llvmfunc|
  llvm.func @powf_negative_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def powf_multiuse_before := [llvmfunc|
  llvm.func @powf_multiuse(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32]

    llvm.call @use_f(%1) : (f32) -> ()
    llvm.return %1 : f32
  }]

def powf_ok_base_no_afn_before := [llvmfunc|
  llvm.func @powf_ok_base_no_afn(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.699999988 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def powl_long_dbl_no_fold_before := [llvmfunc|
  llvm.func @powl_long_dbl_no_fold(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(4.17755552565261002676701084286649753E+1233 : f128) : f128
    %1 = llvm.call @powl(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f128, f128) -> f128]

    llvm.return %1 : f128
  }]

def powf_expf_combined := [llvmfunc|
  llvm.func @powf_expf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.intr.exp(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_expf   : powf_expf_before  ⊑  powf_expf_combined := by
  unfold powf_expf_before powf_expf_combined
  simp_alive_peephole
  sorry
def powf_expf_libcall_combined := [llvmfunc|
  llvm.func @powf_expf_libcall(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.call @expf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_expf_libcall   : powf_expf_libcall_before  ⊑  powf_expf_libcall_combined := by
  unfold powf_expf_libcall_before powf_expf_libcall_combined
  simp_alive_peephole
  sorry
def pow_exp_combined := [llvmfunc|
  llvm.func @pow_exp(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.intr.exp(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_exp   : pow_exp_before  ⊑  pow_exp_combined := by
  unfold pow_exp_before pow_exp_combined
  simp_alive_peephole
  sorry
def pow_exp_not_intrinsic_combined := [llvmfunc|
  llvm.func @pow_exp_not_intrinsic(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.intr.exp(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_exp_not_intrinsic   : pow_exp_not_intrinsic_before  ⊑  pow_exp_not_intrinsic_combined := by
  unfold pow_exp_not_intrinsic_before pow_exp_not_intrinsic_combined
  simp_alive_peephole
  sorry
def powl_expl_combined := [llvmfunc|
  llvm.func @powl_expl(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f128
    %1 = llvm.intr.exp(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128
    llvm.return %1 : f128
  }]

theorem inst_combine_powl_expl   : powl_expl_before  ⊑  powl_expl_combined := by
  unfold powl_expl_before powl_expl_combined
  simp_alive_peephole
  sorry
def powl_expl_not_fast_combined := [llvmfunc|
  llvm.func @powl_expl_not_fast(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @expl(%arg0) : (f128) -> f128
    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128
    llvm.return %1 : f128
  }]

theorem inst_combine_powl_expl_not_fast   : powl_expl_not_fast_before  ⊑  powl_expl_not_fast_combined := by
  unfold powl_expl_not_fast_before powl_expl_not_fast_combined
  simp_alive_peephole
  sorry
def powf_exp2f_combined := [llvmfunc|
  llvm.func @powf_exp2f(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_exp2f   : powf_exp2f_before  ⊑  powf_exp2f_combined := by
  unfold powf_exp2f_before powf_exp2f_combined
  simp_alive_peephole
  sorry
def powf_exp2f_not_intrinsic_combined := [llvmfunc|
  llvm.func @powf_exp2f_not_intrinsic(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_exp2f_not_intrinsic   : powf_exp2f_not_intrinsic_before  ⊑  powf_exp2f_not_intrinsic_combined := by
  unfold powf_exp2f_not_intrinsic_before powf_exp2f_not_intrinsic_combined
  simp_alive_peephole
  sorry
def pow_exp2_combined := [llvmfunc|
  llvm.func @pow_exp2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_exp2   : pow_exp2_before  ⊑  pow_exp2_combined := by
  unfold pow_exp2_before pow_exp2_combined
  simp_alive_peephole
  sorry
def pow_exp2_libcall_combined := [llvmfunc|
  llvm.func @pow_exp2_libcall(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.call @exp2(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_exp2_libcall   : pow_exp2_libcall_before  ⊑  pow_exp2_libcall_combined := by
  unfold pow_exp2_libcall_before pow_exp2_libcall_combined
  simp_alive_peephole
  sorry
def powl_exp2l_combined := [llvmfunc|
  llvm.func @powl_exp2l(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f128
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128
    llvm.return %1 : f128
  }]

theorem inst_combine_powl_exp2l   : powl_exp2l_before  ⊑  powl_exp2l_combined := by
  unfold powl_exp2l_before powl_exp2l_combined
  simp_alive_peephole
  sorry
def powl_exp2l_not_fast_combined := [llvmfunc|
  llvm.func @powl_exp2l_not_fast(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @exp2l(%arg0) : (f128) -> f128
    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128
    llvm.return %1 : f128
  }]

theorem inst_combine_powl_exp2l_not_fast   : powl_exp2l_not_fast_before  ⊑  powl_exp2l_not_fast_combined := by
  unfold powl_exp2l_not_fast_before powl_exp2l_not_fast_combined
  simp_alive_peephole
  sorry
def powf_exp10f_combined := [llvmfunc|
  llvm.func @powf_exp10f(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @exp10f(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_exp10f   : powf_exp10f_before  ⊑  powf_exp10f_combined := by
  unfold powf_exp10f_before powf_exp10f_combined
  simp_alive_peephole
  sorry
def pow_exp10_combined := [llvmfunc|
  llvm.func @pow_exp10(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @exp10(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_exp10   : pow_exp10_before  ⊑  pow_exp10_combined := by
  unfold pow_exp10_before pow_exp10_combined
  simp_alive_peephole
  sorry
def pow_exp10l_combined := [llvmfunc|
  llvm.func @pow_exp10l(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @exp10l(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128
    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128
    llvm.return %1 : f128
  }]

theorem inst_combine_pow_exp10l   : pow_exp10l_before  ⊑  pow_exp10l_combined := by
  unfold pow_exp10l_before pow_exp10l_combined
  simp_alive_peephole
  sorry
def reuse_fast_combined := [llvmfunc|
  llvm.func @reuse_fast(%arg0: f32, %arg1: f32, %arg2: !llvm.ptr) -> f32 {
    %0 = llvm.call @expf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %1 = llvm.call @powf(%0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.store %0, %arg2 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return %1 : f32
  }]

theorem inst_combine_reuse_fast   : reuse_fast_before  ⊑  reuse_fast_combined := by
  unfold reuse_fast_before reuse_fast_combined
  simp_alive_peephole
  sorry
def reuse_libcall_combined := [llvmfunc|
  llvm.func @reuse_libcall(%arg0: f128, %arg1: f128, %arg2: !llvm.ptr) -> f128 {
    %0 = llvm.call @expl(%arg0) : (f128) -> f128
    %1 = llvm.call @powl(%0, %arg1) : (f128, f128) -> f128
    llvm.store %0, %arg2 {alignment = 16 : i64} : f128, !llvm.ptr
    llvm.return %1 : f128
  }]

theorem inst_combine_reuse_libcall   : reuse_libcall_before  ⊑  reuse_libcall_combined := by
  unfold reuse_libcall_before reuse_libcall_combined
  simp_alive_peephole
  sorry
def function_pointer_combined := [llvmfunc|
  llvm.func @function_pointer(%arg0: !llvm.ptr, %arg1: f64) -> f64 {
    %0 = llvm.call %arg0() {fastmathFlags = #llvm.fastmath<fast>} : !llvm.ptr, () -> f64
    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_function_pointer   : function_pointer_before  ⊑  function_pointer_combined := by
  unfold function_pointer_before function_pointer_combined
  simp_alive_peephole
  sorry
def pow_ok_base_combined := [llvmfunc|
  llvm.func @pow_ok_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.51457317282975834 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f64
    %2 = llvm.call @exp2(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ok_base   : pow_ok_base_before  ⊑  pow_ok_base_combined := by
  unfold pow_ok_base_before pow_ok_base_combined
  simp_alive_peephole
  sorry
def pow_ok_base_fast_combined := [llvmfunc|
  llvm.func @pow_ok_base_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.51457317282975834 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.call @exp2(%1) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ok_base_fast   : pow_ok_base_fast_before  ⊑  pow_ok_base_fast_combined := by
  unfold pow_ok_base_fast_before pow_ok_base_fast_combined
  simp_alive_peephole
  sorry
def pow_ok_base2_combined := [llvmfunc|
  llvm.func @pow_ok_base2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.145677455195635 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f64
    %2 = llvm.call @exp2(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ok_base2   : pow_ok_base2_before  ⊑  pow_ok_base2_combined := by
  unfold pow_ok_base2_before pow_ok_base2_combined
  simp_alive_peephole
  sorry
def pow_ok_base3_combined := [llvmfunc|
  llvm.func @pow_ok_base3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.3362833878644325 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f64
    %2 = llvm.call @exp2(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ok_base3   : pow_ok_base3_before  ⊑  pow_ok_base3_combined := by
  unfold pow_ok_base3_before pow_ok_base3_combined
  simp_alive_peephole
  sorry
def pow_ok_ten_base_combined := [llvmfunc|
  llvm.func @pow_ok_ten_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.3219280948873622 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f64
    %2 = llvm.call @exp2(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ok_ten_base   : pow_ok_ten_base_before  ⊑  pow_ok_ten_base_combined := by
  unfold pow_ok_ten_base_before pow_ok_ten_base_combined
  simp_alive_peephole
  sorry
def pow_ok_denorm_base_combined := [llvmfunc|
  llvm.func @pow_ok_denorm_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1042.0000000003358 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f64
    %2 = llvm.call @exp2(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ok_denorm_base   : pow_ok_denorm_base_before  ⊑  pow_ok_denorm_base_combined := by
  unfold pow_ok_denorm_base_before pow_ok_denorm_base_combined
  simp_alive_peephole
  sorry
def powf_ok_base_combined := [llvmfunc|
  llvm.func @powf_ok_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.514573216 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f32
    %2 = llvm.call @exp2f(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_powf_ok_base   : powf_ok_base_before  ⊑  powf_ok_base_combined := by
  unfold powf_ok_base_before powf_ok_base_combined
  simp_alive_peephole
  sorry
def powf_ok_base2_combined := [llvmfunc|
  llvm.func @powf_ok_base2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.14567757 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f32
    %2 = llvm.call @exp2f(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_powf_ok_base2   : powf_ok_base2_before  ⊑  powf_ok_base2_combined := by
  unfold powf_ok_base2_before powf_ok_base2_combined
  simp_alive_peephole
  sorry
def powf_ok_base3_combined := [llvmfunc|
  llvm.func @powf_ok_base3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.33628345 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f32
    %2 = llvm.call @exp2f(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_powf_ok_base3   : powf_ok_base3_before  ⊑  powf_ok_base3_combined := by
  unfold powf_ok_base3_before powf_ok_base3_combined
  simp_alive_peephole
  sorry
def powf_ok_ten_base_combined := [llvmfunc|
  llvm.func @powf_ok_ten_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.32192802 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f32
    %2 = llvm.call @exp2f(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_powf_ok_ten_base   : powf_ok_ten_base_before  ⊑  powf_ok_ten_base_combined := by
  unfold powf_ok_ten_base_before powf_ok_ten_base_combined
  simp_alive_peephole
  sorry
def powf_ok_denorm_base_combined := [llvmfunc|
  llvm.func @powf_ok_denorm_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.350000e+02 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f32
    %2 = llvm.call @exp2f(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_powf_ok_denorm_base   : powf_ok_denorm_base_before  ⊑  powf_ok_denorm_base_combined := by
  unfold powf_ok_denorm_base_before powf_ok_denorm_base_combined
  simp_alive_peephole
  sorry
def pow_zero_base_combined := [llvmfunc|
  llvm.func @pow_zero_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_zero_base   : pow_zero_base_before  ⊑  pow_zero_base_combined := by
  unfold pow_zero_base_before pow_zero_base_combined
  simp_alive_peephole
  sorry
def pow_zero_base2_combined := [llvmfunc|
  llvm.func @pow_zero_base2(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_zero_base2   : pow_zero_base2_before  ⊑  pow_zero_base2_combined := by
  unfold pow_zero_base2_before pow_zero_base2_combined
  simp_alive_peephole
  sorry
def pow_inf_base_combined := [llvmfunc|
  llvm.func @pow_inf_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_inf_base   : pow_inf_base_before  ⊑  pow_inf_base_combined := by
  unfold pow_inf_base_before pow_inf_base_combined
  simp_alive_peephole
  sorry
def pow_nan_base_combined := [llvmfunc|
  llvm.func @pow_nan_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_nan_base   : pow_nan_base_before  ⊑  pow_nan_base_combined := by
  unfold pow_nan_base_before pow_nan_base_combined
  simp_alive_peephole
  sorry
def pow_negative_base_combined := [llvmfunc|
  llvm.func @pow_negative_base(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.000000e+00 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_negative_base   : pow_negative_base_before  ⊑  pow_negative_base_combined := by
  unfold pow_negative_base_before pow_negative_base_combined
  simp_alive_peephole
  sorry
def pow_multiuse_combined := [llvmfunc|
  llvm.func @pow_multiuse(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(2.3219280948873622 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f64
    %2 = llvm.call @exp2(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f64) -> f64
    llvm.call @use_d(%2) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_multiuse   : pow_multiuse_before  ⊑  pow_multiuse_combined := by
  unfold pow_multiuse_before pow_multiuse_combined
  simp_alive_peephole
  sorry
def pow_ok_base_no_afn_combined := [llvmfunc|
  llvm.func @pow_ok_base_no_afn(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_ok_base_no_afn   : pow_ok_base_no_afn_before  ⊑  pow_ok_base_no_afn_combined := by
  unfold pow_ok_base_no_afn_before pow_ok_base_no_afn_combined
  simp_alive_peephole
  sorry
def pow_ok_base_no_nnan_combined := [llvmfunc|
  llvm.func @pow_ok_base_no_nnan(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.69999999999999996 : f64) : f64
    %1 = llvm.call @pow(%0, %arg0) {fastmathFlags = #llvm.fastmath<ninf, afn>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_ok_base_no_nnan   : pow_ok_base_no_nnan_before  ⊑  pow_ok_base_no_nnan_combined := by
  unfold pow_ok_base_no_nnan_before pow_ok_base_no_nnan_combined
  simp_alive_peephole
  sorry
def pow_ok_base_no_ninf_combined := [llvmfunc|
  llvm.func @pow_ok_base_no_ninf(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.51457317282975834 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, afn>} : f64
    %2 = llvm.call @exp2(%1) {fastmathFlags = #llvm.fastmath<nnan, afn>} : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ok_base_no_ninf   : pow_ok_base_no_ninf_before  ⊑  pow_ok_base_no_ninf_combined := by
  unfold pow_ok_base_no_ninf_before pow_ok_base_no_ninf_combined
  simp_alive_peephole
  sorry
def powf_zero_base_combined := [llvmfunc|
  llvm.func @powf_zero_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_zero_base   : powf_zero_base_before  ⊑  powf_zero_base_combined := by
  unfold powf_zero_base_before powf_zero_base_combined
  simp_alive_peephole
  sorry
def powf_zero_base2_combined := [llvmfunc|
  llvm.func @powf_zero_base2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_zero_base2   : powf_zero_base2_before  ⊑  powf_zero_base2_combined := by
  unfold powf_zero_base2_before powf_zero_base2_combined
  simp_alive_peephole
  sorry
def powf_inf_base_combined := [llvmfunc|
  llvm.func @powf_inf_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_inf_base   : powf_inf_base_before  ⊑  powf_inf_base_combined := by
  unfold powf_inf_base_before powf_inf_base_combined
  simp_alive_peephole
  sorry
def powf_nan_base_combined := [llvmfunc|
  llvm.func @powf_nan_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_nan_base   : powf_nan_base_before  ⊑  powf_nan_base_combined := by
  unfold powf_nan_base_before powf_nan_base_combined
  simp_alive_peephole
  sorry
def powf_negative_base_combined := [llvmfunc|
  llvm.func @powf_negative_base(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.000000e+00 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_negative_base   : powf_negative_base_before  ⊑  powf_negative_base_combined := by
  unfold powf_negative_base_before powf_negative_base_combined
  simp_alive_peephole
  sorry
def powf_multiuse_combined := [llvmfunc|
  llvm.func @powf_multiuse(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.32192802 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : f32
    %2 = llvm.call @exp2f(%1) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f32) -> f32
    llvm.call @use_f(%2) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_powf_multiuse   : powf_multiuse_before  ⊑  powf_multiuse_combined := by
  unfold powf_multiuse_before powf_multiuse_combined
  simp_alive_peephole
  sorry
def powf_ok_base_no_afn_combined := [llvmfunc|
  llvm.func @powf_ok_base_no_afn(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.699999988 : f32) : f32
    %1 = llvm.call @powf(%0, %arg0) : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_powf_ok_base_no_afn   : powf_ok_base_no_afn_before  ⊑  powf_ok_base_no_afn_combined := by
  unfold powf_ok_base_no_afn_before powf_ok_base_no_afn_combined
  simp_alive_peephole
  sorry
def powl_long_dbl_no_fold_combined := [llvmfunc|
  llvm.func @powl_long_dbl_no_fold(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(4.17755552565261002676701084286649753E+1233 : f128) : f128
    %1 = llvm.call @powl(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf, afn>} : (f128, f128) -> f128
    llvm.return %1 : f128
  }]

theorem inst_combine_powl_long_dbl_no_fold   : powl_long_dbl_no_fold_before  ⊑  powl_long_dbl_no_fold_combined := by
  unfold powl_long_dbl_no_fold_before powl_long_dbl_no_fold_combined
  simp_alive_peephole
  sorry
