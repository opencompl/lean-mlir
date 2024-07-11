import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  maximum
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def constant_fold_maximum_f32_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f32() -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def constant_fold_maximum_f32_inv_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_inv() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def constant_fold_maximum_f32_nan0_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_nan0() -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def constant_fold_maximum_f32_nan1_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_nan1() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def constant_fold_maximum_f32_nan_nan_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_nan_nan() -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.intr.maximum(%0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def constant_fold_maximum_f32_p0_p0_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_p0_p0() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def constant_fold_maximum_f32_p0_n0_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_p0_n0() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def constant_fold_maximum_f32_n0_p0_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_n0_p0() -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def constant_fold_maximum_f32_n0_n0_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_n0_n0() -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def constant_fold_maximum_v4f32_before := [llvmfunc|
  llvm.func @constant_fold_maximum_v4f32() -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 8.000000e+00, 3.000000e+00, 9.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[2.000000e+00, 2.000000e+00, 1.000000e+01, 5.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.intr.maximum(%0, %1)  : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

def constant_fold_maximum_f64_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f64() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.intr.maximum(%0, %1)  : (f64, f64) -> f64
    llvm.return %2 : f64
  }]

def constant_fold_maximum_f64_nan0_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f64_nan0() -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.intr.maximum(%0, %1)  : (f64, f64) -> f64
    llvm.return %2 : f64
  }]

def constant_fold_maximum_f64_nan1_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f64_nan1() -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %2 = llvm.intr.maximum(%0, %1)  : (f64, f64) -> f64
    llvm.return %2 : f64
  }]

def constant_fold_maximum_f64_nan_nan_before := [llvmfunc|
  llvm.func @constant_fold_maximum_f64_nan_nan() -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    %1 = llvm.intr.maximum(%0, %0)  : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

def canonicalize_constant_maximum_f32_before := [llvmfunc|
  llvm.func @canonicalize_constant_maximum_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def maximum_f32_nan_val_before := [llvmfunc|
  llvm.func @maximum_f32_nan_val(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def maximum_f32_val_nan_before := [llvmfunc|
  llvm.func @maximum_f32_val_nan(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def maximum_f32_1_maximum_val_p0_before := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_val_p0(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  : (f32, f32) -> f32
    llvm.return %3 : f32
  }]

def maximum_f32_1_maximum_p0_val_fast_before := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %3 : f32
  }]

def maximum_f32_1_maximum_p0_val_fmf1_before := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val_fmf1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, arcp>} : (f32, f32) -> f32]

    %3 = llvm.intr.maximum(%2, %1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, arcp>} : (f32, f32) -> f32]

    llvm.return %3 : f32
  }]

def maximum_f32_1_maximum_p0_val_fmf2_before := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val_fmf2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, arcp>} : (f32, f32) -> f32]

    %3 = llvm.intr.maximum(%2, %1)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32) -> f32]

    llvm.return %3 : f32
  }]

def maximum_f32_1_maximum_p0_val_fmf3_before := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val_fmf3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32, f32) -> f32]

    %3 = llvm.intr.maximum(%2, %1)  {fastmathFlags = #llvm.fastmath<nnan, ninf, arcp>} : (f32, f32) -> f32]

    llvm.return %3 : f32
  }]

def maximum_f32_p0_maximum_val_n0_before := [llvmfunc|
  llvm.func @maximum_f32_p0_maximum_val_n0(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  : (f32, f32) -> f32
    llvm.return %3 : f32
  }]

def maximum_f32_1_maximum_p0_val_before := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    %3 = llvm.intr.maximum(%2, %1)  : (f32, f32) -> f32
    llvm.return %3 : f32
  }]

def maximum_f32_1_maximum_val_p0_val_v2f32_before := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_val_p0_val_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.intr.maximum(%arg0, %1)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %4 = llvm.intr.maximum(%3, %2)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def maximum4_before := [llvmfunc|
  llvm.func @maximum4(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg2, %arg3)  : (f32, f32) -> f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

def neg_neg_before := [llvmfunc|
  llvm.func @neg_neg(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.intr.maximum(%1, %2)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def unary_neg_neg_before := [llvmfunc|
  llvm.func @unary_neg_neg(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.intr.maximum(%0, %1)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def neg_neg_vec_fmf_before := [llvmfunc|
  llvm.func @neg_neg_vec_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<arcp>} : f32]

    %2 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<afn>} : f32]

    %3 = llvm.intr.maximum(%1, %2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %3 : f32
  }]

def unary_neg_neg_vec_fmf_before := [llvmfunc|
  llvm.func @unary_neg_neg_vec_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<arcp>} : f32]

    %1 = llvm.fneg %arg1  {fastmathFlags = #llvm.fastmath<afn>} : f32]

    %2 = llvm.intr.maximum(%0, %1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %2 : f32
  }]

