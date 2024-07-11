import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fadd
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fneg_op0_before := [llvmfunc|
  llvm.func @fneg_op0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fadd %1, %arg1  : f32
    llvm.return %2 : f32
  }]

def fneg_op1_before := [llvmfunc|
  llvm.func @fneg_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg1  : f32
    %2 = llvm.fadd %arg0, %1  : f32
    llvm.return %2 : f32
  }]

def fdiv_fneg1_before := [llvmfunc|
  llvm.func @fdiv_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %arg2  : f64
    %3 = llvm.fsub %1, %arg0  : f64
    %4 = llvm.fdiv %3, %arg1  : f64
    %5 = llvm.fadd %2, %4  : f64
    llvm.return %5 : f64
  }]

def fdiv_fneg2_before := [llvmfunc|
  llvm.func @fdiv_fneg2(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 8.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.frem %0, %arg2  : vector<2xf64>
    %3 = llvm.fsub %1, %arg0  : vector<2xf64>
    %4 = llvm.fdiv %arg1, %3  : vector<2xf64>
    %5 = llvm.fadd %2, %4  : vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }]

def fmul_fneg1_before := [llvmfunc|
  llvm.func @fmul_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %arg2  : f64
    %3 = llvm.fsub %1, %arg0  : f64
    %4 = llvm.fmul %3, %arg1  : f64
    %5 = llvm.fadd %2, %4  : f64
    llvm.return %5 : f64
  }]

def fmul_fneg2_before := [llvmfunc|
  llvm.func @fmul_fneg2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %3 = llvm.frem %0, %arg1  : f64
    %4 = llvm.frem %1, %arg2  : f64
    %5 = llvm.fsub %2, %arg0  : f64
    %6 = llvm.fmul %3, %5  : f64
    %7 = llvm.fadd %4, %6  : f64
    llvm.return %7 : f64
  }]

def fdiv_fneg1_commute_before := [llvmfunc|
  llvm.func @fdiv_fneg1_commute(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %arg2  : f64
    %3 = llvm.fsub %1, %arg0  : f64
    %4 = llvm.fdiv %3, %arg1  : f64
    %5 = llvm.fadd %4, %2  : f64
    llvm.return %5 : f64
  }]

def fdiv_fneg2_commute_before := [llvmfunc|
  llvm.func @fdiv_fneg2_commute(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 8.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.frem %0, %arg2  : vector<2xf64>
    %3 = llvm.fsub %1, %arg0  : vector<2xf64>
    %4 = llvm.fdiv %arg1, %3  : vector<2xf64>
    %5 = llvm.fadd %4, %2  : vector<2xf64>
    llvm.return %5 : vector<2xf64>
  }]

def fmul_fneg1_commute_before := [llvmfunc|
  llvm.func @fmul_fneg1_commute(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %arg2  : f64
    %3 = llvm.fsub %1, %arg0  : f64
    %4 = llvm.fmul %3, %arg1  : f64
    %5 = llvm.fadd %4, %2  : f64
    llvm.return %5 : f64
  }]

def fmul_fneg2_commute_before := [llvmfunc|
  llvm.func @fmul_fneg2_commute(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.100000e+01 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %3 = llvm.frem %0, %arg1  : f64
    %4 = llvm.frem %1, %arg2  : f64
    %5 = llvm.fsub %2, %arg0  : f64
    %6 = llvm.fmul %3, %5  : f64
    %7 = llvm.fadd %6, %4  : f64
    llvm.return %7 : f64
  }]

def fdiv_fneg1_extra_use_before := [llvmfunc|
  llvm.func @fdiv_fneg1_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.frem %0, %arg2  : f32
    %3 = llvm.fsub %1, %arg0  : f32
    %4 = llvm.fdiv %3, %arg1  : f32
    llvm.call @use(%4) : (f32) -> ()
    %5 = llvm.fadd %2, %4  : f32
    llvm.return %5 : f32
  }]

def fdiv_fneg2_extra_use_before := [llvmfunc|
  llvm.func @fdiv_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %3 = llvm.frem %0, %arg1  : f32
    %4 = llvm.frem %1, %arg2  : f32
    %5 = llvm.fsub %2, %arg0  : f32
    %6 = llvm.fdiv %3, %5  : f32
    llvm.call @use(%6) : (f32) -> ()
    %7 = llvm.fadd %4, %6  : f32
    llvm.return %7 : f32
  }]

def fmul_fneg1_extra_use_before := [llvmfunc|
  llvm.func @fmul_fneg1_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -1.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.frem %0, %arg2  : vector<2xf32>
    %3 = llvm.fsub %1, %arg0  : vector<2xf32>
    %4 = llvm.fmul %3, %arg1  : vector<2xf32>
    llvm.call @use_vec(%4) : (vector<2xf32>) -> ()
    %5 = llvm.fadd %2, %4  : vector<2xf32>
    llvm.return %5 : vector<2xf32>
  }]

def fmul_fneg2_extra_use_before := [llvmfunc|
  llvm.func @fmul_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %3 = llvm.frem %0, %arg1  : f32
    %4 = llvm.frem %1, %arg2  : f32
    %5 = llvm.fsub %2, %arg0  : f32
    %6 = llvm.fmul %3, %5  : f32
    llvm.call @use(%6) : (f32) -> ()
    %7 = llvm.fadd %4, %6  : f32
    llvm.return %7 : f32
  }]

