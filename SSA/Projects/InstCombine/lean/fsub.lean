import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fsub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }]

def test1_unary_before := [llvmfunc|
  llvm.func @test1_unary(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  : f32
    llvm.return %1 : f32
  }]

def neg_sub_nsz_before := [llvmfunc|
  llvm.func @neg_sub_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %2 : f32
  }]

def unary_neg_sub_nsz_before := [llvmfunc|
  llvm.func @unary_neg_sub_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %1 : f32
  }]

def neg_sub_nsz_extra_use_before := [llvmfunc|
  llvm.func @neg_sub_nsz_extra_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def unary_neg_sub_nsz_extra_use_before := [llvmfunc|
  llvm.func @unary_neg_sub_nsz_extra_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.call @use(%0) : (f32) -> ()
    llvm.return %1 : f32
  }]

def sub_sub_nsz_before := [llvmfunc|
  llvm.func @sub_sub_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %arg2, %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %1 : f32
  }]

def sub_add_neg_x_before := [llvmfunc|
  llvm.func @sub_add_neg_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fadd %1, %arg1  : f32
    %3 = llvm.fsub %arg1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def sub_sub_known_not_negzero_before := [llvmfunc|
  llvm.func @sub_sub_known_not_negzero(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fsub %arg0, %arg1  : f32
    %2 = llvm.fsub %0, %1  : f32
    llvm.return %2 : f32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg1  : f64
    %1 = llvm.fsub %arg0, %0  : f64
    llvm.return %1 : f64
  }]

def constant_op1_before := [llvmfunc|
  llvm.func @constant_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fsub %arg0, %0  : f32
    llvm.return %1 : f32
  }]

def constant_op1_vec_before := [llvmfunc|
  llvm.func @constant_op1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %arg0, %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def constant_op1_vec_poison_before := [llvmfunc|
  llvm.func @constant_op1_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %arg0, %6  : vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }]

def neg_op1_before := [llvmfunc|
  llvm.func @neg_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg1  : f32
    %2 = llvm.fsub %arg0, %1  : f32
    llvm.return %2 : f32
  }]

def unary_neg_op1_before := [llvmfunc|
  llvm.func @unary_neg_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg1  : f32
    %1 = llvm.fsub %arg0, %0  : f32
    llvm.return %1 : f32
  }]