def neg_neg_extra_use_x_before := [llvmfunc|
  llvm.func @neg_neg_extra_use_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.maximum(%1, %2)  : (f32, f32) -> f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %3 : f32
  }]

def unary_neg_neg_extra_use_x_before := [llvmfunc|
  llvm.func @unary_neg_neg_extra_use_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

def neg_neg_extra_use_y_before := [llvmfunc|
  llvm.func @neg_neg_extra_use_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.maximum(%1, %2)  : (f32, f32) -> f32
    llvm.call @use(%2) : (f32) -> ()
    llvm.return %3 : f32
  }]

def unary_neg_neg_extra_use_y_before := [llvmfunc|
  llvm.func @unary_neg_neg_extra_use_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def neg_neg_extra_use_x_and_y_before := [llvmfunc|
  llvm.func @neg_neg_extra_use_x_and_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.maximum(%1, %2)  : (f32, f32) -> f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.call @use(%2) : (f32) -> ()
    llvm.return %3 : f32
  }]

def unary_neg_neg_extra_use_x_and_y_before := [llvmfunc|
  llvm.func @unary_neg_neg_extra_use_x_and_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def reduce_precision_before := [llvmfunc|
  llvm.func @reduce_precision(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.maximum(%0, %1)  : (f64, f64) -> f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def reduce_precision_fmf_before := [llvmfunc|
  llvm.func @reduce_precision_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.maximum(%0, %1)  {fastmathFlags = #llvm.fastmath<nnan>} : (f64, f64) -> f64]

    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def negated_op_before := [llvmfunc|
  llvm.func @negated_op(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def negated_op_fmf_commute_vec_before := [llvmfunc|
  llvm.func @negated_op_fmf_commute_vec(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fneg %arg0  : vector<2xf64>
    %1 = llvm.intr.maximum(%0, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def negated_op_extra_use_before := [llvmfunc|
  llvm.func @negated_op_extra_use(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def negated_op_extra_use_comm_before := [llvmfunc|
  llvm.func @negated_op_extra_use_comm(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def constant_fold_maximum_f32_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f32() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_maximum_f32   : constant_fold_maximum_f32_before  ⊑  constant_fold_maximum_f32_combined := by
  unfold constant_fold_maximum_f32_before constant_fold_maximum_f32_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f32_inv_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_inv() -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_maximum_f32_inv   : constant_fold_maximum_f32_inv_before  ⊑  constant_fold_maximum_f32_inv_combined := by
  unfold constant_fold_maximum_f32_inv_before constant_fold_maximum_f32_inv_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f32_nan0_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_nan0() -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_maximum_f32_nan0   : constant_fold_maximum_f32_nan0_before  ⊑  constant_fold_maximum_f32_nan0_combined := by
  unfold constant_fold_maximum_f32_nan0_before constant_fold_maximum_f32_nan0_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f32_nan1_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_nan1() -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_maximum_f32_nan1   : constant_fold_maximum_f32_nan1_before  ⊑  constant_fold_maximum_f32_nan1_combined := by
  unfold constant_fold_maximum_f32_nan1_before constant_fold_maximum_f32_nan1_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f32_nan_nan_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_nan_nan() -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_maximum_f32_nan_nan   : constant_fold_maximum_f32_nan_nan_before  ⊑  constant_fold_maximum_f32_nan_nan_combined := by
  unfold constant_fold_maximum_f32_nan_nan_before constant_fold_maximum_f32_nan_nan_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f32_p0_p0_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_p0_p0() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_maximum_f32_p0_p0   : constant_fold_maximum_f32_p0_p0_before  ⊑  constant_fold_maximum_f32_p0_p0_combined := by
  unfold constant_fold_maximum_f32_p0_p0_before constant_fold_maximum_f32_p0_p0_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f32_p0_n0_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_p0_n0() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_maximum_f32_p0_n0   : constant_fold_maximum_f32_p0_n0_before  ⊑  constant_fold_maximum_f32_p0_n0_combined := by
  unfold constant_fold_maximum_f32_p0_n0_before constant_fold_maximum_f32_p0_n0_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f32_n0_p0_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_n0_p0() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_maximum_f32_n0_p0   : constant_fold_maximum_f32_n0_p0_before  ⊑  constant_fold_maximum_f32_n0_p0_combined := by
  unfold constant_fold_maximum_f32_n0_p0_before constant_fold_maximum_f32_n0_p0_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f32_n0_n0_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f32_n0_n0() -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_constant_fold_maximum_f32_n0_n0   : constant_fold_maximum_f32_n0_n0_before  ⊑  constant_fold_maximum_f32_n0_n0_combined := by
  unfold constant_fold_maximum_f32_n0_n0_before constant_fold_maximum_f32_n0_n0_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_v4f32_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_v4f32() -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[2.000000e+00, 8.000000e+00, 1.000000e+01, 9.000000e+00]> : vector<4xf32>) : vector<4xf32>
    llvm.return %0 : vector<4xf32>
  }]

theorem inst_combine_constant_fold_maximum_v4f32   : constant_fold_maximum_v4f32_before  ⊑  constant_fold_maximum_v4f32_combined := by
  unfold constant_fold_maximum_v4f32_before constant_fold_maximum_v4f32_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f64_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f64() -> f64 {
    %0 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_maximum_f64   : constant_fold_maximum_f64_before  ⊑  constant_fold_maximum_f64_combined := by
  unfold constant_fold_maximum_f64_before constant_fold_maximum_f64_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f64_nan0_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f64_nan0() -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_maximum_f64_nan0   : constant_fold_maximum_f64_nan0_before  ⊑  constant_fold_maximum_f64_nan0_combined := by
  unfold constant_fold_maximum_f64_nan0_before constant_fold_maximum_f64_nan0_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f64_nan1_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f64_nan1() -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_maximum_f64_nan1   : constant_fold_maximum_f64_nan1_before  ⊑  constant_fold_maximum_f64_nan1_combined := by
  unfold constant_fold_maximum_f64_nan1_before constant_fold_maximum_f64_nan1_combined
  simp_alive_peephole
  sorry
def constant_fold_maximum_f64_nan_nan_combined := [llvmfunc|
  llvm.func @constant_fold_maximum_f64_nan_nan() -> f64 {
    %0 = llvm.mlir.constant(0x7FF8000000000000 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_constant_fold_maximum_f64_nan_nan   : constant_fold_maximum_f64_nan_nan_before  ⊑  constant_fold_maximum_f64_nan_nan_combined := by
  unfold constant_fold_maximum_f64_nan_nan_before constant_fold_maximum_f64_nan_nan_combined
  simp_alive_peephole
  sorry
def canonicalize_constant_maximum_f32_combined := [llvmfunc|
  llvm.func @canonicalize_constant_maximum_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_canonicalize_constant_maximum_f32   : canonicalize_constant_maximum_f32_before  ⊑  canonicalize_constant_maximum_f32_combined := by
  unfold canonicalize_constant_maximum_f32_before canonicalize_constant_maximum_f32_combined
  simp_alive_peephole
  sorry
def maximum_f32_nan_val_combined := [llvmfunc|
  llvm.func @maximum_f32_nan_val(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_maximum_f32_nan_val   : maximum_f32_nan_val_before  ⊑  maximum_f32_nan_val_combined := by
  unfold maximum_f32_nan_val_before maximum_f32_nan_val_combined
  simp_alive_peephole
  sorry
def maximum_f32_val_nan_combined := [llvmfunc|
  llvm.func @maximum_f32_val_nan(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_maximum_f32_val_nan   : maximum_f32_val_nan_before  ⊑  maximum_f32_val_nan_combined := by
  unfold maximum_f32_val_nan_before maximum_f32_val_nan_combined
  simp_alive_peephole
  sorry
def maximum_f32_1_maximum_val_p0_combined := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_val_p0(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maximum_f32_1_maximum_val_p0   : maximum_f32_1_maximum_val_p0_before  ⊑  maximum_f32_1_maximum_val_p0_combined := by
  unfold maximum_f32_1_maximum_val_p0_before maximum_f32_1_maximum_val_p0_combined
  simp_alive_peephole
  sorry
def maximum_f32_1_maximum_p0_val_fast_combined := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val_fast(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maximum_f32_1_maximum_p0_val_fast   : maximum_f32_1_maximum_p0_val_fast_before  ⊑  maximum_f32_1_maximum_p0_val_fast_combined := by
  unfold maximum_f32_1_maximum_p0_val_fast_before maximum_f32_1_maximum_p0_val_fast_combined
  simp_alive_peephole
  sorry
def maximum_f32_1_maximum_p0_val_fmf1_combined := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val_fmf1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan, arcp>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maximum_f32_1_maximum_p0_val_fmf1   : maximum_f32_1_maximum_p0_val_fmf1_before  ⊑  maximum_f32_1_maximum_p0_val_fmf1_combined := by
  unfold maximum_f32_1_maximum_p0_val_fmf1_before maximum_f32_1_maximum_p0_val_fmf1_combined
  simp_alive_peephole
  sorry
def maximum_f32_1_maximum_p0_val_fmf2_combined := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val_fmf2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maximum_f32_1_maximum_p0_val_fmf2   : maximum_f32_1_maximum_p0_val_fmf2_before  ⊑  maximum_f32_1_maximum_p0_val_fmf2_combined := by
  unfold maximum_f32_1_maximum_p0_val_fmf2_before maximum_f32_1_maximum_p0_val_fmf2_combined
  simp_alive_peephole
  sorry
def maximum_f32_1_maximum_p0_val_fmf3_combined := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val_fmf3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maximum_f32_1_maximum_p0_val_fmf3   : maximum_f32_1_maximum_p0_val_fmf3_before  ⊑  maximum_f32_1_maximum_p0_val_fmf3_combined := by
  unfold maximum_f32_1_maximum_p0_val_fmf3_before maximum_f32_1_maximum_p0_val_fmf3_combined
  simp_alive_peephole
  sorry
def maximum_f32_p0_maximum_val_n0_combined := [llvmfunc|
  llvm.func @maximum_f32_p0_maximum_val_n0(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maximum_f32_p0_maximum_val_n0   : maximum_f32_p0_maximum_val_n0_before  ⊑  maximum_f32_p0_maximum_val_n0_combined := by
  unfold maximum_f32_p0_maximum_val_n0_before maximum_f32_p0_maximum_val_n0_combined
  simp_alive_peephole
  sorry
def maximum_f32_1_maximum_p0_val_combined := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_p0_val(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_maximum_f32_1_maximum_p0_val   : maximum_f32_1_maximum_p0_val_before  ⊑  maximum_f32_1_maximum_p0_val_combined := by
  unfold maximum_f32_1_maximum_p0_val_before maximum_f32_1_maximum_p0_val_combined
  simp_alive_peephole
  sorry
def maximum_f32_1_maximum_val_p0_val_v2f32_combined := [llvmfunc|
  llvm.func @maximum_f32_1_maximum_val_p0_val_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.maximum(%arg0, %0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_maximum_f32_1_maximum_val_p0_val_v2f32   : maximum_f32_1_maximum_val_p0_val_v2f32_before  ⊑  maximum_f32_1_maximum_val_p0_val_v2f32_combined := by
  unfold maximum_f32_1_maximum_val_p0_val_v2f32_before maximum_f32_1_maximum_val_p0_val_v2f32_combined
  simp_alive_peephole
  sorry
def maximum4_combined := [llvmfunc|
  llvm.func @maximum4(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.maximum(%arg2, %arg3)  : (f32, f32) -> f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_maximum4   : maximum4_before  ⊑  maximum4_combined := by
  unfold maximum4_before maximum4_combined
  simp_alive_peephole
  sorry
def neg_neg_combined := [llvmfunc|
  llvm.func @neg_neg(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_neg_neg   : neg_neg_before  ⊑  neg_neg_combined := by
  unfold neg_neg_before neg_neg_combined
  simp_alive_peephole
  sorry
def unary_neg_neg_combined := [llvmfunc|
  llvm.func @unary_neg_neg(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.minimum(%arg0, %arg1)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_unary_neg_neg   : unary_neg_neg_before  ⊑  unary_neg_neg_combined := by
  unfold unary_neg_neg_before unary_neg_neg_combined
  simp_alive_peephole
  sorry
def neg_neg_vec_fmf_combined := [llvmfunc|
  llvm.func @neg_neg_vec_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_neg_neg_vec_fmf   : neg_neg_vec_fmf_before  ⊑  neg_neg_vec_fmf_combined := by
  unfold neg_neg_vec_fmf_before neg_neg_vec_fmf_combined
  simp_alive_peephole
  sorry
def unary_neg_neg_vec_fmf_combined := [llvmfunc|
  llvm.func @unary_neg_neg_vec_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minimum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_unary_neg_neg_vec_fmf   : unary_neg_neg_vec_fmf_before  ⊑  unary_neg_neg_vec_fmf_combined := by
  unfold unary_neg_neg_vec_fmf_before unary_neg_neg_vec_fmf_combined
  simp_alive_peephole
  sorry
def neg_neg_extra_use_x_combined := [llvmfunc|
  llvm.func @neg_neg_extra_use_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fneg %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_neg_neg_extra_use_x   : neg_neg_extra_use_x_before  ⊑  neg_neg_extra_use_x_combined := by
  unfold neg_neg_extra_use_x_before neg_neg_extra_use_x_combined
  simp_alive_peephole
  sorry
def unary_neg_neg_extra_use_x_combined := [llvmfunc|
  llvm.func @unary_neg_neg_extra_use_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fneg %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_unary_neg_neg_extra_use_x   : unary_neg_neg_extra_use_x_before  ⊑  unary_neg_neg_extra_use_x_combined := by
  unfold unary_neg_neg_extra_use_x_before unary_neg_neg_extra_use_x_combined
  simp_alive_peephole
  sorry
def neg_neg_extra_use_y_combined := [llvmfunc|
  llvm.func @neg_neg_extra_use_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg1  : f32
    %1 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fneg %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_neg_neg_extra_use_y   : neg_neg_extra_use_y_before  ⊑  neg_neg_extra_use_y_combined := by
  unfold neg_neg_extra_use_y_before neg_neg_extra_use_y_combined
  simp_alive_peephole
  sorry
def unary_neg_neg_extra_use_y_combined := [llvmfunc|
  llvm.func @unary_neg_neg_extra_use_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg1  : f32
    %1 = llvm.intr.minimum(%arg0, %arg1)  : (f32, f32) -> f32
    %2 = llvm.fneg %1  : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_unary_neg_neg_extra_use_y   : unary_neg_neg_extra_use_y_before  ⊑  unary_neg_neg_extra_use_y_combined := by
  unfold unary_neg_neg_extra_use_y_before unary_neg_neg_extra_use_y_combined
  simp_alive_peephole
  sorry
def neg_neg_extra_use_x_and_y_combined := [llvmfunc|
  llvm.func @neg_neg_extra_use_x_and_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_neg_neg_extra_use_x_and_y   : neg_neg_extra_use_x_and_y_before  ⊑  neg_neg_extra_use_x_and_y_combined := by
  unfold neg_neg_extra_use_x_and_y_before neg_neg_extra_use_x_and_y_combined
  simp_alive_peephole
  sorry
def unary_neg_neg_extra_use_x_and_y_combined := [llvmfunc|
  llvm.func @unary_neg_neg_extra_use_x_and_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.maximum(%0, %1)  : (f32, f32) -> f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_unary_neg_neg_extra_use_x_and_y   : unary_neg_neg_extra_use_x_and_y_before  ⊑  unary_neg_neg_extra_use_x_and_y_combined := by
  unfold unary_neg_neg_extra_use_x_and_y_before unary_neg_neg_extra_use_x_and_y_combined
  simp_alive_peephole
  sorry
def reduce_precision_combined := [llvmfunc|
  llvm.func @reduce_precision(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.maximum(%arg0, %arg1)  : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_reduce_precision   : reduce_precision_before  ⊑  reduce_precision_combined := by
  unfold reduce_precision_before reduce_precision_combined
  simp_alive_peephole
  sorry
def reduce_precision_fmf_combined := [llvmfunc|
  llvm.func @reduce_precision_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.maximum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_reduce_precision_fmf   : reduce_precision_fmf_before  ⊑  reduce_precision_fmf_combined := by
  unfold reduce_precision_fmf_before reduce_precision_fmf_combined
  simp_alive_peephole
  sorry
def negated_op_combined := [llvmfunc|
  llvm.func @negated_op(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_negated_op   : negated_op_before  ⊑  negated_op_combined := by
  unfold negated_op_before negated_op_combined
  simp_alive_peephole
  sorry
def negated_op_fmf_commute_vec_combined := [llvmfunc|
  llvm.func @negated_op_fmf_commute_vec(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (vector<2xf64>) -> vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_negated_op_fmf_commute_vec   : negated_op_fmf_commute_vec_before  ⊑  negated_op_fmf_commute_vec_combined := by
  unfold negated_op_fmf_commute_vec_before negated_op_fmf_commute_vec_combined
  simp_alive_peephole
  sorry
def negated_op_extra_use_combined := [llvmfunc|
  llvm.func @negated_op_extra_use(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.maximum(%0, %arg0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_negated_op_extra_use   : negated_op_extra_use_before  ⊑  negated_op_extra_use_combined := by
  unfold negated_op_extra_use_before negated_op_extra_use_combined
  simp_alive_peephole
  sorry
def negated_op_extra_use_comm_combined := [llvmfunc|
  llvm.func @negated_op_extra_use_comm(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.maximum(%arg0, %0)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_negated_op_extra_use_comm   : negated_op_extra_use_comm_before  ⊑  negated_op_extra_use_comm_combined := by
  unfold negated_op_extra_use_comm_before negated_op_extra_use_comm_combined
  simp_alive_peephole
  sorry
