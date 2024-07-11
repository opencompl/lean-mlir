import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  win-math
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def float_acos_before := [llvmfunc|
  llvm.func @float_acos(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_asin_before := [llvmfunc|
  llvm.func @float_asin(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asin(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_atan_before := [llvmfunc|
  llvm.func @float_atan(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atan(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_atan2_before := [llvmfunc|
  llvm.func @float_atan2(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @atan2(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def float_ceil_before := [llvmfunc|
  llvm.func @float_ceil(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @ceil(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_copysign_before := [llvmfunc|
  llvm.func @float_copysign(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @_copysign(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_cos_before := [llvmfunc|
  llvm.func @float_cos(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_cosh_before := [llvmfunc|
  llvm.func @float_cosh(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cosh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_exp_before := [llvmfunc|
  llvm.func @float_exp(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @exp(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def float_fabs_before := [llvmfunc|
  llvm.func @float_fabs(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fabs(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def float_floor_before := [llvmfunc|
  llvm.func @float_floor(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @floor(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_fmod_before := [llvmfunc|
  llvm.func @float_fmod(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmod(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def float_log_before := [llvmfunc|
  llvm.func @float_log(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_logb_before := [llvmfunc|
  llvm.func @float_logb(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @logb(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_pow_before := [llvmfunc|
  llvm.func @float_pow(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def float_sin_before := [llvmfunc|
  llvm.func @float_sin(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_sinh_before := [llvmfunc|
  llvm.func @float_sinh(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sinh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_sqrt_before := [llvmfunc|
  llvm.func @float_sqrt(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_tan_before := [llvmfunc|
  llvm.func @float_tan(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tan(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_tanh_before := [llvmfunc|
  llvm.func @float_tanh(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tanh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_round_before := [llvmfunc|
  llvm.func @float_round(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @round(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def float_powsqrt_before := [llvmfunc|
  llvm.func @float_powsqrt(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def float_acos_combined := [llvmfunc|
  llvm.func @float_acos(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_acos   : float_acos_before  ⊑  float_acos_combined := by
  unfold float_acos_before float_acos_combined
  simp_alive_peephole
  sorry
def float_asin_combined := [llvmfunc|
  llvm.func @float_asin(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @asin(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_asin   : float_asin_before  ⊑  float_asin_combined := by
  unfold float_asin_before float_asin_combined
  simp_alive_peephole
  sorry
def float_atan_combined := [llvmfunc|
  llvm.func @float_atan(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @atan(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_atan   : float_atan_before  ⊑  float_atan_combined := by
  unfold float_atan_before float_atan_combined
  simp_alive_peephole
  sorry
def float_atan2_combined := [llvmfunc|
  llvm.func @float_atan2(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @atan2(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_float_atan2   : float_atan2_before  ⊑  float_atan2_combined := by
  unfold float_atan2_before float_atan2_combined
  simp_alive_peephole
  sorry
def float_ceil_combined := [llvmfunc|
  llvm.func @float_ceil(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.intr.ceil(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_float_ceil   : float_ceil_before  ⊑  float_ceil_combined := by
  unfold float_ceil_before float_ceil_combined
  simp_alive_peephole
  sorry
def float_copysign_combined := [llvmfunc|
  llvm.func @float_copysign(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @_copysign(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_copysign   : float_copysign_before  ⊑  float_copysign_combined := by
  unfold float_copysign_before float_copysign_combined
  simp_alive_peephole
  sorry
def float_cos_combined := [llvmfunc|
  llvm.func @float_cos(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cos(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_cos   : float_cos_before  ⊑  float_cos_combined := by
  unfold float_cos_before float_cos_combined
  simp_alive_peephole
  sorry
def float_cosh_combined := [llvmfunc|
  llvm.func @float_cosh(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @cosh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_cosh   : float_cosh_before  ⊑  float_cosh_combined := by
  unfold float_cosh_before float_cosh_combined
  simp_alive_peephole
  sorry
def float_exp_combined := [llvmfunc|
  llvm.func @float_exp(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @exp(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_float_exp   : float_exp_before  ⊑  float_exp_combined := by
  unfold float_exp_before float_exp_combined
  simp_alive_peephole
  sorry
def float_fabs_combined := [llvmfunc|
  llvm.func @float_fabs(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fabs(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_float_fabs   : float_fabs_before  ⊑  float_fabs_combined := by
  unfold float_fabs_before float_fabs_combined
  simp_alive_peephole
  sorry
def float_floor_combined := [llvmfunc|
  llvm.func @float_floor(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.intr.floor(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_float_floor   : float_floor_before  ⊑  float_floor_combined := by
  unfold float_floor_before float_floor_combined
  simp_alive_peephole
  sorry
def float_fmod_combined := [llvmfunc|
  llvm.func @float_fmod(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmod(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_float_fmod   : float_fmod_before  ⊑  float_fmod_combined := by
  unfold float_fmod_before float_fmod_combined
  simp_alive_peephole
  sorry
def float_log_combined := [llvmfunc|
  llvm.func @float_log(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_log   : float_log_before  ⊑  float_log_combined := by
  unfold float_log_before float_log_combined
  simp_alive_peephole
  sorry
def float_logb_combined := [llvmfunc|
  llvm.func @float_logb(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @logb(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_logb   : float_logb_before  ⊑  float_logb_combined := by
  unfold float_logb_before float_logb_combined
  simp_alive_peephole
  sorry
def float_pow_combined := [llvmfunc|
  llvm.func @float_pow(%arg0: f32, %arg1: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @pow(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_float_pow   : float_pow_before  ⊑  float_pow_combined := by
  unfold float_pow_before float_pow_combined
  simp_alive_peephole
  sorry
def float_sin_combined := [llvmfunc|
  llvm.func @float_sin(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_sin   : float_sin_before  ⊑  float_sin_combined := by
  unfold float_sin_before float_sin_combined
  simp_alive_peephole
  sorry
def float_sinh_combined := [llvmfunc|
  llvm.func @float_sinh(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sinh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_sinh   : float_sinh_before  ⊑  float_sinh_combined := by
  unfold float_sinh_before float_sinh_combined
  simp_alive_peephole
  sorry
def float_sqrt_combined := [llvmfunc|
  llvm.func @float_sqrt(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_sqrt   : float_sqrt_before  ⊑  float_sqrt_combined := by
  unfold float_sqrt_before float_sqrt_combined
  simp_alive_peephole
  sorry
def float_tan_combined := [llvmfunc|
  llvm.func @float_tan(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tan(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_tan   : float_tan_before  ⊑  float_tan_combined := by
  unfold float_tan_before float_tan_combined
  simp_alive_peephole
  sorry
def float_tanh_combined := [llvmfunc|
  llvm.func @float_tanh(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @tanh(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_tanh   : float_tanh_before  ⊑  float_tanh_combined := by
  unfold float_tanh_before float_tanh_combined
  simp_alive_peephole
  sorry
def float_round_combined := [llvmfunc|
  llvm.func @float_round(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @round(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_float_round   : float_round_before  ⊑  float_round_combined := by
  unfold float_round_before float_round_combined
  simp_alive_peephole
  sorry
def float_powsqrt_combined := [llvmfunc|
  llvm.func @float_powsqrt(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.call @powf(%arg0, %0) {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_float_powsqrt   : float_powsqrt_before  ⊑  float_powsqrt_combined := by
  unfold float_powsqrt_before float_powsqrt_combined
  simp_alive_peephole
  sorry
