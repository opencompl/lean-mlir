import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fcmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fpext_fpext_before := [llvmfunc|
  llvm.func @fpext_fpext(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fcmp "ogt" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    llvm.return %2 : i1
  }]

def fpext_constant_before := [llvmfunc|
  llvm.func @fpext_constant(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f64]

    llvm.return %2 : i1
  }]

def fpext_constant_vec_splat_before := [llvmfunc|
  llvm.func @fpext_constant_vec_splat(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf16> to vector<2xf64>
    %2 = llvm.fcmp "ole" %1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf64>]

    llvm.return %2 : vector<2xi1>
  }]

def fpext_constant_lossy_before := [llvmfunc|
  llvm.func @fpext_constant_lossy(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.0000000000000002 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }]

def fpext_constant_denorm_before := [llvmfunc|
  llvm.func @fpext_constant_denorm(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.4012984643248171E-45 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }]

def fneg_constant_swap_pred_before := [llvmfunc|
  llvm.func @fneg_constant_swap_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg0  : f32
    %3 = llvm.fcmp "ogt" %2, %1 : f32
    llvm.return %3 : i1
  }]

def unary_fneg_constant_swap_pred_before := [llvmfunc|
  llvm.func @unary_fneg_constant_swap_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fneg %arg0  : f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fneg_constant_swap_pred_vec_before := [llvmfunc|
  llvm.func @fneg_constant_swap_pred_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fsub %0, %arg0  : vector<2xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }]

def unary_fneg_constant_swap_pred_vec_before := [llvmfunc|
  llvm.func @unary_fneg_constant_swap_pred_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg0  : vector<2xf32>
    %2 = llvm.fcmp "ogt" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def fneg_constant_swap_pred_vec_poison_before := [llvmfunc|
  llvm.func @fneg_constant_swap_pred_vec_poison(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %8 = llvm.fsub %6, %arg0  : vector<2xf32>
    %9 = llvm.fcmp "ogt" %8, %7 : vector<2xf32>
    llvm.return %9 : vector<2xi1>
  }]

def fneg_fmf_before := [llvmfunc|
  llvm.func @fneg_fmf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %3 = llvm.fcmp "oeq" %2, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : i1
  }]

def unary_fneg_fmf_before := [llvmfunc|
  llvm.func @unary_fneg_fmf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fcmp "oeq" %1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : i1
  }]

def fcmp_fneg_fmf_vec_before := [llvmfunc|
  llvm.func @fcmp_fneg_fmf_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(dense<[4.200000e+01, -1.900000e+01]> : vector<2xf32>) : vector<2xf32>
    %3 = llvm.fsub %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>]

    %4 = llvm.fcmp "uge" %3, %2 {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : vector<2xf32>]

    llvm.return %4 : vector<2xi1>
  }]

def fneg_fneg_swap_pred_before := [llvmfunc|
  llvm.func @fneg_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %3 : i1
  }]

def unary_fneg_unary_fneg_swap_pred_before := [llvmfunc|
  llvm.func @unary_fneg_unary_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.fcmp "olt" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %2 : i1
  }]

def unary_fneg_fneg_swap_pred_before := [llvmfunc|
  llvm.func @unary_fneg_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fneg %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %3 : i1
  }]

def fneg_unary_fneg_swap_pred_before := [llvmfunc|
  llvm.func @fneg_unary_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fneg %arg1  : f32
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %3 : i1
  }]

def fneg_fneg_swap_pred_vec_before := [llvmfunc|
  llvm.func @fneg_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def unary_fneg_unary_fneg_swap_pred_vec_before := [llvmfunc|
  llvm.func @unary_fneg_unary_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.fcmp "olt" %0, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %2 : vector<2xi1>
  }]

def unary_fneg_fneg_swap_pred_vec_before := [llvmfunc|
  llvm.func @unary_fneg_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fneg_unary_fneg_swap_pred_vec_before := [llvmfunc|
  llvm.func @fneg_unary_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fneg_fneg_swap_pred_vec_poison_before := [llvmfunc|
  llvm.func @fneg_fneg_swap_pred_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.undef : vector<2xf32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xf32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xf32>
    %12 = llvm.fsub %6, %arg0  : vector<2xf32>
    %13 = llvm.fsub %11, %arg1  : vector<2xf32>
    %14 = llvm.fcmp "olt" %12, %13 : vector<2xf32>
    llvm.return %14 : vector<2xi1>
  }]

def unary_fneg_fneg_swap_pred_vec_poison_before := [llvmfunc|
  llvm.func @unary_fneg_fneg_swap_pred_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fneg %arg0  : vector<2xf32>
    %8 = llvm.fsub %6, %arg1  : vector<2xf32>
    %9 = llvm.fcmp "olt" %7, %8 : vector<2xf32>
    llvm.return %9 : vector<2xi1>
  }]

def fneg_unary_fneg_swap_pred_vec_poison_before := [llvmfunc|
  llvm.func @fneg_unary_fneg_swap_pred_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %6, %arg0  : vector<2xf32>
    %8 = llvm.fneg %arg1  : vector<2xf32>
    %9 = llvm.fcmp "olt" %7, %8 : vector<2xf32>
    llvm.return %9 : vector<2xi1>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f128) : !llvm.ppc_fp128
    %1 = llvm.fpext %arg0 : f32 to !llvm.ppc_fp128
    %2 = llvm.fcmp "ogt" %1, %0 : !llvm.ppc_fp128
    llvm.return %2 : i1
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "olt" %1, %0 : f64
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.sitofp %3 : i32 to f32
    llvm.return %4 : f32
  }]

def fabs_uge_before := [llvmfunc|
  llvm.func @fabs_uge(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "uge" %1, %0 : f64
    llvm.return %2 : i1
  }]

def fabs_olt_before := [llvmfunc|
  llvm.func @fabs_olt(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "olt" %1, %0 : f16
    llvm.return %2 : i1
  }]

