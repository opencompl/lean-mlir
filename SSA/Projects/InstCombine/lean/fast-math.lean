import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fast-math
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fold_before := [llvmfunc|
  llvm.func @fold(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def notfold_before := [llvmfunc|
  llvm.func @notfold(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %2, %1  : f32
    llvm.return %3 : f32
  }]

def fold2_before := [llvmfunc|
  llvm.func @fold2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def fold3_before := [llvmfunc|
  llvm.func @fold3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %2 : f64
  }]

def fold3_reassoc_nsz_before := [llvmfunc|
  llvm.func @fold3_reassoc_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64]

    %2 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fold3_reassoc_before := [llvmfunc|
  llvm.func @fold3_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %2 = llvm.fadd %arg0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fold4_before := [llvmfunc|
  llvm.func @fold4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fsub %1, %arg1  : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def fold4_reassoc_nsz_before := [llvmfunc|
  llvm.func @fold4_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fsub %1, %arg1  : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %4 : f32
  }]

def fold4_reassoc_before := [llvmfunc|
  llvm.func @fold4_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fsub %1, %arg1  : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %4 : f32
  }]

def fold5_before := [llvmfunc|
  llvm.func @fold5(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def fold5_reassoc_nsz_before := [llvmfunc|
  llvm.func @fold5_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fold5_reassoc_before := [llvmfunc|
  llvm.func @fold5_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fold6_before := [llvmfunc|
  llvm.func @fold6(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fold6_reassoc_nsz_before := [llvmfunc|
  llvm.func @fold6_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fold6_reassoc_before := [llvmfunc|
  llvm.func @fold6_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fold7_before := [llvmfunc|
  llvm.func @fold7(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def fold7_reassoc_nsz_before := [llvmfunc|
  llvm.func @fold7_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fold7_reassoc_before := [llvmfunc|
  llvm.func @fold7_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fold8_before := [llvmfunc|
  llvm.func @fold8(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def fold8_reassoc_nsz_before := [llvmfunc|
  llvm.func @fold8_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %1 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fold8_reassoc_before := [llvmfunc|
  llvm.func @fold8_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %1 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fsub_fadd_common_op_fneg_before := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %1 : f32
  }]

def fsub_fadd_common_op_fneg_reassoc_nsz_before := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %1 : f32
  }]

def fsub_fadd_common_op_fneg_vec_before := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg0, %arg1  : vector<2xf32>
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def fsub_fadd_common_op_fneg_commute_before := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg_commute(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg0  : f32
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %1 : f32
  }]

def fsub_fadd_common_op_fneg_commute_vec_before := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg_commute_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg1, %arg0  : vector<2xf32>
    %1 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def fsub_fsub_common_op_fneg_before := [llvmfunc|
  llvm.func @fsub_fsub_common_op_fneg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg0  : f32
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %1 : f32
  }]

def fsub_fsub_common_op_fneg_vec_before := [llvmfunc|
  llvm.func @fsub_fsub_common_op_fneg_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fsub %arg1, %arg0  : vector<2xf32>
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def fold9_reassoc_before := [llvmfunc|
  llvm.func @fold9_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %1 : f32
  }]

def fold10_before := [llvmfunc|
  llvm.func @fold10(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def fold10_reassoc_nsz_before := [llvmfunc|
  llvm.func @fold10_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %4 : f32
  }]

def fold10_reassoc_before := [llvmfunc|
  llvm.func @fold10_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %2 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %3 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %4 : f32
  }]

def fail1_before := [llvmfunc|
  llvm.func @fail1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def fail2_before := [llvmfunc|
  llvm.func @fail2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %2 : f64
  }]

def fsub_op0_fmul_const_before := [llvmfunc|
  llvm.func @fsub_op0_fmul_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fsub_op0_fmul_const_vec_before := [llvmfunc|
  llvm.func @fsub_op0_fmul_const_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[7.000000e+00, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  : vector<2xf32>
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fsub_op1_fmul_const_before := [llvmfunc|
  llvm.func @fsub_op1_fmul_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fsub %arg0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fsub_op1_fmul_const_vec_before := [llvmfunc|
  llvm.func @fsub_op1_fmul_const_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[7.000000e+00, 0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  : vector<2xf32>
    %2 = llvm.fsub %arg0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fsub_op0_fmul_const_wrong_FMF_before := [llvmfunc|
  llvm.func @fsub_op0_fmul_const_wrong_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fold16_before := [llvmfunc|
  llvm.func @fold16(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %1 = llvm.fadd %arg0, %arg1  : f32
    %2 = llvm.fsub %arg0, %arg1  : f32
    %3 = llvm.select %0, %1, %2 : i1, f32
    llvm.return %3 : f32
  }]

def fneg1_before := [llvmfunc|
  llvm.func @fneg1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %4 = llvm.fmul %2, %3  : f32
    llvm.return %4 : f32
  }]

def fneg2_before := [llvmfunc|
  llvm.func @fneg2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %1 : f32
  }]

def fneg2_vec_poison_before := [llvmfunc|
  llvm.func @fneg2_vec_poison(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %6, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>]

    llvm.return %7 : vector<2xf32>
  }]

def fdiv1_before := [llvmfunc|
  llvm.func @fdiv1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fdiv %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def fdiv2_before := [llvmfunc|
  llvm.func @fdiv2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fdiv %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def fdiv2_vec_before := [llvmfunc|
  llvm.func @fdiv2_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[6.000000e+00, 9.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<[2.000000e+00, 3.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fmul %arg0, %0  : vector<2xf32>
    %3 = llvm.fdiv %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    llvm.return %3 : vector<2xf32>
  }]

def fdiv3_before := [llvmfunc|
  llvm.func @fdiv3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.40282347E+38 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fdiv %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def fdiv4_before := [llvmfunc|
  llvm.func @fdiv4(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.40282347E+38 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e-01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fdiv %2, %1  : f32
    llvm.return %3 : f32
  }]

def sqrt_intrinsic_arg_squared_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_arg_squared(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_intrinsic_three_args1_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args1(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def sqrt_intrinsic_three_args2_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def sqrt_intrinsic_three_args3_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def sqrt_intrinsic_three_args4_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args4(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def sqrt_intrinsic_three_args5_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args5(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def sqrt_intrinsic_three_args6_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args6(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fmul %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def sqrt_intrinsic_not_so_fast_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_not_so_fast(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  : f64
    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def sqrt_intrinsic_arg_4th_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_arg_4th(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %2 : f64
  }]

def sqrt_intrinsic_arg_5th_before := [llvmfunc|
  llvm.func @sqrt_intrinsic_arg_5th(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.intr.sqrt(%2)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %3 : f64
  }]

def sqrt_call_squared_f32_before := [llvmfunc|
  llvm.func @sqrt_call_squared_f32(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.call @sqrtf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def sqrt_call_squared_f64_before := [llvmfunc|
  llvm.func @sqrt_call_squared_f64(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def sqrt_call_squared_f128_before := [llvmfunc|
  llvm.func @sqrt_call_squared_f128(%arg0: f128) -> f128 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f128]

    %1 = llvm.call @sqrtl(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128]

    llvm.return %1 : f128
  }]

def max1_before := [llvmfunc|
  llvm.func @max1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmax(%0, %1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def fmax_no_fmf_before := [llvmfunc|
  llvm.func @fmax_no_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @fmaxf(%arg0, %arg1) : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

def max2_before := [llvmfunc|
  llvm.func @max2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @fmaxf(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32) -> f32]

    llvm.return %0 : f32
  }]

def max3_before := [llvmfunc|
  llvm.func @max3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @fmax(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %0 : f64
  }]

def max4_before := [llvmfunc|
  llvm.func @max4(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @fmaxl(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<nnan>} : (f128, f128) -> f128]

    llvm.return %0 : f128
  }]

def min1_before := [llvmfunc|
  llvm.func @min1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmin(%0, %1) {fastmathFlags = #llvm.fastmath<nnan>} : (f64, f64) -> f64]

    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def fmin_no_fmf_before := [llvmfunc|
  llvm.func @fmin_no_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @fminf(%arg0, %arg1) : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

def min2_before := [llvmfunc|
  llvm.func @min2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.call @fminf(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %0 : f32
  }]

def min3_before := [llvmfunc|
  llvm.func @min3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.call @fmin(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<nnan>} : (f64, f64) -> f64]

    llvm.return %0 : f64
  }]

def min4_before := [llvmfunc|
  llvm.func @min4(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.call @fminl(%arg0, %arg1) {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128]

    llvm.return %0 : f128
  }]

def test55_before := [llvmfunc|
  llvm.func @test55(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.cond_br %arg0, ^bb2(%0 : f32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : f32)
  ^bb2(%2: f32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.fadd %2, %1  : f32
    llvm.return %3 : f32
  }]

def fold_combined := [llvmfunc|
  llvm.func @fold(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.760000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold   : fold_before  ⊑  fold_combined := by
  unfold fold_before fold_combined
  simp_alive_peephole
  sorry
def notfold_combined := [llvmfunc|
  llvm.func @notfold(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.200000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.300000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fmul %2, %1  : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_notfold   : notfold_before  ⊑  notfold_combined := by
  unfold notfold_before notfold_combined
  simp_alive_peephole
  sorry
def fold2_combined := [llvmfunc|
  llvm.func @fold2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.760000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold2   : fold2_before  ⊑  fold2_combined := by
  unfold fold2_before fold2_combined
  simp_alive_peephole
  sorry
def fold3_combined := [llvmfunc|
  llvm.func @fold3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(6.000000e+00 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fold3   : fold3_before  ⊑  fold3_combined := by
  unfold fold3_before fold3_combined
  simp_alive_peephole
  sorry
def fold3_reassoc_nsz_combined := [llvmfunc|
  llvm.func @fold3_reassoc_nsz(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(6.000000e+00 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fold3_reassoc_nsz   : fold3_reassoc_nsz_before  ⊑  fold3_reassoc_nsz_combined := by
  unfold fold3_reassoc_nsz_before fold3_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def fold3_reassoc_combined := [llvmfunc|
  llvm.func @fold3_reassoc(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fold3_reassoc   : fold3_reassoc_before  ⊑  fold3_reassoc_combined := by
  unfold fold3_reassoc_before fold3_reassoc_combined
  simp_alive_peephole
  sorry
def fold4_combined := [llvmfunc|
  llvm.func @fold4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fold4   : fold4_before  ⊑  fold4_combined := by
  unfold fold4_before fold4_combined
  simp_alive_peephole
  sorry
def fold4_reassoc_nsz_combined := [llvmfunc|
  llvm.func @fold4_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fold4_reassoc_nsz   : fold4_reassoc_nsz_before  ⊑  fold4_reassoc_nsz_combined := by
  unfold fold4_reassoc_nsz_before fold4_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def fold4_reassoc_combined := [llvmfunc|
  llvm.func @fold4_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fsub %1, %arg1  : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fold4_reassoc   : fold4_reassoc_before  ⊑  fold4_reassoc_combined := by
  unfold fold4_reassoc_before fold4_reassoc_combined
  simp_alive_peephole
  sorry
def fold5_combined := [llvmfunc|
  llvm.func @fold5(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold5   : fold5_before  ⊑  fold5_combined := by
  unfold fold5_before fold5_combined
  simp_alive_peephole
  sorry
def fold5_reassoc_nsz_combined := [llvmfunc|
  llvm.func @fold5_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold5_reassoc_nsz   : fold5_reassoc_nsz_before  ⊑  fold5_reassoc_nsz_combined := by
  unfold fold5_reassoc_nsz_before fold5_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def fold5_reassoc_combined := [llvmfunc|
  llvm.func @fold5_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg0, %0  : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fold5_reassoc   : fold5_reassoc_before  ⊑  fold5_reassoc_combined := by
  unfold fold5_reassoc_before fold5_reassoc_combined
  simp_alive_peephole
  sorry
def fold6_combined := [llvmfunc|
  llvm.func @fold6(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold6   : fold6_before  ⊑  fold6_combined := by
  unfold fold6_before fold6_combined
  simp_alive_peephole
  sorry
def fold6_reassoc_nsz_combined := [llvmfunc|
  llvm.func @fold6_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold6_reassoc_nsz   : fold6_reassoc_nsz_before  ⊑  fold6_reassoc_nsz_combined := by
  unfold fold6_reassoc_nsz_before fold6_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def fold6_reassoc_combined := [llvmfunc|
  llvm.func @fold6_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %1 = llvm.fadd %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fold6_reassoc   : fold6_reassoc_before  ⊑  fold6_reassoc_combined := by
  unfold fold6_reassoc_before fold6_reassoc_combined
  simp_alive_peephole
  sorry
def fold7_combined := [llvmfunc|
  llvm.func @fold7(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold7   : fold7_before  ⊑  fold7_combined := by
  unfold fold7_before fold7_combined
  simp_alive_peephole
  sorry
def fold7_reassoc_nsz_combined := [llvmfunc|
  llvm.func @fold7_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold7_reassoc_nsz   : fold7_reassoc_nsz_before  ⊑  fold7_reassoc_nsz_combined := by
  unfold fold7_reassoc_nsz_before fold7_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def fold7_reassoc_combined := [llvmfunc|
  llvm.func @fold7_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fold7_reassoc   : fold7_reassoc_before  ⊑  fold7_reassoc_combined := by
  unfold fold7_reassoc_before fold7_reassoc_combined
  simp_alive_peephole
  sorry
def fold8_combined := [llvmfunc|
  llvm.func @fold8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold8   : fold8_before  ⊑  fold8_combined := by
  unfold fold8_before fold8_combined
  simp_alive_peephole
  sorry
def fold8_reassoc_nsz_combined := [llvmfunc|
  llvm.func @fold8_reassoc_nsz(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold8_reassoc_nsz   : fold8_reassoc_nsz_before  ⊑  fold8_reassoc_nsz_combined := by
  unfold fold8_reassoc_nsz_before fold8_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def fold8_reassoc_combined := [llvmfunc|
  llvm.func @fold8_reassoc(%arg0: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %1 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fold8_reassoc   : fold8_reassoc_before  ⊑  fold8_reassoc_combined := by
  unfold fold8_reassoc_before fold8_reassoc_combined
  simp_alive_peephole
  sorry
def fsub_fadd_common_op_fneg_combined := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fsub_fadd_common_op_fneg   : fsub_fadd_common_op_fneg_before  ⊑  fsub_fadd_common_op_fneg_combined := by
  unfold fsub_fadd_common_op_fneg_before fsub_fadd_common_op_fneg_combined
  simp_alive_peephole
  sorry
def fsub_fadd_common_op_fneg_reassoc_nsz_combined := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fsub_fadd_common_op_fneg_reassoc_nsz   : fsub_fadd_common_op_fneg_reassoc_nsz_before  ⊑  fsub_fadd_common_op_fneg_reassoc_nsz_combined := by
  unfold fsub_fadd_common_op_fneg_reassoc_nsz_before fsub_fadd_common_op_fneg_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def fsub_fadd_common_op_fneg_vec_combined := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fsub_fadd_common_op_fneg_vec   : fsub_fadd_common_op_fneg_vec_before  ⊑  fsub_fadd_common_op_fneg_vec_combined := by
  unfold fsub_fadd_common_op_fneg_vec_before fsub_fadd_common_op_fneg_vec_combined
  simp_alive_peephole
  sorry
def fsub_fadd_common_op_fneg_commute_combined := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg_commute(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fsub_fadd_common_op_fneg_commute   : fsub_fadd_common_op_fneg_commute_before  ⊑  fsub_fadd_common_op_fneg_commute_combined := by
  unfold fsub_fadd_common_op_fneg_commute_before fsub_fadd_common_op_fneg_commute_combined
  simp_alive_peephole
  sorry
def fsub_fadd_common_op_fneg_commute_vec_combined := [llvmfunc|
  llvm.func @fsub_fadd_common_op_fneg_commute_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fsub_fadd_common_op_fneg_commute_vec   : fsub_fadd_common_op_fneg_commute_vec_before  ⊑  fsub_fadd_common_op_fneg_commute_vec_combined := by
  unfold fsub_fadd_common_op_fneg_commute_vec_before fsub_fadd_common_op_fneg_commute_vec_combined
  simp_alive_peephole
  sorry
def fsub_fsub_common_op_fneg_combined := [llvmfunc|
  llvm.func @fsub_fsub_common_op_fneg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fsub_fsub_common_op_fneg   : fsub_fsub_common_op_fneg_before  ⊑  fsub_fsub_common_op_fneg_combined := by
  unfold fsub_fsub_common_op_fneg_before fsub_fsub_common_op_fneg_combined
  simp_alive_peephole
  sorry
def fsub_fsub_common_op_fneg_vec_combined := [llvmfunc|
  llvm.func @fsub_fsub_common_op_fneg_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fsub_fsub_common_op_fneg_vec   : fsub_fsub_common_op_fneg_vec_before  ⊑  fsub_fsub_common_op_fneg_vec_combined := by
  unfold fsub_fsub_common_op_fneg_vec_before fsub_fsub_common_op_fneg_vec_combined
  simp_alive_peephole
  sorry
def fold9_reassoc_combined := [llvmfunc|
  llvm.func @fold9_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fold9_reassoc   : fold9_reassoc_before  ⊑  fold9_reassoc_combined := by
  unfold fold9_reassoc_before fold9_reassoc_combined
  simp_alive_peephole
  sorry
def fold10_combined := [llvmfunc|
  llvm.func @fold10(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fold10   : fold10_before  ⊑  fold10_combined := by
  unfold fold10_before fold10_combined
  simp_alive_peephole
  sorry
def fold10_reassoc_nsz_combined := [llvmfunc|
  llvm.func @fold10_reassoc_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fold10_reassoc_nsz   : fold10_reassoc_nsz_before  ⊑  fold10_reassoc_nsz_combined := by
  unfold fold10_reassoc_nsz_before fold10_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def fold10_reassoc_combined := [llvmfunc|
  llvm.func @fold10_reassoc(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-3.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %3 = llvm.fadd %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fold10_reassoc   : fold10_reassoc_before  ⊑  fold10_reassoc_combined := by
  unfold fold10_reassoc_before fold10_reassoc_combined
  simp_alive_peephole
  sorry
def fail1_combined := [llvmfunc|
  llvm.func @fail1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-3.000000e+00 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fail1   : fail1_before  ⊑  fail1_combined := by
  unfold fail1_before fail1_combined
  simp_alive_peephole
  sorry
def fail2_combined := [llvmfunc|
  llvm.func @fail2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fadd %arg1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fail2   : fail2_before  ⊑  fail2_combined := by
  unfold fail2_before fail2_combined
  simp_alive_peephole
  sorry
def fsub_op0_fmul_const_combined := [llvmfunc|
  llvm.func @fsub_op0_fmul_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fsub_op0_fmul_const   : fsub_op0_fmul_const_before  ⊑  fsub_op0_fmul_const_combined := by
  unfold fsub_op0_fmul_const_before fsub_op0_fmul_const_combined
  simp_alive_peephole
  sorry
def fsub_op0_fmul_const_vec_combined := [llvmfunc|
  llvm.func @fsub_op0_fmul_const_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[6.000000e+00, -4.300000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fsub_op0_fmul_const_vec   : fsub_op0_fmul_const_vec_before  ⊑  fsub_op0_fmul_const_vec_combined := by
  unfold fsub_op0_fmul_const_vec_before fsub_op0_fmul_const_vec_combined
  simp_alive_peephole
  sorry
def fsub_op1_fmul_const_combined := [llvmfunc|
  llvm.func @fsub_op1_fmul_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-6.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fsub_op1_fmul_const   : fsub_op1_fmul_const_before  ⊑  fsub_op1_fmul_const_combined := by
  unfold fsub_op1_fmul_const_before fsub_op1_fmul_const_combined
  simp_alive_peephole
  sorry
def fsub_op1_fmul_const_vec_combined := [llvmfunc|
  llvm.func @fsub_op1_fmul_const_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[-6.000000e+00, 1.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fsub_op1_fmul_const_vec   : fsub_op1_fmul_const_vec_before  ⊑  fsub_op1_fmul_const_vec_combined := by
  unfold fsub_op1_fmul_const_vec_before fsub_op1_fmul_const_vec_combined
  simp_alive_peephole
  sorry
def fsub_op0_fmul_const_wrong_FMF_combined := [llvmfunc|
  llvm.func @fsub_op0_fmul_const_wrong_FMF(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    %2 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_op0_fmul_const_wrong_FMF   : fsub_op0_fmul_const_wrong_FMF_before  ⊑  fsub_op0_fmul_const_wrong_FMF_combined := by
  unfold fsub_op0_fmul_const_wrong_FMF_before fsub_op0_fmul_const_wrong_FMF_combined
  simp_alive_peephole
  sorry
def fold16_combined := [llvmfunc|
  llvm.func @fold16(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.select %0, %arg1, %1 : i1, f32
    %3 = llvm.fadd %2, %arg0  : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fold16   : fold16_before  ⊑  fold16_combined := by
  unfold fold16_before fold16_combined
  simp_alive_peephole
  sorry
def fneg1_combined := [llvmfunc|
  llvm.func @fneg1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fneg1   : fneg1_before  ⊑  fneg1_combined := by
  unfold fneg1_before fneg1_combined
  simp_alive_peephole
  sorry
def fneg2_combined := [llvmfunc|
  llvm.func @fneg2(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fneg2   : fneg2_before  ⊑  fneg2_combined := by
  unfold fneg2_before fneg2_combined
  simp_alive_peephole
  sorry
def fneg2_vec_poison_combined := [llvmfunc|
  llvm.func @fneg2_vec_poison(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fneg2_vec_poison   : fneg2_vec_poison_before  ⊑  fneg2_vec_poison_combined := by
  unfold fneg2_vec_poison_before fneg2_vec_poison_combined
  simp_alive_peephole
  sorry
def fdiv1_combined := [llvmfunc|
  llvm.func @fdiv1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.362318844 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fdiv1   : fdiv1_before  ⊑  fdiv1_combined := by
  unfold fdiv1_before fdiv1_combined
  simp_alive_peephole
  sorry
def fdiv2_combined := [llvmfunc|
  llvm.func @fdiv2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.521739185 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fdiv2   : fdiv2_before  ⊑  fdiv2_combined := by
  unfold fdiv2_before fdiv2_combined
  simp_alive_peephole
  sorry
def fdiv2_vec_combined := [llvmfunc|
  llvm.func @fdiv2_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<3.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fdiv2_vec   : fdiv2_vec_before  ⊑  fdiv2_vec_combined := by
  unfold fdiv2_vec_before fdiv2_vec_combined
  simp_alive_peephole
  sorry
def fdiv3_combined := [llvmfunc|
  llvm.func @fdiv3(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.434782624 : f32) : f32
    %1 = llvm.mlir.constant(3.40282347E+38 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.fdiv %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fdiv3   : fdiv3_before  ⊑  fdiv3_combined := by
  unfold fdiv3_before fdiv3_combined
  simp_alive_peephole
  sorry
def fdiv4_combined := [llvmfunc|
  llvm.func @fdiv4(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.40282347E+38 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e-01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fdiv %2, %1  : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fdiv4   : fdiv4_before  ⊑  fdiv4_combined := by
  unfold fdiv4_before fdiv4_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_arg_squared_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_arg_squared(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_sqrt_intrinsic_arg_squared   : sqrt_intrinsic_arg_squared_before  ⊑  sqrt_intrinsic_arg_squared_combined := by
  unfold sqrt_intrinsic_arg_squared_before sqrt_intrinsic_arg_squared_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_three_args1_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args1(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_intrinsic_three_args1   : sqrt_intrinsic_three_args1_before  ⊑  sqrt_intrinsic_three_args1_combined := by
  unfold sqrt_intrinsic_three_args1_before sqrt_intrinsic_three_args1_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_three_args2_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_intrinsic_three_args2   : sqrt_intrinsic_three_args2_before  ⊑  sqrt_intrinsic_three_args2_combined := by
  unfold sqrt_intrinsic_three_args2_before sqrt_intrinsic_three_args2_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_three_args3_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_intrinsic_three_args3   : sqrt_intrinsic_three_args3_before  ⊑  sqrt_intrinsic_three_args3_combined := by
  unfold sqrt_intrinsic_three_args3_before sqrt_intrinsic_three_args3_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_three_args4_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args4(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_intrinsic_three_args4   : sqrt_intrinsic_three_args4_before  ⊑  sqrt_intrinsic_three_args4_combined := by
  unfold sqrt_intrinsic_three_args4_before sqrt_intrinsic_three_args4_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_three_args5_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args5(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_intrinsic_three_args5   : sqrt_intrinsic_three_args5_before  ⊑  sqrt_intrinsic_three_args5_combined := by
  unfold sqrt_intrinsic_three_args5_before sqrt_intrinsic_three_args5_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_three_args6_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_three_args6(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_intrinsic_three_args6   : sqrt_intrinsic_three_args6_before  ⊑  sqrt_intrinsic_three_args6_combined := by
  unfold sqrt_intrinsic_three_args6_before sqrt_intrinsic_three_args6_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_not_so_fast_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_not_so_fast(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  : f64
    %1 = llvm.fmul %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.intr.sqrt(%1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_intrinsic_not_so_fast   : sqrt_intrinsic_not_so_fast_before  ⊑  sqrt_intrinsic_not_so_fast_combined := by
  unfold sqrt_intrinsic_not_so_fast_before sqrt_intrinsic_not_so_fast_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_arg_4th_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_arg_4th(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_sqrt_intrinsic_arg_4th   : sqrt_intrinsic_arg_4th_before  ⊑  sqrt_intrinsic_arg_4th_combined := by
  unfold sqrt_intrinsic_arg_4th_before sqrt_intrinsic_arg_4th_combined
  simp_alive_peephole
  sorry
def sqrt_intrinsic_arg_5th_combined := [llvmfunc|
  llvm.func @sqrt_intrinsic_arg_5th(%arg0: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_intrinsic_arg_5th   : sqrt_intrinsic_arg_5th_before  ⊑  sqrt_intrinsic_arg_5th_combined := by
  unfold sqrt_intrinsic_arg_5th_before sqrt_intrinsic_arg_5th_combined
  simp_alive_peephole
  sorry
def sqrt_call_squared_f32_combined := [llvmfunc|
  llvm.func @sqrt_call_squared_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_sqrt_call_squared_f32   : sqrt_call_squared_f32_before  ⊑  sqrt_call_squared_f32_combined := by
  unfold sqrt_call_squared_f32_before sqrt_call_squared_f32_combined
  simp_alive_peephole
  sorry
def sqrt_call_squared_f64_combined := [llvmfunc|
  llvm.func @sqrt_call_squared_f64(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_sqrt_call_squared_f64   : sqrt_call_squared_f64_before  ⊑  sqrt_call_squared_f64_combined := by
  unfold sqrt_call_squared_f64_before sqrt_call_squared_f64_combined
  simp_alive_peephole
  sorry
def sqrt_call_squared_f128_combined := [llvmfunc|
  llvm.func @sqrt_call_squared_f128(%arg0: f128) -> f128 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f128) -> f128
    llvm.return %0 : f128
  }]

theorem inst_combine_sqrt_call_squared_f128   : sqrt_call_squared_f128_before  ⊑  sqrt_call_squared_f128_combined := by
  unfold sqrt_call_squared_f128_before sqrt_call_squared_f128_combined
  simp_alive_peephole
  sorry
def max1_combined := [llvmfunc|
  llvm.func @max1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_max1   : max1_before  ⊑  max1_combined := by
  unfold max1_before max1_combined
  simp_alive_peephole
  sorry
def fmax_no_fmf_combined := [llvmfunc|
  llvm.func @fmax_no_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmax_no_fmf   : fmax_no_fmf_before  ⊑  fmax_no_fmf_combined := by
  unfold fmax_no_fmf_before fmax_no_fmf_combined
  simp_alive_peephole
  sorry
def max2_combined := [llvmfunc|
  llvm.func @max2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_max2   : max2_before  ⊑  max2_combined := by
  unfold max2_before max2_combined
  simp_alive_peephole
  sorry
def max3_combined := [llvmfunc|
  llvm.func @max3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_max3   : max3_before  ⊑  max3_combined := by
  unfold max3_before max3_combined
  simp_alive_peephole
  sorry
def max4_combined := [llvmfunc|
  llvm.func @max4(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f128, f128) -> f128
    llvm.return %0 : f128
  }]

theorem inst_combine_max4   : max4_before  ⊑  max4_combined := by
  unfold max4_before max4_combined
  simp_alive_peephole
  sorry
def min1_combined := [llvmfunc|
  llvm.func @min1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_min1   : min1_before  ⊑  min1_combined := by
  unfold min1_before min1_combined
  simp_alive_peephole
  sorry
def fmin_no_fmf_combined := [llvmfunc|
  llvm.func @fmin_no_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmin_no_fmf   : fmin_no_fmf_before  ⊑  fmin_no_fmf_combined := by
  unfold fmin_no_fmf_before fmin_no_fmf_combined
  simp_alive_peephole
  sorry
def min2_combined := [llvmfunc|
  llvm.func @min2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_min2   : min2_before  ⊑  min2_combined := by
  unfold min2_before min2_combined
  simp_alive_peephole
  sorry
def min3_combined := [llvmfunc|
  llvm.func @min3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64, f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_min3   : min3_before  ⊑  min3_combined := by
  unfold min3_before min3_combined
  simp_alive_peephole
  sorry
def min4_combined := [llvmfunc|
  llvm.func @min4(%arg0: f128, %arg1: f128) -> f128 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f128, f128) -> f128
    llvm.return %0 : f128
  }]

theorem inst_combine_min4   : min4_before  ⊑  min4_combined := by
  unfold min4_before min4_combined
  simp_alive_peephole
  sorry
def test55_combined := [llvmfunc|
  llvm.func @test55(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.cond_br %arg0, ^bb2(%0 : f32), ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.fadd %arg1, %1  : f32
    llvm.br ^bb2(%2 : f32)
  ^bb2(%3: f32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : f32
  }]

theorem inst_combine_test55   : test55_before  ⊑  test55_combined := by
  unfold test55_before test55_combined
  simp_alive_peephole
  sorry
