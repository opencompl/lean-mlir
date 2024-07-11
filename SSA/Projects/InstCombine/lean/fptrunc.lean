import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fptrunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fadd_fpext_op0_before := [llvmfunc|
  llvm.func @fadd_fpext_op0(%arg0: f32, %arg1: f64) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fadd %0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def fsub_fpext_op1_before := [llvmfunc|
  llvm.func @fsub_fpext_op1(%arg0: f16, %arg1: f64) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %2 = llvm.fptrunc %1 : f64 to f16
    llvm.return %2 : f16
  }]

def fdiv_constant_op0_before := [llvmfunc|
  llvm.func @fdiv_constant_op0(%arg0: vector<2xf64>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.210000e+01, -1.000000e-01]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf64>]

    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def fmul_constant_op1_before := [llvmfunc|
  llvm.func @fmul_constant_op1(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<[3.40282347E+38, 5.000000e-01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>]

    %2 = llvm.fptrunc %1 : vector<2xf32> to vector<2xf16>
    llvm.return %2 : vector<2xf16>
  }]

def fptrunc_select_true_val_before := [llvmfunc|
  llvm.func @fptrunc_select_true_val(%arg0: f32, %arg1: f64, %arg2: i1) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def fptrunc_select_false_val_before := [llvmfunc|
  llvm.func @fptrunc_select_false_val(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %1 = llvm.select %arg2, %0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf64>]

    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def fptrunc_select_true_val_extra_use_before := [llvmfunc|
  llvm.func @fptrunc_select_true_val_extra_use(%arg0: f16, %arg1: f32, %arg2: i1) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f32]

    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }]

def fptrunc_select_true_val_extra_use_2_before := [llvmfunc|
  llvm.func @fptrunc_select_true_val_extra_use_2(%arg0: f16, %arg1: f32, %arg2: i1) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f32]

    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }]