def fdiv_fneg1_extra_use2_before := [llvmfunc|
  llvm.func @fdiv_fneg1_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %1, %arg1  : f32
    %3 = llvm.fadd %2, %arg2  : f32
    llvm.return %3 : f32
  }]

def fdiv_fneg2_extra_use2_before := [llvmfunc|
  llvm.func @fdiv_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %arg1, %1  : f32
    %3 = llvm.fadd %2, %arg2  : f32
    llvm.return %3 : f32
  }]

def fmul_fneg1_extra_use2_before := [llvmfunc|
  llvm.func @fmul_fneg1_extra_use2(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    %3 = llvm.fadd %2, %arg2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def fmul_fneg2_extra_use2_before := [llvmfunc|
  llvm.func @fmul_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.frem %0, %arg1  : f32
    %3 = llvm.fsub %1, %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.fmul %2, %3  : f32
    %5 = llvm.fadd %4, %arg2  : f32
    llvm.return %5 : f32
  }]

def fdiv_fneg1_extra_use3_before := [llvmfunc|
  llvm.func @fdiv_fneg1_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %1, %arg1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fadd %2, %arg2  : f32
    llvm.return %3 : f32
  }]

def fdiv_fneg2_extra_use3_before := [llvmfunc|
  llvm.func @fdiv_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fdiv %arg1, %1  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fadd %2, %arg2  : f32
    llvm.return %3 : f32
  }]

