import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shuffle_select-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_before := [llvmfunc|
  llvm.func @add(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def add_nuw_nsw_before := [llvmfunc|
  llvm.func @add_nuw_nsw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def add_undef_mask_elt_before := [llvmfunc|
  llvm.func @add_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 5, -1, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def add_nuw_nsw_undef_mask_elt_before := [llvmfunc|
  llvm.func @add_nuw_nsw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def sub_before := [llvmfunc|
  llvm.func @sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def mul_before := [llvmfunc|
  llvm.func @mul(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def shl_before := [llvmfunc|
  llvm.func @shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [4, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def shl_nsw_before := [llvmfunc|
  llvm.func @shl_nsw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [4, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def shl_undef_mask_elt_before := [llvmfunc|
  llvm.func @shl_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def shl_nuw_undef_mask_elt_before := [llvmfunc|
  llvm.func @shl_nuw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def lshr_constant_op0_before := [llvmfunc|
  llvm.func @lshr_constant_op0(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def lshr_exact_constant_op0_before := [llvmfunc|
  llvm.func @lshr_exact_constant_op0(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def lshr_undef_mask_elt_before := [llvmfunc|
  llvm.func @lshr_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def lshr_exact_undef_mask_elt_before := [llvmfunc|
  llvm.func @lshr_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def lshr_constant_op1_before := [llvmfunc|
  llvm.func @lshr_constant_op1(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def ashr_before := [llvmfunc|
  llvm.func @ashr(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.ashr %arg0, %0  : vector<3xi32>
    %2 = llvm.shufflevector %1, %arg0 [3, 1, 2] : vector<3xi32> 
    llvm.return %2 : vector<3xi32>
  }]

def and_before := [llvmfunc|
  llvm.func @and(%arg0: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(13 : i42) : i42
    %1 = llvm.mlir.constant(12 : i42) : i42
    %2 = llvm.mlir.constant(11 : i42) : i42
    %3 = llvm.mlir.constant(dense<[11, 12, 13]> : vector<3xi42>) : vector<3xi42>
    %4 = llvm.and %arg0, %3  : vector<3xi42>
    %5 = llvm.shufflevector %arg0, %4 [0, 4, -1] : vector<3xi42> 
    llvm.return %5 : vector<3xi42>
  }]

def or_before := [llvmfunc|
  llvm.func @or(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.or %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [4, 5, 2, 3] : vector<4xi32> 
    llvm.call @use_v4i32(%1) : (vector<4xi32>) -> ()
    llvm.return %2 : vector<4xi32>
  }]

def xor_before := [llvmfunc|
  llvm.func @xor(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [0, 5, 2, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def udiv_before := [llvmfunc|
  llvm.func @udiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def udiv_exact_before := [llvmfunc|
  llvm.func @udiv_exact(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def udiv_undef_mask_elt_before := [llvmfunc|
  llvm.func @udiv_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def udiv_exact_undef_mask_elt_before := [llvmfunc|
  llvm.func @udiv_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def sdiv_before := [llvmfunc|
  llvm.func @sdiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 1, 6, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def sdiv_exact_before := [llvmfunc|
  llvm.func @sdiv_exact(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [4, 1, 6, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def sdiv_undef_mask_elt_before := [llvmfunc|
  llvm.func @sdiv_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def sdiv_exact_undef_mask_elt_before := [llvmfunc|
  llvm.func @sdiv_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def urem_before := [llvmfunc|
  llvm.func @urem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def urem_undef_mask_elt_before := [llvmfunc|
  llvm.func @urem_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def srem_before := [llvmfunc|
  llvm.func @srem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.srem %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

def fadd_maybe_nan_before := [llvmfunc|
  llvm.func @fadd_maybe_nan(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  : vector<4xf32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

def fadd_before := [llvmfunc|
  llvm.func @fadd(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  : vector<4xf32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

def fsub_before := [llvmfunc|
  llvm.func @fsub(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.fsub %0, %arg0  : vector<4xf64>
    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def fmul_before := [llvmfunc|
  llvm.func @fmul(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf32>]

    %2 = llvm.shufflevector %1, %arg0 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }]

def fdiv_constant_op0_before := [llvmfunc|
  llvm.func @fdiv_constant_op0(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf64>]

    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def fdiv_constant_op1_before := [llvmfunc|
  llvm.func @fdiv_constant_op1(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.fdiv %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf64>]

    %2 = llvm.shufflevector %arg0, %1 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def frem_before := [llvmfunc|
  llvm.func @frem(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, 4.300000e+01, 4.400000e+01]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.frem %0, %arg0  : vector<4xf64>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xf64> 
    llvm.return %2 : vector<4xf64>
  }]

def add_add_before := [llvmfunc|
  llvm.func @add_add(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.add %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def add_add_nsw_before := [llvmfunc|
  llvm.func @add_add_nsw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.add %arg0, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def add_add_undef_mask_elt_before := [llvmfunc|
  llvm.func @add_add_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.add %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, -1, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def add_add_nsw_undef_mask_elt_before := [llvmfunc|
  llvm.func @add_add_nsw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.add %arg0, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, -1, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sub_sub_before := [llvmfunc|
  llvm.func @sub_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sub_sub_nuw_before := [llvmfunc|
  llvm.func @sub_sub_nuw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.sub %1, %arg0 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sub_sub_undef_mask_elt_before := [llvmfunc|
  llvm.func @sub_sub_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sub_sub_nuw_undef_mask_elt_before := [llvmfunc|
  llvm.func @sub_sub_nuw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.sub %1, %arg0 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def mul_mul_before := [llvmfunc|
  llvm.func @mul_mul(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.mul %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_shl_before := [llvmfunc|
  llvm.func @shl_shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_shl_nuw_before := [llvmfunc|
  llvm.func @shl_shl_nuw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.shl %arg0, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_shl_undef_mask_elt_before := [llvmfunc|
  llvm.func @shl_shl_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_shl_nuw_undef_mask_elt_before := [llvmfunc|
  llvm.func @shl_shl_nuw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.shl %arg0, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def lshr_lshr_before := [llvmfunc|
  llvm.func @lshr_lshr(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def ashr_ashr_before := [llvmfunc|
  llvm.func @ashr_ashr(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[4, 5, 6]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.ashr %arg0, %0  : vector<3xi32>
    %3 = llvm.ashr %arg0, %1  : vector<3xi32>
    %4 = llvm.shufflevector %2, %3 [3, 1, 2] : vector<3xi32> 
    llvm.return %4 : vector<3xi32>
  }]

def and_and_before := [llvmfunc|
  llvm.func @and_and(%arg0: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(3 : i42) : i42
    %1 = llvm.mlir.constant(2 : i42) : i42
    %2 = llvm.mlir.constant(1 : i42) : i42
    %3 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi42>) : vector<3xi42>
    %4 = llvm.mlir.constant(6 : i42) : i42
    %5 = llvm.mlir.constant(5 : i42) : i42
    %6 = llvm.mlir.constant(4 : i42) : i42
    %7 = llvm.mlir.constant(dense<[4, 5, 6]> : vector<3xi42>) : vector<3xi42>
    %8 = llvm.and %arg0, %3  : vector<3xi42>
    %9 = llvm.and %arg0, %7  : vector<3xi42>
    %10 = llvm.shufflevector %8, %9 [0, 4, -1] : vector<3xi42> 
    llvm.return %10 : vector<3xi42>
  }]

def or_or_before := [llvmfunc|
  llvm.func @or_or(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.or %arg0, %0  : vector<4xi32>
    %3 = llvm.or %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }]

def xor_xor_before := [llvmfunc|
  llvm.func @xor_xor(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.xor %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 3] : vector<4xi32> 
    llvm.call @use_v4i32(%3) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }]

def udiv_udiv_before := [llvmfunc|
  llvm.func @udiv_udiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.call @use_v4i32(%3) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }]

def sdiv_sdiv_before := [llvmfunc|
  llvm.func @sdiv_sdiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sdiv_sdiv_exact_before := [llvmfunc|
  llvm.func @sdiv_sdiv_exact(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sdiv_sdiv_undef_mask_elt_before := [llvmfunc|
  llvm.func @sdiv_sdiv_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sdiv_sdiv_exact_undef_mask_elt_before := [llvmfunc|
  llvm.func @sdiv_sdiv_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def urem_urem_before := [llvmfunc|
  llvm.func @urem_urem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.urem %0, %arg0  : vector<4xi32>
    %3 = llvm.urem %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def urem_urem_undef_mask_elt_before := [llvmfunc|
  llvm.func @urem_urem_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.urem %0, %arg0  : vector<4xi32>
    %3 = llvm.urem %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def srem_srem_before := [llvmfunc|
  llvm.func @srem_srem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.srem %0, %arg0  : vector<4xi32>
    %3 = llvm.srem %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def srem_srem_undef_mask_elt_before := [llvmfunc|
  llvm.func @srem_srem_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.srem %0, %arg0  : vector<4xi32>
    %3 = llvm.srem %1, %arg0  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, -1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def fadd_fadd_before := [llvmfunc|
  llvm.func @fadd_fadd(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %arg0, %1  : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }]

def fsub_fsub_before := [llvmfunc|
  llvm.func @fsub_fsub(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.fsub %0, %arg0  : vector<4xf64>
    %3 = llvm.fsub %1, %arg0  : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }]

def fmul_fmul_before := [llvmfunc|
  llvm.func @fmul_fmul(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf32>]

    %3 = llvm.fmul %arg0, %1  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf32>]

    %4 = llvm.shufflevector %2, %3 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }]

def fdiv_fdiv_before := [llvmfunc|
  llvm.func @fdiv_fdiv(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf64>]

    %3 = llvm.fdiv %1, %arg0  {fastmathFlags = #llvm.fastmath<nnan, arcp>} : vector<4xf64>]

    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }]

def frem_frem_before := [llvmfunc|
  llvm.func @frem_frem(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.frem %0, %arg0  : vector<4xf64>
    %3 = llvm.frem %arg0, %1  : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }]

def add_2_vars_before := [llvmfunc|
  llvm.func @add_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.add %arg0, %0  : vector<4xi32>
    %3 = llvm.add %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sub_2_vars_before := [llvmfunc|
  llvm.func @sub_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sub_2_vars_nsw_before := [llvmfunc|
  llvm.func @sub_2_vars_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.sub %1, %arg1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sub_2_vars_undef_mask_elt_before := [llvmfunc|
  llvm.func @sub_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0  : vector<4xi32>
    %3 = llvm.sub %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sub_2_vars_nsw_undef_mask_elt_before := [llvmfunc|
  llvm.func @sub_2_vars_nsw_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.sub %1, %arg1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def mul_2_vars_before := [llvmfunc|
  llvm.func @mul_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.mul %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def mul_2_vars_nuw_before := [llvmfunc|
  llvm.func @mul_2_vars_nuw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.mul %arg1, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def mul_2_vars_undef_mask_elt_before := [llvmfunc|
  llvm.func @mul_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.mul %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def mul_2_vars_nuw_undef_mask_elt_before := [llvmfunc|
  llvm.func @mul_2_vars_nuw_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.mul %arg1, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_2_vars_before := [llvmfunc|
  llvm.func @shl_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_2_vars_nsw_before := [llvmfunc|
  llvm.func @shl_2_vars_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.shl %arg1, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_2_vars_undef_mask_elt_before := [llvmfunc|
  llvm.func @shl_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_2_vars_nsw_undef_mask_elt_before := [llvmfunc|
  llvm.func @shl_2_vars_nsw_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.shl %arg1, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def lshr_2_vars_before := [llvmfunc|
  llvm.func @lshr_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def lshr_2_vars_exact_before := [llvmfunc|
  llvm.func @lshr_2_vars_exact(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def lshr_2_vars_undef_mask_elt_before := [llvmfunc|
  llvm.func @lshr_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def lshr_2_vars_exact_undef_mask_elt_before := [llvmfunc|
  llvm.func @lshr_2_vars_exact_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def ashr_2_vars_before := [llvmfunc|
  llvm.func @ashr_2_vars(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<[4, 5, 6]> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.ashr %arg0, %0  : vector<3xi32>
    %3 = llvm.ashr %arg1, %1  : vector<3xi32>
    %4 = llvm.shufflevector %2, %3 [3, 1, 2] : vector<3xi32> 
    llvm.return %4 : vector<3xi32>
  }]

def and_2_vars_before := [llvmfunc|
  llvm.func @and_2_vars(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(3 : i42) : i42
    %1 = llvm.mlir.constant(2 : i42) : i42
    %2 = llvm.mlir.constant(1 : i42) : i42
    %3 = llvm.mlir.constant(dense<[1, 2, 3]> : vector<3xi42>) : vector<3xi42>
    %4 = llvm.mlir.constant(6 : i42) : i42
    %5 = llvm.mlir.constant(5 : i42) : i42
    %6 = llvm.mlir.constant(4 : i42) : i42
    %7 = llvm.mlir.constant(dense<[4, 5, 6]> : vector<3xi42>) : vector<3xi42>
    %8 = llvm.and %arg0, %3  : vector<3xi42>
    %9 = llvm.and %arg1, %7  : vector<3xi42>
    %10 = llvm.shufflevector %8, %9 [0, 4, -1] : vector<3xi42> 
    llvm.return %10 : vector<3xi42>
  }]

def or_2_vars_before := [llvmfunc|
  llvm.func @or_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.or %arg0, %0  : vector<4xi32>
    %3 = llvm.or %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }]

def xor_2_vars_before := [llvmfunc|
  llvm.func @xor_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.xor %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 3] : vector<4xi32> 
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.call @use_v4i32(%3) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }]

def udiv_2_vars_before := [llvmfunc|
  llvm.func @udiv_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def udiv_2_vars_exact_before := [llvmfunc|
  llvm.func @udiv_2_vars_exact(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def udiv_2_vars_undef_mask_elt_before := [llvmfunc|
  llvm.func @udiv_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def udiv_2_vars_exact_undef_mask_elt_before := [llvmfunc|
  llvm.func @udiv_2_vars_exact_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sdiv_2_vars_before := [llvmfunc|
  llvm.func @sdiv_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sdiv_2_vars_exact_before := [llvmfunc|
  llvm.func @sdiv_2_vars_exact(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sdiv_2_vars_undef_mask_elt_before := [llvmfunc|
  llvm.func @sdiv_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def sdiv_2_vars_exact_undef_mask_elt_before := [llvmfunc|
  llvm.func @sdiv_2_vars_exact_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sdiv %arg0, %0  : vector<4xi32>
    %3 = llvm.sdiv %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, -1] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def urem_2_vars_before := [llvmfunc|
  llvm.func @urem_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.urem %0, %arg0  : vector<4xi32>
    %3 = llvm.urem %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def srem_2_vars_before := [llvmfunc|
  llvm.func @srem_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.srem %0, %arg0  : vector<4xi32>
    %3 = llvm.srem %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, -1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def fadd_2_vars_before := [llvmfunc|
  llvm.func @fadd_2_vars(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %arg1, %1  : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }]

def fsub_2_vars_before := [llvmfunc|
  llvm.func @fsub_2_vars(%arg0: vector<4xf64>, %arg1: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.fsub %0, %arg0  : vector<4xf64>
    %3 = llvm.fsub %1, %arg1  : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }]

def fmul_2_vars_before := [llvmfunc|
  llvm.func @fmul_2_vars(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

    %3 = llvm.fmul %arg1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

    %4 = llvm.shufflevector %2, %3 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }]

def frem_2_vars_before := [llvmfunc|
  llvm.func @frem_2_vars(%arg0: vector<4xf64>, %arg1: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.frem %0, %arg0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf64>]

    %3 = llvm.frem %1, %arg1  {fastmathFlags = #llvm.fastmath<nnan, arcp>} : vector<4xf64>]

    %4 = llvm.shufflevector %2, %3 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }]

def fdiv_2_vars_before := [llvmfunc|
  llvm.func @fdiv_2_vars(%arg0: vector<4xf64>, %arg1: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %1 = llvm.mlir.constant(dense<[5.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.fdiv %0, %arg0  : vector<4xf64>
    %3 = llvm.fdiv %arg1, %1  : vector<4xf64>
    %4 = llvm.shufflevector %2, %3 [0, 1, 6, 7] : vector<4xf64> 
    llvm.return %4 : vector<4xf64>
  }]

def mul_shl_before := [llvmfunc|
  llvm.func @mul_shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.shl %arg0, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_mul_before := [llvmfunc|
  llvm.func @shl_mul(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.mul %arg0, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, -1, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def mul_is_nop_shl_before := [llvmfunc|
  llvm.func @mul_is_nop_shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0  : vector<4xi32>
    %3 = llvm.shl %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 6, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_mul_not_constant_shift_amount_before := [llvmfunc|
  llvm.func @shl_mul_not_constant_shift_amount(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %0, %arg0  : vector<4xi32>
    %3 = llvm.mul %arg0, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def mul_shl_2_vars_before := [llvmfunc|
  llvm.func @mul_shl_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    %3 = llvm.shl %arg1, %1 overflow<nuw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def shl_mul_2_vars_before := [llvmfunc|
  llvm.func @shl_mul_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    %3 = llvm.mul %arg1, %1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [4, -1, 2, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

def add_or_before := [llvmfunc|
  llvm.func @add_or(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[65534, 65535, 65536, 65537]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.shl %arg0, %0  : vector<4xi32>
    %4 = llvm.add %3, %1  : vector<4xi32>
    %5 = llvm.or %3, %2  : vector<4xi32>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %6 : vector<4xi32>
  }]

def or_add_before := [llvmfunc|
  llvm.func @or_add(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.lshr %arg0, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    %5 = llvm.add %3, %2 overflow<nsw, nuw>  : vector<4xi8>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi8> 
    llvm.return %6 : vector<4xi8>
  }]

def or_add_not_enough_masking_before := [llvmfunc|
  llvm.func @or_add_not_enough_masking(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.lshr %arg0, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    %5 = llvm.add %3, %2 overflow<nsw, nuw>  : vector<4xi8>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi8> 
    llvm.return %6 : vector<4xi8>
  }]

def add_or_2_vars_before := [llvmfunc|
  llvm.func @add_or_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[65534, 65535, 65536, 65537]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.shl %arg0, %0  : vector<4xi32>
    %4 = llvm.add %arg1, %1  : vector<4xi32>
    %5 = llvm.or %3, %2  : vector<4xi32>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi32> 
    llvm.return %6 : vector<4xi32>
  }]

def or_add_2_vars_before := [llvmfunc|
  llvm.func @or_add_2_vars(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi8>) : vector<4xi8>
    %3 = llvm.lshr %arg0, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    %5 = llvm.add %arg1, %2 overflow<nsw, nuw>  : vector<4xi8>
    %6 = llvm.shufflevector %4, %5 [4, 5, 2, 3] : vector<4xi8> 
    llvm.return %6 : vector<4xi8>
  }]

def PR41419_before := [llvmfunc|
  llvm.func @PR41419(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [4, 5, 2, 7] : vector<4xi32> 
    llvm.return %1 : vector<4xi32>
  }]

def add_combined := [llvmfunc|
  llvm.func @add(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 0, 13, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_add   : add_before  ⊑  add_combined := by
  unfold add_before add_combined
  simp_alive_peephole
  sorry
def add_nuw_nsw_combined := [llvmfunc|
  llvm.func @add_nuw_nsw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 0, 13, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0 overflow<nsw, nuw>  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_add_nuw_nsw   : add_nuw_nsw_before  ⊑  add_nuw_nsw_combined := by
  unfold add_nuw_nsw_before add_nuw_nsw_combined
  simp_alive_peephole
  sorry
def add_undef_mask_elt_combined := [llvmfunc|
  llvm.func @add_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(11 : i32) : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.add %arg0, %11  : vector<4xi32>
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_add_undef_mask_elt   : add_undef_mask_elt_before  ⊑  add_undef_mask_elt_combined := by
  unfold add_undef_mask_elt_before add_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def add_nuw_nsw_undef_mask_elt_combined := [llvmfunc|
  llvm.func @add_nuw_nsw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(13 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.constant(11 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.add %arg0, %12  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

theorem inst_combine_add_nuw_nsw_undef_mask_elt   : add_nuw_nsw_undef_mask_elt_before  ⊑  add_nuw_nsw_undef_mask_elt_combined := by
  unfold add_nuw_nsw_undef_mask_elt_before add_nuw_nsw_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def sub_combined := [llvmfunc|
  llvm.func @sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.sub %10, %arg0  : vector<4xi32>
    %12 = llvm.shufflevector %arg0, %11 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %12 : vector<4xi32>
  }]

theorem inst_combine_sub   : sub_before  ⊑  sub_combined := by
  unfold sub_before sub_combined
  simp_alive_peephole
  sorry
def mul_combined := [llvmfunc|
  llvm.func @mul(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(12 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mul %arg0, %12  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

theorem inst_combine_mul   : mul_before  ⊑  mul_combined := by
  unfold mul_before mul_combined
  simp_alive_peephole
  sorry
def shl_combined := [llvmfunc|
  llvm.func @shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 12, 13, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_shl   : shl_before  ⊑  shl_combined := by
  unfold shl_before shl_combined
  simp_alive_peephole
  sorry
def shl_nsw_combined := [llvmfunc|
  llvm.func @shl_nsw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 12, 13, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_shl_nsw   : shl_nsw_before  ⊑  shl_nsw_combined := by
  unfold shl_nsw_before shl_nsw_combined
  simp_alive_peephole
  sorry
def shl_undef_mask_elt_combined := [llvmfunc|
  llvm.func @shl_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 12, 13, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_shl_undef_mask_elt   : shl_undef_mask_elt_before  ⊑  shl_undef_mask_elt_combined := by
  unfold shl_undef_mask_elt_before shl_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def shl_nuw_undef_mask_elt_combined := [llvmfunc|
  llvm.func @shl_nuw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 0, 13, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_shl_nuw_undef_mask_elt   : shl_nuw_undef_mask_elt_before  ⊑  shl_nuw_undef_mask_elt_combined := by
  unfold shl_nuw_undef_mask_elt_before shl_nuw_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def lshr_constant_op0_combined := [llvmfunc|
  llvm.func @lshr_constant_op0(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 0, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_lshr_constant_op0   : lshr_constant_op0_before  ⊑  lshr_constant_op0_combined := by
  unfold lshr_constant_op0_before lshr_constant_op0_combined
  simp_alive_peephole
  sorry
def lshr_exact_constant_op0_combined := [llvmfunc|
  llvm.func @lshr_exact_constant_op0(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 0, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_lshr_exact_constant_op0   : lshr_exact_constant_op0_before  ⊑  lshr_exact_constant_op0_combined := by
  unfold lshr_exact_constant_op0_before lshr_exact_constant_op0_combined
  simp_alive_peephole
  sorry
def lshr_undef_mask_elt_combined := [llvmfunc|
  llvm.func @lshr_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 12, 13, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_lshr_undef_mask_elt   : lshr_undef_mask_elt_before  ⊑  lshr_undef_mask_elt_combined := by
  unfold lshr_undef_mask_elt_before lshr_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def lshr_exact_undef_mask_elt_combined := [llvmfunc|
  llvm.func @lshr_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 0, 13, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_lshr_exact_undef_mask_elt   : lshr_exact_undef_mask_elt_before  ⊑  lshr_exact_undef_mask_elt_combined := by
  unfold lshr_exact_undef_mask_elt_before lshr_exact_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def lshr_constant_op1_combined := [llvmfunc|
  llvm.func @lshr_constant_op1(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_lshr_constant_op1   : lshr_constant_op1_before  ⊑  lshr_constant_op1_combined := by
  unfold lshr_constant_op1_before lshr_constant_op1_combined
  simp_alive_peephole
  sorry
def ashr_combined := [llvmfunc|
  llvm.func @ashr(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[0, 12, 13]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.ashr %arg0, %0  : vector<3xi32>
    llvm.return %1 : vector<3xi32>
  }]

theorem inst_combine_ashr   : ashr_before  ⊑  ashr_combined := by
  unfold ashr_before ashr_combined
  simp_alive_peephole
  sorry
def and_combined := [llvmfunc|
  llvm.func @and(%arg0: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.undef : i42
    %1 = llvm.mlir.constant(12 : i42) : i42
    %2 = llvm.mlir.constant(-1 : i42) : i42
    %3 = llvm.mlir.undef : vector<3xi42>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi42>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi42>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi42>
    %10 = llvm.and %arg0, %9  : vector<3xi42>
    llvm.return %10 : vector<3xi42>
  }]

theorem inst_combine_and   : and_before  ⊑  and_combined := by
  unfold and_before and_combined
  simp_alive_peephole
  sorry
def or_combined := [llvmfunc|
  llvm.func @or(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[0, 0, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.or %arg0, %0  : vector<4xi32>
    %3 = llvm.or %arg0, %1  : vector<4xi32>
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_or   : or_before  ⊑  or_combined := by
  unfold or_before or_combined
  simp_alive_peephole
  sorry
def xor_combined := [llvmfunc|
  llvm.func @xor(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 12, 0, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.xor %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_xor   : xor_before  ⊑  xor_combined := by
  unfold xor_before xor_combined
  simp_alive_peephole
  sorry
def udiv_combined := [llvmfunc|
  llvm.func @udiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_udiv   : udiv_before  ⊑  udiv_combined := by
  unfold udiv_before udiv_combined
  simp_alive_peephole
  sorry
def udiv_exact_combined := [llvmfunc|
  llvm.func @udiv_exact(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_udiv_exact   : udiv_exact_before  ⊑  udiv_exact_combined := by
  unfold udiv_exact_before udiv_exact_combined
  simp_alive_peephole
  sorry
def udiv_undef_mask_elt_combined := [llvmfunc|
  llvm.func @udiv_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_udiv_undef_mask_elt   : udiv_undef_mask_elt_before  ⊑  udiv_undef_mask_elt_combined := by
  unfold udiv_undef_mask_elt_before udiv_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def udiv_exact_undef_mask_elt_combined := [llvmfunc|
  llvm.func @udiv_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.udiv %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, -1, 2, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_udiv_exact_undef_mask_elt   : udiv_exact_undef_mask_elt_before  ⊑  udiv_exact_undef_mask_elt_combined := by
  unfold udiv_exact_undef_mask_elt_before udiv_exact_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def sdiv_combined := [llvmfunc|
  llvm.func @sdiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 1, 13, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sdiv   : sdiv_before  ⊑  sdiv_combined := by
  unfold sdiv_before sdiv_combined
  simp_alive_peephole
  sorry
def sdiv_exact_combined := [llvmfunc|
  llvm.func @sdiv_exact(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 1, 13, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sdiv_exact   : sdiv_exact_before  ⊑  sdiv_exact_combined := by
  unfold sdiv_exact_before sdiv_exact_combined
  simp_alive_peephole
  sorry
def sdiv_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sdiv_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 1, 13, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sdiv_undef_mask_elt   : sdiv_undef_mask_elt_before  ⊑  sdiv_undef_mask_elt_combined := by
  unfold sdiv_undef_mask_elt_before sdiv_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def sdiv_exact_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sdiv_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 1, 13, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sdiv_exact_undef_mask_elt   : sdiv_exact_undef_mask_elt_before  ⊑  sdiv_exact_undef_mask_elt_combined := by
  unfold sdiv_exact_undef_mask_elt_before sdiv_exact_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def urem_combined := [llvmfunc|
  llvm.func @urem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_urem   : urem_before  ⊑  urem_combined := by
  unfold urem_before urem_combined
  simp_alive_peephole
  sorry
def urem_undef_mask_elt_combined := [llvmfunc|
  llvm.func @urem_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %1, %arg0 [0, 1, 6, -1] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_urem_undef_mask_elt   : urem_undef_mask_elt_before  ⊑  urem_undef_mask_elt_combined := by
  unfold urem_undef_mask_elt_before urem_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def srem_combined := [llvmfunc|
  llvm.func @srem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[11, 12, 13, 14]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.srem %0, %arg0  : vector<4xi32>
    %2 = llvm.shufflevector %arg0, %1 [0, 1, 6, 3] : vector<4xi32> 
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_srem   : srem_before  ⊑  srem_combined := by
  unfold srem_before srem_combined
  simp_alive_peephole
  sorry
def fadd_maybe_nan_combined := [llvmfunc|
  llvm.func @fadd_maybe_nan(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, -0.000000e+00, -0.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_fadd_maybe_nan   : fadd_maybe_nan_before  ⊑  fadd_maybe_nan_combined := by
  unfold fadd_maybe_nan_before fadd_maybe_nan_combined
  simp_alive_peephole
  sorry
def fadd_combined := [llvmfunc|
  llvm.func @fadd(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 4.200000e+01, -0.000000e+00, -0.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_fadd   : fadd_before  ⊑  fadd_combined := by
  unfold fadd_before fadd_combined
  simp_alive_peephole
  sorry
def fsub_combined := [llvmfunc|
  llvm.func @fsub(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(4.400000e+01 : f64) : f64
    %1 = llvm.mlir.constant(4.300000e+01 : f64) : f64
    %2 = llvm.mlir.poison : f64
    %3 = llvm.mlir.undef : vector<4xf64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xf64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xf64>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xf64>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf64>
    %12 = llvm.fsub %11, %arg0  : vector<4xf64>
    %13 = llvm.shufflevector %arg0, %12 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %13 : vector<4xf64>
  }]

theorem inst_combine_fsub   : fsub_before  ⊑  fsub_combined := by
  unfold fsub_before fsub_combined
  simp_alive_peephole
  sorry
def fmul_combined := [llvmfunc|
  llvm.func @fmul(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[4.100000e+01, 1.000000e+00, 1.000000e+00, 1.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf32>]

theorem inst_combine_fmul   : fmul_before  ⊑  fmul_combined := by
  unfold fmul_before fmul_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_fmul   : fmul_before  ⊑  fmul_combined := by
  unfold fmul_before fmul_combined
  simp_alive_peephole
  sorry
def fdiv_constant_op0_combined := [llvmfunc|
  llvm.func @fdiv_constant_op0(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(4.400000e+01 : f64) : f64
    %1 = llvm.mlir.constant(4.300000e+01 : f64) : f64
    %2 = llvm.mlir.poison : f64
    %3 = llvm.mlir.undef : vector<4xf64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xf64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xf64>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xf64>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf64>
    %12 = llvm.fdiv %11, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf64>]

theorem inst_combine_fdiv_constant_op0   : fdiv_constant_op0_before  ⊑  fdiv_constant_op0_combined := by
  unfold fdiv_constant_op0_before fdiv_constant_op0_combined
  simp_alive_peephole
  sorry
    %13 = llvm.shufflevector %arg0, %12 [-1, 1, 6, 7] : vector<4xf64> 
    llvm.return %13 : vector<4xf64>
  }]

theorem inst_combine_fdiv_constant_op0   : fdiv_constant_op0_before  ⊑  fdiv_constant_op0_combined := by
  unfold fdiv_constant_op0_before fdiv_constant_op0_combined
  simp_alive_peephole
  sorry
def fdiv_constant_op1_combined := [llvmfunc|
  llvm.func @fdiv_constant_op1(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(4.400000e+01 : f64) : f64
    %1 = llvm.mlir.constant(4.300000e+01 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.undef : f64
    %4 = llvm.mlir.undef : vector<4xf64>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf64>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf64>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf64>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf64>
    %13 = llvm.fdiv %arg0, %12  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf64>]

theorem inst_combine_fdiv_constant_op1   : fdiv_constant_op1_before  ⊑  fdiv_constant_op1_combined := by
  unfold fdiv_constant_op1_before fdiv_constant_op1_combined
  simp_alive_peephole
  sorry
    llvm.return %13 : vector<4xf64>
  }]

theorem inst_combine_fdiv_constant_op1   : fdiv_constant_op1_before  ⊑  fdiv_constant_op1_combined := by
  unfold fdiv_constant_op1_before fdiv_constant_op1_combined
  simp_alive_peephole
  sorry
def frem_combined := [llvmfunc|
  llvm.func @frem(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.mlir.constant(4.100000e+01 : f64) : f64
    %3 = llvm.mlir.undef : vector<4xf64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xf64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xf64>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xf64>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf64>
    %12 = llvm.frem %11, %arg0  : vector<4xf64>
    %13 = llvm.shufflevector %12, %arg0 [0, 1, 6, 7] : vector<4xf64> 
    llvm.return %13 : vector<4xf64>
  }]

theorem inst_combine_frem   : frem_before  ⊑  frem_combined := by
  unfold frem_before frem_combined
  simp_alive_peephole
  sorry
def add_add_combined := [llvmfunc|
  llvm.func @add_add(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 6, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_add_add   : add_add_before  ⊑  add_add_combined := by
  unfold add_add_before add_add_combined
  simp_alive_peephole
  sorry
def add_add_nsw_combined := [llvmfunc|
  llvm.func @add_add_nsw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 6, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.add %arg0, %0 overflow<nsw>  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_add_add_nsw   : add_add_nsw_before  ⊑  add_add_nsw_combined := by
  unfold add_add_nsw_before add_add_nsw_combined
  simp_alive_peephole
  sorry
def add_add_undef_mask_elt_combined := [llvmfunc|
  llvm.func @add_add_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.add %arg0, %12  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

theorem inst_combine_add_add_undef_mask_elt   : add_add_undef_mask_elt_before  ⊑  add_add_undef_mask_elt_combined := by
  unfold add_add_undef_mask_elt_before add_add_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def add_add_nsw_undef_mask_elt_combined := [llvmfunc|
  llvm.func @add_add_nsw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.add %arg0, %12  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

theorem inst_combine_add_add_nsw_undef_mask_elt   : add_add_nsw_undef_mask_elt_before  ⊑  add_add_nsw_undef_mask_elt_combined := by
  unfold add_add_nsw_undef_mask_elt_before add_add_nsw_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def sub_sub_combined := [llvmfunc|
  llvm.func @sub_sub(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sub_sub   : sub_sub_before  ⊑  sub_sub_combined := by
  unfold sub_sub_before sub_sub_combined
  simp_alive_peephole
  sorry
def sub_sub_nuw_combined := [llvmfunc|
  llvm.func @sub_sub_nuw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sub %0, %arg0 overflow<nuw>  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sub_sub_nuw   : sub_sub_nuw_before  ⊑  sub_sub_nuw_combined := by
  unfold sub_sub_nuw_before sub_sub_nuw_combined
  simp_alive_peephole
  sorry
def sub_sub_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sub_sub_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.sub %12, %arg0  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

theorem inst_combine_sub_sub_undef_mask_elt   : sub_sub_undef_mask_elt_before  ⊑  sub_sub_undef_mask_elt_combined := by
  unfold sub_sub_undef_mask_elt_before sub_sub_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def sub_sub_nuw_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sub_sub_nuw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.sub %12, %arg0  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

theorem inst_combine_sub_sub_nuw_undef_mask_elt   : sub_sub_nuw_undef_mask_elt_before  ⊑  sub_sub_nuw_undef_mask_elt_combined := by
  unfold sub_sub_nuw_undef_mask_elt_before sub_sub_nuw_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def mul_mul_combined := [llvmfunc|
  llvm.func @mul_mul(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mul %arg0, %12  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

theorem inst_combine_mul_mul   : mul_mul_before  ⊑  mul_mul_combined := by
  unfold mul_mul_before mul_mul_combined
  simp_alive_peephole
  sorry
def shl_shl_combined := [llvmfunc|
  llvm.func @shl_shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_shl_shl   : shl_shl_before  ⊑  shl_shl_combined := by
  unfold shl_shl_before shl_shl_combined
  simp_alive_peephole
  sorry
def shl_shl_nuw_combined := [llvmfunc|
  llvm.func @shl_shl_nuw(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_shl_shl_nuw   : shl_shl_nuw_before  ⊑  shl_shl_nuw_combined := by
  unfold shl_shl_nuw_before shl_shl_nuw_combined
  simp_alive_peephole
  sorry
def shl_shl_undef_mask_elt_combined := [llvmfunc|
  llvm.func @shl_shl_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 6, 3, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_shl_shl_undef_mask_elt   : shl_shl_undef_mask_elt_before  ⊑  shl_shl_undef_mask_elt_combined := by
  unfold shl_shl_undef_mask_elt_before shl_shl_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def shl_shl_nuw_undef_mask_elt_combined := [llvmfunc|
  llvm.func @shl_shl_nuw_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 6, 3, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0 overflow<nuw>  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_shl_shl_nuw_undef_mask_elt   : shl_shl_nuw_undef_mask_elt_before  ⊑  shl_shl_nuw_undef_mask_elt_combined := by
  unfold shl_shl_nuw_undef_mask_elt_before shl_shl_nuw_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def lshr_lshr_combined := [llvmfunc|
  llvm.func @lshr_lshr(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.lshr %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_lshr_lshr   : lshr_lshr_before  ⊑  lshr_lshr_combined := by
  unfold lshr_lshr_before lshr_lshr_combined
  simp_alive_peephole
  sorry
def ashr_ashr_combined := [llvmfunc|
  llvm.func @ashr_ashr(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[4, 2, 3]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.ashr %arg0, %0  : vector<3xi32>
    llvm.return %1 : vector<3xi32>
  }]

theorem inst_combine_ashr_ashr   : ashr_ashr_before  ⊑  ashr_ashr_combined := by
  unfold ashr_ashr_before ashr_ashr_combined
  simp_alive_peephole
  sorry
def and_and_combined := [llvmfunc|
  llvm.func @and_and(%arg0: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.undef : i42
    %1 = llvm.mlir.constant(5 : i42) : i42
    %2 = llvm.mlir.constant(1 : i42) : i42
    %3 = llvm.mlir.undef : vector<3xi42>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi42>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi42>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi42>
    %10 = llvm.and %arg0, %9  : vector<3xi42>
    llvm.return %10 : vector<3xi42>
  }]

theorem inst_combine_and_and   : and_and_before  ⊑  and_and_combined := by
  unfold and_and_before and_and_combined
  simp_alive_peephole
  sorry
def or_or_combined := [llvmfunc|
  llvm.func @or_or(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.or %arg0, %0  : vector<4xi32>
    %3 = llvm.or %arg0, %1  : vector<4xi32>
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_or_or   : or_or_before  ⊑  or_or_combined := by
  unfold or_or_before or_or_combined
  simp_alive_peephole
  sorry
def xor_xor_combined := [llvmfunc|
  llvm.func @xor_xor(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[1, 6, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.xor %arg0, %1  : vector<4xi32>
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_xor_xor   : xor_xor_before  ⊑  xor_xor_combined := by
  unfold xor_xor_before xor_xor_combined
  simp_alive_peephole
  sorry
def udiv_udiv_combined := [llvmfunc|
  llvm.func @udiv_udiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<[1, 2, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.udiv %0, %arg0  : vector<4xi32>
    %4 = llvm.udiv %1, %arg0  : vector<4xi32>
    %5 = llvm.udiv %2, %arg0  : vector<4xi32>
    llvm.call @use_v4i32(%3) : (vector<4xi32>) -> ()
    llvm.call @use_v4i32(%4) : (vector<4xi32>) -> ()
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_udiv_udiv   : udiv_udiv_before  ⊑  udiv_udiv_combined := by
  unfold udiv_udiv_before udiv_udiv_combined
  simp_alive_peephole
  sorry
def sdiv_sdiv_combined := [llvmfunc|
  llvm.func @sdiv_sdiv(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sdiv_sdiv   : sdiv_sdiv_before  ⊑  sdiv_sdiv_combined := by
  unfold sdiv_sdiv_before sdiv_sdiv_combined
  simp_alive_peephole
  sorry
def sdiv_sdiv_exact_combined := [llvmfunc|
  llvm.func @sdiv_sdiv_exact(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sdiv_sdiv_exact   : sdiv_sdiv_exact_before  ⊑  sdiv_sdiv_exact_combined := by
  unfold sdiv_sdiv_exact_before sdiv_sdiv_exact_combined
  simp_alive_peephole
  sorry
def sdiv_sdiv_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sdiv_sdiv_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sdiv_sdiv_undef_mask_elt   : sdiv_sdiv_undef_mask_elt_before  ⊑  sdiv_sdiv_undef_mask_elt_combined := by
  unfold sdiv_sdiv_undef_mask_elt_before sdiv_sdiv_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def sdiv_sdiv_exact_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sdiv_sdiv_exact_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_sdiv_sdiv_exact_undef_mask_elt   : sdiv_sdiv_exact_undef_mask_elt_before  ⊑  sdiv_sdiv_exact_undef_mask_elt_combined := by
  unfold sdiv_sdiv_exact_undef_mask_elt_before sdiv_sdiv_exact_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def urem_urem_combined := [llvmfunc|
  llvm.func @urem_urem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_urem_urem   : urem_urem_before  ⊑  urem_urem_combined := by
  unfold urem_urem_before urem_urem_combined
  simp_alive_peephole
  sorry
def urem_urem_undef_mask_elt_combined := [llvmfunc|
  llvm.func @urem_urem_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_urem_urem_undef_mask_elt   : urem_urem_undef_mask_elt_before  ⊑  urem_urem_undef_mask_elt_combined := by
  unfold urem_urem_undef_mask_elt_before urem_urem_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def srem_srem_combined := [llvmfunc|
  llvm.func @srem_srem(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.srem %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_srem_srem   : srem_srem_before  ⊑  srem_srem_combined := by
  unfold srem_srem_before srem_srem_combined
  simp_alive_peephole
  sorry
def srem_srem_undef_mask_elt_combined := [llvmfunc|
  llvm.func @srem_srem_undef_mask_elt(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 0, 7, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.srem %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_srem_srem_undef_mask_elt   : srem_srem_undef_mask_elt_before  ⊑  srem_srem_undef_mask_elt_combined := by
  unfold srem_srem_undef_mask_elt_before srem_srem_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def fadd_fadd_combined := [llvmfunc|
  llvm.func @fadd_fadd(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_fadd_fadd   : fadd_fadd_before  ⊑  fadd_fadd_combined := by
  unfold fadd_fadd_before fadd_fadd_combined
  simp_alive_peephole
  sorry
def fsub_fsub_combined := [llvmfunc|
  llvm.func @fsub_fsub(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(8.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %3 = llvm.mlir.undef : f64
    %4 = llvm.mlir.undef : vector<4xf64>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf64>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf64>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf64>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf64>
    %13 = llvm.fsub %12, %arg0  : vector<4xf64>
    llvm.return %13 : vector<4xf64>
  }]

theorem inst_combine_fsub_fsub   : fsub_fsub_before  ⊑  fsub_fsub_combined := by
  unfold fsub_fsub_before fsub_fsub_combined
  simp_alive_peephole
  sorry
def fmul_fmul_combined := [llvmfunc|
  llvm.func @fmul_fmul(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : vector<4xf32>]

theorem inst_combine_fmul_fmul   : fmul_fmul_before  ⊑  fmul_fmul_combined := by
  unfold fmul_fmul_before fmul_fmul_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_fmul_fmul   : fmul_fmul_before  ⊑  fmul_fmul_combined := by
  unfold fmul_fmul_before fmul_fmul_combined
  simp_alive_peephole
  sorry
def fdiv_fdiv_combined := [llvmfunc|
  llvm.func @fdiv_fdiv(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(8.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %3 = llvm.mlir.undef : f64
    %4 = llvm.mlir.undef : vector<4xf64>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf64>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf64>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf64>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf64>
    %13 = llvm.fdiv %12, %arg0  {fastmathFlags = #llvm.fastmath<arcp>} : vector<4xf64>]

theorem inst_combine_fdiv_fdiv   : fdiv_fdiv_before  ⊑  fdiv_fdiv_combined := by
  unfold fdiv_fdiv_before fdiv_fdiv_combined
  simp_alive_peephole
  sorry
    llvm.return %13 : vector<4xf64>
  }]

theorem inst_combine_fdiv_fdiv   : fdiv_fdiv_before  ⊑  fdiv_fdiv_combined := by
  unfold fdiv_fdiv_before fdiv_fdiv_combined
  simp_alive_peephole
  sorry
def frem_frem_combined := [llvmfunc|
  llvm.func @frem_frem(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.undef : vector<4xf64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xf64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xf64>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xf64>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf64>
    %12 = llvm.mlir.constant(8.000000e+00 : f64) : f64
    %13 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %14 = llvm.mlir.undef : vector<4xf64>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %0, %14[%15 : i32] : vector<4xf64>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<4xf64>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %13, %18[%19 : i32] : vector<4xf64>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xf64>
    %23 = llvm.frem %11, %arg0  : vector<4xf64>
    %24 = llvm.frem %arg0, %22  : vector<4xf64>
    %25 = llvm.shufflevector %23, %24 [0, 1, 6, 7] : vector<4xf64> 
    llvm.return %25 : vector<4xf64>
  }]

theorem inst_combine_frem_frem   : frem_frem_before  ⊑  frem_frem_combined := by
  unfold frem_frem_before frem_frem_combined
  simp_alive_peephole
  sorry
def add_2_vars_combined := [llvmfunc|
  llvm.func @add_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 6, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 7] : vector<4xi32> 
    %2 = llvm.add %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_add_2_vars   : add_2_vars_before  ⊑  add_2_vars_combined := by
  unfold add_2_vars_before add_2_vars_combined
  simp_alive_peephole
  sorry
def sub_2_vars_combined := [llvmfunc|
  llvm.func @sub_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 7] : vector<4xi32> 
    %2 = llvm.sub %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_sub_2_vars   : sub_2_vars_before  ⊑  sub_2_vars_combined := by
  unfold sub_2_vars_before sub_2_vars_combined
  simp_alive_peephole
  sorry
def sub_2_vars_nsw_combined := [llvmfunc|
  llvm.func @sub_2_vars_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 2, 7] : vector<4xi32> 
    %2 = llvm.sub %0, %1 overflow<nsw>  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_sub_2_vars_nsw   : sub_2_vars_nsw_before  ⊑  sub_2_vars_nsw_combined := by
  unfold sub_2_vars_nsw_before sub_2_vars_nsw_combined
  simp_alive_peephole
  sorry
def sub_2_vars_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sub_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.shufflevector %arg0, %arg1 [-1, 1, 2, 7] : vector<4xi32> 
    %14 = llvm.sub %12, %13  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_sub_2_vars_undef_mask_elt   : sub_2_vars_undef_mask_elt_before  ⊑  sub_2_vars_undef_mask_elt_combined := by
  unfold sub_2_vars_undef_mask_elt_before sub_2_vars_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def sub_2_vars_nsw_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sub_2_vars_nsw_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.undef : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.shufflevector %arg0, %arg1 [-1, 1, 2, 7] : vector<4xi32> 
    %14 = llvm.sub %12, %13  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_sub_2_vars_nsw_undef_mask_elt   : sub_2_vars_nsw_undef_mask_elt_before  ⊑  sub_2_vars_nsw_undef_mask_elt_combined := by
  unfold sub_2_vars_nsw_undef_mask_elt_before sub_2_vars_nsw_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def mul_2_vars_combined := [llvmfunc|
  llvm.func @mul_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 6, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 7] : vector<4xi32> 
    %2 = llvm.mul %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_mul_2_vars   : mul_2_vars_before  ⊑  mul_2_vars_combined := by
  unfold mul_2_vars_before mul_2_vars_combined
  simp_alive_peephole
  sorry
def mul_2_vars_nuw_combined := [llvmfunc|
  llvm.func @mul_2_vars_nuw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 6, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 7] : vector<4xi32> 
    %2 = llvm.mul %1, %0 overflow<nuw>  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_mul_2_vars_nuw   : mul_2_vars_nuw_before  ⊑  mul_2_vars_nuw_combined := by
  unfold mul_2_vars_nuw_before mul_2_vars_nuw_combined
  simp_alive_peephole
  sorry
def mul_2_vars_undef_mask_elt_combined := [llvmfunc|
  llvm.func @mul_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.shufflevector %arg0, %arg1 [0, -1, 2, 7] : vector<4xi32> 
    %14 = llvm.mul %13, %12  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_mul_2_vars_undef_mask_elt   : mul_2_vars_undef_mask_elt_before  ⊑  mul_2_vars_undef_mask_elt_combined := by
  unfold mul_2_vars_undef_mask_elt_before mul_2_vars_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def mul_2_vars_nuw_undef_mask_elt_combined := [llvmfunc|
  llvm.func @mul_2_vars_nuw_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.shufflevector %arg0, %arg1 [0, -1, 2, 7] : vector<4xi32> 
    %14 = llvm.mul %13, %12  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_mul_2_vars_nuw_undef_mask_elt   : mul_2_vars_nuw_undef_mask_elt_before  ⊑  mul_2_vars_nuw_undef_mask_elt_combined := by
  unfold mul_2_vars_nuw_undef_mask_elt_before mul_2_vars_nuw_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def shl_2_vars_combined := [llvmfunc|
  llvm.func @shl_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 6, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 3] : vector<4xi32> 
    %2 = llvm.shl %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_shl_2_vars   : shl_2_vars_before  ⊑  shl_2_vars_combined := by
  unfold shl_2_vars_before shl_2_vars_combined
  simp_alive_peephole
  sorry
def shl_2_vars_nsw_combined := [llvmfunc|
  llvm.func @shl_2_vars_nsw(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 6, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 2, 3] : vector<4xi32> 
    %2 = llvm.shl %1, %0 overflow<nsw>  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_shl_2_vars_nsw   : shl_2_vars_nsw_before  ⊑  shl_2_vars_nsw_combined := by
  unfold shl_2_vars_nsw_before shl_2_vars_nsw_combined
  simp_alive_peephole
  sorry
def shl_2_vars_undef_mask_elt_combined := [llvmfunc|
  llvm.func @shl_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 6, 3, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [-1, 5, 2, -1] : vector<4xi32> 
    %2 = llvm.shl %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_shl_2_vars_undef_mask_elt   : shl_2_vars_undef_mask_elt_before  ⊑  shl_2_vars_undef_mask_elt_combined := by
  unfold shl_2_vars_undef_mask_elt_before shl_2_vars_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def shl_2_vars_nsw_undef_mask_elt_combined := [llvmfunc|
  llvm.func @shl_2_vars_nsw_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 6, 3, 0]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [-1, 5, 2, -1] : vector<4xi32> 
    %2 = llvm.shl %1, %0 overflow<nsw>  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_shl_2_vars_nsw_undef_mask_elt   : shl_2_vars_nsw_undef_mask_elt_before  ⊑  shl_2_vars_nsw_undef_mask_elt_combined := by
  unfold shl_2_vars_nsw_undef_mask_elt_before shl_2_vars_nsw_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def lshr_2_vars_combined := [llvmfunc|
  llvm.func @lshr_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg1, %arg0 [0, 1, 6, 3] : vector<4xi32> 
    %2 = llvm.lshr %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_lshr_2_vars   : lshr_2_vars_before  ⊑  lshr_2_vars_combined := by
  unfold lshr_2_vars_before lshr_2_vars_combined
  simp_alive_peephole
  sorry
def lshr_2_vars_exact_combined := [llvmfunc|
  llvm.func @lshr_2_vars_exact(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg1, %arg0 [0, 1, 6, 3] : vector<4xi32> 
    %2 = llvm.lshr %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_lshr_2_vars_exact   : lshr_2_vars_exact_before  ⊑  lshr_2_vars_exact_combined := by
  unfold lshr_2_vars_exact_before lshr_2_vars_exact_combined
  simp_alive_peephole
  sorry
def lshr_2_vars_undef_mask_elt_combined := [llvmfunc|
  llvm.func @lshr_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_lshr_2_vars_undef_mask_elt   : lshr_2_vars_undef_mask_elt_before  ⊑  lshr_2_vars_undef_mask_elt_combined := by
  unfold lshr_2_vars_undef_mask_elt_before lshr_2_vars_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def lshr_2_vars_exact_undef_mask_elt_combined := [llvmfunc|
  llvm.func @lshr_2_vars_exact_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.lshr %0, %arg0  : vector<4xi32>
    %3 = llvm.lshr %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 5, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_lshr_2_vars_exact_undef_mask_elt   : lshr_2_vars_exact_undef_mask_elt_before  ⊑  lshr_2_vars_exact_undef_mask_elt_combined := by
  unfold lshr_2_vars_exact_undef_mask_elt_before lshr_2_vars_exact_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def ashr_2_vars_combined := [llvmfunc|
  llvm.func @ashr_2_vars(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[4, 2, 3]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.shufflevector %arg1, %arg0 [0, 4, 5] : vector<3xi32> 
    %2 = llvm.ashr %1, %0  : vector<3xi32>
    llvm.return %2 : vector<3xi32>
  }]

theorem inst_combine_ashr_2_vars   : ashr_2_vars_before  ⊑  ashr_2_vars_combined := by
  unfold ashr_2_vars_before ashr_2_vars_combined
  simp_alive_peephole
  sorry
def and_2_vars_combined := [llvmfunc|
  llvm.func @and_2_vars(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.undef : i42
    %1 = llvm.mlir.constant(5 : i42) : i42
    %2 = llvm.mlir.constant(1 : i42) : i42
    %3 = llvm.mlir.undef : vector<3xi42>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi42>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi42>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi42>
    %10 = llvm.shufflevector %arg0, %arg1 [0, 4, -1] : vector<3xi42> 
    %11 = llvm.and %10, %9  : vector<3xi42>
    llvm.return %11 : vector<3xi42>
  }]

theorem inst_combine_and_2_vars   : and_2_vars_before  ⊑  and_2_vars_combined := by
  unfold and_2_vars_before and_2_vars_combined
  simp_alive_peephole
  sorry
def or_2_vars_combined := [llvmfunc|
  llvm.func @or_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.or %arg0, %0  : vector<4xi32>
    %3 = llvm.shufflevector %arg1, %arg0 [0, 1, 6, 7] : vector<4xi32> 
    %4 = llvm.or %3, %1  : vector<4xi32>
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_or_2_vars   : or_2_vars_before  ⊑  or_2_vars_combined := by
  unfold or_2_vars_before or_2_vars_combined
  simp_alive_peephole
  sorry
def xor_2_vars_combined := [llvmfunc|
  llvm.func @xor_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.xor %arg0, %0  : vector<4xi32>
    %3 = llvm.xor %arg1, %1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, 5, 2, 3] : vector<4xi32> 
    llvm.call @use_v4i32(%2) : (vector<4xi32>) -> ()
    llvm.call @use_v4i32(%3) : (vector<4xi32>) -> ()
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_xor_2_vars   : xor_2_vars_before  ⊑  xor_2_vars_combined := by
  unfold xor_2_vars_before xor_2_vars_combined
  simp_alive_peephole
  sorry
def udiv_2_vars_combined := [llvmfunc|
  llvm.func @udiv_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[5, 2, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg1, %arg0 [0, 5, 6, 3] : vector<4xi32> 
    %2 = llvm.udiv %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_udiv_2_vars   : udiv_2_vars_before  ⊑  udiv_2_vars_combined := by
  unfold udiv_2_vars_before udiv_2_vars_combined
  simp_alive_peephole
  sorry
def udiv_2_vars_exact_combined := [llvmfunc|
  llvm.func @udiv_2_vars_exact(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[5, 2, 3, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg1, %arg0 [0, 5, 6, 3] : vector<4xi32> 
    %2 = llvm.udiv %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_udiv_2_vars_exact   : udiv_2_vars_exact_before  ⊑  udiv_2_vars_exact_combined := by
  unfold udiv_2_vars_exact_before udiv_2_vars_exact_combined
  simp_alive_peephole
  sorry
def udiv_2_vars_undef_mask_elt_combined := [llvmfunc|
  llvm.func @udiv_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_udiv_2_vars_undef_mask_elt   : udiv_2_vars_undef_mask_elt_before  ⊑  udiv_2_vars_undef_mask_elt_combined := by
  unfold udiv_2_vars_undef_mask_elt_before udiv_2_vars_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def udiv_2_vars_exact_undef_mask_elt_combined := [llvmfunc|
  llvm.func @udiv_2_vars_exact_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.udiv %0, %arg0  : vector<4xi32>
    %3 = llvm.udiv %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [-1, 1, 2, 7] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_udiv_2_vars_exact_undef_mask_elt   : udiv_2_vars_exact_undef_mask_elt_before  ⊑  udiv_2_vars_exact_undef_mask_elt_combined := by
  unfold udiv_2_vars_exact_undef_mask_elt_before udiv_2_vars_exact_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def sdiv_2_vars_combined := [llvmfunc|
  llvm.func @sdiv_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 6, 3] : vector<4xi32> 
    %2 = llvm.sdiv %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_sdiv_2_vars   : sdiv_2_vars_before  ⊑  sdiv_2_vars_combined := by
  unfold sdiv_2_vars_before sdiv_2_vars_combined
  simp_alive_peephole
  sorry
def sdiv_2_vars_exact_combined := [llvmfunc|
  llvm.func @sdiv_2_vars_exact(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 6, 3] : vector<4xi32> 
    %2 = llvm.sdiv %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_sdiv_2_vars_exact   : sdiv_2_vars_exact_before  ⊑  sdiv_2_vars_exact_combined := by
  unfold sdiv_2_vars_exact_before sdiv_2_vars_exact_combined
  simp_alive_peephole
  sorry
def sdiv_2_vars_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sdiv_2_vars_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 6, -1] : vector<4xi32> 
    %2 = llvm.sdiv %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_sdiv_2_vars_undef_mask_elt   : sdiv_2_vars_undef_mask_elt_before  ⊑  sdiv_2_vars_undef_mask_elt_combined := by
  unfold sdiv_2_vars_undef_mask_elt_before sdiv_2_vars_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def sdiv_2_vars_exact_undef_mask_elt_combined := [llvmfunc|
  llvm.func @sdiv_2_vars_exact_undef_mask_elt(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 6, -1] : vector<4xi32> 
    %2 = llvm.sdiv %1, %0  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_sdiv_2_vars_exact_undef_mask_elt   : sdiv_2_vars_exact_undef_mask_elt_before  ⊑  sdiv_2_vars_exact_undef_mask_elt_combined := by
  unfold sdiv_2_vars_exact_undef_mask_elt_before sdiv_2_vars_exact_undef_mask_elt_combined
  simp_alive_peephole
  sorry
def urem_2_vars_combined := [llvmfunc|
  llvm.func @urem_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 6, 7] : vector<4xi32> 
    %2 = llvm.urem %0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_urem_2_vars   : urem_2_vars_before  ⊑  urem_2_vars_combined := by
  unfold urem_2_vars_before urem_2_vars_combined
  simp_alive_peephole
  sorry
def srem_2_vars_combined := [llvmfunc|
  llvm.func @srem_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[5, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.srem %0, %arg0  : vector<4xi32>
    %3 = llvm.srem %1, %arg1  : vector<4xi32>
    %4 = llvm.shufflevector %2, %3 [0, -1, 6, 3] : vector<4xi32> 
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_srem_2_vars   : srem_2_vars_before  ⊑  srem_2_vars_combined := by
  unfold srem_2_vars_before srem_2_vars_combined
  simp_alive_peephole
  sorry
def fadd_2_vars_combined := [llvmfunc|
  llvm.func @fadd_2_vars(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 1, 6, 7] : vector<4xf32> 
    %2 = llvm.fadd %1, %0  : vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_fadd_2_vars   : fadd_2_vars_before  ⊑  fadd_2_vars_combined := by
  unfold fadd_2_vars_before fadd_2_vars_combined
  simp_alive_peephole
  sorry
def fsub_2_vars_combined := [llvmfunc|
  llvm.func @fsub_2_vars(%arg0: vector<4xf64>, %arg1: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(8.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %3 = llvm.mlir.undef : f64
    %4 = llvm.mlir.undef : vector<4xf64>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf64>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf64>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf64>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf64>
    %13 = llvm.shufflevector %arg0, %arg1 [-1, 1, 6, 7] : vector<4xf64> 
    %14 = llvm.fsub %12, %13  : vector<4xf64>
    llvm.return %14 : vector<4xf64>
  }]

theorem inst_combine_fsub_2_vars   : fsub_2_vars_before  ⊑  fsub_2_vars_combined := by
  unfold fsub_2_vars_before fsub_2_vars_combined
  simp_alive_peephole
  sorry
def fmul_2_vars_combined := [llvmfunc|
  llvm.func @fmul_2_vars(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 6.000000e+00, 7.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %arg1 [0, 5, 6, 7] : vector<4xf32> 
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

theorem inst_combine_fmul_2_vars   : fmul_2_vars_before  ⊑  fmul_2_vars_combined := by
  unfold fmul_2_vars_before fmul_2_vars_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<4xf32>
  }]

theorem inst_combine_fmul_2_vars   : fmul_2_vars_before  ⊑  fmul_2_vars_combined := by
  unfold fmul_2_vars_before fmul_2_vars_combined
  simp_alive_peephole
  sorry
def frem_2_vars_combined := [llvmfunc|
  llvm.func @frem_2_vars(%arg0: vector<4xf64>, %arg1: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(8.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %3 = llvm.mlir.undef : f64
    %4 = llvm.mlir.undef : vector<4xf64>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf64>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf64>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf64>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf64>
    %13 = llvm.shufflevector %arg0, %arg1 [-1, 1, 6, 7] : vector<4xf64> 
    %14 = llvm.frem %12, %13  : vector<4xf64>
    llvm.return %14 : vector<4xf64>
  }]

theorem inst_combine_frem_2_vars   : frem_2_vars_before  ⊑  frem_2_vars_combined := by
  unfold frem_2_vars_before frem_2_vars_combined
  simp_alive_peephole
  sorry
def fdiv_2_vars_combined := [llvmfunc|
  llvm.func @fdiv_2_vars(%arg0: vector<4xf64>, %arg1: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.undef : vector<4xf64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xf64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xf64>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xf64>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf64>
    %12 = llvm.mlir.constant(8.000000e+00 : f64) : f64
    %13 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %14 = llvm.mlir.undef : vector<4xf64>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %0, %14[%15 : i32] : vector<4xf64>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %0, %16[%17 : i32] : vector<4xf64>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %13, %18[%19 : i32] : vector<4xf64>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %12, %20[%21 : i32] : vector<4xf64>
    %23 = llvm.fdiv %11, %arg0  : vector<4xf64>
    %24 = llvm.fdiv %arg1, %22  : vector<4xf64>
    %25 = llvm.shufflevector %23, %24 [0, 1, 6, 7] : vector<4xf64> 
    llvm.return %25 : vector<4xf64>
  }]

theorem inst_combine_fdiv_2_vars   : fdiv_2_vars_before  ⊑  fdiv_2_vars_combined := by
  unfold fdiv_2_vars_before fdiv_2_vars_combined
  simp_alive_peephole
  sorry
def mul_shl_combined := [llvmfunc|
  llvm.func @mul_shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[32, 64, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_mul_shl   : mul_shl_before  ⊑  mul_shl_combined := by
  unfold mul_shl_before mul_shl_combined
  simp_alive_peephole
  sorry
def shl_mul_combined := [llvmfunc|
  llvm.func @shl_mul(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.mul %arg0, %12  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

theorem inst_combine_shl_mul   : shl_mul_before  ⊑  shl_mul_combined := by
  unfold shl_mul_before shl_mul_combined
  simp_alive_peephole
  sorry
def mul_is_nop_shl_combined := [llvmfunc|
  llvm.func @mul_is_nop_shl(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 6, 7, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_mul_is_nop_shl   : mul_is_nop_shl_before  ⊑  mul_is_nop_shl_combined := by
  unfold mul_is_nop_shl_before mul_is_nop_shl_combined
  simp_alive_peephole
  sorry
def shl_mul_not_constant_shift_amount_combined := [llvmfunc|
  llvm.func @shl_mul_not_constant_shift_amount(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(6 : i32) : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %1, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.shl %0, %arg0  : vector<4xi32>
    %14 = llvm.mul %arg0, %12  : vector<4xi32>
    %15 = llvm.shufflevector %14, %13 [0, 1, 6, 7] : vector<4xi32> 
    llvm.return %15 : vector<4xi32>
  }]

theorem inst_combine_shl_mul_not_constant_shift_amount   : shl_mul_not_constant_shift_amount_before  ⊑  shl_mul_not_constant_shift_amount_combined := by
  unfold shl_mul_not_constant_shift_amount_before shl_mul_not_constant_shift_amount_combined
  simp_alive_peephole
  sorry
def mul_shl_2_vars_combined := [llvmfunc|
  llvm.func @mul_shl_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[32, 64, 3, 4]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg1, %arg0 [0, 1, 6, 7] : vector<4xi32> 
    %2 = llvm.mul %1, %0 overflow<nuw>  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_mul_shl_2_vars   : mul_shl_2_vars_before  ⊑  mul_shl_2_vars_combined := by
  unfold mul_shl_2_vars_before mul_shl_2_vars_combined
  simp_alive_peephole
  sorry
def shl_mul_2_vars_combined := [llvmfunc|
  llvm.func @shl_mul_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.constant(5 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.shufflevector %arg1, %arg0 [0, -1, 6, 7] : vector<4xi32> 
    %14 = llvm.mul %13, %12  : vector<4xi32>
    llvm.return %14 : vector<4xi32>
  }]

theorem inst_combine_shl_mul_2_vars   : shl_mul_2_vars_before  ⊑  shl_mul_2_vars_combined := by
  unfold shl_mul_2_vars_before shl_mul_2_vars_combined
  simp_alive_peephole
  sorry
def add_or_combined := [llvmfunc|
  llvm.func @add_or(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[31, 31, 65536, 65537]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.add %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_add_or   : add_or_before  ⊑  add_or_combined := by
  unfold add_or_before add_or_combined
  simp_alive_peephole
  sorry
def or_add_combined := [llvmfunc|
  llvm.func @or_add(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 2, -64, -64]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.lshr %arg0, %0  : vector<4xi8>
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_or_add   : or_add_before  ⊑  or_add_combined := by
  unfold or_add_before or_add_combined
  simp_alive_peephole
  sorry
def or_add_not_enough_masking_combined := [llvmfunc|
  llvm.func @or_add_not_enough_masking(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<4xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xi8>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi8>
    %12 = llvm.mlir.constant(2 : i8) : i8
    %13 = llvm.mlir.constant(1 : i8) : i8
    %14 = llvm.mlir.undef : vector<4xi8>
    %15 = llvm.mlir.constant(0 : i32) : i32
    %16 = llvm.insertelement %13, %14[%15 : i32] : vector<4xi8>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.insertelement %12, %16[%17 : i32] : vector<4xi8>
    %19 = llvm.mlir.constant(2 : i32) : i32
    %20 = llvm.insertelement %2, %18[%19 : i32] : vector<4xi8>
    %21 = llvm.mlir.constant(3 : i32) : i32
    %22 = llvm.insertelement %2, %20[%21 : i32] : vector<4xi8>
    %23 = llvm.lshr %arg0, %0  : vector<4xi8>
    %24 = llvm.or %23, %11  : vector<4xi8>
    %25 = llvm.add %23, %22 overflow<nsw, nuw>  : vector<4xi8>
    %26 = llvm.shufflevector %25, %24 [0, 1, 6, 7] : vector<4xi8> 
    llvm.return %26 : vector<4xi8>
  }]

theorem inst_combine_or_add_not_enough_masking   : or_add_not_enough_masking_before  ⊑  or_add_not_enough_masking_combined := by
  unfold or_add_not_enough_masking_before or_add_not_enough_masking_combined
  simp_alive_peephole
  sorry
def add_or_2_vars_combined := [llvmfunc|
  llvm.func @add_or_2_vars(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<5> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[31, 31, 65536, 65537]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.shufflevector %2, %arg1 [0, 1, 6, 7] : vector<4xi32> 
    %4 = llvm.add %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_add_or_2_vars   : add_or_2_vars_before  ⊑  add_or_2_vars_combined := by
  unfold add_or_2_vars_before add_or_2_vars_combined
  simp_alive_peephole
  sorry
def or_add_2_vars_combined := [llvmfunc|
  llvm.func @or_add_2_vars(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[1, 2, -64, -64]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.lshr %arg0, %0  : vector<4xi8>
    %3 = llvm.shufflevector %arg1, %2 [0, 1, 6, 7] : vector<4xi8> 
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

theorem inst_combine_or_add_2_vars   : or_add_2_vars_before  ⊑  or_add_2_vars_combined := by
  unfold or_add_2_vars_before or_add_2_vars_combined
  simp_alive_peephole
  sorry
def PR41419_combined := [llvmfunc|
  llvm.func @PR41419(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [-1, -1, 2, -1] : vector<4xi32> 
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_PR41419   : PR41419_before  ⊑  PR41419_combined := by
  unfold PR41419_before PR41419_combined
  simp_alive_peephole
  sorry