def fptrunc_select_true_val_type_mismatch_before := [llvmfunc|
  llvm.func @fptrunc_select_true_val_type_mismatch(%arg0: f16, %arg1: f64, %arg2: i1) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.select %arg2, %arg1, %0 : i1, f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def fptrunc_select_true_val_type_mismatch_fast_before := [llvmfunc|
  llvm.func @fptrunc_select_true_val_type_mismatch_fast(%arg0: f16, %arg1: f64, %arg2: i1) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f64]

    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def ItoFtoF_s54_f64_f32_before := [llvmfunc|
  llvm.func @ItoFtoF_s54_f64_f32(%arg0: vector<2xi54>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi54> to vector<2xf64>
    %1 = llvm.fptrunc %0 : vector<2xf64> to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def ItoFtoF_u24_f32_f16_before := [llvmfunc|
  llvm.func @ItoFtoF_u24_f32_f16(%arg0: i24) -> f16 {
    %0 = llvm.uitofp %arg0 : i24 to f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

def ItoFtoF_s55_f64_f32_before := [llvmfunc|
  llvm.func @ItoFtoF_s55_f64_f32(%arg0: i55) -> f32 {
    %0 = llvm.sitofp %arg0 : i55 to f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def ItoFtoF_u25_f32_f16_before := [llvmfunc|
  llvm.func @ItoFtoF_u25_f32_f16(%arg0: i25) -> f16 {
    %0 = llvm.uitofp %arg0 : i25 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

def fptrunc_to_bfloat_bitcast_to_half_before := [llvmfunc|
  llvm.func @fptrunc_to_bfloat_bitcast_to_half(%arg0: f32) -> f16 {
    %0 = llvm.fptrunc %arg0 : f32 to bf16
    %1 = llvm.bitcast %0 : bf16 to f16
    llvm.return %1 : f16
  }]

def fadd_fpext_op0_combined := [llvmfunc|
  llvm.func @fadd_fpext_op0(%arg0: f32, %arg1: f64) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fadd %0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fadd_fpext_op0   : fadd_fpext_op0_before  ⊑  fadd_fpext_op0_combined := by
  unfold fadd_fpext_op0_before fadd_fpext_op0_combined
  simp_alive_peephole
  sorry
def fsub_fpext_op1_combined := [llvmfunc|
  llvm.func @fsub_fpext_op1(%arg0: f16, %arg1: f64) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.fptrunc %1 : f64 to f16
    llvm.return %2 : f16
  }]

theorem inst_combine_fsub_fpext_op1   : fsub_fpext_op1_before  ⊑  fsub_fpext_op1_combined := by
  unfold fsub_fpext_op1_before fsub_fpext_op1_combined
  simp_alive_peephole
  sorry
def fdiv_constant_op0_combined := [llvmfunc|
  llvm.func @fdiv_constant_op0(%arg0: vector<2xf64>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.210000e+01, -1.000000e-01]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fdiv_constant_op0   : fdiv_constant_op0_before  ⊑  fdiv_constant_op0_combined := by
  unfold fdiv_constant_op0_before fdiv_constant_op0_combined
  simp_alive_peephole
  sorry
def fmul_constant_op1_combined := [llvmfunc|
  llvm.func @fmul_constant_op1(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = llvm.mlir.constant(dense<[3.40282347E+38, 5.000000e-01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<2xf32>
    %2 = llvm.fptrunc %1 : vector<2xf32> to vector<2xf16>
    llvm.return %2 : vector<2xf16>
  }]

theorem inst_combine_fmul_constant_op1   : fmul_constant_op1_before  ⊑  fmul_constant_op1_combined := by
  unfold fmul_constant_op1_before fmul_constant_op1_combined
  simp_alive_peephole
  sorry
def fptrunc_select_true_val_combined := [llvmfunc|
  llvm.func @fptrunc_select_true_val(%arg0: f32, %arg1: f64, %arg2: i1) -> f32 {
    %0 = llvm.fptrunc %arg1 : f64 to f32
    %1 = llvm.select %arg2, %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fptrunc_select_true_val   : fptrunc_select_true_val_before  ⊑  fptrunc_select_true_val_combined := by
  unfold fptrunc_select_true_val_before fptrunc_select_true_val_combined
  simp_alive_peephole
  sorry
def fptrunc_select_false_val_combined := [llvmfunc|
  llvm.func @fptrunc_select_false_val(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.fptrunc %arg1 : vector<2xf64> to vector<2xf32>
    %1 = llvm.select %arg2, %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xi1>, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fptrunc_select_false_val   : fptrunc_select_false_val_before  ⊑  fptrunc_select_false_val_combined := by
  unfold fptrunc_select_false_val_before fptrunc_select_false_val_combined
  simp_alive_peephole
  sorry
def fptrunc_select_true_val_extra_use_combined := [llvmfunc|
  llvm.func @fptrunc_select_true_val_extra_use(%arg0: f16, %arg1: f32, %arg2: i1) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fptrunc %arg1 : f32 to f16
    %2 = llvm.select %arg2, %1, %arg0 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f16
    llvm.return %2 : f16
  }]

theorem inst_combine_fptrunc_select_true_val_extra_use   : fptrunc_select_true_val_extra_use_before  ⊑  fptrunc_select_true_val_extra_use_combined := by
  unfold fptrunc_select_true_val_extra_use_before fptrunc_select_true_val_extra_use_combined
  simp_alive_peephole
  sorry
def fptrunc_select_true_val_extra_use_2_combined := [llvmfunc|
  llvm.func @fptrunc_select_true_val_extra_use_2(%arg0: f16, %arg1: f32, %arg2: i1) -> f16 {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }]

theorem inst_combine_fptrunc_select_true_val_extra_use_2   : fptrunc_select_true_val_extra_use_2_before  ⊑  fptrunc_select_true_val_extra_use_2_combined := by
  unfold fptrunc_select_true_val_extra_use_2_before fptrunc_select_true_val_extra_use_2_combined
  simp_alive_peephole
  sorry
def fptrunc_select_true_val_type_mismatch_combined := [llvmfunc|
  llvm.func @fptrunc_select_true_val_type_mismatch(%arg0: f16, %arg1: f64, %arg2: i1) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.select %arg2, %arg1, %0 : i1, f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fptrunc_select_true_val_type_mismatch   : fptrunc_select_true_val_type_mismatch_before  ⊑  fptrunc_select_true_val_type_mismatch_combined := by
  unfold fptrunc_select_true_val_type_mismatch_before fptrunc_select_true_val_type_mismatch_combined
  simp_alive_peephole
  sorry
def fptrunc_select_true_val_type_mismatch_fast_combined := [llvmfunc|
  llvm.func @fptrunc_select_true_val_type_mismatch_fast(%arg0: f16, %arg1: f64, %arg2: i1) -> f32 {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.select %arg2, %arg1, %0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fptrunc_select_true_val_type_mismatch_fast   : fptrunc_select_true_val_type_mismatch_fast_before  ⊑  fptrunc_select_true_val_type_mismatch_fast_combined := by
  unfold fptrunc_select_true_val_type_mismatch_fast_before fptrunc_select_true_val_type_mismatch_fast_combined
  simp_alive_peephole
  sorry
def ItoFtoF_s54_f64_f32_combined := [llvmfunc|
  llvm.func @ItoFtoF_s54_f64_f32(%arg0: vector<2xi54>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi54> to vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_ItoFtoF_s54_f64_f32   : ItoFtoF_s54_f64_f32_before  ⊑  ItoFtoF_s54_f64_f32_combined := by
  unfold ItoFtoF_s54_f64_f32_before ItoFtoF_s54_f64_f32_combined
  simp_alive_peephole
  sorry
def ItoFtoF_u24_f32_f16_combined := [llvmfunc|
  llvm.func @ItoFtoF_u24_f32_f16(%arg0: i24) -> f16 {
    %0 = llvm.uitofp %arg0 : i24 to f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.uitofp %arg0 : i24 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_ItoFtoF_u24_f32_f16   : ItoFtoF_u24_f32_f16_before  ⊑  ItoFtoF_u24_f32_f16_combined := by
  unfold ItoFtoF_u24_f32_f16_before ItoFtoF_u24_f32_f16_combined
  simp_alive_peephole
  sorry
def ItoFtoF_s55_f64_f32_combined := [llvmfunc|
  llvm.func @ItoFtoF_s55_f64_f32(%arg0: i55) -> f32 {
    %0 = llvm.sitofp %arg0 : i55 to f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_ItoFtoF_s55_f64_f32   : ItoFtoF_s55_f64_f32_before  ⊑  ItoFtoF_s55_f64_f32_combined := by
  unfold ItoFtoF_s55_f64_f32_before ItoFtoF_s55_f64_f32_combined
  simp_alive_peephole
  sorry
def ItoFtoF_u25_f32_f16_combined := [llvmfunc|
  llvm.func @ItoFtoF_u25_f32_f16(%arg0: i25) -> f16 {
    %0 = llvm.uitofp %arg0 : i25 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_ItoFtoF_u25_f32_f16   : ItoFtoF_u25_f32_f16_before  ⊑  ItoFtoF_u25_f32_f16_combined := by
  unfold ItoFtoF_u25_f32_f16_before ItoFtoF_u25_f32_f16_combined
  simp_alive_peephole
  sorry
def fptrunc_to_bfloat_bitcast_to_half_combined := [llvmfunc|
  llvm.func @fptrunc_to_bfloat_bitcast_to_half(%arg0: f32) -> f16 {
    %0 = llvm.fptrunc %arg0 : f32 to bf16
    %1 = llvm.bitcast %0 : bf16 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_fptrunc_to_bfloat_bitcast_to_half   : fptrunc_to_bfloat_bitcast_to_half_before  ⊑  fptrunc_to_bfloat_bitcast_to_half_combined := by
  unfold fptrunc_to_bfloat_bitcast_to_half_before fptrunc_to_bfloat_bitcast_to_half_combined
  simp_alive_peephole
  sorry