def fmul_fneg1_extra_use3_before := [llvmfunc|
  llvm.func @fmul_fneg1_extra_use3(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fmul %1, %arg1  : vector<2xf32>
    llvm.call @use_vec(%2) : (vector<2xf32>) -> ()
    %3 = llvm.fadd %2, %arg2  : vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def fmul_fneg2_extra_use3_before := [llvmfunc|
  llvm.func @fmul_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.frem %0, %arg1  : f32
    %3 = llvm.fsub %1, %arg0  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.fmul %2, %3  : f32
    llvm.call @use(%4) : (f32) -> ()
    %5 = llvm.fadd %4, %arg2  : f32
    llvm.return %5 : f32
  }]

def fadd_rdx_before := [llvmfunc|
  llvm.func @fadd_rdx(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, vector<4xf32>) -> f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fadd_rdx_commute_before := [llvmfunc|
  llvm.func @fadd_rdx_commute(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fdiv %0, %arg0  : f32
    %3 = "llvm.intr.vector.reduce.fadd"(%1, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %4 : f32
  }]

def fadd_rdx_fmf_before := [llvmfunc|
  llvm.func @fadd_rdx_fmf(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fadd_rdx_extra_use_before := [llvmfunc|
  llvm.func @fadd_rdx_extra_use(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32]

    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fadd_rdx_nonzero_start_const_op_before := [llvmfunc|
  llvm.func @fadd_rdx_nonzero_start_const_op(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(-9.000000e+00 : f32) : f32
    %2 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fadd_rdx_nonzero_start_variable_op_before := [llvmfunc|
  llvm.func @fadd_rdx_nonzero_start_variable_op(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %2 : f32
  }]

def fadd_fmul_common_op_before := [llvmfunc|
  llvm.func @fadd_fmul_common_op(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fadd_fmul_common_op_vec_before := [llvmfunc|
  llvm.func @fadd_fmul_common_op_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def fadd_fmul_common_op_commute_vec_before := [llvmfunc|
  llvm.func @fadd_fmul_common_op_commute_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -4.300000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %arg0  : vector<2xf32>
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %3 : vector<2xf32>
  }]

def fadd_fmul_common_op_use_before := [llvmfunc|
  llvm.func @fadd_fmul_common_op_use(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %2 : f32
  }]

def fadd_fmul_common_op_wrong_fmf_before := [llvmfunc|
  llvm.func @fadd_fmul_common_op_wrong_fmf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f32]

    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f32]

    llvm.return %2 : f32
  }]

def fadd_fneg_reass_commute0_before := [llvmfunc|
  llvm.func @fadd_fneg_reass_commute0(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %2 = llvm.fadd %arg0, %arg2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fadd_fneg_reass_commute1_before := [llvmfunc|
  llvm.func @fadd_fneg_reass_commute1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %3 : f32
  }]

def fadd_fneg_reass_commute2_before := [llvmfunc|
  llvm.func @fadd_fneg_reass_commute2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %arg2, %arg0  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %3 : f32
  }]

def fadd_fneg_reass_commute3_before := [llvmfunc|
  llvm.func @fadd_fneg_reass_commute3(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.call @use_vec(%0) : (vector<2xf32>) -> ()
    %1 = llvm.fsub %0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    %2 = llvm.fadd %arg2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>]

    llvm.return %3 : vector<2xf32>
  }]

def fadd_fneg_commute0_before := [llvmfunc|
  llvm.func @fadd_fneg_commute0(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %3 : f32
  }]

def fadd_reduce_sqr_sum_varA_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varA_order2_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_order2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %1, %4  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varA_order3_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_order3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %arg1, %3  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varA_order4_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_order4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %arg1, %2  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varA_order5_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_order5(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %0, %arg0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varB_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB_order1_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_order1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %5, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB_order2_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_order2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %4, %3  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB_order3_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_order3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg1, %arg0  : f32
    %2 = llvm.fmul %0, %1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB2_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB2_order1_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_order1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %5, %2  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB2_order2_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_order2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %arg1, %1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB2_order3_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_order3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %0, %arg0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varA_not_one_use1_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_not_one_use1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @fake_func(%4) : (f32) -> ()
    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varA_not_one_use2_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_not_one_use2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @fake_func(%1) : (f32) -> ()
    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varB_not_one_use1_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_not_one_use1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @fake_func(%2) : (f32) -> ()
    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB_not_one_use2_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_not_one_use2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @fake_func(%5) : (f32) -> ()
    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB2_not_one_use_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_not_one_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.call @fake_func(%2) : (f32) -> ()
    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varA_invalid1_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg0  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varA_invalid2_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg0  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varA_invalid3_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varA_invalid4_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg1, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varA_invalid5_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid5(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %5 : f32
  }]

def fadd_reduce_sqr_sum_varB_invalid1_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg0  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB_invalid2_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg1  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB_invalid3_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB_invalid4_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB_invalid5_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid5(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg1, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB2_invalid1_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_invalid1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB2_invalid2_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_invalid2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fadd_reduce_sqr_sum_varB2_invalid3_before := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_invalid3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg1, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32]

    llvm.return %6 : f32
  }]

def fneg_op0_combined := [llvmfunc|
  llvm.func @fneg_op0(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg1, %arg0  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fneg_op0   : fneg_op0_before  ⊑  fneg_op0_combined := by
  unfold fneg_op0_before fneg_op0_combined
  simp_alive_peephole
  sorry
def fneg_op1_combined := [llvmfunc|
  llvm.func @fneg_op1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fsub %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fneg_op1   : fneg_op1_before  ⊑  fneg_op1_combined := by
  unfold fneg_op1_before fneg_op1_combined
  simp_alive_peephole
  sorry
def fdiv_fneg1_combined := [llvmfunc|
  llvm.func @fdiv_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.frem %0, %arg2  : f64
    %2 = llvm.fdiv %arg0, %arg1  : f64
    %3 = llvm.fsub %1, %2  : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_fdiv_fneg1   : fdiv_fneg1_before  ⊑  fdiv_fneg1_combined := by
  unfold fdiv_fneg1_before fdiv_fneg1_combined
  simp_alive_peephole
  sorry
def fdiv_fneg2_combined := [llvmfunc|
  llvm.func @fdiv_fneg2(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 8.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.frem %0, %arg2  : vector<2xf64>
    %2 = llvm.fdiv %arg1, %arg0  : vector<2xf64>
    %3 = llvm.fsub %1, %2  : vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }]

theorem inst_combine_fdiv_fneg2   : fdiv_fneg2_before  ⊑  fdiv_fneg2_combined := by
  unfold fdiv_fneg2_before fdiv_fneg2_combined
  simp_alive_peephole
  sorry
def fmul_fneg1_combined := [llvmfunc|
  llvm.func @fmul_fneg1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.frem %0, %arg2  : f64
    %2 = llvm.fmul %arg0, %arg1  : f64
    %3 = llvm.fsub %1, %2  : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_fmul_fneg1   : fmul_fneg1_before  ⊑  fmul_fneg1_combined := by
  unfold fmul_fneg1_before fmul_fneg1_combined
  simp_alive_peephole
  sorry
def fmul_fneg2_combined := [llvmfunc|
  llvm.func @fmul_fneg2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.frem %0, %arg1  : f64
    %3 = llvm.frem %1, %arg2  : f64
    %4 = llvm.fmul %2, %arg0  : f64
    %5 = llvm.fsub %3, %4  : f64
    llvm.return %5 : f64
  }]

theorem inst_combine_fmul_fneg2   : fmul_fneg2_before  ⊑  fmul_fneg2_combined := by
  unfold fmul_fneg2_before fmul_fneg2_combined
  simp_alive_peephole
  sorry
def fdiv_fneg1_commute_combined := [llvmfunc|
  llvm.func @fdiv_fneg1_commute(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.frem %0, %arg2  : f64
    %2 = llvm.fdiv %arg0, %arg1  : f64
    %3 = llvm.fsub %1, %2  : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_fdiv_fneg1_commute   : fdiv_fneg1_commute_before  ⊑  fdiv_fneg1_commute_combined := by
  unfold fdiv_fneg1_commute_before fdiv_fneg1_commute_combined
  simp_alive_peephole
  sorry
def fdiv_fneg2_commute_combined := [llvmfunc|
  llvm.func @fdiv_fneg2_commute(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 8.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.frem %0, %arg2  : vector<2xf64>
    %2 = llvm.fdiv %arg1, %arg0  : vector<2xf64>
    %3 = llvm.fsub %1, %2  : vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }]

theorem inst_combine_fdiv_fneg2_commute   : fdiv_fneg2_commute_before  ⊑  fdiv_fneg2_commute_combined := by
  unfold fdiv_fneg2_commute_before fdiv_fneg2_commute_combined
  simp_alive_peephole
  sorry
def fmul_fneg1_commute_combined := [llvmfunc|
  llvm.func @fmul_fneg1_commute(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.frem %0, %arg2  : f64
    %2 = llvm.fmul %arg0, %arg1  : f64
    %3 = llvm.fsub %1, %2  : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_fmul_fneg1_commute   : fmul_fneg1_commute_before  ⊑  fmul_fneg1_commute_combined := by
  unfold fmul_fneg1_commute_before fmul_fneg1_commute_combined
  simp_alive_peephole
  sorry
def fmul_fneg2_commute_combined := [llvmfunc|
  llvm.func @fmul_fneg2_commute(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(4.100000e+01 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.frem %0, %arg1  : f64
    %3 = llvm.frem %1, %arg2  : f64
    %4 = llvm.fmul %2, %arg0  : f64
    %5 = llvm.fsub %3, %4  : f64
    llvm.return %5 : f64
  }]

theorem inst_combine_fmul_fneg2_commute   : fmul_fneg2_commute_before  ⊑  fmul_fneg2_commute_combined := by
  unfold fmul_fneg2_commute_before fmul_fneg2_commute_combined
  simp_alive_peephole
  sorry
def fdiv_fneg1_extra_use_combined := [llvmfunc|
  llvm.func @fdiv_fneg1_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.frem %0, %arg2  : f32
    %2 = llvm.fneg %arg0  : f32
    %3 = llvm.fdiv %2, %arg1  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.fadd %1, %3  : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fdiv_fneg1_extra_use   : fdiv_fneg1_extra_use_before  ⊑  fdiv_fneg1_extra_use_combined := by
  unfold fdiv_fneg1_extra_use_before fdiv_fneg1_extra_use_combined
  simp_alive_peephole
  sorry
def fdiv_fneg2_extra_use_combined := [llvmfunc|
  llvm.func @fdiv_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.frem %0, %arg1  : f32
    %3 = llvm.frem %1, %arg2  : f32
    %4 = llvm.fneg %arg0  : f32
    %5 = llvm.fdiv %2, %4  : f32
    llvm.call @use(%5) : (f32) -> ()
    %6 = llvm.fadd %3, %5  : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fdiv_fneg2_extra_use   : fdiv_fneg2_extra_use_before  ⊑  fdiv_fneg2_extra_use_combined := by
  unfold fdiv_fneg2_extra_use_before fdiv_fneg2_extra_use_combined
  simp_alive_peephole
  sorry
def fmul_fneg1_extra_use_combined := [llvmfunc|
  llvm.func @fmul_fneg1_extra_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, -1.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.frem %0, %arg2  : vector<2xf32>
    %2 = llvm.fneg %arg0  : vector<2xf32>
    %3 = llvm.fmul %2, %arg1  : vector<2xf32>
    llvm.call @use_vec(%3) : (vector<2xf32>) -> ()
    %4 = llvm.fadd %1, %3  : vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

theorem inst_combine_fmul_fneg1_extra_use   : fmul_fneg1_extra_use_before  ⊑  fmul_fneg1_extra_use_combined := by
  unfold fmul_fneg1_extra_use_before fmul_fneg1_extra_use_combined
  simp_alive_peephole
  sorry
def fmul_fneg2_extra_use_combined := [llvmfunc|
  llvm.func @fmul_fneg2_extra_use(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.frem %0, %arg1  : f32
    %3 = llvm.frem %1, %arg2  : f32
    %4 = llvm.fneg %arg0  : f32
    %5 = llvm.fmul %2, %4  : f32
    llvm.call @use(%5) : (f32) -> ()
    %6 = llvm.fadd %3, %5  : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fmul_fneg2_extra_use   : fmul_fneg2_extra_use_before  ⊑  fmul_fneg2_extra_use_combined := by
  unfold fmul_fneg2_extra_use_before fmul_fneg2_extra_use_combined
  simp_alive_peephole
  sorry
def fdiv_fneg1_extra_use2_combined := [llvmfunc|
  llvm.func @fdiv_fneg1_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fdiv %arg0, %arg1  : f32
    %2 = llvm.fsub %arg2, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fneg1_extra_use2   : fdiv_fneg1_extra_use2_before  ⊑  fdiv_fneg1_extra_use2_combined := by
  unfold fdiv_fneg1_extra_use2_before fdiv_fneg1_extra_use2_combined
  simp_alive_peephole
  sorry
def fdiv_fneg2_extra_use2_combined := [llvmfunc|
  llvm.func @fdiv_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fdiv %arg1, %arg0  : f32
    %2 = llvm.fsub %arg2, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fneg2_extra_use2   : fdiv_fneg2_extra_use2_before  ⊑  fdiv_fneg2_extra_use2_combined := by
  unfold fdiv_fneg2_extra_use2_before fdiv_fneg2_extra_use2_combined
  simp_alive_peephole
  sorry
def fmul_fneg1_extra_use2_combined := [llvmfunc|
  llvm.func @fmul_fneg1_extra_use2(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    llvm.call @use_vec(%0) : (vector<2xf32>) -> ()
    %1 = llvm.fmul %arg0, %arg1  : vector<2xf32>
    %2 = llvm.fsub %arg2, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fmul_fneg1_extra_use2   : fmul_fneg1_extra_use2_before  ⊑  fmul_fneg1_extra_use2_combined := by
  unfold fmul_fneg1_extra_use2_before fmul_fneg1_extra_use2_combined
  simp_alive_peephole
  sorry
def fmul_fneg2_extra_use2_combined := [llvmfunc|
  llvm.func @fmul_fneg2_extra_use2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.frem %0, %arg1  : f32
    %2 = llvm.fneg %arg0  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fmul %1, %arg0  : f32
    %4 = llvm.fsub %arg2, %3  : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fmul_fneg2_extra_use2   : fmul_fneg2_extra_use2_before  ⊑  fmul_fneg2_extra_use2_combined := by
  unfold fmul_fneg2_extra_use2_before fmul_fneg2_extra_use2_combined
  simp_alive_peephole
  sorry
def fdiv_fneg1_extra_use3_combined := [llvmfunc|
  llvm.func @fdiv_fneg1_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fdiv %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %1, %arg2  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fneg1_extra_use3   : fdiv_fneg1_extra_use3_before  ⊑  fdiv_fneg1_extra_use3_combined := by
  unfold fdiv_fneg1_extra_use3_before fdiv_fneg1_extra_use3_combined
  simp_alive_peephole
  sorry
def fdiv_fneg2_extra_use3_combined := [llvmfunc|
  llvm.func @fdiv_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fdiv %arg1, %0  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %1, %arg2  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fdiv_fneg2_extra_use3   : fdiv_fneg2_extra_use3_before  ⊑  fdiv_fneg2_extra_use3_combined := by
  unfold fdiv_fneg2_extra_use3_before fdiv_fneg2_extra_use3_combined
  simp_alive_peephole
  sorry
def fmul_fneg1_extra_use3_combined := [llvmfunc|
  llvm.func @fmul_fneg1_extra_use3(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    llvm.call @use_vec(%0) : (vector<2xf32>) -> ()
    %1 = llvm.fmul %0, %arg1  : vector<2xf32>
    llvm.call @use_vec(%1) : (vector<2xf32>) -> ()
    %2 = llvm.fadd %1, %arg2  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fmul_fneg1_extra_use3   : fmul_fneg1_extra_use3_before  ⊑  fmul_fneg1_extra_use3_combined := by
  unfold fmul_fneg1_extra_use3_before fmul_fneg1_extra_use3_combined
  simp_alive_peephole
  sorry
def fmul_fneg2_extra_use3_combined := [llvmfunc|
  llvm.func @fmul_fneg2_extra_use3(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(-4.200000e+01 : f32) : f32
    %1 = llvm.frem %0, %arg1  : f32
    %2 = llvm.fneg %arg0  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fmul %1, %2  : f32
    llvm.call @use(%3) : (f32) -> ()
    %4 = llvm.fadd %3, %arg2  : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fmul_fneg2_extra_use3   : fmul_fneg2_extra_use3_before  ⊑  fmul_fneg2_extra_use3_combined := by
  unfold fmul_fneg2_extra_use3_before fmul_fneg2_extra_use3_combined
  simp_alive_peephole
  sorry
def fadd_rdx_combined := [llvmfunc|
  llvm.func @fadd_rdx(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = "llvm.intr.vector.reduce.fadd"(%arg0, %arg1) <{fastmathFlags = #llvm.fastmath<fast>}> : (f32, vector<4xf32>) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fadd_rdx   : fadd_rdx_before  ⊑  fadd_rdx_combined := by
  unfold fadd_rdx_before fadd_rdx_combined
  simp_alive_peephole
  sorry
def fadd_rdx_commute_combined := [llvmfunc|
  llvm.func @fadd_rdx_commute(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fdiv %0, %arg0  : f32
    %2 = "llvm.intr.vector.reduce.fadd"(%1, %arg1) <{fastmathFlags = #llvm.fastmath<nsz, reassoc>}> : (f32, vector<4xf32>) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fadd_rdx_commute   : fadd_rdx_commute_before  ⊑  fadd_rdx_commute_combined := by
  unfold fadd_rdx_commute_before fadd_rdx_commute_combined
  simp_alive_peephole
  sorry
def fadd_rdx_fmf_combined := [llvmfunc|
  llvm.func @fadd_rdx_fmf(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fadd_rdx_fmf   : fadd_rdx_fmf_before  ⊑  fadd_rdx_fmf_combined := by
  unfold fadd_rdx_fmf_before fadd_rdx_fmf_combined
  simp_alive_peephole
  sorry
def fadd_rdx_extra_use_combined := [llvmfunc|
  llvm.func @fadd_rdx_extra_use(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fadd_rdx_extra_use   : fadd_rdx_extra_use_before  ⊑  fadd_rdx_extra_use_combined := by
  unfold fadd_rdx_extra_use_before fadd_rdx_extra_use_combined
  simp_alive_peephole
  sorry
def fadd_rdx_nonzero_start_const_op_combined := [llvmfunc|
  llvm.func @fadd_rdx_nonzero_start_const_op(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(3.300000e+01 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg0) <{fastmathFlags = #llvm.fastmath<ninf, nsz, reassoc>}> : (f32, vector<4xf32>) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_rdx_nonzero_start_const_op   : fadd_rdx_nonzero_start_const_op_before  ⊑  fadd_rdx_nonzero_start_const_op_combined := by
  unfold fadd_rdx_nonzero_start_const_op_before fadd_rdx_nonzero_start_const_op_combined
  simp_alive_peephole
  sorry
def fadd_rdx_nonzero_start_variable_op_combined := [llvmfunc|
  llvm.func @fadd_rdx_nonzero_start_variable_op(%arg0: f32, %arg1: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = "llvm.intr.vector.reduce.fadd"(%0, %arg1) <{fastmathFlags = #llvm.fastmath<none>}> : (f32, vector<4xf32>) -> f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fadd_rdx_nonzero_start_variable_op   : fadd_rdx_nonzero_start_variable_op_before  ⊑  fadd_rdx_nonzero_start_variable_op_combined := by
  unfold fadd_rdx_nonzero_start_variable_op_before fadd_rdx_nonzero_start_variable_op_combined
  simp_alive_peephole
  sorry
def fadd_fmul_common_op_combined := [llvmfunc|
  llvm.func @fadd_fmul_common_op(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.300000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_fmul_common_op   : fadd_fmul_common_op_before  ⊑  fadd_fmul_common_op_combined := by
  unfold fadd_fmul_common_op_before fadd_fmul_common_op_combined
  simp_alive_peephole
  sorry
def fadd_fmul_common_op_vec_combined := [llvmfunc|
  llvm.func @fadd_fmul_common_op_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<4.300000e+01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fadd_fmul_common_op_vec   : fadd_fmul_common_op_vec_before  ⊑  fadd_fmul_common_op_vec_combined := by
  unfold fadd_fmul_common_op_vec_before fadd_fmul_common_op_vec_combined
  simp_alive_peephole
  sorry
def fadd_fmul_common_op_commute_vec_combined := [llvmfunc|
  llvm.func @fadd_fmul_common_op_commute_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.300000e+01, -4.200000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fmul %arg0, %arg0  : vector<2xf32>
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_fadd_fmul_common_op_commute_vec   : fadd_fmul_common_op_commute_vec_before  ⊑  fadd_fmul_common_op_commute_vec_combined := by
  unfold fadd_fmul_common_op_commute_vec_before fadd_fmul_common_op_commute_vec_combined
  simp_alive_peephole
  sorry
def fadd_fmul_common_op_use_combined := [llvmfunc|
  llvm.func @fadd_fmul_common_op_use(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(4.300000e+01 : f32) : f32
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fadd_fmul_common_op_use   : fadd_fmul_common_op_use_before  ⊑  fadd_fmul_common_op_use_combined := by
  unfold fadd_fmul_common_op_use_before fadd_fmul_common_op_use_combined
  simp_alive_peephole
  sorry
def fadd_fmul_common_op_wrong_fmf_combined := [llvmfunc|
  llvm.func @fadd_fmul_common_op_wrong_fmf(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f32
    %2 = llvm.fadd %1, %arg0  {fastmathFlags = #llvm.fastmath<ninf, nsz>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fadd_fmul_common_op_wrong_fmf   : fadd_fmul_common_op_wrong_fmf_before  ⊑  fadd_fmul_common_op_wrong_fmf_combined := by
  unfold fadd_fmul_common_op_wrong_fmf_before fadd_fmul_common_op_wrong_fmf_combined
  simp_alive_peephole
  sorry
def fadd_fneg_reass_commute0_combined := [llvmfunc|
  llvm.func @fadd_fneg_reass_commute0(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %arg2, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_fneg_reass_commute0   : fadd_fneg_reass_commute0_before  ⊑  fadd_fneg_reass_commute0_combined := by
  unfold fadd_fneg_reass_commute0_before fadd_fneg_reass_commute0_combined
  simp_alive_peephole
  sorry
def fadd_fneg_reass_commute1_combined := [llvmfunc|
  llvm.func @fadd_fneg_reass_commute1(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fsub %arg2, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_fadd_fneg_reass_commute1   : fadd_fneg_reass_commute1_before  ⊑  fadd_fneg_reass_commute1_combined := by
  unfold fadd_fneg_reass_commute1_before fadd_fneg_reass_commute1_combined
  simp_alive_peephole
  sorry
def fadd_fneg_reass_commute2_combined := [llvmfunc|
  llvm.func @fadd_fneg_reass_commute2(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  : f32
    llvm.call @use(%1) : (f32) -> ()
    %2 = llvm.fadd %arg2, %arg0  : f32
    llvm.call @use(%2) : (f32) -> ()
    %3 = llvm.fsub %arg2, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fadd_fneg_reass_commute2   : fadd_fneg_reass_commute2_before  ⊑  fadd_fneg_reass_commute2_combined := by
  unfold fadd_fneg_reass_commute2_before fadd_fneg_reass_commute2_combined
  simp_alive_peephole
  sorry
def fadd_fneg_reass_commute3_combined := [llvmfunc|
  llvm.func @fadd_fneg_reass_commute3(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.call @use_vec(%0) : (vector<2xf32>) -> ()
    %1 = llvm.fsub %arg2, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fadd_fneg_reass_commute3   : fadd_fneg_reass_commute3_before  ⊑  fadd_fneg_reass_commute3_combined := by
  unfold fadd_fneg_reass_commute3_before fadd_fneg_reass_commute3_combined
  simp_alive_peephole
  sorry
def fadd_fneg_commute0_combined := [llvmfunc|
  llvm.func @fadd_fneg_commute0(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.fsub %0, %arg1  : f32
    %2 = llvm.fadd %arg0, %arg2  : f32
    %3 = llvm.fadd %1, %2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_fadd_fneg_commute0   : fadd_fneg_commute0_before  ⊑  fadd_fneg_commute0_combined := by
  unfold fadd_fneg_commute0_before fadd_fneg_commute0_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA   : fadd_reduce_sqr_sum_varA_before  ⊑  fadd_reduce_sqr_sum_varA_combined := by
  unfold fadd_reduce_sqr_sum_varA_before fadd_reduce_sqr_sum_varA_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_order2_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_order2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_order2   : fadd_reduce_sqr_sum_varA_order2_before  ⊑  fadd_reduce_sqr_sum_varA_order2_combined := by
  unfold fadd_reduce_sqr_sum_varA_order2_before fadd_reduce_sqr_sum_varA_order2_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_order3_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_order3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_order3   : fadd_reduce_sqr_sum_varA_order3_before  ⊑  fadd_reduce_sqr_sum_varA_order3_combined := by
  unfold fadd_reduce_sqr_sum_varA_order3_before fadd_reduce_sqr_sum_varA_order3_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_order4_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_order4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_order4   : fadd_reduce_sqr_sum_varA_order4_before  ⊑  fadd_reduce_sqr_sum_varA_order4_combined := by
  unfold fadd_reduce_sqr_sum_varA_order4_before fadd_reduce_sqr_sum_varA_order4_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_order5_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_order5(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_order5   : fadd_reduce_sqr_sum_varA_order5_before  ⊑  fadd_reduce_sqr_sum_varA_order5_combined := by
  unfold fadd_reduce_sqr_sum_varA_order5_before fadd_reduce_sqr_sum_varA_order5_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB   : fadd_reduce_sqr_sum_varB_before  ⊑  fadd_reduce_sqr_sum_varB_combined := by
  unfold fadd_reduce_sqr_sum_varB_before fadd_reduce_sqr_sum_varB_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_order1_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_order1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_order1   : fadd_reduce_sqr_sum_varB_order1_before  ⊑  fadd_reduce_sqr_sum_varB_order1_combined := by
  unfold fadd_reduce_sqr_sum_varB_order1_before fadd_reduce_sqr_sum_varB_order1_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_order2_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_order2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_order2   : fadd_reduce_sqr_sum_varB_order2_before  ⊑  fadd_reduce_sqr_sum_varB_order2_combined := by
  unfold fadd_reduce_sqr_sum_varB_order2_before fadd_reduce_sqr_sum_varB_order2_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_order3_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_order3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg1, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_order3   : fadd_reduce_sqr_sum_varB_order3_before  ⊑  fadd_reduce_sqr_sum_varB_order3_combined := by
  unfold fadd_reduce_sqr_sum_varB_order3_before fadd_reduce_sqr_sum_varB_order3_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB2_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB2   : fadd_reduce_sqr_sum_varB2_before  ⊑  fadd_reduce_sqr_sum_varB2_combined := by
  unfold fadd_reduce_sqr_sum_varB2_before fadd_reduce_sqr_sum_varB2_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB2_order1_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_order1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB2_order1   : fadd_reduce_sqr_sum_varB2_order1_before  ⊑  fadd_reduce_sqr_sum_varB2_order1_combined := by
  unfold fadd_reduce_sqr_sum_varB2_order1_before fadd_reduce_sqr_sum_varB2_order1_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB2_order2_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_order2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB2_order2   : fadd_reduce_sqr_sum_varB2_order2_before  ⊑  fadd_reduce_sqr_sum_varB2_order2_combined := by
  unfold fadd_reduce_sqr_sum_varB2_order2_before fadd_reduce_sqr_sum_varB2_order2_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB2_order3_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_order3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB2_order3   : fadd_reduce_sqr_sum_varB2_order3_before  ⊑  fadd_reduce_sqr_sum_varB2_order3_combined := by
  unfold fadd_reduce_sqr_sum_varB2_order3_before fadd_reduce_sqr_sum_varB2_order3_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_not_one_use1_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_not_one_use1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%4) : (f32) -> ()
    llvm.return %5 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_not_one_use1   : fadd_reduce_sqr_sum_varA_not_one_use1_before  ⊑  fadd_reduce_sqr_sum_varA_not_one_use1_combined := by
  unfold fadd_reduce_sqr_sum_varA_not_one_use1_before fadd_reduce_sqr_sum_varA_not_one_use1_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_not_one_use2_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_not_one_use2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%1) : (f32) -> ()
    llvm.return %5 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_not_one_use2   : fadd_reduce_sqr_sum_varA_not_one_use2_before  ⊑  fadd_reduce_sqr_sum_varA_not_one_use2_combined := by
  unfold fadd_reduce_sqr_sum_varA_not_one_use2_before fadd_reduce_sqr_sum_varA_not_one_use2_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_not_one_use1_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_not_one_use1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%2) : (f32) -> ()
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_not_one_use1   : fadd_reduce_sqr_sum_varB_not_one_use1_before  ⊑  fadd_reduce_sqr_sum_varB_not_one_use1_combined := by
  unfold fadd_reduce_sqr_sum_varB_not_one_use1_before fadd_reduce_sqr_sum_varB_not_one_use1_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_not_one_use2_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_not_one_use2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%5) : (f32) -> ()
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_not_one_use2   : fadd_reduce_sqr_sum_varB_not_one_use2_before  ⊑  fadd_reduce_sqr_sum_varB_not_one_use2_combined := by
  unfold fadd_reduce_sqr_sum_varB_not_one_use2_before fadd_reduce_sqr_sum_varB_not_one_use2_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB2_not_one_use_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_not_one_use(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.call @fake_func(%2) : (f32) -> ()
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB2_not_one_use   : fadd_reduce_sqr_sum_varB2_not_one_use_before  ⊑  fadd_reduce_sqr_sum_varB2_not_one_use_combined := by
  unfold fadd_reduce_sqr_sum_varB2_not_one_use_before fadd_reduce_sqr_sum_varB2_not_one_use_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_invalid1_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fadd %1, %arg1  : f32
    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %4 = llvm.fmul %3, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_invalid1   : fadd_reduce_sqr_sum_varA_invalid1_before  ⊑  fadd_reduce_sqr_sum_varA_invalid1_combined := by
  unfold fadd_reduce_sqr_sum_varA_invalid1_before fadd_reduce_sqr_sum_varA_invalid1_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_invalid2_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg0  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_invalid2   : fadd_reduce_sqr_sum_varA_invalid2_before  ⊑  fadd_reduce_sqr_sum_varA_invalid2_combined := by
  unfold fadd_reduce_sqr_sum_varA_invalid2_before fadd_reduce_sqr_sum_varA_invalid2_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_invalid3_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg0, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_invalid3   : fadd_reduce_sqr_sum_varA_invalid3_before  ⊑  fadd_reduce_sqr_sum_varA_invalid3_combined := by
  unfold fadd_reduce_sqr_sum_varA_invalid3_before fadd_reduce_sqr_sum_varA_invalid3_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_invalid4_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %arg1, %0  : f32
    %3 = llvm.fadd %2, %arg1  : f32
    %4 = llvm.fmul %3, %arg1  : f32
    %5 = llvm.fadd %4, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %5 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_invalid4   : fadd_reduce_sqr_sum_varA_invalid4_before  ⊑  fadd_reduce_sqr_sum_varA_invalid4_combined := by
  unfold fadd_reduce_sqr_sum_varA_invalid4_before fadd_reduce_sqr_sum_varA_invalid4_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varA_invalid5_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varA_invalid5(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fadd %1, %arg1  : f32
    %3 = llvm.fadd %2, %arg0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    %4 = llvm.fmul %3, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varA_invalid5   : fadd_reduce_sqr_sum_varA_invalid5_before  ⊑  fadd_reduce_sqr_sum_varA_invalid5_combined := by
  unfold fadd_reduce_sqr_sum_varA_invalid5_before fadd_reduce_sqr_sum_varA_invalid5_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_invalid1_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg0  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_invalid1   : fadd_reduce_sqr_sum_varB_invalid1_before  ⊑  fadd_reduce_sqr_sum_varB_invalid1_combined := by
  unfold fadd_reduce_sqr_sum_varB_invalid1_before fadd_reduce_sqr_sum_varB_invalid1_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_invalid2_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg1  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_invalid2   : fadd_reduce_sqr_sum_varB_invalid2_before  ⊑  fadd_reduce_sqr_sum_varB_invalid2_combined := by
  unfold fadd_reduce_sqr_sum_varB_invalid2_before fadd_reduce_sqr_sum_varB_invalid2_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_invalid3_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_invalid3   : fadd_reduce_sqr_sum_varB_invalid3_before  ⊑  fadd_reduce_sqr_sum_varB_invalid3_combined := by
  unfold fadd_reduce_sqr_sum_varB_invalid3_before fadd_reduce_sqr_sum_varB_invalid3_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_invalid4_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid4(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %arg0  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_invalid4   : fadd_reduce_sqr_sum_varB_invalid4_before  ⊑  fadd_reduce_sqr_sum_varB_invalid4_combined := by
  unfold fadd_reduce_sqr_sum_varB_invalid4_before fadd_reduce_sqr_sum_varB_invalid4_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB_invalid5_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB_invalid5(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg1, %arg1  : f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB_invalid5   : fadd_reduce_sqr_sum_varB_invalid5_before  ⊑  fadd_reduce_sqr_sum_varB_invalid5_combined := by
  unfold fadd_reduce_sqr_sum_varB_invalid5_before fadd_reduce_sqr_sum_varB_invalid5_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB2_invalid1_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_invalid1(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg0  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB2_invalid1   : fadd_reduce_sqr_sum_varB2_invalid1_before  ⊑  fadd_reduce_sqr_sum_varB2_invalid1_combined := by
  unfold fadd_reduce_sqr_sum_varB2_invalid1_before fadd_reduce_sqr_sum_varB2_invalid1_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB2_invalid2_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_invalid2(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.100000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB2_invalid2   : fadd_reduce_sqr_sum_varB2_invalid2_before  ⊑  fadd_reduce_sqr_sum_varB2_invalid2_combined := by
  unfold fadd_reduce_sqr_sum_varB2_invalid2_before fadd_reduce_sqr_sum_varB2_invalid2_combined
  simp_alive_peephole
  sorry
def fadd_reduce_sqr_sum_varB2_invalid3_combined := [llvmfunc|
  llvm.func @fadd_reduce_sqr_sum_varB2_invalid3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg1, %0  : f32
    %2 = llvm.fmul %1, %arg1  : f32
    %3 = llvm.fmul %arg0, %arg0  : f32
    %4 = llvm.fmul %arg1, %arg1  : f32
    %5 = llvm.fadd %3, %4  : f32
    %6 = llvm.fadd %2, %5  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f32
    llvm.return %6 : f32
  }]

theorem inst_combine_fadd_reduce_sqr_sum_varB2_invalid3   : fadd_reduce_sqr_sum_varB2_invalid3_before  ⊑  fadd_reduce_sqr_sum_varB2_invalid3_combined := by
  unfold fadd_reduce_sqr_sum_varB2_invalid3_before fadd_reduce_sqr_sum_varB2_invalid3_combined
  simp_alive_peephole
  sorry
