import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  double-float-shrink-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def acos_test1_before := [llvmfunc|
  llvm.func @acos_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acos(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def acos_test2_before := [llvmfunc|
  llvm.func @acos_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acos(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def acosh_test1_before := [llvmfunc|
  llvm.func @acosh_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acosh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def acosh_test2_before := [llvmfunc|
  llvm.func @acosh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acosh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def asin_test1_before := [llvmfunc|
  llvm.func @asin_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asin(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def asin_test2_before := [llvmfunc|
  llvm.func @asin_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asin(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def asinh_test1_before := [llvmfunc|
  llvm.func @asinh_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asinh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def asinh_test2_before := [llvmfunc|
  llvm.func @asinh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asinh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def atan_test1_before := [llvmfunc|
  llvm.func @atan_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atan(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def atan_test2_before := [llvmfunc|
  llvm.func @atan_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atan(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def atanh_test1_before := [llvmfunc|
  llvm.func @atanh_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atanh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def atanh_test2_before := [llvmfunc|
  llvm.func @atanh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atanh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def cbrt_test1_before := [llvmfunc|
  llvm.func @cbrt_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cbrt(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def cbrt_test2_before := [llvmfunc|
  llvm.func @cbrt_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cbrt(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def exp_test1_before := [llvmfunc|
  llvm.func @exp_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def exp_test2_before := [llvmfunc|
  llvm.func @exp_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def expm1_test1_before := [llvmfunc|
  llvm.func @expm1_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @expm1(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def expm1_test2_before := [llvmfunc|
  llvm.func @expm1_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @expm1(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def exp10_test1_before := [llvmfunc|
  llvm.func @exp10_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp10(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def exp10_test2_before := [llvmfunc|
  llvm.func @exp10_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp10(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def log_test1_before := [llvmfunc|
  llvm.func @log_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def log_test2_before := [llvmfunc|
  llvm.func @log_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def log10_test1_before := [llvmfunc|
  llvm.func @log10_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log10(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def log10_test2_before := [llvmfunc|
  llvm.func @log10_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log10(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def log1p_test1_before := [llvmfunc|
  llvm.func @log1p_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log1p(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def log1p_test2_before := [llvmfunc|
  llvm.func @log1p_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log1p(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def log2_test1_before := [llvmfunc|
  llvm.func @log2_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log2(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def log2_test2_before := [llvmfunc|
  llvm.func @log2_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log2(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def logb_test1_before := [llvmfunc|
  llvm.func @logb_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @logb(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def logb_test2_before := [llvmfunc|
  llvm.func @logb_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @logb(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def pow_test1_before := [llvmfunc|
  llvm.func @pow_test1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def pow_test2_before := [llvmfunc|
  llvm.func @pow_test2(%arg0: f32, %arg1: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %2 : f64
  }]

def sin_test1_before := [llvmfunc|
  llvm.func @sin_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sin(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def sin_test2_before := [llvmfunc|
  llvm.func @sin_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sin(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_test1_before := [llvmfunc|
  llvm.func @sqrt_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def sqrt_test2_before := [llvmfunc|
  llvm.func @sqrt_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def sqrt_int_test1_before := [llvmfunc|
  llvm.func @sqrt_int_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def sqrt_int_test2_before := [llvmfunc|
  llvm.func @sqrt_int_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def tan_test1_before := [llvmfunc|
  llvm.func @tan_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tan(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def tan_test2_before := [llvmfunc|
  llvm.func @tan_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tan(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def tanh_test1_before := [llvmfunc|
  llvm.func @tanh_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tanh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def tanh_test2_before := [llvmfunc|
  llvm.func @tanh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tanh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def max1_before := [llvmfunc|
  llvm.func @max1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmax(%0, %1) {fastmathFlags = #llvm.fastmath<arcp>} : (f64, f64) -> f64]

    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def fake_fmin_before := [llvmfunc|
  llvm.func @fake_fmin(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f128
    %1 = llvm.fpext %arg1 : f32 to f128
    %2 = llvm.call @fmin(%0, %1) : (f128, f128) -> f128
    %3 = llvm.fptrunc %2 : f128 to f32
    llvm.return %3 : f32
  }]

def acos_test1_combined := [llvmfunc|
  llvm.func @acos_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @acosf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_acos_test1   : acos_test1_before  ⊑  acos_test1_combined := by
  unfold acos_test1_before acos_test1_combined
  simp_alive_peephole
  sorry
def acos_test2_combined := [llvmfunc|
  llvm.func @acos_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acos(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_acos_test2   : acos_test2_before  ⊑  acos_test2_combined := by
  unfold acos_test2_before acos_test2_combined
  simp_alive_peephole
  sorry
def acosh_test1_combined := [llvmfunc|
  llvm.func @acosh_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @acoshf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_acosh_test1   : acosh_test1_before  ⊑  acosh_test1_combined := by
  unfold acosh_test1_before acosh_test1_combined
  simp_alive_peephole
  sorry
def acosh_test2_combined := [llvmfunc|
  llvm.func @acosh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acosh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_acosh_test2   : acosh_test2_before  ⊑  acosh_test2_combined := by
  unfold acosh_test2_before acosh_test2_combined
  simp_alive_peephole
  sorry
def asin_test1_combined := [llvmfunc|
  llvm.func @asin_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @asinf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_asin_test1   : asin_test1_before  ⊑  asin_test1_combined := by
  unfold asin_test1_before asin_test1_combined
  simp_alive_peephole
  sorry
def asin_test2_combined := [llvmfunc|
  llvm.func @asin_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asin(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_asin_test2   : asin_test2_before  ⊑  asin_test2_combined := by
  unfold asin_test2_before asin_test2_combined
  simp_alive_peephole
  sorry
def asinh_test1_combined := [llvmfunc|
  llvm.func @asinh_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @asinhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_asinh_test1   : asinh_test1_before  ⊑  asinh_test1_combined := by
  unfold asinh_test1_before asinh_test1_combined
  simp_alive_peephole
  sorry
def asinh_test2_combined := [llvmfunc|
  llvm.func @asinh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asinh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_asinh_test2   : asinh_test2_before  ⊑  asinh_test2_combined := by
  unfold asinh_test2_before asinh_test2_combined
  simp_alive_peephole
  sorry
def atan_test1_combined := [llvmfunc|
  llvm.func @atan_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @atanf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_atan_test1   : atan_test1_before  ⊑  atan_test1_combined := by
  unfold atan_test1_before atan_test1_combined
  simp_alive_peephole
  sorry
def atan_test2_combined := [llvmfunc|
  llvm.func @atan_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atan(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_atan_test2   : atan_test2_before  ⊑  atan_test2_combined := by
  unfold atan_test2_before atan_test2_combined
  simp_alive_peephole
  sorry
def atanh_test1_combined := [llvmfunc|
  llvm.func @atanh_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @atanhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_atanh_test1   : atanh_test1_before  ⊑  atanh_test1_combined := by
  unfold atanh_test1_before atanh_test1_combined
  simp_alive_peephole
  sorry
def atanh_test2_combined := [llvmfunc|
  llvm.func @atanh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atanh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_atanh_test2   : atanh_test2_before  ⊑  atanh_test2_combined := by
  unfold atanh_test2_before atanh_test2_combined
  simp_alive_peephole
  sorry
def cbrt_test1_combined := [llvmfunc|
  llvm.func @cbrt_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @cbrtf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_cbrt_test1   : cbrt_test1_before  ⊑  cbrt_test1_combined := by
  unfold cbrt_test1_before cbrt_test1_combined
  simp_alive_peephole
  sorry
def cbrt_test2_combined := [llvmfunc|
  llvm.func @cbrt_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cbrt(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_cbrt_test2   : cbrt_test2_before  ⊑  cbrt_test2_combined := by
  unfold cbrt_test2_before cbrt_test2_combined
  simp_alive_peephole
  sorry
def exp_test1_combined := [llvmfunc|
  llvm.func @exp_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @expf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_exp_test1   : exp_test1_before  ⊑  exp_test1_combined := by
  unfold exp_test1_before exp_test1_combined
  simp_alive_peephole
  sorry
def exp_test2_combined := [llvmfunc|
  llvm.func @exp_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_exp_test2   : exp_test2_before  ⊑  exp_test2_combined := by
  unfold exp_test2_before exp_test2_combined
  simp_alive_peephole
  sorry
def expm1_test1_combined := [llvmfunc|
  llvm.func @expm1_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @expm1f(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_expm1_test1   : expm1_test1_before  ⊑  expm1_test1_combined := by
  unfold expm1_test1_before expm1_test1_combined
  simp_alive_peephole
  sorry
def expm1_test2_combined := [llvmfunc|
  llvm.func @expm1_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @expm1(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_expm1_test2   : expm1_test2_before  ⊑  expm1_test2_combined := by
  unfold expm1_test2_before expm1_test2_combined
  simp_alive_peephole
  sorry
def exp10_test1_combined := [llvmfunc|
  llvm.func @exp10_test1(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp10(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_exp10_test1   : exp10_test1_before  ⊑  exp10_test1_combined := by
  unfold exp10_test1_before exp10_test1_combined
  simp_alive_peephole
  sorry
def exp10_test2_combined := [llvmfunc|
  llvm.func @exp10_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @exp10(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_exp10_test2   : exp10_test2_before  ⊑  exp10_test2_combined := by
  unfold exp10_test2_before exp10_test2_combined
  simp_alive_peephole
  sorry
def log_test1_combined := [llvmfunc|
  llvm.func @log_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @logf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_log_test1   : log_test1_before  ⊑  log_test1_combined := by
  unfold log_test1_before log_test1_combined
  simp_alive_peephole
  sorry
def log_test2_combined := [llvmfunc|
  llvm.func @log_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_log_test2   : log_test2_before  ⊑  log_test2_combined := by
  unfold log_test2_before log_test2_combined
  simp_alive_peephole
  sorry
def log10_test1_combined := [llvmfunc|
  llvm.func @log10_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @log10f(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_log10_test1   : log10_test1_before  ⊑  log10_test1_combined := by
  unfold log10_test1_before log10_test1_combined
  simp_alive_peephole
  sorry
def log10_test2_combined := [llvmfunc|
  llvm.func @log10_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log10(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_log10_test2   : log10_test2_before  ⊑  log10_test2_combined := by
  unfold log10_test2_before log10_test2_combined
  simp_alive_peephole
  sorry
def log1p_test1_combined := [llvmfunc|
  llvm.func @log1p_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @log1pf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_log1p_test1   : log1p_test1_before  ⊑  log1p_test1_combined := by
  unfold log1p_test1_before log1p_test1_combined
  simp_alive_peephole
  sorry
def log1p_test2_combined := [llvmfunc|
  llvm.func @log1p_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log1p(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_log1p_test2   : log1p_test2_before  ⊑  log1p_test2_combined := by
  unfold log1p_test2_before log1p_test2_combined
  simp_alive_peephole
  sorry
def log2_test1_combined := [llvmfunc|
  llvm.func @log2_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @log2f(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_log2_test1   : log2_test1_before  ⊑  log2_test1_combined := by
  unfold log2_test1_before log2_test1_combined
  simp_alive_peephole
  sorry
def log2_test2_combined := [llvmfunc|
  llvm.func @log2_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log2(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_log2_test2   : log2_test2_before  ⊑  log2_test2_combined := by
  unfold log2_test2_before log2_test2_combined
  simp_alive_peephole
  sorry
def logb_test1_combined := [llvmfunc|
  llvm.func @logb_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @logbf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_logb_test1   : logb_test1_before  ⊑  logb_test1_combined := by
  unfold logb_test1_before logb_test1_combined
  simp_alive_peephole
  sorry
def logb_test2_combined := [llvmfunc|
  llvm.func @logb_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @logb(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_logb_test2   : logb_test2_before  ⊑  logb_test2_combined := by
  unfold logb_test2_before logb_test2_combined
  simp_alive_peephole
  sorry
def pow_test1_combined := [llvmfunc|
  llvm.func @pow_test1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @powf(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_pow_test1   : pow_test1_before  ⊑  pow_test1_combined := by
  unfold pow_test1_before pow_test1_combined
  simp_alive_peephole
  sorry
def pow_test2_combined := [llvmfunc|
  llvm.func @pow_test2(%arg0: f32, %arg1: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_test2   : pow_test2_before  ⊑  pow_test2_combined := by
  unfold pow_test2_before pow_test2_combined
  simp_alive_peephole
  sorry
def sin_test1_combined := [llvmfunc|
  llvm.func @sin_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @sinf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_sin_test1   : sin_test1_before  ⊑  sin_test1_combined := by
  unfold sin_test1_before sin_test1_combined
  simp_alive_peephole
  sorry
def sin_test2_combined := [llvmfunc|
  llvm.func @sin_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sin(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_sin_test2   : sin_test2_before  ⊑  sin_test2_combined := by
  unfold sin_test2_before sin_test2_combined
  simp_alive_peephole
  sorry
def sqrt_test1_combined := [llvmfunc|
  llvm.func @sqrt_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @sqrtf(%arg0) : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_sqrt_test1   : sqrt_test1_before  ⊑  sqrt_test1_combined := by
  unfold sqrt_test1_before sqrt_test1_combined
  simp_alive_peephole
  sorry
def sqrt_test2_combined := [llvmfunc|
  llvm.func @sqrt_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_test2   : sqrt_test2_before  ⊑  sqrt_test2_combined := by
  unfold sqrt_test2_before sqrt_test2_combined
  simp_alive_peephole
  sorry
def sqrt_int_test1_combined := [llvmfunc|
  llvm.func @sqrt_int_test1(%arg0: f32) -> f32 {
    %0 = llvm.intr.sqrt(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_sqrt_int_test1   : sqrt_int_test1_before  ⊑  sqrt_int_test1_combined := by
  unfold sqrt_int_test1_before sqrt_int_test1_combined
  simp_alive_peephole
  sorry
def sqrt_int_test2_combined := [llvmfunc|
  llvm.func @sqrt_int_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_sqrt_int_test2   : sqrt_int_test2_before  ⊑  sqrt_int_test2_combined := by
  unfold sqrt_int_test2_before sqrt_int_test2_combined
  simp_alive_peephole
  sorry
def tan_test1_combined := [llvmfunc|
  llvm.func @tan_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @tanf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_tan_test1   : tan_test1_before  ⊑  tan_test1_combined := by
  unfold tan_test1_before tan_test1_combined
  simp_alive_peephole
  sorry
def tan_test2_combined := [llvmfunc|
  llvm.func @tan_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tan(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_tan_test2   : tan_test2_before  ⊑  tan_test2_combined := by
  unfold tan_test2_before tan_test2_combined
  simp_alive_peephole
  sorry
def tanh_test1_combined := [llvmfunc|
  llvm.func @tanh_test1(%arg0: f32) -> f32 {
    %0 = llvm.call @tanhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_tanh_test1   : tanh_test1_before  ⊑  tanh_test1_combined := by
  unfold tanh_test1_before tanh_test1_combined
  simp_alive_peephole
  sorry
def tanh_test2_combined := [llvmfunc|
  llvm.func @tanh_test2(%arg0: f32) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tanh(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_tanh_test2   : tanh_test2_before  ⊑  tanh_test2_combined := by
  unfold tanh_test2_before tanh_test2_combined
  simp_alive_peephole
  sorry
def max1_combined := [llvmfunc|
  llvm.func @max1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz, arcp>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_max1   : max1_before  ⊑  max1_combined := by
  unfold max1_before max1_combined
  simp_alive_peephole
  sorry
def fake_fmin_combined := [llvmfunc|
  llvm.func @fake_fmin(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fake_fmin   : fake_fmin_before  ⊑  fake_fmin_combined := by
  unfold fake_fmin_before fake_fmin_combined
  simp_alive_peephole
  sorry
