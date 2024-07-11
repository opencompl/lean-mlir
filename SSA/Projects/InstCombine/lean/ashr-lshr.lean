import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ashr-lshr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ashr_lshr_exact_ashr_only_before := [llvmfunc|
  llvm.func @ashr_lshr_exact_ashr_only(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_no_exact_before := [llvmfunc|
  llvm.func @ashr_lshr_no_exact(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_exact_both_before := [llvmfunc|
  llvm.func @ashr_lshr_exact_both(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_exact_lshr_only_before := [llvmfunc|
  llvm.func @ashr_lshr_exact_lshr_only(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr2_before := [llvmfunc|
  llvm.func @ashr_lshr2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_splat_vec_before := [llvmfunc|
  llvm.func @ashr_lshr_splat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_splat_vec2_before := [llvmfunc|
  llvm.func @ashr_lshr_splat_vec2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_splat_vec3_before := [llvmfunc|
  llvm.func @ashr_lshr_splat_vec3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_splat_vec4_before := [llvmfunc|
  llvm.func @ashr_lshr_splat_vec4(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_nonsplat_vec_before := [llvmfunc|
  llvm.func @ashr_lshr_nonsplat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_nonsplat_vec2_before := [llvmfunc|
  llvm.func @ashr_lshr_nonsplat_vec2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 4]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_nonsplat_vec3_before := [llvmfunc|
  llvm.func @ashr_lshr_nonsplat_vec3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_nonsplat_vec4_before := [llvmfunc|
  llvm.func @ashr_lshr_nonsplat_vec4(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8, 7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_cst_before := [llvmfunc|
  llvm.func @ashr_lshr_cst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.select %2, %4, %3 : i1, i32
    llvm.return %5 : i32
  }]

def ashr_lshr_cst2_before := [llvmfunc|
  llvm.func @ashr_lshr_cst2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.select %2, %3, %4 : i1, i32
    llvm.return %5 : i32
  }]

def ashr_lshr_inv_before := [llvmfunc|
  llvm.func @ashr_lshr_inv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_inv2_before := [llvmfunc|
  llvm.func @ashr_lshr_inv2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_inv_splat_vec_before := [llvmfunc|
  llvm.func @ashr_lshr_inv_splat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %3, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_inv_nonsplat_vec_before := [llvmfunc|
  llvm.func @ashr_lshr_inv_nonsplat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %3, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ashr_lshr_vec_poison_before := [llvmfunc|
  llvm.func @ashr_lshr_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "sgt" %arg0, %6 : vector<2xi32>
    %8 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %9 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %10 = llvm.select %7, %8, %9 : vector<2xi1>, vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def ashr_lshr_vec_poison2_before := [llvmfunc|
  llvm.func @ashr_lshr_vec_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "slt" %arg0, %6 : vector<2xi32>
    %8 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %9 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %10 = llvm.select %7, %9, %8 : vector<2xi1>, vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }]

def ashr_lshr_wrong_cst_before := [llvmfunc|
  llvm.func @ashr_lshr_wrong_cst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_wrong_cst2_before := [llvmfunc|
  llvm.func @ashr_lshr_wrong_cst2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_wrong_cond_before := [llvmfunc|
  llvm.func @ashr_lshr_wrong_cond(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_shift_wrong_pred_before := [llvmfunc|
  llvm.func @ashr_lshr_shift_wrong_pred(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sle" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_shift_wrong_pred2_before := [llvmfunc|
  llvm.func @ashr_lshr_shift_wrong_pred2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg2, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_wrong_operands_before := [llvmfunc|
  llvm.func @ashr_lshr_wrong_operands(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_no_ashr_before := [llvmfunc|
  llvm.func @ashr_lshr_no_ashr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.xor %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_shift_amt_mismatch_before := [llvmfunc|
  llvm.func @ashr_lshr_shift_amt_mismatch(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg2  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_shift_base_mismatch_before := [llvmfunc|
  llvm.func @ashr_lshr_shift_base_mismatch(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg2, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_no_lshr_before := [llvmfunc|
  llvm.func @ashr_lshr_no_lshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

def ashr_lshr_vec_wrong_pred_before := [llvmfunc|
  llvm.func @ashr_lshr_vec_wrong_pred(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sle" %arg0, %1 : vector<2xi32>
    %3 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %5 = llvm.select %2, %3, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def ashr_lshr_inv_vec_wrong_pred_before := [llvmfunc|
  llvm.func @ashr_lshr_inv_vec_wrong_pred(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %1 : vector<2xi32>
    %3 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %5 = llvm.select %2, %4, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def lshr_sub_nsw_before := [llvmfunc|
  llvm.func @lshr_sub_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_sub_wrong_amount_before := [llvmfunc|
  llvm.func @lshr_sub_wrong_amount(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_sub_before := [llvmfunc|
  llvm.func @lshr_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_sub_nsw_extra_use_before := [llvmfunc|
  llvm.func @lshr_sub_nsw_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_sub_nsw_splat_before := [llvmfunc|
  llvm.func @lshr_sub_nsw_splat(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(41 : i42) : i42
    %1 = llvm.mlir.constant(dense<41> : vector<3xi42>) : vector<3xi42>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi42>
    %3 = llvm.lshr %2, %1  : vector<3xi42>
    llvm.return %3 : vector<3xi42>
  }]

def lshr_sub_nsw_splat_poison_before := [llvmfunc|
  llvm.func @lshr_sub_nsw_splat_poison(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(41 : i42) : i42
    %1 = llvm.mlir.poison : i42
    %2 = llvm.mlir.undef : vector<3xi42>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi42>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi42>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi42>
    %9 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi42>
    %10 = llvm.lshr %9, %8  : vector<3xi42>
    llvm.return %10 : vector<3xi42>
  }]

def ashr_sub_nsw_before := [llvmfunc|
  llvm.func @ashr_sub_nsw(%arg0: i17, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(16 : i17) : i17
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i17
    %2 = llvm.ashr %1, %0  : i17
    llvm.return %2 : i17
  }]

def ashr_sub_wrong_amount_before := [llvmfunc|
  llvm.func @ashr_sub_wrong_amount(%arg0: i17, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(15 : i17) : i17
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i17
    %2 = llvm.ashr %1, %0  : i17
    llvm.return %2 : i17
  }]

def ashr_sub_before := [llvmfunc|
  llvm.func @ashr_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

def ashr_sub_nsw_extra_use_before := [llvmfunc|
  llvm.func @ashr_sub_nsw_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

def ashr_sub_nsw_splat_before := [llvmfunc|
  llvm.func @ashr_sub_nsw_splat(%arg0: vector<3xi43>, %arg1: vector<3xi43>) -> vector<3xi43> {
    %0 = llvm.mlir.constant(42 : i43) : i43
    %1 = llvm.mlir.constant(dense<42> : vector<3xi43>) : vector<3xi43>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi43>
    %3 = llvm.ashr %2, %1  : vector<3xi43>
    llvm.return %3 : vector<3xi43>
  }]

def ashr_sub_nsw_splat_poison_before := [llvmfunc|
  llvm.func @ashr_sub_nsw_splat_poison(%arg0: vector<3xi43>, %arg1: vector<3xi43>) -> vector<3xi43> {
    %0 = llvm.mlir.constant(42 : i43) : i43
    %1 = llvm.mlir.poison : i43
    %2 = llvm.mlir.undef : vector<3xi43>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi43>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi43>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi43>
    %9 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi43>
    %10 = llvm.ashr %9, %8  : vector<3xi43>
    llvm.return %10 : vector<3xi43>
  }]

def ashr_known_pos_exact_before := [llvmfunc|
  llvm.func @ashr_known_pos_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.ashr %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def ashr_known_pos_exact_vec_before := [llvmfunc|
  llvm.func @ashr_known_pos_exact_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mul %arg0, %arg0 overflow<nsw>  : vector<2xi8>
    %1 = llvm.ashr %0, %arg1  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def lshr_mul_times_3_div_2_before := [llvmfunc|
  llvm.func @lshr_mul_times_3_div_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def lshr_mul_times_3_div_2_exact_before := [llvmfunc|
  llvm.func @lshr_mul_times_3_div_2_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def lshr_mul_times_3_div_2_no_flags_before := [llvmfunc|
  llvm.func @lshr_mul_times_3_div_2_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def mul_times_3_div_2_multiuse_lshr_before := [llvmfunc|
  llvm.func @mul_times_3_div_2_multiuse_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

def lshr_mul_times_3_div_2_exact_2_before := [llvmfunc|
  llvm.func @lshr_mul_times_3_div_2_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def lshr_mul_times_5_div_4_before := [llvmfunc|
  llvm.func @lshr_mul_times_5_div_4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def lshr_mul_times_5_div_4_exact_before := [llvmfunc|
  llvm.func @lshr_mul_times_5_div_4_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def lshr_mul_times_5_div_4_no_flags_before := [llvmfunc|
  llvm.func @lshr_mul_times_5_div_4_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def mul_times_5_div_4_multiuse_lshr_before := [llvmfunc|
  llvm.func @mul_times_5_div_4_multiuse_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

def lshr_mul_times_5_div_4_exact_2_before := [llvmfunc|
  llvm.func @lshr_mul_times_5_div_4_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_mul_times_3_div_2_before := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_mul_times_3_div_2_exact_before := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_mul_times_3_div_2_no_flags_before := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_mul_times_3_div_2_no_nsw_before := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2_no_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def mul_times_3_div_2_multiuse_ashr_before := [llvmfunc|
  llvm.func @mul_times_3_div_2_multiuse_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

def ashr_mul_times_3_div_2_exact_2_before := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_mul_times_5_div_4_before := [llvmfunc|
  llvm.func @ashr_mul_times_5_div_4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_mul_times_5_div_4_exact_before := [llvmfunc|
  llvm.func @ashr_mul_times_5_div_4_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_mul_times_5_div_4_no_flags_before := [llvmfunc|
  llvm.func @ashr_mul_times_5_div_4_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def mul_times_5_div_4_multiuse_ashr_before := [llvmfunc|
  llvm.func @mul_times_5_div_4_multiuse_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

def ashr_mul_times_5_div_4_exact_2_before := [llvmfunc|
  llvm.func @ashr_mul_times_5_div_4_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

def ashr_lshr_exact_ashr_only_combined := [llvmfunc|
  llvm.func @ashr_lshr_exact_ashr_only(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ashr_lshr_exact_ashr_only   : ashr_lshr_exact_ashr_only_before  ⊑  ashr_lshr_exact_ashr_only_combined := by
  unfold ashr_lshr_exact_ashr_only_before ashr_lshr_exact_ashr_only_combined
  simp_alive_peephole
  sorry
def ashr_lshr_no_exact_combined := [llvmfunc|
  llvm.func @ashr_lshr_no_exact(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ashr_lshr_no_exact   : ashr_lshr_no_exact_before  ⊑  ashr_lshr_no_exact_combined := by
  unfold ashr_lshr_no_exact_before ashr_lshr_no_exact_combined
  simp_alive_peephole
  sorry
def ashr_lshr_exact_both_combined := [llvmfunc|
  llvm.func @ashr_lshr_exact_both(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ashr_lshr_exact_both   : ashr_lshr_exact_both_before  ⊑  ashr_lshr_exact_both_combined := by
  unfold ashr_lshr_exact_both_before ashr_lshr_exact_both_combined
  simp_alive_peephole
  sorry
def ashr_lshr_exact_lshr_only_combined := [llvmfunc|
  llvm.func @ashr_lshr_exact_lshr_only(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ashr_lshr_exact_lshr_only   : ashr_lshr_exact_lshr_only_before  ⊑  ashr_lshr_exact_lshr_only_combined := by
  unfold ashr_lshr_exact_lshr_only_before ashr_lshr_exact_lshr_only_combined
  simp_alive_peephole
  sorry
def ashr_lshr2_combined := [llvmfunc|
  llvm.func @ashr_lshr2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ashr_lshr2   : ashr_lshr2_before  ⊑  ashr_lshr2_combined := by
  unfold ashr_lshr2_before ashr_lshr2_combined
  simp_alive_peephole
  sorry
def ashr_lshr_splat_vec_combined := [llvmfunc|
  llvm.func @ashr_lshr_splat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_splat_vec   : ashr_lshr_splat_vec_before  ⊑  ashr_lshr_splat_vec_combined := by
  unfold ashr_lshr_splat_vec_before ashr_lshr_splat_vec_combined
  simp_alive_peephole
  sorry
def ashr_lshr_splat_vec2_combined := [llvmfunc|
  llvm.func @ashr_lshr_splat_vec2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_splat_vec2   : ashr_lshr_splat_vec2_before  ⊑  ashr_lshr_splat_vec2_combined := by
  unfold ashr_lshr_splat_vec2_before ashr_lshr_splat_vec2_combined
  simp_alive_peephole
  sorry
def ashr_lshr_splat_vec3_combined := [llvmfunc|
  llvm.func @ashr_lshr_splat_vec3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_splat_vec3   : ashr_lshr_splat_vec3_before  ⊑  ashr_lshr_splat_vec3_combined := by
  unfold ashr_lshr_splat_vec3_before ashr_lshr_splat_vec3_combined
  simp_alive_peephole
  sorry
def ashr_lshr_splat_vec4_combined := [llvmfunc|
  llvm.func @ashr_lshr_splat_vec4(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_splat_vec4   : ashr_lshr_splat_vec4_before  ⊑  ashr_lshr_splat_vec4_combined := by
  unfold ashr_lshr_splat_vec4_before ashr_lshr_splat_vec4_combined
  simp_alive_peephole
  sorry
def ashr_lshr_nonsplat_vec_combined := [llvmfunc|
  llvm.func @ashr_lshr_nonsplat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_nonsplat_vec   : ashr_lshr_nonsplat_vec_before  ⊑  ashr_lshr_nonsplat_vec_combined := by
  unfold ashr_lshr_nonsplat_vec_before ashr_lshr_nonsplat_vec_combined
  simp_alive_peephole
  sorry
def ashr_lshr_nonsplat_vec2_combined := [llvmfunc|
  llvm.func @ashr_lshr_nonsplat_vec2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_nonsplat_vec2   : ashr_lshr_nonsplat_vec2_before  ⊑  ashr_lshr_nonsplat_vec2_combined := by
  unfold ashr_lshr_nonsplat_vec2_before ashr_lshr_nonsplat_vec2_combined
  simp_alive_peephole
  sorry
def ashr_lshr_nonsplat_vec3_combined := [llvmfunc|
  llvm.func @ashr_lshr_nonsplat_vec3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_nonsplat_vec3   : ashr_lshr_nonsplat_vec3_before  ⊑  ashr_lshr_nonsplat_vec3_combined := by
  unfold ashr_lshr_nonsplat_vec3_before ashr_lshr_nonsplat_vec3_combined
  simp_alive_peephole
  sorry
def ashr_lshr_nonsplat_vec4_combined := [llvmfunc|
  llvm.func @ashr_lshr_nonsplat_vec4(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_nonsplat_vec4   : ashr_lshr_nonsplat_vec4_before  ⊑  ashr_lshr_nonsplat_vec4_combined := by
  unfold ashr_lshr_nonsplat_vec4_before ashr_lshr_nonsplat_vec4_combined
  simp_alive_peephole
  sorry
def ashr_lshr_cst_combined := [llvmfunc|
  llvm.func @ashr_lshr_cst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr_lshr_cst   : ashr_lshr_cst_before  ⊑  ashr_lshr_cst_combined := by
  unfold ashr_lshr_cst_before ashr_lshr_cst_combined
  simp_alive_peephole
  sorry
def ashr_lshr_cst2_combined := [llvmfunc|
  llvm.func @ashr_lshr_cst2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr_lshr_cst2   : ashr_lshr_cst2_before  ⊑  ashr_lshr_cst2_combined := by
  unfold ashr_lshr_cst2_before ashr_lshr_cst2_combined
  simp_alive_peephole
  sorry
def ashr_lshr_inv_combined := [llvmfunc|
  llvm.func @ashr_lshr_inv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ashr_lshr_inv   : ashr_lshr_inv_before  ⊑  ashr_lshr_inv_combined := by
  unfold ashr_lshr_inv_before ashr_lshr_inv_combined
  simp_alive_peephole
  sorry
def ashr_lshr_inv2_combined := [llvmfunc|
  llvm.func @ashr_lshr_inv2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.ashr %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ashr_lshr_inv2   : ashr_lshr_inv2_before  ⊑  ashr_lshr_inv2_combined := by
  unfold ashr_lshr_inv2_before ashr_lshr_inv2_combined
  simp_alive_peephole
  sorry
def ashr_lshr_inv_splat_vec_combined := [llvmfunc|
  llvm.func @ashr_lshr_inv_splat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_inv_splat_vec   : ashr_lshr_inv_splat_vec_before  ⊑  ashr_lshr_inv_splat_vec_combined := by
  unfold ashr_lshr_inv_splat_vec_before ashr_lshr_inv_splat_vec_combined
  simp_alive_peephole
  sorry
def ashr_lshr_inv_nonsplat_vec_combined := [llvmfunc|
  llvm.func @ashr_lshr_inv_nonsplat_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_inv_nonsplat_vec   : ashr_lshr_inv_nonsplat_vec_before  ⊑  ashr_lshr_inv_nonsplat_vec_combined := by
  unfold ashr_lshr_inv_nonsplat_vec_before ashr_lshr_inv_nonsplat_vec_combined
  simp_alive_peephole
  sorry
def ashr_lshr_vec_poison_combined := [llvmfunc|
  llvm.func @ashr_lshr_vec_poison(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_vec_poison   : ashr_lshr_vec_poison_before  ⊑  ashr_lshr_vec_poison_combined := by
  unfold ashr_lshr_vec_poison_before ashr_lshr_vec_poison_combined
  simp_alive_peephole
  sorry
def ashr_lshr_vec_poison2_combined := [llvmfunc|
  llvm.func @ashr_lshr_vec_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_vec_poison2   : ashr_lshr_vec_poison2_before  ⊑  ashr_lshr_vec_poison2_combined := by
  unfold ashr_lshr_vec_poison2_before ashr_lshr_vec_poison2_combined
  simp_alive_peephole
  sorry
def ashr_lshr_wrong_cst_combined := [llvmfunc|
  llvm.func @ashr_lshr_wrong_cst(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_wrong_cst   : ashr_lshr_wrong_cst_before  ⊑  ashr_lshr_wrong_cst_combined := by
  unfold ashr_lshr_wrong_cst_before ashr_lshr_wrong_cst_combined
  simp_alive_peephole
  sorry
def ashr_lshr_wrong_cst2_combined := [llvmfunc|
  llvm.func @ashr_lshr_wrong_cst2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %3, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_wrong_cst2   : ashr_lshr_wrong_cst2_before  ⊑  ashr_lshr_wrong_cst2_combined := by
  unfold ashr_lshr_wrong_cst2_before ashr_lshr_wrong_cst2_combined
  simp_alive_peephole
  sorry
def ashr_lshr_wrong_cond_combined := [llvmfunc|
  llvm.func @ashr_lshr_wrong_cond(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_wrong_cond   : ashr_lshr_wrong_cond_before  ⊑  ashr_lshr_wrong_cond_combined := by
  unfold ashr_lshr_wrong_cond_before ashr_lshr_wrong_cond_combined
  simp_alive_peephole
  sorry
def ashr_lshr_shift_wrong_pred_combined := [llvmfunc|
  llvm.func @ashr_lshr_shift_wrong_pred(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.lshr %arg0, %arg1  : i32
    %3 = llvm.ashr %arg0, %arg1  : i32
    %4 = llvm.select %1, %2, %3 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_shift_wrong_pred   : ashr_lshr_shift_wrong_pred_before  ⊑  ashr_lshr_shift_wrong_pred_combined := by
  unfold ashr_lshr_shift_wrong_pred_before ashr_lshr_shift_wrong_pred_combined
  simp_alive_peephole
  sorry
def ashr_lshr_shift_wrong_pred2_combined := [llvmfunc|
  llvm.func @ashr_lshr_shift_wrong_pred2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.ashr %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %arg2, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_shift_wrong_pred2   : ashr_lshr_shift_wrong_pred2_before  ⊑  ashr_lshr_shift_wrong_pred2_combined := by
  unfold ashr_lshr_shift_wrong_pred2_before ashr_lshr_shift_wrong_pred2_combined
  simp_alive_peephole
  sorry
def ashr_lshr_wrong_operands_combined := [llvmfunc|
  llvm.func @ashr_lshr_wrong_operands(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.ashr %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_wrong_operands   : ashr_lshr_wrong_operands_before  ⊑  ashr_lshr_wrong_operands_combined := by
  unfold ashr_lshr_wrong_operands_before ashr_lshr_wrong_operands_combined
  simp_alive_peephole
  sorry
def ashr_lshr_no_ashr_combined := [llvmfunc|
  llvm.func @ashr_lshr_no_ashr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_no_ashr   : ashr_lshr_no_ashr_before  ⊑  ashr_lshr_no_ashr_combined := by
  unfold ashr_lshr_no_ashr_before ashr_lshr_no_ashr_combined
  simp_alive_peephole
  sorry
def ashr_lshr_shift_amt_mismatch_combined := [llvmfunc|
  llvm.func @ashr_lshr_shift_amt_mismatch(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.ashr %arg0, %arg2  : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_shift_amt_mismatch   : ashr_lshr_shift_amt_mismatch_before  ⊑  ashr_lshr_shift_amt_mismatch_combined := by
  unfold ashr_lshr_shift_amt_mismatch_before ashr_lshr_shift_amt_mismatch_combined
  simp_alive_peephole
  sorry
def ashr_lshr_shift_base_mismatch_combined := [llvmfunc|
  llvm.func @ashr_lshr_shift_base_mismatch(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.ashr %arg2, %arg1  : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_shift_base_mismatch   : ashr_lshr_shift_base_mismatch_before  ⊑  ashr_lshr_shift_base_mismatch_combined := by
  unfold ashr_lshr_shift_base_mismatch_before ashr_lshr_shift_base_mismatch_combined
  simp_alive_peephole
  sorry
def ashr_lshr_no_lshr_combined := [llvmfunc|
  llvm.func @ashr_lshr_no_lshr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.ashr %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_ashr_lshr_no_lshr   : ashr_lshr_no_lshr_before  ⊑  ashr_lshr_no_lshr_combined := by
  unfold ashr_lshr_no_lshr_before ashr_lshr_no_lshr_combined
  simp_alive_peephole
  sorry
def ashr_lshr_vec_wrong_pred_combined := [llvmfunc|
  llvm.func @ashr_lshr_vec_wrong_pred(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.select %1, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_vec_wrong_pred   : ashr_lshr_vec_wrong_pred_before  ⊑  ashr_lshr_vec_wrong_pred_combined := by
  unfold ashr_lshr_vec_wrong_pred_before ashr_lshr_vec_wrong_pred_combined
  simp_alive_peephole
  sorry
def ashr_lshr_inv_vec_wrong_pred_combined := [llvmfunc|
  llvm.func @ashr_lshr_inv_vec_wrong_pred(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %5 = llvm.select %4, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_ashr_lshr_inv_vec_wrong_pred   : ashr_lshr_inv_vec_wrong_pred_before  ⊑  ashr_lshr_inv_vec_wrong_pred_combined := by
  unfold ashr_lshr_inv_vec_wrong_pred_before ashr_lshr_inv_vec_wrong_pred_combined
  simp_alive_peephole
  sorry
def lshr_sub_nsw_combined := [llvmfunc|
  llvm.func @lshr_sub_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.zext %0 : i1 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_lshr_sub_nsw   : lshr_sub_nsw_before  ⊑  lshr_sub_nsw_combined := by
  unfold lshr_sub_nsw_before lshr_sub_nsw_combined
  simp_alive_peephole
  sorry
def lshr_sub_wrong_amount_combined := [llvmfunc|
  llvm.func @lshr_sub_wrong_amount(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr_sub_wrong_amount   : lshr_sub_wrong_amount_before  ⊑  lshr_sub_wrong_amount_combined := by
  unfold lshr_sub_wrong_amount_before lshr_sub_wrong_amount_combined
  simp_alive_peephole
  sorry
def lshr_sub_combined := [llvmfunc|
  llvm.func @lshr_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr_sub   : lshr_sub_before  ⊑  lshr_sub_combined := by
  unfold lshr_sub_before lshr_sub_combined
  simp_alive_peephole
  sorry
def lshr_sub_nsw_extra_use_combined := [llvmfunc|
  llvm.func @lshr_sub_nsw_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_lshr_sub_nsw_extra_use   : lshr_sub_nsw_extra_use_before  ⊑  lshr_sub_nsw_extra_use_combined := by
  unfold lshr_sub_nsw_extra_use_before lshr_sub_nsw_extra_use_combined
  simp_alive_peephole
  sorry
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr_sub_nsw_extra_use   : lshr_sub_nsw_extra_use_before  ⊑  lshr_sub_nsw_extra_use_combined := by
  unfold lshr_sub_nsw_extra_use_before lshr_sub_nsw_extra_use_combined
  simp_alive_peephole
  sorry
def lshr_sub_nsw_splat_combined := [llvmfunc|
  llvm.func @lshr_sub_nsw_splat(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.icmp "slt" %arg0, %arg1 : vector<3xi42>
    %1 = llvm.zext %0 : vector<3xi1> to vector<3xi42>
    llvm.return %1 : vector<3xi42>
  }]

theorem inst_combine_lshr_sub_nsw_splat   : lshr_sub_nsw_splat_before  ⊑  lshr_sub_nsw_splat_combined := by
  unfold lshr_sub_nsw_splat_before lshr_sub_nsw_splat_combined
  simp_alive_peephole
  sorry
def lshr_sub_nsw_splat_poison_combined := [llvmfunc|
  llvm.func @lshr_sub_nsw_splat_poison(%arg0: vector<3xi42>, %arg1: vector<3xi42>) -> vector<3xi42> {
    %0 = llvm.mlir.constant(41 : i42) : i42
    %1 = llvm.mlir.poison : i42
    %2 = llvm.mlir.undef : vector<3xi42>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi42>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi42>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi42>
    %9 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi42>
    %10 = llvm.lshr %9, %8  : vector<3xi42>
    llvm.return %10 : vector<3xi42>
  }]

theorem inst_combine_lshr_sub_nsw_splat_poison   : lshr_sub_nsw_splat_poison_before  ⊑  lshr_sub_nsw_splat_poison_combined := by
  unfold lshr_sub_nsw_splat_poison_before lshr_sub_nsw_splat_poison_combined
  simp_alive_peephole
  sorry
def ashr_sub_nsw_combined := [llvmfunc|
  llvm.func @ashr_sub_nsw(%arg0: i17, %arg1: i17) -> i17 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i17
    %1 = llvm.sext %0 : i1 to i17
    llvm.return %1 : i17
  }]

theorem inst_combine_ashr_sub_nsw   : ashr_sub_nsw_before  ⊑  ashr_sub_nsw_combined := by
  unfold ashr_sub_nsw_before ashr_sub_nsw_combined
  simp_alive_peephole
  sorry
def ashr_sub_wrong_amount_combined := [llvmfunc|
  llvm.func @ashr_sub_wrong_amount(%arg0: i17, %arg1: i17) -> i17 {
    %0 = llvm.mlir.constant(15 : i17) : i17
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i17
    %2 = llvm.ashr %1, %0  : i17
    llvm.return %2 : i17
  }]

theorem inst_combine_ashr_sub_wrong_amount   : ashr_sub_wrong_amount_before  ⊑  ashr_sub_wrong_amount_combined := by
  unfold ashr_sub_wrong_amount_before ashr_sub_wrong_amount_combined
  simp_alive_peephole
  sorry
def ashr_sub_combined := [llvmfunc|
  llvm.func @ashr_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ashr_sub   : ashr_sub_before  ⊑  ashr_sub_combined := by
  unfold ashr_sub_before ashr_sub_combined
  simp_alive_peephole
  sorry
def ashr_sub_nsw_extra_use_combined := [llvmfunc|
  llvm.func @ashr_sub_nsw_extra_use(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_ashr_sub_nsw_extra_use   : ashr_sub_nsw_extra_use_before  ⊑  ashr_sub_nsw_extra_use_combined := by
  unfold ashr_sub_nsw_extra_use_before ashr_sub_nsw_extra_use_combined
  simp_alive_peephole
  sorry
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_ashr_sub_nsw_extra_use   : ashr_sub_nsw_extra_use_before  ⊑  ashr_sub_nsw_extra_use_combined := by
  unfold ashr_sub_nsw_extra_use_before ashr_sub_nsw_extra_use_combined
  simp_alive_peephole
  sorry
def ashr_sub_nsw_splat_combined := [llvmfunc|
  llvm.func @ashr_sub_nsw_splat(%arg0: vector<3xi43>, %arg1: vector<3xi43>) -> vector<3xi43> {
    %0 = llvm.icmp "slt" %arg0, %arg1 : vector<3xi43>
    %1 = llvm.sext %0 : vector<3xi1> to vector<3xi43>
    llvm.return %1 : vector<3xi43>
  }]

theorem inst_combine_ashr_sub_nsw_splat   : ashr_sub_nsw_splat_before  ⊑  ashr_sub_nsw_splat_combined := by
  unfold ashr_sub_nsw_splat_before ashr_sub_nsw_splat_combined
  simp_alive_peephole
  sorry
def ashr_sub_nsw_splat_poison_combined := [llvmfunc|
  llvm.func @ashr_sub_nsw_splat_poison(%arg0: vector<3xi43>, %arg1: vector<3xi43>) -> vector<3xi43> {
    %0 = llvm.mlir.constant(42 : i43) : i43
    %1 = llvm.mlir.poison : i43
    %2 = llvm.mlir.undef : vector<3xi43>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi43>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi43>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi43>
    %9 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<3xi43>
    %10 = llvm.ashr %9, %8  : vector<3xi43>
    llvm.return %10 : vector<3xi43>
  }]

theorem inst_combine_ashr_sub_nsw_splat_poison   : ashr_sub_nsw_splat_poison_before  ⊑  ashr_sub_nsw_splat_poison_combined := by
  unfold ashr_sub_nsw_splat_poison_before ashr_sub_nsw_splat_poison_combined
  simp_alive_peephole
  sorry
def ashr_known_pos_exact_combined := [llvmfunc|
  llvm.func @ashr_known_pos_exact(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.lshr %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_ashr_known_pos_exact   : ashr_known_pos_exact_before  ⊑  ashr_known_pos_exact_combined := by
  unfold ashr_known_pos_exact_before ashr_known_pos_exact_combined
  simp_alive_peephole
  sorry
def ashr_known_pos_exact_vec_combined := [llvmfunc|
  llvm.func @ashr_known_pos_exact_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mul %arg0, %arg0 overflow<nsw>  : vector<2xi8>
    %1 = llvm.lshr %0, %arg1  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_ashr_known_pos_exact_vec   : ashr_known_pos_exact_vec_before  ⊑  ashr_known_pos_exact_vec_combined := by
  unfold ashr_known_pos_exact_vec_before ashr_known_pos_exact_vec_combined
  simp_alive_peephole
  sorry
def lshr_mul_times_3_div_2_combined := [llvmfunc|
  llvm.func @lshr_mul_times_3_div_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_mul_times_3_div_2   : lshr_mul_times_3_div_2_before  ⊑  lshr_mul_times_3_div_2_combined := by
  unfold lshr_mul_times_3_div_2_before lshr_mul_times_3_div_2_combined
  simp_alive_peephole
  sorry
def lshr_mul_times_3_div_2_exact_combined := [llvmfunc|
  llvm.func @lshr_mul_times_3_div_2_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_mul_times_3_div_2_exact   : lshr_mul_times_3_div_2_exact_before  ⊑  lshr_mul_times_3_div_2_exact_combined := by
  unfold lshr_mul_times_3_div_2_exact_before lshr_mul_times_3_div_2_exact_combined
  simp_alive_peephole
  sorry
def lshr_mul_times_3_div_2_no_flags_combined := [llvmfunc|
  llvm.func @lshr_mul_times_3_div_2_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_mul_times_3_div_2_no_flags   : lshr_mul_times_3_div_2_no_flags_before  ⊑  lshr_mul_times_3_div_2_no_flags_combined := by
  unfold lshr_mul_times_3_div_2_no_flags_before lshr_mul_times_3_div_2_no_flags_combined
  simp_alive_peephole
  sorry
def mul_times_3_div_2_multiuse_lshr_combined := [llvmfunc|
  llvm.func @mul_times_3_div_2_multiuse_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_times_3_div_2_multiuse_lshr   : mul_times_3_div_2_multiuse_lshr_before  ⊑  mul_times_3_div_2_multiuse_lshr_combined := by
  unfold mul_times_3_div_2_multiuse_lshr_before mul_times_3_div_2_multiuse_lshr_combined
  simp_alive_peephole
  sorry
def lshr_mul_times_3_div_2_exact_2_combined := [llvmfunc|
  llvm.func @lshr_mul_times_3_div_2_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_mul_times_3_div_2_exact_2   : lshr_mul_times_3_div_2_exact_2_before  ⊑  lshr_mul_times_3_div_2_exact_2_combined := by
  unfold lshr_mul_times_3_div_2_exact_2_before lshr_mul_times_3_div_2_exact_2_combined
  simp_alive_peephole
  sorry
def lshr_mul_times_5_div_4_combined := [llvmfunc|
  llvm.func @lshr_mul_times_5_div_4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_mul_times_5_div_4   : lshr_mul_times_5_div_4_before  ⊑  lshr_mul_times_5_div_4_combined := by
  unfold lshr_mul_times_5_div_4_before lshr_mul_times_5_div_4_combined
  simp_alive_peephole
  sorry
def lshr_mul_times_5_div_4_exact_combined := [llvmfunc|
  llvm.func @lshr_mul_times_5_div_4_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_mul_times_5_div_4_exact   : lshr_mul_times_5_div_4_exact_before  ⊑  lshr_mul_times_5_div_4_exact_combined := by
  unfold lshr_mul_times_5_div_4_exact_before lshr_mul_times_5_div_4_exact_combined
  simp_alive_peephole
  sorry
def lshr_mul_times_5_div_4_no_flags_combined := [llvmfunc|
  llvm.func @lshr_mul_times_5_div_4_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_mul_times_5_div_4_no_flags   : lshr_mul_times_5_div_4_no_flags_before  ⊑  lshr_mul_times_5_div_4_no_flags_combined := by
  unfold lshr_mul_times_5_div_4_no_flags_before lshr_mul_times_5_div_4_no_flags_combined
  simp_alive_peephole
  sorry
def mul_times_5_div_4_multiuse_lshr_combined := [llvmfunc|
  llvm.func @mul_times_5_div_4_multiuse_lshr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_times_5_div_4_multiuse_lshr   : mul_times_5_div_4_multiuse_lshr_before  ⊑  mul_times_5_div_4_multiuse_lshr_combined := by
  unfold mul_times_5_div_4_multiuse_lshr_before mul_times_5_div_4_multiuse_lshr_combined
  simp_alive_peephole
  sorry
def lshr_mul_times_5_div_4_exact_2_combined := [llvmfunc|
  llvm.func @lshr_mul_times_5_div_4_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_mul_times_5_div_4_exact_2   : lshr_mul_times_5_div_4_exact_2_before  ⊑  lshr_mul_times_5_div_4_exact_2_combined := by
  unfold lshr_mul_times_5_div_4_exact_2_before lshr_mul_times_5_div_4_exact_2_combined
  simp_alive_peephole
  sorry
def ashr_mul_times_3_div_2_combined := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_mul_times_3_div_2   : ashr_mul_times_3_div_2_before  ⊑  ashr_mul_times_3_div_2_combined := by
  unfold ashr_mul_times_3_div_2_before ashr_mul_times_3_div_2_combined
  simp_alive_peephole
  sorry
def ashr_mul_times_3_div_2_exact_combined := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_mul_times_3_div_2_exact   : ashr_mul_times_3_div_2_exact_before  ⊑  ashr_mul_times_3_div_2_exact_combined := by
  unfold ashr_mul_times_3_div_2_exact_before ashr_mul_times_3_div_2_exact_combined
  simp_alive_peephole
  sorry
def ashr_mul_times_3_div_2_no_flags_combined := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_mul_times_3_div_2_no_flags   : ashr_mul_times_3_div_2_no_flags_before  ⊑  ashr_mul_times_3_div_2_no_flags_combined := by
  unfold ashr_mul_times_3_div_2_no_flags_before ashr_mul_times_3_div_2_no_flags_combined
  simp_alive_peephole
  sorry
def ashr_mul_times_3_div_2_no_nsw_combined := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2_no_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_mul_times_3_div_2_no_nsw   : ashr_mul_times_3_div_2_no_nsw_before  ⊑  ashr_mul_times_3_div_2_no_nsw_combined := by
  unfold ashr_mul_times_3_div_2_no_nsw_before ashr_mul_times_3_div_2_no_nsw_combined
  simp_alive_peephole
  sorry
def mul_times_3_div_2_multiuse_ashr_combined := [llvmfunc|
  llvm.func @mul_times_3_div_2_multiuse_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_times_3_div_2_multiuse_ashr   : mul_times_3_div_2_multiuse_ashr_before  ⊑  mul_times_3_div_2_multiuse_ashr_combined := by
  unfold mul_times_3_div_2_multiuse_ashr_before mul_times_3_div_2_multiuse_ashr_combined
  simp_alive_peephole
  sorry
def ashr_mul_times_3_div_2_exact_2_combined := [llvmfunc|
  llvm.func @ashr_mul_times_3_div_2_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_mul_times_3_div_2_exact_2   : ashr_mul_times_3_div_2_exact_2_before  ⊑  ashr_mul_times_3_div_2_exact_2_combined := by
  unfold ashr_mul_times_3_div_2_exact_2_before ashr_mul_times_3_div_2_exact_2_combined
  simp_alive_peephole
  sorry
def ashr_mul_times_5_div_4_combined := [llvmfunc|
  llvm.func @ashr_mul_times_5_div_4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_mul_times_5_div_4   : ashr_mul_times_5_div_4_before  ⊑  ashr_mul_times_5_div_4_combined := by
  unfold ashr_mul_times_5_div_4_before ashr_mul_times_5_div_4_combined
  simp_alive_peephole
  sorry
def ashr_mul_times_5_div_4_exact_combined := [llvmfunc|
  llvm.func @ashr_mul_times_5_div_4_exact(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_mul_times_5_div_4_exact   : ashr_mul_times_5_div_4_exact_before  ⊑  ashr_mul_times_5_div_4_exact_combined := by
  unfold ashr_mul_times_5_div_4_exact_before ashr_mul_times_5_div_4_exact_combined
  simp_alive_peephole
  sorry
def ashr_mul_times_5_div_4_no_flags_combined := [llvmfunc|
  llvm.func @ashr_mul_times_5_div_4_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_mul_times_5_div_4_no_flags   : ashr_mul_times_5_div_4_no_flags_before  ⊑  ashr_mul_times_5_div_4_no_flags_combined := by
  unfold ashr_mul_times_5_div_4_no_flags_before ashr_mul_times_5_div_4_no_flags_combined
  simp_alive_peephole
  sorry
def mul_times_5_div_4_multiuse_ashr_combined := [llvmfunc|
  llvm.func @mul_times_5_div_4_multiuse_ashr(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_times_5_div_4_multiuse_ashr   : mul_times_5_div_4_multiuse_ashr_before  ⊑  mul_times_5_div_4_multiuse_ashr_combined := by
  unfold mul_times_5_div_4_multiuse_ashr_before mul_times_5_div_4_multiuse_ashr_combined
  simp_alive_peephole
  sorry
def ashr_mul_times_5_div_4_exact_2_combined := [llvmfunc|
  llvm.func @ashr_mul_times_5_div_4_exact_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.ashr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_ashr_mul_times_5_div_4_exact_2   : ashr_mul_times_5_div_4_exact_2_before  ⊑  ashr_mul_times_5_div_4_exact_2_combined := by
  unfold ashr_mul_times_5_div_4_exact_2_before ashr_mul_times_5_div_4_exact_2_combined
  simp_alive_peephole
  sorry
