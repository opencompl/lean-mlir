import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fabs
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def replace_fabs_call_f32_before := [llvmfunc|
  llvm.func @replace_fabs_call_f32(%arg0: f32) -> f32 {
    %0 = llvm.call @fabsf(%arg0) : (f32) -> f32
    llvm.return %0 : f32
  }]

def replace_fabs_call_f64_before := [llvmfunc|
  llvm.func @replace_fabs_call_f64(%arg0: f64) -> f64 {
    %0 = llvm.call @fabs(%arg0) : (f64) -> f64
    llvm.return %0 : f64
  }]

def replace_fabs_call_f128_before := [llvmfunc|
  llvm.func @replace_fabs_call_f128(%arg0: f128) -> f128 {
    %0 = llvm.call @fabsl(%arg0) : (f128) -> f128
    llvm.return %0 : f128
  }]

def fmf_replace_fabs_call_f32_before := [llvmfunc|
  llvm.func @fmf_replace_fabs_call_f32(%arg0: f32) -> f32 {
    %0 = llvm.call @fabsf(%arg0) {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32]

    llvm.return %0 : f32
  }]

def square_fabs_intrinsic_f32_before := [llvmfunc|
  llvm.func @square_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  : f32
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def square_fabs_intrinsic_f64_before := [llvmfunc|
  llvm.func @square_fabs_intrinsic_f64(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  : f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def square_fabs_intrinsic_f128_before := [llvmfunc|
  llvm.func @square_fabs_intrinsic_f128(%arg0: f128) -> f128 {
    %0 = llvm.fmul %arg0, %arg0  : f128
    %1 = llvm.intr.fabs(%0)  : (f128) -> f128
    llvm.return %1 : f128
  }]

def square_nnan_fabs_intrinsic_f32_before := [llvmfunc|
  llvm.func @square_nnan_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def square_fabs_shrink_call1_before := [llvmfunc|
  llvm.func @square_fabs_shrink_call1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fmul %0, %0  : f64
    %2 = llvm.call @fabs(%1) : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def square_fabs_shrink_call2_before := [llvmfunc|
  llvm.func @square_fabs_shrink_call2(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  : f32
    %1 = llvm.fpext %0 : f32 to f64
    %2 = llvm.call @fabs(%1) : (f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def fabs_select_constant_negative_positive_before := [llvmfunc|
  llvm.func @fabs_select_constant_negative_positive(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, f32
    %5 = llvm.intr.fabs(%4)  : (f32) -> f32
    llvm.return %5 : f32
  }]

def fabs_select_constant_positive_negative_before := [llvmfunc|
  llvm.func @fabs_select_constant_positive_negative(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(-2.000000e+00 : f32) : f32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, f32
    %5 = llvm.intr.fabs(%4)  : (f32) -> f32
    llvm.return %5 : f32
  }]

def fabs_select_constant_negative_negative_before := [llvmfunc|
  llvm.func @fabs_select_constant_negative_negative(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(-2.000000e+00 : f32) : f32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, f32
    %5 = llvm.intr.fabs(%4)  : (f32) -> f32
    llvm.return %5 : f32
  }]

def fabs_select_constant_neg0_before := [llvmfunc|
  llvm.func @fabs_select_constant_neg0(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, f32
    %5 = llvm.intr.fabs(%4)  : (f32) -> f32
    llvm.return %5 : f32
  }]

def fabs_select_var_constant_negative_before := [llvmfunc|
  llvm.func @fabs_select_var_constant_negative(%arg0: i32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, f32
    %4 = llvm.intr.fabs(%3)  : (f32) -> f32
    llvm.return %4 : f32
  }]

def square_fma_fabs_intrinsic_f32_before := [llvmfunc|
  llvm.func @square_fma_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg0, %0)  : (f32, f32, f32) -> f32
    %2 = llvm.intr.fabs(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

def square_nnan_fma_fabs_intrinsic_f32_before := [llvmfunc|
  llvm.func @square_nnan_fma_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32, f32) -> f32]

    %2 = llvm.intr.fabs(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

def square_fmuladd_fabs_intrinsic_f32_before := [llvmfunc|
  llvm.func @square_fmuladd_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg0, %0)  : (f32, f32, f32) -> f32
    %2 = llvm.intr.fabs(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

def square_nnan_fmuladd_fabs_intrinsic_f32_before := [llvmfunc|
  llvm.func @square_nnan_fmuladd_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32, f32) -> f32]

    %2 = llvm.intr.fabs(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

def multi_use_fabs_fpext_before := [llvmfunc|
  llvm.func @multi_use_fabs_fpext(%arg0: f32) -> f64 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.intr.fabs(%1)  : (f64) -> f64
    llvm.store volatile %1, %0 {alignment = 8 : i64} : f64, !llvm.ptr]

    llvm.return %2 : f64
  }]

def select_fcmp_ole_zero_before := [llvmfunc|
  llvm.func @select_fcmp_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

def select_fcmp_nnan_ole_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

def select_nnan_fcmp_nnan_ole_zero_before := [llvmfunc|
  llvm.func @select_nnan_fcmp_nnan_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_fcmp_nnan_ule_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_ule_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ule" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

def select_fcmp_nnan_olt_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_olt_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

def select_fcmp_nnan_ole_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_ole_negzero(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<2xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xf32>
    %8 = llvm.fcmp "ole" %arg0, %0 : vector<2xf32>
    %9 = llvm.fsub %7, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    %10 = llvm.select %8, %9, %arg0 : vector<2xi1>, vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }]

def select_nnan_fcmp_nnan_ole_negzero_before := [llvmfunc|
  llvm.func @select_nnan_fcmp_nnan_ole_negzero(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<2xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xf32>
    %8 = llvm.fcmp "ole" %arg0, %0 : vector<2xf32>
    %9 = llvm.fsub %7, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    %10 = llvm.select %8, %9, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf32>]

    llvm.return %10 : vector<2xf32>
  }]

def select_fcmp_ogt_zero_before := [llvmfunc|
  llvm.func @select_fcmp_ogt_zero(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(0.000000e+00 : f128) : f128
    %1 = llvm.fcmp "ogt" %arg0, %0 : f128
    %2 = llvm.fsub %0, %arg0  : f128
    %3 = llvm.select %1, %arg0, %2 : i1, f128
    llvm.return %3 : f128
  }]

def select_nsz_fcmp_ogt_fneg_before := [llvmfunc|
  llvm.func @select_nsz_fcmp_ogt_fneg(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ogt" %arg0, %0 : f32
    %2 = llvm.select %1, %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32]

    llvm.return %2 : f32
  }]

def select_nsz_nnan_fcmp_ogt_fneg_before := [llvmfunc|
  llvm.func @select_nsz_nnan_fcmp_ogt_fneg(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ogt" %arg0, %0 : f32
    %2 = llvm.select %1, %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f32]

    llvm.return %2 : f32
  }]

def select_fcmp_nnan_ogt_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_ogt_zero(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(0.000000e+00 : f128) : f128
    %1 = llvm.fcmp "ogt" %arg0, %0 : f128
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f128]

    %3 = llvm.select %1, %arg0, %2 : i1, f128
    llvm.return %3 : f128
  }]

def select_nnan_fcmp_nnan_ogt_zero_before := [llvmfunc|
  llvm.func @select_nnan_fcmp_nnan_ogt_zero(%arg0: f128) -> f128 {
    %0 = llvm.mlir.constant(0.000000e+00 : f128) : f128
    %1 = llvm.fcmp "ogt" %arg0, %0 : f128
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f128]

    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f128]

    llvm.return %3 : f128
  }]

def select_fcmp_nnan_ogt_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_ogt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.fcmp "ogt" %arg0, %0 : f16
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f16]

    %4 = llvm.select %2, %arg0, %3 : i1, f16
    llvm.return %4 : f16
  }]

