import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow_fp_int
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pow_sitofp_const_base_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_const_base_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast(%arg0: i31) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i31 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_sitofp_double_const_base_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_double_const_base_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.sitofp %arg0 : i32 to f64
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

    llvm.return %2 : f64
  }]

def pow_uitofp_double_const_base_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_double_const_base_fast(%arg0: i31) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i31 to f64
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

    llvm.return %2 : f64
  }]

def pow_sitofp_double_const_base_2_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_double_const_base_2_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_sitofp_double_const_base_power_of_2_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_double_const_base_power_of_2_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_2_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_2_fast(%arg0: i31) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i31 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_power_of_2_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_power_of_2_fast(%arg0: i31) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i31 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_sitofp_float_base_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_float_base_fast(%arg0: f32, %arg1: i32) -> f64 {
    %0 = llvm.sitofp %arg1 : i32 to f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

def pow_uitofp_float_base_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_float_base_fast(%arg0: f32, %arg1: i31) -> f64 {
    %0 = llvm.uitofp %arg1 : i31 to f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

def pow_sitofp_double_base_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_double_base_fast(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.sitofp %arg1 : i32 to f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_uitofp_double_base_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_double_base_fast(%arg0: f64, %arg1: i31) -> f64 {
    %0 = llvm.uitofp %arg1 : i31 to f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_sitofp_const_base_fast_i8_before := [llvmfunc|
  llvm.func @pow_sitofp_const_base_fast_i8(%arg0: i8) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i8 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_sitofp_const_base_fast_i16_before := [llvmfunc|
  llvm.func @pow_sitofp_const_base_fast_i16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i16 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_fast_i8_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast_i8(%arg0: i8) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i8 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_fast_i16_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast_i16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i16 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def powf_exp_const_int_fast_before := [llvmfunc|
  llvm.func @powf_exp_const_int_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_exp_const2_int_fast_before := [llvmfunc|
  llvm.func @powf_exp_const2_int_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.000000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_uitofp_const_base_fast_i32_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast_i32(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_2_fast_i32_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_2_fast_i32(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_power_of_2_fast_i32_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_power_of_2_fast_i32(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_float_base_fast_i32_before := [llvmfunc|
  llvm.func @pow_uitofp_float_base_fast_i32(%arg0: f32, %arg1: i32) -> f64 {
    %0 = llvm.uitofp %arg1 : i32 to f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

def pow_uitofp_double_base_fast_i32_before := [llvmfunc|
  llvm.func @pow_uitofp_double_base_fast_i32(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.uitofp %arg1 : i32 to f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_sitofp_const_base_fast_i64_before := [llvmfunc|
  llvm.func @pow_sitofp_const_base_fast_i64(%arg0: i64) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_fast_i64_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast_i64(%arg0: i64) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i64 to f32
    %2 = llvm.intr.pow(%0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_sitofp_const_base_no_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_const_base_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_no_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_sitofp_const_base_2_no_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_const_base_2_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_sitofp_const_base_power_of_2_no_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_const_base_power_of_2_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_2_no_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_2_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_uitofp_const_base_power_of_2_no_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_const_base_power_of_2_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1.600000e+01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def pow_sitofp_float_base_no_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_float_base_no_fast(%arg0: f32, %arg1: i32) -> f64 {
    %0 = llvm.sitofp %arg1 : i32 to f32
    %1 = llvm.intr.pow(%arg0, %0)  : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

def pow_uitofp_float_base_no_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_float_base_no_fast(%arg0: f32, %arg1: i32) -> f64 {
    %0 = llvm.uitofp %arg1 : i32 to f32
    %1 = llvm.intr.pow(%arg0, %0)  : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

def pow_sitofp_double_base_no_fast_before := [llvmfunc|
  llvm.func @pow_sitofp_double_base_no_fast(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.sitofp %arg1 : i32 to f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def pow_uitofp_double_base_no_fast_before := [llvmfunc|
  llvm.func @pow_uitofp_double_base_no_fast(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.uitofp %arg1 : i32 to f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def powf_exp_const_int_no_fast_before := [llvmfunc|
  llvm.func @powf_exp_const_int_no_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def powf_exp_const_not_int_fast_before := [llvmfunc|
  llvm.func @powf_exp_const_not_int_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.750000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def powf_exp_const_not_int_no_fast_before := [llvmfunc|
  llvm.func @powf_exp_const_not_int_no_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.750000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def powf_exp_const2_int_no_fast_before := [llvmfunc|
  llvm.func @powf_exp_const2_int_no_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.000000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def pow_sitofp_const_base_2_no_fast_vector_before := [llvmfunc|
  llvm.func @pow_sitofp_const_base_2_no_fast_vector(%arg0: vector<2xi8>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf32>
    %2 = llvm.intr.pow(%0, %1)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def pow_sitofp_const_base_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_const_base_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.intr.powi(%0, %arg0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_sitofp_const_base_fast   : pow_sitofp_const_base_fast_before  ⊑  pow_sitofp_const_base_fast_combined := by
  unfold pow_sitofp_const_base_fast_before pow_sitofp_const_base_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast(%arg0: i31) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.zext %arg0 : i31 to i32
    %2 = llvm.intr.powi(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_fast   : pow_uitofp_const_base_fast_before  ⊑  pow_uitofp_const_base_fast_combined := by
  unfold pow_uitofp_const_base_fast_before pow_uitofp_const_base_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_double_const_base_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_double_const_base_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.intr.powi(%0, %arg0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_sitofp_double_const_base_fast   : pow_sitofp_double_const_base_fast_before  ⊑  pow_sitofp_double_const_base_fast_combined := by
  unfold pow_sitofp_double_const_base_fast_before pow_sitofp_double_const_base_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_double_const_base_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_double_const_base_fast(%arg0: i31) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.zext %arg0 : i31 to i32
    %2 = llvm.intr.powi(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_uitofp_double_const_base_fast   : pow_uitofp_double_const_base_fast_before  ⊑  pow_uitofp_double_const_base_fast_combined := by
  unfold pow_uitofp_double_const_base_fast_before pow_uitofp_double_const_base_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_double_const_base_2_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_double_const_base_2_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @ldexpf(%0, %arg0) {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_sitofp_double_const_base_2_fast   : pow_sitofp_double_const_base_2_fast_before  ⊑  pow_sitofp_double_const_base_2_fast_combined := by
  unfold pow_sitofp_double_const_base_2_fast_before pow_sitofp_double_const_base_2_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_double_const_base_power_of_2_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_double_const_base_power_of_2_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<afn>} : f32
    %3 = llvm.intr.exp2(%2)  {fastmathFlags = #llvm.fastmath<afn>} : (f32) -> f32
    %4 = llvm.fpext %3 : f32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_sitofp_double_const_base_power_of_2_fast   : pow_sitofp_double_const_base_power_of_2_fast_before  ⊑  pow_sitofp_double_const_base_power_of_2_fast_combined := by
  unfold pow_sitofp_double_const_base_power_of_2_fast_before pow_sitofp_double_const_base_power_of_2_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_2_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_2_fast(%arg0: i31) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.zext %arg0 : i31 to i32
    %2 = llvm.call @ldexpf(%0, %1) {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_2_fast   : pow_uitofp_const_base_2_fast_before  ⊑  pow_uitofp_const_base_2_fast_combined := by
  unfold pow_uitofp_const_base_2_fast_before pow_uitofp_const_base_2_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_power_of_2_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_power_of_2_fast(%arg0: i31) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i31 to f32
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<afn>} : f32
    %3 = llvm.intr.exp2(%2)  {fastmathFlags = #llvm.fastmath<afn>} : (f32) -> f32
    %4 = llvm.fpext %3 : f32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_power_of_2_fast   : pow_uitofp_const_base_power_of_2_fast_before  ⊑  pow_uitofp_const_base_power_of_2_fast_combined := by
  unfold pow_uitofp_const_base_power_of_2_fast_before pow_uitofp_const_base_power_of_2_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_float_base_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_float_base_fast(%arg0: f32, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_sitofp_float_base_fast   : pow_sitofp_float_base_fast_before  ⊑  pow_sitofp_float_base_fast_combined := by
  unfold pow_sitofp_float_base_fast_before pow_sitofp_float_base_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_float_base_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_float_base_fast(%arg0: f32, %arg1: i31) -> f64 {
    %0 = llvm.zext %arg1 : i31 to i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_uitofp_float_base_fast   : pow_uitofp_float_base_fast_before  ⊑  pow_uitofp_float_base_fast_combined := by
  unfold pow_uitofp_float_base_fast_before pow_uitofp_float_base_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_double_base_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_double_base_fast(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.intr.powi(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, i32) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_pow_sitofp_double_base_fast   : pow_sitofp_double_base_fast_before  ⊑  pow_sitofp_double_base_fast_combined := by
  unfold pow_sitofp_double_base_fast_before pow_sitofp_double_base_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_double_base_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_double_base_fast(%arg0: f64, %arg1: i31) -> f64 {
    %0 = llvm.zext %arg1 : i31 to i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<afn>} : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_uitofp_double_base_fast   : pow_uitofp_double_base_fast_before  ⊑  pow_uitofp_double_base_fast_combined := by
  unfold pow_uitofp_double_base_fast_before pow_uitofp_double_base_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_const_base_fast_i8_combined := [llvmfunc|
  llvm.func @pow_sitofp_const_base_fast_i8(%arg0: i8) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.intr.powi(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_sitofp_const_base_fast_i8   : pow_sitofp_const_base_fast_i8_before  ⊑  pow_sitofp_const_base_fast_i8_combined := by
  unfold pow_sitofp_const_base_fast_i8_before pow_sitofp_const_base_fast_i8_combined
  simp_alive_peephole
  sorry
def pow_sitofp_const_base_fast_i16_combined := [llvmfunc|
  llvm.func @pow_sitofp_const_base_fast_i16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.intr.powi(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_sitofp_const_base_fast_i16   : pow_sitofp_const_base_fast_i16_before  ⊑  pow_sitofp_const_base_fast_i16_combined := by
  unfold pow_sitofp_const_base_fast_i16_before pow_sitofp_const_base_fast_i16_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_fast_i8_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast_i8(%arg0: i8) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.intr.powi(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_fast_i8   : pow_uitofp_const_base_fast_i8_before  ⊑  pow_uitofp_const_base_fast_i8_combined := by
  unfold pow_uitofp_const_base_fast_i8_before pow_uitofp_const_base_fast_i8_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_fast_i16_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast_i16(%arg0: i16) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.intr.powi(%0, %1)  {fastmathFlags = #llvm.fastmath<afn>} : (f32, i32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_fast_i16   : pow_uitofp_const_base_fast_i16_before  ⊑  pow_uitofp_const_base_fast_i16_combined := by
  unfold pow_uitofp_const_base_fast_i16_before pow_uitofp_const_base_fast_i16_combined
  simp_alive_peephole
  sorry
def powf_exp_const_int_fast_combined := [llvmfunc|
  llvm.func @powf_exp_const_int_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(40 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_powf_exp_const_int_fast   : powf_exp_const_int_fast_before  ⊑  powf_exp_const_int_fast_combined := by
  unfold powf_exp_const_int_fast_before powf_exp_const_int_fast_combined
  simp_alive_peephole
  sorry
def powf_exp_const2_int_fast_combined := [llvmfunc|
  llvm.func @powf_exp_const2_int_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-40 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_powf_exp_const2_int_fast   : powf_exp_const2_int_fast_before  ⊑  powf_exp_const2_int_fast_combined := by
  unfold powf_exp_const2_int_fast_before powf_exp_const2_int_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_fast_i32_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast_i32(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2.80735493 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.intr.exp2(%2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %4 = llvm.fpext %3 : f32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_fast_i32   : pow_uitofp_const_base_fast_i32_before  ⊑  pow_uitofp_const_base_fast_i32_combined := by
  unfold pow_uitofp_const_base_fast_i32_before pow_uitofp_const_base_fast_i32_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_2_fast_i32_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_2_fast_i32(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_2_fast_i32   : pow_uitofp_const_base_2_fast_i32_before  ⊑  pow_uitofp_const_base_2_fast_i32_combined := by
  unfold pow_uitofp_const_base_2_fast_i32_before pow_uitofp_const_base_2_fast_i32_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_power_of_2_fast_i32_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_power_of_2_fast_i32(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.intr.exp2(%2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %4 = llvm.fpext %3 : f32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_power_of_2_fast_i32   : pow_uitofp_const_base_power_of_2_fast_i32_before  ⊑  pow_uitofp_const_base_power_of_2_fast_i32_combined := by
  unfold pow_uitofp_const_base_power_of_2_fast_i32_before pow_uitofp_const_base_power_of_2_fast_i32_combined
  simp_alive_peephole
  sorry
def pow_uitofp_float_base_fast_i32_combined := [llvmfunc|
  llvm.func @pow_uitofp_float_base_fast_i32(%arg0: f32, %arg1: i32) -> f64 {
    %0 = llvm.uitofp %arg1 : i32 to f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_uitofp_float_base_fast_i32   : pow_uitofp_float_base_fast_i32_before  ⊑  pow_uitofp_float_base_fast_i32_combined := by
  unfold pow_uitofp_float_base_fast_i32_before pow_uitofp_float_base_fast_i32_combined
  simp_alive_peephole
  sorry
def pow_uitofp_double_base_fast_i32_combined := [llvmfunc|
  llvm.func @pow_uitofp_double_base_fast_i32(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.uitofp %arg1 : i32 to f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_uitofp_double_base_fast_i32   : pow_uitofp_double_base_fast_i32_before  ⊑  pow_uitofp_double_base_fast_i32_combined := by
  unfold pow_uitofp_double_base_fast_i32_before pow_uitofp_double_base_fast_i32_combined
  simp_alive_peephole
  sorry
def pow_sitofp_const_base_fast_i64_combined := [llvmfunc|
  llvm.func @pow_sitofp_const_base_fast_i64(%arg0: i64) -> f64 {
    %0 = llvm.mlir.constant(2.80735493 : f32) : f32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.intr.exp2(%2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %4 = llvm.fpext %3 : f32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_sitofp_const_base_fast_i64   : pow_sitofp_const_base_fast_i64_before  ⊑  pow_sitofp_const_base_fast_i64_combined := by
  unfold pow_sitofp_const_base_fast_i64_before pow_sitofp_const_base_fast_i64_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_fast_i64_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_fast_i64(%arg0: i64) -> f64 {
    %0 = llvm.mlir.constant(2.80735493 : f32) : f32
    %1 = llvm.uitofp %arg0 : i64 to f32
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.intr.exp2(%2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %4 = llvm.fpext %3 : f32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_fast_i64   : pow_uitofp_const_base_fast_i64_before  ⊑  pow_uitofp_const_base_fast_i64_combined := by
  unfold pow_uitofp_const_base_fast_i64_before pow_uitofp_const_base_fast_i64_combined
  simp_alive_peephole
  sorry
def pow_sitofp_const_base_no_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_const_base_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_sitofp_const_base_no_fast   : pow_sitofp_const_base_no_fast_before  ⊑  pow_sitofp_const_base_no_fast_combined := by
  unfold pow_sitofp_const_base_no_fast_before pow_sitofp_const_base_no_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_no_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.intr.pow(%0, %1)  : (f32, f32) -> f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_no_fast   : pow_uitofp_const_base_no_fast_before  ⊑  pow_uitofp_const_base_no_fast_combined := by
  unfold pow_uitofp_const_base_no_fast_before pow_uitofp_const_base_no_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_const_base_2_no_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_const_base_2_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @ldexpf(%0, %arg0) : (f32, i32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_sitofp_const_base_2_no_fast   : pow_sitofp_const_base_2_no_fast_before  ⊑  pow_sitofp_const_base_2_no_fast_combined := by
  unfold pow_sitofp_const_base_2_no_fast_before pow_sitofp_const_base_2_no_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_const_base_power_of_2_no_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_const_base_power_of_2_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.intr.exp2(%2)  : (f32) -> f32
    %4 = llvm.fpext %3 : f32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_sitofp_const_base_power_of_2_no_fast   : pow_sitofp_const_base_power_of_2_no_fast_before  ⊑  pow_sitofp_const_base_power_of_2_no_fast_combined := by
  unfold pow_sitofp_const_base_power_of_2_no_fast_before pow_sitofp_const_base_power_of_2_no_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_2_no_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_2_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.intr.exp2(%0)  : (f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_2_no_fast   : pow_uitofp_const_base_2_no_fast_before  ⊑  pow_uitofp_const_base_2_no_fast_combined := by
  unfold pow_uitofp_const_base_2_no_fast_before pow_uitofp_const_base_2_no_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_const_base_power_of_2_no_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_const_base_power_of_2_no_fast(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.intr.exp2(%2)  : (f32) -> f32
    %4 = llvm.fpext %3 : f32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_uitofp_const_base_power_of_2_no_fast   : pow_uitofp_const_base_power_of_2_no_fast_before  ⊑  pow_uitofp_const_base_power_of_2_no_fast_combined := by
  unfold pow_uitofp_const_base_power_of_2_no_fast_before pow_uitofp_const_base_power_of_2_no_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_float_base_no_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_float_base_no_fast(%arg0: f32, %arg1: i32) -> f64 {
    %0 = llvm.sitofp %arg1 : i32 to f32
    %1 = llvm.intr.pow(%arg0, %0)  : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_sitofp_float_base_no_fast   : pow_sitofp_float_base_no_fast_before  ⊑  pow_sitofp_float_base_no_fast_combined := by
  unfold pow_sitofp_float_base_no_fast_before pow_sitofp_float_base_no_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_float_base_no_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_float_base_no_fast(%arg0: f32, %arg1: i32) -> f64 {
    %0 = llvm.uitofp %arg1 : i32 to f32
    %1 = llvm.intr.pow(%arg0, %0)  : (f32, f32) -> f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_uitofp_float_base_no_fast   : pow_uitofp_float_base_no_fast_before  ⊑  pow_uitofp_float_base_no_fast_combined := by
  unfold pow_uitofp_float_base_no_fast_before pow_uitofp_float_base_no_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_double_base_no_fast_combined := [llvmfunc|
  llvm.func @pow_sitofp_double_base_no_fast(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.sitofp %arg1 : i32 to f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_sitofp_double_base_no_fast   : pow_sitofp_double_base_no_fast_before  ⊑  pow_sitofp_double_base_no_fast_combined := by
  unfold pow_sitofp_double_base_no_fast_before pow_sitofp_double_base_no_fast_combined
  simp_alive_peephole
  sorry
def pow_uitofp_double_base_no_fast_combined := [llvmfunc|
  llvm.func @pow_uitofp_double_base_no_fast(%arg0: f64, %arg1: i32) -> f64 {
    %0 = llvm.uitofp %arg1 : i32 to f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_uitofp_double_base_no_fast   : pow_uitofp_double_base_no_fast_before  ⊑  pow_uitofp_double_base_no_fast_combined := by
  unfold pow_uitofp_double_base_no_fast_before pow_uitofp_double_base_no_fast_combined
  simp_alive_peephole
  sorry
def powf_exp_const_int_no_fast_combined := [llvmfunc|
  llvm.func @powf_exp_const_int_no_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_powf_exp_const_int_no_fast   : powf_exp_const_int_no_fast_before  ⊑  powf_exp_const_int_no_fast_combined := by
  unfold powf_exp_const_int_no_fast_before powf_exp_const_int_no_fast_combined
  simp_alive_peephole
  sorry
def powf_exp_const_not_int_fast_combined := [llvmfunc|
  llvm.func @powf_exp_const_not_int_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(37 : i32) : i32
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_powf_exp_const_not_int_fast   : powf_exp_const_not_int_fast_before  ⊑  powf_exp_const_not_int_fast_combined := by
  unfold powf_exp_const_not_int_fast_before powf_exp_const_not_int_fast_combined
  simp_alive_peephole
  sorry
def powf_exp_const_not_int_no_fast_combined := [llvmfunc|
  llvm.func @powf_exp_const_not_int_no_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.750000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_powf_exp_const_not_int_no_fast   : powf_exp_const_not_int_no_fast_before  ⊑  powf_exp_const_not_int_no_fast_combined := by
  unfold powf_exp_const_not_int_no_fast_before powf_exp_const_not_int_no_fast_combined
  simp_alive_peephole
  sorry
def powf_exp_const2_int_no_fast_combined := [llvmfunc|
  llvm.func @powf_exp_const2_int_no_fast(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.000000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_powf_exp_const2_int_no_fast   : powf_exp_const2_int_no_fast_before  ⊑  powf_exp_const2_int_no_fast_combined := by
  unfold powf_exp_const2_int_no_fast_before powf_exp_const2_int_no_fast_combined
  simp_alive_peephole
  sorry
def pow_sitofp_const_base_2_no_fast_vector_combined := [llvmfunc|
  llvm.func @pow_sitofp_const_base_2_no_fast_vector(%arg0: vector<2xi8>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf32>
    %1 = llvm.intr.exp2(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_pow_sitofp_const_base_2_no_fast_vector   : pow_sitofp_const_base_2_no_fast_vector_before  ⊑  pow_sitofp_const_base_2_no_fast_vector_combined := by
  unfold pow_sitofp_const_base_2_no_fast_vector_before pow_sitofp_const_base_2_no_fast_vector_combined
  simp_alive_peephole
  sorry