def fabs_ole_before := [llvmfunc|
  llvm.func @fabs_ole(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fabs_ule_before := [llvmfunc|
  llvm.func @fabs_ule(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ule" %2, %1 {fastmathFlags = #llvm.fastmath<ninf, arcp>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fabs_ogt_before := [llvmfunc|
  llvm.func @fabs_ogt(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "ogt" %1, %0 {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : i1
  }]

def fabs_ugt_before := [llvmfunc|
  llvm.func @fabs_ugt(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "ugt" %1, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f64]

    llvm.return %2 : i1
  }]

def fabs_oge_before := [llvmfunc|
  llvm.func @fabs_oge(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "oge" %1, %0 {fastmathFlags = #llvm.fastmath<afn>} : f64]

    llvm.return %2 : i1
  }]

def fabs_ult_before := [llvmfunc|
  llvm.func @fabs_ult(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "ult" %1, %0 {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    llvm.return %2 : i1
  }]

def fabs_ult_nnan_before := [llvmfunc|
  llvm.func @fabs_ult_nnan(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ult" %2, %1 {fastmathFlags = #llvm.fastmath<nnan, arcp, reassoc>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fabs_une_before := [llvmfunc|
  llvm.func @fabs_une(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %2 = llvm.fcmp "une" %1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f16]

    llvm.return %2 : i1
  }]

def fabs_oeq_before := [llvmfunc|
  llvm.func @fabs_oeq(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "oeq" %1, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f64]

    llvm.return %2 : i1
  }]

def fabs_one_before := [llvmfunc|
  llvm.func @fabs_one(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %2 = llvm.fcmp "one" %1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %2 : i1
  }]

def fabs_ueq_before := [llvmfunc|
  llvm.func @fabs_ueq(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ueq" %2, %1 {fastmathFlags = #llvm.fastmath<arcp>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fabs_ord_before := [llvmfunc|
  llvm.func @fabs_ord(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "ord" %2, %1 {fastmathFlags = #llvm.fastmath<arcp>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fabs_uno_before := [llvmfunc|
  llvm.func @fabs_uno(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fcmp "uno" %2, %1 {fastmathFlags = #llvm.fastmath<arcp>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: f64, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call %arg1(%arg0) : !llvm.ptr, (f64) -> f64
    %2 = llvm.fcmp "ueq" %1, %0 : f64
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

def test18_undef_unordered_before := [llvmfunc|
  llvm.func @test18_undef_unordered(%arg0: f32) -> i32 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

def test18_undef_ordered_before := [llvmfunc|
  llvm.func @test18_undef_ordered(%arg0: f32) -> i32 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

def test19_undef_unordered_before := [llvmfunc|
  llvm.func @test19_undef_unordered() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.fcmp "ueq" %0, %0 : f32
    llvm.return %1 : i1
  }]

def test19_undef_ordered_before := [llvmfunc|
  llvm.func @test19_undef_ordered() -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.fcmp "oeq" %0, %0 : f32
    llvm.return %1 : i1
  }]

def test20_recipX_olt_0_before := [llvmfunc|
  llvm.func @test20_recipX_olt_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %3 = llvm.fcmp "olt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %3 : i1
  }]

def test21_recipX_ole_0_before := [llvmfunc|
  llvm.func @test21_recipX_ole_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %3 : i1
  }]

def test22_recipX_ogt_0_before := [llvmfunc|
  llvm.func @test22_recipX_ogt_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %3 : i1
  }]

def test23_recipX_oge_0_before := [llvmfunc|
  llvm.func @test23_recipX_oge_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %3 = llvm.fcmp "oge" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %3 : i1
  }]

def test24_recipX_noninf_cmp_before := [llvmfunc|
  llvm.func @test24_recipX_noninf_cmp(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %3 = llvm.fcmp "ogt" %2, %1 : f32
    llvm.return %3 : i1
  }]

def test25_recipX_noninf_div_before := [llvmfunc|
  llvm.func @test25_recipX_noninf_div(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  : f32
    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %3 : i1
  }]

def test26_recipX_unorderd_before := [llvmfunc|
  llvm.func @test26_recipX_unorderd(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    %3 = llvm.fcmp "ugt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %3 : i1
  }]

def test27_recipX_gt_vecsplat_before := [llvmfunc|
  llvm.func @test27_recipX_gt_vecsplat(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def is_signbit_set_before := [llvmfunc|
  llvm.func @is_signbit_set(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "olt" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_set_1_before := [llvmfunc|
  llvm.func @is_signbit_set_1(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ult" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_set_2_before := [llvmfunc|
  llvm.func @is_signbit_set_2(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ole" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_set_3_before := [llvmfunc|
  llvm.func @is_signbit_set_3(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ule" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_set_anyzero_before := [llvmfunc|
  llvm.func @is_signbit_set_anyzero(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[-0.000000e+00, 0.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.copysign(%0, %arg0)  : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    %3 = llvm.fcmp "olt" %2, %1 : vector<2xf64>
    llvm.return %3 : vector<2xi1>
  }]

def is_signbit_clear_before := [llvmfunc|
  llvm.func @is_signbit_clear(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ogt" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_clear_1_before := [llvmfunc|
  llvm.func @is_signbit_clear_1(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ugt" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_clear_2_before := [llvmfunc|
  llvm.func @is_signbit_clear_2(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "oge" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_clear_3_before := [llvmfunc|
  llvm.func @is_signbit_clear_3(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "uge" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_set_extra_use_before := [llvmfunc|
  llvm.func @is_signbit_set_extra_use(%arg0: f64, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    llvm.store %2, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

    %3 = llvm.fcmp "olt" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_clear_nonzero_before := [llvmfunc|
  llvm.func @is_signbit_clear_nonzero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ogt" %2, %1 : f64
    llvm.return %3 : i1
  }]

def is_signbit_set_simplify_zero_before := [llvmfunc|
  llvm.func @is_signbit_set_simplify_zero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }]

def is_signbit_set_simplify_nan_before := [llvmfunc|
  llvm.func @is_signbit_set_simplify_nan(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ogt" %2, %1 : f64
    llvm.return %3 : i1
  }]

def lossy_oeq_before := [llvmfunc|
  llvm.func @lossy_oeq(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

def lossy_one_before := [llvmfunc|
  llvm.func @lossy_one(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    llvm.store %1, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

    %2 = llvm.fcmp "one" %1, %0 : f64
    llvm.return %2 : i1
  }]

def lossy_ueq_before := [llvmfunc|
  llvm.func @lossy_ueq(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "ueq" %1, %0 : f64
    llvm.return %2 : i1
  }]

def lossy_une_before := [llvmfunc|
  llvm.func @lossy_une(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }]

def lossy_ogt_before := [llvmfunc|
  llvm.func @lossy_ogt(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fcmp "ogt" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

def lossy_oge_before := [llvmfunc|
  llvm.func @lossy_oge(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    llvm.store %1, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

    %2 = llvm.fcmp "oge" %1, %0 : f64
    llvm.return %2 : i1
  }]

def lossy_olt_before := [llvmfunc|
  llvm.func @lossy_olt(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "olt" %1, %0 : f64
    llvm.return %2 : i1
  }]

def lossy_ole_before := [llvmfunc|
  llvm.func @lossy_ole(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }]

def lossy_ugt_before := [llvmfunc|
  llvm.func @lossy_ugt(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fcmp "ugt" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

def lossy_uge_before := [llvmfunc|
  llvm.func @lossy_uge(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    llvm.store %1, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

    %2 = llvm.fcmp "uge" %1, %0 : f64
    llvm.return %2 : i1
  }]

def lossy_ult_before := [llvmfunc|
  llvm.func @lossy_ult(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "ult" %1, %0 : f64
    llvm.return %2 : i1
  }]

def lossy_ule_before := [llvmfunc|
  llvm.func @lossy_ule(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "ule" %1, %0 : f32
    llvm.return %2 : i1
  }]

def lossy_ord_before := [llvmfunc|
  llvm.func @lossy_ord(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "ord" %1, %0 : f64
    llvm.return %2 : i1
  }]

def lossy_uno_before := [llvmfunc|
  llvm.func @lossy_uno(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "uno" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fneg_oeq_before := [llvmfunc|
  llvm.func @fneg_oeq(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "oeq" %0, %arg0 : f32
    llvm.return %1 : i1
  }]

def fneg_ogt_before := [llvmfunc|
  llvm.func @fneg_ogt(%arg0: f16) -> i1 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.fcmp "ogt" %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f16]

    llvm.return %1 : i1
  }]

def fneg_oge_before := [llvmfunc|
  llvm.func @fneg_oge(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %1 = llvm.fcmp "oge" %0, %arg0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

def fneg_olt_before := [llvmfunc|
  llvm.func @fneg_olt(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

    %1 = llvm.fcmp "olt" %0, %arg0 : f32
    llvm.return %1 : i1
  }]

def fneg_ole_before := [llvmfunc|
  llvm.func @fneg_ole(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ole" %0, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %1 : i1
  }]

def fneg_one_before := [llvmfunc|
  llvm.func @fneg_one(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "one" %0, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %1 : i1
  }]

def fneg_ord_before := [llvmfunc|
  llvm.func @fneg_ord(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ord" %0, %arg0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %1 : i1
  }]

def fneg_uno_before := [llvmfunc|
  llvm.func @fneg_uno(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "uno" %0, %arg0 : f32
    llvm.return %1 : i1
  }]

def fneg_ueq_before := [llvmfunc|
  llvm.func @fneg_ueq(%arg0: f16) -> i1 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.fcmp "ueq" %0, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f16]

    llvm.return %1 : i1
  }]

def fneg_ugt_before := [llvmfunc|
  llvm.func @fneg_ugt(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %1 = llvm.fcmp "ugt" %0, %arg0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

def fneg_uge_before := [llvmfunc|
  llvm.func @fneg_uge(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    llvm.store %0, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

    %1 = llvm.fcmp "uge" %0, %arg0 : f32
    llvm.return %1 : i1
  }]

def fneg_ult_before := [llvmfunc|
  llvm.func @fneg_ult(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ult" %0, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %1 : i1
  }]

def fneg_ule_before := [llvmfunc|
  llvm.func @fneg_ule(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "ule" %0, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %1 : i1
  }]

def fneg_une_before := [llvmfunc|
  llvm.func @fneg_une(%arg0: f32) -> i1 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fcmp "une" %0, %arg0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %1 : i1
  }]

def fneg_oeq_swap_before := [llvmfunc|
  llvm.func @fneg_oeq_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "oeq" %0, %1 : f32
    llvm.return %2 : i1
  }]

def fneg_ogt_swap_before := [llvmfunc|
  llvm.func @fneg_ogt_swap(%arg0: f16) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f16
    %1 = llvm.fneg %0  : f16
    %2 = llvm.fcmp "ogt" %0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f16]

    llvm.return %2 : i1
  }]

def fneg_oge_swap_before := [llvmfunc|
  llvm.func @fneg_oge_swap(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fadd %arg0, %arg0  : vector<2xf32>
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %2 = llvm.fcmp "oge" %0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def fneg_olt_swap_before := [llvmfunc|
  llvm.func @fneg_olt_swap(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    llvm.store %1, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

    %2 = llvm.fcmp "olt" %0, %1 : f32
    llvm.return %2 : i1
  }]

def fneg_ole_swap_before := [llvmfunc|
  llvm.func @fneg_ole_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "ole" %0, %1 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %2 : i1
  }]

def fneg_one_swap_before := [llvmfunc|
  llvm.func @fneg_one_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "one" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %2 : i1
  }]

def fneg_ord_swap_before := [llvmfunc|
  llvm.func @fneg_ord_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "ord" %0, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %2 : i1
  }]

def fneg_uno_swap_before := [llvmfunc|
  llvm.func @fneg_uno_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "uno" %0, %1 : f32
    llvm.return %2 : i1
  }]

def fneg_ueq_swap_before := [llvmfunc|
  llvm.func @fneg_ueq_swap(%arg0: f16) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f16
    %1 = llvm.fneg %0  : f16
    %2 = llvm.fcmp "ueq" %0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f16]

    llvm.return %2 : i1
  }]

def fneg_ugt_swap_before := [llvmfunc|
  llvm.func @fneg_ugt_swap(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fadd %arg0, %arg0  : vector<2xf32>
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %2 = llvm.fcmp "ugt" %0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def fneg_uge_swap_before := [llvmfunc|
  llvm.func @fneg_uge_swap(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    llvm.store %1, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

    %2 = llvm.fcmp "uge" %0, %1 : f32
    llvm.return %2 : i1
  }]

def fneg_ult_swap_before := [llvmfunc|
  llvm.func @fneg_ult_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "ult" %0, %1 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %2 : i1
  }]

def fneg_ule_swap_before := [llvmfunc|
  llvm.func @fneg_ule_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "ule" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %2 : i1
  }]

def fneg_une_swap_before := [llvmfunc|
  llvm.func @fneg_une_swap(%arg0: f32) -> i1 {
    %0 = llvm.fadd %arg0, %arg0  : f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fcmp "une" %0, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %2 : i1
  }]

def bitcast_eq0_before := [llvmfunc|
  llvm.func @bitcast_eq0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def bitcast_ne0_before := [llvmfunc|
  llvm.func @bitcast_ne0(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.bitcast %arg0 : vector<2xi32> to vector<2xf32>
    %3 = llvm.fcmp "une" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }]

def bitcast_eq0_use_before := [llvmfunc|
  llvm.func @bitcast_eq0_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : i32 to f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def bitcast_nonint_eq0_before := [llvmfunc|
  llvm.func @bitcast_nonint_eq0(%arg0: vector<2xi16>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : vector<2xi16> to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def bitcast_gt0_before := [llvmfunc|
  llvm.func @bitcast_gt0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def bitcast_1vec_eq0_before := [llvmfunc|
  llvm.func @bitcast_1vec_eq0(%arg0: i32) -> vector<1xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<1xf32>) : vector<1xf32>
    %2 = llvm.bitcast %arg0 : i32 to vector<1xf32>
    %3 = llvm.fcmp "oeq" %2, %1 : vector<1xf32>
    llvm.return %3 : vector<1xi1>
  }]

def fcmp_fadd_zero_ugt_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ugt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_uge_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_uge(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "uge" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_ogt_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ogt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ogt" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_oge_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_oge(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "oge" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_ult_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ult(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ult" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_ule_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ule(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ule" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_olt_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_olt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "olt" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_ole_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ole(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ole" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_oeq_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_oeq(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "oeq" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_one_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_one(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "one" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_ueq_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ueq(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ueq" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_une_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_une(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "une" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_ord_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ord(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ord" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_uno_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_uno(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "uno" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_neg_zero_before := [llvmfunc|
  llvm.func @fcmp_fadd_neg_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_switched_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_switched(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg1, %0  : f32
    %2 = llvm.fcmp "ugt" %arg0, %1 : f32
    llvm.return %2 : i1
  }]

def fcmp_fadd_zero_vec_before := [llvmfunc|
  llvm.func @fcmp_fadd_zero_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %0  : vector<2xf32>
    %2 = llvm.fcmp "ugt" %1, %arg1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

def fcmp_fast_fadd_fast_zero_before := [llvmfunc|
  llvm.func @fcmp_fast_fadd_fast_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fcmp "ugt" %1, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : i1
  }]

def fcmp_fast_fadd_zero_before := [llvmfunc|
  llvm.func @fcmp_fast_fadd_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : i1
  }]

def fcmp_fadd_fast_zero_before := [llvmfunc|
  llvm.func @fcmp_fadd_fast_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fcmp "ugt" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

def fcmp_ueq_sel_x_negx_before := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "ueq" %3, %0 : f32
    llvm.return %4 : i1
  }]

def fcmp_une_sel_x_negx_before := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "une" %3, %0 : f32
    llvm.return %4 : i1
  }]

def fcmp_oeq_sel_x_negx_before := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "oeq" %3, %0 : f32
    llvm.return %4 : i1
  }]

def fcmp_one_sel_x_negx_before := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "one" %3, %0 : f32
    llvm.return %4 : i1
  }]

def fcmp_ueq_sel_x_negx_nzero_before := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    %5 = llvm.fcmp "ueq" %4, %1 : f32
    llvm.return %5 : i1
  }]

def fcmp_une_sel_x_negx_nzero_before := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "une" %arg0, %0 : f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    %5 = llvm.fcmp "une" %4, %1 : f32
    llvm.return %5 : i1
  }]

def fcmp_oeq_sel_x_negx_nzero_before := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "oeq" %arg0, %0 : f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    %5 = llvm.fcmp "oeq" %4, %1 : f32
    llvm.return %5 : i1
  }]

def fcmp_one_sel_x_negx_nzero_before := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "one" %arg0, %0 : f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.select %2, %arg0, %3 : i1, f32
    %5 = llvm.fcmp "one" %4, %1 : f32
    llvm.return %5 : i1
  }]

def fcmp_ueq_sel_x_negx_vec_before := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "ueq" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "ueq" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }]

def fcmp_une_sel_x_negx_vec_before := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "une" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "une" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }]

def fcmp_oeq_sel_x_negx_vec_before := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "oeq" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }]

def fcmp_one_sel_x_negx_vec_before := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "one" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "one" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }]

def fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "oeq" %2, %0 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "one" %2, %0 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "ueq" %2, %0 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "une" %2, %0 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "oeq" %2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "one" %2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "ueq" %2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.fcmp "une" %2, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

    llvm.return %3 : vector<2xi1>
  }]

def fcmp_ueq_fsub_nnan_const_extra_use_before := [llvmfunc|
  llvm.func @fcmp_ueq_fsub_nnan_const_extra_use(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fcmp "ueq" %1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    llvm.return %2 : i1
  }]

def fcmp_oeq_fsub_ninf_const_extra_use_before := [llvmfunc|
  llvm.func @fcmp_oeq_fsub_ninf_const_extra_use(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fcmp "oeq" %1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.return %2 : i1
  }]

def fcmp_oeq_fsub_const_before := [llvmfunc|
  llvm.func @fcmp_oeq_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fcmp_oge_fsub_const_before := [llvmfunc|
  llvm.func @fcmp_oge_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "oge" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fcmp_ole_fsub_const_before := [llvmfunc|
  llvm.func @fcmp_ole_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fcmp_ueq_fsub_const_before := [llvmfunc|
  llvm.func @fcmp_ueq_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fcmp_uge_fsub_const_before := [llvmfunc|
  llvm.func @fcmp_uge_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "uge" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fcmp_ule_fsub_const_before := [llvmfunc|
  llvm.func @fcmp_ule_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ule" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fcmp_ugt_fsub_const_before := [llvmfunc|
  llvm.func @fcmp_ugt_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ugt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fcmp_ult_fsub_const_before := [llvmfunc|
  llvm.func @fcmp_ult_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ult" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fcmp_une_fsub_const_before := [llvmfunc|
  llvm.func @fcmp_une_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }]

def fcmp_uge_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_uge_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ule_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_ule_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "ule" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ueq_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_ueq_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "ueq" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_oge_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_oge_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "oge" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ole_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_ole_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_oeq_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_oeq_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "oeq" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ogt_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_ogt_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_olt_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_olt_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "olt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_one_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_one_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "one" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ugt_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_ugt_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "ugt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ult_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_ult_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "ult" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_une_fsub_const_ninf_vec_before := [llvmfunc|
  llvm.func @fcmp_une_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    %3 = llvm.fcmp "une" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_uge_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_uge_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ule_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_ule_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "ule" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ueq_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_ueq_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "ueq" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_oge_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_oge_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "oge" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ole_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_ole_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_oeq_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_oeq_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "oeq" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ogt_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_ogt_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_olt_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_olt_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "olt" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_one_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_one_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "one" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ugt_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_ugt_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "ugt" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ult_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_ult_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "ult" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def fcmp_une_fsub_const_nnan_vec_before := [llvmfunc|
  llvm.func @fcmp_une_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    %3 = llvm.fcmp "une" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

    llvm.return %3 : vector<8xi1>
  }]

def "fcmp_ugt_fsub_const_vec_denormal_positive-zero"_before := [llvmfunc|
  llvm.func @"fcmp_ugt_fsub_const_vec_denormal_positive-zero"(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> attributes {passthrough = [["denormal-fp-math", "positive-zero,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }]

def fcmp_ogt_fsub_const_vec_denormal_dynamic_before := [llvmfunc|
  llvm.func @fcmp_ogt_fsub_const_vec_denormal_dynamic(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> attributes {passthrough = [["denormal-fp-math", "dynamic,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }]

def "fcmp_ogt_fsub_const_vec_denormal_preserve-sign"_before := [llvmfunc|
  llvm.func @"fcmp_ogt_fsub_const_vec_denormal_preserve-sign"(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> attributes {passthrough = [["denormal-fp-math", "preserve-sign,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }]

def fpext_fpext_combined := [llvmfunc|
  llvm.func @fpext_fpext(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fpext_fpext   : fpext_fpext_before  ⊑  fpext_fpext_combined := by
  unfold fpext_fpext_before fpext_fpext_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_fpext_fpext   : fpext_fpext_before  ⊑  fpext_fpext_combined := by
  unfold fpext_fpext_before fpext_fpext_combined
  simp_alive_peephole
  sorry
def fpext_constant_combined := [llvmfunc|
  llvm.func @fpext_constant(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_fpext_constant   : fpext_constant_before  ⊑  fpext_constant_combined := by
  unfold fpext_constant_before fpext_constant_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fpext_constant   : fpext_constant_before  ⊑  fpext_constant_combined := by
  unfold fpext_constant_before fpext_constant_combined
  simp_alive_peephole
  sorry
def fpext_constant_vec_splat_combined := [llvmfunc|
  llvm.func @fpext_constant_vec_splat(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fcmp "ole" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf16>]

theorem inst_combine_fpext_constant_vec_splat   : fpext_constant_vec_splat_before  ⊑  fpext_constant_vec_splat_combined := by
  unfold fpext_constant_vec_splat_before fpext_constant_vec_splat_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_fpext_constant_vec_splat   : fpext_constant_vec_splat_before  ⊑  fpext_constant_vec_splat_combined := by
  unfold fpext_constant_vec_splat_before fpext_constant_vec_splat_combined
  simp_alive_peephole
  sorry
def fpext_constant_lossy_combined := [llvmfunc|
  llvm.func @fpext_constant_lossy(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.0000000000000002 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }]

theorem inst_combine_fpext_constant_lossy   : fpext_constant_lossy_before  ⊑  fpext_constant_lossy_combined := by
  unfold fpext_constant_lossy_before fpext_constant_lossy_combined
  simp_alive_peephole
  sorry
def fpext_constant_denorm_combined := [llvmfunc|
  llvm.func @fpext_constant_denorm(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.4012984643248171E-45 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }]

theorem inst_combine_fpext_constant_denorm   : fpext_constant_denorm_before  ⊑  fpext_constant_denorm_combined := by
  unfold fpext_constant_denorm_before fpext_constant_denorm_combined
  simp_alive_peephole
  sorry
def fneg_constant_swap_pred_combined := [llvmfunc|
  llvm.func @fneg_constant_swap_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_constant_swap_pred   : fneg_constant_swap_pred_before  ⊑  fneg_constant_swap_pred_combined := by
  unfold fneg_constant_swap_pred_before fneg_constant_swap_pred_combined
  simp_alive_peephole
  sorry
def unary_fneg_constant_swap_pred_combined := [llvmfunc|
  llvm.func @unary_fneg_constant_swap_pred(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_unary_fneg_constant_swap_pred   : unary_fneg_constant_swap_pred_before  ⊑  unary_fneg_constant_swap_pred_combined := by
  unfold unary_fneg_constant_swap_pred_before unary_fneg_constant_swap_pred_combined
  simp_alive_peephole
  sorry
def fneg_constant_swap_pred_vec_combined := [llvmfunc|
  llvm.func @fneg_constant_swap_pred_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "olt" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_fneg_constant_swap_pred_vec   : fneg_constant_swap_pred_vec_before  ⊑  fneg_constant_swap_pred_vec_combined := by
  unfold fneg_constant_swap_pred_vec_before fneg_constant_swap_pred_vec_combined
  simp_alive_peephole
  sorry
def unary_fneg_constant_swap_pred_vec_combined := [llvmfunc|
  llvm.func @unary_fneg_constant_swap_pred_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "olt" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_unary_fneg_constant_swap_pred_vec   : unary_fneg_constant_swap_pred_vec_before  ⊑  unary_fneg_constant_swap_pred_vec_combined := by
  unfold unary_fneg_constant_swap_pred_vec_before unary_fneg_constant_swap_pred_vec_combined
  simp_alive_peephole
  sorry
def fneg_constant_swap_pred_vec_poison_combined := [llvmfunc|
  llvm.func @fneg_constant_swap_pred_vec_poison(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "olt" %arg0, %0 : vector<2xf32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_fneg_constant_swap_pred_vec_poison   : fneg_constant_swap_pred_vec_poison_before  ⊑  fneg_constant_swap_pred_vec_poison_combined := by
  unfold fneg_constant_swap_pred_vec_poison_before fneg_constant_swap_pred_vec_poison_combined
  simp_alive_peephole
  sorry
def fneg_fmf_combined := [llvmfunc|
  llvm.func @fneg_fmf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fneg_fmf   : fneg_fmf_before  ⊑  fneg_fmf_combined := by
  unfold fneg_fmf_before fneg_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_fmf   : fneg_fmf_before  ⊑  fneg_fmf_combined := by
  unfold fneg_fmf_before fneg_fmf_combined
  simp_alive_peephole
  sorry
def unary_fneg_fmf_combined := [llvmfunc|
  llvm.func @unary_fneg_fmf(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_unary_fneg_fmf   : unary_fneg_fmf_before  ⊑  unary_fneg_fmf_combined := by
  unfold unary_fneg_fmf_before unary_fneg_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_unary_fneg_fmf   : unary_fneg_fmf_before  ⊑  unary_fneg_fmf_combined := by
  unfold unary_fneg_fmf_before unary_fneg_fmf_combined
  simp_alive_peephole
  sorry
def fcmp_fneg_fmf_vec_combined := [llvmfunc|
  llvm.func @fcmp_fneg_fmf_vec(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-4.200000e+01, 1.900000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fcmp "ule" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : vector<2xf32>]

theorem inst_combine_fcmp_fneg_fmf_vec   : fcmp_fneg_fmf_vec_before  ⊑  fcmp_fneg_fmf_vec_combined := by
  unfold fcmp_fneg_fmf_vec_before fcmp_fneg_fmf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_fcmp_fneg_fmf_vec   : fcmp_fneg_fmf_vec_before  ⊑  fcmp_fneg_fmf_vec_combined := by
  unfold fcmp_fneg_fmf_vec_before fcmp_fneg_fmf_vec_combined
  simp_alive_peephole
  sorry
def fneg_fneg_swap_pred_combined := [llvmfunc|
  llvm.func @fneg_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fneg_fneg_swap_pred   : fneg_fneg_swap_pred_before  ⊑  fneg_fneg_swap_pred_combined := by
  unfold fneg_fneg_swap_pred_before fneg_fneg_swap_pred_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_fneg_fneg_swap_pred   : fneg_fneg_swap_pred_before  ⊑  fneg_fneg_swap_pred_combined := by
  unfold fneg_fneg_swap_pred_before fneg_fneg_swap_pred_combined
  simp_alive_peephole
  sorry
def unary_fneg_unary_fneg_swap_pred_combined := [llvmfunc|
  llvm.func @unary_fneg_unary_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_unary_fneg_unary_fneg_swap_pred   : unary_fneg_unary_fneg_swap_pred_before  ⊑  unary_fneg_unary_fneg_swap_pred_combined := by
  unfold unary_fneg_unary_fneg_swap_pred_before unary_fneg_unary_fneg_swap_pred_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_unary_fneg_unary_fneg_swap_pred   : unary_fneg_unary_fneg_swap_pred_before  ⊑  unary_fneg_unary_fneg_swap_pred_combined := by
  unfold unary_fneg_unary_fneg_swap_pred_before unary_fneg_unary_fneg_swap_pred_combined
  simp_alive_peephole
  sorry
def unary_fneg_fneg_swap_pred_combined := [llvmfunc|
  llvm.func @unary_fneg_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_unary_fneg_fneg_swap_pred   : unary_fneg_fneg_swap_pred_before  ⊑  unary_fneg_fneg_swap_pred_combined := by
  unfold unary_fneg_fneg_swap_pred_before unary_fneg_fneg_swap_pred_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_unary_fneg_fneg_swap_pred   : unary_fneg_fneg_swap_pred_before  ⊑  unary_fneg_fneg_swap_pred_combined := by
  unfold unary_fneg_fneg_swap_pred_before unary_fneg_fneg_swap_pred_combined
  simp_alive_peephole
  sorry
def fneg_unary_fneg_swap_pred_combined := [llvmfunc|
  llvm.func @fneg_unary_fneg_swap_pred(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fneg_unary_fneg_swap_pred   : fneg_unary_fneg_swap_pred_before  ⊑  fneg_unary_fneg_swap_pred_combined := by
  unfold fneg_unary_fneg_swap_pred_before fneg_unary_fneg_swap_pred_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_fneg_unary_fneg_swap_pred   : fneg_unary_fneg_swap_pred_before  ⊑  fneg_unary_fneg_swap_pred_combined := by
  unfold fneg_unary_fneg_swap_pred_before fneg_unary_fneg_swap_pred_combined
  simp_alive_peephole
  sorry
def fneg_fneg_swap_pred_vec_combined := [llvmfunc|
  llvm.func @fneg_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_fneg_fneg_swap_pred_vec   : fneg_fneg_swap_pred_vec_before  ⊑  fneg_fneg_swap_pred_vec_combined := by
  unfold fneg_fneg_swap_pred_vec_before fneg_fneg_swap_pred_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_fneg_fneg_swap_pred_vec   : fneg_fneg_swap_pred_vec_before  ⊑  fneg_fneg_swap_pred_vec_combined := by
  unfold fneg_fneg_swap_pred_vec_before fneg_fneg_swap_pred_vec_combined
  simp_alive_peephole
  sorry
def unary_fneg_unary_fneg_swap_pred_vec_combined := [llvmfunc|
  llvm.func @unary_fneg_unary_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_unary_fneg_unary_fneg_swap_pred_vec   : unary_fneg_unary_fneg_swap_pred_vec_before  ⊑  unary_fneg_unary_fneg_swap_pred_vec_combined := by
  unfold unary_fneg_unary_fneg_swap_pred_vec_before unary_fneg_unary_fneg_swap_pred_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_unary_fneg_unary_fneg_swap_pred_vec   : unary_fneg_unary_fneg_swap_pred_vec_before  ⊑  unary_fneg_unary_fneg_swap_pred_vec_combined := by
  unfold unary_fneg_unary_fneg_swap_pred_vec_before unary_fneg_unary_fneg_swap_pred_vec_combined
  simp_alive_peephole
  sorry
def unary_fneg_fneg_swap_pred_vec_combined := [llvmfunc|
  llvm.func @unary_fneg_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_unary_fneg_fneg_swap_pred_vec   : unary_fneg_fneg_swap_pred_vec_before  ⊑  unary_fneg_fneg_swap_pred_vec_combined := by
  unfold unary_fneg_fneg_swap_pred_vec_before unary_fneg_fneg_swap_pred_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_unary_fneg_fneg_swap_pred_vec   : unary_fneg_fneg_swap_pred_vec_before  ⊑  unary_fneg_fneg_swap_pred_vec_combined := by
  unfold unary_fneg_fneg_swap_pred_vec_before unary_fneg_fneg_swap_pred_vec_combined
  simp_alive_peephole
  sorry
def fneg_unary_fneg_swap_pred_vec_combined := [llvmfunc|
  llvm.func @fneg_unary_fneg_swap_pred_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_fneg_unary_fneg_swap_pred_vec   : fneg_unary_fneg_swap_pred_vec_before  ⊑  fneg_unary_fneg_swap_pred_vec_combined := by
  unfold fneg_unary_fneg_swap_pred_vec_before fneg_unary_fneg_swap_pred_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_fneg_unary_fneg_swap_pred_vec   : fneg_unary_fneg_swap_pred_vec_before  ⊑  fneg_unary_fneg_swap_pred_vec_combined := by
  unfold fneg_unary_fneg_swap_pred_vec_before fneg_unary_fneg_swap_pred_vec_combined
  simp_alive_peephole
  sorry
def fneg_fneg_swap_pred_vec_poison_combined := [llvmfunc|
  llvm.func @fneg_fneg_swap_pred_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : vector<2xf32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_fneg_fneg_swap_pred_vec_poison   : fneg_fneg_swap_pred_vec_poison_before  ⊑  fneg_fneg_swap_pred_vec_poison_combined := by
  unfold fneg_fneg_swap_pred_vec_poison_before fneg_fneg_swap_pred_vec_poison_combined
  simp_alive_peephole
  sorry
def unary_fneg_fneg_swap_pred_vec_poison_combined := [llvmfunc|
  llvm.func @unary_fneg_fneg_swap_pred_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : vector<2xf32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_unary_fneg_fneg_swap_pred_vec_poison   : unary_fneg_fneg_swap_pred_vec_poison_before  ⊑  unary_fneg_fneg_swap_pred_vec_poison_combined := by
  unfold unary_fneg_fneg_swap_pred_vec_poison_before unary_fneg_fneg_swap_pred_vec_poison_combined
  simp_alive_peephole
  sorry
def fneg_unary_fneg_swap_pred_vec_poison_combined := [llvmfunc|
  llvm.func @fneg_unary_fneg_swap_pred_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : vector<2xf32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_fneg_unary_fneg_swap_pred_vec_poison   : fneg_unary_fneg_swap_pred_vec_poison_before  ⊑  fneg_unary_fneg_swap_pred_vec_poison_combined := by
  unfold fneg_unary_fneg_swap_pred_vec_poison_before fneg_unary_fneg_swap_pred_vec_poison_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    %2 = llvm.uitofp %1 : i1 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def fabs_uge_combined := [llvmfunc|
  llvm.func @fabs_uge(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fabs_uge   : fabs_uge_before  ⊑  fabs_uge_combined := by
  unfold fabs_uge_before fabs_uge_combined
  simp_alive_peephole
  sorry
def fabs_olt_combined := [llvmfunc|
  llvm.func @fabs_olt(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_fabs_olt   : fabs_olt_before  ⊑  fabs_olt_combined := by
  unfold fabs_olt_before fabs_olt_combined
  simp_alive_peephole
  sorry
def fabs_ole_combined := [llvmfunc|
  llvm.func @fabs_ole(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "oeq" %arg0, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_fabs_ole   : fabs_ole_before  ⊑  fabs_ole_combined := by
  unfold fabs_ole_before fabs_ole_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fabs_ole   : fabs_ole_before  ⊑  fabs_ole_combined := by
  unfold fabs_ole_before fabs_ole_combined
  simp_alive_peephole
  sorry
def fabs_ule_combined := [llvmfunc|
  llvm.func @fabs_ule(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ueq" %arg0, %1 {fastmathFlags = #llvm.fastmath<ninf, arcp>} : vector<2xf32>]

theorem inst_combine_fabs_ule   : fabs_ule_before  ⊑  fabs_ule_combined := by
  unfold fabs_ule_before fabs_ule_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fabs_ule   : fabs_ule_before  ⊑  fabs_ule_combined := by
  unfold fabs_ule_before fabs_ule_combined
  simp_alive_peephole
  sorry
def fabs_ogt_combined := [llvmfunc|
  llvm.func @fabs_ogt(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "one" %arg0, %0 {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_fabs_ogt   : fabs_ogt_before  ⊑  fabs_ogt_combined := by
  unfold fabs_ogt_before fabs_ogt_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fabs_ogt   : fabs_ogt_before  ⊑  fabs_ogt_combined := by
  unfold fabs_ogt_before fabs_ogt_combined
  simp_alive_peephole
  sorry
def fabs_ugt_combined := [llvmfunc|
  llvm.func @fabs_ugt(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "une" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f64]

theorem inst_combine_fabs_ugt   : fabs_ugt_before  ⊑  fabs_ugt_combined := by
  unfold fabs_ugt_before fabs_ugt_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fabs_ugt   : fabs_ugt_before  ⊑  fabs_ugt_combined := by
  unfold fabs_ugt_before fabs_ugt_combined
  simp_alive_peephole
  sorry
def fabs_oge_combined := [llvmfunc|
  llvm.func @fabs_oge(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<afn>} : f64]

theorem inst_combine_fabs_oge   : fabs_oge_before  ⊑  fabs_oge_combined := by
  unfold fabs_oge_before fabs_oge_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fabs_oge   : fabs_oge_before  ⊑  fabs_oge_combined := by
  unfold fabs_oge_before fabs_oge_combined
  simp_alive_peephole
  sorry
def fabs_ult_combined := [llvmfunc|
  llvm.func @fabs_ult(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uno" %arg0, %0 {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

theorem inst_combine_fabs_ult   : fabs_ult_before  ⊑  fabs_ult_combined := by
  unfold fabs_ult_before fabs_ult_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fabs_ult   : fabs_ult_before  ⊑  fabs_ult_combined := by
  unfold fabs_ult_before fabs_ult_combined
  simp_alive_peephole
  sorry
def fabs_ult_nnan_combined := [llvmfunc|
  llvm.func @fabs_ult_nnan(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_fabs_ult_nnan   : fabs_ult_nnan_before  ⊑  fabs_ult_nnan_combined := by
  unfold fabs_ult_nnan_before fabs_ult_nnan_combined
  simp_alive_peephole
  sorry
def fabs_une_combined := [llvmfunc|
  llvm.func @fabs_une(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "une" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f16]

theorem inst_combine_fabs_une   : fabs_une_before  ⊑  fabs_une_combined := by
  unfold fabs_une_before fabs_une_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fabs_une   : fabs_une_before  ⊑  fabs_une_combined := by
  unfold fabs_une_before fabs_une_combined
  simp_alive_peephole
  sorry
def fabs_oeq_combined := [llvmfunc|
  llvm.func @fabs_oeq(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oeq" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f64]

theorem inst_combine_fabs_oeq   : fabs_oeq_before  ⊑  fabs_oeq_combined := by
  unfold fabs_oeq_before fabs_oeq_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fabs_oeq   : fabs_oeq_before  ⊑  fabs_oeq_combined := by
  unfold fabs_oeq_before fabs_oeq_combined
  simp_alive_peephole
  sorry
def fabs_one_combined := [llvmfunc|
  llvm.func @fabs_one(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "one" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_fabs_one   : fabs_one_before  ⊑  fabs_one_combined := by
  unfold fabs_one_before fabs_one_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fabs_one   : fabs_one_before  ⊑  fabs_one_combined := by
  unfold fabs_one_before fabs_one_combined
  simp_alive_peephole
  sorry
def fabs_ueq_combined := [llvmfunc|
  llvm.func @fabs_ueq(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ueq" %arg0, %1 {fastmathFlags = #llvm.fastmath<arcp>} : vector<2xf32>]

theorem inst_combine_fabs_ueq   : fabs_ueq_before  ⊑  fabs_ueq_combined := by
  unfold fabs_ueq_before fabs_ueq_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fabs_ueq   : fabs_ueq_before  ⊑  fabs_ueq_combined := by
  unfold fabs_ueq_before fabs_ueq_combined
  simp_alive_peephole
  sorry
def fabs_ord_combined := [llvmfunc|
  llvm.func @fabs_ord(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ord" %arg0, %1 {fastmathFlags = #llvm.fastmath<arcp>} : vector<2xf32>]

theorem inst_combine_fabs_ord   : fabs_ord_before  ⊑  fabs_ord_combined := by
  unfold fabs_ord_before fabs_ord_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fabs_ord   : fabs_ord_before  ⊑  fabs_ord_combined := by
  unfold fabs_ord_before fabs_ord_combined
  simp_alive_peephole
  sorry
def fabs_uno_combined := [llvmfunc|
  llvm.func @fabs_uno(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "uno" %arg0, %1 {fastmathFlags = #llvm.fastmath<arcp>} : vector<2xf32>]

theorem inst_combine_fabs_uno   : fabs_uno_before  ⊑  fabs_uno_combined := by
  unfold fabs_uno_before fabs_uno_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fabs_uno   : fabs_uno_before  ⊑  fabs_uno_combined := by
  unfold fabs_uno_before fabs_uno_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: f64, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call %arg1(%arg0) : !llvm.ptr, (f64) -> f64
    %2 = llvm.fcmp "ueq" %1, %0 : f64
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_undef_unordered_combined := [llvmfunc|
  llvm.func @test18_undef_unordered(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test18_undef_unordered   : test18_undef_unordered_before  ⊑  test18_undef_unordered_combined := by
  unfold test18_undef_unordered_before test18_undef_unordered_combined
  simp_alive_peephole
  sorry
def test18_undef_ordered_combined := [llvmfunc|
  llvm.func @test18_undef_ordered(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test18_undef_ordered   : test18_undef_ordered_before  ⊑  test18_undef_ordered_combined := by
  unfold test18_undef_ordered_before test18_undef_ordered_combined
  simp_alive_peephole
  sorry
def test19_undef_unordered_combined := [llvmfunc|
  llvm.func @test19_undef_unordered() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test19_undef_unordered   : test19_undef_unordered_before  ⊑  test19_undef_unordered_combined := by
  unfold test19_undef_unordered_before test19_undef_unordered_combined
  simp_alive_peephole
  sorry
def test19_undef_ordered_combined := [llvmfunc|
  llvm.func @test19_undef_ordered() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test19_undef_ordered   : test19_undef_ordered_before  ⊑  test19_undef_ordered_combined := by
  unfold test19_undef_ordered_before test19_undef_ordered_combined
  simp_alive_peephole
  sorry
def test20_recipX_olt_0_combined := [llvmfunc|
  llvm.func @test20_recipX_olt_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_test20_recipX_olt_0   : test20_recipX_olt_0_before  ⊑  test20_recipX_olt_0_combined := by
  unfold test20_recipX_olt_0_before test20_recipX_olt_0_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_test20_recipX_olt_0   : test20_recipX_olt_0_before  ⊑  test20_recipX_olt_0_combined := by
  unfold test20_recipX_olt_0_before test20_recipX_olt_0_combined
  simp_alive_peephole
  sorry
def test21_recipX_ole_0_combined := [llvmfunc|
  llvm.func @test21_recipX_ole_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_test21_recipX_ole_0   : test21_recipX_ole_0_before  ⊑  test21_recipX_ole_0_combined := by
  unfold test21_recipX_ole_0_before test21_recipX_ole_0_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_test21_recipX_ole_0   : test21_recipX_ole_0_before  ⊑  test21_recipX_ole_0_combined := by
  unfold test21_recipX_ole_0_before test21_recipX_ole_0_combined
  simp_alive_peephole
  sorry
def test22_recipX_ogt_0_combined := [llvmfunc|
  llvm.func @test22_recipX_ogt_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_test22_recipX_ogt_0   : test22_recipX_ogt_0_before  ⊑  test22_recipX_ogt_0_combined := by
  unfold test22_recipX_ogt_0_before test22_recipX_ogt_0_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_test22_recipX_ogt_0   : test22_recipX_ogt_0_before  ⊑  test22_recipX_ogt_0_combined := by
  unfold test22_recipX_ogt_0_before test22_recipX_ogt_0_combined
  simp_alive_peephole
  sorry
def test23_recipX_oge_0_combined := [llvmfunc|
  llvm.func @test23_recipX_oge_0(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ole" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_test23_recipX_oge_0   : test23_recipX_oge_0_before  ⊑  test23_recipX_oge_0_combined := by
  unfold test23_recipX_oge_0_before test23_recipX_oge_0_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_test23_recipX_oge_0   : test23_recipX_oge_0_before  ⊑  test23_recipX_oge_0_combined := by
  unfold test23_recipX_oge_0_before test23_recipX_oge_0_combined
  simp_alive_peephole
  sorry
def test24_recipX_noninf_cmp_combined := [llvmfunc|
  llvm.func @test24_recipX_noninf_cmp(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_test24_recipX_noninf_cmp   : test24_recipX_noninf_cmp_before  ⊑  test24_recipX_noninf_cmp_combined := by
  unfold test24_recipX_noninf_cmp_before test24_recipX_noninf_cmp_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ogt" %2, %1 : f32
    llvm.return %3 : i1
  }]

theorem inst_combine_test24_recipX_noninf_cmp   : test24_recipX_noninf_cmp_before  ⊑  test24_recipX_noninf_cmp_combined := by
  unfold test24_recipX_noninf_cmp_before test24_recipX_noninf_cmp_combined
  simp_alive_peephole
  sorry
def test25_recipX_noninf_div_combined := [llvmfunc|
  llvm.func @test25_recipX_noninf_div(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  : f32
    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_test25_recipX_noninf_div   : test25_recipX_noninf_div_before  ⊑  test25_recipX_noninf_div_combined := by
  unfold test25_recipX_noninf_div_before test25_recipX_noninf_div_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i1
  }]

theorem inst_combine_test25_recipX_noninf_div   : test25_recipX_noninf_div_before  ⊑  test25_recipX_noninf_div_combined := by
  unfold test25_recipX_noninf_div_before test25_recipX_noninf_div_combined
  simp_alive_peephole
  sorry
def test26_recipX_unorderd_combined := [llvmfunc|
  llvm.func @test26_recipX_unorderd(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_test26_recipX_unorderd   : test26_recipX_unorderd_before  ⊑  test26_recipX_unorderd_combined := by
  unfold test26_recipX_unorderd_before test26_recipX_unorderd_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ugt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_test26_recipX_unorderd   : test26_recipX_unorderd_before  ⊑  test26_recipX_unorderd_combined := by
  unfold test26_recipX_unorderd_before test26_recipX_unorderd_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i1
  }]

theorem inst_combine_test26_recipX_unorderd   : test26_recipX_unorderd_before  ⊑  test26_recipX_unorderd_combined := by
  unfold test26_recipX_unorderd_before test26_recipX_unorderd_combined
  simp_alive_peephole
  sorry
def test27_recipX_gt_vecsplat_combined := [llvmfunc|
  llvm.func @test27_recipX_gt_vecsplat(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "olt" %arg0, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_test27_recipX_gt_vecsplat   : test27_recipX_gt_vecsplat_before  ⊑  test27_recipX_gt_vecsplat_combined := by
  unfold test27_recipX_gt_vecsplat_before test27_recipX_gt_vecsplat_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test27_recipX_gt_vecsplat   : test27_recipX_gt_vecsplat_before  ⊑  test27_recipX_gt_vecsplat_combined := by
  unfold test27_recipX_gt_vecsplat_before test27_recipX_gt_vecsplat_combined
  simp_alive_peephole
  sorry
def is_signbit_set_combined := [llvmfunc|
  llvm.func @is_signbit_set(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : f64 to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    llvm.return %2 : i1
  }]

theorem inst_combine_is_signbit_set   : is_signbit_set_before  ⊑  is_signbit_set_combined := by
  unfold is_signbit_set_before is_signbit_set_combined
  simp_alive_peephole
  sorry
def is_signbit_set_1_combined := [llvmfunc|
  llvm.func @is_signbit_set_1(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ult" %2, %1 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_is_signbit_set_1   : is_signbit_set_1_before  ⊑  is_signbit_set_1_combined := by
  unfold is_signbit_set_1_before is_signbit_set_1_combined
  simp_alive_peephole
  sorry
def is_signbit_set_2_combined := [llvmfunc|
  llvm.func @is_signbit_set_2(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ole" %2, %1 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_is_signbit_set_2   : is_signbit_set_2_before  ⊑  is_signbit_set_2_combined := by
  unfold is_signbit_set_2_before is_signbit_set_2_combined
  simp_alive_peephole
  sorry
def is_signbit_set_3_combined := [llvmfunc|
  llvm.func @is_signbit_set_3(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ule" %2, %1 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_is_signbit_set_3   : is_signbit_set_3_before  ⊑  is_signbit_set_3_combined := by
  unfold is_signbit_set_3_before is_signbit_set_3_combined
  simp_alive_peephole
  sorry
def is_signbit_set_anyzero_combined := [llvmfunc|
  llvm.func @is_signbit_set_anyzero(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.bitcast %arg0 : vector<2xf64> to vector<2xi64>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_is_signbit_set_anyzero   : is_signbit_set_anyzero_before  ⊑  is_signbit_set_anyzero_combined := by
  unfold is_signbit_set_anyzero_before is_signbit_set_anyzero_combined
  simp_alive_peephole
  sorry
def is_signbit_clear_combined := [llvmfunc|
  llvm.func @is_signbit_clear(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ogt" %2, %1 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_is_signbit_clear   : is_signbit_clear_before  ⊑  is_signbit_clear_combined := by
  unfold is_signbit_clear_before is_signbit_clear_combined
  simp_alive_peephole
  sorry
def is_signbit_clear_1_combined := [llvmfunc|
  llvm.func @is_signbit_clear_1(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ugt" %2, %1 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_is_signbit_clear_1   : is_signbit_clear_1_before  ⊑  is_signbit_clear_1_combined := by
  unfold is_signbit_clear_1_before is_signbit_clear_1_combined
  simp_alive_peephole
  sorry
def is_signbit_clear_2_combined := [llvmfunc|
  llvm.func @is_signbit_clear_2(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "oge" %2, %1 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_is_signbit_clear_2   : is_signbit_clear_2_before  ⊑  is_signbit_clear_2_combined := by
  unfold is_signbit_clear_2_before is_signbit_clear_2_combined
  simp_alive_peephole
  sorry
def is_signbit_clear_3_combined := [llvmfunc|
  llvm.func @is_signbit_clear_3(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "uge" %2, %1 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_is_signbit_clear_3   : is_signbit_clear_3_before  ⊑  is_signbit_clear_3_combined := by
  unfold is_signbit_clear_3_before is_signbit_clear_3_combined
  simp_alive_peephole
  sorry
def is_signbit_set_extra_use_combined := [llvmfunc|
  llvm.func @is_signbit_set_extra_use(%arg0: f64, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    llvm.store %2, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

theorem inst_combine_is_signbit_set_extra_use   : is_signbit_set_extra_use_before  ⊑  is_signbit_set_extra_use_combined := by
  unfold is_signbit_set_extra_use_before is_signbit_set_extra_use_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "olt" %2, %1 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_is_signbit_set_extra_use   : is_signbit_set_extra_use_before  ⊑  is_signbit_set_extra_use_combined := by
  unfold is_signbit_set_extra_use_before is_signbit_set_extra_use_combined
  simp_alive_peephole
  sorry
def is_signbit_clear_nonzero_combined := [llvmfunc|
  llvm.func @is_signbit_clear_nonzero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.intr.copysign(%0, %arg0)  : (f64, f64) -> f64
    %3 = llvm.fcmp "ogt" %2, %1 : f64
    llvm.return %3 : i1
  }]

theorem inst_combine_is_signbit_clear_nonzero   : is_signbit_clear_nonzero_before  ⊑  is_signbit_clear_nonzero_combined := by
  unfold is_signbit_clear_nonzero_before is_signbit_clear_nonzero_combined
  simp_alive_peephole
  sorry
def is_signbit_set_simplify_zero_combined := [llvmfunc|
  llvm.func @is_signbit_set_simplify_zero(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_is_signbit_set_simplify_zero   : is_signbit_set_simplify_zero_before  ⊑  is_signbit_set_simplify_zero_combined := by
  unfold is_signbit_set_simplify_zero_before is_signbit_set_simplify_zero_combined
  simp_alive_peephole
  sorry
def is_signbit_set_simplify_nan_combined := [llvmfunc|
  llvm.func @is_signbit_set_simplify_nan(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_is_signbit_set_simplify_nan   : is_signbit_set_simplify_nan_before  ⊑  is_signbit_set_simplify_nan_combined := by
  unfold is_signbit_set_simplify_nan_before is_signbit_set_simplify_nan_combined
  simp_alive_peephole
  sorry
def lossy_oeq_combined := [llvmfunc|
  llvm.func @lossy_oeq(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_lossy_oeq   : lossy_oeq_before  ⊑  lossy_oeq_combined := by
  unfold lossy_oeq_before lossy_oeq_combined
  simp_alive_peephole
  sorry
def lossy_one_combined := [llvmfunc|
  llvm.func @lossy_one(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fpext %arg0 : f32 to f64
    llvm.store %1, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

theorem inst_combine_lossy_one   : lossy_one_before  ⊑  lossy_one_combined := by
  unfold lossy_one_before lossy_one_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "ord" %arg0, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_lossy_one   : lossy_one_before  ⊑  lossy_one_combined := by
  unfold lossy_one_before lossy_one_combined
  simp_alive_peephole
  sorry
def lossy_ueq_combined := [llvmfunc|
  llvm.func @lossy_ueq(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uno" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_lossy_ueq   : lossy_ueq_before  ⊑  lossy_ueq_combined := by
  unfold lossy_ueq_before lossy_ueq_combined
  simp_alive_peephole
  sorry
def lossy_une_combined := [llvmfunc|
  llvm.func @lossy_une(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_lossy_une   : lossy_une_before  ⊑  lossy_une_combined := by
  unfold lossy_une_before lossy_une_combined
  simp_alive_peephole
  sorry
def lossy_ogt_combined := [llvmfunc|
  llvm.func @lossy_ogt(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fcmp "ogt" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_lossy_ogt   : lossy_ogt_before  ⊑  lossy_ogt_combined := by
  unfold lossy_ogt_before lossy_ogt_combined
  simp_alive_peephole
  sorry
def lossy_oge_combined := [llvmfunc|
  llvm.func @lossy_oge(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    llvm.store %1, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

theorem inst_combine_lossy_oge   : lossy_oge_before  ⊑  lossy_oge_combined := by
  unfold lossy_oge_before lossy_oge_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "oge" %1, %0 : f64
    llvm.return %2 : i1
  }]

theorem inst_combine_lossy_oge   : lossy_oge_before  ⊑  lossy_oge_combined := by
  unfold lossy_oge_before lossy_oge_combined
  simp_alive_peephole
  sorry
def lossy_olt_combined := [llvmfunc|
  llvm.func @lossy_olt(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "olt" %1, %0 : f64
    llvm.return %2 : i1
  }]

theorem inst_combine_lossy_olt   : lossy_olt_before  ⊑  lossy_olt_combined := by
  unfold lossy_olt_before lossy_olt_combined
  simp_alive_peephole
  sorry
def lossy_ole_combined := [llvmfunc|
  llvm.func @lossy_ole(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_lossy_ole   : lossy_ole_before  ⊑  lossy_ole_combined := by
  unfold lossy_ole_before lossy_ole_combined
  simp_alive_peephole
  sorry
def lossy_ugt_combined := [llvmfunc|
  llvm.func @lossy_ugt(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.000000e-01> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fcmp "ugt" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_lossy_ugt   : lossy_ugt_before  ⊑  lossy_ugt_combined := by
  unfold lossy_ugt_before lossy_ugt_combined
  simp_alive_peephole
  sorry
def lossy_uge_combined := [llvmfunc|
  llvm.func @lossy_uge(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    llvm.store %1, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

theorem inst_combine_lossy_uge   : lossy_uge_before  ⊑  lossy_uge_combined := by
  unfold lossy_uge_before lossy_uge_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "uge" %1, %0 : f64
    llvm.return %2 : i1
  }]

theorem inst_combine_lossy_uge   : lossy_uge_before  ⊑  lossy_uge_combined := by
  unfold lossy_uge_before lossy_uge_combined
  simp_alive_peephole
  sorry
def lossy_ult_combined := [llvmfunc|
  llvm.func @lossy_ult(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(6.553600e+04 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fcmp "ult" %1, %0 : f64
    llvm.return %2 : i1
  }]

theorem inst_combine_lossy_ult   : lossy_ult_before  ⊑  lossy_ult_combined := by
  unfold lossy_ult_before lossy_ult_combined
  simp_alive_peephole
  sorry
def lossy_ule_combined := [llvmfunc|
  llvm.func @lossy_ule(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(2.049000e+03 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fcmp "ule" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_lossy_ule   : lossy_ule_before  ⊑  lossy_ule_combined := by
  unfold lossy_ule_before lossy_ule_combined
  simp_alive_peephole
  sorry
def lossy_ord_combined := [llvmfunc|
  llvm.func @lossy_ord(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_lossy_ord   : lossy_ord_before  ⊑  lossy_ord_combined := by
  unfold lossy_ord_before lossy_ord_combined
  simp_alive_peephole
  sorry
def lossy_uno_combined := [llvmfunc|
  llvm.func @lossy_uno(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uno" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_lossy_uno   : lossy_uno_before  ⊑  lossy_uno_combined := by
  unfold lossy_uno_before lossy_uno_combined
  simp_alive_peephole
  sorry
def fneg_oeq_combined := [llvmfunc|
  llvm.func @fneg_oeq(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_oeq   : fneg_oeq_before  ⊑  fneg_oeq_combined := by
  unfold fneg_oeq_before fneg_oeq_combined
  simp_alive_peephole
  sorry
def fneg_ogt_combined := [llvmfunc|
  llvm.func @fneg_ogt(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_fneg_ogt   : fneg_ogt_before  ⊑  fneg_ogt_combined := by
  unfold fneg_ogt_before fneg_ogt_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_ogt   : fneg_ogt_before  ⊑  fneg_ogt_combined := by
  unfold fneg_ogt_before fneg_ogt_combined
  simp_alive_peephole
  sorry
def fneg_oge_combined := [llvmfunc|
  llvm.func @fneg_oge(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ole" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fneg_oge   : fneg_oge_before  ⊑  fneg_oge_combined := by
  unfold fneg_oge_before fneg_oge_combined
  simp_alive_peephole
  sorry
def fneg_olt_combined := [llvmfunc|
  llvm.func @fneg_olt(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fneg %arg0  : f32
    llvm.store %1, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_fneg_olt   : fneg_olt_before  ⊑  fneg_olt_combined := by
  unfold fneg_olt_before fneg_olt_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_olt   : fneg_olt_before  ⊑  fneg_olt_combined := by
  unfold fneg_olt_before fneg_olt_combined
  simp_alive_peephole
  sorry
def fneg_ole_combined := [llvmfunc|
  llvm.func @fneg_ole(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

theorem inst_combine_fneg_ole   : fneg_ole_before  ⊑  fneg_ole_combined := by
  unfold fneg_ole_before fneg_ole_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_ole   : fneg_ole_before  ⊑  fneg_ole_combined := by
  unfold fneg_ole_before fneg_ole_combined
  simp_alive_peephole
  sorry
def fneg_one_combined := [llvmfunc|
  llvm.func @fneg_one(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fneg_one   : fneg_one_before  ⊑  fneg_one_combined := by
  unfold fneg_one_before fneg_one_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_one   : fneg_one_before  ⊑  fneg_one_combined := by
  unfold fneg_one_before fneg_one_combined
  simp_alive_peephole
  sorry
def fneg_ord_combined := [llvmfunc|
  llvm.func @fneg_ord(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_fneg_ord   : fneg_ord_before  ⊑  fneg_ord_combined := by
  unfold fneg_ord_before fneg_ord_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_ord   : fneg_ord_before  ⊑  fneg_ord_combined := by
  unfold fneg_ord_before fneg_ord_combined
  simp_alive_peephole
  sorry
def fneg_uno_combined := [llvmfunc|
  llvm.func @fneg_uno(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uno" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_uno   : fneg_uno_before  ⊑  fneg_uno_combined := by
  unfold fneg_uno_before fneg_uno_combined
  simp_alive_peephole
  sorry
def fneg_ueq_combined := [llvmfunc|
  llvm.func @fneg_ueq(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ueq" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_fneg_ueq   : fneg_ueq_before  ⊑  fneg_ueq_combined := by
  unfold fneg_ueq_before fneg_ueq_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_ueq   : fneg_ueq_before  ⊑  fneg_ueq_combined := by
  unfold fneg_ueq_before fneg_ueq_combined
  simp_alive_peephole
  sorry
def fneg_ugt_combined := [llvmfunc|
  llvm.func @fneg_ugt(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "ult" %arg0, %1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fneg_ugt   : fneg_ugt_before  ⊑  fneg_ugt_combined := by
  unfold fneg_ugt_before fneg_ugt_combined
  simp_alive_peephole
  sorry
def fneg_uge_combined := [llvmfunc|
  llvm.func @fneg_uge(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fneg %arg0  : f32
    llvm.store %1, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_fneg_uge   : fneg_uge_before  ⊑  fneg_uge_combined := by
  unfold fneg_uge_before fneg_uge_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fcmp "ule" %arg0, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_uge   : fneg_uge_before  ⊑  fneg_uge_combined := by
  unfold fneg_uge_before fneg_uge_combined
  simp_alive_peephole
  sorry
def fneg_ult_combined := [llvmfunc|
  llvm.func @fneg_ult(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ugt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

theorem inst_combine_fneg_ult   : fneg_ult_before  ⊑  fneg_ult_combined := by
  unfold fneg_ult_before fneg_ult_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_ult   : fneg_ult_before  ⊑  fneg_ult_combined := by
  unfold fneg_ult_before fneg_ult_combined
  simp_alive_peephole
  sorry
def fneg_ule_combined := [llvmfunc|
  llvm.func @fneg_ule(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "uge" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fneg_ule   : fneg_ule_before  ⊑  fneg_ule_combined := by
  unfold fneg_ule_before fneg_ule_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_ule   : fneg_ule_before  ⊑  fneg_ule_combined := by
  unfold fneg_ule_before fneg_ule_combined
  simp_alive_peephole
  sorry
def fneg_une_combined := [llvmfunc|
  llvm.func @fneg_une(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_fneg_une   : fneg_une_before  ⊑  fneg_une_combined := by
  unfold fneg_une_before fneg_une_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i1
  }]

theorem inst_combine_fneg_une   : fneg_une_before  ⊑  fneg_une_combined := by
  unfold fneg_une_before fneg_une_combined
  simp_alive_peephole
  sorry
def fneg_oeq_swap_combined := [llvmfunc|
  llvm.func @fneg_oeq_swap(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_oeq_swap   : fneg_oeq_swap_before  ⊑  fneg_oeq_swap_combined := by
  unfold fneg_oeq_swap_before fneg_oeq_swap_combined
  simp_alive_peephole
  sorry
def fneg_ogt_swap_combined := [llvmfunc|
  llvm.func @fneg_ogt_swap(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fadd %arg0, %arg0  : f16
    %2 = llvm.fcmp "ogt" %1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_fneg_ogt_swap   : fneg_ogt_swap_before  ⊑  fneg_ogt_swap_combined := by
  unfold fneg_ogt_swap_before fneg_ogt_swap_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_ogt_swap   : fneg_ogt_swap_before  ⊑  fneg_ogt_swap_combined := by
  unfold fneg_ogt_swap_before fneg_ogt_swap_combined
  simp_alive_peephole
  sorry
def fneg_oge_swap_combined := [llvmfunc|
  llvm.func @fneg_oge_swap(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fadd %arg0, %arg0  : vector<2xf32>
    %3 = llvm.fcmp "oge" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_fneg_oge_swap   : fneg_oge_swap_before  ⊑  fneg_oge_swap_combined := by
  unfold fneg_oge_swap_before fneg_oge_swap_combined
  simp_alive_peephole
  sorry
def fneg_olt_swap_combined := [llvmfunc|
  llvm.func @fneg_olt_swap(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fneg %1  : f32
    llvm.store %2, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_fneg_olt_swap   : fneg_olt_swap_before  ⊑  fneg_olt_swap_combined := by
  unfold fneg_olt_swap_before fneg_olt_swap_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "olt" %1, %0 : f32
    llvm.return %3 : i1
  }]

theorem inst_combine_fneg_olt_swap   : fneg_olt_swap_before  ⊑  fneg_olt_swap_combined := by
  unfold fneg_olt_swap_before fneg_olt_swap_combined
  simp_alive_peephole
  sorry
def fneg_ole_swap_combined := [llvmfunc|
  llvm.func @fneg_ole_swap(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fcmp "ole" %1, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

theorem inst_combine_fneg_ole_swap   : fneg_ole_swap_before  ⊑  fneg_ole_swap_combined := by
  unfold fneg_ole_swap_before fneg_ole_swap_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_ole_swap   : fneg_ole_swap_before  ⊑  fneg_ole_swap_combined := by
  unfold fneg_ole_swap_before fneg_ole_swap_combined
  simp_alive_peephole
  sorry
def fneg_one_swap_combined := [llvmfunc|
  llvm.func @fneg_one_swap(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fcmp "one" %1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fneg_one_swap   : fneg_one_swap_before  ⊑  fneg_one_swap_combined := by
  unfold fneg_one_swap_before fneg_one_swap_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_one_swap   : fneg_one_swap_before  ⊑  fneg_one_swap_combined := by
  unfold fneg_one_swap_before fneg_one_swap_combined
  simp_alive_peephole
  sorry
def fneg_ord_swap_combined := [llvmfunc|
  llvm.func @fneg_ord_swap(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fcmp "ord" %1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_fneg_ord_swap   : fneg_ord_swap_before  ⊑  fneg_ord_swap_combined := by
  unfold fneg_ord_swap_before fneg_ord_swap_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_ord_swap   : fneg_ord_swap_before  ⊑  fneg_ord_swap_combined := by
  unfold fneg_ord_swap_before fneg_ord_swap_combined
  simp_alive_peephole
  sorry
def fneg_uno_swap_combined := [llvmfunc|
  llvm.func @fneg_uno_swap(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fcmp "uno" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_uno_swap   : fneg_uno_swap_before  ⊑  fneg_uno_swap_combined := by
  unfold fneg_uno_swap_before fneg_uno_swap_combined
  simp_alive_peephole
  sorry
def fneg_ueq_swap_combined := [llvmfunc|
  llvm.func @fneg_ueq_swap(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fadd %arg0, %arg0  : f16
    %2 = llvm.fcmp "ueq" %1, %0 {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_fneg_ueq_swap   : fneg_ueq_swap_before  ⊑  fneg_ueq_swap_combined := by
  unfold fneg_ueq_swap_before fneg_ueq_swap_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_ueq_swap   : fneg_ueq_swap_before  ⊑  fneg_ueq_swap_combined := by
  unfold fneg_ueq_swap_before fneg_ueq_swap_combined
  simp_alive_peephole
  sorry
def fneg_ugt_swap_combined := [llvmfunc|
  llvm.func @fneg_ugt_swap(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fadd %arg0, %arg0  : vector<2xf32>
    %3 = llvm.fcmp "ugt" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_fneg_ugt_swap   : fneg_ugt_swap_before  ⊑  fneg_ugt_swap_combined := by
  unfold fneg_ugt_swap_before fneg_ugt_swap_combined
  simp_alive_peephole
  sorry
def fneg_uge_swap_combined := [llvmfunc|
  llvm.func @fneg_uge_swap(%arg0: f32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fneg %1  : f32
    llvm.store %2, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_fneg_uge_swap   : fneg_uge_swap_before  ⊑  fneg_uge_swap_combined := by
  unfold fneg_uge_swap_before fneg_uge_swap_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "uge" %1, %0 : f32
    llvm.return %3 : i1
  }]

theorem inst_combine_fneg_uge_swap   : fneg_uge_swap_before  ⊑  fneg_uge_swap_combined := by
  unfold fneg_uge_swap_before fneg_uge_swap_combined
  simp_alive_peephole
  sorry
def fneg_ult_swap_combined := [llvmfunc|
  llvm.func @fneg_ult_swap(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fcmp "ult" %1, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

theorem inst_combine_fneg_ult_swap   : fneg_ult_swap_before  ⊑  fneg_ult_swap_combined := by
  unfold fneg_ult_swap_before fneg_ult_swap_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_ult_swap   : fneg_ult_swap_before  ⊑  fneg_ult_swap_combined := by
  unfold fneg_ult_swap_before fneg_ult_swap_combined
  simp_alive_peephole
  sorry
def fneg_ule_swap_combined := [llvmfunc|
  llvm.func @fneg_ule_swap(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fcmp "ule" %1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fneg_ule_swap   : fneg_ule_swap_before  ⊑  fneg_ule_swap_combined := by
  unfold fneg_ule_swap_before fneg_ule_swap_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_ule_swap   : fneg_ule_swap_before  ⊑  fneg_ule_swap_combined := by
  unfold fneg_ule_swap_before fneg_ule_swap_combined
  simp_alive_peephole
  sorry
def fneg_une_swap_combined := [llvmfunc|
  llvm.func @fneg_une_swap(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %arg0  : f32
    %2 = llvm.fcmp "une" %1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_fneg_une_swap   : fneg_une_swap_before  ⊑  fneg_une_swap_combined := by
  unfold fneg_une_swap_before fneg_une_swap_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fneg_une_swap   : fneg_une_swap_before  ⊑  fneg_une_swap_combined := by
  unfold fneg_une_swap_before fneg_une_swap_combined
  simp_alive_peephole
  sorry
def bitcast_eq0_combined := [llvmfunc|
  llvm.func @bitcast_eq0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_bitcast_eq0   : bitcast_eq0_before  ⊑  bitcast_eq0_combined := by
  unfold bitcast_eq0_before bitcast_eq0_combined
  simp_alive_peephole
  sorry
def bitcast_ne0_combined := [llvmfunc|
  llvm.func @bitcast_ne0(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_bitcast_ne0   : bitcast_ne0_before  ⊑  bitcast_ne0_combined := by
  unfold bitcast_ne0_before bitcast_ne0_combined
  simp_alive_peephole
  sorry
def bitcast_eq0_use_combined := [llvmfunc|
  llvm.func @bitcast_eq0_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : i32 to f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_bitcast_eq0_use   : bitcast_eq0_use_before  ⊑  bitcast_eq0_use_combined := by
  unfold bitcast_eq0_use_before bitcast_eq0_use_combined
  simp_alive_peephole
  sorry
def bitcast_nonint_eq0_combined := [llvmfunc|
  llvm.func @bitcast_nonint_eq0(%arg0: vector<2xi16>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : vector<2xi16> to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_bitcast_nonint_eq0   : bitcast_nonint_eq0_before  ⊑  bitcast_nonint_eq0_combined := by
  unfold bitcast_nonint_eq0_before bitcast_nonint_eq0_combined
  simp_alive_peephole
  sorry
def bitcast_gt0_combined := [llvmfunc|
  llvm.func @bitcast_gt0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.bitcast %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_bitcast_gt0   : bitcast_gt0_before  ⊑  bitcast_gt0_combined := by
  unfold bitcast_gt0_before bitcast_gt0_combined
  simp_alive_peephole
  sorry
def bitcast_1vec_eq0_combined := [llvmfunc|
  llvm.func @bitcast_1vec_eq0(%arg0: i32) -> vector<1xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<1xf32>) : vector<1xf32>
    %2 = llvm.bitcast %arg0 : i32 to vector<1xf32>
    %3 = llvm.fcmp "oeq" %2, %1 : vector<1xf32>
    llvm.return %3 : vector<1xi1>
  }]

theorem inst_combine_bitcast_1vec_eq0   : bitcast_1vec_eq0_before  ⊑  bitcast_1vec_eq0_combined := by
  unfold bitcast_1vec_eq0_before bitcast_1vec_eq0_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_ugt_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ugt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_ugt   : fcmp_fadd_zero_ugt_before  ⊑  fcmp_fadd_zero_ugt_combined := by
  unfold fcmp_fadd_zero_ugt_before fcmp_fadd_zero_ugt_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_uge_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_uge(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "uge" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_uge   : fcmp_fadd_zero_uge_before  ⊑  fcmp_fadd_zero_uge_combined := by
  unfold fcmp_fadd_zero_uge_before fcmp_fadd_zero_uge_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_ogt_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ogt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ogt" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_ogt   : fcmp_fadd_zero_ogt_before  ⊑  fcmp_fadd_zero_ogt_combined := by
  unfold fcmp_fadd_zero_ogt_before fcmp_fadd_zero_ogt_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_oge_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_oge(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "oge" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_oge   : fcmp_fadd_zero_oge_before  ⊑  fcmp_fadd_zero_oge_combined := by
  unfold fcmp_fadd_zero_oge_before fcmp_fadd_zero_oge_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_ult_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ult(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ult" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_ult   : fcmp_fadd_zero_ult_before  ⊑  fcmp_fadd_zero_ult_combined := by
  unfold fcmp_fadd_zero_ult_before fcmp_fadd_zero_ult_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_ule_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ule(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ule" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_ule   : fcmp_fadd_zero_ule_before  ⊑  fcmp_fadd_zero_ule_combined := by
  unfold fcmp_fadd_zero_ule_before fcmp_fadd_zero_ule_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_olt_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_olt(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "olt" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_olt   : fcmp_fadd_zero_olt_before  ⊑  fcmp_fadd_zero_olt_combined := by
  unfold fcmp_fadd_zero_olt_before fcmp_fadd_zero_olt_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_ole_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ole(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ole" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_ole   : fcmp_fadd_zero_ole_before  ⊑  fcmp_fadd_zero_ole_combined := by
  unfold fcmp_fadd_zero_ole_before fcmp_fadd_zero_ole_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_oeq_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_oeq(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "oeq" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_oeq   : fcmp_fadd_zero_oeq_before  ⊑  fcmp_fadd_zero_oeq_combined := by
  unfold fcmp_fadd_zero_oeq_before fcmp_fadd_zero_oeq_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_one_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_one(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "one" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_one   : fcmp_fadd_zero_one_before  ⊑  fcmp_fadd_zero_one_combined := by
  unfold fcmp_fadd_zero_one_before fcmp_fadd_zero_one_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_ueq_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ueq(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ueq" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_ueq   : fcmp_fadd_zero_ueq_before  ⊑  fcmp_fadd_zero_ueq_combined := by
  unfold fcmp_fadd_zero_ueq_before fcmp_fadd_zero_ueq_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_une_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_une(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "une" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_une   : fcmp_fadd_zero_une_before  ⊑  fcmp_fadd_zero_une_combined := by
  unfold fcmp_fadd_zero_une_before fcmp_fadd_zero_une_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_ord_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_ord(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ord" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_ord   : fcmp_fadd_zero_ord_before  ⊑  fcmp_fadd_zero_ord_combined := by
  unfold fcmp_fadd_zero_ord_before fcmp_fadd_zero_ord_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_uno_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_uno(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "uno" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_uno   : fcmp_fadd_zero_uno_before  ⊑  fcmp_fadd_zero_uno_combined := by
  unfold fcmp_fadd_zero_uno_before fcmp_fadd_zero_uno_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_neg_zero_combined := [llvmfunc|
  llvm.func @fcmp_fadd_neg_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f32
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_fadd_neg_zero   : fcmp_fadd_neg_zero_before  ⊑  fcmp_fadd_neg_zero_combined := by
  unfold fcmp_fadd_neg_zero_before fcmp_fadd_neg_zero_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_switched_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_switched(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg1, %0  : f32
    %2 = llvm.fcmp "ult" %1, %arg0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fadd_zero_switched   : fcmp_fadd_zero_switched_before  ⊑  fcmp_fadd_zero_switched_combined := by
  unfold fcmp_fadd_zero_switched_before fcmp_fadd_zero_switched_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_zero_vec_combined := [llvmfunc|
  llvm.func @fcmp_fadd_zero_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %0  : vector<2xf32>
    %2 = llvm.fcmp "ugt" %1, %arg1 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_fcmp_fadd_zero_vec   : fcmp_fadd_zero_vec_before  ⊑  fcmp_fadd_zero_vec_combined := by
  unfold fcmp_fadd_zero_vec_before fcmp_fadd_zero_vec_combined
  simp_alive_peephole
  sorry
def fcmp_fast_fadd_fast_zero_combined := [llvmfunc|
  llvm.func @fcmp_fast_fadd_fast_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fcmp_fast_fadd_fast_zero   : fcmp_fast_fadd_fast_zero_before  ⊑  fcmp_fast_fadd_fast_zero_combined := by
  unfold fcmp_fast_fadd_fast_zero_before fcmp_fast_fadd_fast_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_fast_fadd_fast_zero   : fcmp_fast_fadd_fast_zero_before  ⊑  fcmp_fast_fadd_fast_zero_combined := by
  unfold fcmp_fast_fadd_fast_zero_before fcmp_fast_fadd_fast_zero_combined
  simp_alive_peephole
  sorry
def fcmp_fast_fadd_zero_combined := [llvmfunc|
  llvm.func @fcmp_fast_fadd_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    %2 = llvm.fcmp "ugt" %1, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

theorem inst_combine_fcmp_fast_fadd_zero   : fcmp_fast_fadd_zero_before  ⊑  fcmp_fast_fadd_zero_combined := by
  unfold fcmp_fast_fadd_zero_before fcmp_fast_fadd_zero_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_fast_fadd_zero   : fcmp_fast_fadd_zero_before  ⊑  fcmp_fast_fadd_zero_combined := by
  unfold fcmp_fast_fadd_zero_before fcmp_fast_fadd_zero_combined
  simp_alive_peephole
  sorry
def fcmp_fadd_fast_zero_combined := [llvmfunc|
  llvm.func @fcmp_fadd_fast_zero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f32
    llvm.return %0 : i1
  }]

theorem inst_combine_fcmp_fadd_fast_zero   : fcmp_fadd_fast_zero_before  ⊑  fcmp_fadd_fast_zero_combined := by
  unfold fcmp_fadd_fast_zero_before fcmp_fadd_fast_zero_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_sel_x_negx_combined := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "ueq" %3, %0 : f32
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_ueq_sel_x_negx   : fcmp_ueq_sel_x_negx_before  ⊑  fcmp_ueq_sel_x_negx_combined := by
  unfold fcmp_ueq_sel_x_negx_before fcmp_ueq_sel_x_negx_combined
  simp_alive_peephole
  sorry
def fcmp_une_sel_x_negx_combined := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "une" %3, %0 : f32
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_une_sel_x_negx   : fcmp_une_sel_x_negx_before  ⊑  fcmp_une_sel_x_negx_combined := by
  unfold fcmp_une_sel_x_negx_before fcmp_une_sel_x_negx_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_sel_x_negx_combined := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "oeq" %3, %0 : f32
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_oeq_sel_x_negx   : fcmp_oeq_sel_x_negx_before  ⊑  fcmp_oeq_sel_x_negx_combined := by
  unfold fcmp_oeq_sel_x_negx_before fcmp_oeq_sel_x_negx_combined
  simp_alive_peephole
  sorry
def fcmp_one_sel_x_negx_combined := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "one" %3, %0 : f32
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_one_sel_x_negx   : fcmp_one_sel_x_negx_before  ⊑  fcmp_one_sel_x_negx_combined := by
  unfold fcmp_one_sel_x_negx_before fcmp_one_sel_x_negx_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_sel_x_negx_nzero_combined := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ueq" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "ueq" %3, %0 : f32
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_ueq_sel_x_negx_nzero   : fcmp_ueq_sel_x_negx_nzero_before  ⊑  fcmp_ueq_sel_x_negx_nzero_combined := by
  unfold fcmp_ueq_sel_x_negx_nzero_before fcmp_ueq_sel_x_negx_nzero_combined
  simp_alive_peephole
  sorry
def fcmp_une_sel_x_negx_nzero_combined := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "une" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "une" %3, %0 : f32
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_une_sel_x_negx_nzero   : fcmp_une_sel_x_negx_nzero_before  ⊑  fcmp_une_sel_x_negx_nzero_combined := by
  unfold fcmp_une_sel_x_negx_nzero_before fcmp_une_sel_x_negx_nzero_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_sel_x_negx_nzero_combined := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "oeq" %3, %0 : f32
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_oeq_sel_x_negx_nzero   : fcmp_oeq_sel_x_negx_nzero_before  ⊑  fcmp_oeq_sel_x_negx_nzero_combined := by
  unfold fcmp_oeq_sel_x_negx_nzero_before fcmp_oeq_sel_x_negx_nzero_combined
  simp_alive_peephole
  sorry
def fcmp_one_sel_x_negx_nzero_combined := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx_nzero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "one" %arg0, %0 : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.select %1, %arg0, %2 : i1, f32
    %4 = llvm.fcmp "one" %3, %0 : f32
    llvm.return %4 : i1
  }]

theorem inst_combine_fcmp_one_sel_x_negx_nzero   : fcmp_one_sel_x_negx_nzero_before  ⊑  fcmp_one_sel_x_negx_nzero_combined := by
  unfold fcmp_one_sel_x_negx_nzero_before fcmp_one_sel_x_negx_nzero_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_sel_x_negx_vec_combined := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "ueq" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "ueq" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ueq_sel_x_negx_vec   : fcmp_ueq_sel_x_negx_vec_before  ⊑  fcmp_ueq_sel_x_negx_vec_combined := by
  unfold fcmp_ueq_sel_x_negx_vec_before fcmp_ueq_sel_x_negx_vec_combined
  simp_alive_peephole
  sorry
def fcmp_une_sel_x_negx_vec_combined := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "une" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "une" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }]

theorem inst_combine_fcmp_une_sel_x_negx_vec   : fcmp_une_sel_x_negx_vec_before  ⊑  fcmp_une_sel_x_negx_vec_combined := by
  unfold fcmp_une_sel_x_negx_vec_before fcmp_une_sel_x_negx_vec_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_sel_x_negx_vec_combined := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "oeq" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }]

theorem inst_combine_fcmp_oeq_sel_x_negx_vec   : fcmp_oeq_sel_x_negx_vec_before  ⊑  fcmp_oeq_sel_x_negx_vec_combined := by
  unfold fcmp_oeq_sel_x_negx_vec_before fcmp_oeq_sel_x_negx_vec_combined
  simp_alive_peephole
  sorry
def fcmp_one_sel_x_negx_vec_combined := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx_vec(%arg0: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fcmp "one" %arg0, %1 : vector<8xf32>
    %3 = llvm.fneg %arg0  : vector<8xf32>
    %4 = llvm.select %2, %arg0, %3 : vector<8xi1>, vector<8xf32>
    %5 = llvm.fcmp "one" %4, %1 : vector<8xf32>
    llvm.return %5 : vector<8xi1>
  }]

theorem inst_combine_fcmp_one_sel_x_negx_vec   : fcmp_one_sel_x_negx_vec_before  ⊑  fcmp_one_sel_x_negx_vec_combined := by
  unfold fcmp_one_sel_x_negx_vec_before fcmp_one_sel_x_negx_vec_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fcmp "oeq" %3, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec   : fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_before  ⊑  fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_combined := by
  unfold fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_before fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec   : fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_before  ⊑  fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_combined := by
  unfold fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_before fcmp_oeq_sel_x_negx_with_any_fpzero_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fcmp "one" %3, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec   : fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_before  ⊑  fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_combined := by
  unfold fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_before fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec   : fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_before  ⊑  fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_combined := by
  unfold fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_before fcmp_one_sel_x_negx_with_any_fpzero_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fcmp "ueq" %3, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec   : fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_before  ⊑  fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_combined := by
  unfold fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_before fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec   : fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_before  ⊑  fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_combined := by
  unfold fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_before fcmp_ueq_sel_x_negx_with_any_fpzero_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fcmp "une" %3, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<2xf32>]

theorem inst_combine_fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec   : fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_before  ⊑  fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_combined := by
  unfold fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_before fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec   : fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_before  ⊑  fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_combined := by
  unfold fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_before fcmp_une_sel_x_negx_with_any_fpzero_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fcmp "oeq" %3, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

theorem inst_combine_fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec   : fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_before  ⊑  fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_combined := by
  unfold fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_before fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec   : fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_before  ⊑  fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_combined := by
  unfold fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_before fcmp_oeq_sel_x_negx_with_any_fpzero_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fcmp "one" %3, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

theorem inst_combine_fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec   : fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_before  ⊑  fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_combined := by
  unfold fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_before fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec   : fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_before  ⊑  fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_combined := by
  unfold fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_before fcmp_one_sel_x_negx_with_any_fpzero_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fcmp "ueq" %3, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

theorem inst_combine_fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec   : fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_before  ⊑  fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_combined := by
  unfold fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_before fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec   : fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_before  ⊑  fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_combined := by
  unfold fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_before fcmp_ueq_sel_x_negx_with_any_fpzero_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fneg %arg1  : vector<2xf32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fcmp "une" %3, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf32>]

theorem inst_combine_fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec   : fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_before  ⊑  fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_combined := by
  unfold fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_before fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec   : fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_before  ⊑  fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_combined := by
  unfold fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_before fcmp_une_sel_x_negx_with_any_fpzero_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_fsub_nnan_const_extra_use_combined := [llvmfunc|
  llvm.func @fcmp_ueq_fsub_nnan_const_extra_use(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fcmp_ueq_fsub_nnan_const_extra_use   : fcmp_ueq_fsub_nnan_const_extra_use_before  ⊑  fcmp_ueq_fsub_nnan_const_extra_use_combined := by
  unfold fcmp_ueq_fsub_nnan_const_extra_use_before fcmp_ueq_fsub_nnan_const_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fcmp "ueq" %1, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_fcmp_ueq_fsub_nnan_const_extra_use   : fcmp_ueq_fsub_nnan_const_extra_use_before  ⊑  fcmp_ueq_fsub_nnan_const_extra_use_combined := by
  unfold fcmp_ueq_fsub_nnan_const_extra_use_before fcmp_ueq_fsub_nnan_const_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_ueq_fsub_nnan_const_extra_use   : fcmp_ueq_fsub_nnan_const_extra_use_before  ⊑  fcmp_ueq_fsub_nnan_const_extra_use_combined := by
  unfold fcmp_ueq_fsub_nnan_const_extra_use_before fcmp_ueq_fsub_nnan_const_extra_use_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_fsub_ninf_const_extra_use_combined := [llvmfunc|
  llvm.func @fcmp_oeq_fsub_ninf_const_extra_use(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_fcmp_oeq_fsub_ninf_const_extra_use   : fcmp_oeq_fsub_ninf_const_extra_use_before  ⊑  fcmp_oeq_fsub_ninf_const_extra_use_combined := by
  unfold fcmp_oeq_fsub_ninf_const_extra_use_before fcmp_oeq_fsub_ninf_const_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fcmp "oeq" %1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_fcmp_oeq_fsub_ninf_const_extra_use   : fcmp_oeq_fsub_ninf_const_extra_use_before  ⊑  fcmp_oeq_fsub_ninf_const_extra_use_combined := by
  unfold fcmp_oeq_fsub_ninf_const_extra_use_before fcmp_oeq_fsub_ninf_const_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_oeq_fsub_ninf_const_extra_use   : fcmp_oeq_fsub_ninf_const_extra_use_before  ⊑  fcmp_oeq_fsub_ninf_const_extra_use_combined := by
  unfold fcmp_oeq_fsub_ninf_const_extra_use_before fcmp_oeq_fsub_ninf_const_extra_use_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_fsub_const_combined := [llvmfunc|
  llvm.func @fcmp_oeq_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_oeq_fsub_const   : fcmp_oeq_fsub_const_before  ⊑  fcmp_oeq_fsub_const_combined := by
  unfold fcmp_oeq_fsub_const_before fcmp_oeq_fsub_const_combined
  simp_alive_peephole
  sorry
def fcmp_oge_fsub_const_combined := [llvmfunc|
  llvm.func @fcmp_oge_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "oge" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_oge_fsub_const   : fcmp_oge_fsub_const_before  ⊑  fcmp_oge_fsub_const_combined := by
  unfold fcmp_oge_fsub_const_before fcmp_oge_fsub_const_combined
  simp_alive_peephole
  sorry
def fcmp_ole_fsub_const_combined := [llvmfunc|
  llvm.func @fcmp_ole_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_ole_fsub_const   : fcmp_ole_fsub_const_before  ⊑  fcmp_ole_fsub_const_combined := by
  unfold fcmp_ole_fsub_const_before fcmp_ole_fsub_const_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_fsub_const_combined := [llvmfunc|
  llvm.func @fcmp_ueq_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_ueq_fsub_const   : fcmp_ueq_fsub_const_before  ⊑  fcmp_ueq_fsub_const_combined := by
  unfold fcmp_ueq_fsub_const_before fcmp_ueq_fsub_const_combined
  simp_alive_peephole
  sorry
def fcmp_uge_fsub_const_combined := [llvmfunc|
  llvm.func @fcmp_uge_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "uge" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_uge_fsub_const   : fcmp_uge_fsub_const_before  ⊑  fcmp_uge_fsub_const_combined := by
  unfold fcmp_uge_fsub_const_before fcmp_uge_fsub_const_combined
  simp_alive_peephole
  sorry
def fcmp_ule_fsub_const_combined := [llvmfunc|
  llvm.func @fcmp_ule_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ule" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_ule_fsub_const   : fcmp_ule_fsub_const_before  ⊑  fcmp_ule_fsub_const_combined := by
  unfold fcmp_ule_fsub_const_before fcmp_ule_fsub_const_combined
  simp_alive_peephole
  sorry
def fcmp_ugt_fsub_const_combined := [llvmfunc|
  llvm.func @fcmp_ugt_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ugt" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_ugt_fsub_const   : fcmp_ugt_fsub_const_before  ⊑  fcmp_ugt_fsub_const_combined := by
  unfold fcmp_ugt_fsub_const_before fcmp_ugt_fsub_const_combined
  simp_alive_peephole
  sorry
def fcmp_ult_fsub_const_combined := [llvmfunc|
  llvm.func @fcmp_ult_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "ult" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_ult_fsub_const   : fcmp_ult_fsub_const_before  ⊑  fcmp_ult_fsub_const_combined := by
  unfold fcmp_ult_fsub_const_before fcmp_ult_fsub_const_combined
  simp_alive_peephole
  sorry
def fcmp_une_fsub_const_combined := [llvmfunc|
  llvm.func @fcmp_une_fsub_const(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_une_fsub_const   : fcmp_une_fsub_const_before  ⊑  fcmp_une_fsub_const_combined := by
  unfold fcmp_une_fsub_const_before fcmp_une_fsub_const_combined
  simp_alive_peephole
  sorry
def fcmp_uge_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_uge_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_uge_fsub_const_ninf_vec   : fcmp_uge_fsub_const_ninf_vec_before  ⊑  fcmp_uge_fsub_const_ninf_vec_combined := by
  unfold fcmp_uge_fsub_const_ninf_vec_before fcmp_uge_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_uge_fsub_const_ninf_vec   : fcmp_uge_fsub_const_ninf_vec_before  ⊑  fcmp_uge_fsub_const_ninf_vec_combined := by
  unfold fcmp_uge_fsub_const_ninf_vec_before fcmp_uge_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_uge_fsub_const_ninf_vec   : fcmp_uge_fsub_const_ninf_vec_before  ⊑  fcmp_uge_fsub_const_ninf_vec_combined := by
  unfold fcmp_uge_fsub_const_ninf_vec_before fcmp_uge_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ule_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_ule_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ule_fsub_const_ninf_vec   : fcmp_ule_fsub_const_ninf_vec_before  ⊑  fcmp_ule_fsub_const_ninf_vec_combined := by
  unfold fcmp_ule_fsub_const_ninf_vec_before fcmp_ule_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ule" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ule_fsub_const_ninf_vec   : fcmp_ule_fsub_const_ninf_vec_before  ⊑  fcmp_ule_fsub_const_ninf_vec_combined := by
  unfold fcmp_ule_fsub_const_ninf_vec_before fcmp_ule_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ule_fsub_const_ninf_vec   : fcmp_ule_fsub_const_ninf_vec_before  ⊑  fcmp_ule_fsub_const_ninf_vec_combined := by
  unfold fcmp_ule_fsub_const_ninf_vec_before fcmp_ule_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_ueq_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ueq_fsub_const_ninf_vec   : fcmp_ueq_fsub_const_ninf_vec_before  ⊑  fcmp_ueq_fsub_const_ninf_vec_combined := by
  unfold fcmp_ueq_fsub_const_ninf_vec_before fcmp_ueq_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ueq" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ueq_fsub_const_ninf_vec   : fcmp_ueq_fsub_const_ninf_vec_before  ⊑  fcmp_ueq_fsub_const_ninf_vec_combined := by
  unfold fcmp_ueq_fsub_const_ninf_vec_before fcmp_ueq_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ueq_fsub_const_ninf_vec   : fcmp_ueq_fsub_const_ninf_vec_before  ⊑  fcmp_ueq_fsub_const_ninf_vec_combined := by
  unfold fcmp_ueq_fsub_const_ninf_vec_before fcmp_ueq_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_oge_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_oge_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_oge_fsub_const_ninf_vec   : fcmp_oge_fsub_const_ninf_vec_before  ⊑  fcmp_oge_fsub_const_ninf_vec_combined := by
  unfold fcmp_oge_fsub_const_ninf_vec_before fcmp_oge_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "oge" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_oge_fsub_const_ninf_vec   : fcmp_oge_fsub_const_ninf_vec_before  ⊑  fcmp_oge_fsub_const_ninf_vec_combined := by
  unfold fcmp_oge_fsub_const_ninf_vec_before fcmp_oge_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_oge_fsub_const_ninf_vec   : fcmp_oge_fsub_const_ninf_vec_before  ⊑  fcmp_oge_fsub_const_ninf_vec_combined := by
  unfold fcmp_oge_fsub_const_ninf_vec_before fcmp_oge_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ole_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_ole_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ole_fsub_const_ninf_vec   : fcmp_ole_fsub_const_ninf_vec_before  ⊑  fcmp_ole_fsub_const_ninf_vec_combined := by
  unfold fcmp_ole_fsub_const_ninf_vec_before fcmp_ole_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ole_fsub_const_ninf_vec   : fcmp_ole_fsub_const_ninf_vec_before  ⊑  fcmp_ole_fsub_const_ninf_vec_combined := by
  unfold fcmp_ole_fsub_const_ninf_vec_before fcmp_ole_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ole_fsub_const_ninf_vec   : fcmp_ole_fsub_const_ninf_vec_before  ⊑  fcmp_ole_fsub_const_ninf_vec_combined := by
  unfold fcmp_ole_fsub_const_ninf_vec_before fcmp_ole_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_oeq_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_oeq_fsub_const_ninf_vec   : fcmp_oeq_fsub_const_ninf_vec_before  ⊑  fcmp_oeq_fsub_const_ninf_vec_combined := by
  unfold fcmp_oeq_fsub_const_ninf_vec_before fcmp_oeq_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "oeq" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_oeq_fsub_const_ninf_vec   : fcmp_oeq_fsub_const_ninf_vec_before  ⊑  fcmp_oeq_fsub_const_ninf_vec_combined := by
  unfold fcmp_oeq_fsub_const_ninf_vec_before fcmp_oeq_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_oeq_fsub_const_ninf_vec   : fcmp_oeq_fsub_const_ninf_vec_before  ⊑  fcmp_oeq_fsub_const_ninf_vec_combined := by
  unfold fcmp_oeq_fsub_const_ninf_vec_before fcmp_oeq_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ogt_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_ogt_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ogt_fsub_const_ninf_vec   : fcmp_ogt_fsub_const_ninf_vec_before  ⊑  fcmp_ogt_fsub_const_ninf_vec_combined := by
  unfold fcmp_ogt_fsub_const_ninf_vec_before fcmp_ogt_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ogt_fsub_const_ninf_vec   : fcmp_ogt_fsub_const_ninf_vec_before  ⊑  fcmp_ogt_fsub_const_ninf_vec_combined := by
  unfold fcmp_ogt_fsub_const_ninf_vec_before fcmp_ogt_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ogt_fsub_const_ninf_vec   : fcmp_ogt_fsub_const_ninf_vec_before  ⊑  fcmp_ogt_fsub_const_ninf_vec_combined := by
  unfold fcmp_ogt_fsub_const_ninf_vec_before fcmp_ogt_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_olt_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_olt_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_olt_fsub_const_ninf_vec   : fcmp_olt_fsub_const_ninf_vec_before  ⊑  fcmp_olt_fsub_const_ninf_vec_combined := by
  unfold fcmp_olt_fsub_const_ninf_vec_before fcmp_olt_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "olt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_olt_fsub_const_ninf_vec   : fcmp_olt_fsub_const_ninf_vec_before  ⊑  fcmp_olt_fsub_const_ninf_vec_combined := by
  unfold fcmp_olt_fsub_const_ninf_vec_before fcmp_olt_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_olt_fsub_const_ninf_vec   : fcmp_olt_fsub_const_ninf_vec_before  ⊑  fcmp_olt_fsub_const_ninf_vec_combined := by
  unfold fcmp_olt_fsub_const_ninf_vec_before fcmp_olt_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_one_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_one_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_one_fsub_const_ninf_vec   : fcmp_one_fsub_const_ninf_vec_before  ⊑  fcmp_one_fsub_const_ninf_vec_combined := by
  unfold fcmp_one_fsub_const_ninf_vec_before fcmp_one_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "one" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_one_fsub_const_ninf_vec   : fcmp_one_fsub_const_ninf_vec_before  ⊑  fcmp_one_fsub_const_ninf_vec_combined := by
  unfold fcmp_one_fsub_const_ninf_vec_before fcmp_one_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_one_fsub_const_ninf_vec   : fcmp_one_fsub_const_ninf_vec_before  ⊑  fcmp_one_fsub_const_ninf_vec_combined := by
  unfold fcmp_one_fsub_const_ninf_vec_before fcmp_one_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ugt_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_ugt_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ugt_fsub_const_ninf_vec   : fcmp_ugt_fsub_const_ninf_vec_before  ⊑  fcmp_ugt_fsub_const_ninf_vec_combined := by
  unfold fcmp_ugt_fsub_const_ninf_vec_before fcmp_ugt_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ugt" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ugt_fsub_const_ninf_vec   : fcmp_ugt_fsub_const_ninf_vec_before  ⊑  fcmp_ugt_fsub_const_ninf_vec_combined := by
  unfold fcmp_ugt_fsub_const_ninf_vec_before fcmp_ugt_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ugt_fsub_const_ninf_vec   : fcmp_ugt_fsub_const_ninf_vec_before  ⊑  fcmp_ugt_fsub_const_ninf_vec_combined := by
  unfold fcmp_ugt_fsub_const_ninf_vec_before fcmp_ugt_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ult_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_ult_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ult_fsub_const_ninf_vec   : fcmp_ult_fsub_const_ninf_vec_before  ⊑  fcmp_ult_fsub_const_ninf_vec_combined := by
  unfold fcmp_ult_fsub_const_ninf_vec_before fcmp_ult_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ult" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_ult_fsub_const_ninf_vec   : fcmp_ult_fsub_const_ninf_vec_before  ⊑  fcmp_ult_fsub_const_ninf_vec_combined := by
  unfold fcmp_ult_fsub_const_ninf_vec_before fcmp_ult_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ult_fsub_const_ninf_vec   : fcmp_ult_fsub_const_ninf_vec_before  ⊑  fcmp_ult_fsub_const_ninf_vec_combined := by
  unfold fcmp_ult_fsub_const_ninf_vec_before fcmp_ult_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_une_fsub_const_ninf_vec_combined := [llvmfunc|
  llvm.func @fcmp_une_fsub_const_ninf_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_une_fsub_const_ninf_vec   : fcmp_une_fsub_const_ninf_vec_before  ⊑  fcmp_une_fsub_const_ninf_vec_combined := by
  unfold fcmp_une_fsub_const_ninf_vec_before fcmp_une_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "une" %2, %1 {fastmathFlags = #llvm.fastmath<ninf>} : vector<8xf32>]

theorem inst_combine_fcmp_une_fsub_const_ninf_vec   : fcmp_une_fsub_const_ninf_vec_before  ⊑  fcmp_une_fsub_const_ninf_vec_combined := by
  unfold fcmp_une_fsub_const_ninf_vec_before fcmp_une_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_une_fsub_const_ninf_vec   : fcmp_une_fsub_const_ninf_vec_before  ⊑  fcmp_une_fsub_const_ninf_vec_combined := by
  unfold fcmp_une_fsub_const_ninf_vec_before fcmp_une_fsub_const_ninf_vec_combined
  simp_alive_peephole
  sorry
def fcmp_uge_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_uge_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_uge_fsub_const_nnan_vec   : fcmp_uge_fsub_const_nnan_vec_before  ⊑  fcmp_uge_fsub_const_nnan_vec_combined := by
  unfold fcmp_uge_fsub_const_nnan_vec_before fcmp_uge_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_uge_fsub_const_nnan_vec   : fcmp_uge_fsub_const_nnan_vec_before  ⊑  fcmp_uge_fsub_const_nnan_vec_combined := by
  unfold fcmp_uge_fsub_const_nnan_vec_before fcmp_uge_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_uge_fsub_const_nnan_vec   : fcmp_uge_fsub_const_nnan_vec_before  ⊑  fcmp_uge_fsub_const_nnan_vec_combined := by
  unfold fcmp_uge_fsub_const_nnan_vec_before fcmp_uge_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ule_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_ule_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ule_fsub_const_nnan_vec   : fcmp_ule_fsub_const_nnan_vec_before  ⊑  fcmp_ule_fsub_const_nnan_vec_combined := by
  unfold fcmp_ule_fsub_const_nnan_vec_before fcmp_ule_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ule" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ule_fsub_const_nnan_vec   : fcmp_ule_fsub_const_nnan_vec_before  ⊑  fcmp_ule_fsub_const_nnan_vec_combined := by
  unfold fcmp_ule_fsub_const_nnan_vec_before fcmp_ule_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ule_fsub_const_nnan_vec   : fcmp_ule_fsub_const_nnan_vec_before  ⊑  fcmp_ule_fsub_const_nnan_vec_combined := by
  unfold fcmp_ule_fsub_const_nnan_vec_before fcmp_ule_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ueq_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_ueq_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ueq_fsub_const_nnan_vec   : fcmp_ueq_fsub_const_nnan_vec_before  ⊑  fcmp_ueq_fsub_const_nnan_vec_combined := by
  unfold fcmp_ueq_fsub_const_nnan_vec_before fcmp_ueq_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ueq" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ueq_fsub_const_nnan_vec   : fcmp_ueq_fsub_const_nnan_vec_before  ⊑  fcmp_ueq_fsub_const_nnan_vec_combined := by
  unfold fcmp_ueq_fsub_const_nnan_vec_before fcmp_ueq_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ueq_fsub_const_nnan_vec   : fcmp_ueq_fsub_const_nnan_vec_before  ⊑  fcmp_ueq_fsub_const_nnan_vec_combined := by
  unfold fcmp_ueq_fsub_const_nnan_vec_before fcmp_ueq_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_oge_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_oge_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_oge_fsub_const_nnan_vec   : fcmp_oge_fsub_const_nnan_vec_before  ⊑  fcmp_oge_fsub_const_nnan_vec_combined := by
  unfold fcmp_oge_fsub_const_nnan_vec_before fcmp_oge_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "oge" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_oge_fsub_const_nnan_vec   : fcmp_oge_fsub_const_nnan_vec_before  ⊑  fcmp_oge_fsub_const_nnan_vec_combined := by
  unfold fcmp_oge_fsub_const_nnan_vec_before fcmp_oge_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_oge_fsub_const_nnan_vec   : fcmp_oge_fsub_const_nnan_vec_before  ⊑  fcmp_oge_fsub_const_nnan_vec_combined := by
  unfold fcmp_oge_fsub_const_nnan_vec_before fcmp_oge_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ole_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_ole_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ole_fsub_const_nnan_vec   : fcmp_ole_fsub_const_nnan_vec_before  ⊑  fcmp_ole_fsub_const_nnan_vec_combined := by
  unfold fcmp_ole_fsub_const_nnan_vec_before fcmp_ole_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ole" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ole_fsub_const_nnan_vec   : fcmp_ole_fsub_const_nnan_vec_before  ⊑  fcmp_ole_fsub_const_nnan_vec_combined := by
  unfold fcmp_ole_fsub_const_nnan_vec_before fcmp_ole_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ole_fsub_const_nnan_vec   : fcmp_ole_fsub_const_nnan_vec_before  ⊑  fcmp_ole_fsub_const_nnan_vec_combined := by
  unfold fcmp_ole_fsub_const_nnan_vec_before fcmp_ole_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_oeq_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_oeq_fsub_const_nnan_vec   : fcmp_oeq_fsub_const_nnan_vec_before  ⊑  fcmp_oeq_fsub_const_nnan_vec_combined := by
  unfold fcmp_oeq_fsub_const_nnan_vec_before fcmp_oeq_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "oeq" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_oeq_fsub_const_nnan_vec   : fcmp_oeq_fsub_const_nnan_vec_before  ⊑  fcmp_oeq_fsub_const_nnan_vec_combined := by
  unfold fcmp_oeq_fsub_const_nnan_vec_before fcmp_oeq_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_oeq_fsub_const_nnan_vec   : fcmp_oeq_fsub_const_nnan_vec_before  ⊑  fcmp_oeq_fsub_const_nnan_vec_combined := by
  unfold fcmp_oeq_fsub_const_nnan_vec_before fcmp_oeq_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ogt_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_ogt_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ogt_fsub_const_nnan_vec   : fcmp_ogt_fsub_const_nnan_vec_before  ⊑  fcmp_ogt_fsub_const_nnan_vec_combined := by
  unfold fcmp_ogt_fsub_const_nnan_vec_before fcmp_ogt_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ogt" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ogt_fsub_const_nnan_vec   : fcmp_ogt_fsub_const_nnan_vec_before  ⊑  fcmp_ogt_fsub_const_nnan_vec_combined := by
  unfold fcmp_ogt_fsub_const_nnan_vec_before fcmp_ogt_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ogt_fsub_const_nnan_vec   : fcmp_ogt_fsub_const_nnan_vec_before  ⊑  fcmp_ogt_fsub_const_nnan_vec_combined := by
  unfold fcmp_ogt_fsub_const_nnan_vec_before fcmp_ogt_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_olt_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_olt_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_olt_fsub_const_nnan_vec   : fcmp_olt_fsub_const_nnan_vec_before  ⊑  fcmp_olt_fsub_const_nnan_vec_combined := by
  unfold fcmp_olt_fsub_const_nnan_vec_before fcmp_olt_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "olt" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_olt_fsub_const_nnan_vec   : fcmp_olt_fsub_const_nnan_vec_before  ⊑  fcmp_olt_fsub_const_nnan_vec_combined := by
  unfold fcmp_olt_fsub_const_nnan_vec_before fcmp_olt_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_olt_fsub_const_nnan_vec   : fcmp_olt_fsub_const_nnan_vec_before  ⊑  fcmp_olt_fsub_const_nnan_vec_combined := by
  unfold fcmp_olt_fsub_const_nnan_vec_before fcmp_olt_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_one_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_one_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_one_fsub_const_nnan_vec   : fcmp_one_fsub_const_nnan_vec_before  ⊑  fcmp_one_fsub_const_nnan_vec_combined := by
  unfold fcmp_one_fsub_const_nnan_vec_before fcmp_one_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "one" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_one_fsub_const_nnan_vec   : fcmp_one_fsub_const_nnan_vec_before  ⊑  fcmp_one_fsub_const_nnan_vec_combined := by
  unfold fcmp_one_fsub_const_nnan_vec_before fcmp_one_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_one_fsub_const_nnan_vec   : fcmp_one_fsub_const_nnan_vec_before  ⊑  fcmp_one_fsub_const_nnan_vec_combined := by
  unfold fcmp_one_fsub_const_nnan_vec_before fcmp_one_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ugt_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_ugt_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ugt_fsub_const_nnan_vec   : fcmp_ugt_fsub_const_nnan_vec_before  ⊑  fcmp_ugt_fsub_const_nnan_vec_combined := by
  unfold fcmp_ugt_fsub_const_nnan_vec_before fcmp_ugt_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ugt" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ugt_fsub_const_nnan_vec   : fcmp_ugt_fsub_const_nnan_vec_before  ⊑  fcmp_ugt_fsub_const_nnan_vec_combined := by
  unfold fcmp_ugt_fsub_const_nnan_vec_before fcmp_ugt_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ugt_fsub_const_nnan_vec   : fcmp_ugt_fsub_const_nnan_vec_before  ⊑  fcmp_ugt_fsub_const_nnan_vec_combined := by
  unfold fcmp_ugt_fsub_const_nnan_vec_before fcmp_ugt_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_ult_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_ult_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ult_fsub_const_nnan_vec   : fcmp_ult_fsub_const_nnan_vec_before  ⊑  fcmp_ult_fsub_const_nnan_vec_combined := by
  unfold fcmp_ult_fsub_const_nnan_vec_before fcmp_ult_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ult" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_ult_fsub_const_nnan_vec   : fcmp_ult_fsub_const_nnan_vec_before  ⊑  fcmp_ult_fsub_const_nnan_vec_combined := by
  unfold fcmp_ult_fsub_const_nnan_vec_before fcmp_ult_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ult_fsub_const_nnan_vec   : fcmp_ult_fsub_const_nnan_vec_before  ⊑  fcmp_ult_fsub_const_nnan_vec_combined := by
  unfold fcmp_ult_fsub_const_nnan_vec_before fcmp_ult_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def fcmp_une_fsub_const_nnan_vec_combined := [llvmfunc|
  llvm.func @fcmp_une_fsub_const_nnan_vec(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_une_fsub_const_nnan_vec   : fcmp_une_fsub_const_nnan_vec_before  ⊑  fcmp_une_fsub_const_nnan_vec_combined := by
  unfold fcmp_une_fsub_const_nnan_vec_before fcmp_une_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "une" %2, %1 {fastmathFlags = #llvm.fastmath<nnan>} : vector<8xf32>]

theorem inst_combine_fcmp_une_fsub_const_nnan_vec   : fcmp_une_fsub_const_nnan_vec_before  ⊑  fcmp_une_fsub_const_nnan_vec_combined := by
  unfold fcmp_une_fsub_const_nnan_vec_before fcmp_une_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_une_fsub_const_nnan_vec   : fcmp_une_fsub_const_nnan_vec_before  ⊑  fcmp_une_fsub_const_nnan_vec_combined := by
  unfold fcmp_une_fsub_const_nnan_vec_before fcmp_une_fsub_const_nnan_vec_combined
  simp_alive_peephole
  sorry
def "fcmp_ugt_fsub_const_vec_denormal_positive-zero"_combined := [llvmfunc|
  llvm.func @"fcmp_ugt_fsub_const_vec_denormal_positive-zero"(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> attributes {passthrough = [["denormal-fp-math", "positive-zero,positive-zero"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_"fcmp_ugt_fsub_const_vec_denormal_positive-zero"   : "fcmp_ugt_fsub_const_vec_denormal_positive-zero"_before  ⊑  "fcmp_ugt_fsub_const_vec_denormal_positive-zero"_combined := by
  unfold "fcmp_ugt_fsub_const_vec_denormal_positive-zero"_before "fcmp_ugt_fsub_const_vec_denormal_positive-zero"_combined
  simp_alive_peephole
  sorry
def fcmp_ogt_fsub_const_vec_denormal_dynamic_combined := [llvmfunc|
  llvm.func @fcmp_ogt_fsub_const_vec_denormal_dynamic(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> attributes {passthrough = [["denormal-fp-math", "dynamic,dynamic"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_fcmp_ogt_fsub_const_vec_denormal_dynamic   : fcmp_ogt_fsub_const_vec_denormal_dynamic_before  ⊑  fcmp_ogt_fsub_const_vec_denormal_dynamic_combined := by
  unfold fcmp_ogt_fsub_const_vec_denormal_dynamic_before fcmp_ogt_fsub_const_vec_denormal_dynamic_combined
  simp_alive_peephole
  sorry
def "fcmp_ogt_fsub_const_vec_denormal_preserve-sign"_combined := [llvmfunc|
  llvm.func @"fcmp_ogt_fsub_const_vec_denormal_preserve-sign"(%arg0: vector<8xf32>, %arg1: vector<8xf32>) -> vector<8xi1> attributes {passthrough = [["denormal-fp-math", "preserve-sign,preserve-sign"]]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<8xf32>
    %3 = llvm.fcmp "ogt" %2, %1 : vector<8xf32>
    llvm.return %3 : vector<8xi1>
  }]

theorem inst_combine_"fcmp_ogt_fsub_const_vec_denormal_preserve-sign"   : "fcmp_ogt_fsub_const_vec_denormal_preserve-sign"_before  ⊑  "fcmp_ogt_fsub_const_vec_denormal_preserve-sign"_combined := by
  unfold "fcmp_ogt_fsub_const_vec_denormal_preserve-sign"_before "fcmp_ogt_fsub_const_vec_denormal_preserve-sign"_combined
  simp_alive_peephole
  sorry