def select_nnan_fcmp_nnan_ogt_negzero_before := [llvmfunc|
  llvm.func @select_nnan_fcmp_nnan_ogt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.fcmp "ogt" %arg0, %0 : f16
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f16]

    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f16]

    llvm.return %4 : f16
  }]

def select_fcmp_nnan_ugt_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_ugt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.fcmp "ugt" %arg0, %0 : f16
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f16]

    %4 = llvm.select %2, %arg0, %3 : i1, f16
    llvm.return %4 : f16
  }]

def select_fcmp_nnan_oge_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_oge_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.fcmp "oge" %arg0, %0 : f16
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f16]

    %4 = llvm.select %2, %arg0, %3 : i1, f16
    llvm.return %4 : f16
  }]

def select_nsz_fcmp_olt_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_nsz_fcmp_olt_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_fcmp_olt_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_nsz_nnan_fcmp_olt_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_fcmp_nnan_nsz_olt_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_olt_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "olt" %arg0, %0 : f64
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64]

    %4 = llvm.select %2, %3, %arg0 : i1, f64
    llvm.return %4 : f64
  }]

def select_nnan_nsz_fcmp_nnan_nsz_olt_zero_before := [llvmfunc|
  llvm.func @select_nnan_nsz_fcmp_nnan_nsz_olt_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "olt" %arg0, %0 : f64
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64]

    %4 = llvm.select %2, %3, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %4 : f64
  }]

def select_fcmp_nnan_nsz_ult_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ult_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f64
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64]

    %4 = llvm.select %2, %3, %arg0 : i1, f64
    llvm.return %4 : f64
  }]

def select_fcmp_nnan_nsz_olt_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_olt_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64]

    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

def select_fcmp_nnan_nsz_ult_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ult_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64]

    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

def select_fcmp_nnan_nsz_olt_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_olt_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

def select_nnan_ninf_nsz_fcmp_nnan_nsz_olt_negzero_before := [llvmfunc|
  llvm.func @select_nnan_ninf_nsz_fcmp_nnan_nsz_olt_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : i1, f32]

    llvm.return %3 : f32
  }]

def select_fcmp_nnan_nsz_ult_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ult_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ult" %arg0, %0 : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

def select_fcmp_nnan_nsz_olt_negzero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_olt_negzero_unary_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

def select_fcmp_nnan_nsz_ult_negzero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ult_negzero_unary_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ult" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

def select_fcmp_nnan_nsz_ole_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ole" %arg0, %0 : f64
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %4 = llvm.select %2, %3, %arg0 : i1, f64
    llvm.return %4 : f64
  }]

def select_fast_fcmp_nnan_nsz_ole_zero_before := [llvmfunc|
  llvm.func @select_fast_fcmp_nnan_nsz_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ole" %arg0, %0 : f64
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64]

    %4 = llvm.select %2, %3, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f64]

    llvm.return %4 : f64
  }]

def select_fcmp_nnan_nsz_ule_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ule_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ule" %arg0, %0 : f64
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %4 = llvm.select %2, %3, %arg0 : i1, f64
    llvm.return %4 : f64
  }]

def select_fcmp_nnan_nsz_ole_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ole_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

def select_fcmp_nnan_nsz_ule_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ule_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ule" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

def select_fcmp_nnan_nsz_ole_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ole_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ole" %arg0, %0 : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

def select_nnan_nsz_fcmp_nnan_nsz_ole_negzero_before := [llvmfunc|
  llvm.func @select_nnan_nsz_fcmp_nnan_nsz_ole_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ole" %arg0, %0 : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f32]

    llvm.return %3 : f32
  }]

def select_fcmp_nnan_nsz_ule_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ule_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ule" %arg0, %0 : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

def select_fcmp_nnan_nsz_ole_negzero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ole_negzero_unary_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ole" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

def select_fcmp_nnan_nsz_ule_negzero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ule_negzero_unary_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ule" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    %3 = llvm.select %1, %2, %arg0 : i1, f32
    llvm.return %3 : f32
  }]

def select_nsz_fcmp_ogt_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_nsz_fcmp_ogt_zero_unary_fneg(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ogt" %arg0, %1 : vector<2xf32>
    %3 = llvm.fneg %arg0  : vector<2xf32>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xi1>, vector<2xf32>]

    llvm.return %4 : vector<2xf32>
  }]

def select_nsz_nnan_fcmp_ogt_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_nsz_nnan_fcmp_ogt_zero_unary_fneg(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ogt" %arg0, %1 : vector<2xf32>
    %3 = llvm.fneg %arg0  : vector<2xf32>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xi1>, vector<2xf32>]

    llvm.return %4 : vector<2xf32>
  }]

def select_fcmp_nnan_nsz_ogt_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ogt_zero(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.fcmp "ogt" %arg0, %1 : vector<2xf32>
    %4 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, arcp>} : vector<2xf32>]

    %5 = llvm.select %3, %arg0, %4 : vector<2xi1>, vector<2xf32>
    llvm.return %5 : vector<2xf32>
  }]

def select_fcmp_nnan_nsz_ugt_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ugt_zero(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.fcmp "ugt" %arg0, %1 : vector<2xf32>
    %4 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, arcp>} : vector<2xf32>]

    %5 = llvm.select %3, %arg0, %4 : vector<2xi1>, vector<2xf32>
    llvm.return %5 : vector<2xf32>
  }]

def select_fcmp_nnan_nsz_ogt_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ogt_zero_unary_fneg(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ogt" %arg0, %1 : vector<2xf32>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, arcp>} : vector<2xf32>]

    %4 = llvm.select %2, %arg0, %3 : vector<2xi1>, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def select_fcmp_nnan_nsz_ugt_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ugt_zero_unary_fneg(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ugt" %arg0, %1 : vector<2xf32>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, arcp>} : vector<2xf32>]

    %4 = llvm.select %2, %arg0, %3 : vector<2xi1>, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def select_fcmp_nnan_nsz_ogt_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ogt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.fcmp "ogt" %arg0, %0 : f16
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    %4 = llvm.select %2, %arg0, %3 : i1, f16
    llvm.return %4 : f16
  }]

def select_fcmp_nnan_nsz_ugt_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ugt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %2 = llvm.fcmp "ugt" %arg0, %0 : f16
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    %4 = llvm.select %2, %arg0, %3 : i1, f16
    llvm.return %4 : f16
  }]

def select_fcmp_nnan_nsz_oge_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_oge_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.fcmp "oge" %arg0, %1 : vector<2xf64>
    %4 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : vector<2xf64>]

    %5 = llvm.select %3, %arg0, %4 : vector<2xi1>, vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }]