def neg_op1_vec_before := [llvmfunc|
  llvm.func @neg_op1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg1  : vector<2xf32>
    %2 = llvm.fsub %arg0, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def unary_neg_op1_vec_before := [llvmfunc|
  llvm.func @unary_neg_op1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg1  : vector<2xf32>
    %1 = llvm.fsub %arg0, %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def neg_op1_vec_poison_before := [llvmfunc|
  llvm.func @neg_op1_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %6, %arg1  : vector<2xf32>
    %8 = llvm.fsub %arg0, %7  : vector<2xf32>
    llvm.return %8 : vector<2xf32>
  }]

def neg_ext_op1_before := [llvmfunc|
  llvm.func @neg_ext_op1(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fpext %1 : f32 to f64
    %3 = llvm.fsub %arg1, %2  : f64
    llvm.return %3 : f64
  }]

def unary_neg_ext_op1_before := [llvmfunc|
  llvm.func @unary_neg_ext_op1(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fpext %0 : f32 to f64
    %2 = llvm.fsub %arg1, %1  : f64
    llvm.return %2 : f64
  }]

def neg_trunc_op1_before := [llvmfunc|
  llvm.func @neg_trunc_op1(%arg0: vector<2xf64>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fsub %0, %arg0  : vector<2xf64>
    %2 = llvm.fptrunc %1 : vector<2xf64> to vector<2xf32>
    %3 = llvm.fsub %arg1, %2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def unary_neg_trunc_op1_before := [llvmfunc|
  llvm.func @unary_neg_trunc_op1(%arg0: vector<2xf64>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf64>
    %1 = llvm.fptrunc %0 : vector<2xf64> to vector<2xf32>
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def neg_ext_op1_fast_before := [llvmfunc|
  llvm.func @neg_ext_op1_fast(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fpext %1 : f32 to f64
    %3 = llvm.fsub %arg1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %3 : f64
  }]

def unary_neg_ext_op1_fast_before := [llvmfunc|
  llvm.func @unary_neg_ext_op1_fast(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fpext %0 : f32 to f64
    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %2 : f64
  }]

def neg_ext_op1_extra_use_before := [llvmfunc|
  llvm.func @neg_ext_op1_extra_use(%arg0: f16, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f16) : f16
    %1 = llvm.fsub %0, %arg0  : f16
    %2 = llvm.fpext %1 : f16 to f32
    %3 = llvm.fsub %arg1, %2  : f32
    llvm.call @use(%2) : (f32) -> ()
    llvm.return %3 : f32
  }]

def unary_neg_ext_op1_extra_use_before := [llvmfunc|
  llvm.func @unary_neg_ext_op1_extra_use(%arg0: f16, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.fpext %0 : f16 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def neg_trunc_op1_extra_use_before := [llvmfunc|
  llvm.func @neg_trunc_op1_extra_use(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    %3 = llvm.fsub %arg1, %2  : f32
    llvm.call @use(%2) : (f32) -> ()
    llvm.return %3 : f32
  }]

def unary_neg_trunc_op1_extra_use_before := [llvmfunc|
  llvm.func @unary_neg_trunc_op1_extra_use(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.fptrunc %0 : f64 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def neg_trunc_op1_extra_uses_before := [llvmfunc|
  llvm.func @neg_trunc_op1_extra_uses(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    %3 = llvm.fsub %arg1, %2  : f32
    llvm.call @use2(%2, %1) : (f32, f64) -> ()
    llvm.return %3 : f32
  }]

def unary_neg_trunc_op1_extra_uses_before := [llvmfunc|
  llvm.func @unary_neg_trunc_op1_extra_uses(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.fptrunc %0 : f64 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use2(%1, %0) : (f32, f64) -> ()
    llvm.return %2 : f32
  }]

def PR37605_before := [llvmfunc|
  llvm.func @PR37605(%arg0: f32) -> f32 {
    %0 = llvm.mlir.addressof @b : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fsub %arg0, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fdiv_fneg1_before := [llvmfunc|
  llvm.func @fsub_fdiv_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fdiv %1, %arg1  : f64
    %3 = llvm.fsub %arg2, %2  : f64
    llvm.return %3 : f64
  }]

def fsub_fdiv_fneg2_before := [llvmfunc|
  llvm.func @fsub_fdiv_fneg2(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fsub %0, %arg0  : vector<2xf64>
    %2 = llvm.fdiv %arg1, %1  : vector<2xf64>
    %3 = llvm.fsub %arg2, %2  : vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }]

def fsub_fmul_fneg1_before := [llvmfunc|
  llvm.func @fsub_fmul_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fmul %1, %arg1  : f64
    %3 = llvm.fsub %arg2, %2  : f64
    llvm.return %3 : f64
  }]

def fsub_fmul_fneg2_before := [llvmfunc|
  llvm.func @fsub_fmul_fneg2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.fmul %arg1, %1  : f64
    %3 = llvm.fsub %arg2, %2  : f64
    llvm.return %3 : f64
  }]

def fsub_fdiv_fneg1_extra_use_before := [llvmfunc|
  llvm.func @fsub_fdiv_fneg1_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fdiv %1, %arg1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fdiv_fneg2_extra_use_before := [llvmfunc|
  llvm.func @fsub_fdiv_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fdiv %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fmul_fneg1_extra_use_before := [llvmfunc|
  llvm.func @fsub_fmul_fneg1_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.fsub %arg2, %2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def fsub_fmul_fneg2_extra_use_before := [llvmfunc|
  llvm.func @fsub_fmul_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fmul %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fdiv_fneg1_extra_use2_before := [llvmfunc|
  llvm.func @fsub_fdiv_fneg1_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %1, %arg1  : f32
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fdiv_fneg2_extra_use2_before := [llvmfunc|
  llvm.func @fsub_fdiv_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %arg1, %1  : f32
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fmul_fneg1_extra_use2_before := [llvmfunc|
  llvm.func @fsub_fmul_fneg1_extra_use2(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    %3 = llvm.fsub %arg2, %2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def fsub_fmul_fneg2_extra_use2_before := [llvmfunc|
  llvm.func @fsub_fmul_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fmul %arg1, %1  : f32
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fdiv_fneg1_extra_use3_before := [llvmfunc|
  llvm.func @fsub_fdiv_fneg1_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %1, %arg1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fdiv_fneg2_extra_use3_before := [llvmfunc|
  llvm.func @fsub_fdiv_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fmul_fneg1_extra_use3_before := [llvmfunc|
  llvm.func @fsub_fmul_fneg1_extra_use3(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.fsub %arg2, %2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def fsub_fmul_fneg2_extra_use3_before := [llvmfunc|
  llvm.func @fsub_fmul_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fmul %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %2  : f32
    llvm.return %3 : f32
  }]

def fsub_fsub_before := [llvmfunc|
  llvm.func @fsub_fsub(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  : f32
    llvm.return %1 : f32
  }]

def fsub_fsub_nsz_before := [llvmfunc|
  llvm.func @fsub_fsub_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %1 : f32
  }]

def fsub_fsub_reassoc_before := [llvmfunc|
  llvm.func @fsub_fsub_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %1 : f32
  }]

def fsub_fsub_nsz_reassoc_before := [llvmfunc|
  llvm.func @fsub_fsub_nsz_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %1 : f32
  }]

def fsub_fsub_fast_vec_before := [llvmfunc|
  llvm.func @fsub_fsub_fast_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>]

    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def fsub_fsub_nsz_reassoc_extra_use_before := [llvmfunc|
  llvm.func @fsub_fsub_nsz_reassoc_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %1 : f32
  }]

def fneg_fsub_before := [llvmfunc|
  llvm.func @fneg_fsub(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fsub %0, %arg1  : f32
    llvm.return %1 : f32
  }]

def fneg_fsub_nsz_before := [llvmfunc|
  llvm.func @fneg_fsub_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %1 : f32
  }]

def fake_fneg_fsub_fast_before := [llvmfunc|
  llvm.func @fake_fneg_fsub_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fake_fneg_fsub_fast_extra_use_before := [llvmfunc|
  llvm.func @fake_fneg_fsub_fast_extra_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fake_fneg_fsub_vec_before := [llvmfunc|
  llvm.func @fake_fneg_fsub_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %1, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fneg_fsub_constant_before := [llvmfunc|
  llvm.func @fneg_fsub_constant(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fneg %arg0  : f32
    %2 = llvm.fsub %1, %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %2 : f32
  }]

def fsub_fadd_fsub_reassoc_before := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fsub_fadd_fsub_reassoc_commute_before := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc_commute(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg2, %0  : vector<2xf32>
    %2 = llvm.fsub %arg0, %arg1  : vector<2xf32>
    %3 = llvm.fadd %1, %2  : vector<2xf32>
    %4 = llvm.fsub %3, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    llvm.return %4 : vector<2xf32>
  }]

def fsub_fadd_fsub_reassoc_twice_before := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc_twice(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32, %arg4: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %1 = llvm.fsub %arg2, %arg3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fadd %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fsub %2, %arg4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fsub_fadd_fsub_not_reassoc_before := [llvmfunc|
  llvm.func @fsub_fadd_fsub_not_reassoc(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %2 : f32
  }]

def fsub_fadd_fsub_reassoc_use1_before := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc_use1(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fsub_fadd_fsub_reassoc_use2_before := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc_use2(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fmul_c1_before := [llvmfunc|
  llvm.func @fmul_c1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.return %2 : f32
  }]

def fmul_c1_fmf_before := [llvmfunc|
  llvm.func @fmul_c1_fmf(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 5.000000e-01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : vector<2xf32>]

    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def fmul_c1_use_before := [llvmfunc|
  llvm.func @fmul_c1_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.return %2 : f32
  }]

def fdiv_c0_before := [llvmfunc|
  llvm.func @fdiv_c0(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.mlir.constant(7.000000e+00 : f16) : f16
    %1 = llvm.fdiv %0, %arg0  : f16
    %2 = llvm.fsub %arg1, %1  : f16
    llvm.return %2 : f16
  }]

def fdiv_c0_fmf_before := [llvmfunc|
  llvm.func @fdiv_c0_fmf(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  : f64
    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def fdiv_c1_before := [llvmfunc|
  llvm.func @fdiv_c1(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.270000e+02, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg0, %0  : vector<2xf32>
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def fdiv_c1_fmf_before := [llvmfunc|
  llvm.func @fdiv_c1_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.270000e+02 : f32) : f32
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fdiv_c1_use_before := [llvmfunc|
  llvm.func @fdiv_c1_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.270000e+02, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg0, %0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_unary_combined := [llvmfunc|
  llvm.func @test1_unary(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test1_unary   : test1_unary_before  ⊑  test1_unary_combined := by
  unfold test1_unary_before test1_unary_combined
  simp_alive_peephole
  sorry
def neg_sub_nsz_combined := [llvmfunc|
  llvm.func @neg_sub_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_neg_sub_nsz   : neg_sub_nsz_before  ⊑  neg_sub_nsz_combined := by
  unfold neg_sub_nsz_before neg_sub_nsz_combined
  simp_alive_peephole
  sorry
def unary_neg_sub_nsz_combined := [llvmfunc|
  llvm.func @unary_neg_sub_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_unary_neg_sub_nsz   : unary_neg_sub_nsz_before  ⊑  unary_neg_sub_nsz_combined := by
  unfold unary_neg_sub_nsz_before unary_neg_sub_nsz_combined
  simp_alive_peephole
  sorry
def neg_sub_nsz_extra_use_combined := [llvmfunc|
  llvm.func @neg_sub_nsz_extra_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %1 : f32
  }]

theorem inst_combine_neg_sub_nsz_extra_use   : neg_sub_nsz_extra_use_before  ⊑  neg_sub_nsz_extra_use_combined := by
  unfold neg_sub_nsz_extra_use_before neg_sub_nsz_extra_use_combined
  simp_alive_peephole
  sorry
def unary_neg_sub_nsz_extra_use_combined := [llvmfunc|
  llvm.func @unary_neg_sub_nsz_extra_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.call @use(%0) : (f32) -> ()
    llvm.return %1 : f32
  }]

theorem inst_combine_unary_neg_sub_nsz_extra_use   : unary_neg_sub_nsz_extra_use_before  ⊑  unary_neg_sub_nsz_extra_use_combined := by
  unfold unary_neg_sub_nsz_extra_use_before unary_neg_sub_nsz_extra_use_combined
  simp_alive_peephole
  sorry
def sub_sub_nsz_combined := [llvmfunc|
  llvm.func @sub_sub_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_sub_sub_nsz   : sub_sub_nsz_before  ⊑  sub_sub_nsz_combined := by
  unfold sub_sub_nsz_before sub_sub_nsz_combined
  simp_alive_peephole
  sorry
def sub_add_neg_x_combined := [llvmfunc|
  llvm.func @sub_add_neg_x(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-5.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_sub_add_neg_x   : sub_add_neg_x_before  ⊑  sub_add_neg_x_combined := by
  unfold sub_add_neg_x_before sub_add_neg_x_combined
  simp_alive_peephole
  sorry
def sub_sub_known_not_negzero_combined := [llvmfunc|
  llvm.func @sub_sub_known_not_negzero(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fsub %arg1, %arg0  : f32
    %2 = llvm.fadd %1, %0  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_sub_sub_known_not_negzero   : sub_sub_known_not_negzero_before  ⊑  sub_sub_known_not_negzero_combined := by
  unfold sub_sub_known_not_negzero_before sub_sub_known_not_negzero_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg1  : f64
    %1 = llvm.fsub %arg0, %0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def constant_op1_combined := [llvmfunc|
  llvm.func @constant_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_constant_op1   : constant_op1_before  ⊑  constant_op1_combined := by
  unfold constant_op1_before constant_op1_combined
  simp_alive_peephole
  sorry
def constant_op1_vec_combined := [llvmfunc|
  llvm.func @constant_op1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[-4.200000e+01, 4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_constant_op1_vec   : constant_op1_vec_before  ⊑  constant_op1_vec_combined := by
  unfold constant_op1_vec_before constant_op1_vec_combined
  simp_alive_peephole
  sorry
def constant_op1_vec_poison_combined := [llvmfunc|
  llvm.func @constant_op1_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.poison : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fadd %arg0, %6  : vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }]

theorem inst_combine_constant_op1_vec_poison   : constant_op1_vec_poison_before  ⊑  constant_op1_vec_poison_combined := by
  unfold constant_op1_vec_poison_before constant_op1_vec_poison_combined
  simp_alive_peephole
  sorry
def neg_op1_combined := [llvmfunc|
  llvm.func @neg_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_neg_op1   : neg_op1_before  ⊑  neg_op1_combined := by
  unfold neg_op1_before neg_op1_combined
  simp_alive_peephole
  sorry
def unary_neg_op1_combined := [llvmfunc|
  llvm.func @unary_neg_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_unary_neg_op1   : unary_neg_op1_before  ⊑  unary_neg_op1_combined := by
  unfold unary_neg_op1_before unary_neg_op1_combined
  simp_alive_peephole
  sorry
def neg_op1_vec_combined := [llvmfunc|
  llvm.func @neg_op1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg0, %arg1  : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_neg_op1_vec   : neg_op1_vec_before  ⊑  neg_op1_vec_combined := by
  unfold neg_op1_vec_before neg_op1_vec_combined
  simp_alive_peephole
  sorry
def unary_neg_op1_vec_combined := [llvmfunc|
  llvm.func @unary_neg_op1_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg0, %arg1  : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_unary_neg_op1_vec   : unary_neg_op1_vec_before  ⊑  unary_neg_op1_vec_combined := by
  unfold unary_neg_op1_vec_before unary_neg_op1_vec_combined
  simp_alive_peephole
  sorry
def neg_op1_vec_poison_combined := [llvmfunc|
  llvm.func @neg_op1_vec_poison(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg0, %arg1  : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_neg_op1_vec_poison   : neg_op1_vec_poison_before  ⊑  neg_op1_vec_poison_combined := by
  unfold neg_op1_vec_poison_before neg_op1_vec_poison_combined
  simp_alive_peephole
  sorry
def neg_ext_op1_combined := [llvmfunc|
  llvm.func @neg_ext_op1(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fadd %0, %arg1  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_neg_ext_op1   : neg_ext_op1_before  ⊑  neg_ext_op1_combined := by
  unfold neg_ext_op1_before neg_ext_op1_combined
  simp_alive_peephole
  sorry
def unary_neg_ext_op1_combined := [llvmfunc|
  llvm.func @unary_neg_ext_op1(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fadd %0, %arg1  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_unary_neg_ext_op1   : unary_neg_ext_op1_before  ⊑  unary_neg_ext_op1_combined := by
  unfold unary_neg_ext_op1_before unary_neg_ext_op1_combined
  simp_alive_peephole
  sorry
def neg_trunc_op1_combined := [llvmfunc|
  llvm.func @neg_trunc_op1(%arg0: vector<2xf64>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fptrunc %arg0 : vector<2xf64> to vector<2xf32>
    %1 = llvm.fadd %0, %arg1  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_neg_trunc_op1   : neg_trunc_op1_before  ⊑  neg_trunc_op1_combined := by
  unfold neg_trunc_op1_before neg_trunc_op1_combined
  simp_alive_peephole
  sorry
def unary_neg_trunc_op1_combined := [llvmfunc|
  llvm.func @unary_neg_trunc_op1(%arg0: vector<2xf64>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fptrunc %arg0 : vector<2xf64> to vector<2xf32>
    %1 = llvm.fadd %0, %arg1  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_unary_neg_trunc_op1   : unary_neg_trunc_op1_before  ⊑  unary_neg_trunc_op1_combined := by
  unfold unary_neg_trunc_op1_before unary_neg_trunc_op1_combined
  simp_alive_peephole
  sorry
def neg_ext_op1_fast_combined := [llvmfunc|
  llvm.func @neg_ext_op1_fast(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fadd %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_neg_ext_op1_fast   : neg_ext_op1_fast_before  ⊑  neg_ext_op1_fast_combined := by
  unfold neg_ext_op1_fast_before neg_ext_op1_fast_combined
  simp_alive_peephole
  sorry
def unary_neg_ext_op1_fast_combined := [llvmfunc|
  llvm.func @unary_neg_ext_op1_fast(%arg0: f32, %arg1: f64) -> f64 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fadd %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_unary_neg_ext_op1_fast   : unary_neg_ext_op1_fast_before  ⊑  unary_neg_ext_op1_fast_combined := by
  unfold unary_neg_ext_op1_fast_before unary_neg_ext_op1_fast_combined
  simp_alive_peephole
  sorry
def neg_ext_op1_extra_use_combined := [llvmfunc|
  llvm.func @neg_ext_op1_extra_use(%arg0: f16, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.fpext %0 : f16 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_neg_ext_op1_extra_use   : neg_ext_op1_extra_use_before  ⊑  neg_ext_op1_extra_use_combined := by
  unfold neg_ext_op1_extra_use_before neg_ext_op1_extra_use_combined
  simp_alive_peephole
  sorry
def unary_neg_ext_op1_extra_use_combined := [llvmfunc|
  llvm.func @unary_neg_ext_op1_extra_use(%arg0: f16, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.fpext %0 : f16 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_unary_neg_ext_op1_extra_use   : unary_neg_ext_op1_extra_use_before  ⊑  unary_neg_ext_op1_extra_use_combined := by
  unfold unary_neg_ext_op1_extra_use_before unary_neg_ext_op1_extra_use_combined
  simp_alive_peephole
  sorry
def neg_trunc_op1_extra_use_combined := [llvmfunc|
  llvm.func @neg_trunc_op1_extra_use(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.fptrunc %arg0 : f64 to f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fadd %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_neg_trunc_op1_extra_use   : neg_trunc_op1_extra_use_before  ⊑  neg_trunc_op1_extra_use_combined := by
  unfold neg_trunc_op1_extra_use_before neg_trunc_op1_extra_use_combined
  simp_alive_peephole
  sorry
def unary_neg_trunc_op1_extra_use_combined := [llvmfunc|
  llvm.func @unary_neg_trunc_op1_extra_use(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.fptrunc %arg0 : f64 to f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.fadd %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_unary_neg_trunc_op1_extra_use   : unary_neg_trunc_op1_extra_use_before  ⊑  unary_neg_trunc_op1_extra_use_combined := by
  unfold unary_neg_trunc_op1_extra_use_before unary_neg_trunc_op1_extra_use_combined
  simp_alive_peephole
  sorry
def neg_trunc_op1_extra_uses_combined := [llvmfunc|
  llvm.func @neg_trunc_op1_extra_uses(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.fptrunc %0 : f64 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use2(%1, %0) : (f32, f64) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_neg_trunc_op1_extra_uses   : neg_trunc_op1_extra_uses_before  ⊑  neg_trunc_op1_extra_uses_combined := by
  unfold neg_trunc_op1_extra_uses_before neg_trunc_op1_extra_uses_combined
  simp_alive_peephole
  sorry
def unary_neg_trunc_op1_extra_uses_combined := [llvmfunc|
  llvm.func @unary_neg_trunc_op1_extra_uses(%arg0: f64, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.fptrunc %0 : f64 to f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.call @use2(%1, %0) : (f32, f64) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_unary_neg_trunc_op1_extra_uses   : unary_neg_trunc_op1_extra_uses_before  ⊑  unary_neg_trunc_op1_extra_uses_combined := by
  unfold unary_neg_trunc_op1_extra_uses_before unary_neg_trunc_op1_extra_uses_combined
  simp_alive_peephole
  sorry
def PR37605_combined := [llvmfunc|
  llvm.func @PR37605(%arg0: f32) -> f32 {
    %0 = llvm.mlir.addressof @b : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.bitcast %1 : i32 to f32
    %3 = llvm.fsub %arg0, %2  : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_PR37605   : PR37605_before  ⊑  PR37605_combined := by
  unfold PR37605_before PR37605_combined
  simp_alive_peephole
  sorry
def fsub_fdiv_fneg1_combined := [llvmfunc|
  llvm.func @fsub_fdiv_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg0, %arg1  : f64
    %1 = llvm.fadd %0, %arg2  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fsub_fdiv_fneg1   : fsub_fdiv_fneg1_before  ⊑  fsub_fdiv_fneg1_combined := by
  unfold fsub_fdiv_fneg1_before fsub_fdiv_fneg1_combined
  simp_alive_peephole
  sorry
def fsub_fdiv_fneg2_combined := [llvmfunc|
  llvm.func @fsub_fdiv_fneg2(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fdiv %arg1, %arg0  : vector<2xf64>
    %1 = llvm.fadd %0, %arg2  : vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fsub_fdiv_fneg2   : fsub_fdiv_fneg2_before  ⊑  fsub_fdiv_fneg2_combined := by
  unfold fsub_fdiv_fneg2_before fsub_fdiv_fneg2_combined
  simp_alive_peephole
  sorry
def fsub_fmul_fneg1_combined := [llvmfunc|
  llvm.func @fsub_fmul_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  : f64
    %1 = llvm.fadd %0, %arg2  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fsub_fmul_fneg1   : fsub_fmul_fneg1_before  ⊑  fsub_fmul_fneg1_combined := by
  unfold fsub_fmul_fneg1_before fsub_fmul_fneg1_combined
  simp_alive_peephole
  sorry
def fsub_fmul_fneg2_combined := [llvmfunc|
  llvm.func @fsub_fmul_fneg2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  : f64
    %1 = llvm.fadd %0, %arg2  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fsub_fmul_fneg2   : fsub_fmul_fneg2_before  ⊑  fsub_fmul_fneg2_combined := by
  unfold fsub_fmul_fneg2_before fsub_fmul_fneg2_combined
  simp_alive_peephole
  sorry
def fsub_fdiv_fneg1_extra_use_combined := [llvmfunc|
  llvm.func @fsub_fdiv_fneg1_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fdiv %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg2, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fdiv_fneg1_extra_use   : fsub_fdiv_fneg1_extra_use_before  ⊑  fsub_fdiv_fneg1_extra_use_combined := by
  unfold fsub_fdiv_fneg1_extra_use_before fsub_fdiv_fneg1_extra_use_combined
  simp_alive_peephole
  sorry
def fsub_fdiv_fneg2_extra_use_combined := [llvmfunc|
  llvm.func @fsub_fdiv_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fdiv %arg1, %0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg2, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fdiv_fneg2_extra_use   : fsub_fdiv_fneg2_extra_use_before  ⊑  fsub_fdiv_fneg2_extra_use_combined := by
  unfold fsub_fdiv_fneg2_extra_use_before fsub_fdiv_fneg2_extra_use_combined
  simp_alive_peephole
  sorry
def fsub_fmul_fneg1_extra_use_combined := [llvmfunc|
  llvm.func @fsub_fmul_fneg1_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.fmul %0, %arg1  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fsub %arg2, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fsub_fmul_fneg1_extra_use   : fsub_fmul_fneg1_extra_use_before  ⊑  fsub_fmul_fneg1_extra_use_combined := by
  unfold fsub_fmul_fneg1_extra_use_before fsub_fmul_fneg1_extra_use_combined
  simp_alive_peephole
  sorry
def fsub_fmul_fneg2_extra_use_combined := [llvmfunc|
  llvm.func @fsub_fmul_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fmul %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg2, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fmul_fneg2_extra_use   : fsub_fmul_fneg2_extra_use_before  ⊑  fsub_fmul_fneg2_extra_use_combined := by
  unfold fsub_fmul_fneg2_extra_use_before fsub_fmul_fneg2_extra_use_combined
  simp_alive_peephole
  sorry
def fsub_fdiv_fneg1_extra_use2_combined := [llvmfunc|
  llvm.func @fsub_fdiv_fneg1_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fdiv %arg0, %arg1  : f32
    %2 = llvm.fadd %1, %arg2  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fdiv_fneg1_extra_use2   : fsub_fdiv_fneg1_extra_use2_before  ⊑  fsub_fdiv_fneg1_extra_use2_combined := by
  unfold fsub_fdiv_fneg1_extra_use2_before fsub_fdiv_fneg1_extra_use2_combined
  simp_alive_peephole
  sorry
def fsub_fdiv_fneg2_extra_use2_combined := [llvmfunc|
  llvm.func @fsub_fdiv_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fdiv %arg1, %arg0  : f32
    %2 = llvm.fadd %1, %arg2  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fdiv_fneg2_extra_use2   : fsub_fdiv_fneg2_extra_use2_before  ⊑  fsub_fdiv_fneg2_extra_use2_combined := by
  unfold fsub_fdiv_fneg2_extra_use2_before fsub_fdiv_fneg2_extra_use2_combined
  simp_alive_peephole
  sorry
def fsub_fmul_fneg1_extra_use2_combined := [llvmfunc|
  llvm.func @fsub_fmul_fneg1_extra_use2(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    llvm.call @use_vec(%0) : (vector<2xf32>) -> ()
    %1 = llvm.fmul %arg0, %arg1  : vector<2xf32>
    %2 = llvm.fadd %1, %arg2  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fsub_fmul_fneg1_extra_use2   : fsub_fmul_fneg1_extra_use2_before  ⊑  fsub_fmul_fneg1_extra_use2_combined := by
  unfold fsub_fmul_fneg1_extra_use2_before fsub_fmul_fneg1_extra_use2_combined
  simp_alive_peephole
  sorry
def fsub_fmul_fneg2_extra_use2_combined := [llvmfunc|
  llvm.func @fsub_fmul_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fadd %1, %arg2  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fmul_fneg2_extra_use2   : fsub_fmul_fneg2_extra_use2_before  ⊑  fsub_fmul_fneg2_extra_use2_combined := by
  unfold fsub_fmul_fneg2_extra_use2_before fsub_fmul_fneg2_extra_use2_combined
  simp_alive_peephole
  sorry
def fsub_fdiv_fneg1_extra_use3_combined := [llvmfunc|
  llvm.func @fsub_fdiv_fneg1_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fdiv %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg2, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fdiv_fneg1_extra_use3   : fsub_fdiv_fneg1_extra_use3_before  ⊑  fsub_fdiv_fneg1_extra_use3_combined := by
  unfold fsub_fdiv_fneg1_extra_use3_before fsub_fdiv_fneg1_extra_use3_combined
  simp_alive_peephole
  sorry
def fsub_fdiv_fneg2_extra_use3_combined := [llvmfunc|
  llvm.func @fsub_fdiv_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fdiv %arg1, %0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg2, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fdiv_fneg2_extra_use3   : fsub_fdiv_fneg2_extra_use3_before  ⊑  fsub_fdiv_fneg2_extra_use3_combined := by
  unfold fsub_fdiv_fneg2_extra_use3_before fsub_fdiv_fneg2_extra_use3_combined
  simp_alive_peephole
  sorry
def fsub_fmul_fneg1_extra_use3_combined := [llvmfunc|
  llvm.func @fsub_fmul_fneg1_extra_use3(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    llvm.call @use_vec(%0) : (vector<2xf32>) -> ()
    %1 = llvm.fmul %0, %arg1  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fsub %arg2, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fsub_fmul_fneg1_extra_use3   : fsub_fmul_fneg1_extra_use3_before  ⊑  fsub_fmul_fneg1_extra_use3_combined := by
  unfold fsub_fmul_fneg1_extra_use3_before fsub_fmul_fneg1_extra_use3_combined
  simp_alive_peephole
  sorry
def fsub_fmul_fneg2_extra_use3_combined := [llvmfunc|
  llvm.func @fsub_fmul_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fmul %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg2, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fmul_fneg2_extra_use3   : fsub_fmul_fneg2_extra_use3_before  ⊑  fsub_fmul_fneg2_extra_use3_combined := by
  unfold fsub_fmul_fneg2_extra_use3_before fsub_fmul_fneg2_extra_use3_combined
  simp_alive_peephole
  sorry
def fsub_fsub_combined := [llvmfunc|
  llvm.func @fsub_fsub(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fsub_fsub   : fsub_fsub_before  ⊑  fsub_fsub_combined := by
  unfold fsub_fsub_before fsub_fsub_combined
  simp_alive_peephole
  sorry
def fsub_fsub_nsz_combined := [llvmfunc|
  llvm.func @fsub_fsub_nsz(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fsub_fsub_nsz   : fsub_fsub_nsz_before  ⊑  fsub_fsub_nsz_combined := by
  unfold fsub_fsub_nsz_before fsub_fsub_nsz_combined
  simp_alive_peephole
  sorry
def fsub_fsub_reassoc_combined := [llvmfunc|
  llvm.func @fsub_fsub_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fsub_fsub_reassoc   : fsub_fsub_reassoc_before  ⊑  fsub_fsub_reassoc_combined := by
  unfold fsub_fsub_reassoc_before fsub_fsub_reassoc_combined
  simp_alive_peephole
  sorry
def fsub_fsub_nsz_reassoc_combined := [llvmfunc|
  llvm.func @fsub_fsub_nsz_reassoc(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fsub_fsub_nsz_reassoc   : fsub_fsub_nsz_reassoc_before  ⊑  fsub_fsub_nsz_reassoc_combined := by
  unfold fsub_fsub_nsz_reassoc_before fsub_fsub_nsz_reassoc_combined
  simp_alive_peephole
  sorry
def fsub_fsub_fast_vec_combined := [llvmfunc|
  llvm.func @fsub_fsub_fast_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_fsub_fsub_fast_vec   : fsub_fsub_fast_vec_before  ⊑  fsub_fsub_fast_vec_combined := by
  unfold fsub_fsub_fast_vec_before fsub_fsub_fast_vec_combined
  simp_alive_peephole
  sorry
def fsub_fsub_nsz_reassoc_extra_use_combined := [llvmfunc|
  llvm.func @fsub_fsub_nsz_reassoc_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fsub_fsub_nsz_reassoc_extra_use   : fsub_fsub_nsz_reassoc_extra_use_before  ⊑  fsub_fsub_nsz_reassoc_extra_use_combined := by
  unfold fsub_fsub_nsz_reassoc_extra_use_before fsub_fsub_nsz_reassoc_extra_use_combined
  simp_alive_peephole
  sorry
def fneg_fsub_combined := [llvmfunc|
  llvm.func @fneg_fsub(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fsub %0, %arg1  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fneg_fsub   : fneg_fsub_before  ⊑  fneg_fsub_combined := by
  unfold fneg_fsub_before fneg_fsub_combined
  simp_alive_peephole
  sorry
def fneg_fsub_nsz_combined := [llvmfunc|
  llvm.func @fneg_fsub_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fneg_fsub_nsz   : fneg_fsub_nsz_before  ⊑  fneg_fsub_nsz_combined := by
  unfold fneg_fsub_nsz_before fneg_fsub_nsz_combined
  simp_alive_peephole
  sorry
def fake_fneg_fsub_fast_combined := [llvmfunc|
  llvm.func @fake_fneg_fsub_fast(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fake_fneg_fsub_fast   : fake_fneg_fsub_fast_before  ⊑  fake_fneg_fsub_fast_combined := by
  unfold fake_fneg_fsub_fast_before fake_fneg_fsub_fast_combined
  simp_alive_peephole
  sorry
def fake_fneg_fsub_fast_extra_use_combined := [llvmfunc|
  llvm.func @fake_fneg_fsub_fast_extra_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fake_fneg_fsub_fast_extra_use   : fake_fneg_fsub_fast_extra_use_before  ⊑  fake_fneg_fsub_fast_extra_use_combined := by
  unfold fake_fneg_fsub_fast_extra_use_before fake_fneg_fsub_fast_extra_use_combined
  simp_alive_peephole
  sorry
def fake_fneg_fsub_vec_combined := [llvmfunc|
  llvm.func @fake_fneg_fsub_vec(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fake_fneg_fsub_vec   : fake_fneg_fsub_vec_before  ⊑  fake_fneg_fsub_vec_combined := by
  unfold fake_fneg_fsub_vec_before fake_fneg_fsub_vec_combined
  simp_alive_peephole
  sorry
def fneg_fsub_constant_combined := [llvmfunc|
  llvm.func @fneg_fsub_constant(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fneg_fsub_constant   : fneg_fsub_constant_before  ⊑  fneg_fsub_constant_combined := by
  unfold fneg_fsub_constant_before fneg_fsub_constant_combined
  simp_alive_peephole
  sorry
def fsub_fadd_fsub_reassoc_combined := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fadd %arg1, %arg3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fsub %0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fadd_fsub_reassoc   : fsub_fadd_fsub_reassoc_before  ⊑  fsub_fadd_fsub_reassoc_combined := by
  unfold fsub_fadd_fsub_reassoc_before fsub_fadd_fsub_reassoc_combined
  simp_alive_peephole
  sorry
def fsub_fadd_fsub_reassoc_commute_combined := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc_commute(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg2, %0  : vector<2xf32>
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %3 = llvm.fadd %arg1, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    %4 = llvm.fsub %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fsub_fadd_fsub_reassoc_commute   : fsub_fadd_fsub_reassoc_commute_before  ⊑  fsub_fadd_fsub_reassoc_commute_combined := by
  unfold fsub_fadd_fsub_reassoc_commute_before fsub_fadd_fsub_reassoc_commute_combined
  simp_alive_peephole
  sorry
def fsub_fadd_fsub_reassoc_twice_combined := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc_twice(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32, %arg4: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %2 = llvm.fadd %0, %arg3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fsub_fadd_fsub_reassoc_twice   : fsub_fadd_fsub_reassoc_twice_before  ⊑  fsub_fadd_fsub_reassoc_twice_combined := by
  unfold fsub_fadd_fsub_reassoc_twice_before fsub_fadd_fsub_reassoc_twice_combined
  simp_alive_peephole
  sorry
def fsub_fadd_fsub_not_reassoc_combined := [llvmfunc|
  llvm.func @fsub_fadd_fsub_not_reassoc(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fadd_fsub_not_reassoc   : fsub_fadd_fsub_not_reassoc_before  ⊑  fsub_fadd_fsub_not_reassoc_combined := by
  unfold fsub_fadd_fsub_not_reassoc_before fsub_fadd_fsub_not_reassoc_combined
  simp_alive_peephole
  sorry
def fsub_fadd_fsub_reassoc_use1_combined := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc_use1(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fadd_fsub_reassoc_use1   : fsub_fadd_fsub_reassoc_use1_before  ⊑  fsub_fadd_fsub_reassoc_use1_combined := by
  unfold fsub_fadd_fsub_reassoc_use1_before fsub_fadd_fsub_reassoc_use1_combined
  simp_alive_peephole
  sorry
def fsub_fadd_fsub_reassoc_use2_combined := [llvmfunc|
  llvm.func @fsub_fadd_fsub_reassoc_use2(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %1, %arg3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_fadd_fsub_reassoc_use2   : fsub_fadd_fsub_reassoc_use2_before  ⊑  fsub_fadd_fsub_reassoc_use2_combined := by
  unfold fsub_fadd_fsub_reassoc_use2_before fsub_fadd_fsub_reassoc_use2_combined
  simp_alive_peephole
  sorry
def fmul_c1_combined := [llvmfunc|
  llvm.func @fmul_c1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_c1   : fmul_c1_before  ⊑  fmul_c1_combined := by
  unfold fmul_c1_before fmul_c1_combined
  simp_alive_peephole
  sorry
def fmul_c1_fmf_combined := [llvmfunc|
  llvm.func @fmul_c1_fmf(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 5.000000e-01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : vector<2xf32>
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fmul_c1_fmf   : fmul_c1_fmf_before  ⊑  fmul_c1_fmf_combined := by
  unfold fmul_c1_fmf_before fmul_c1_fmf_combined
  simp_alive_peephole
  sorry
def fmul_c1_use_combined := [llvmfunc|
  llvm.func @fmul_c1_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg1, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_c1_use   : fmul_c1_use_before  ⊑  fmul_c1_use_combined := by
  unfold fmul_c1_use_before fmul_c1_use_combined
  simp_alive_peephole
  sorry
def fdiv_c0_combined := [llvmfunc|
  llvm.func @fdiv_c0(%arg0: f16, %arg1: f16) -> f16 {
    %0 = llvm.mlir.constant(7.000000e+00 : f16) : f16
    %1 = llvm.fdiv %0, %arg0  : f16
    %2 = llvm.fsub %arg1, %1  : f16
    llvm.return %2 : f16
  }]

theorem inst_combine_fdiv_c0   : fdiv_c0_before  ⊑  fdiv_c0_combined := by
  unfold fdiv_c0_before fdiv_c0_combined
  simp_alive_peephole
  sorry
def fdiv_c0_fmf_combined := [llvmfunc|
  llvm.func @fdiv_c0_fmf(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  : f64
    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<nnan, reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_fdiv_c0_fmf   : fdiv_c0_fmf_before  ⊑  fdiv_c0_fmf_combined := by
  unfold fdiv_c0_fmf_before fdiv_c0_fmf_combined
  simp_alive_peephole
  sorry
def fdiv_c1_combined := [llvmfunc|
  llvm.func @fdiv_c1(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.270000e+02, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg0, %0  : vector<2xf32>
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fdiv_c1   : fdiv_c1_before  ⊑  fdiv_c1_combined := by
  unfold fdiv_c1_before fdiv_c1_combined
  simp_alive_peephole
  sorry
def fdiv_c1_fmf_combined := [llvmfunc|
  llvm.func @fdiv_c1_fmf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(4.270000e+02 : f32) : f32
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %2 = llvm.fsub %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_c1_fmf   : fdiv_c1_fmf_before  ⊑  fdiv_c1_fmf_combined := by
  unfold fdiv_c1_fmf_before fdiv_c1_fmf_combined
  simp_alive_peephole
  sorry
def fdiv_c1_use_combined := [llvmfunc|
  llvm.func @fdiv_c1_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.270000e+02, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fdiv %arg0, %0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fsub %arg1, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fdiv_c1_use   : fdiv_c1_use_before  ⊑  fdiv_c1_use_combined := by
  unfold fdiv_c1_use_before fdiv_c1_use_combined
  simp_alive_peephole
  sorry
