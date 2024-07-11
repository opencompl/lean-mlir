import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fsh
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fshl_mask_simplify1_before := [llvmfunc|
  llvm.func @fshl_mask_simplify1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fshr_mask_simplify2_before := [llvmfunc|
  llvm.func @fshr_mask_simplify2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg2, %0  : vector<2xi32>
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def fshl_mask_simplify3_before := [llvmfunc|
  llvm.func @fshl_mask_simplify3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fshr_mask_simplify1_before := [llvmfunc|
  llvm.func @fshr_mask_simplify1(%arg0: i33, %arg1: i33, %arg2: i33) -> i33 {
    %0 = llvm.mlir.constant(64 : i33) : i33
    %1 = llvm.and %arg2, %0  : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

def fshl_mask_simplify2_before := [llvmfunc|
  llvm.func @fshl_mask_simplify2(%arg0: vector<2xi31>, %arg1: vector<2xi31>, %arg2: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(32 : i31) : i31
    %1 = llvm.mlir.constant(dense<32> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.and %arg2, %1  : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

def fshr_mask_simplify3_before := [llvmfunc|
  llvm.func @fshr_mask_simplify3(%arg0: i33, %arg1: i33, %arg2: i33) -> i33 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = llvm.and %arg2, %0  : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

def fshl_mask_not_required_before := [llvmfunc|
  llvm.func @fshl_mask_not_required(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fshl_mask_reduce_constant_before := [llvmfunc|
  llvm.func @fshl_mask_reduce_constant(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(33 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fshl_mask_negative_before := [llvmfunc|
  llvm.func @fshl_mask_negative(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fshr_set_but_not_demanded_vec_before := [llvmfunc|
  llvm.func @fshr_set_but_not_demanded_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.or %arg2, %0  : vector<2xi32>
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def fshl_set_but_not_demanded_vec_before := [llvmfunc|
  llvm.func @fshl_set_but_not_demanded_vec(%arg0: vector<2xi31>, %arg1: vector<2xi31>, %arg2: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(32 : i31) : i31
    %1 = llvm.mlir.constant(dense<32> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.or %arg2, %1  : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

def fshl_op0_undef_before := [llvmfunc|
  llvm.func @fshl_op0_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.intr.fshl(%0, %arg0, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fshl_op0_zero_before := [llvmfunc|
  llvm.func @fshl_op0_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.intr.fshl(%0, %arg0, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fshr_op0_undef_before := [llvmfunc|
  llvm.func @fshr_op0_undef(%arg0: i33) -> i33 {
    %0 = llvm.mlir.undef : i33
    %1 = llvm.mlir.constant(7 : i33) : i33
    %2 = llvm.intr.fshr(%0, %arg0, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

def fshr_op0_zero_before := [llvmfunc|
  llvm.func @fshr_op0_zero(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = llvm.mlir.constant(7 : i33) : i33
    %2 = llvm.intr.fshr(%0, %arg0, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

def fshl_op1_undef_before := [llvmfunc|
  llvm.func @fshl_op1_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %0, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fshl_op1_zero_before := [llvmfunc|
  llvm.func @fshl_op1_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %0, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

def fshr_op1_undef_before := [llvmfunc|
  llvm.func @fshr_op1_undef(%arg0: i33) -> i33 {
    %0 = llvm.mlir.undef : i33
    %1 = llvm.mlir.constant(7 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %0, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

def fshr_op1_zero_before := [llvmfunc|
  llvm.func @fshr_op1_zero(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(0 : i33) : i33
    %1 = llvm.mlir.constant(7 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %0, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

def fshl_op0_zero_splat_vec_before := [llvmfunc|
  llvm.func @fshl_op0_zero_splat_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(0 : i31) : i31
    %1 = llvm.mlir.constant(dense<0> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(7 : i31) : i31
    %3 = llvm.mlir.constant(dense<7> : vector<2xi31>) : vector<2xi31>
    %4 = llvm.intr.fshl(%1, %arg0, %3)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %4 : vector<2xi31>
  }]

def fshl_op1_undef_splat_vec_before := [llvmfunc|
  llvm.func @fshl_op1_undef_splat_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.undef : vector<2xi31>
    %1 = llvm.mlir.constant(7 : i31) : i31
    %2 = llvm.mlir.constant(dense<7> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %0, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

def fshr_op0_undef_splat_vec_before := [llvmfunc|
  llvm.func @fshr_op0_undef_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.fshr(%0, %arg0, %1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def fshr_op1_zero_splat_vec_before := [llvmfunc|
  llvm.func @fshr_op1_zero_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.intr.fshr(%arg0, %1, %2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def fshl_op0_zero_vec_before := [llvmfunc|
  llvm.func @fshl_op0_zero_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(0 : i31) : i31
    %1 = llvm.mlir.constant(dense<0> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(33 : i31) : i31
    %3 = llvm.mlir.constant(-1 : i31) : i31
    %4 = llvm.mlir.constant(dense<[-1, 33]> : vector<2xi31>) : vector<2xi31>
    %5 = llvm.intr.fshl(%1, %arg0, %4)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %5 : vector<2xi31>
  }]

def fshl_op1_undef_vec_before := [llvmfunc|
  llvm.func @fshl_op1_undef_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.undef : vector<2xi31>
    %1 = llvm.mlir.constant(33 : i31) : i31
    %2 = llvm.mlir.constant(-1 : i31) : i31
    %3 = llvm.mlir.constant(dense<[-1, 33]> : vector<2xi31>) : vector<2xi31>
    %4 = llvm.intr.fshl(%arg0, %0, %3)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %4 : vector<2xi31>
  }]

def fshr_op0_undef_vec_before := [llvmfunc|
  llvm.func @fshr_op0_undef_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-1, 33]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.fshr(%0, %arg0, %1)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def fshr_op1_zero_vec_before := [llvmfunc|
  llvm.func @fshr_op1_zero_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[-1, 33]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.intr.fshr(%arg0, %1, %2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def fshl_only_op0_demanded_before := [llvmfunc|
  llvm.func @fshl_only_op0_demanded(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def fshl_only_op1_demanded_before := [llvmfunc|
  llvm.func @fshl_only_op1_demanded(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(63 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def fshr_only_op1_demanded_before := [llvmfunc|
  llvm.func @fshr_only_op1_demanded(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(7 : i33) : i33
    %1 = llvm.mlir.constant(12392 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    %3 = llvm.and %2, %1  : i33
    llvm.return %3 : i33
  }]

def fshr_only_op0_demanded_before := [llvmfunc|
  llvm.func @fshr_only_op0_demanded(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(7 : i33) : i33
    %1 = llvm.mlir.constant(30 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    %3 = llvm.lshr %2, %1  : i33
    llvm.return %3 : i33
  }]

def fshl_only_op1_demanded_vec_splat_before := [llvmfunc|
  llvm.func @fshl_only_op1_demanded_vec_splat(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(7 : i31) : i31
    %1 = llvm.mlir.constant(dense<7> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(31 : i31) : i31
    %3 = llvm.mlir.constant(63 : i31) : i31
    %4 = llvm.mlir.constant(dense<[63, 31]> : vector<2xi31>) : vector<2xi31>
    %5 = llvm.intr.fshl(%arg0, %arg1, %1)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    %6 = llvm.and %5, %4  : vector<2xi31>
    llvm.return %6 : vector<2xi31>
  }]

def fshl_constant_shift_amount_modulo_bitwidth_before := [llvmfunc|
  llvm.func @fshl_constant_shift_amount_modulo_bitwidth(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(33 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

def fshr_constant_shift_amount_modulo_bitwidth_before := [llvmfunc|
  llvm.func @fshr_constant_shift_amount_modulo_bitwidth(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(34 : i33) : i33
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    llvm.return %1 : i33
  }]

def fshl_undef_shift_amount_before := [llvmfunc|
  llvm.func @fshl_undef_shift_amount(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

def fshr_undef_shift_amount_before := [llvmfunc|
  llvm.func @fshr_undef_shift_amount(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.undef : i33
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    llvm.return %1 : i33
  }]

def fshr_constant_shift_amount_modulo_bitwidth_constexpr_before := [llvmfunc|
  llvm.func @fshr_constant_shift_amount_modulo_bitwidth_constexpr(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.addressof @external_global : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

def fshr_constant_shift_amount_modulo_bitwidth_vec_before := [llvmfunc|
  llvm.func @fshr_constant_shift_amount_modulo_bitwidth_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[34, -1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def fshl_constant_shift_amount_modulo_bitwidth_vec_before := [llvmfunc|
  llvm.func @fshl_constant_shift_amount_modulo_bitwidth_vec(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(-1 : i31) : i31
    %1 = llvm.mlir.constant(34 : i31) : i31
    %2 = llvm.mlir.constant(dense<[34, -1]> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

def fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr_before := [llvmfunc|
  llvm.func @fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.addressof @external_global : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i31
    %2 = llvm.mlir.constant(34 : i31) : i31
    %3 = llvm.mlir.undef : vector<2xi31>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi31>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi31>
    %8 = llvm.ptrtoint %0 : !llvm.ptr to i31
    %9 = llvm.intr.fshl(%arg0, %arg1, %7)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %9 : vector<2xi31>
  }]

def fshl_undef_shift_amount_vec_before := [llvmfunc|
  llvm.func @fshl_undef_shift_amount_vec(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.undef : vector<2xi31>
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %1 : vector<2xi31>
  }]

def fshr_undef_shift_amount_vec_before := [llvmfunc|
  llvm.func @fshr_undef_shift_amount_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def rotl_common_demanded_before := [llvmfunc|
  llvm.func @rotl_common_demanded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }]

def rotr_common_demanded_before := [llvmfunc|
  llvm.func @rotr_common_demanded(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(2 : i33) : i33
    %1 = llvm.mlir.constant(8 : i33) : i33
    %2 = llvm.xor %arg0, %0  : i33
    %3 = llvm.intr.fshr(%2, %2, %1)  : (i33, i33, i33) -> i33
    llvm.return %3 : i33
  }]

def fshl_only_op1_demanded_vec_nonsplat_before := [llvmfunc|
  llvm.func @fshl_only_op1_demanded_vec_nonsplat(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(38 : i31) : i31
    %1 = llvm.mlir.constant(7 : i31) : i31
    %2 = llvm.mlir.constant(dense<[7, 38]> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.mlir.constant(31 : i31) : i31
    %4 = llvm.mlir.constant(63 : i31) : i31
    %5 = llvm.mlir.constant(dense<[63, 31]> : vector<2xi31>) : vector<2xi31>
    %6 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    %7 = llvm.and %6, %5  : vector<2xi31>
    llvm.return %7 : vector<2xi31>
  }]

def rotl_constant_shift_amount_before := [llvmfunc|
  llvm.func @rotl_constant_shift_amount(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(33 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

def rotl_constant_shift_amount_vec_before := [llvmfunc|
  llvm.func @rotl_constant_shift_amount_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(-1 : i31) : i31
    %1 = llvm.mlir.constant(32 : i31) : i31
    %2 = llvm.mlir.constant(dense<[32, -1]> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg0, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

def rotr_constant_shift_amount_before := [llvmfunc|
  llvm.func @rotr_constant_shift_amount(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(34 : i33) : i33
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i33, i33, i33) -> i33
    llvm.return %1 : i33
  }]

def rotr_constant_shift_amount_vec_before := [llvmfunc|
  llvm.func @rotr_constant_shift_amount_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[33, -1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def fshl_both_ops_demanded_before := [llvmfunc|
  llvm.func @fshl_both_ops_demanded(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(192 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

def fshr_both_ops_demanded_before := [llvmfunc|
  llvm.func @fshr_both_ops_demanded(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(26 : i33) : i33
    %1 = llvm.mlir.constant(192 : i33) : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    %3 = llvm.and %2, %1  : i33
    llvm.return %3 : i33
  }]

def fshl_known_bits_before := [llvmfunc|
  llvm.func @fshl_known_bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(192 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.lshr %arg1, %0  : i32
    %5 = llvm.intr.fshl(%3, %4, %1)  : (i32, i32, i32) -> i32
    %6 = llvm.and %5, %2  : i32
    llvm.return %6 : i32
  }]

def fshr_known_bits_before := [llvmfunc|
  llvm.func @fshr_known_bits(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = llvm.mlir.constant(26 : i33) : i33
    %2 = llvm.mlir.constant(192 : i33) : i33
    %3 = llvm.or %arg0, %0  : i33
    %4 = llvm.lshr %arg1, %0  : i33
    %5 = llvm.intr.fshr(%3, %4, %1)  : (i33, i33, i33) -> i33
    %6 = llvm.and %5, %2  : i33
    llvm.return %6 : i33
  }]

def fshr_multi_use_before := [llvmfunc|
  llvm.func @fshr_multi_use(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = llvm.mlir.constant(23 : i33) : i33
    %2 = llvm.mlir.constant(31 : i33) : i33
    %3 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i33, i33, i33) -> i33
    %4 = llvm.lshr %3, %1  : i33
    %5 = llvm.xor %4, %3  : i33
    %6 = llvm.and %5, %2  : i33
    llvm.return %6 : i33
  }]

def expanded_fshr_multi_use_before := [llvmfunc|
  llvm.func @expanded_fshr_multi_use(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(1 : i33) : i33
    %1 = llvm.mlir.constant(32 : i33) : i33
    %2 = llvm.mlir.constant(23 : i33) : i33
    %3 = llvm.mlir.constant(31 : i33) : i33
    %4 = llvm.lshr %arg0, %0  : i33
    %5 = llvm.shl %arg0, %1  : i33
    %6 = llvm.or %4, %5  : i33
    %7 = llvm.lshr %6, %2  : i33
    %8 = llvm.xor %7, %6  : i33
    %9 = llvm.and %8, %3  : i33
    llvm.return %9 : i33
  }]

def fshl_bswap_before := [llvmfunc|
  llvm.func @fshl_bswap(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

def fshr_bswap_before := [llvmfunc|
  llvm.func @fshr_bswap(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

def fshl_bswap_vector_before := [llvmfunc|
  llvm.func @fshl_bswap_vector(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<3xi16>, vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    llvm.return %1 : vector<3xi16>
  }]

def fshl_bswap_wrong_op_before := [llvmfunc|
  llvm.func @fshl_bswap_wrong_op(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

def fshr_bswap_wrong_amount_before := [llvmfunc|
  llvm.func @fshr_bswap_wrong_amount(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

def fshl_bswap_wrong_width_before := [llvmfunc|
  llvm.func @fshl_bswap_wrong_width(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

def fshl_mask_args_same1_before := [llvmfunc|
  llvm.func @fshl_mask_args_same1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }]

def fshl_mask_args_same2_before := [llvmfunc|
  llvm.func @fshl_mask_args_same2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }]

def fshl_mask_args_same3_before := [llvmfunc|
  llvm.func @fshl_mask_args_same3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }]

def fshl_mask_args_different_before := [llvmfunc|
  llvm.func @fshl_mask_args_different(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.mlir.constant(17 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.intr.fshl(%3, %4, %2)  : (i32, i32, i32) -> i32
    llvm.return %5 : i32
  }]

def fsh_andconst_rotate_before := [llvmfunc|
  llvm.func @fsh_andconst_rotate(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }]

def fsh_orconst_rotate_before := [llvmfunc|
  llvm.func @fsh_orconst_rotate(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-268435456 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }]

def fsh_rotate_5_before := [llvmfunc|
  llvm.func @fsh_rotate_5(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(27 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.lshr %3, %0  : i32
    %5 = llvm.shl %3, %1  : i32
    %6 = llvm.or %4, %5  : i32
    llvm.return %6 : i32
  }]

def fsh_rotate_18_before := [llvmfunc|
  llvm.func @fsh_rotate_18(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.mlir.constant(18 : i32) : i32
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.or %2, %arg1  : i32
    %4 = llvm.lshr %3, %0  : i32
    %5 = llvm.shl %3, %1  : i32
    %6 = llvm.or %4, %5  : i32
    llvm.return %6 : i32
  }]

def fsh_load_rotate_12_before := [llvmfunc|
  llvm.func @fsh_load_rotate_12(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(20 : i32) : i32
    %7 = llvm.mlir.constant(12 : i32) : i32
    %8 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %9 = llvm.zext %8 : i8 to i32
    %10 = llvm.shl %9, %0 overflow<nuw>  : i32
    %11 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %13 = llvm.zext %12 : i8 to i32
    %14 = llvm.shl %13, %2 overflow<nsw, nuw>  : i32
    %15 = llvm.or %14, %10  : i32
    %16 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %17 = llvm.load %16 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %18 = llvm.zext %17 : i8 to i32
    %19 = llvm.shl %18, %4 overflow<nsw, nuw>  : i32
    %20 = llvm.or %15, %19  : i32
    %21 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %22 = llvm.load %21 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %23 = llvm.zext %22 : i8 to i32
    %24 = llvm.or %20, %23  : i32
    %25 = llvm.lshr %24, %6  : i32
    %26 = llvm.shl %24, %7  : i32
    %27 = llvm.or %25, %26  : i32
    llvm.return %27 : i32
  }]

def fsh_load_rotate_25_before := [llvmfunc|
  llvm.func @fsh_load_rotate_25(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(7 : i32) : i32
    %7 = llvm.mlir.constant(25 : i32) : i32
    %8 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %9 = llvm.zext %8 : i8 to i32
    %10 = llvm.shl %9, %0 overflow<nuw>  : i32
    %11 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %12 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %13 = llvm.zext %12 : i8 to i32
    %14 = llvm.shl %13, %2 overflow<nsw, nuw>  : i32
    %15 = llvm.or %14, %10  : i32
    %16 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %17 = llvm.load %16 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %18 = llvm.zext %17 : i8 to i32
    %19 = llvm.shl %18, %4 overflow<nsw, nuw>  : i32
    %20 = llvm.or %15, %19  : i32
    %21 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %22 = llvm.load %21 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %23 = llvm.zext %22 : i8 to i32
    %24 = llvm.or %20, %23  : i32
    %25 = llvm.lshr %24, %6  : i32
    %26 = llvm.shl %24, %7  : i32
    %27 = llvm.or %25, %26  : i32
    llvm.return %27 : i32
  }]

def fshr_mask_args_same_vector_before := [llvmfunc|
  llvm.func @fshr_mask_args_same_vector(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(1000 : i31) : i31
    %1 = llvm.mlir.constant(dense<1000> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(-1 : i31) : i31
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi31>) : vector<2xi31>
    %4 = llvm.mlir.constant(10 : i31) : i31
    %5 = llvm.mlir.constant(dense<10> : vector<2xi31>) : vector<2xi31>
    %6 = llvm.and %arg0, %1  : vector<2xi31>
    %7 = llvm.and %arg0, %3  : vector<2xi31>
    %8 = llvm.intr.fshl(%7, %6, %5)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %8 : vector<2xi31>
  }]

def fshr_mask_args_same_vector2_before := [llvmfunc|
  llvm.func @fshr_mask_args_same_vector2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000000, 100000]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.and %arg0, %1  : vector<2xi32>
    %5 = llvm.intr.fshr(%3, %3, %2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def fshr_mask_args_same_vector3_different_but_still_prunable_before := [llvmfunc|
  llvm.func @fshr_mask_args_same_vector3_different_but_still_prunable(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(1000 : i31) : i31
    %1 = llvm.mlir.constant(dense<1000> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(-1 : i31) : i31
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi31>) : vector<2xi31>
    %4 = llvm.mlir.constant(3 : i31) : i31
    %5 = llvm.mlir.constant(10 : i31) : i31
    %6 = llvm.mlir.constant(dense<[10, 3]> : vector<2xi31>) : vector<2xi31>
    %7 = llvm.and %arg0, %1  : vector<2xi31>
    %8 = llvm.and %arg0, %3  : vector<2xi31>
    %9 = llvm.intr.fshl(%8, %7, %6)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %9 : vector<2xi31>
  }]

def fsh_unary_shuffle_ops_before := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xi32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xi32> 
    %4 = llvm.intr.fshr(%1, %2, %3)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def fsh_unary_shuffle_ops_widening_before := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_widening(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: vector<2xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 1] : vector<2xi16> 
    llvm.call @use_v3(%1) : (vector<3xi16>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0, 1] : vector<2xi16> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0, 1] : vector<2xi16> 
    %4 = llvm.intr.fshl(%1, %2, %3)  : (vector<3xi16>, vector<3xi16>, vector<3xi16>) -> vector<3xi16>
    llvm.return %4 : vector<3xi16>
  }]

def fsh_unary_shuffle_ops_narrowing_before := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_narrowing(%arg0: vector<3xi31>, %arg1: vector<3xi31>, %arg2: vector<3xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.poison : vector<3xi31>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<3xi31> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<3xi31> 
    llvm.call @use_v2(%2) : (vector<2xi31>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<3xi31> 
    %4 = llvm.intr.fshl(%1, %2, %3)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %4 : vector<2xi31>
  }]

def fsh_unary_shuffle_ops_unshuffled_before := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_unshuffled(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xi32> 
    %3 = llvm.intr.fshr(%1, %2, %arg2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def fsh_unary_shuffle_ops_wrong_mask_before := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_wrong_mask(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %2 = llvm.shufflevector %arg1, %0 [0, 0] : vector<2xi32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xi32> 
    %4 = llvm.intr.fshr(%1, %2, %3)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def fsh_unary_shuffle_ops_uses_before := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_uses(%arg0: vector<2xi31>, %arg1: vector<2xi31>, %arg2: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.poison : vector<2xi31>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi31> 
    llvm.call @use_v2(%1) : (vector<2xi31>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xi31> 
    llvm.call @use_v2(%2) : (vector<2xi31>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xi31> 
    llvm.call @use_v2(%3) : (vector<2xi31>) -> ()
    %4 = llvm.intr.fshl(%1, %2, %3)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %4 : vector<2xi31>
  }]

def fsh_unary_shuffle_ops_partial_widening_before := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_partial_widening(%arg0: vector<3xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<3xi32>
    %1 = llvm.mlir.poison : vector<2xi32>
    %2 = llvm.shufflevector %arg0, %0 [1, 0] : vector<3xi32> 
    %3 = llvm.shufflevector %arg1, %1 [1, 0] : vector<2xi32> 
    %4 = llvm.shufflevector %arg2, %1 [1, 0] : vector<2xi32> 
    %5 = llvm.intr.fshr(%2, %3, %4)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def fshr_vec_zero_elem_before := [llvmfunc|
  llvm.func @fshr_vec_zero_elem(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshr(%arg0, %arg1, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

def fshl_mask_simplify1_combined := [llvmfunc|
  llvm.func @fshl_mask_simplify1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_fshl_mask_simplify1   : fshl_mask_simplify1_before  ⊑  fshl_mask_simplify1_combined := by
  unfold fshl_mask_simplify1_before fshl_mask_simplify1_combined
  simp_alive_peephole
  sorry
def fshr_mask_simplify2_combined := [llvmfunc|
  llvm.func @fshr_mask_simplify2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    llvm.return %arg1 : vector<2xi32>
  }]

theorem inst_combine_fshr_mask_simplify2   : fshr_mask_simplify2_before  ⊑  fshr_mask_simplify2_combined := by
  unfold fshr_mask_simplify2_before fshr_mask_simplify2_combined
  simp_alive_peephole
  sorry
def fshl_mask_simplify3_combined := [llvmfunc|
  llvm.func @fshl_mask_simplify3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fshl_mask_simplify3   : fshl_mask_simplify3_before  ⊑  fshl_mask_simplify3_combined := by
  unfold fshl_mask_simplify3_before fshl_mask_simplify3_combined
  simp_alive_peephole
  sorry
def fshr_mask_simplify1_combined := [llvmfunc|
  llvm.func @fshr_mask_simplify1(%arg0: i33, %arg1: i33, %arg2: i33) -> i33 {
    %0 = llvm.mlir.constant(64 : i33) : i33
    %1 = llvm.and %arg2, %0  : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

theorem inst_combine_fshr_mask_simplify1   : fshr_mask_simplify1_before  ⊑  fshr_mask_simplify1_combined := by
  unfold fshr_mask_simplify1_before fshr_mask_simplify1_combined
  simp_alive_peephole
  sorry
def fshl_mask_simplify2_combined := [llvmfunc|
  llvm.func @fshl_mask_simplify2(%arg0: vector<2xi31>, %arg1: vector<2xi31>, %arg2: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(32 : i31) : i31
    %1 = llvm.mlir.constant(dense<32> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.and %arg2, %1  : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

theorem inst_combine_fshl_mask_simplify2   : fshl_mask_simplify2_before  ⊑  fshl_mask_simplify2_combined := by
  unfold fshl_mask_simplify2_before fshl_mask_simplify2_combined
  simp_alive_peephole
  sorry
def fshr_mask_simplify3_combined := [llvmfunc|
  llvm.func @fshr_mask_simplify3(%arg0: i33, %arg1: i33, %arg2: i33) -> i33 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = llvm.and %arg2, %0  : i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

theorem inst_combine_fshr_mask_simplify3   : fshr_mask_simplify3_before  ⊑  fshr_mask_simplify3_combined := by
  unfold fshr_mask_simplify3_before fshr_mask_simplify3_combined
  simp_alive_peephole
  sorry
def fshl_mask_not_required_combined := [llvmfunc|
  llvm.func @fshl_mask_not_required(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (i32, i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fshl_mask_not_required   : fshl_mask_not_required_before  ⊑  fshl_mask_not_required_combined := by
  unfold fshl_mask_not_required_before fshl_mask_not_required_combined
  simp_alive_peephole
  sorry
def fshl_mask_reduce_constant_combined := [llvmfunc|
  llvm.func @fshl_mask_reduce_constant(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fshl_mask_reduce_constant   : fshl_mask_reduce_constant_before  ⊑  fshl_mask_reduce_constant_combined := by
  unfold fshl_mask_reduce_constant_before fshl_mask_reduce_constant_combined
  simp_alive_peephole
  sorry
def fshl_mask_negative_combined := [llvmfunc|
  llvm.func @fshl_mask_negative(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fshl_mask_negative   : fshl_mask_negative_before  ⊑  fshl_mask_negative_combined := by
  unfold fshl_mask_negative_before fshl_mask_negative_combined
  simp_alive_peephole
  sorry
def fshr_set_but_not_demanded_vec_combined := [llvmfunc|
  llvm.func @fshr_set_but_not_demanded_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.fshr(%arg0, %arg1, %arg2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_fshr_set_but_not_demanded_vec   : fshr_set_but_not_demanded_vec_before  ⊑  fshr_set_but_not_demanded_vec_combined := by
  unfold fshr_set_but_not_demanded_vec_before fshr_set_but_not_demanded_vec_combined
  simp_alive_peephole
  sorry
def fshl_set_but_not_demanded_vec_combined := [llvmfunc|
  llvm.func @fshl_set_but_not_demanded_vec(%arg0: vector<2xi31>, %arg1: vector<2xi31>, %arg2: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(32 : i31) : i31
    %1 = llvm.mlir.constant(dense<32> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.or %arg2, %1  : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

theorem inst_combine_fshl_set_but_not_demanded_vec   : fshl_set_but_not_demanded_vec_before  ⊑  fshl_set_but_not_demanded_vec_combined := by
  unfold fshl_set_but_not_demanded_vec_before fshl_set_but_not_demanded_vec_combined
  simp_alive_peephole
  sorry
def fshl_op0_undef_combined := [llvmfunc|
  llvm.func @fshl_op0_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fshl_op0_undef   : fshl_op0_undef_before  ⊑  fshl_op0_undef_combined := by
  unfold fshl_op0_undef_before fshl_op0_undef_combined
  simp_alive_peephole
  sorry
def fshl_op0_zero_combined := [llvmfunc|
  llvm.func @fshl_op0_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fshl_op0_zero   : fshl_op0_zero_before  ⊑  fshl_op0_zero_combined := by
  unfold fshl_op0_zero_before fshl_op0_zero_combined
  simp_alive_peephole
  sorry
def fshr_op0_undef_combined := [llvmfunc|
  llvm.func @fshr_op0_undef(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(7 : i33) : i33
    %1 = llvm.lshr %arg0, %0  : i33
    llvm.return %1 : i33
  }]

theorem inst_combine_fshr_op0_undef   : fshr_op0_undef_before  ⊑  fshr_op0_undef_combined := by
  unfold fshr_op0_undef_before fshr_op0_undef_combined
  simp_alive_peephole
  sorry
def fshr_op0_zero_combined := [llvmfunc|
  llvm.func @fshr_op0_zero(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(7 : i33) : i33
    %1 = llvm.lshr %arg0, %0  : i33
    llvm.return %1 : i33
  }]

theorem inst_combine_fshr_op0_zero   : fshr_op0_zero_before  ⊑  fshr_op0_zero_combined := by
  unfold fshr_op0_zero_before fshr_op0_zero_combined
  simp_alive_peephole
  sorry
def fshl_op1_undef_combined := [llvmfunc|
  llvm.func @fshl_op1_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fshl_op1_undef   : fshl_op1_undef_before  ⊑  fshl_op1_undef_combined := by
  unfold fshl_op1_undef_before fshl_op1_undef_combined
  simp_alive_peephole
  sorry
def fshl_op1_zero_combined := [llvmfunc|
  llvm.func @fshl_op1_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fshl_op1_zero   : fshl_op1_zero_before  ⊑  fshl_op1_zero_combined := by
  unfold fshl_op1_zero_before fshl_op1_zero_combined
  simp_alive_peephole
  sorry
def fshr_op1_undef_combined := [llvmfunc|
  llvm.func @fshr_op1_undef(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(26 : i33) : i33
    %1 = llvm.shl %arg0, %0  : i33
    llvm.return %1 : i33
  }]

theorem inst_combine_fshr_op1_undef   : fshr_op1_undef_before  ⊑  fshr_op1_undef_combined := by
  unfold fshr_op1_undef_before fshr_op1_undef_combined
  simp_alive_peephole
  sorry
def fshr_op1_zero_combined := [llvmfunc|
  llvm.func @fshr_op1_zero(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(26 : i33) : i33
    %1 = llvm.shl %arg0, %0  : i33
    llvm.return %1 : i33
  }]

theorem inst_combine_fshr_op1_zero   : fshr_op1_zero_before  ⊑  fshr_op1_zero_combined := by
  unfold fshr_op1_zero_before fshr_op1_zero_combined
  simp_alive_peephole
  sorry
def fshl_op0_zero_splat_vec_combined := [llvmfunc|
  llvm.func @fshl_op0_zero_splat_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(24 : i31) : i31
    %1 = llvm.mlir.constant(dense<24> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.lshr %arg0, %1  : vector<2xi31>
    llvm.return %2 : vector<2xi31>
  }]

theorem inst_combine_fshl_op0_zero_splat_vec   : fshl_op0_zero_splat_vec_before  ⊑  fshl_op0_zero_splat_vec_combined := by
  unfold fshl_op0_zero_splat_vec_before fshl_op0_zero_splat_vec_combined
  simp_alive_peephole
  sorry
def fshl_op1_undef_splat_vec_combined := [llvmfunc|
  llvm.func @fshl_op1_undef_splat_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(7 : i31) : i31
    %1 = llvm.mlir.constant(dense<7> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.shl %arg0, %1  : vector<2xi31>
    llvm.return %2 : vector<2xi31>
  }]

theorem inst_combine_fshl_op1_undef_splat_vec   : fshl_op1_undef_splat_vec_before  ⊑  fshl_op1_undef_splat_vec_combined := by
  unfold fshl_op1_undef_splat_vec_before fshl_op1_undef_splat_vec_combined
  simp_alive_peephole
  sorry
def fshr_op0_undef_splat_vec_combined := [llvmfunc|
  llvm.func @fshr_op0_undef_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_fshr_op0_undef_splat_vec   : fshr_op0_undef_splat_vec_before  ⊑  fshr_op0_undef_splat_vec_combined := by
  unfold fshr_op0_undef_splat_vec_before fshr_op0_undef_splat_vec_combined
  simp_alive_peephole
  sorry
def fshr_op1_zero_splat_vec_combined := [llvmfunc|
  llvm.func @fshr_op1_zero_splat_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<25> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_fshr_op1_zero_splat_vec   : fshr_op1_zero_splat_vec_before  ⊑  fshr_op1_zero_splat_vec_combined := by
  unfold fshr_op1_zero_splat_vec_before fshr_op1_zero_splat_vec_combined
  simp_alive_peephole
  sorry
def fshl_op0_zero_vec_combined := [llvmfunc|
  llvm.func @fshl_op0_zero_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(29 : i31) : i31
    %1 = llvm.mlir.constant(30 : i31) : i31
    %2 = llvm.mlir.constant(dense<[30, 29]> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.lshr %arg0, %2  : vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

theorem inst_combine_fshl_op0_zero_vec   : fshl_op0_zero_vec_before  ⊑  fshl_op0_zero_vec_combined := by
  unfold fshl_op0_zero_vec_before fshl_op0_zero_vec_combined
  simp_alive_peephole
  sorry
def fshl_op1_undef_vec_combined := [llvmfunc|
  llvm.func @fshl_op1_undef_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(2 : i31) : i31
    %1 = llvm.mlir.constant(1 : i31) : i31
    %2 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.shl %arg0, %2  : vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

theorem inst_combine_fshl_op1_undef_vec   : fshl_op1_undef_vec_before  ⊑  fshl_op1_undef_vec_combined := by
  unfold fshl_op1_undef_vec_before fshl_op1_undef_vec_combined
  simp_alive_peephole
  sorry
def fshr_op0_undef_vec_combined := [llvmfunc|
  llvm.func @fshr_op0_undef_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[31, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_fshr_op0_undef_vec   : fshr_op0_undef_vec_before  ⊑  fshr_op0_undef_vec_combined := by
  unfold fshr_op0_undef_vec_before fshr_op0_undef_vec_combined
  simp_alive_peephole
  sorry
def fshr_op1_zero_vec_combined := [llvmfunc|
  llvm.func @fshr_op1_zero_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 31]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %arg0, %0  : vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_fshr_op1_zero_vec   : fshr_op1_zero_vec_before  ⊑  fshr_op1_zero_vec_combined := by
  unfold fshr_op1_zero_vec_before fshr_op1_zero_vec_combined
  simp_alive_peephole
  sorry
def fshl_only_op0_demanded_combined := [llvmfunc|
  llvm.func @fshl_only_op0_demanded(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_fshl_only_op0_demanded   : fshl_only_op0_demanded_before  ⊑  fshl_only_op0_demanded_combined := by
  unfold fshl_only_op0_demanded_before fshl_only_op0_demanded_combined
  simp_alive_peephole
  sorry
def fshl_only_op1_demanded_combined := [llvmfunc|
  llvm.func @fshl_only_op1_demanded(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.mlir.constant(63 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_fshl_only_op1_demanded   : fshl_only_op1_demanded_before  ⊑  fshl_only_op1_demanded_combined := by
  unfold fshl_only_op1_demanded_before fshl_only_op1_demanded_combined
  simp_alive_peephole
  sorry
def fshr_only_op1_demanded_combined := [llvmfunc|
  llvm.func @fshr_only_op1_demanded(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(7 : i33) : i33
    %1 = llvm.mlir.constant(12392 : i33) : i33
    %2 = llvm.lshr %arg1, %0  : i33
    %3 = llvm.and %2, %1  : i33
    llvm.return %3 : i33
  }]

theorem inst_combine_fshr_only_op1_demanded   : fshr_only_op1_demanded_before  ⊑  fshr_only_op1_demanded_combined := by
  unfold fshr_only_op1_demanded_before fshr_only_op1_demanded_combined
  simp_alive_peephole
  sorry
def fshr_only_op0_demanded_combined := [llvmfunc|
  llvm.func @fshr_only_op0_demanded(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(4 : i33) : i33
    %1 = llvm.mlir.constant(7 : i33) : i33
    %2 = llvm.lshr %arg0, %0  : i33
    %3 = llvm.and %2, %1  : i33
    llvm.return %3 : i33
  }]

theorem inst_combine_fshr_only_op0_demanded   : fshr_only_op0_demanded_before  ⊑  fshr_only_op0_demanded_combined := by
  unfold fshr_only_op0_demanded_before fshr_only_op0_demanded_combined
  simp_alive_peephole
  sorry
def fshl_only_op1_demanded_vec_splat_combined := [llvmfunc|
  llvm.func @fshl_only_op1_demanded_vec_splat(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(24 : i31) : i31
    %1 = llvm.mlir.constant(dense<24> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(31 : i31) : i31
    %3 = llvm.mlir.constant(63 : i31) : i31
    %4 = llvm.mlir.constant(dense<[63, 31]> : vector<2xi31>) : vector<2xi31>
    %5 = llvm.lshr %arg1, %1  : vector<2xi31>
    %6 = llvm.and %5, %4  : vector<2xi31>
    llvm.return %6 : vector<2xi31>
  }]

theorem inst_combine_fshl_only_op1_demanded_vec_splat   : fshl_only_op1_demanded_vec_splat_before  ⊑  fshl_only_op1_demanded_vec_splat_combined := by
  unfold fshl_only_op1_demanded_vec_splat_before fshl_only_op1_demanded_vec_splat_combined
  simp_alive_peephole
  sorry
def fshl_constant_shift_amount_modulo_bitwidth_combined := [llvmfunc|
  llvm.func @fshl_constant_shift_amount_modulo_bitwidth(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fshl_constant_shift_amount_modulo_bitwidth   : fshl_constant_shift_amount_modulo_bitwidth_before  ⊑  fshl_constant_shift_amount_modulo_bitwidth_combined := by
  unfold fshl_constant_shift_amount_modulo_bitwidth_before fshl_constant_shift_amount_modulo_bitwidth_combined
  simp_alive_peephole
  sorry
def fshr_constant_shift_amount_modulo_bitwidth_combined := [llvmfunc|
  llvm.func @fshr_constant_shift_amount_modulo_bitwidth(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    llvm.return %1 : i33
  }]

theorem inst_combine_fshr_constant_shift_amount_modulo_bitwidth   : fshr_constant_shift_amount_modulo_bitwidth_before  ⊑  fshr_constant_shift_amount_modulo_bitwidth_combined := by
  unfold fshr_constant_shift_amount_modulo_bitwidth_before fshr_constant_shift_amount_modulo_bitwidth_combined
  simp_alive_peephole
  sorry
def fshl_undef_shift_amount_combined := [llvmfunc|
  llvm.func @fshl_undef_shift_amount(%arg0: i32, %arg1: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_fshl_undef_shift_amount   : fshl_undef_shift_amount_before  ⊑  fshl_undef_shift_amount_combined := by
  unfold fshl_undef_shift_amount_before fshl_undef_shift_amount_combined
  simp_alive_peephole
  sorry
def fshr_undef_shift_amount_combined := [llvmfunc|
  llvm.func @fshr_undef_shift_amount(%arg0: i33, %arg1: i33) -> i33 {
    llvm.return %arg1 : i33
  }]

theorem inst_combine_fshr_undef_shift_amount   : fshr_undef_shift_amount_before  ⊑  fshr_undef_shift_amount_combined := by
  unfold fshr_undef_shift_amount_before fshr_undef_shift_amount_combined
  simp_alive_peephole
  sorry
def fshr_constant_shift_amount_modulo_bitwidth_constexpr_combined := [llvmfunc|
  llvm.func @fshr_constant_shift_amount_modulo_bitwidth_constexpr(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.addressof @external_global : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i33
    %2 = llvm.intr.fshr(%arg0, %arg1, %1)  : (i33, i33, i33) -> i33
    llvm.return %2 : i33
  }]

theorem inst_combine_fshr_constant_shift_amount_modulo_bitwidth_constexpr   : fshr_constant_shift_amount_modulo_bitwidth_constexpr_before  ⊑  fshr_constant_shift_amount_modulo_bitwidth_constexpr_combined := by
  unfold fshr_constant_shift_amount_modulo_bitwidth_constexpr_before fshr_constant_shift_amount_modulo_bitwidth_constexpr_combined
  simp_alive_peephole
  sorry
def fshr_constant_shift_amount_modulo_bitwidth_vec_combined := [llvmfunc|
  llvm.func @fshr_constant_shift_amount_modulo_bitwidth_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[30, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_fshr_constant_shift_amount_modulo_bitwidth_vec   : fshr_constant_shift_amount_modulo_bitwidth_vec_before  ⊑  fshr_constant_shift_amount_modulo_bitwidth_vec_combined := by
  unfold fshr_constant_shift_amount_modulo_bitwidth_vec_before fshr_constant_shift_amount_modulo_bitwidth_vec_combined
  simp_alive_peephole
  sorry
def fshl_constant_shift_amount_modulo_bitwidth_vec_combined := [llvmfunc|
  llvm.func @fshl_constant_shift_amount_modulo_bitwidth_vec(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(1 : i31) : i31
    %1 = llvm.mlir.constant(3 : i31) : i31
    %2 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi31>) : vector<2xi31>
    %3 = llvm.intr.fshl(%arg0, %arg1, %2)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %3 : vector<2xi31>
  }]

theorem inst_combine_fshl_constant_shift_amount_modulo_bitwidth_vec   : fshl_constant_shift_amount_modulo_bitwidth_vec_before  ⊑  fshl_constant_shift_amount_modulo_bitwidth_vec_combined := by
  unfold fshl_constant_shift_amount_modulo_bitwidth_vec_before fshl_constant_shift_amount_modulo_bitwidth_vec_combined
  simp_alive_peephole
  sorry
def fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr_combined := [llvmfunc|
  llvm.func @fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.addressof @external_global : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i31
    %2 = llvm.mlir.constant(34 : i31) : i31
    %3 = llvm.mlir.undef : vector<2xi31>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi31>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi31>
    %8 = llvm.intr.fshl(%arg0, %arg1, %7)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %8 : vector<2xi31>
  }]

theorem inst_combine_fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr   : fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr_before  ⊑  fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr_combined := by
  unfold fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr_before fshl_constant_shift_amount_modulo_bitwidth_vec_const_expr_combined
  simp_alive_peephole
  sorry
def fshl_undef_shift_amount_vec_combined := [llvmfunc|
  llvm.func @fshl_undef_shift_amount_vec(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    llvm.return %arg0 : vector<2xi31>
  }]

theorem inst_combine_fshl_undef_shift_amount_vec   : fshl_undef_shift_amount_vec_before  ⊑  fshl_undef_shift_amount_vec_combined := by
  unfold fshl_undef_shift_amount_vec_before fshl_undef_shift_amount_vec_combined
  simp_alive_peephole
  sorry
def fshr_undef_shift_amount_vec_combined := [llvmfunc|
  llvm.func @fshr_undef_shift_amount_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    llvm.return %arg1 : vector<2xi32>
  }]

theorem inst_combine_fshr_undef_shift_amount_vec   : fshr_undef_shift_amount_vec_before  ⊑  fshr_undef_shift_amount_vec_combined := by
  unfold fshr_undef_shift_amount_vec_before fshr_undef_shift_amount_vec_combined
  simp_alive_peephole
  sorry
def rotl_common_demanded_combined := [llvmfunc|
  llvm.func @rotl_common_demanded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_rotl_common_demanded   : rotl_common_demanded_before  ⊑  rotl_common_demanded_combined := by
  unfold rotl_common_demanded_before rotl_common_demanded_combined
  simp_alive_peephole
  sorry
def rotr_common_demanded_combined := [llvmfunc|
  llvm.func @rotr_common_demanded(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(2 : i33) : i33
    %1 = llvm.mlir.constant(25 : i33) : i33
    %2 = llvm.xor %arg0, %0  : i33
    %3 = llvm.intr.fshl(%2, %2, %1)  : (i33, i33, i33) -> i33
    llvm.return %3 : i33
  }]

theorem inst_combine_rotr_common_demanded   : rotr_common_demanded_before  ⊑  rotr_common_demanded_combined := by
  unfold rotr_common_demanded_before rotr_common_demanded_combined
  simp_alive_peephole
  sorry
def fshl_only_op1_demanded_vec_nonsplat_combined := [llvmfunc|
  llvm.func @fshl_only_op1_demanded_vec_nonsplat(%arg0: vector<2xi31>, %arg1: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(24 : i31) : i31
    %1 = llvm.mlir.constant(dense<24> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(31 : i31) : i31
    %3 = llvm.mlir.constant(63 : i31) : i31
    %4 = llvm.mlir.constant(dense<[63, 31]> : vector<2xi31>) : vector<2xi31>
    %5 = llvm.lshr %arg1, %1  : vector<2xi31>
    %6 = llvm.and %5, %4  : vector<2xi31>
    llvm.return %6 : vector<2xi31>
  }]

theorem inst_combine_fshl_only_op1_demanded_vec_nonsplat   : fshl_only_op1_demanded_vec_nonsplat_before  ⊑  fshl_only_op1_demanded_vec_nonsplat_combined := by
  unfold fshl_only_op1_demanded_vec_nonsplat_before fshl_only_op1_demanded_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def rotl_constant_shift_amount_combined := [llvmfunc|
  llvm.func @rotl_constant_shift_amount(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_rotl_constant_shift_amount   : rotl_constant_shift_amount_before  ⊑  rotl_constant_shift_amount_combined := by
  unfold rotl_constant_shift_amount_before rotl_constant_shift_amount_combined
  simp_alive_peephole
  sorry
def rotl_constant_shift_amount_vec_combined := [llvmfunc|
  llvm.func @rotl_constant_shift_amount_vec(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(1 : i31) : i31
    %1 = llvm.mlir.constant(dense<1> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.intr.fshl(%arg0, %arg0, %1)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %2 : vector<2xi31>
  }]

theorem inst_combine_rotl_constant_shift_amount_vec   : rotl_constant_shift_amount_vec_before  ⊑  rotl_constant_shift_amount_vec_combined := by
  unfold rotl_constant_shift_amount_vec_before rotl_constant_shift_amount_vec_combined
  simp_alive_peephole
  sorry
def rotr_constant_shift_amount_combined := [llvmfunc|
  llvm.func @rotr_constant_shift_amount(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i33, i33, i33) -> i33
    llvm.return %1 : i33
  }]

theorem inst_combine_rotr_constant_shift_amount   : rotr_constant_shift_amount_before  ⊑  rotr_constant_shift_amount_combined := by
  unfold rotr_constant_shift_amount_before rotr_constant_shift_amount_combined
  simp_alive_peephole
  sorry
def rotr_constant_shift_amount_vec_combined := [llvmfunc|
  llvm.func @rotr_constant_shift_amount_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[31, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_rotr_constant_shift_amount_vec   : rotr_constant_shift_amount_vec_before  ⊑  rotr_constant_shift_amount_vec_combined := by
  unfold rotr_constant_shift_amount_vec_before rotr_constant_shift_amount_vec_combined
  simp_alive_peephole
  sorry
def fshl_both_ops_demanded_combined := [llvmfunc|
  llvm.func @fshl_both_ops_demanded(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(192 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_fshl_both_ops_demanded   : fshl_both_ops_demanded_before  ⊑  fshl_both_ops_demanded_combined := by
  unfold fshl_both_ops_demanded_before fshl_both_ops_demanded_combined
  simp_alive_peephole
  sorry
def fshr_both_ops_demanded_combined := [llvmfunc|
  llvm.func @fshr_both_ops_demanded(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(7 : i33) : i33
    %1 = llvm.mlir.constant(192 : i33) : i33
    %2 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i33, i33, i33) -> i33
    %3 = llvm.and %2, %1  : i33
    llvm.return %3 : i33
  }]

theorem inst_combine_fshr_both_ops_demanded   : fshr_both_ops_demanded_before  ⊑  fshr_both_ops_demanded_combined := by
  unfold fshr_both_ops_demanded_before fshr_both_ops_demanded_combined
  simp_alive_peephole
  sorry
def fshl_known_bits_combined := [llvmfunc|
  llvm.func @fshl_known_bits(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fshl_known_bits   : fshl_known_bits_before  ⊑  fshl_known_bits_combined := by
  unfold fshl_known_bits_before fshl_known_bits_combined
  simp_alive_peephole
  sorry
def fshr_known_bits_combined := [llvmfunc|
  llvm.func @fshr_known_bits(%arg0: i33, %arg1: i33) -> i33 {
    %0 = llvm.mlir.constant(128 : i33) : i33
    llvm.return %0 : i33
  }]

theorem inst_combine_fshr_known_bits   : fshr_known_bits_before  ⊑  fshr_known_bits_combined := by
  unfold fshr_known_bits_before fshr_known_bits_combined
  simp_alive_peephole
  sorry
def fshr_multi_use_combined := [llvmfunc|
  llvm.func @fshr_multi_use(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = llvm.mlir.constant(23 : i33) : i33
    %2 = llvm.mlir.constant(31 : i33) : i33
    %3 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i33, i33, i33) -> i33
    %4 = llvm.lshr %3, %1  : i33
    %5 = llvm.xor %4, %3  : i33
    %6 = llvm.and %5, %2  : i33
    llvm.return %6 : i33
  }]

theorem inst_combine_fshr_multi_use   : fshr_multi_use_before  ⊑  fshr_multi_use_combined := by
  unfold fshr_multi_use_before fshr_multi_use_combined
  simp_alive_peephole
  sorry
def expanded_fshr_multi_use_combined := [llvmfunc|
  llvm.func @expanded_fshr_multi_use(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(32 : i33) : i33
    %1 = llvm.mlir.constant(23 : i33) : i33
    %2 = llvm.mlir.constant(31 : i33) : i33
    %3 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i33, i33, i33) -> i33
    %4 = llvm.lshr %3, %1  : i33
    %5 = llvm.xor %4, %3  : i33
    %6 = llvm.and %5, %2  : i33
    llvm.return %6 : i33
  }]

theorem inst_combine_expanded_fshr_multi_use   : expanded_fshr_multi_use_before  ⊑  expanded_fshr_multi_use_combined := by
  unfold expanded_fshr_multi_use_before expanded_fshr_multi_use_combined
  simp_alive_peephole
  sorry
def fshl_bswap_combined := [llvmfunc|
  llvm.func @fshl_bswap(%arg0: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_fshl_bswap   : fshl_bswap_before  ⊑  fshl_bswap_combined := by
  unfold fshl_bswap_before fshl_bswap_combined
  simp_alive_peephole
  sorry
def fshr_bswap_combined := [llvmfunc|
  llvm.func @fshr_bswap(%arg0: i16) -> i16 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    llvm.return %0 : i16
  }]

theorem inst_combine_fshr_bswap   : fshr_bswap_before  ⊑  fshr_bswap_combined := by
  unfold fshr_bswap_before fshr_bswap_combined
  simp_alive_peephole
  sorry
def fshl_bswap_vector_combined := [llvmfunc|
  llvm.func @fshl_bswap_vector(%arg0: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<3xi16>) -> vector<3xi16>
    llvm.return %0 : vector<3xi16>
  }]

theorem inst_combine_fshl_bswap_vector   : fshl_bswap_vector_before  ⊑  fshl_bswap_vector_combined := by
  unfold fshl_bswap_vector_before fshl_bswap_vector_combined
  simp_alive_peephole
  sorry
def fshl_bswap_wrong_op_combined := [llvmfunc|
  llvm.func @fshl_bswap_wrong_op(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_fshl_bswap_wrong_op   : fshl_bswap_wrong_op_before  ⊑  fshl_bswap_wrong_op_combined := by
  unfold fshl_bswap_wrong_op_before fshl_bswap_wrong_op_combined
  simp_alive_peephole
  sorry
def fshr_bswap_wrong_amount_combined := [llvmfunc|
  llvm.func @fshr_bswap_wrong_amount(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i16, i16, i16) -> i16
    llvm.return %1 : i16
  }]

theorem inst_combine_fshr_bswap_wrong_amount   : fshr_bswap_wrong_amount_before  ⊑  fshr_bswap_wrong_amount_combined := by
  unfold fshr_bswap_wrong_amount_before fshr_bswap_wrong_amount_combined
  simp_alive_peephole
  sorry
def fshl_bswap_wrong_width_combined := [llvmfunc|
  llvm.func @fshl_bswap_wrong_width(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fshl_bswap_wrong_width   : fshl_bswap_wrong_width_before  ⊑  fshl_bswap_wrong_width_combined := by
  unfold fshl_bswap_wrong_width_before fshl_bswap_wrong_width_combined
  simp_alive_peephole
  sorry
def fshl_mask_args_same1_combined := [llvmfunc|
  llvm.func @fshl_mask_args_same1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fshl_mask_args_same1   : fshl_mask_args_same1_before  ⊑  fshl_mask_args_same1_combined := by
  unfold fshl_mask_args_same1_before fshl_mask_args_same1_combined
  simp_alive_peephole
  sorry
def fshl_mask_args_same2_combined := [llvmfunc|
  llvm.func @fshl_mask_args_same2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.shl %1, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_fshl_mask_args_same2   : fshl_mask_args_same2_before  ⊑  fshl_mask_args_same2_combined := by
  unfold fshl_mask_args_same2_before fshl_mask_args_same2_combined
  simp_alive_peephole
  sorry
def fshl_mask_args_same3_combined := [llvmfunc|
  llvm.func @fshl_mask_args_same3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fshl_mask_args_same3   : fshl_mask_args_same3_before  ⊑  fshl_mask_args_same3_combined := by
  unfold fshl_mask_args_same3_before fshl_mask_args_same3_combined
  simp_alive_peephole
  sorry
def fshl_mask_args_different_combined := [llvmfunc|
  llvm.func @fshl_mask_args_different(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(130560 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_fshl_mask_args_different   : fshl_mask_args_different_before  ⊑  fshl_mask_args_different_combined := by
  unfold fshl_mask_args_different_before fshl_mask_args_different_combined
  simp_alive_peephole
  sorry
def fsh_andconst_rotate_combined := [llvmfunc|
  llvm.func @fsh_andconst_rotate(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_fsh_andconst_rotate   : fsh_andconst_rotate_before  ⊑  fsh_andconst_rotate_combined := by
  unfold fsh_andconst_rotate_before fsh_andconst_rotate_combined
  simp_alive_peephole
  sorry
def fsh_orconst_rotate_combined := [llvmfunc|
  llvm.func @fsh_orconst_rotate(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-268435456 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.intr.fshl(%arg0, %0, %1)  : (i32, i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fsh_orconst_rotate   : fsh_orconst_rotate_before  ⊑  fsh_orconst_rotate_combined := by
  unfold fsh_orconst_rotate_before fsh_orconst_rotate_combined
  simp_alive_peephole
  sorry
def fsh_rotate_5_combined := [llvmfunc|
  llvm.func @fsh_rotate_5(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.or %1, %arg1  : i32
    %3 = llvm.intr.fshl(%2, %arg1, %0)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_fsh_rotate_5   : fsh_rotate_5_before  ⊑  fsh_rotate_5_combined := by
  unfold fsh_rotate_5_before fsh_rotate_5_combined
  simp_alive_peephole
  sorry
def fsh_rotate_18_combined := [llvmfunc|
  llvm.func @fsh_rotate_18(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(18 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.or %1, %arg1  : i32
    %3 = llvm.intr.fshl(%2, %arg1, %0)  : (i32, i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_fsh_rotate_18   : fsh_rotate_18_before  ⊑  fsh_rotate_18_combined := by
  unfold fsh_rotate_18_before fsh_rotate_18_combined
  simp_alive_peephole
  sorry
def fsh_load_rotate_12_combined := [llvmfunc|
  llvm.func @fsh_load_rotate_12(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(12 : i32) : i32
    %7 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fsh_load_rotate_12   : fsh_load_rotate_12_before  ⊑  fsh_load_rotate_12_combined := by
  unfold fsh_load_rotate_12_before fsh_load_rotate_12_combined
  simp_alive_peephole
  sorry
    %8 = llvm.zext %7 : i8 to i32
    %9 = llvm.shl %8, %0 overflow<nuw>  : i32
    %10 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %11 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fsh_load_rotate_12   : fsh_load_rotate_12_before  ⊑  fsh_load_rotate_12_combined := by
  unfold fsh_load_rotate_12_before fsh_load_rotate_12_combined
  simp_alive_peephole
  sorry
    %12 = llvm.zext %11 : i8 to i32
    %13 = llvm.shl %12, %2 overflow<nsw, nuw>  : i32
    %14 = llvm.or %13, %9  : i32
    %15 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %16 = llvm.load %15 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fsh_load_rotate_12   : fsh_load_rotate_12_before  ⊑  fsh_load_rotate_12_combined := by
  unfold fsh_load_rotate_12_before fsh_load_rotate_12_combined
  simp_alive_peephole
  sorry
    %17 = llvm.zext %16 : i8 to i32
    %18 = llvm.shl %17, %4 overflow<nsw, nuw>  : i32
    %19 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %20 = llvm.load %19 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fsh_load_rotate_12   : fsh_load_rotate_12_before  ⊑  fsh_load_rotate_12_combined := by
  unfold fsh_load_rotate_12_before fsh_load_rotate_12_combined
  simp_alive_peephole
  sorry
    %21 = llvm.zext %20 : i8 to i32
    %22 = llvm.or %18, %21  : i32
    %23 = llvm.or %22, %13  : i32
    %24 = llvm.intr.fshl(%23, %14, %6)  : (i32, i32, i32) -> i32
    llvm.return %24 : i32
  }]

theorem inst_combine_fsh_load_rotate_12   : fsh_load_rotate_12_before  ⊑  fsh_load_rotate_12_combined := by
  unfold fsh_load_rotate_12_before fsh_load_rotate_12_combined
  simp_alive_peephole
  sorry
def fsh_load_rotate_25_combined := [llvmfunc|
  llvm.func @fsh_load_rotate_25(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(16 : i32) : i32
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(8 : i32) : i32
    %5 = llvm.mlir.constant(3 : i64) : i64
    %6 = llvm.mlir.constant(25 : i32) : i32
    %7 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fsh_load_rotate_25   : fsh_load_rotate_25_before  ⊑  fsh_load_rotate_25_combined := by
  unfold fsh_load_rotate_25_before fsh_load_rotate_25_combined
  simp_alive_peephole
  sorry
    %8 = llvm.zext %7 : i8 to i32
    %9 = llvm.shl %8, %0 overflow<nuw>  : i32
    %10 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %11 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fsh_load_rotate_25   : fsh_load_rotate_25_before  ⊑  fsh_load_rotate_25_combined := by
  unfold fsh_load_rotate_25_before fsh_load_rotate_25_combined
  simp_alive_peephole
  sorry
    %12 = llvm.zext %11 : i8 to i32
    %13 = llvm.shl %12, %2 overflow<nsw, nuw>  : i32
    %14 = llvm.or %13, %9  : i32
    %15 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %16 = llvm.load %15 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fsh_load_rotate_25   : fsh_load_rotate_25_before  ⊑  fsh_load_rotate_25_combined := by
  unfold fsh_load_rotate_25_before fsh_load_rotate_25_combined
  simp_alive_peephole
  sorry
    %17 = llvm.zext %16 : i8 to i32
    %18 = llvm.shl %17, %4 overflow<nsw, nuw>  : i32
    %19 = llvm.or %14, %18  : i32
    %20 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %21 = llvm.load %20 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_fsh_load_rotate_25   : fsh_load_rotate_25_before  ⊑  fsh_load_rotate_25_combined := by
  unfold fsh_load_rotate_25_before fsh_load_rotate_25_combined
  simp_alive_peephole
  sorry
    %22 = llvm.zext %21 : i8 to i32
    %23 = llvm.or %19, %22  : i32
    %24 = llvm.intr.fshl(%22, %23, %6)  : (i32, i32, i32) -> i32
    llvm.return %24 : i32
  }]

theorem inst_combine_fsh_load_rotate_25   : fsh_load_rotate_25_before  ⊑  fsh_load_rotate_25_combined := by
  unfold fsh_load_rotate_25_before fsh_load_rotate_25_combined
  simp_alive_peephole
  sorry
def fshr_mask_args_same_vector_combined := [llvmfunc|
  llvm.func @fshr_mask_args_same_vector(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(10 : i31) : i31
    %1 = llvm.mlir.constant(dense<10> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.shl %arg0, %1  : vector<2xi31>
    llvm.return %2 : vector<2xi31>
  }]

theorem inst_combine_fshr_mask_args_same_vector   : fshr_mask_args_same_vector_before  ⊑  fshr_mask_args_same_vector_combined := by
  unfold fshr_mask_args_same_vector_before fshr_mask_args_same_vector_combined
  simp_alive_peephole
  sorry
def fshr_mask_args_same_vector2_combined := [llvmfunc|
  llvm.func @fshr_mask_args_same_vector2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1000000, 100000]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_fshr_mask_args_same_vector2   : fshr_mask_args_same_vector2_before  ⊑  fshr_mask_args_same_vector2_combined := by
  unfold fshr_mask_args_same_vector2_before fshr_mask_args_same_vector2_combined
  simp_alive_peephole
  sorry
def fshr_mask_args_same_vector3_different_but_still_prunable_combined := [llvmfunc|
  llvm.func @fshr_mask_args_same_vector3_different_but_still_prunable(%arg0: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.constant(1000 : i31) : i31
    %1 = llvm.mlir.constant(dense<1000> : vector<2xi31>) : vector<2xi31>
    %2 = llvm.mlir.constant(3 : i31) : i31
    %3 = llvm.mlir.constant(10 : i31) : i31
    %4 = llvm.mlir.constant(dense<[10, 3]> : vector<2xi31>) : vector<2xi31>
    %5 = llvm.and %arg0, %1  : vector<2xi31>
    %6 = llvm.intr.fshl(%arg0, %5, %4)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %6 : vector<2xi31>
  }]

theorem inst_combine_fshr_mask_args_same_vector3_different_but_still_prunable   : fshr_mask_args_same_vector3_different_but_still_prunable_before  ⊑  fshr_mask_args_same_vector3_different_but_still_prunable_combined := by
  unfold fshr_mask_args_same_vector3_different_but_still_prunable_before fshr_mask_args_same_vector3_different_but_still_prunable_combined
  simp_alive_peephole
  sorry
def fsh_unary_shuffle_ops_combined := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.intr.fshr(%arg0, %arg1, %arg2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.shufflevector %1, %0 [1, 0] : vector<2xi32> 
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_fsh_unary_shuffle_ops   : fsh_unary_shuffle_ops_before  ⊑  fsh_unary_shuffle_ops_combined := by
  unfold fsh_unary_shuffle_ops_before fsh_unary_shuffle_ops_combined
  simp_alive_peephole
  sorry
def fsh_unary_shuffle_ops_widening_combined := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_widening(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: vector<2xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.poison : vector<2xi16>
    %1 = llvm.shufflevector %arg0, %0 [1, 0, 1] : vector<2xi16> 
    llvm.call @use_v3(%1) : (vector<3xi16>) -> ()
    %2 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (vector<2xi16>, vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = llvm.shufflevector %2, %0 [1, 0, 1] : vector<2xi16> 
    llvm.return %3 : vector<3xi16>
  }]

theorem inst_combine_fsh_unary_shuffle_ops_widening   : fsh_unary_shuffle_ops_widening_before  ⊑  fsh_unary_shuffle_ops_widening_combined := by
  unfold fsh_unary_shuffle_ops_widening_before fsh_unary_shuffle_ops_widening_combined
  simp_alive_peephole
  sorry
def fsh_unary_shuffle_ops_narrowing_combined := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_narrowing(%arg0: vector<3xi31>, %arg1: vector<3xi31>, %arg2: vector<3xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.poison : vector<3xi31>
    %1 = llvm.shufflevector %arg1, %0 [1, 0] : vector<3xi31> 
    llvm.call @use_v2(%1) : (vector<2xi31>) -> ()
    %2 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (vector<3xi31>, vector<3xi31>, vector<3xi31>) -> vector<3xi31>
    %3 = llvm.shufflevector %2, %0 [1, 0] : vector<3xi31> 
    llvm.return %3 : vector<2xi31>
  }]

theorem inst_combine_fsh_unary_shuffle_ops_narrowing   : fsh_unary_shuffle_ops_narrowing_before  ⊑  fsh_unary_shuffle_ops_narrowing_combined := by
  unfold fsh_unary_shuffle_ops_narrowing_before fsh_unary_shuffle_ops_narrowing_combined
  simp_alive_peephole
  sorry
def fsh_unary_shuffle_ops_unshuffled_combined := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_unshuffled(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xi32> 
    %3 = llvm.intr.fshr(%1, %2, %arg2)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_fsh_unary_shuffle_ops_unshuffled   : fsh_unary_shuffle_ops_unshuffled_before  ⊑  fsh_unary_shuffle_ops_unshuffled_combined := by
  unfold fsh_unary_shuffle_ops_unshuffled_before fsh_unary_shuffle_ops_unshuffled_combined
  simp_alive_peephole
  sorry
def fsh_unary_shuffle_ops_wrong_mask_combined := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_wrong_mask(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<2xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi32> 
    %2 = llvm.shufflevector %arg1, %0 [0, 0] : vector<2xi32> 
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xi32> 
    %4 = llvm.intr.fshr(%1, %2, %3)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_fsh_unary_shuffle_ops_wrong_mask   : fsh_unary_shuffle_ops_wrong_mask_before  ⊑  fsh_unary_shuffle_ops_wrong_mask_combined := by
  unfold fsh_unary_shuffle_ops_wrong_mask_before fsh_unary_shuffle_ops_wrong_mask_combined
  simp_alive_peephole
  sorry
def fsh_unary_shuffle_ops_uses_combined := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_uses(%arg0: vector<2xi31>, %arg1: vector<2xi31>, %arg2: vector<2xi31>) -> vector<2xi31> {
    %0 = llvm.mlir.poison : vector<2xi31>
    %1 = llvm.shufflevector %arg0, %0 [1, 0] : vector<2xi31> 
    llvm.call @use_v2(%1) : (vector<2xi31>) -> ()
    %2 = llvm.shufflevector %arg1, %0 [1, 0] : vector<2xi31> 
    llvm.call @use_v2(%2) : (vector<2xi31>) -> ()
    %3 = llvm.shufflevector %arg2, %0 [1, 0] : vector<2xi31> 
    llvm.call @use_v2(%3) : (vector<2xi31>) -> ()
    %4 = llvm.intr.fshl(%1, %2, %3)  : (vector<2xi31>, vector<2xi31>, vector<2xi31>) -> vector<2xi31>
    llvm.return %4 : vector<2xi31>
  }]

theorem inst_combine_fsh_unary_shuffle_ops_uses   : fsh_unary_shuffle_ops_uses_before  ⊑  fsh_unary_shuffle_ops_uses_combined := by
  unfold fsh_unary_shuffle_ops_uses_before fsh_unary_shuffle_ops_uses_combined
  simp_alive_peephole
  sorry
def fsh_unary_shuffle_ops_partial_widening_combined := [llvmfunc|
  llvm.func @fsh_unary_shuffle_ops_partial_widening(%arg0: vector<3xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : vector<3xi32>
    %1 = llvm.mlir.poison : vector<2xi32>
    %2 = llvm.shufflevector %arg0, %0 [1, 0] : vector<3xi32> 
    %3 = llvm.shufflevector %arg1, %1 [1, 0] : vector<2xi32> 
    %4 = llvm.shufflevector %arg2, %1 [1, 0] : vector<2xi32> 
    %5 = llvm.intr.fshr(%2, %3, %4)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_fsh_unary_shuffle_ops_partial_widening   : fsh_unary_shuffle_ops_partial_widening_before  ⊑  fsh_unary_shuffle_ops_partial_widening_combined := by
  unfold fsh_unary_shuffle_ops_partial_widening_before fsh_unary_shuffle_ops_partial_widening_combined
  simp_alive_peephole
  sorry
def fshr_vec_zero_elem_combined := [llvmfunc|
  llvm.func @fshr_vec_zero_elem(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[30, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.fshl(%arg0, %arg1, %0)  : (vector<2xi32>, vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %1 : vector<2xi32>
  }]

theorem inst_combine_fshr_vec_zero_elem   : fshr_vec_zero_elem_before  ⊑  fshr_vec_zero_elem_combined := by
  unfold fshr_vec_zero_elem_before fshr_vec_zero_elem_combined
  simp_alive_peephole
  sorry