def select_fcmp_nnan_nsz_uge_zero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_uge_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.fcmp "uge" %arg0, %1 : vector<2xf64>
    %4 = llvm.fsub %2, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : vector<2xf64>]

    %5 = llvm.select %3, %arg0, %4 : vector<2xi1>, vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }]

def select_fcmp_nnan_nsz_oge_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_oge_zero_unary_fneg(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "oge" %arg0, %1 : vector<2xf64>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : vector<2xf64>]

    %4 = llvm.select %2, %arg0, %3 : vector<2xi1>, vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

def select_fcmp_nnan_nsz_uge_zero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_uge_zero_unary_fneg(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "uge" %arg0, %1 : vector<2xf64>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : vector<2xf64>]

    %4 = llvm.select %2, %arg0, %3 : vector<2xi1>, vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

def select_fcmp_nnan_nsz_oge_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_oge_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f16]

    %3 = llvm.select %1, %arg0, %2 : i1, f16
    llvm.return %3 : f16
  }]

def select_fcmp_nnan_nsz_uge_negzero_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_uge_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 : f16
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f16]

    %3 = llvm.select %1, %arg0, %2 : i1, f16
    llvm.return %3 : f16
  }]

def select_fcmp_nnan_nsz_oge_negzero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_oge_negzero_unary_fneg(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f16]

    %3 = llvm.select %1, %arg0, %2 : i1, f16
    llvm.return %3 : f16
  }]

def select_fcmp_nnan_nsz_uge_negzero_unary_fneg_before := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_uge_negzero_unary_fneg(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 : f16
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f16]

    %3 = llvm.select %1, %arg0, %2 : i1, f16
    llvm.return %3 : f16
  }]

