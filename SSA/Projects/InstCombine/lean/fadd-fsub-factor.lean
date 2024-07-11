import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fadd-fsub-factor
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fmul_fadd_before := [llvmfunc|
  llvm.func @fmul_fadd(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fmul_fadd_commute1_vec_before := [llvmfunc|
  llvm.func @fmul_fadd_commute1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg2, %arg0  : vector<2xf32>
    %1 = llvm.fmul %arg2, %arg1  : vector<2xf32>
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fmul_fadd_commute2_vec_before := [llvmfunc|
  llvm.func @fmul_fadd_commute2_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %1 = llvm.fmul %arg2, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fmul_fadd_commute3_before := [llvmfunc|
  llvm.func @fmul_fadd_commute3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fmul %arg2, %arg0  : f64
    %1 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fmul_fadd_not_enough_FMF_before := [llvmfunc|
  llvm.func @fmul_fadd_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fmul_fadd_uses1_before := [llvmfunc|
  llvm.func @fmul_fadd_uses1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fmul_fadd_uses2_before := [llvmfunc|
  llvm.func @fmul_fadd_uses2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg2, %arg1  : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fmul_fadd_uses3_before := [llvmfunc|
  llvm.func @fmul_fadd_uses3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg2, %arg1  : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fmul_fsub_before := [llvmfunc|
  llvm.func @fmul_fsub(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = llvm.fmul %arg0, %arg2  : f16
    %1 = llvm.fmul %arg1, %arg2  : f16
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f16]

    llvm.return %2 : f16
  }]

def fmul_fsub_commute1_vec_before := [llvmfunc|
  llvm.func @fmul_fsub_commute1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg2, %arg0  : vector<2xf32>
    %1 = llvm.fmul %arg1, %arg2  : vector<2xf32>
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fmul_fsub_commute2_vec_before := [llvmfunc|
  llvm.func @fmul_fsub_commute2_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %1 = llvm.fmul %arg2, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fmul_fsub_commute3_before := [llvmfunc|
  llvm.func @fmul_fsub_commute3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fmul %arg2, %arg0  : f64
    %1 = llvm.fmul %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fmul_fsub_not_enough_FMF_before := [llvmfunc|
  llvm.func @fmul_fsub_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %2 : f32
  }]

def fmul_fsub_uses1_before := [llvmfunc|
  llvm.func @fmul_fsub_uses1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fmul_fsub_uses2_before := [llvmfunc|
  llvm.func @fmul_fsub_uses2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg2, %arg1  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fmul_fsub_uses3_before := [llvmfunc|
  llvm.func @fmul_fsub_uses3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fdiv_fadd_before := [llvmfunc|
  llvm.func @fdiv_fadd(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg0, %arg2  : f64
    %1 = llvm.fdiv %arg1, %arg2  : f64
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_fsub_before := [llvmfunc|
  llvm.func @fdiv_fsub(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_fadd_vec_before := [llvmfunc|
  llvm.func @fdiv_fadd_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>]

    %1 = llvm.fdiv %arg1, %arg2  : vector<2xf64>
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fdiv_fsub_vec_before := [llvmfunc|
  llvm.func @fdiv_fsub_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fdiv %arg0, %arg2  : vector<2xf32>
    %1 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fdiv_fadd_commute1_before := [llvmfunc|
  llvm.func @fdiv_fadd_commute1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fdiv %arg2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_fsub_commute2_before := [llvmfunc|
  llvm.func @fdiv_fsub_commute2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_fadd_not_enough_FMF_before := [llvmfunc|
  llvm.func @fdiv_fadd_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fdiv %arg2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_fsub_not_enough_FMF_before := [llvmfunc|
  llvm.func @fdiv_fsub_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fdiv %arg2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_fadd_uses1_before := [llvmfunc|
  llvm.func @fdiv_fadd_uses1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fdiv_fsub_uses2_before := [llvmfunc|
  llvm.func @fdiv_fsub_uses2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fdiv_fsub_uses3_before := [llvmfunc|
  llvm.func @fdiv_fsub_uses3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fdiv_fadd_not_denorm_before := [llvmfunc|
  llvm.func @fdiv_fadd_not_denorm(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.constant(5.87747175E-39 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def fdiv_fadd_denorm_before := [llvmfunc|
  llvm.func @fdiv_fadd_denorm(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.constant(5.87747175E-39 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def fdiv_fsub_denorm_before := [llvmfunc|
  llvm.func @fdiv_fsub_denorm(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.constant(5.87747175E-39 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fsub %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def lerp_commute0_before := [llvmfunc|
  llvm.func @lerp_commute0(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def lerp_commute1_before := [llvmfunc|
  llvm.func @lerp_commute1(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg2  : vector<2xf32>
    %2 = llvm.fmul %1, %arg0  : vector<2xf32>
    %3 = llvm.fmul %arg2, %arg1  : vector<2xf32>
    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    llvm.return %4 : vector<2xf32>
  }]

def lerp_commute2_before := [llvmfunc|
  llvm.func @lerp_commute2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  : f32
    %2 = llvm.fmul %1, %arg0  : f32
    %3 = llvm.fmul %arg1, %arg2  : f32
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %4 : f32
  }]

def lerp_commute3_before := [llvmfunc|
  llvm.func @lerp_commute3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fmul %1, %arg0  : f32
    %3 = llvm.fmul %arg1, %arg2  : f32
    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : f32]

    llvm.return %4 : f32
  }]

def lerp_commute4_before := [llvmfunc|
  llvm.func @lerp_commute4(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.fmul %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %4 : f64
  }]

def lerp_commute5_before := [llvmfunc|
  llvm.func @lerp_commute5(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %2 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.fmul %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %4 : f64
  }]

def lerp_commute6_before := [llvmfunc|
  llvm.func @lerp_commute6(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    %2 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    %3 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    llvm.return %4 : f16
  }]

def lerp_commute7_before := [llvmfunc|
  llvm.func @lerp_commute7(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    %2 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    %3 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<fast>} : f16]

    llvm.return %4 : f16
  }]

def lerp_extra_use1_before := [llvmfunc|
  llvm.func @lerp_extra_use1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def lerp_extra_use2_before := [llvmfunc|
  llvm.func @lerp_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def lerp_extra_use3_before := [llvmfunc|
  llvm.func @lerp_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def fmul_fadd_combined := [llvmfunc|
  llvm.func @fmul_fadd(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fmul_fadd   : fmul_fadd_before  ⊑  fmul_fadd_combined := by
  unfold fmul_fadd_before fmul_fadd_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fmul_fadd   : fmul_fadd_before  ⊑  fmul_fadd_combined := by
  unfold fmul_fadd_before fmul_fadd_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_fmul_fadd   : fmul_fadd_before  ⊑  fmul_fadd_combined := by
  unfold fmul_fadd_before fmul_fadd_combined
  simp_alive_peephole
  sorry
def fmul_fadd_commute1_vec_combined := [llvmfunc|
  llvm.func @fmul_fadd_commute1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fmul_fadd_commute1_vec   : fmul_fadd_commute1_vec_before  ⊑  fmul_fadd_commute1_vec_combined := by
  unfold fmul_fadd_commute1_vec_before fmul_fadd_commute1_vec_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fmul_fadd_commute1_vec   : fmul_fadd_commute1_vec_before  ⊑  fmul_fadd_commute1_vec_combined := by
  unfold fmul_fadd_commute1_vec_before fmul_fadd_commute1_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fmul_fadd_commute1_vec   : fmul_fadd_commute1_vec_before  ⊑  fmul_fadd_commute1_vec_combined := by
  unfold fmul_fadd_commute1_vec_before fmul_fadd_commute1_vec_combined
  simp_alive_peephole
  sorry
def fmul_fadd_commute2_vec_combined := [llvmfunc|
  llvm.func @fmul_fadd_commute2_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fmul_fadd_commute2_vec   : fmul_fadd_commute2_vec_before  ⊑  fmul_fadd_commute2_vec_combined := by
  unfold fmul_fadd_commute2_vec_before fmul_fadd_commute2_vec_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fmul_fadd_commute2_vec   : fmul_fadd_commute2_vec_before  ⊑  fmul_fadd_commute2_vec_combined := by
  unfold fmul_fadd_commute2_vec_before fmul_fadd_commute2_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fmul_fadd_commute2_vec   : fmul_fadd_commute2_vec_before  ⊑  fmul_fadd_commute2_vec_combined := by
  unfold fmul_fadd_commute2_vec_before fmul_fadd_commute2_vec_combined
  simp_alive_peephole
  sorry
def fmul_fadd_commute3_combined := [llvmfunc|
  llvm.func @fmul_fadd_commute3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

theorem inst_combine_fmul_fadd_commute3   : fmul_fadd_commute3_before  ⊑  fmul_fadd_commute3_combined := by
  unfold fmul_fadd_commute3_before fmul_fadd_commute3_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

theorem inst_combine_fmul_fadd_commute3   : fmul_fadd_commute3_before  ⊑  fmul_fadd_commute3_combined := by
  unfold fmul_fadd_commute3_before fmul_fadd_commute3_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_fmul_fadd_commute3   : fmul_fadd_commute3_before  ⊑  fmul_fadd_commute3_combined := by
  unfold fmul_fadd_commute3_before fmul_fadd_commute3_combined
  simp_alive_peephole
  sorry
def fmul_fadd_not_enough_FMF_combined := [llvmfunc|
  llvm.func @fmul_fadd_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fmul_fadd_not_enough_FMF   : fmul_fadd_not_enough_FMF_before  ⊑  fmul_fadd_not_enough_FMF_combined := by
  unfold fmul_fadd_not_enough_FMF_before fmul_fadd_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fmul_fadd_not_enough_FMF   : fmul_fadd_not_enough_FMF_before  ⊑  fmul_fadd_not_enough_FMF_combined := by
  unfold fmul_fadd_not_enough_FMF_before fmul_fadd_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_fmul_fadd_not_enough_FMF   : fmul_fadd_not_enough_FMF_before  ⊑  fmul_fadd_not_enough_FMF_combined := by
  unfold fmul_fadd_not_enough_FMF_before fmul_fadd_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_fadd_not_enough_FMF   : fmul_fadd_not_enough_FMF_before  ⊑  fmul_fadd_not_enough_FMF_combined := by
  unfold fmul_fadd_not_enough_FMF_before fmul_fadd_not_enough_FMF_combined
  simp_alive_peephole
  sorry
def fmul_fadd_uses1_combined := [llvmfunc|
  llvm.func @fmul_fadd_uses1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fmul_fadd_uses1   : fmul_fadd_uses1_before  ⊑  fmul_fadd_uses1_combined := by
  unfold fmul_fadd_uses1_before fmul_fadd_uses1_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_fadd_uses1   : fmul_fadd_uses1_before  ⊑  fmul_fadd_uses1_combined := by
  unfold fmul_fadd_uses1_before fmul_fadd_uses1_combined
  simp_alive_peephole
  sorry
def fmul_fadd_uses2_combined := [llvmfunc|
  llvm.func @fmul_fadd_uses2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg2, %arg1  : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fmul_fadd_uses2   : fmul_fadd_uses2_before  ⊑  fmul_fadd_uses2_combined := by
  unfold fmul_fadd_uses2_before fmul_fadd_uses2_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_fadd_uses2   : fmul_fadd_uses2_before  ⊑  fmul_fadd_uses2_combined := by
  unfold fmul_fadd_uses2_before fmul_fadd_uses2_combined
  simp_alive_peephole
  sorry
def fmul_fadd_uses3_combined := [llvmfunc|
  llvm.func @fmul_fadd_uses3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg2, %arg1  : f32
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fmul_fadd_uses3   : fmul_fadd_uses3_before  ⊑  fmul_fadd_uses3_combined := by
  unfold fmul_fadd_uses3_before fmul_fadd_uses3_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_fadd_uses3   : fmul_fadd_uses3_before  ⊑  fmul_fadd_uses3_combined := by
  unfold fmul_fadd_uses3_before fmul_fadd_uses3_combined
  simp_alive_peephole
  sorry
def fmul_fsub_combined := [llvmfunc|
  llvm.func @fmul_fsub(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f16]

theorem inst_combine_fmul_fsub   : fmul_fsub_before  ⊑  fmul_fsub_combined := by
  unfold fmul_fsub_before fmul_fsub_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f16]

theorem inst_combine_fmul_fsub   : fmul_fsub_before  ⊑  fmul_fsub_combined := by
  unfold fmul_fsub_before fmul_fsub_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_fmul_fsub   : fmul_fsub_before  ⊑  fmul_fsub_combined := by
  unfold fmul_fsub_before fmul_fsub_combined
  simp_alive_peephole
  sorry
def fmul_fsub_commute1_vec_combined := [llvmfunc|
  llvm.func @fmul_fsub_commute1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fmul_fsub_commute1_vec   : fmul_fsub_commute1_vec_before  ⊑  fmul_fsub_commute1_vec_combined := by
  unfold fmul_fsub_commute1_vec_before fmul_fsub_commute1_vec_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fmul_fsub_commute1_vec   : fmul_fsub_commute1_vec_before  ⊑  fmul_fsub_commute1_vec_combined := by
  unfold fmul_fsub_commute1_vec_before fmul_fsub_commute1_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fmul_fsub_commute1_vec   : fmul_fsub_commute1_vec_before  ⊑  fmul_fsub_commute1_vec_combined := by
  unfold fmul_fsub_commute1_vec_before fmul_fsub_commute1_vec_combined
  simp_alive_peephole
  sorry
def fmul_fsub_commute2_vec_combined := [llvmfunc|
  llvm.func @fmul_fsub_commute2_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fmul_fsub_commute2_vec   : fmul_fsub_commute2_vec_before  ⊑  fmul_fsub_commute2_vec_combined := by
  unfold fmul_fsub_commute2_vec_before fmul_fsub_commute2_vec_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fmul_fsub_commute2_vec   : fmul_fsub_commute2_vec_before  ⊑  fmul_fsub_commute2_vec_combined := by
  unfold fmul_fsub_commute2_vec_before fmul_fsub_commute2_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fmul_fsub_commute2_vec   : fmul_fsub_commute2_vec_before  ⊑  fmul_fsub_commute2_vec_combined := by
  unfold fmul_fsub_commute2_vec_before fmul_fsub_commute2_vec_combined
  simp_alive_peephole
  sorry
def fmul_fsub_commute3_combined := [llvmfunc|
  llvm.func @fmul_fsub_commute3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

theorem inst_combine_fmul_fsub_commute3   : fmul_fsub_commute3_before  ⊑  fmul_fsub_commute3_combined := by
  unfold fmul_fsub_commute3_before fmul_fsub_commute3_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<nnan, nsz, reassoc>} : f64]

theorem inst_combine_fmul_fsub_commute3   : fmul_fsub_commute3_before  ⊑  fmul_fsub_commute3_combined := by
  unfold fmul_fsub_commute3_before fmul_fsub_commute3_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_fmul_fsub_commute3   : fmul_fsub_commute3_before  ⊑  fmul_fsub_commute3_combined := by
  unfold fmul_fsub_commute3_before fmul_fsub_commute3_combined
  simp_alive_peephole
  sorry
def fmul_fsub_not_enough_FMF_combined := [llvmfunc|
  llvm.func @fmul_fsub_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fmul_fsub_not_enough_FMF   : fmul_fsub_not_enough_FMF_before  ⊑  fmul_fsub_not_enough_FMF_combined := by
  unfold fmul_fsub_not_enough_FMF_before fmul_fsub_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fmul_fsub_not_enough_FMF   : fmul_fsub_not_enough_FMF_before  ⊑  fmul_fsub_not_enough_FMF_combined := by
  unfold fmul_fsub_not_enough_FMF_before fmul_fsub_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

theorem inst_combine_fmul_fsub_not_enough_FMF   : fmul_fsub_not_enough_FMF_before  ⊑  fmul_fsub_not_enough_FMF_combined := by
  unfold fmul_fsub_not_enough_FMF_before fmul_fsub_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_fsub_not_enough_FMF   : fmul_fsub_not_enough_FMF_before  ⊑  fmul_fsub_not_enough_FMF_combined := by
  unfold fmul_fsub_not_enough_FMF_before fmul_fsub_not_enough_FMF_combined
  simp_alive_peephole
  sorry
def fmul_fsub_uses1_combined := [llvmfunc|
  llvm.func @fmul_fsub_uses1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fmul_fsub_uses1   : fmul_fsub_uses1_before  ⊑  fmul_fsub_uses1_combined := by
  unfold fmul_fsub_uses1_before fmul_fsub_uses1_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_fsub_uses1   : fmul_fsub_uses1_before  ⊑  fmul_fsub_uses1_combined := by
  unfold fmul_fsub_uses1_before fmul_fsub_uses1_combined
  simp_alive_peephole
  sorry
def fmul_fsub_uses2_combined := [llvmfunc|
  llvm.func @fmul_fsub_uses2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg2, %arg0  : f32
    %1 = llvm.fmul %arg2, %arg1  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fmul_fsub_uses2   : fmul_fsub_uses2_before  ⊑  fmul_fsub_uses2_combined := by
  unfold fmul_fsub_uses2_before fmul_fsub_uses2_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_fsub_uses2   : fmul_fsub_uses2_before  ⊑  fmul_fsub_uses2_combined := by
  unfold fmul_fsub_uses2_before fmul_fsub_uses2_combined
  simp_alive_peephole
  sorry
def fmul_fsub_uses3_combined := [llvmfunc|
  llvm.func @fmul_fsub_uses3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg2  : f32
    %1 = llvm.fmul %arg1, %arg2  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fmul_fsub_uses3   : fmul_fsub_uses3_before  ⊑  fmul_fsub_uses3_combined := by
  unfold fmul_fsub_uses3_before fmul_fsub_uses3_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_fsub_uses3   : fmul_fsub_uses3_before  ⊑  fmul_fsub_uses3_combined := by
  unfold fmul_fsub_uses3_before fmul_fsub_uses3_combined
  simp_alive_peephole
  sorry
def fdiv_fadd_combined := [llvmfunc|
  llvm.func @fdiv_fadd(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64]

theorem inst_combine_fdiv_fadd   : fdiv_fadd_before  ⊑  fdiv_fadd_combined := by
  unfold fdiv_fadd_before fdiv_fadd_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64]

theorem inst_combine_fdiv_fadd   : fdiv_fadd_before  ⊑  fdiv_fadd_combined := by
  unfold fdiv_fadd_before fdiv_fadd_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_fdiv_fadd   : fdiv_fadd_before  ⊑  fdiv_fadd_combined := by
  unfold fdiv_fadd_before fdiv_fadd_combined
  simp_alive_peephole
  sorry
def fdiv_fsub_combined := [llvmfunc|
  llvm.func @fdiv_fsub(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fdiv_fsub   : fdiv_fsub_before  ⊑  fdiv_fsub_combined := by
  unfold fdiv_fsub_before fdiv_fsub_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_fdiv_fsub   : fdiv_fsub_before  ⊑  fdiv_fsub_combined := by
  unfold fdiv_fsub_before fdiv_fsub_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_fdiv_fsub   : fdiv_fsub_before  ⊑  fdiv_fsub_combined := by
  unfold fdiv_fsub_before fdiv_fsub_combined
  simp_alive_peephole
  sorry
def fdiv_fadd_vec_combined := [llvmfunc|
  llvm.func @fdiv_fadd_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf64>]

theorem inst_combine_fdiv_fadd_vec   : fdiv_fadd_vec_before  ⊑  fdiv_fadd_vec_combined := by
  unfold fdiv_fadd_vec_before fdiv_fadd_vec_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf64>]

theorem inst_combine_fdiv_fadd_vec   : fdiv_fadd_vec_before  ⊑  fdiv_fadd_vec_combined := by
  unfold fdiv_fadd_vec_before fdiv_fadd_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fdiv_fadd_vec   : fdiv_fadd_vec_before  ⊑  fdiv_fadd_vec_combined := by
  unfold fdiv_fadd_vec_before fdiv_fadd_vec_combined
  simp_alive_peephole
  sorry
def fdiv_fsub_vec_combined := [llvmfunc|
  llvm.func @fdiv_fsub_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fdiv_fsub_vec   : fdiv_fsub_vec_before  ⊑  fdiv_fsub_vec_combined := by
  unfold fdiv_fsub_vec_before fdiv_fsub_vec_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

theorem inst_combine_fdiv_fsub_vec   : fdiv_fsub_vec_before  ⊑  fdiv_fsub_vec_combined := by
  unfold fdiv_fsub_vec_before fdiv_fsub_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fdiv_fsub_vec   : fdiv_fsub_vec_before  ⊑  fdiv_fsub_vec_combined := by
  unfold fdiv_fsub_vec_before fdiv_fsub_vec_combined
  simp_alive_peephole
  sorry
def fdiv_fadd_commute1_combined := [llvmfunc|
  llvm.func @fdiv_fadd_commute1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_commute1   : fdiv_fadd_commute1_before  ⊑  fdiv_fadd_commute1_combined := by
  unfold fdiv_fadd_commute1_before fdiv_fadd_commute1_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %arg2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_commute1   : fdiv_fadd_commute1_before  ⊑  fdiv_fadd_commute1_combined := by
  unfold fdiv_fadd_commute1_before fdiv_fadd_commute1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_commute1   : fdiv_fadd_commute1_before  ⊑  fdiv_fadd_commute1_combined := by
  unfold fdiv_fadd_commute1_before fdiv_fadd_commute1_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fadd_commute1   : fdiv_fadd_commute1_before  ⊑  fdiv_fadd_commute1_combined := by
  unfold fdiv_fadd_commute1_before fdiv_fadd_commute1_combined
  simp_alive_peephole
  sorry
def fdiv_fsub_commute2_combined := [llvmfunc|
  llvm.func @fdiv_fsub_commute2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_commute2   : fdiv_fsub_commute2_before  ⊑  fdiv_fsub_commute2_combined := by
  unfold fdiv_fsub_commute2_before fdiv_fsub_commute2_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_commute2   : fdiv_fsub_commute2_before  ⊑  fdiv_fsub_commute2_combined := by
  unfold fdiv_fsub_commute2_before fdiv_fsub_commute2_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_commute2   : fdiv_fsub_commute2_before  ⊑  fdiv_fsub_commute2_combined := by
  unfold fdiv_fsub_commute2_before fdiv_fsub_commute2_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fsub_commute2   : fdiv_fsub_commute2_before  ⊑  fdiv_fsub_commute2_combined := by
  unfold fdiv_fsub_commute2_before fdiv_fsub_commute2_combined
  simp_alive_peephole
  sorry
def fdiv_fadd_not_enough_FMF_combined := [llvmfunc|
  llvm.func @fdiv_fadd_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_not_enough_FMF   : fdiv_fadd_not_enough_FMF_before  ⊑  fdiv_fadd_not_enough_FMF_combined := by
  unfold fdiv_fadd_not_enough_FMF_before fdiv_fadd_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %arg2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_not_enough_FMF   : fdiv_fadd_not_enough_FMF_before  ⊑  fdiv_fadd_not_enough_FMF_combined := by
  unfold fdiv_fadd_not_enough_FMF_before fdiv_fadd_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

theorem inst_combine_fdiv_fadd_not_enough_FMF   : fdiv_fadd_not_enough_FMF_before  ⊑  fdiv_fadd_not_enough_FMF_combined := by
  unfold fdiv_fadd_not_enough_FMF_before fdiv_fadd_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fadd_not_enough_FMF   : fdiv_fadd_not_enough_FMF_before  ⊑  fdiv_fadd_not_enough_FMF_combined := by
  unfold fdiv_fadd_not_enough_FMF_before fdiv_fadd_not_enough_FMF_combined
  simp_alive_peephole
  sorry
def fdiv_fsub_not_enough_FMF_combined := [llvmfunc|
  llvm.func @fdiv_fsub_not_enough_FMF(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_not_enough_FMF   : fdiv_fsub_not_enough_FMF_before  ⊑  fdiv_fsub_not_enough_FMF_combined := by
  unfold fdiv_fsub_not_enough_FMF_before fdiv_fsub_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %arg2, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_not_enough_FMF   : fdiv_fsub_not_enough_FMF_before  ⊑  fdiv_fsub_not_enough_FMF_combined := by
  unfold fdiv_fsub_not_enough_FMF_before fdiv_fsub_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_fdiv_fsub_not_enough_FMF   : fdiv_fsub_not_enough_FMF_before  ⊑  fdiv_fsub_not_enough_FMF_combined := by
  unfold fdiv_fsub_not_enough_FMF_before fdiv_fsub_not_enough_FMF_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fsub_not_enough_FMF   : fdiv_fsub_not_enough_FMF_before  ⊑  fdiv_fsub_not_enough_FMF_combined := by
  unfold fdiv_fsub_not_enough_FMF_before fdiv_fsub_not_enough_FMF_combined
  simp_alive_peephole
  sorry
def fdiv_fadd_uses1_combined := [llvmfunc|
  llvm.func @fdiv_fadd_uses1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_uses1   : fdiv_fadd_uses1_before  ⊑  fdiv_fadd_uses1_combined := by
  unfold fdiv_fadd_uses1_before fdiv_fadd_uses1_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_uses1   : fdiv_fadd_uses1_before  ⊑  fdiv_fadd_uses1_combined := by
  unfold fdiv_fadd_uses1_before fdiv_fadd_uses1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_uses1   : fdiv_fadd_uses1_before  ⊑  fdiv_fadd_uses1_combined := by
  unfold fdiv_fadd_uses1_before fdiv_fadd_uses1_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fadd_uses1   : fdiv_fadd_uses1_before  ⊑  fdiv_fadd_uses1_combined := by
  unfold fdiv_fadd_uses1_before fdiv_fadd_uses1_combined
  simp_alive_peephole
  sorry
def fdiv_fsub_uses2_combined := [llvmfunc|
  llvm.func @fdiv_fsub_uses2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_uses2   : fdiv_fsub_uses2_before  ⊑  fdiv_fsub_uses2_combined := by
  unfold fdiv_fsub_uses2_before fdiv_fsub_uses2_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_uses2   : fdiv_fsub_uses2_before  ⊑  fdiv_fsub_uses2_combined := by
  unfold fdiv_fsub_uses2_before fdiv_fsub_uses2_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_uses2   : fdiv_fsub_uses2_before  ⊑  fdiv_fsub_uses2_combined := by
  unfold fdiv_fsub_uses2_before fdiv_fsub_uses2_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fsub_uses2   : fdiv_fsub_uses2_before  ⊑  fdiv_fsub_uses2_combined := by
  unfold fdiv_fsub_uses2_before fdiv_fsub_uses2_combined
  simp_alive_peephole
  sorry
def fdiv_fsub_uses3_combined := [llvmfunc|
  llvm.func @fdiv_fsub_uses3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fdiv %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_uses3   : fdiv_fsub_uses3_before  ⊑  fdiv_fsub_uses3_combined := by
  unfold fdiv_fsub_uses3_before fdiv_fsub_uses3_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_uses3   : fdiv_fsub_uses3_before  ⊑  fdiv_fsub_uses3_combined := by
  unfold fdiv_fsub_uses3_before fdiv_fsub_uses3_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_uses3   : fdiv_fsub_uses3_before  ⊑  fdiv_fsub_uses3_combined := by
  unfold fdiv_fsub_uses3_before fdiv_fsub_uses3_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f32) -> ()
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fsub_uses3   : fdiv_fsub_uses3_before  ⊑  fdiv_fsub_uses3_combined := by
  unfold fdiv_fsub_uses3_before fdiv_fsub_uses3_combined
  simp_alive_peephole
  sorry
def fdiv_fadd_not_denorm_combined := [llvmfunc|
  llvm.func @fdiv_fadd_not_denorm(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.76324153E-38 : f32) : f32
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_not_denorm   : fdiv_fadd_not_denorm_before  ⊑  fdiv_fadd_not_denorm_combined := by
  unfold fdiv_fadd_not_denorm_before fdiv_fadd_not_denorm_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_fdiv_fadd_not_denorm   : fdiv_fadd_not_denorm_before  ⊑  fdiv_fadd_not_denorm_combined := by
  unfold fdiv_fadd_not_denorm_before fdiv_fadd_not_denorm_combined
  simp_alive_peephole
  sorry
def fdiv_fadd_denorm_combined := [llvmfunc|
  llvm.func @fdiv_fadd_denorm(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.constant(5.87747175E-39 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_denorm   : fdiv_fadd_denorm_before  ⊑  fdiv_fadd_denorm_combined := by
  unfold fdiv_fadd_denorm_before fdiv_fadd_denorm_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_denorm   : fdiv_fadd_denorm_before  ⊑  fdiv_fadd_denorm_combined := by
  unfold fdiv_fadd_denorm_before fdiv_fadd_denorm_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fadd_denorm   : fdiv_fadd_denorm_before  ⊑  fdiv_fadd_denorm_combined := by
  unfold fdiv_fadd_denorm_before fdiv_fadd_denorm_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_fdiv_fadd_denorm   : fdiv_fadd_denorm_before  ⊑  fdiv_fadd_denorm_combined := by
  unfold fdiv_fadd_denorm_before fdiv_fadd_denorm_combined
  simp_alive_peephole
  sorry
def fdiv_fsub_denorm_combined := [llvmfunc|
  llvm.func @fdiv_fsub_denorm(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.constant(5.87747175E-39 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_denorm   : fdiv_fsub_denorm_before  ⊑  fdiv_fsub_denorm_combined := by
  unfold fdiv_fsub_denorm_before fdiv_fsub_denorm_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_denorm   : fdiv_fsub_denorm_before  ⊑  fdiv_fsub_denorm_combined := by
  unfold fdiv_fsub_denorm_before fdiv_fsub_denorm_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fsub %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fdiv_fsub_denorm   : fdiv_fsub_denorm_before  ⊑  fdiv_fsub_denorm_combined := by
  unfold fdiv_fsub_denorm_before fdiv_fsub_denorm_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_fdiv_fsub_denorm   : fdiv_fsub_denorm_before  ⊑  fdiv_fsub_denorm_combined := by
  unfold fdiv_fsub_denorm_before fdiv_fsub_denorm_combined
  simp_alive_peephole
  sorry
def lerp_commute0_combined := [llvmfunc|
  llvm.func @lerp_commute0(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_commute0   : lerp_commute0_before  ⊑  lerp_commute0_combined := by
  unfold lerp_commute0_before lerp_commute0_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_commute0   : lerp_commute0_before  ⊑  lerp_commute0_combined := by
  unfold lerp_commute0_before lerp_commute0_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_commute0   : lerp_commute0_before  ⊑  lerp_commute0_combined := by
  unfold lerp_commute0_before lerp_commute0_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_lerp_commute0   : lerp_commute0_before  ⊑  lerp_commute0_combined := by
  unfold lerp_commute0_before lerp_commute0_combined
  simp_alive_peephole
  sorry
def lerp_commute1_combined := [llvmfunc|
  llvm.func @lerp_commute1(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

theorem inst_combine_lerp_commute1   : lerp_commute1_before  ⊑  lerp_commute1_combined := by
  unfold lerp_commute1_before lerp_commute1_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

theorem inst_combine_lerp_commute1   : lerp_commute1_before  ⊑  lerp_commute1_combined := by
  unfold lerp_commute1_before lerp_commute1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

theorem inst_combine_lerp_commute1   : lerp_commute1_before  ⊑  lerp_commute1_combined := by
  unfold lerp_commute1_before lerp_commute1_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_lerp_commute1   : lerp_commute1_before  ⊑  lerp_commute1_combined := by
  unfold lerp_commute1_before lerp_commute1_combined
  simp_alive_peephole
  sorry
def lerp_commute2_combined := [llvmfunc|
  llvm.func @lerp_commute2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_lerp_commute2   : lerp_commute2_before  ⊑  lerp_commute2_combined := by
  unfold lerp_commute2_before lerp_commute2_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_lerp_commute2   : lerp_commute2_before  ⊑  lerp_commute2_combined := by
  unfold lerp_commute2_before lerp_commute2_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

theorem inst_combine_lerp_commute2   : lerp_commute2_before  ⊑  lerp_commute2_combined := by
  unfold lerp_commute2_before lerp_commute2_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_lerp_commute2   : lerp_commute2_before  ⊑  lerp_commute2_combined := by
  unfold lerp_commute2_before lerp_commute2_combined
  simp_alive_peephole
  sorry
def lerp_commute3_combined := [llvmfunc|
  llvm.func @lerp_commute3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : f32]

theorem inst_combine_lerp_commute3   : lerp_commute3_before  ⊑  lerp_commute3_combined := by
  unfold lerp_commute3_before lerp_commute3_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : f32]

theorem inst_combine_lerp_commute3   : lerp_commute3_before  ⊑  lerp_commute3_combined := by
  unfold lerp_commute3_before lerp_commute3_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : f32]

theorem inst_combine_lerp_commute3   : lerp_commute3_before  ⊑  lerp_commute3_combined := by
  unfold lerp_commute3_before lerp_commute3_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_lerp_commute3   : lerp_commute3_before  ⊑  lerp_commute3_combined := by
  unfold lerp_commute3_before lerp_commute3_combined
  simp_alive_peephole
  sorry
def lerp_commute4_combined := [llvmfunc|
  llvm.func @lerp_commute4(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_lerp_commute4   : lerp_commute4_before  ⊑  lerp_commute4_combined := by
  unfold lerp_commute4_before lerp_commute4_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_lerp_commute4   : lerp_commute4_before  ⊑  lerp_commute4_combined := by
  unfold lerp_commute4_before lerp_commute4_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_lerp_commute4   : lerp_commute4_before  ⊑  lerp_commute4_combined := by
  unfold lerp_commute4_before lerp_commute4_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_lerp_commute4   : lerp_commute4_before  ⊑  lerp_commute4_combined := by
  unfold lerp_commute4_before lerp_commute4_combined
  simp_alive_peephole
  sorry
def lerp_commute5_combined := [llvmfunc|
  llvm.func @lerp_commute5(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_lerp_commute5   : lerp_commute5_before  ⊑  lerp_commute5_combined := by
  unfold lerp_commute5_before lerp_commute5_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_lerp_commute5   : lerp_commute5_before  ⊑  lerp_commute5_combined := by
  unfold lerp_commute5_before lerp_commute5_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_lerp_commute5   : lerp_commute5_before  ⊑  lerp_commute5_combined := by
  unfold lerp_commute5_before lerp_commute5_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f64
  }]

theorem inst_combine_lerp_commute5   : lerp_commute5_before  ⊑  lerp_commute5_combined := by
  unfold lerp_commute5_before lerp_commute5_combined
  simp_alive_peephole
  sorry
def lerp_commute6_combined := [llvmfunc|
  llvm.func @lerp_commute6(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_lerp_commute6   : lerp_commute6_before  ⊑  lerp_commute6_combined := by
  unfold lerp_commute6_before lerp_commute6_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_lerp_commute6   : lerp_commute6_before  ⊑  lerp_commute6_combined := by
  unfold lerp_commute6_before lerp_commute6_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_lerp_commute6   : lerp_commute6_before  ⊑  lerp_commute6_combined := by
  unfold lerp_commute6_before lerp_commute6_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f16
  }]

theorem inst_combine_lerp_commute6   : lerp_commute6_before  ⊑  lerp_commute6_combined := by
  unfold lerp_commute6_before lerp_commute6_combined
  simp_alive_peephole
  sorry
def lerp_commute7_combined := [llvmfunc|
  llvm.func @lerp_commute7(%arg0: f16, %arg1: f16, %arg2: f16) -> f16 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_lerp_commute7   : lerp_commute7_before  ⊑  lerp_commute7_combined := by
  unfold lerp_commute7_before lerp_commute7_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fmul %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_lerp_commute7   : lerp_commute7_before  ⊑  lerp_commute7_combined := by
  unfold lerp_commute7_before lerp_commute7_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_lerp_commute7   : lerp_commute7_before  ⊑  lerp_commute7_combined := by
  unfold lerp_commute7_before lerp_commute7_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f16
  }]

theorem inst_combine_lerp_commute7   : lerp_commute7_before  ⊑  lerp_commute7_combined := by
  unfold lerp_commute7_before lerp_commute7_combined
  simp_alive_peephole
  sorry
def lerp_extra_use1_combined := [llvmfunc|
  llvm.func @lerp_extra_use1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use1   : lerp_extra_use1_before  ⊑  lerp_extra_use1_combined := by
  unfold lerp_extra_use1_before lerp_extra_use1_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use1   : lerp_extra_use1_before  ⊑  lerp_extra_use1_combined := by
  unfold lerp_extra_use1_before lerp_extra_use1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use1   : lerp_extra_use1_before  ⊑  lerp_extra_use1_combined := by
  unfold lerp_extra_use1_before lerp_extra_use1_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use1   : lerp_extra_use1_before  ⊑  lerp_extra_use1_combined := by
  unfold lerp_extra_use1_before lerp_extra_use1_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_lerp_extra_use1   : lerp_extra_use1_before  ⊑  lerp_extra_use1_combined := by
  unfold lerp_extra_use1_before lerp_extra_use1_combined
  simp_alive_peephole
  sorry
def lerp_extra_use2_combined := [llvmfunc|
  llvm.func @lerp_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use2   : lerp_extra_use2_before  ⊑  lerp_extra_use2_combined := by
  unfold lerp_extra_use2_before lerp_extra_use2_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use2   : lerp_extra_use2_before  ⊑  lerp_extra_use2_combined := by
  unfold lerp_extra_use2_before lerp_extra_use2_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use2   : lerp_extra_use2_before  ⊑  lerp_extra_use2_combined := by
  unfold lerp_extra_use2_before lerp_extra_use2_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use2   : lerp_extra_use2_before  ⊑  lerp_extra_use2_combined := by
  unfold lerp_extra_use2_before lerp_extra_use2_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_lerp_extra_use2   : lerp_extra_use2_before  ⊑  lerp_extra_use2_combined := by
  unfold lerp_extra_use2_before lerp_extra_use2_combined
  simp_alive_peephole
  sorry
def lerp_extra_use3_combined := [llvmfunc|
  llvm.func @lerp_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use3   : lerp_extra_use3_before  ⊑  lerp_extra_use3_combined := by
  unfold lerp_extra_use3_before lerp_extra_use3_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fmul %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use3   : lerp_extra_use3_before  ⊑  lerp_extra_use3_combined := by
  unfold lerp_extra_use3_before lerp_extra_use3_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fmul %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use3   : lerp_extra_use3_before  ⊑  lerp_extra_use3_combined := by
  unfold lerp_extra_use3_before lerp_extra_use3_combined
  simp_alive_peephole
  sorry
    %4 = llvm.fadd %3, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_lerp_extra_use3   : lerp_extra_use3_before  ⊑  lerp_extra_use3_combined := by
  unfold lerp_extra_use3_before lerp_extra_use3_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f32
  }]

theorem inst_combine_lerp_extra_use3   : lerp_extra_use3_before  ⊑  lerp_extra_use3_combined := by
  unfold lerp_extra_use3_before lerp_extra_use3_combined
  simp_alive_peephole
  sorry
