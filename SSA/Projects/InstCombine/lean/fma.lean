import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fma
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fma_fneg_x_fneg_y_before := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.fma(%1, %2, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

def fma_unary_fneg_x_unary_fneg_y_before := [llvmfunc|
  llvm.func @fma_unary_fneg_x_unary_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.fma(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }]

def fma_fneg_x_fneg_y_vec_before := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_y_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.intr.fma(%1, %2, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def fma_unary_fneg_x_unary_fneg_y_vec_before := [llvmfunc|
  llvm.func @fma_unary_fneg_x_unary_fneg_y_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.fneg %arg1  : vector<2xf32>
    %2 = llvm.intr.fma(%0, %1, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def fma_fneg_x_fneg_y_vec_poison_before := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_y_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
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
    %14 = llvm.intr.fma(%12, %13, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %14 : vector<2xf32>
  }]

def fma_fneg_x_fneg_y_fast_before := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.fma(%1, %2, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %3 : f32
  }]

def fma_unary_fneg_x_unary_fneg_y_fast_before := [llvmfunc|
  llvm.func @fma_unary_fneg_x_unary_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.fma(%0, %1, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %2 : f32
  }]

def fma_fneg_const_fneg_y_before := [llvmfunc|
  llvm.func @fma_fneg_const_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @external : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fsub %0, %arg0  : f32
    %5 = llvm.fsub %0, %3  : f32
    %6 = llvm.intr.fma(%5, %4, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %6 : f32
  }]

def fma_unary_fneg_const_unary_fneg_y_before := [llvmfunc|
  llvm.func @fma_unary_fneg_const_unary_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.fneg %2  : f32
    %5 = llvm.intr.fma(%4, %3, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %5 : f32
  }]

def fma_fneg_x_fneg_const_before := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @external : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fsub %0, %arg0  : f32
    %5 = llvm.fsub %0, %3  : f32
    %6 = llvm.intr.fma(%4, %5, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %6 : f32
  }]

def fma_unary_fneg_x_unary_fneg_const_before := [llvmfunc|
  llvm.func @fma_unary_fneg_x_unary_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.fneg %2  : f32
    %5 = llvm.intr.fma(%3, %4, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %5 : f32
  }]

def fma_fabs_x_fabs_y_before := [llvmfunc|
  llvm.func @fma_fabs_x_fabs_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fabs(%arg1)  : (f32) -> f32
    %2 = llvm.intr.fma(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }]

def fma_fabs_x_fabs_x_before := [llvmfunc|
  llvm.func @fma_fabs_x_fabs_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fma(%0, %0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fma_fabs_x_fabs_x_fast_before := [llvmfunc|
  llvm.func @fma_fabs_x_fabs_x_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fma(%0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def fmuladd_fneg_x_fneg_y_before := [llvmfunc|
  llvm.func @fmuladd_fneg_x_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.fmuladd(%1, %2, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

def fmuladd_unary_fneg_x_unary_fneg_y_before := [llvmfunc|
  llvm.func @fmuladd_unary_fneg_x_unary_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.fmuladd(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }]

def fmuladd_fneg_x_fneg_y_fast_before := [llvmfunc|
  llvm.func @fmuladd_fneg_x_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.intr.fmuladd(%1, %2, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %3 : f32
  }]

def fmuladd_unfold_before := [llvmfunc|
  llvm.func @fmuladd_unfold(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fmuladd(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<contract, reassoc>} : (f32, f32, f32) -> f32]

    llvm.return %0 : f32
  }]

def fmuladd_unfold_vec_before := [llvmfunc|
  llvm.func @fmuladd_unfold_vec(%arg0: vector<8xf16>, %arg1: vector<8xf16>, %arg2: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.intr.fmuladd(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<contract, reassoc>} : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>]

    llvm.return %0 : vector<8xf16>
  }]

def fmuladd_unary_fneg_x_unary_fneg_y_fast_before := [llvmfunc|
  llvm.func @fmuladd_unary_fneg_x_unary_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.intr.fmuladd(%0, %1, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %2 : f32
  }]

def fmuladd_fneg_const_fneg_y_before := [llvmfunc|
  llvm.func @fmuladd_fneg_const_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @external : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fsub %0, %arg0  : f32
    %5 = llvm.fsub %0, %3  : f32
    %6 = llvm.intr.fmuladd(%5, %4, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %6 : f32
  }]

def fmuladd_unary_fneg_const_unary_fneg_y_before := [llvmfunc|
  llvm.func @fmuladd_unary_fneg_const_unary_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.fneg %2  : f32
    %5 = llvm.intr.fmuladd(%4, %3, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %5 : f32
  }]

def fmuladd_fneg_x_fneg_const_before := [llvmfunc|
  llvm.func @fmuladd_fneg_x_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @external : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fsub %0, %arg0  : f32
    %5 = llvm.fsub %0, %3  : f32
    %6 = llvm.intr.fmuladd(%4, %5, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %6 : f32
  }]

def fmuladd_unary_fneg_x_unary_fneg_const_before := [llvmfunc|
  llvm.func @fmuladd_unary_fneg_x_unary_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fneg %arg0  : f32
    %4 = llvm.fneg %2  : f32
    %5 = llvm.intr.fmuladd(%3, %4, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %5 : f32
  }]

def fmuladd_fabs_x_fabs_y_before := [llvmfunc|
  llvm.func @fmuladd_fabs_x_fabs_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fabs(%arg1)  : (f32) -> f32
    %2 = llvm.intr.fmuladd(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }]

def fmuladd_fabs_x_fabs_x_before := [llvmfunc|
  llvm.func @fmuladd_fabs_x_fabs_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fmuladd(%0, %0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fmuladd_fabs_x_fabs_x_fast_before := [llvmfunc|
  llvm.func @fmuladd_fabs_x_fabs_x_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fmuladd(%0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def fma_k_y_z_before := [llvmfunc|
  llvm.func @fma_k_y_z(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fma_k_y_z_fast_before := [llvmfunc|
  llvm.func @fma_k_y_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def fmuladd_k_y_z_fast_before := [llvmfunc|
  llvm.func @fmuladd_k_y_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def fma_1_y_z_before := [llvmfunc|
  llvm.func @fma_1_y_z(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fma_x_1_z_before := [llvmfunc|
  llvm.func @fma_x_1_z(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fma_x_1_z_v2f32_before := [llvmfunc|
  llvm.func @fma_x_1_z_v2f32(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def fma_x_1_2_z_v2f32_before := [llvmfunc|
  llvm.func @fma_x_1_2_z_v2f32(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def fma_x_1_z_fast_before := [llvmfunc|
  llvm.func @fma_x_1_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def fma_1_1_z_before := [llvmfunc|
  llvm.func @fma_1_1_z(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%0, %0, %arg0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fma_x_y_0_before := [llvmfunc|
  llvm.func @fma_x_y_0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fma_x_y_0_nsz_before := [llvmfunc|
  llvm.func @fma_x_y_0_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def fma_x_y_0_v_before := [llvmfunc|
  llvm.func @fma_x_y_0_v(%arg0: vector<8xf16>, %arg1: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf16>) : vector<8xf16>
    %2 = llvm.intr.fma(%arg0, %arg1, %1)  : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    llvm.return %2 : vector<8xf16>
  }]

def fma_x_y_0_nsz_v_before := [llvmfunc|
  llvm.func @fma_x_y_0_nsz_v(%arg0: vector<8xf16>, %arg1: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf16>) : vector<8xf16>
    %2 = llvm.intr.fma(%arg0, %arg1, %1)  {fastmathFlags = #llvm.fastmath<nsz>} : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>]

    llvm.return %2 : vector<8xf16>
  }]

def fmuladd_x_y_0_before := [llvmfunc|
  llvm.func @fmuladd_x_y_0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fmuladd_x_y_0_nsz_before := [llvmfunc|
  llvm.func @fmuladd_x_y_0_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def fma_x_y_m0_before := [llvmfunc|
  llvm.func @fma_x_y_m0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fma_x_y_m0_v_before := [llvmfunc|
  llvm.func @fma_x_y_m0_v(%arg0: vector<8xf16>, %arg1: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<8xf16>) : vector<8xf16>
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    llvm.return %1 : vector<8xf16>
  }]

def fmuladd_x_y_m0_before := [llvmfunc|
  llvm.func @fmuladd_x_y_m0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fmuladd_x_1_z_fast_before := [llvmfunc|
  llvm.func @fmuladd_x_1_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def fmuladd_a_0_b_before := [llvmfunc|
  llvm.func @fmuladd_a_0_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%arg0, %1, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fmuladd_0_a_b_before := [llvmfunc|
  llvm.func @fmuladd_0_a_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%1, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fmuladd_a_0_b_missing_flags_before := [llvmfunc|
  llvm.func @fmuladd_a_0_b_missing_flags(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%arg0, %1, %arg1)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_a_0_b_before := [llvmfunc|
  llvm.func @fma_a_0_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%arg0, %1, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_0_a_b_before := [llvmfunc|
  llvm.func @fma_0_a_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%1, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_0_a_b_missing_flags_before := [llvmfunc|
  llvm.func @fma_0_a_b_missing_flags(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%1, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_sqrt_before := [llvmfunc|
  llvm.func @fma_sqrt(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>) -> vector<2xf64>]

    %1 = llvm.intr.fma(%0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fma_const_fmul_before := [llvmfunc|
  llvm.func @fma_const_fmul(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_const_fmul_zero_before := [llvmfunc|
  llvm.func @fma_const_fmul_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.intr.fma(%1, %2, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %3 : vector<2xf64>
  }]

def fma_const_fmul_zero2_before := [llvmfunc|
  llvm.func @fma_const_fmul_zero2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.intr.fma(%0, %2, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %3 : vector<2xf64>
  }]

def fma_const_fmul_one_before := [llvmfunc|
  llvm.func @fma_const_fmul_one(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_const_fmul_one2_before := [llvmfunc|
  llvm.func @fma_const_fmul_one2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_nan_and_const_0_before := [llvmfunc|
  llvm.func @fma_nan_and_const_0(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_nan_and_const_1_before := [llvmfunc|
  llvm.func @fma_nan_and_const_1(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_nan_and_const_2_before := [llvmfunc|
  llvm.func @fma_nan_and_const_2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %arg0, %1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fma_undef_0_before := [llvmfunc|
  llvm.func @fma_undef_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fma_undef_1_before := [llvmfunc|
  llvm.func @fma_undef_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fma_undef_2_before := [llvmfunc|
  llvm.func @fma_undef_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fma_partial_undef_0_before := [llvmfunc|
  llvm.func @fma_partial_undef_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(199.00122999999999 : f64) : f64
    %1 = llvm.mlir.undef : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.intr.fma(%6, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %7 : vector<2xf64>
  }]

def fma_partial_undef_1_before := [llvmfunc|
  llvm.func @fma_partial_undef_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(199.00122999999999 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.intr.fma(%arg0, %6, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %7 : vector<2xf64>
  }]

def fma_partial_undef_2_before := [llvmfunc|
  llvm.func @fma_partial_undef_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(199.00122999999999 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.intr.fma(%arg0, %arg1, %6)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %7 : vector<2xf64>
  }]

def fma_nan_0_before := [llvmfunc|
  llvm.func @fma_nan_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fma(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fma_nan_1_before := [llvmfunc|
  llvm.func @fma_nan_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fma_nan_2_before := [llvmfunc|
  llvm.func @fma_nan_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fmuladd_const_fmul_before := [llvmfunc|
  llvm.func @fmuladd_const_fmul(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fmuladd_nan_and_const_0_before := [llvmfunc|
  llvm.func @fmuladd_nan_and_const_0(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fmuladd_nan_and_const_1_before := [llvmfunc|
  llvm.func @fmuladd_nan_and_const_1(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fmuladd_nan_and_const_2_before := [llvmfunc|
  llvm.func @fmuladd_nan_and_const_2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%0, %arg0, %1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %2 : vector<2xf64>
  }]

def fmuladd_nan_0_before := [llvmfunc|
  llvm.func @fmuladd_nan_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fmuladd(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fmuladd_nan_1_before := [llvmfunc|
  llvm.func @fmuladd_nan_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fmuladd(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fmuladd_undef_0_before := [llvmfunc|
  llvm.func @fmuladd_undef_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fmuladd(%0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fmuladd_undef_1_before := [llvmfunc|
  llvm.func @fmuladd_undef_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : vector<2xf64>
    %1 = llvm.intr.fmuladd(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fmuladd_undef_2_before := [llvmfunc|
  llvm.func @fmuladd_undef_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.fmuladd(%arg0, %arg1, %0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fma_unary_shuffle_ops_before := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xf32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xf32> 
    %4 = llvm.intr.fma(%1, %2, %3)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def fma_unary_shuffle_ops_widening_before := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_widening(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 1] : vector<2xf32> 
    llvm.call @use_vec3(%1) : (vector<3xf32>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 1] : vector<2xf32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0, 1] : vector<2xf32> 
    %4 = llvm.intr.fma(%1, %2, %3)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> vector<3xf32>]

    llvm.return %4 : vector<3xf32>
  }]

def fma_unary_shuffle_ops_narrowing_before := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_narrowing(%arg0: vector<3xf32>, %arg1: vector<3xf32>, %arg2: vector<3xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<3xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<3xf32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<3xf32> 
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<3xf32> 
    %4 = llvm.intr.fma(%1, %2, %3)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>]

    llvm.return %4 : vector<2xf32>
  }]

def fma_unary_shuffle_ops_unshuffled_before := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_unshuffled(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xf32> 
    %3 = llvm.intr.fma(%1, %2, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def fma_unary_shuffle_ops_wrong_mask_before := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_wrong_mask(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    %2 = llvm.shufflevector %arg1, %0 [0, 0] : vector<2xf32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xf32> 
    %4 = llvm.intr.fma(%1, %2, %3)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def fma_unary_shuffle_ops_uses_before := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_uses(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xf32> 
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xf32> 
    llvm.call @use_vec(%3) : (vector<2xf32>) -> ()
    %4 = llvm.intr.fma(%1, %2, %3)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def fma_fneg_x_fneg_y_combined := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fma(%arg0, %arg1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_fneg_x_fneg_y   : fma_fneg_x_fneg_y_before  ⊑  fma_fneg_x_fneg_y_combined := by
  unfold fma_fneg_x_fneg_y_before fma_fneg_x_fneg_y_combined
  simp_alive_peephole
  sorry
def fma_unary_fneg_x_unary_fneg_y_combined := [llvmfunc|
  llvm.func @fma_unary_fneg_x_unary_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fma(%arg0, %arg1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_unary_fneg_x_unary_fneg_y   : fma_unary_fneg_x_unary_fneg_y_before  ⊑  fma_unary_fneg_x_unary_fneg_y_combined := by
  unfold fma_unary_fneg_x_unary_fneg_y_before fma_unary_fneg_x_unary_fneg_y_combined
  simp_alive_peephole
  sorry
def fma_fneg_x_fneg_y_vec_combined := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_y_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fma(%arg0, %arg1, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fma_fneg_x_fneg_y_vec   : fma_fneg_x_fneg_y_vec_before  ⊑  fma_fneg_x_fneg_y_vec_combined := by
  unfold fma_fneg_x_fneg_y_vec_before fma_fneg_x_fneg_y_vec_combined
  simp_alive_peephole
  sorry
def fma_unary_fneg_x_unary_fneg_y_vec_combined := [llvmfunc|
  llvm.func @fma_unary_fneg_x_unary_fneg_y_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fma(%arg0, %arg1, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fma_unary_fneg_x_unary_fneg_y_vec   : fma_unary_fneg_x_unary_fneg_y_vec_before  ⊑  fma_unary_fneg_x_unary_fneg_y_vec_combined := by
  unfold fma_unary_fneg_x_unary_fneg_y_vec_before fma_unary_fneg_x_unary_fneg_y_vec_combined
  simp_alive_peephole
  sorry
def fma_fneg_x_fneg_y_vec_poison_combined := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_y_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fma(%arg0, %arg1, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fma_fneg_x_fneg_y_vec_poison   : fma_fneg_x_fneg_y_vec_poison_before  ⊑  fma_fneg_x_fneg_y_vec_poison_combined := by
  unfold fma_fneg_x_fneg_y_vec_poison_before fma_fneg_x_fneg_y_vec_poison_combined
  simp_alive_peephole
  sorry
def fma_fneg_x_fneg_y_fast_combined := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fma(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_fneg_x_fneg_y_fast   : fma_fneg_x_fneg_y_fast_before  ⊑  fma_fneg_x_fneg_y_fast_combined := by
  unfold fma_fneg_x_fneg_y_fast_before fma_fneg_x_fneg_y_fast_combined
  simp_alive_peephole
  sorry
def fma_unary_fneg_x_unary_fneg_y_fast_combined := [llvmfunc|
  llvm.func @fma_unary_fneg_x_unary_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fma(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_unary_fneg_x_unary_fneg_y_fast   : fma_unary_fneg_x_unary_fneg_y_fast_before  ⊑  fma_unary_fneg_x_unary_fneg_y_fast_combined := by
  unfold fma_unary_fneg_x_unary_fneg_y_fast_before fma_unary_fneg_x_unary_fneg_y_fast_combined
  simp_alive_peephole
  sorry
def fma_fneg_const_fneg_y_combined := [llvmfunc|
  llvm.func @fma_fneg_const_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.intr.fma(%arg0, %2, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fma_fneg_const_fneg_y   : fma_fneg_const_fneg_y_before  ⊑  fma_fneg_const_fneg_y_combined := by
  unfold fma_fneg_const_fneg_y_before fma_fneg_const_fneg_y_combined
  simp_alive_peephole
  sorry
def fma_unary_fneg_const_unary_fneg_y_combined := [llvmfunc|
  llvm.func @fma_unary_fneg_const_unary_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.intr.fma(%arg0, %2, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fma_unary_fneg_const_unary_fneg_y   : fma_unary_fneg_const_unary_fneg_y_before  ⊑  fma_unary_fneg_const_unary_fneg_y_combined := by
  unfold fma_unary_fneg_const_unary_fneg_y_before fma_unary_fneg_const_unary_fneg_y_combined
  simp_alive_peephole
  sorry
def fma_fneg_x_fneg_const_combined := [llvmfunc|
  llvm.func @fma_fneg_x_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.intr.fma(%arg0, %2, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fma_fneg_x_fneg_const   : fma_fneg_x_fneg_const_before  ⊑  fma_fneg_x_fneg_const_combined := by
  unfold fma_fneg_x_fneg_const_before fma_fneg_x_fneg_const_combined
  simp_alive_peephole
  sorry
def fma_unary_fneg_x_unary_fneg_const_combined := [llvmfunc|
  llvm.func @fma_unary_fneg_x_unary_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.intr.fma(%arg0, %2, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fma_unary_fneg_x_unary_fneg_const   : fma_unary_fneg_x_unary_fneg_const_before  ⊑  fma_unary_fneg_x_unary_fneg_const_combined := by
  unfold fma_unary_fneg_x_unary_fneg_const_before fma_unary_fneg_x_unary_fneg_const_combined
  simp_alive_peephole
  sorry
def fma_fabs_x_fabs_y_combined := [llvmfunc|
  llvm.func @fma_fabs_x_fabs_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fabs(%arg1)  : (f32) -> f32
    %2 = llvm.intr.fma(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fma_fabs_x_fabs_y   : fma_fabs_x_fabs_y_before  ⊑  fma_fabs_x_fabs_y_combined := by
  unfold fma_fabs_x_fabs_y_before fma_fabs_x_fabs_y_combined
  simp_alive_peephole
  sorry
def fma_fabs_x_fabs_x_combined := [llvmfunc|
  llvm.func @fma_fabs_x_fabs_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fma(%arg0, %arg0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_fabs_x_fabs_x   : fma_fabs_x_fabs_x_before  ⊑  fma_fabs_x_fabs_x_combined := by
  unfold fma_fabs_x_fabs_x_before fma_fabs_x_fabs_x_combined
  simp_alive_peephole
  sorry
def fma_fabs_x_fabs_x_fast_combined := [llvmfunc|
  llvm.func @fma_fabs_x_fabs_x_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fma(%arg0, %arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_fabs_x_fabs_x_fast   : fma_fabs_x_fabs_x_fast_before  ⊑  fma_fabs_x_fabs_x_fast_combined := by
  unfold fma_fabs_x_fabs_x_fast_before fma_fabs_x_fabs_x_fast_combined
  simp_alive_peephole
  sorry
def fmuladd_fneg_x_fneg_y_combined := [llvmfunc|
  llvm.func @fmuladd_fneg_x_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fmuladd(%arg0, %arg1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmuladd_fneg_x_fneg_y   : fmuladd_fneg_x_fneg_y_before  ⊑  fmuladd_fneg_x_fneg_y_combined := by
  unfold fmuladd_fneg_x_fneg_y_before fmuladd_fneg_x_fneg_y_combined
  simp_alive_peephole
  sorry
def fmuladd_unary_fneg_x_unary_fneg_y_combined := [llvmfunc|
  llvm.func @fmuladd_unary_fneg_x_unary_fneg_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fmuladd(%arg0, %arg1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmuladd_unary_fneg_x_unary_fneg_y   : fmuladd_unary_fneg_x_unary_fneg_y_before  ⊑  fmuladd_unary_fneg_x_unary_fneg_y_combined := by
  unfold fmuladd_unary_fneg_x_unary_fneg_y_before fmuladd_unary_fneg_x_unary_fneg_y_combined
  simp_alive_peephole
  sorry
def fmuladd_fneg_x_fneg_y_fast_combined := [llvmfunc|
  llvm.func @fmuladd_fneg_x_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fmuladd_fneg_x_fneg_y_fast   : fmuladd_fneg_x_fneg_y_fast_before  ⊑  fmuladd_fneg_x_fneg_y_fast_combined := by
  unfold fmuladd_fneg_x_fneg_y_fast_before fmuladd_fneg_x_fneg_y_fast_combined
  simp_alive_peephole
  sorry
def fmuladd_unfold_combined := [llvmfunc|
  llvm.func @fmuladd_unfold(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fmuladd(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<contract, reassoc>} : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmuladd_unfold   : fmuladd_unfold_before  ⊑  fmuladd_unfold_combined := by
  unfold fmuladd_unfold_before fmuladd_unfold_combined
  simp_alive_peephole
  sorry
def fmuladd_unfold_vec_combined := [llvmfunc|
  llvm.func @fmuladd_unfold_vec(%arg0: vector<8xf16>, %arg1: vector<8xf16>, %arg2: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.intr.fmuladd(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<contract, reassoc>} : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    llvm.return %0 : vector<8xf16>
  }]

theorem inst_combine_fmuladd_unfold_vec   : fmuladd_unfold_vec_before  ⊑  fmuladd_unfold_vec_combined := by
  unfold fmuladd_unfold_vec_before fmuladd_unfold_vec_combined
  simp_alive_peephole
  sorry
def fmuladd_unary_fneg_x_unary_fneg_y_fast_combined := [llvmfunc|
  llvm.func @fmuladd_unary_fneg_x_unary_fneg_y_fast(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fmuladd_unary_fneg_x_unary_fneg_y_fast   : fmuladd_unary_fneg_x_unary_fneg_y_fast_before  ⊑  fmuladd_unary_fneg_x_unary_fneg_y_fast_combined := by
  unfold fmuladd_unary_fneg_x_unary_fneg_y_fast_before fmuladd_unary_fneg_x_unary_fneg_y_fast_combined
  simp_alive_peephole
  sorry
def fmuladd_fneg_const_fneg_y_combined := [llvmfunc|
  llvm.func @fmuladd_fneg_const_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.intr.fmuladd(%arg0, %2, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fmuladd_fneg_const_fneg_y   : fmuladd_fneg_const_fneg_y_before  ⊑  fmuladd_fneg_const_fneg_y_combined := by
  unfold fmuladd_fneg_const_fneg_y_before fmuladd_fneg_const_fneg_y_combined
  simp_alive_peephole
  sorry
def fmuladd_unary_fneg_const_unary_fneg_y_combined := [llvmfunc|
  llvm.func @fmuladd_unary_fneg_const_unary_fneg_y(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.intr.fmuladd(%arg0, %2, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fmuladd_unary_fneg_const_unary_fneg_y   : fmuladd_unary_fneg_const_unary_fneg_y_before  ⊑  fmuladd_unary_fneg_const_unary_fneg_y_combined := by
  unfold fmuladd_unary_fneg_const_unary_fneg_y_before fmuladd_unary_fneg_const_unary_fneg_y_combined
  simp_alive_peephole
  sorry
def fmuladd_fneg_x_fneg_const_combined := [llvmfunc|
  llvm.func @fmuladd_fneg_x_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.intr.fmuladd(%arg0, %2, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fmuladd_fneg_x_fneg_const   : fmuladd_fneg_x_fneg_const_before  ⊑  fmuladd_fneg_x_fneg_const_combined := by
  unfold fmuladd_fneg_x_fneg_const_before fmuladd_fneg_x_fneg_const_combined
  simp_alive_peephole
  sorry
def fmuladd_unary_fneg_x_unary_fneg_const_combined := [llvmfunc|
  llvm.func @fmuladd_unary_fneg_x_unary_fneg_const(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.addressof @external : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.intr.fmuladd(%arg0, %2, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fmuladd_unary_fneg_x_unary_fneg_const   : fmuladd_unary_fneg_x_unary_fneg_const_before  ⊑  fmuladd_unary_fneg_x_unary_fneg_const_combined := by
  unfold fmuladd_unary_fneg_x_unary_fneg_const_before fmuladd_unary_fneg_x_unary_fneg_const_combined
  simp_alive_peephole
  sorry
def fmuladd_fabs_x_fabs_y_combined := [llvmfunc|
  llvm.func @fmuladd_fabs_x_fabs_y(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.fabs(%arg1)  : (f32) -> f32
    %2 = llvm.intr.fmuladd(%0, %1, %arg2)  : (f32, f32, f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fmuladd_fabs_x_fabs_y   : fmuladd_fabs_x_fabs_y_before  ⊑  fmuladd_fabs_x_fabs_y_combined := by
  unfold fmuladd_fabs_x_fabs_y_before fmuladd_fabs_x_fabs_y_combined
  simp_alive_peephole
  sorry
def fmuladd_fabs_x_fabs_x_combined := [llvmfunc|
  llvm.func @fmuladd_fabs_x_fabs_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fmuladd(%arg0, %arg0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmuladd_fabs_x_fabs_x   : fmuladd_fabs_x_fabs_x_before  ⊑  fmuladd_fabs_x_fabs_x_combined := by
  unfold fmuladd_fabs_x_fabs_x_before fmuladd_fabs_x_fabs_x_combined
  simp_alive_peephole
  sorry
def fmuladd_fabs_x_fabs_x_fast_combined := [llvmfunc|
  llvm.func @fmuladd_fabs_x_fabs_x_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fmuladd_fabs_x_fabs_x_fast   : fmuladd_fabs_x_fabs_x_fast_before  ⊑  fmuladd_fabs_x_fabs_x_fast_combined := by
  unfold fmuladd_fabs_x_fabs_x_fast_before fmuladd_fabs_x_fabs_x_fast_combined
  simp_alive_peephole
  sorry
def fma_k_y_z_combined := [llvmfunc|
  llvm.func @fma_k_y_z(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fma_k_y_z   : fma_k_y_z_before  ⊑  fma_k_y_z_combined := by
  unfold fma_k_y_z_before fma_k_y_z_combined
  simp_alive_peephole
  sorry
def fma_k_y_z_fast_combined := [llvmfunc|
  llvm.func @fma_k_y_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fma_k_y_z_fast   : fma_k_y_z_fast_before  ⊑  fma_k_y_z_fast_combined := by
  unfold fma_k_y_z_fast_before fma_k_y_z_fast_combined
  simp_alive_peephole
  sorry
def fmuladd_k_y_z_fast_combined := [llvmfunc|
  llvm.func @fmuladd_k_y_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fadd %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fmuladd_k_y_z_fast   : fmuladd_k_y_z_fast_before  ⊑  fmuladd_k_y_z_fast_combined := by
  unfold fmuladd_k_y_z_fast_before fmuladd_k_y_z_fast_combined
  simp_alive_peephole
  sorry
def fma_1_y_z_combined := [llvmfunc|
  llvm.func @fma_1_y_z(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_1_y_z   : fma_1_y_z_before  ⊑  fma_1_y_z_combined := by
  unfold fma_1_y_z_before fma_1_y_z_combined
  simp_alive_peephole
  sorry
def fma_x_1_z_combined := [llvmfunc|
  llvm.func @fma_x_1_z(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_x_1_z   : fma_x_1_z_before  ⊑  fma_x_1_z_combined := by
  unfold fma_x_1_z_before fma_x_1_z_combined
  simp_alive_peephole
  sorry
def fma_x_1_z_v2f32_combined := [llvmfunc|
  llvm.func @fma_x_1_z_v2f32(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg0, %arg1  : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fma_x_1_z_v2f32   : fma_x_1_z_v2f32_before  ⊑  fma_x_1_z_v2f32_combined := by
  unfold fma_x_1_z_v2f32_before fma_x_1_z_v2f32_combined
  simp_alive_peephole
  sorry
def fma_x_1_2_z_v2f32_combined := [llvmfunc|
  llvm.func @fma_x_1_2_z_v2f32(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.fma(%arg0, %0, %arg1)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fma_x_1_2_z_v2f32   : fma_x_1_2_z_v2f32_before  ⊑  fma_x_1_2_z_v2f32_combined := by
  unfold fma_x_1_2_z_v2f32_before fma_x_1_2_z_v2f32_combined
  simp_alive_peephole
  sorry
def fma_x_1_z_fast_combined := [llvmfunc|
  llvm.func @fma_x_1_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_x_1_z_fast   : fma_x_1_z_fast_before  ⊑  fma_x_1_z_fast_combined := by
  unfold fma_x_1_z_fast_before fma_x_1_z_fast_combined
  simp_alive_peephole
  sorry
def fma_1_1_z_combined := [llvmfunc|
  llvm.func @fma_1_1_z(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fma_1_1_z   : fma_1_1_z_before  ⊑  fma_1_1_z_combined := by
  unfold fma_1_1_z_before fma_1_1_z_combined
  simp_alive_peephole
  sorry
def fma_x_y_0_combined := [llvmfunc|
  llvm.func @fma_x_y_0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fma(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fma_x_y_0   : fma_x_y_0_before  ⊑  fma_x_y_0_combined := by
  unfold fma_x_y_0_before fma_x_y_0_combined
  simp_alive_peephole
  sorry
def fma_x_y_0_nsz_combined := [llvmfunc|
  llvm.func @fma_x_y_0_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_x_y_0_nsz   : fma_x_y_0_nsz_before  ⊑  fma_x_y_0_nsz_combined := by
  unfold fma_x_y_0_nsz_before fma_x_y_0_nsz_combined
  simp_alive_peephole
  sorry
def fma_x_y_0_v_combined := [llvmfunc|
  llvm.func @fma_x_y_0_v(%arg0: vector<8xf16>, %arg1: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf16>) : vector<8xf16>
    %2 = llvm.intr.fma(%arg0, %arg1, %1)  : (vector<8xf16>, vector<8xf16>, vector<8xf16>) -> vector<8xf16>
    llvm.return %2 : vector<8xf16>
  }]

theorem inst_combine_fma_x_y_0_v   : fma_x_y_0_v_before  ⊑  fma_x_y_0_v_combined := by
  unfold fma_x_y_0_v_before fma_x_y_0_v_combined
  simp_alive_peephole
  sorry
def fma_x_y_0_nsz_v_combined := [llvmfunc|
  llvm.func @fma_x_y_0_nsz_v(%arg0: vector<8xf16>, %arg1: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : vector<8xf16>
    llvm.return %0 : vector<8xf16>
  }]

theorem inst_combine_fma_x_y_0_nsz_v   : fma_x_y_0_nsz_v_before  ⊑  fma_x_y_0_nsz_v_combined := by
  unfold fma_x_y_0_nsz_v_before fma_x_y_0_nsz_v_combined
  simp_alive_peephole
  sorry
def fmuladd_x_y_0_combined := [llvmfunc|
  llvm.func @fmuladd_x_y_0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.fmuladd(%arg0, %arg1, %0)  : (f32, f32, f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fmuladd_x_y_0   : fmuladd_x_y_0_before  ⊑  fmuladd_x_y_0_combined := by
  unfold fmuladd_x_y_0_before fmuladd_x_y_0_combined
  simp_alive_peephole
  sorry
def fmuladd_x_y_0_nsz_combined := [llvmfunc|
  llvm.func @fmuladd_x_y_0_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmuladd_x_y_0_nsz   : fmuladd_x_y_0_nsz_before  ⊑  fmuladd_x_y_0_nsz_combined := by
  unfold fmuladd_x_y_0_nsz_before fmuladd_x_y_0_nsz_combined
  simp_alive_peephole
  sorry
def fma_x_y_m0_combined := [llvmfunc|
  llvm.func @fma_x_y_m0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fma_x_y_m0   : fma_x_y_m0_before  ⊑  fma_x_y_m0_combined := by
  unfold fma_x_y_m0_before fma_x_y_m0_combined
  simp_alive_peephole
  sorry
def fma_x_y_m0_v_combined := [llvmfunc|
  llvm.func @fma_x_y_m0_v(%arg0: vector<8xf16>, %arg1: vector<8xf16>) -> vector<8xf16> {
    %0 = llvm.fmul %arg0, %arg1  : vector<8xf16>
    llvm.return %0 : vector<8xf16>
  }]

theorem inst_combine_fma_x_y_m0_v   : fma_x_y_m0_v_before  ⊑  fma_x_y_m0_v_combined := by
  unfold fma_x_y_m0_v_before fma_x_y_m0_v_combined
  simp_alive_peephole
  sorry
def fmuladd_x_y_m0_combined := [llvmfunc|
  llvm.func @fmuladd_x_y_m0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmuladd_x_y_m0   : fmuladd_x_y_m0_before  ⊑  fmuladd_x_y_m0_combined := by
  unfold fmuladd_x_y_m0_before fmuladd_x_y_m0_combined
  simp_alive_peephole
  sorry
def fmuladd_x_1_z_fast_combined := [llvmfunc|
  llvm.func @fmuladd_x_1_z_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmuladd_x_1_z_fast   : fmuladd_x_1_z_fast_before  ⊑  fmuladd_x_1_z_fast_combined := by
  unfold fmuladd_x_1_z_fast_before fmuladd_x_1_z_fast_combined
  simp_alive_peephole
  sorry
def fmuladd_a_0_b_combined := [llvmfunc|
  llvm.func @fmuladd_a_0_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    llvm.return %arg1 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_a_0_b   : fmuladd_a_0_b_before  ⊑  fmuladd_a_0_b_combined := by
  unfold fmuladd_a_0_b_before fmuladd_a_0_b_combined
  simp_alive_peephole
  sorry
def fmuladd_0_a_b_combined := [llvmfunc|
  llvm.func @fmuladd_0_a_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    llvm.return %arg1 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_0_a_b   : fmuladd_0_a_b_before  ⊑  fmuladd_0_a_b_combined := by
  unfold fmuladd_0_a_b_before fmuladd_0_a_b_combined
  simp_alive_peephole
  sorry
def fmuladd_a_0_b_missing_flags_combined := [llvmfunc|
  llvm.func @fmuladd_a_0_b_missing_flags(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fmuladd(%arg0, %1, %arg1)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_a_0_b_missing_flags   : fmuladd_a_0_b_missing_flags_before  ⊑  fmuladd_a_0_b_missing_flags_combined := by
  unfold fmuladd_a_0_b_missing_flags_before fmuladd_a_0_b_missing_flags_combined
  simp_alive_peephole
  sorry
def fma_a_0_b_combined := [llvmfunc|
  llvm.func @fma_a_0_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    llvm.return %arg1 : vector<2xf64>
  }]

theorem inst_combine_fma_a_0_b   : fma_a_0_b_before  ⊑  fma_a_0_b_combined := by
  unfold fma_a_0_b_before fma_a_0_b_combined
  simp_alive_peephole
  sorry
def fma_0_a_b_combined := [llvmfunc|
  llvm.func @fma_0_a_b(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    llvm.return %arg1 : vector<2xf64>
  }]

theorem inst_combine_fma_0_a_b   : fma_0_a_b_before  ⊑  fma_0_a_b_combined := by
  unfold fma_0_a_b_before fma_0_a_b_combined
  simp_alive_peephole
  sorry
def fma_0_a_b_missing_flags_combined := [llvmfunc|
  llvm.func @fma_0_a_b_missing_flags(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%arg0, %1, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

theorem inst_combine_fma_0_a_b_missing_flags   : fma_0_a_b_missing_flags_before  ⊑  fma_0_a_b_missing_flags_combined := by
  unfold fma_0_a_b_missing_flags_before fma_0_a_b_missing_flags_combined
  simp_alive_peephole
  sorry
def fma_sqrt_combined := [llvmfunc|
  llvm.func @fma_sqrt(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_sqrt   : fma_sqrt_before  ⊑  fma_sqrt_combined := by
  unfold fma_sqrt_before fma_sqrt_combined
  simp_alive_peephole
  sorry
def fma_const_fmul_combined := [llvmfunc|
  llvm.func @fma_const_fmul(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<[1.291820e-08, 9.123000e-06]> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.intr.fma(%0, %1, %arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %2 : vector<2xf64>
  }]

theorem inst_combine_fma_const_fmul   : fma_const_fmul_before  ⊑  fma_const_fmul_combined := by
  unfold fma_const_fmul_before fma_const_fmul_combined
  simp_alive_peephole
  sorry
def fma_const_fmul_zero_combined := [llvmfunc|
  llvm.func @fma_const_fmul_zero(%arg0: vector<2xf64>) -> vector<2xf64> {
    llvm.return %arg0 : vector<2xf64>
  }]

theorem inst_combine_fma_const_fmul_zero   : fma_const_fmul_zero_before  ⊑  fma_const_fmul_zero_combined := by
  unfold fma_const_fmul_zero_before fma_const_fmul_zero_combined
  simp_alive_peephole
  sorry
def fma_const_fmul_zero2_combined := [llvmfunc|
  llvm.func @fma_const_fmul_zero2(%arg0: vector<2xf64>) -> vector<2xf64> {
    llvm.return %arg0 : vector<2xf64>
  }]

theorem inst_combine_fma_const_fmul_zero2   : fma_const_fmul_zero2_before  ⊑  fma_const_fmul_zero2_combined := by
  unfold fma_const_fmul_zero2_before fma_const_fmul_zero2_combined
  simp_alive_peephole
  sorry
def fma_const_fmul_one_combined := [llvmfunc|
  llvm.func @fma_const_fmul_one(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fma_const_fmul_one   : fma_const_fmul_one_before  ⊑  fma_const_fmul_one_combined := by
  unfold fma_const_fmul_one_before fma_const_fmul_one_combined
  simp_alive_peephole
  sorry
def fma_const_fmul_one2_combined := [llvmfunc|
  llvm.func @fma_const_fmul_one2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[1123123.0099110012, 9999.0000001000008]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fma_const_fmul_one2   : fma_const_fmul_one2_before  ⊑  fma_const_fmul_one2_combined := by
  unfold fma_const_fmul_one2_before fma_const_fmul_one2_combined
  simp_alive_peephole
  sorry
def fma_nan_and_const_0_combined := [llvmfunc|
  llvm.func @fma_nan_and_const_0(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_nan_and_const_0   : fma_nan_and_const_0_before  ⊑  fma_nan_and_const_0_combined := by
  unfold fma_nan_and_const_0_before fma_nan_and_const_0_combined
  simp_alive_peephole
  sorry
def fma_nan_and_const_1_combined := [llvmfunc|
  llvm.func @fma_nan_and_const_1(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_nan_and_const_1   : fma_nan_and_const_1_before  ⊑  fma_nan_and_const_1_combined := by
  unfold fma_nan_and_const_1_before fma_nan_and_const_1_combined
  simp_alive_peephole
  sorry
def fma_nan_and_const_2_combined := [llvmfunc|
  llvm.func @fma_nan_and_const_2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_nan_and_const_2   : fma_nan_and_const_2_before  ⊑  fma_nan_and_const_2_combined := by
  unfold fma_nan_and_const_2_before fma_nan_and_const_2_combined
  simp_alive_peephole
  sorry
def fma_undef_0_combined := [llvmfunc|
  llvm.func @fma_undef_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_undef_0   : fma_undef_0_before  ⊑  fma_undef_0_combined := by
  unfold fma_undef_0_before fma_undef_0_combined
  simp_alive_peephole
  sorry
def fma_undef_1_combined := [llvmfunc|
  llvm.func @fma_undef_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_undef_1   : fma_undef_1_before  ⊑  fma_undef_1_combined := by
  unfold fma_undef_1_before fma_undef_1_combined
  simp_alive_peephole
  sorry
def fma_undef_2_combined := [llvmfunc|
  llvm.func @fma_undef_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_undef_2   : fma_undef_2_before  ⊑  fma_undef_2_combined := by
  unfold fma_undef_2_before fma_undef_2_combined
  simp_alive_peephole
  sorry
def fma_partial_undef_0_combined := [llvmfunc|
  llvm.func @fma_partial_undef_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(199.00122999999999 : f64) : f64
    %1 = llvm.mlir.undef : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.intr.fma(%arg0, %6, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %7 : vector<2xf64>
  }]

theorem inst_combine_fma_partial_undef_0   : fma_partial_undef_0_before  ⊑  fma_partial_undef_0_combined := by
  unfold fma_partial_undef_0_before fma_partial_undef_0_combined
  simp_alive_peephole
  sorry
def fma_partial_undef_1_combined := [llvmfunc|
  llvm.func @fma_partial_undef_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(199.00122999999999 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.intr.fma(%arg0, %6, %arg1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %7 : vector<2xf64>
  }]

theorem inst_combine_fma_partial_undef_1   : fma_partial_undef_1_before  ⊑  fma_partial_undef_1_combined := by
  unfold fma_partial_undef_1_before fma_partial_undef_1_combined
  simp_alive_peephole
  sorry
def fma_partial_undef_2_combined := [llvmfunc|
  llvm.func @fma_partial_undef_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(199.00122999999999 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.intr.fma(%arg0, %arg1, %6)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<2xf64>, vector<2xf64>, vector<2xf64>) -> vector<2xf64>
    llvm.return %7 : vector<2xf64>
  }]

theorem inst_combine_fma_partial_undef_2   : fma_partial_undef_2_before  ⊑  fma_partial_undef_2_combined := by
  unfold fma_partial_undef_2_before fma_partial_undef_2_combined
  simp_alive_peephole
  sorry
def fma_nan_0_combined := [llvmfunc|
  llvm.func @fma_nan_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_nan_0   : fma_nan_0_before  ⊑  fma_nan_0_combined := by
  unfold fma_nan_0_before fma_nan_0_combined
  simp_alive_peephole
  sorry
def fma_nan_1_combined := [llvmfunc|
  llvm.func @fma_nan_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_nan_1   : fma_nan_1_before  ⊑  fma_nan_1_combined := by
  unfold fma_nan_1_before fma_nan_1_combined
  simp_alive_peephole
  sorry
def fma_nan_2_combined := [llvmfunc|
  llvm.func @fma_nan_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fma_nan_2   : fma_nan_2_before  ⊑  fma_nan_2_combined := by
  unfold fma_nan_2_before fma_nan_2_combined
  simp_alive_peephole
  sorry
def fmuladd_const_fmul_combined := [llvmfunc|
  llvm.func @fmuladd_const_fmul(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[0.014508727666632295, 0.091220877000912318]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_const_fmul   : fmuladd_const_fmul_before  ⊑  fmuladd_const_fmul_combined := by
  unfold fmuladd_const_fmul_before fmuladd_const_fmul_combined
  simp_alive_peephole
  sorry
def fmuladd_nan_and_const_0_combined := [llvmfunc|
  llvm.func @fmuladd_nan_and_const_0(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_nan_and_const_0   : fmuladd_nan_and_const_0_before  ⊑  fmuladd_nan_and_const_0_combined := by
  unfold fmuladd_nan_and_const_0_before fmuladd_nan_and_const_0_combined
  simp_alive_peephole
  sorry
def fmuladd_nan_and_const_1_combined := [llvmfunc|
  llvm.func @fmuladd_nan_and_const_1(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_nan_and_const_1   : fmuladd_nan_and_const_1_before  ⊑  fmuladd_nan_and_const_1_combined := by
  unfold fmuladd_nan_and_const_1_before fmuladd_nan_and_const_1_combined
  simp_alive_peephole
  sorry
def fmuladd_nan_and_const_2_combined := [llvmfunc|
  llvm.func @fmuladd_nan_and_const_2(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_nan_and_const_2   : fmuladd_nan_and_const_2_before  ⊑  fmuladd_nan_and_const_2_combined := by
  unfold fmuladd_nan_and_const_2_before fmuladd_nan_and_const_2_combined
  simp_alive_peephole
  sorry
def fmuladd_nan_0_combined := [llvmfunc|
  llvm.func @fmuladd_nan_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_nan_0   : fmuladd_nan_0_before  ⊑  fmuladd_nan_0_combined := by
  unfold fmuladd_nan_0_before fmuladd_nan_0_combined
  simp_alive_peephole
  sorry
def fmuladd_nan_1_combined := [llvmfunc|
  llvm.func @fmuladd_nan_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_nan_1   : fmuladd_nan_1_before  ⊑  fmuladd_nan_1_combined := by
  unfold fmuladd_nan_1_before fmuladd_nan_1_combined
  simp_alive_peephole
  sorry
def fmuladd_undef_0_combined := [llvmfunc|
  llvm.func @fmuladd_undef_0(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_undef_0   : fmuladd_undef_0_before  ⊑  fmuladd_undef_0_combined := by
  unfold fmuladd_undef_0_before fmuladd_undef_0_combined
  simp_alive_peephole
  sorry
def fmuladd_undef_1_combined := [llvmfunc|
  llvm.func @fmuladd_undef_1(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_undef_1   : fmuladd_undef_1_before  ⊑  fmuladd_undef_1_combined := by
  unfold fmuladd_undef_1_before fmuladd_undef_1_combined
  simp_alive_peephole
  sorry
def fmuladd_undef_2_combined := [llvmfunc|
  llvm.func @fmuladd_undef_2(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<0x7FF8000000000000> : vector<2xf64>) : vector<2xf64>
    llvm.return %0 : vector<2xf64>
  }]

theorem inst_combine_fmuladd_undef_2   : fmuladd_undef_2_before  ⊑  fmuladd_undef_2_combined := by
  unfold fmuladd_undef_2_before fmuladd_undef_2_combined
  simp_alive_peephole
  sorry
def fma_unary_shuffle_ops_combined := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.intr.fma(%arg0, %arg1, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %2 = llvm.shufflevector %1, %0 [1, 0] : vector<2xf32> 
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fma_unary_shuffle_ops   : fma_unary_shuffle_ops_before  ⊑  fma_unary_shuffle_ops_combined := by
  unfold fma_unary_shuffle_ops_before fma_unary_shuffle_ops_combined
  simp_alive_peephole
  sorry
def fma_unary_shuffle_ops_widening_combined := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_widening(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 1] : vector<2xf32> 
    llvm.call @use_vec3(%1) : (vector<3xf32>) -> ()
    %2 = llvm.intr.fma(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %3 = llvm.shufflevector %2, %0 [1, 0, 1] : vector<2xf32> 
    llvm.return %3 : vector<3xf32>
  }]

theorem inst_combine_fma_unary_shuffle_ops_widening   : fma_unary_shuffle_ops_widening_before  ⊑  fma_unary_shuffle_ops_widening_combined := by
  unfold fma_unary_shuffle_ops_widening_before fma_unary_shuffle_ops_widening_combined
  simp_alive_peephole
  sorry
def fma_unary_shuffle_ops_narrowing_combined := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_narrowing(%arg0: vector<3xf32>, %arg1: vector<3xf32>, %arg2: vector<3xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<3xf32>
    %1 = llvm.shufflevector %arg1, %0 [1, 0] : vector<3xf32> 
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.intr.fma(%arg0, %arg1, %arg2)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (vector<3xf32>, vector<3xf32>, vector<3xf32>) -> vector<3xf32>
    %3 = llvm.shufflevector %2, %0 [1, 0] : vector<3xf32> 
    llvm.return %3 : vector<2xf32>
  }]

theorem inst_combine_fma_unary_shuffle_ops_narrowing   : fma_unary_shuffle_ops_narrowing_before  ⊑  fma_unary_shuffle_ops_narrowing_combined := by
  unfold fma_unary_shuffle_ops_narrowing_before fma_unary_shuffle_ops_narrowing_combined
  simp_alive_peephole
  sorry
def fma_unary_shuffle_ops_unshuffled_combined := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_unshuffled(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xf32> 
    %3 = llvm.intr.fma(%1, %2, %arg2)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

theorem inst_combine_fma_unary_shuffle_ops_unshuffled   : fma_unary_shuffle_ops_unshuffled_before  ⊑  fma_unary_shuffle_ops_unshuffled_combined := by
  unfold fma_unary_shuffle_ops_unshuffled_before fma_unary_shuffle_ops_unshuffled_combined
  simp_alive_peephole
  sorry
def fma_unary_shuffle_ops_wrong_mask_combined := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_wrong_mask(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    %2 = llvm.shufflevector %arg1, %0 [0, 0] : vector<2xf32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xf32> 
    %4 = llvm.intr.fma(%1, %2, %3)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fma_unary_shuffle_ops_wrong_mask   : fma_unary_shuffle_ops_wrong_mask_before  ⊑  fma_unary_shuffle_ops_wrong_mask_combined := by
  unfold fma_unary_shuffle_ops_wrong_mask_before fma_unary_shuffle_ops_wrong_mask_combined
  simp_alive_peephole
  sorry
def fma_unary_shuffle_ops_uses_combined := [llvmfunc|
  llvm.func @fma_unary_shuffle_ops_uses(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : vector<2xf32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xf32> 
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xf32> 
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xf32> 
    llvm.call @use_vec(%3) : (vector<2xf32>) -> ()
    %4 = llvm.intr.fma(%1, %2, %3)  : (vector<2xf32>, vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fma_unary_shuffle_ops_uses   : fma_unary_shuffle_ops_uses_before  ⊑  fma_unary_shuffle_ops_uses_combined := by
  unfold fma_unary_shuffle_ops_uses_before fma_unary_shuffle_ops_uses_combined
  simp_alive_peephole
  sorry