def select_fneg_before := [llvmfunc|
  llvm.func @select_fneg(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg1  : f32
    %1 = llvm.select %arg0, %0, %arg1 : i1, f32
    %2 = llvm.intr.fabs(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

def select_fneg_use1_before := [llvmfunc|
  llvm.func @select_fneg_use1(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg1  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.select %arg0, %arg1, %0 : i1, f32
    %2 = llvm.intr.fabs(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %2 : f32
  }]

def select_fneg_use2_before := [llvmfunc|
  llvm.func @select_fneg_use2(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg1  {fastmathFlags = #llvm.fastmath<arcp>} : f32]

    %1 = llvm.select %arg0, %0, %arg1 : i1, f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.intr.fabs(%1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32) -> f32]

    llvm.return %2 : f32
  }]

def select_fneg_vec_before := [llvmfunc|
  llvm.func @select_fneg_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg1  : vector<2xf32>
    %1 = llvm.select %arg0, %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : vector<2xi1>, vector<2xf32>]

    %2 = llvm.intr.fabs(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def test_select_neg_negx_x_before := [llvmfunc|
  llvm.func @test_select_neg_negx_x(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_nneg_negx_x_before := [llvmfunc|
  llvm.func @test_select_nneg_negx_x(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_neg_x_negx_before := [llvmfunc|
  llvm.func @test_select_neg_x_negx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_nneg_x_negx_before := [llvmfunc|
  llvm.func @test_select_nneg_x_negx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_neg_negx_x_multiuse1_before := [llvmfunc|
  llvm.func @test_select_neg_negx_x_multiuse1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.call @usebool(%2) : (i1) -> ()
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_neg_negx_x_multiuse2_before := [llvmfunc|
  llvm.func @test_select_neg_negx_x_multiuse2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_neg_negx_x_multiuse3_before := [llvmfunc|
  llvm.func @test_select_neg_negx_x_multiuse3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.call @usebool(%2) : (i1) -> ()
    %3 = llvm.fneg %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_neg_negx_x_fmf_before := [llvmfunc|
  llvm.func @test_select_neg_negx_x_fmf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : i1, f32]

    llvm.return %4 : f32
  }]

def test_select_nneg_negx_x_fmf_before := [llvmfunc|
  llvm.func @test_select_nneg_negx_x_fmf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : i1, f32]

    llvm.return %4 : f32
  }]

def test_select_nneg_negx_x_multiuse4_before := [llvmfunc|
  llvm.func @test_select_nneg_negx_x_multiuse4(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.call @usebool(%2) : (i1) -> ()
    %3 = llvm.fneg %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_neg_negx_x_mismatched1_before := [llvmfunc|
  llvm.func @test_select_neg_negx_x_mismatched1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg1 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_neg_negx_x_mismatched2_before := [llvmfunc|
  llvm.func @test_select_neg_negx_x_mismatched2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg1  : f32
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_neg_negx_x_mismatched3_before := [llvmfunc|
  llvm.func @test_select_neg_negx_x_mismatched3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg1 : i1, f32
    llvm.return %4 : f32
  }]

def test_select_neg_negx_x_wrong_type_before := [llvmfunc|
  llvm.func @test_select_neg_negx_x_wrong_type(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    %3 = llvm.fneg %arg0  : vector<2xf32>
    %4 = llvm.select %2, %3, %arg0 : i1, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def replace_fabs_call_f32_combined := [llvmfunc|
  llvm.func @replace_fabs_call_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_replace_fabs_call_f32   : replace_fabs_call_f32_before  ⊑  replace_fabs_call_f32_combined := by
  unfold replace_fabs_call_f32_before replace_fabs_call_f32_combined
  simp_alive_peephole
  sorry
def replace_fabs_call_f64_combined := [llvmfunc|
  llvm.func @replace_fabs_call_f64(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_replace_fabs_call_f64   : replace_fabs_call_f64_before  ⊑  replace_fabs_call_f64_combined := by
  unfold replace_fabs_call_f64_before replace_fabs_call_f64_combined
  simp_alive_peephole
  sorry
def replace_fabs_call_f128_combined := [llvmfunc|
  llvm.func @replace_fabs_call_f128(%arg0: f128) -> f128 {
    %0 = llvm.intr.fabs(%arg0)  : (f128) -> f128
    llvm.return %0 : f128
  }]

theorem inst_combine_replace_fabs_call_f128   : replace_fabs_call_f128_before  ⊑  replace_fabs_call_f128_combined := by
  unfold replace_fabs_call_f128_before replace_fabs_call_f128_combined
  simp_alive_peephole
  sorry
def fmf_replace_fabs_call_f32_combined := [llvmfunc|
  llvm.func @fmf_replace_fabs_call_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmf_replace_fabs_call_f32   : fmf_replace_fabs_call_f32_before  ⊑  fmf_replace_fabs_call_f32_combined := by
  unfold fmf_replace_fabs_call_f32_before fmf_replace_fabs_call_f32_combined
  simp_alive_peephole
  sorry
def square_fabs_intrinsic_f32_combined := [llvmfunc|
  llvm.func @square_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  : f32
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_square_fabs_intrinsic_f32   : square_fabs_intrinsic_f32_before  ⊑  square_fabs_intrinsic_f32_combined := by
  unfold square_fabs_intrinsic_f32_before square_fabs_intrinsic_f32_combined
  simp_alive_peephole
  sorry
def square_fabs_intrinsic_f64_combined := [llvmfunc|
  llvm.func @square_fabs_intrinsic_f64(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  : f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_square_fabs_intrinsic_f64   : square_fabs_intrinsic_f64_before  ⊑  square_fabs_intrinsic_f64_combined := by
  unfold square_fabs_intrinsic_f64_before square_fabs_intrinsic_f64_combined
  simp_alive_peephole
  sorry
def square_fabs_intrinsic_f128_combined := [llvmfunc|
  llvm.func @square_fabs_intrinsic_f128(%arg0: f128) -> f128 {
    %0 = llvm.fmul %arg0, %arg0  : f128
    %1 = llvm.intr.fabs(%0)  : (f128) -> f128
    llvm.return %1 : f128
  }]

theorem inst_combine_square_fabs_intrinsic_f128   : square_fabs_intrinsic_f128_before  ⊑  square_fabs_intrinsic_f128_combined := by
  unfold square_fabs_intrinsic_f128_before square_fabs_intrinsic_f128_combined
  simp_alive_peephole
  sorry
def square_nnan_fabs_intrinsic_f32_combined := [llvmfunc|
  llvm.func @square_nnan_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_square_nnan_fabs_intrinsic_f32   : square_nnan_fabs_intrinsic_f32_before  ⊑  square_nnan_fabs_intrinsic_f32_combined := by
  unfold square_nnan_fabs_intrinsic_f32_before square_nnan_fabs_intrinsic_f32_combined
  simp_alive_peephole
  sorry
def square_fabs_shrink_call1_combined := [llvmfunc|
  llvm.func @square_fabs_shrink_call1(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  : f32
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_square_fabs_shrink_call1   : square_fabs_shrink_call1_before  ⊑  square_fabs_shrink_call1_combined := by
  unfold square_fabs_shrink_call1_before square_fabs_shrink_call1_combined
  simp_alive_peephole
  sorry
def square_fabs_shrink_call2_combined := [llvmfunc|
  llvm.func @square_fabs_shrink_call2(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  : f32
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_square_fabs_shrink_call2   : square_fabs_shrink_call2_before  ⊑  square_fabs_shrink_call2_combined := by
  unfold square_fabs_shrink_call2_before square_fabs_shrink_call2_combined
  simp_alive_peephole
  sorry
def fabs_select_constant_negative_positive_combined := [llvmfunc|
  llvm.func @fabs_select_constant_negative_positive(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fabs_select_constant_negative_positive   : fabs_select_constant_negative_positive_before  ⊑  fabs_select_constant_negative_positive_combined := by
  unfold fabs_select_constant_negative_positive_before fabs_select_constant_negative_positive_combined
  simp_alive_peephole
  sorry
def fabs_select_constant_positive_negative_combined := [llvmfunc|
  llvm.func @fabs_select_constant_positive_negative(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fabs_select_constant_positive_negative   : fabs_select_constant_positive_negative_before  ⊑  fabs_select_constant_positive_negative_combined := by
  unfold fabs_select_constant_positive_negative_before fabs_select_constant_positive_negative_combined
  simp_alive_peephole
  sorry
def fabs_select_constant_negative_negative_combined := [llvmfunc|
  llvm.func @fabs_select_constant_negative_negative(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fabs_select_constant_negative_negative   : fabs_select_constant_negative_negative_before  ⊑  fabs_select_constant_negative_negative_combined := by
  unfold fabs_select_constant_negative_negative_before fabs_select_constant_negative_negative_combined
  simp_alive_peephole
  sorry
def fabs_select_constant_neg0_combined := [llvmfunc|
  llvm.func @fabs_select_constant_neg0(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_select_constant_neg0   : fabs_select_constant_neg0_before  ⊑  fabs_select_constant_neg0_combined := by
  unfold fabs_select_constant_neg0_before fabs_select_constant_neg0_combined
  simp_alive_peephole
  sorry
def fabs_select_var_constant_negative_combined := [llvmfunc|
  llvm.func @fabs_select_var_constant_negative(%arg0: i32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, f32
    %4 = llvm.intr.fabs(%3)  : (f32) -> f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fabs_select_var_constant_negative   : fabs_select_var_constant_negative_before  ⊑  fabs_select_var_constant_negative_combined := by
  unfold fabs_select_var_constant_negative_before fabs_select_var_constant_negative_combined
  simp_alive_peephole
  sorry
def square_fma_fabs_intrinsic_f32_combined := [llvmfunc|
  llvm.func @square_fma_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg0, %0)  : (f32, f32, f32) -> f32
    %2 = llvm.intr.fabs(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_square_fma_fabs_intrinsic_f32   : square_fma_fabs_intrinsic_f32_before  ⊑  square_fma_fabs_intrinsic_f32_combined := by
  unfold square_fma_fabs_intrinsic_f32_before square_fma_fabs_intrinsic_f32_combined
  simp_alive_peephole
  sorry
def square_nnan_fma_fabs_intrinsic_f32_combined := [llvmfunc|
  llvm.func @square_nnan_fma_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_square_nnan_fma_fabs_intrinsic_f32   : square_nnan_fma_fabs_intrinsic_f32_before  ⊑  square_nnan_fma_fabs_intrinsic_f32_combined := by
  unfold square_nnan_fma_fabs_intrinsic_f32_before square_nnan_fma_fabs_intrinsic_f32_combined
  simp_alive_peephole
  sorry
def square_fmuladd_fabs_intrinsic_f32_combined := [llvmfunc|
  llvm.func @square_fmuladd_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg0, %0)  : (f32, f32, f32) -> f32
    %2 = llvm.intr.fabs(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_square_fmuladd_fabs_intrinsic_f32   : square_fmuladd_fabs_intrinsic_f32_before  ⊑  square_fmuladd_fabs_intrinsic_f32_combined := by
  unfold square_fmuladd_fabs_intrinsic_f32_before square_fmuladd_fabs_intrinsic_f32_combined
  simp_alive_peephole
  sorry
def square_nnan_fmuladd_fabs_intrinsic_f32_combined := [llvmfunc|
  llvm.func @square_nnan_fmuladd_fabs_intrinsic_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_square_nnan_fmuladd_fabs_intrinsic_f32   : square_nnan_fmuladd_fabs_intrinsic_f32_before  ⊑  square_nnan_fmuladd_fabs_intrinsic_f32_combined := by
  unfold square_nnan_fmuladd_fabs_intrinsic_f32_before square_nnan_fmuladd_fabs_intrinsic_f32_combined
  simp_alive_peephole
  sorry
def multi_use_fabs_fpext_combined := [llvmfunc|
  llvm.func @multi_use_fabs_fpext(%arg0: f32) -> f64 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.intr.fabs(%1)  : (f64) -> f64
    llvm.store volatile %1, %0 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.return %2 : f64
  }]

theorem inst_combine_multi_use_fabs_fpext   : multi_use_fabs_fpext_before  ⊑  multi_use_fabs_fpext_combined := by
  unfold multi_use_fabs_fpext_before multi_use_fabs_fpext_combined
  simp_alive_peephole
  sorry
def select_fcmp_ole_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_select_fcmp_ole_zero   : select_fcmp_ole_zero_before  ⊑  select_fcmp_ole_zero_combined := by
  unfold select_fcmp_ole_zero_before select_fcmp_ole_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_ole_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_select_fcmp_nnan_ole_zero   : select_fcmp_nnan_ole_zero_before  ⊑  select_fcmp_nnan_ole_zero_combined := by
  unfold select_fcmp_nnan_ole_zero_before select_fcmp_nnan_ole_zero_combined
  simp_alive_peephole
  sorry
def select_nnan_fcmp_nnan_ole_zero_combined := [llvmfunc|
  llvm.func @select_nnan_fcmp_nnan_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_select_nnan_fcmp_nnan_ole_zero   : select_nnan_fcmp_nnan_ole_zero_before  ⊑  select_nnan_fcmp_nnan_ole_zero_combined := by
  unfold select_nnan_fcmp_nnan_ole_zero_before select_nnan_fcmp_nnan_ole_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_ule_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_ule_zero(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_select_fcmp_nnan_ule_zero   : select_fcmp_nnan_ule_zero_before  ⊑  select_fcmp_nnan_ule_zero_combined := by
  unfold select_fcmp_nnan_ule_zero_before select_fcmp_nnan_ule_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_olt_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_olt_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_fcmp_nnan_olt_zero   : select_fcmp_nnan_olt_zero_before  ⊑  select_fcmp_nnan_olt_zero_combined := by
  unfold select_fcmp_nnan_olt_zero_before select_fcmp_nnan_olt_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_ole_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_ole_negzero(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_select_fcmp_nnan_ole_negzero   : select_fcmp_nnan_ole_negzero_before  ⊑  select_fcmp_nnan_ole_negzero_combined := by
  unfold select_fcmp_nnan_ole_negzero_before select_fcmp_nnan_ole_negzero_combined
  simp_alive_peephole
  sorry
def select_nnan_fcmp_nnan_ole_negzero_combined := [llvmfunc|
  llvm.func @select_nnan_fcmp_nnan_ole_negzero(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_select_nnan_fcmp_nnan_ole_negzero   : select_nnan_fcmp_nnan_ole_negzero_before  ⊑  select_nnan_fcmp_nnan_ole_negzero_combined := by
  unfold select_nnan_fcmp_nnan_ole_negzero_before select_nnan_fcmp_nnan_ole_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_ogt_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_ogt_zero(%arg0: f128) -> f128 {
    %0 = llvm.intr.fabs(%arg0)  : (f128) -> f128
    llvm.return %0 : f128
  }]

theorem inst_combine_select_fcmp_ogt_zero   : select_fcmp_ogt_zero_before  ⊑  select_fcmp_ogt_zero_combined := by
  unfold select_fcmp_ogt_zero_before select_fcmp_ogt_zero_combined
  simp_alive_peephole
  sorry
def select_nsz_fcmp_ogt_fneg_combined := [llvmfunc|
  llvm.func @select_nsz_fcmp_ogt_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fneg %arg0  : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %1 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_nsz_fcmp_ogt_fneg   : select_nsz_fcmp_ogt_fneg_before  ⊑  select_nsz_fcmp_ogt_fneg_combined := by
  unfold select_nsz_fcmp_ogt_fneg_before select_nsz_fcmp_ogt_fneg_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_fcmp_ogt_fneg_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_fcmp_ogt_fneg(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_select_nsz_nnan_fcmp_ogt_fneg   : select_nsz_nnan_fcmp_ogt_fneg_before  ⊑  select_nsz_nnan_fcmp_ogt_fneg_combined := by
  unfold select_nsz_nnan_fcmp_ogt_fneg_before select_nsz_nnan_fcmp_ogt_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_ogt_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_ogt_zero(%arg0: f128) -> f128 {
    %0 = llvm.intr.fabs(%arg0)  : (f128) -> f128
    llvm.return %0 : f128
  }]

theorem inst_combine_select_fcmp_nnan_ogt_zero   : select_fcmp_nnan_ogt_zero_before  ⊑  select_fcmp_nnan_ogt_zero_combined := by
  unfold select_fcmp_nnan_ogt_zero_before select_fcmp_nnan_ogt_zero_combined
  simp_alive_peephole
  sorry
def select_nnan_fcmp_nnan_ogt_zero_combined := [llvmfunc|
  llvm.func @select_nnan_fcmp_nnan_ogt_zero(%arg0: f128) -> f128 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f128) -> f128
    llvm.return %0 : f128
  }]

theorem inst_combine_select_nnan_fcmp_nnan_ogt_zero   : select_nnan_fcmp_nnan_ogt_zero_before  ⊑  select_nnan_fcmp_nnan_ogt_zero_combined := by
  unfold select_nnan_fcmp_nnan_ogt_zero_before select_nnan_fcmp_nnan_ogt_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_ogt_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_ogt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    llvm.return %0 : f16
  }]

theorem inst_combine_select_fcmp_nnan_ogt_negzero   : select_fcmp_nnan_ogt_negzero_before  ⊑  select_fcmp_nnan_ogt_negzero_combined := by
  unfold select_fcmp_nnan_ogt_negzero_before select_fcmp_nnan_ogt_negzero_combined
  simp_alive_peephole
  sorry
def select_nnan_fcmp_nnan_ogt_negzero_combined := [llvmfunc|
  llvm.func @select_nnan_fcmp_nnan_ogt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f16) -> f16
    llvm.return %0 : f16
  }]

theorem inst_combine_select_nnan_fcmp_nnan_ogt_negzero   : select_nnan_fcmp_nnan_ogt_negzero_before  ⊑  select_nnan_fcmp_nnan_ogt_negzero_combined := by
  unfold select_nnan_fcmp_nnan_ogt_negzero_before select_nnan_fcmp_nnan_ogt_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_ugt_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_ugt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    llvm.return %0 : f16
  }]

theorem inst_combine_select_fcmp_nnan_ugt_negzero   : select_fcmp_nnan_ugt_negzero_before  ⊑  select_fcmp_nnan_ugt_negzero_combined := by
  unfold select_fcmp_nnan_ugt_negzero_before select_fcmp_nnan_ugt_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_oge_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_oge_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan>} : f16
    %3 = llvm.select %1, %arg0, %2 : i1, f16
    llvm.return %3 : f16
  }]

theorem inst_combine_select_fcmp_nnan_oge_negzero   : select_fcmp_nnan_oge_negzero_before  ⊑  select_fcmp_nnan_oge_negzero_combined := by
  unfold select_fcmp_nnan_oge_negzero_before select_fcmp_nnan_oge_negzero_combined
  simp_alive_peephole
  sorry
def select_nsz_fcmp_olt_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_nsz_fcmp_olt_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_fcmp_olt_zero_unary_fneg   : select_nsz_fcmp_olt_zero_unary_fneg_before  ⊑  select_nsz_fcmp_olt_zero_unary_fneg_combined := by
  unfold select_nsz_fcmp_olt_zero_unary_fneg_before select_nsz_fcmp_olt_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_fcmp_olt_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_fcmp_olt_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_select_nsz_nnan_fcmp_olt_zero_unary_fneg   : select_nsz_nnan_fcmp_olt_zero_unary_fneg_before  ⊑  select_nsz_nnan_fcmp_olt_zero_unary_fneg_combined := by
  unfold select_nsz_nnan_fcmp_olt_zero_unary_fneg_before select_nsz_nnan_fcmp_olt_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_olt_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_olt_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_fcmp_nnan_nsz_olt_zero   : select_fcmp_nnan_nsz_olt_zero_before  ⊑  select_fcmp_nnan_nsz_olt_zero_combined := by
  unfold select_fcmp_nnan_nsz_olt_zero_before select_fcmp_nnan_nsz_olt_zero_combined
  simp_alive_peephole
  sorry
def select_nnan_nsz_fcmp_nnan_nsz_olt_zero_combined := [llvmfunc|
  llvm.func @select_nnan_nsz_fcmp_nnan_nsz_olt_zero(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_select_nnan_nsz_fcmp_nnan_nsz_olt_zero   : select_nnan_nsz_fcmp_nnan_nsz_olt_zero_before  ⊑  select_nnan_nsz_fcmp_nnan_nsz_olt_zero_combined := by
  unfold select_nnan_nsz_fcmp_nnan_nsz_olt_zero_before select_nnan_nsz_fcmp_nnan_nsz_olt_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ult_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ult_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ult_zero   : select_fcmp_nnan_nsz_ult_zero_before  ⊑  select_fcmp_nnan_nsz_ult_zero_combined := by
  unfold select_fcmp_nnan_nsz_ult_zero_before select_fcmp_nnan_nsz_ult_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_olt_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_olt_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_fcmp_nnan_nsz_olt_zero_unary_fneg   : select_fcmp_nnan_nsz_olt_zero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_olt_zero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_olt_zero_unary_fneg_before select_fcmp_nnan_nsz_olt_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ult_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ult_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ult_zero_unary_fneg   : select_fcmp_nnan_nsz_ult_zero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_ult_zero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_ult_zero_unary_fneg_before select_fcmp_nnan_nsz_ult_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_olt_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_olt_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fcmp_nnan_nsz_olt_negzero   : select_fcmp_nnan_nsz_olt_negzero_before  ⊑  select_fcmp_nnan_nsz_olt_negzero_combined := by
  unfold select_fcmp_nnan_nsz_olt_negzero_before select_fcmp_nnan_nsz_olt_negzero_combined
  simp_alive_peephole
  sorry
def select_nnan_ninf_nsz_fcmp_nnan_nsz_olt_negzero_combined := [llvmfunc|
  llvm.func @select_nnan_ninf_nsz_fcmp_nnan_nsz_olt_negzero(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_select_nnan_ninf_nsz_fcmp_nnan_nsz_olt_negzero   : select_nnan_ninf_nsz_fcmp_nnan_nsz_olt_negzero_before  ⊑  select_nnan_ninf_nsz_fcmp_nnan_nsz_olt_negzero_combined := by
  unfold select_nnan_ninf_nsz_fcmp_nnan_nsz_olt_negzero_before select_nnan_ninf_nsz_fcmp_nnan_nsz_olt_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ult_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ult_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ult" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ult_negzero   : select_fcmp_nnan_nsz_ult_negzero_before  ⊑  select_fcmp_nnan_nsz_ult_negzero_combined := by
  unfold select_fcmp_nnan_nsz_ult_negzero_before select_fcmp_nnan_nsz_ult_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_olt_negzero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_olt_negzero_unary_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fcmp_nnan_nsz_olt_negzero_unary_fneg   : select_fcmp_nnan_nsz_olt_negzero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_olt_negzero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_olt_negzero_unary_fneg_before select_fcmp_nnan_nsz_olt_negzero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ult_negzero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ult_negzero_unary_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ult" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ult_negzero_unary_fneg   : select_fcmp_nnan_nsz_ult_negzero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_ult_negzero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_ult_negzero_unary_fneg_before select_fcmp_nnan_nsz_ult_negzero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ole_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ole_zero   : select_fcmp_nnan_nsz_ole_zero_before  ⊑  select_fcmp_nnan_nsz_ole_zero_combined := by
  unfold select_fcmp_nnan_nsz_ole_zero_before select_fcmp_nnan_nsz_ole_zero_combined
  simp_alive_peephole
  sorry
def select_fast_fcmp_nnan_nsz_ole_zero_combined := [llvmfunc|
  llvm.func @select_fast_fcmp_nnan_nsz_ole_zero(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_select_fast_fcmp_nnan_nsz_ole_zero   : select_fast_fcmp_nnan_nsz_ole_zero_before  ⊑  select_fast_fcmp_nnan_nsz_ole_zero_combined := by
  unfold select_fast_fcmp_nnan_nsz_ole_zero_before select_fast_fcmp_nnan_nsz_ole_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ule_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ule_zero(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ule" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ule_zero   : select_fcmp_nnan_nsz_ule_zero_before  ⊑  select_fcmp_nnan_nsz_ule_zero_combined := by
  unfold select_fcmp_nnan_nsz_ule_zero_before select_fcmp_nnan_nsz_ule_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ole_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ole_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ole_zero_unary_fneg   : select_fcmp_nnan_nsz_ole_zero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_ole_zero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_ole_zero_unary_fneg_before select_fcmp_nnan_nsz_ole_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ule_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ule_zero_unary_fneg(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ule" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ule_zero_unary_fneg   : select_fcmp_nnan_nsz_ule_zero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_ule_zero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_ule_zero_unary_fneg_before select_fcmp_nnan_nsz_ule_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ole_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ole_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ole" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ole_negzero   : select_fcmp_nnan_nsz_ole_negzero_before  ⊑  select_fcmp_nnan_nsz_ole_negzero_combined := by
  unfold select_fcmp_nnan_nsz_ole_negzero_before select_fcmp_nnan_nsz_ole_negzero_combined
  simp_alive_peephole
  sorry
def select_nnan_nsz_fcmp_nnan_nsz_ole_negzero_combined := [llvmfunc|
  llvm.func @select_nnan_nsz_fcmp_nnan_nsz_ole_negzero(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_select_nnan_nsz_fcmp_nnan_nsz_ole_negzero   : select_nnan_nsz_fcmp_nnan_nsz_ole_negzero_before  ⊑  select_nnan_nsz_fcmp_nnan_nsz_ole_negzero_combined := by
  unfold select_nnan_nsz_fcmp_nnan_nsz_ole_negzero_before select_nnan_nsz_fcmp_nnan_nsz_ole_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ule_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ule_negzero(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ule" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ule_negzero   : select_fcmp_nnan_nsz_ule_negzero_before  ⊑  select_fcmp_nnan_nsz_ule_negzero_combined := by
  unfold select_fcmp_nnan_nsz_ule_negzero_before select_fcmp_nnan_nsz_ule_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ole_negzero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ole_negzero_unary_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ole" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ole_negzero_unary_fneg   : select_fcmp_nnan_nsz_ole_negzero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_ole_negzero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_ole_negzero_unary_fneg_before select_fcmp_nnan_nsz_ole_negzero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ule_negzero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ule_negzero_unary_fneg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ule" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ule_negzero_unary_fneg   : select_fcmp_nnan_nsz_ule_negzero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_ule_negzero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_ule_negzero_unary_fneg_before select_fcmp_nnan_nsz_ule_negzero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_nsz_fcmp_ogt_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_nsz_fcmp_ogt_zero_unary_fneg(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ogt" %arg0, %1 : vector<2xf32>
    %3 = llvm.fneg %arg0  : vector<2xf32>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xi1>, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_select_nsz_fcmp_ogt_zero_unary_fneg   : select_nsz_fcmp_ogt_zero_unary_fneg_before  ⊑  select_nsz_fcmp_ogt_zero_unary_fneg_combined := by
  unfold select_nsz_fcmp_ogt_zero_unary_fneg_before select_nsz_fcmp_ogt_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_fcmp_ogt_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_fcmp_ogt_zero_unary_fneg(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_select_nsz_nnan_fcmp_ogt_zero_unary_fneg   : select_nsz_nnan_fcmp_ogt_zero_unary_fneg_before  ⊑  select_nsz_nnan_fcmp_ogt_zero_unary_fneg_combined := by
  unfold select_nsz_nnan_fcmp_ogt_zero_unary_fneg_before select_nsz_nnan_fcmp_ogt_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ogt_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ogt_zero(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ogt" %arg0, %1 : vector<2xf32>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, arcp>} : vector<2xf32>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ogt_zero   : select_fcmp_nnan_nsz_ogt_zero_before  ⊑  select_fcmp_nnan_nsz_ogt_zero_combined := by
  unfold select_fcmp_nnan_nsz_ogt_zero_before select_fcmp_nnan_nsz_ogt_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ugt_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ugt_zero(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ugt" %arg0, %1 : vector<2xf32>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, arcp>} : vector<2xf32>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ugt_zero   : select_fcmp_nnan_nsz_ugt_zero_before  ⊑  select_fcmp_nnan_nsz_ugt_zero_combined := by
  unfold select_fcmp_nnan_nsz_ugt_zero_before select_fcmp_nnan_nsz_ugt_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ogt_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ogt_zero_unary_fneg(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ogt" %arg0, %1 : vector<2xf32>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, arcp>} : vector<2xf32>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ogt_zero_unary_fneg   : select_fcmp_nnan_nsz_ogt_zero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_ogt_zero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_ogt_zero_unary_fneg_before select_fcmp_nnan_nsz_ogt_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ugt_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ugt_zero_unary_fneg(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ugt" %arg0, %1 : vector<2xf32>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, arcp>} : vector<2xf32>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ugt_zero_unary_fneg   : select_fcmp_nnan_nsz_ugt_zero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_ugt_zero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_ugt_zero_unary_fneg_before select_fcmp_nnan_nsz_ugt_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ogt_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ogt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ogt" %arg0, %0 : f16
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f16
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f16
    llvm.return %3 : f16
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ogt_negzero   : select_fcmp_nnan_nsz_ogt_negzero_before  ⊑  select_fcmp_nnan_nsz_ogt_negzero_combined := by
  unfold select_fcmp_nnan_nsz_ogt_negzero_before select_fcmp_nnan_nsz_ogt_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_ugt_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_ugt_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ugt" %arg0, %0 : f16
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f16
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f16
    llvm.return %3 : f16
  }]

theorem inst_combine_select_fcmp_nnan_nsz_ugt_negzero   : select_fcmp_nnan_nsz_ugt_negzero_before  ⊑  select_fcmp_nnan_nsz_ugt_negzero_combined := by
  unfold select_fcmp_nnan_nsz_ugt_negzero_before select_fcmp_nnan_nsz_ugt_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_oge_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_oge_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "oge" %arg0, %1 : vector<2xf64>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : vector<2xf64>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_select_fcmp_nnan_nsz_oge_zero   : select_fcmp_nnan_nsz_oge_zero_before  ⊑  select_fcmp_nnan_nsz_oge_zero_combined := by
  unfold select_fcmp_nnan_nsz_oge_zero_before select_fcmp_nnan_nsz_oge_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_uge_zero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_uge_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "uge" %arg0, %1 : vector<2xf64>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : vector<2xf64>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_select_fcmp_nnan_nsz_uge_zero   : select_fcmp_nnan_nsz_uge_zero_before  ⊑  select_fcmp_nnan_nsz_uge_zero_combined := by
  unfold select_fcmp_nnan_nsz_uge_zero_before select_fcmp_nnan_nsz_uge_zero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_oge_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_oge_zero_unary_fneg(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "oge" %arg0, %1 : vector<2xf64>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : vector<2xf64>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_select_fcmp_nnan_nsz_oge_zero_unary_fneg   : select_fcmp_nnan_nsz_oge_zero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_oge_zero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_oge_zero_unary_fneg_before select_fcmp_nnan_nsz_oge_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_uge_zero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_uge_zero_unary_fneg(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fcmp "uge" %arg0, %1 : vector<2xf64>
    %3 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : vector<2xf64>
    %4 = llvm.select %2, %arg0, %3 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }]

theorem inst_combine_select_fcmp_nnan_nsz_uge_zero_unary_fneg   : select_fcmp_nnan_nsz_uge_zero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_uge_zero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_uge_zero_unary_fneg_before select_fcmp_nnan_nsz_uge_zero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_oge_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_oge_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f16
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f16
    llvm.return %3 : f16
  }]

theorem inst_combine_select_fcmp_nnan_nsz_oge_negzero   : select_fcmp_nnan_nsz_oge_negzero_before  ⊑  select_fcmp_nnan_nsz_oge_negzero_combined := by
  unfold select_fcmp_nnan_nsz_oge_negzero_before select_fcmp_nnan_nsz_oge_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_uge_negzero_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_uge_negzero(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 : f16
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f16
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f16
    llvm.return %3 : f16
  }]

theorem inst_combine_select_fcmp_nnan_nsz_uge_negzero   : select_fcmp_nnan_nsz_uge_negzero_before  ⊑  select_fcmp_nnan_nsz_uge_negzero_combined := by
  unfold select_fcmp_nnan_nsz_uge_negzero_before select_fcmp_nnan_nsz_uge_negzero_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_oge_negzero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_oge_negzero_unary_fneg(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f16
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f16
    llvm.return %3 : f16
  }]

theorem inst_combine_select_fcmp_nnan_nsz_oge_negzero_unary_fneg   : select_fcmp_nnan_nsz_oge_negzero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_oge_negzero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_oge_negzero_unary_fneg_before select_fcmp_nnan_nsz_oge_negzero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fcmp_nnan_nsz_uge_negzero_unary_fneg_combined := [llvmfunc|
  llvm.func @select_fcmp_nnan_nsz_uge_negzero_unary_fneg(%arg0: f16) -> f16 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 : f16
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f16
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f16
    llvm.return %3 : f16
  }]

theorem inst_combine_select_fcmp_nnan_nsz_uge_negzero_unary_fneg   : select_fcmp_nnan_nsz_uge_negzero_unary_fneg_before  ⊑  select_fcmp_nnan_nsz_uge_negzero_unary_fneg_combined := by
  unfold select_fcmp_nnan_nsz_uge_negzero_unary_fneg_before select_fcmp_nnan_nsz_uge_negzero_unary_fneg_combined
  simp_alive_peephole
  sorry
def select_fneg_combined := [llvmfunc|
  llvm.func @select_fneg(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg1)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_select_fneg   : select_fneg_before  ⊑  select_fneg_combined := by
  unfold select_fneg_before select_fneg_combined
  simp_alive_peephole
  sorry
def select_fneg_use1_combined := [llvmfunc|
  llvm.func @select_fneg_use1(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg1  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.fabs(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_select_fneg_use1   : select_fneg_use1_before  ⊑  select_fneg_use1_combined := by
  unfold select_fneg_use1_before select_fneg_use1_combined
  simp_alive_peephole
  sorry
def select_fneg_use2_combined := [llvmfunc|
  llvm.func @select_fneg_use2(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg1  {fastmathFlags = #llvm.fastmath<arcp>} : f32
    %1 = llvm.select %arg0, %0, %arg1 : i1, f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.intr.fabs(%arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_select_fneg_use2   : select_fneg_use2_before  ⊑  select_fneg_use2_combined := by
  unfold select_fneg_use2_before select_fneg_use2_combined
  simp_alive_peephole
  sorry
def select_fneg_vec_combined := [llvmfunc|
  llvm.func @select_fneg_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fabs(%arg1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_select_fneg_vec   : select_fneg_vec_before  ⊑  select_fneg_vec_combined := by
  unfold select_fneg_vec_before select_fneg_vec_combined
  simp_alive_peephole
  sorry
def test_select_neg_negx_x_combined := [llvmfunc|
  llvm.func @test_select_neg_negx_x(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_neg_negx_x   : test_select_neg_negx_x_before  ⊑  test_select_neg_negx_x_combined := by
  unfold test_select_neg_negx_x_before test_select_neg_negx_x_combined
  simp_alive_peephole
  sorry
def test_select_nneg_negx_x_combined := [llvmfunc|
  llvm.func @test_select_nneg_negx_x(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.icmp "slt" %1, %0 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_nneg_negx_x   : test_select_nneg_negx_x_before  ⊑  test_select_nneg_negx_x_combined := by
  unfold test_select_nneg_negx_x_before test_select_nneg_negx_x_combined
  simp_alive_peephole
  sorry
def test_select_neg_x_negx_combined := [llvmfunc|
  llvm.func @test_select_neg_x_negx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_neg_x_negx   : test_select_neg_x_negx_before  ⊑  test_select_neg_x_negx_combined := by
  unfold test_select_neg_x_negx_before test_select_neg_x_negx_combined
  simp_alive_peephole
  sorry
def test_select_nneg_x_negx_combined := [llvmfunc|
  llvm.func @test_select_nneg_x_negx(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.icmp "slt" %1, %0 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_nneg_x_negx   : test_select_nneg_x_negx_before  ⊑  test_select_nneg_x_negx_combined := by
  unfold test_select_nneg_x_negx_before test_select_nneg_x_negx_combined
  simp_alive_peephole
  sorry
def test_select_neg_negx_x_multiuse1_combined := [llvmfunc|
  llvm.func @test_select_neg_negx_x_multiuse1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.call @usebool(%2) : (i1) -> ()
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_neg_negx_x_multiuse1   : test_select_neg_negx_x_multiuse1_before  ⊑  test_select_neg_negx_x_multiuse1_combined := by
  unfold test_select_neg_negx_x_multiuse1_before test_select_neg_negx_x_multiuse1_combined
  simp_alive_peephole
  sorry
def test_select_neg_negx_x_multiuse2_combined := [llvmfunc|
  llvm.func @test_select_neg_negx_x_multiuse2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_neg_negx_x_multiuse2   : test_select_neg_negx_x_multiuse2_before  ⊑  test_select_neg_negx_x_multiuse2_combined := by
  unfold test_select_neg_negx_x_multiuse2_before test_select_neg_negx_x_multiuse2_combined
  simp_alive_peephole
  sorry
def test_select_neg_negx_x_multiuse3_combined := [llvmfunc|
  llvm.func @test_select_neg_negx_x_multiuse3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.call @usebool(%2) : (i1) -> ()
    %3 = llvm.fneg %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_neg_negx_x_multiuse3   : test_select_neg_negx_x_multiuse3_before  ⊑  test_select_neg_negx_x_multiuse3_combined := by
  unfold test_select_neg_negx_x_multiuse3_before test_select_neg_negx_x_multiuse3_combined
  simp_alive_peephole
  sorry
def test_select_neg_negx_x_fmf_combined := [llvmfunc|
  llvm.func @test_select_neg_negx_x_fmf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_neg_negx_x_fmf   : test_select_neg_negx_x_fmf_before  ⊑  test_select_neg_negx_x_fmf_combined := by
  unfold test_select_neg_negx_x_fmf_before test_select_neg_negx_x_fmf_combined
  simp_alive_peephole
  sorry
def test_select_nneg_negx_x_fmf_combined := [llvmfunc|
  llvm.func @test_select_nneg_negx_x_fmf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.icmp "slt" %1, %0 : i32
    %4 = llvm.select %3, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_nneg_negx_x_fmf   : test_select_nneg_negx_x_fmf_before  ⊑  test_select_nneg_negx_x_fmf_combined := by
  unfold test_select_nneg_negx_x_fmf_before test_select_nneg_negx_x_fmf_combined
  simp_alive_peephole
  sorry
def test_select_nneg_negx_x_multiuse4_combined := [llvmfunc|
  llvm.func @test_select_nneg_negx_x_multiuse4(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    llvm.call @usebool(%2) : (i1) -> ()
    %3 = llvm.fneg %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_nneg_negx_x_multiuse4   : test_select_nneg_negx_x_multiuse4_before  ⊑  test_select_nneg_negx_x_multiuse4_combined := by
  unfold test_select_nneg_negx_x_multiuse4_before test_select_nneg_negx_x_multiuse4_combined
  simp_alive_peephole
  sorry
def test_select_neg_negx_x_mismatched1_combined := [llvmfunc|
  llvm.func @test_select_neg_negx_x_mismatched1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg1 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_neg_negx_x_mismatched1   : test_select_neg_negx_x_mismatched1_before  ⊑  test_select_neg_negx_x_mismatched1_combined := by
  unfold test_select_neg_negx_x_mismatched1_before test_select_neg_negx_x_mismatched1_combined
  simp_alive_peephole
  sorry
def test_select_neg_negx_x_mismatched2_combined := [llvmfunc|
  llvm.func @test_select_neg_negx_x_mismatched2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg1  : f32
    %4 = llvm.select %2, %3, %arg0 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_neg_negx_x_mismatched2   : test_select_neg_negx_x_mismatched2_before  ⊑  test_select_neg_negx_x_mismatched2_combined := by
  unfold test_select_neg_negx_x_mismatched2_before test_select_neg_negx_x_mismatched2_combined
  simp_alive_peephole
  sorry
def test_select_neg_negx_x_mismatched3_combined := [llvmfunc|
  llvm.func @test_select_neg_negx_x_mismatched3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %3, %arg1 : i1, f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_select_neg_negx_x_mismatched3   : test_select_neg_negx_x_mismatched3_before  ⊑  test_select_neg_negx_x_mismatched3_combined := by
  unfold test_select_neg_negx_x_mismatched3_before test_select_neg_negx_x_mismatched3_combined
  simp_alive_peephole
  sorry
def test_select_neg_negx_x_wrong_type_combined := [llvmfunc|
  llvm.func @test_select_neg_negx_x_wrong_type(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    %3 = llvm.fneg %arg0  : vector<2xf32>
    %4 = llvm.select %2, %3, %arg0 : i1, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_test_select_neg_negx_x_wrong_type   : test_select_neg_negx_x_wrong_type_before  ⊑  test_select_neg_negx_x_wrong_type_combined := by
  unfold test_select_neg_negx_x_wrong_type_before test_select_neg_negx_x_wrong_type_combined
  simp_alive_peephole
  sorry
