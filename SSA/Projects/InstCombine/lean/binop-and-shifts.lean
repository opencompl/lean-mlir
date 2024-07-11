import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  binop-and-shifts
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shl_and_and_before := [llvmfunc|
  llvm.func @shl_and_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(88 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }]

def shl_and_and_fail_before := [llvmfunc|
  llvm.func @shl_and_and_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(88 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.shl %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.and %3, %5  : i8
    llvm.return %6 : i8
  }]

def shl_add_add_before := [llvmfunc|
  llvm.func @shl_add_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }]

def shl_add_add_fail_before := [llvmfunc|
  llvm.func @shl_add_add_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }]

def shl_and_and_fail2_before := [llvmfunc|
  llvm.func @shl_and_and_fail2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(88 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg1  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }]

def lshr_and_or_before := [llvmfunc|
  llvm.func @lshr_and_or(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[44, 99]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.and %2, %1  : vector<2xi8>
    %5 = llvm.or %3, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_and_or_fail_before := [llvmfunc|
  llvm.func @lshr_and_or_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[44, 99]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

def shl_and_xor_before := [llvmfunc|
  llvm.func @shl_and_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.and %2, %1  : i8
    %5 = llvm.xor %3, %4  : i8
    llvm.return %5 : i8
  }]

def shl_and_add_before := [llvmfunc|
  llvm.func @shl_and_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(119 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }]

def shl_xor_add_fail_before := [llvmfunc|
  llvm.func @shl_xor_add_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(119 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }]

def lshr_or_and_before := [llvmfunc|
  llvm.func @lshr_or_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-58 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.or %2, %1  : i8
    %5 = llvm.and %4, %3  : i8
    llvm.return %5 : i8
  }]

def lshr_or_or_fail_before := [llvmfunc|
  llvm.func @lshr_or_or_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-58 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

def shl_xor_and_before := [llvmfunc|
  llvm.func @shl_xor_and(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(44 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.shl %arg0, %6  : vector<2xi8>
    %14 = llvm.shl %arg1, %6  : vector<2xi8>
    %15 = llvm.xor %14, %12  : vector<2xi8>
    %16 = llvm.and %15, %13  : vector<2xi8>
    llvm.return %16 : vector<2xi8>
  }]

def shl_xor_and_fail_before := [llvmfunc|
  llvm.func @shl_xor_and_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.undef : vector<2xi8>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi8>
    %12 = llvm.mlir.constant(44 : i8) : i8
    %13 = llvm.mlir.undef : vector<2xi8>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<2xi8>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : vector<2xi8>
    %18 = llvm.shl %arg0, %6  : vector<2xi8>
    %19 = llvm.shl %arg1, %11  : vector<2xi8>
    %20 = llvm.xor %19, %17  : vector<2xi8>
    %21 = llvm.and %18, %20  : vector<2xi8>
    llvm.return %21 : vector<2xi8>
  }]

def lshr_or_or_no_const_before := [llvmfunc|
  llvm.func @lshr_or_or_no_const(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg2  : i8
    %1 = llvm.lshr %arg1, %arg2  : i8
    %2 = llvm.or %1, %arg3  : i8
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }]

def lshr_or_or_no_const_fail_before := [llvmfunc|
  llvm.func @lshr_or_or_no_const_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.lshr %arg1, %arg2  : i8
    %2 = llvm.or %1, %arg3  : i8
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }]

def shl_xor_xor_no_const_before := [llvmfunc|
  llvm.func @shl_xor_xor_no_const(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.shl %arg1, %arg2  : i8
    %2 = llvm.xor %1, %arg3  : i8
    %3 = llvm.xor %0, %2  : i8
    llvm.return %3 : i8
  }]

def shl_xor_and_no_const_fail_before := [llvmfunc|
  llvm.func @shl_xor_and_no_const_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.shl %arg1, %arg2  : i8
    %2 = llvm.xor %1, %arg3  : i8
    %3 = llvm.and %0, %2  : i8
    llvm.return %3 : i8
  }]

def shl_and_and_no_const_before := [llvmfunc|
  llvm.func @shl_and_and_no_const(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.shl %arg0, %arg2  : vector<2xi8>
    %1 = llvm.shl %arg1, %arg2  : vector<2xi8>
    %2 = llvm.and %1, %arg3  : vector<2xi8>
    %3 = llvm.and %0, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def shl_add_add_no_const_before := [llvmfunc|
  llvm.func @shl_add_add_no_const(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.shl %arg1, %arg2  : i8
    %2 = llvm.add %1, %arg3  : i8
    %3 = llvm.add %0, %2  : i8
    llvm.return %3 : i8
  }]

def lshr_add_add_no_const_fail_before := [llvmfunc|
  llvm.func @lshr_add_add_no_const_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg2  : i8
    %1 = llvm.lshr %arg1, %arg2  : i8
    %2 = llvm.add %1, %arg3  : i8
    %3 = llvm.add %0, %2  : i8
    llvm.return %3 : i8
  }]

def lshr_add_and_before := [llvmfunc|
  llvm.func @lshr_add_and(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.add %3, %1  : vector<2xi8>
    %5 = llvm.and %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_add_or_fail_dif_masks_before := [llvmfunc|
  llvm.func @lshr_add_or_fail_dif_masks(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.lshr %arg0, %0  : vector<2xi8>
    %10 = llvm.lshr %arg1, %7  : vector<2xi8>
    %11 = llvm.add %10, %8  : vector<2xi8>
    %12 = llvm.and %9, %11  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }]

def shl_or_or_good_mask_before := [llvmfunc|
  llvm.func @shl_or_or_good_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[18, 24]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    %5 = llvm.or %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def shl_or_or_fail_bad_mask_before := [llvmfunc|
  llvm.func @shl_or_or_fail_bad_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[19, 24]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    %5 = llvm.or %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_xor_or_good_mask_before := [llvmfunc|
  llvm.func @lshr_xor_or_good_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

def lshr_xor_or_fail_bad_mask_before := [llvmfunc|
  llvm.func @lshr_xor_or_fail_bad_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

def lshr_or_xor_good_mask_before := [llvmfunc|
  llvm.func @lshr_or_xor_good_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    %5 = llvm.xor %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_or_xor_fail_bad_mask_before := [llvmfunc|
  llvm.func @lshr_or_xor_fail_bad_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[7, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    %5 = llvm.xor %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def shl_xor_xor_good_mask_before := [llvmfunc|
  llvm.func @shl_xor_xor_good_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(88 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.xor %2, %4  : i8
    llvm.return %5 : i8
  }]

def shl_xor_xor_bad_mask_distribute_before := [llvmfunc|
  llvm.func @shl_xor_xor_bad_mask_distribute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-68 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.xor %2, %4  : i8
    llvm.return %5 : i8
  }]

def shl_add_and_before := [llvmfunc|
  llvm.func @shl_add_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }]

def lshr_and_add_fail_before := [llvmfunc|
  llvm.func @lshr_and_add_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }]

def lshr_add_or_fail_before := [llvmfunc|
  llvm.func @lshr_add_or_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

def lshr_add_xor_fail_before := [llvmfunc|
  llvm.func @lshr_add_xor_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.xor %2, %4  : i8
    llvm.return %5 : i8
  }]

def lshr_and_add_before := [llvmfunc|
  llvm.func @lshr_and_add(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-67, 123]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %0  : vector<2xi8>
    %4 = llvm.and %2, %1  : vector<2xi8>
    %5 = llvm.add %3, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def lshr_or_add_fail_before := [llvmfunc|
  llvm.func @lshr_or_add_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-67, 123]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %0  : vector<2xi8>
    %4 = llvm.or %2, %1  : vector<2xi8>
    %5 = llvm.add %3, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def shl_add_and_fail_mismatch_shift_before := [llvmfunc|
  llvm.func @shl_add_and_fail_mismatch_shift(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }]

def and_ashr_not_before := [llvmfunc|
  llvm.func @and_ashr_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }]

def and_ashr_not_commuted_before := [llvmfunc|
  llvm.func @and_ashr_not_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

def and_ashr_not_fail_lshr_ashr_before := [llvmfunc|
  llvm.func @and_ashr_not_fail_lshr_ashr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }]

def and_ashr_not_fail_ashr_lshr_before := [llvmfunc|
  llvm.func @and_ashr_not_fail_ashr_lshr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.lshr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }]

def and_ashr_not_fail_invalid_xor_constant_before := [llvmfunc|
  llvm.func @and_ashr_not_fail_invalid_xor_constant(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }]

def and_ashr_not_vec_before := [llvmfunc|
  llvm.func @and_ashr_not_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.and %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def and_ashr_not_vec_commuted_before := [llvmfunc|
  llvm.func @and_ashr_not_vec_commuted(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.and %3, %1  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def and_ashr_not_vec_poison_1_before := [llvmfunc|
  llvm.func @and_ashr_not_vec_poison_1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %12 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %13 = llvm.xor %12, %10  : vector<4xi8>
    %14 = llvm.and %11, %13  : vector<4xi8>
    llvm.return %14 : vector<4xi8>
  }]

def and_ashr_not_vec_poison_2_before := [llvmfunc|
  llvm.func @and_ashr_not_vec_poison_2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.and %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def or_ashr_not_before := [llvmfunc|
  llvm.func @or_ashr_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }]

def or_ashr_not_commuted_before := [llvmfunc|
  llvm.func @or_ashr_not_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }]

def or_ashr_not_fail_lshr_ashr_before := [llvmfunc|
  llvm.func @or_ashr_not_fail_lshr_ashr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }]

def or_ashr_not_fail_ashr_lshr_before := [llvmfunc|
  llvm.func @or_ashr_not_fail_ashr_lshr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.lshr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }]

def or_ashr_not_fail_invalid_xor_constant_before := [llvmfunc|
  llvm.func @or_ashr_not_fail_invalid_xor_constant(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }]

def or_ashr_not_vec_before := [llvmfunc|
  llvm.func @or_ashr_not_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.or %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def or_ashr_not_vec_commuted_before := [llvmfunc|
  llvm.func @or_ashr_not_vec_commuted(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.or %3, %1  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def or_ashr_not_vec_poison_1_before := [llvmfunc|
  llvm.func @or_ashr_not_vec_poison_1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %12 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %13 = llvm.xor %12, %10  : vector<4xi8>
    %14 = llvm.or %11, %13  : vector<4xi8>
    llvm.return %14 : vector<4xi8>
  }]

def or_ashr_not_vec_poison_2_before := [llvmfunc|
  llvm.func @or_ashr_not_vec_poison_2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.or %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def xor_ashr_not_before := [llvmfunc|
  llvm.func @xor_ashr_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %1, %3  : i8
    llvm.return %4 : i8
  }]

def xor_ashr_not_commuted_before := [llvmfunc|
  llvm.func @xor_ashr_not_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

def xor_ashr_not_fail_lshr_ashr_before := [llvmfunc|
  llvm.func @xor_ashr_not_fail_lshr_ashr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %1, %3  : i8
    llvm.return %4 : i8
  }]

def xor_ashr_not_fail_ashr_lshr_before := [llvmfunc|
  llvm.func @xor_ashr_not_fail_ashr_lshr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.lshr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %1, %3  : i8
    llvm.return %4 : i8
  }]

def xor_ashr_not_fail_invalid_xor_constant_before := [llvmfunc|
  llvm.func @xor_ashr_not_fail_invalid_xor_constant(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.xor %1, %3  : i8
    llvm.return %4 : i8
  }]

def xor_ashr_not_vec_before := [llvmfunc|
  llvm.func @xor_ashr_not_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.xor %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def xor_ashr_not_vec_commuted_before := [llvmfunc|
  llvm.func @xor_ashr_not_vec_commuted(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.xor %3, %1  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def xor_ashr_not_vec_poison_1_before := [llvmfunc|
  llvm.func @xor_ashr_not_vec_poison_1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %12 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %13 = llvm.xor %12, %10  : vector<4xi8>
    %14 = llvm.xor %11, %13  : vector<4xi8>
    llvm.return %14 : vector<4xi8>
  }]

def xor_ashr_not_vec_poison_2_before := [llvmfunc|
  llvm.func @xor_ashr_not_vec_poison_2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.ashr %arg0, %arg2  : vector<4xi8>
    %2 = llvm.ashr %arg1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    %4 = llvm.xor %1, %3  : vector<4xi8>
    llvm.return %4 : vector<4xi8>
  }]

def binop_ashr_not_fail_invalid_binop_before := [llvmfunc|
  llvm.func @binop_ashr_not_fail_invalid_binop(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.add %1, %3  : i8
    llvm.return %4 : i8
  }]

def shl_and_and_combined := [llvmfunc|
  llvm.func @shl_and_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(80 : i8) : i8
    %2 = llvm.and %arg1, %arg0  : i8
    %3 = llvm.shl %2, %0  : i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_and_and   : shl_and_and_before  ⊑  shl_and_and_combined := by
  unfold shl_and_and_before shl_and_and_combined
  simp_alive_peephole
  sorry
def shl_and_and_fail_combined := [llvmfunc|
  llvm.func @shl_and_and_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(64 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.shl %arg1, %1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.and %3, %5  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_shl_and_and_fail   : shl_and_and_fail_before  ⊑  shl_and_and_fail_combined := by
  unfold shl_and_and_fail_before shl_and_and_fail_combined
  simp_alive_peephole
  sorry
def shl_add_add_combined := [llvmfunc|
  llvm.func @shl_add_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.add %arg1, %arg0  : i8
    %3 = llvm.shl %2, %0  : i8
    %4 = llvm.add %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_add_add   : shl_add_add_before  ⊑  shl_add_add_combined := by
  unfold shl_add_add_before shl_add_add_combined
  simp_alive_peephole
  sorry
def shl_add_add_fail_combined := [llvmfunc|
  llvm.func @shl_add_add_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i8
    %5 = llvm.add %2, %4 overflow<nuw>  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_shl_add_add_fail   : shl_add_add_fail_before  ⊑  shl_add_add_fail_combined := by
  unfold shl_add_add_fail_before shl_add_add_fail_combined
  simp_alive_peephole
  sorry
def shl_and_and_fail2_combined := [llvmfunc|
  llvm.func @shl_and_and_fail2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(88 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.shl %0, %arg1  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_shl_and_and_fail2   : shl_and_and_fail2_before  ⊑  shl_and_and_fail2_combined := by
  unfold shl_and_and_fail2_before shl_and_and_fail2_combined
  simp_alive_peephole
  sorry
def lshr_and_or_combined := [llvmfunc|
  llvm.func @lshr_and_or(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-64, 96]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.or %2, %arg1  : vector<2xi8>
    %4 = llvm.lshr %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_lshr_and_or   : lshr_and_or_before  ⊑  lshr_and_or_combined := by
  unfold lshr_and_or_before lshr_and_or_combined
  simp_alive_peephole
  sorry
def lshr_and_or_fail_combined := [llvmfunc|
  llvm.func @lshr_and_or_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[44, 99]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %arg0, %0  : vector<2xi8>
    %4 = llvm.lshr %arg1, %1  : vector<2xi8>
    %5 = llvm.and %4, %2  : vector<2xi8>
    %6 = llvm.or %3, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_lshr_and_or_fail   : lshr_and_or_fail_before  ⊑  lshr_and_or_fail_combined := by
  unfold lshr_and_or_fail_before lshr_and_or_fail_combined
  simp_alive_peephole
  sorry
def shl_and_xor_combined := [llvmfunc|
  llvm.func @shl_and_xor(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.xor %2, %arg1  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_and_xor   : shl_and_xor_before  ⊑  shl_and_xor_combined := by
  unfold shl_and_xor_before shl_and_xor_combined
  simp_alive_peephole
  sorry
def shl_and_add_combined := [llvmfunc|
  llvm.func @shl_and_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(59 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.add %2, %arg0  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_and_add   : shl_and_add_before  ⊑  shl_and_add_combined := by
  unfold shl_and_add_before shl_and_add_combined
  simp_alive_peephole
  sorry
def shl_xor_add_fail_combined := [llvmfunc|
  llvm.func @shl_xor_add_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(119 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.shl %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.add %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_shl_xor_add_fail   : shl_xor_add_fail_before  ⊑  shl_xor_add_fail_combined := by
  unfold shl_xor_add_fail_before shl_xor_add_fail_combined
  simp_alive_peephole
  sorry
def lshr_or_and_combined := [llvmfunc|
  llvm.func @lshr_or_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.lshr %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_lshr_or_and   : lshr_or_and_before  ⊑  lshr_or_and_combined := by
  unfold lshr_or_and_before lshr_or_and_combined
  simp_alive_peephole
  sorry
def lshr_or_or_fail_combined := [llvmfunc|
  llvm.func @lshr_or_or_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-58 : i8) : i8
    %2 = llvm.or %arg1, %arg0  : i8
    %3 = llvm.lshr %2, %0  : i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_lshr_or_or_fail   : lshr_or_or_fail_before  ⊑  lshr_or_or_fail_combined := by
  unfold lshr_or_or_fail_before lshr_or_or_fail_combined
  simp_alive_peephole
  sorry
def shl_xor_and_combined := [llvmfunc|
  llvm.func @shl_xor_and(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(2 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.xor %arg1, %6  : vector<2xi8>
    %14 = llvm.and %13, %arg0  : vector<2xi8>
    %15 = llvm.shl %14, %12  : vector<2xi8>
    llvm.return %15 : vector<2xi8>
  }]

theorem inst_combine_shl_xor_and   : shl_xor_and_before  ⊑  shl_xor_and_combined := by
  unfold shl_xor_and_before shl_xor_and_combined
  simp_alive_peephole
  sorry
def shl_xor_and_fail_combined := [llvmfunc|
  llvm.func @shl_xor_and_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.undef : vector<2xi8>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xi8>
    %12 = llvm.mlir.constant(44 : i8) : i8
    %13 = llvm.mlir.undef : vector<2xi8>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<2xi8>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %0, %15[%16 : i32] : vector<2xi8>
    %18 = llvm.shl %arg0, %6  : vector<2xi8>
    %19 = llvm.shl %arg1, %11  : vector<2xi8>
    %20 = llvm.xor %19, %17  : vector<2xi8>
    %21 = llvm.and %18, %20  : vector<2xi8>
    llvm.return %21 : vector<2xi8>
  }]

theorem inst_combine_shl_xor_and_fail   : shl_xor_and_fail_before  ⊑  shl_xor_and_fail_combined := by
  unfold shl_xor_and_fail_before shl_xor_and_fail_combined
  simp_alive_peephole
  sorry
def lshr_or_or_no_const_combined := [llvmfunc|
  llvm.func @lshr_or_or_no_const(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.lshr %0, %arg2  : i8
    %2 = llvm.or %1, %arg3  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_lshr_or_or_no_const   : lshr_or_or_no_const_before  ⊑  lshr_or_or_no_const_combined := by
  unfold lshr_or_or_no_const_before lshr_or_or_no_const_combined
  simp_alive_peephole
  sorry
def lshr_or_or_no_const_fail_combined := [llvmfunc|
  llvm.func @lshr_or_or_no_const_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.lshr %arg1, %arg2  : i8
    %2 = llvm.or %1, %arg3  : i8
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lshr_or_or_no_const_fail   : lshr_or_or_no_const_fail_before  ⊑  lshr_or_or_no_const_fail_combined := by
  unfold lshr_or_or_no_const_fail_before lshr_or_or_no_const_fail_combined
  simp_alive_peephole
  sorry
def shl_xor_xor_no_const_combined := [llvmfunc|
  llvm.func @shl_xor_xor_no_const(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.xor %arg1, %arg0  : i8
    %1 = llvm.shl %0, %arg2  : i8
    %2 = llvm.xor %1, %arg3  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_shl_xor_xor_no_const   : shl_xor_xor_no_const_before  ⊑  shl_xor_xor_no_const_combined := by
  unfold shl_xor_xor_no_const_before shl_xor_xor_no_const_combined
  simp_alive_peephole
  sorry
def shl_xor_and_no_const_fail_combined := [llvmfunc|
  llvm.func @shl_xor_and_no_const_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.shl %arg0, %arg2  : i8
    %1 = llvm.shl %arg1, %arg2  : i8
    %2 = llvm.xor %1, %arg3  : i8
    %3 = llvm.and %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_shl_xor_and_no_const_fail   : shl_xor_and_no_const_fail_before  ⊑  shl_xor_and_no_const_fail_combined := by
  unfold shl_xor_and_no_const_fail_before shl_xor_and_no_const_fail_combined
  simp_alive_peephole
  sorry
def shl_and_and_no_const_combined := [llvmfunc|
  llvm.func @shl_and_and_no_const(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.and %arg1, %arg0  : vector<2xi8>
    %1 = llvm.shl %0, %arg2  : vector<2xi8>
    %2 = llvm.and %1, %arg3  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_shl_and_and_no_const   : shl_and_and_no_const_before  ⊑  shl_and_and_no_const_combined := by
  unfold shl_and_and_no_const_before shl_and_and_no_const_combined
  simp_alive_peephole
  sorry
def shl_add_add_no_const_combined := [llvmfunc|
  llvm.func @shl_add_add_no_const(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.add %arg1, %arg0  : i8
    %1 = llvm.shl %0, %arg2  : i8
    %2 = llvm.add %1, %arg3  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_shl_add_add_no_const   : shl_add_add_no_const_before  ⊑  shl_add_add_no_const_combined := by
  unfold shl_add_add_no_const_before shl_add_add_no_const_combined
  simp_alive_peephole
  sorry
def lshr_add_add_no_const_fail_combined := [llvmfunc|
  llvm.func @lshr_add_add_no_const_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.lshr %arg0, %arg2  : i8
    %1 = llvm.lshr %arg1, %arg2  : i8
    %2 = llvm.add %1, %arg3  : i8
    %3 = llvm.add %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lshr_add_add_no_const_fail   : lshr_add_add_no_const_fail_before  ⊑  lshr_add_add_no_const_fail_combined := by
  unfold lshr_add_add_no_const_fail_before lshr_add_add_no_const_fail_combined
  simp_alive_peephole
  sorry
def lshr_add_and_combined := [llvmfunc|
  llvm.func @lshr_add_and(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-8, 16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg1, %0  : vector<2xi8>
    %3 = llvm.and %2, %arg0  : vector<2xi8>
    %4 = llvm.lshr %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_lshr_add_and   : lshr_add_and_before  ⊑  lshr_add_and_combined := by
  unfold lshr_add_and_before lshr_add_and_combined
  simp_alive_peephole
  sorry
def lshr_add_or_fail_dif_masks_combined := [llvmfunc|
  llvm.func @lshr_add_or_fail_dif_masks(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.lshr %arg0, %0  : vector<2xi8>
    %10 = llvm.lshr %arg1, %7  : vector<2xi8>
    %11 = llvm.add %10, %8 overflow<nsw>  : vector<2xi8>
    %12 = llvm.and %9, %11  : vector<2xi8>
    llvm.return %12 : vector<2xi8>
  }]

theorem inst_combine_lshr_add_or_fail_dif_masks   : lshr_add_or_fail_dif_masks_before  ⊑  lshr_add_or_fail_dif_masks_combined := by
  unfold lshr_add_or_fail_dif_masks_before lshr_add_or_fail_dif_masks_combined
  simp_alive_peephole
  sorry
def shl_or_or_good_mask_combined := [llvmfunc|
  llvm.func @shl_or_or_good_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[18, 24]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg1, %arg0  : vector<2xi8>
    %3 = llvm.shl %2, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_shl_or_or_good_mask   : shl_or_or_good_mask_before  ⊑  shl_or_or_good_mask_combined := by
  unfold shl_or_or_good_mask_before shl_or_or_good_mask_combined
  simp_alive_peephole
  sorry
def shl_or_or_fail_bad_mask_combined := [llvmfunc|
  llvm.func @shl_or_or_fail_bad_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[19, 24]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg1, %arg0  : vector<2xi8>
    %3 = llvm.shl %2, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_shl_or_or_fail_bad_mask   : shl_or_or_fail_bad_mask_before  ⊑  shl_or_or_fail_bad_mask_combined := by
  unfold shl_or_or_fail_bad_mask_before shl_or_or_fail_bad_mask_combined
  simp_alive_peephole
  sorry
def lshr_xor_or_good_mask_combined := [llvmfunc|
  llvm.func @lshr_xor_or_good_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(48 : i8) : i8
    %2 = llvm.or %arg1, %arg0  : i8
    %3 = llvm.lshr %2, %0  : i8
    %4 = llvm.or %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_lshr_xor_or_good_mask   : lshr_xor_or_good_mask_before  ⊑  lshr_xor_or_good_mask_combined := by
  unfold lshr_xor_or_good_mask_before lshr_xor_or_good_mask_combined
  simp_alive_peephole
  sorry
def lshr_xor_or_fail_bad_mask_combined := [llvmfunc|
  llvm.func @lshr_xor_or_fail_bad_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_xor_or_fail_bad_mask   : lshr_xor_or_fail_bad_mask_before  ⊑  lshr_xor_or_fail_bad_mask_combined := by
  unfold lshr_xor_or_fail_bad_mask_before lshr_xor_or_fail_bad_mask_combined
  simp_alive_peephole
  sorry
def lshr_or_xor_good_mask_combined := [llvmfunc|
  llvm.func @lshr_or_xor_good_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-64, 64]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg1, %0  : vector<2xi8>
    %3 = llvm.xor %2, %arg0  : vector<2xi8>
    %4 = llvm.lshr %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_lshr_or_xor_good_mask   : lshr_or_xor_good_mask_before  ⊑  lshr_or_xor_good_mask_combined := by
  unfold lshr_or_xor_good_mask_before lshr_or_xor_good_mask_combined
  simp_alive_peephole
  sorry
def lshr_or_xor_fail_bad_mask_combined := [llvmfunc|
  llvm.func @lshr_or_xor_fail_bad_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[7, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %1  : vector<2xi8>
    %5 = llvm.xor %2, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_lshr_or_xor_fail_bad_mask   : lshr_or_xor_fail_bad_mask_before  ⊑  lshr_or_xor_fail_bad_mask_combined := by
  unfold lshr_or_xor_fail_bad_mask_before lshr_or_xor_fail_bad_mask_combined
  simp_alive_peephole
  sorry
def shl_xor_xor_good_mask_combined := [llvmfunc|
  llvm.func @shl_xor_xor_good_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(88 : i8) : i8
    %2 = llvm.xor %arg1, %arg0  : i8
    %3 = llvm.shl %2, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_xor_xor_good_mask   : shl_xor_xor_good_mask_before  ⊑  shl_xor_xor_good_mask_combined := by
  unfold shl_xor_xor_good_mask_before shl_xor_xor_good_mask_combined
  simp_alive_peephole
  sorry
def shl_xor_xor_bad_mask_distribute_combined := [llvmfunc|
  llvm.func @shl_xor_xor_bad_mask_distribute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-68 : i8) : i8
    %2 = llvm.xor %arg1, %arg0  : i8
    %3 = llvm.shl %2, %0  : i8
    %4 = llvm.xor %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_xor_xor_bad_mask_distribute   : shl_xor_xor_bad_mask_distribute_before  ⊑  shl_xor_xor_bad_mask_distribute_combined := by
  unfold shl_xor_xor_bad_mask_distribute_before shl_xor_xor_bad_mask_distribute_combined
  simp_alive_peephole
  sorry
def shl_add_and_combined := [llvmfunc|
  llvm.func @shl_add_and(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(61 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.add %arg1, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.shl %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_add_and   : shl_add_and_before  ⊑  shl_add_and_combined := by
  unfold shl_add_and_before shl_add_and_combined
  simp_alive_peephole
  sorry
def lshr_and_add_fail_combined := [llvmfunc|
  llvm.func @lshr_and_add_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.add %2, %4 overflow<nuw>  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_and_add_fail   : lshr_and_add_fail_before  ⊑  lshr_and_add_fail_combined := by
  unfold lshr_and_add_fail_before lshr_and_add_fail_combined
  simp_alive_peephole
  sorry
def lshr_add_or_fail_combined := [llvmfunc|
  llvm.func @lshr_add_or_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1 overflow<nuw>  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_add_or_fail   : lshr_add_or_fail_before  ⊑  lshr_add_or_fail_combined := by
  unfold lshr_add_or_fail_before lshr_add_or_fail_combined
  simp_alive_peephole
  sorry
def lshr_add_xor_fail_combined := [llvmfunc|
  llvm.func @lshr_add_xor_fail(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1 overflow<nuw>  : i8
    %5 = llvm.xor %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_lshr_add_xor_fail   : lshr_add_xor_fail_before  ⊑  lshr_add_xor_fail_combined := by
  unfold lshr_add_xor_fail_before lshr_add_xor_fail_combined
  simp_alive_peephole
  sorry
def lshr_and_add_combined := [llvmfunc|
  llvm.func @lshr_and_add(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[11, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %arg1  : vector<2xi8>
    %4 = llvm.shl %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_lshr_and_add   : lshr_and_add_before  ⊑  lshr_and_add_combined := by
  unfold lshr_and_add_before lshr_and_add_combined
  simp_alive_peephole
  sorry
def lshr_or_add_fail_combined := [llvmfunc|
  llvm.func @lshr_or_add_fail(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[4, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-67, 123]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.shl %arg1, %0  : vector<2xi8>
    %4 = llvm.or %2, %1  : vector<2xi8>
    %5 = llvm.add %3, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_lshr_or_add_fail   : lshr_or_add_fail_before  ⊑  lshr_or_add_fail_combined := by
  unfold lshr_or_add_fail_before lshr_or_add_fail_combined
  simp_alive_peephole
  sorry
def shl_add_and_fail_mismatch_shift_combined := [llvmfunc|
  llvm.func @shl_add_and_fail_mismatch_shift(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.add %3, %1 overflow<nuw>  : i8
    %5 = llvm.and %2, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_shl_add_and_fail_mismatch_shift   : shl_add_and_fail_mismatch_shift_before  ⊑  shl_add_and_fail_mismatch_shift_combined := by
  unfold shl_add_and_fail_mismatch_shift_before shl_add_and_fail_mismatch_shift_combined
  simp_alive_peephole
  sorry
def and_ashr_not_combined := [llvmfunc|
  llvm.func @and_ashr_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.ashr %2, %arg2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_and_ashr_not   : and_ashr_not_before  ⊑  and_ashr_not_combined := by
  unfold and_ashr_not_before and_ashr_not_combined
  simp_alive_peephole
  sorry
def and_ashr_not_commuted_combined := [llvmfunc|
  llvm.func @and_ashr_not_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.ashr %2, %arg2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_and_ashr_not_commuted   : and_ashr_not_commuted_before  ⊑  and_ashr_not_commuted_combined := by
  unfold and_ashr_not_commuted_before and_ashr_not_commuted_combined
  simp_alive_peephole
  sorry
def and_ashr_not_fail_lshr_ashr_combined := [llvmfunc|
  llvm.func @and_ashr_not_fail_lshr_ashr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_and_ashr_not_fail_lshr_ashr   : and_ashr_not_fail_lshr_ashr_before  ⊑  and_ashr_not_fail_lshr_ashr_combined := by
  unfold and_ashr_not_fail_lshr_ashr_before and_ashr_not_fail_lshr_ashr_combined
  simp_alive_peephole
  sorry
def and_ashr_not_fail_ashr_lshr_combined := [llvmfunc|
  llvm.func @and_ashr_not_fail_ashr_lshr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.lshr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_and_ashr_not_fail_ashr_lshr   : and_ashr_not_fail_ashr_lshr_before  ⊑  and_ashr_not_fail_ashr_lshr_combined := by
  unfold and_ashr_not_fail_ashr_lshr_before and_ashr_not_fail_ashr_lshr_combined
  simp_alive_peephole
  sorry
def and_ashr_not_fail_invalid_xor_constant_combined := [llvmfunc|
  llvm.func @and_ashr_not_fail_invalid_xor_constant(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_and_ashr_not_fail_invalid_xor_constant   : and_ashr_not_fail_invalid_xor_constant_before  ⊑  and_ashr_not_fail_invalid_xor_constant_combined := by
  unfold and_ashr_not_fail_invalid_xor_constant_before and_ashr_not_fail_invalid_xor_constant_combined
  simp_alive_peephole
  sorry
def and_ashr_not_vec_combined := [llvmfunc|
  llvm.func @and_ashr_not_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.xor %arg1, %0  : vector<4xi8>
    %2 = llvm.and %1, %arg0  : vector<4xi8>
    %3 = llvm.ashr %2, %arg2  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_and_ashr_not_vec   : and_ashr_not_vec_before  ⊑  and_ashr_not_vec_combined := by
  unfold and_ashr_not_vec_before and_ashr_not_vec_combined
  simp_alive_peephole
  sorry
def and_ashr_not_vec_commuted_combined := [llvmfunc|
  llvm.func @and_ashr_not_vec_commuted(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.xor %arg1, %0  : vector<4xi8>
    %2 = llvm.and %1, %arg0  : vector<4xi8>
    %3 = llvm.ashr %2, %arg2  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_and_ashr_not_vec_commuted   : and_ashr_not_vec_commuted_before  ⊑  and_ashr_not_vec_commuted_combined := by
  unfold and_ashr_not_vec_commuted_before and_ashr_not_vec_commuted_combined
  simp_alive_peephole
  sorry
def and_ashr_not_vec_poison_1_combined := [llvmfunc|
  llvm.func @and_ashr_not_vec_poison_1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.xor %arg1, %0  : vector<4xi8>
    %2 = llvm.and %1, %arg0  : vector<4xi8>
    %3 = llvm.ashr %2, %arg2  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_and_ashr_not_vec_poison_1   : and_ashr_not_vec_poison_1_before  ⊑  and_ashr_not_vec_poison_1_combined := by
  unfold and_ashr_not_vec_poison_1_before and_ashr_not_vec_poison_1_combined
  simp_alive_peephole
  sorry
def and_ashr_not_vec_poison_2_combined := [llvmfunc|
  llvm.func @and_ashr_not_vec_poison_2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    llvm.return %0 : vector<4xi8>
  }]

theorem inst_combine_and_ashr_not_vec_poison_2   : and_ashr_not_vec_poison_2_before  ⊑  and_ashr_not_vec_poison_2_combined := by
  unfold and_ashr_not_vec_poison_2_before and_ashr_not_vec_poison_2_combined
  simp_alive_peephole
  sorry
def or_ashr_not_combined := [llvmfunc|
  llvm.func @or_ashr_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.ashr %2, %arg2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_or_ashr_not   : or_ashr_not_before  ⊑  or_ashr_not_combined := by
  unfold or_ashr_not_before or_ashr_not_combined
  simp_alive_peephole
  sorry
def or_ashr_not_commuted_combined := [llvmfunc|
  llvm.func @or_ashr_not_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.ashr %2, %arg2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_or_ashr_not_commuted   : or_ashr_not_commuted_before  ⊑  or_ashr_not_commuted_combined := by
  unfold or_ashr_not_commuted_before or_ashr_not_commuted_combined
  simp_alive_peephole
  sorry
def or_ashr_not_fail_lshr_ashr_combined := [llvmfunc|
  llvm.func @or_ashr_not_fail_lshr_ashr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_ashr_not_fail_lshr_ashr   : or_ashr_not_fail_lshr_ashr_before  ⊑  or_ashr_not_fail_lshr_ashr_combined := by
  unfold or_ashr_not_fail_lshr_ashr_before or_ashr_not_fail_lshr_ashr_combined
  simp_alive_peephole
  sorry
def or_ashr_not_fail_ashr_lshr_combined := [llvmfunc|
  llvm.func @or_ashr_not_fail_ashr_lshr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.lshr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_ashr_not_fail_ashr_lshr   : or_ashr_not_fail_ashr_lshr_before  ⊑  or_ashr_not_fail_ashr_lshr_combined := by
  unfold or_ashr_not_fail_ashr_lshr_before or_ashr_not_fail_ashr_lshr_combined
  simp_alive_peephole
  sorry
def or_ashr_not_fail_invalid_xor_constant_combined := [llvmfunc|
  llvm.func @or_ashr_not_fail_invalid_xor_constant(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_or_ashr_not_fail_invalid_xor_constant   : or_ashr_not_fail_invalid_xor_constant_before  ⊑  or_ashr_not_fail_invalid_xor_constant_combined := by
  unfold or_ashr_not_fail_invalid_xor_constant_before or_ashr_not_fail_invalid_xor_constant_combined
  simp_alive_peephole
  sorry
def or_ashr_not_vec_combined := [llvmfunc|
  llvm.func @or_ashr_not_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.xor %arg1, %0  : vector<4xi8>
    %2 = llvm.or %1, %arg0  : vector<4xi8>
    %3 = llvm.ashr %2, %arg2  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_or_ashr_not_vec   : or_ashr_not_vec_before  ⊑  or_ashr_not_vec_combined := by
  unfold or_ashr_not_vec_before or_ashr_not_vec_combined
  simp_alive_peephole
  sorry
def or_ashr_not_vec_commuted_combined := [llvmfunc|
  llvm.func @or_ashr_not_vec_commuted(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.xor %arg1, %0  : vector<4xi8>
    %2 = llvm.or %1, %arg0  : vector<4xi8>
    %3 = llvm.ashr %2, %arg2  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_or_ashr_not_vec_commuted   : or_ashr_not_vec_commuted_before  ⊑  or_ashr_not_vec_commuted_combined := by
  unfold or_ashr_not_vec_commuted_before or_ashr_not_vec_commuted_combined
  simp_alive_peephole
  sorry
def or_ashr_not_vec_poison_1_combined := [llvmfunc|
  llvm.func @or_ashr_not_vec_poison_1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.xor %arg1, %0  : vector<4xi8>
    %2 = llvm.or %1, %arg0  : vector<4xi8>
    %3 = llvm.ashr %2, %arg2  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_or_ashr_not_vec_poison_1   : or_ashr_not_vec_poison_1_before  ⊑  or_ashr_not_vec_poison_1_combined := by
  unfold or_ashr_not_vec_poison_1_before or_ashr_not_vec_poison_1_combined
  simp_alive_peephole
  sorry
def or_ashr_not_vec_poison_2_combined := [llvmfunc|
  llvm.func @or_ashr_not_vec_poison_2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    llvm.return %0 : vector<4xi8>
  }]

theorem inst_combine_or_ashr_not_vec_poison_2   : or_ashr_not_vec_poison_2_before  ⊑  or_ashr_not_vec_poison_2_combined := by
  unfold or_ashr_not_vec_poison_2_before or_ashr_not_vec_poison_2_combined
  simp_alive_peephole
  sorry
def xor_ashr_not_combined := [llvmfunc|
  llvm.func @xor_ashr_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.ashr %1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor_ashr_not   : xor_ashr_not_before  ⊑  xor_ashr_not_combined := by
  unfold xor_ashr_not_before xor_ashr_not_combined
  simp_alive_peephole
  sorry
def xor_ashr_not_commuted_combined := [llvmfunc|
  llvm.func @xor_ashr_not_commuted(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.ashr %1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor_ashr_not_commuted   : xor_ashr_not_commuted_before  ⊑  xor_ashr_not_commuted_combined := by
  unfold xor_ashr_not_commuted_before xor_ashr_not_commuted_combined
  simp_alive_peephole
  sorry
def xor_ashr_not_fail_lshr_ashr_combined := [llvmfunc|
  llvm.func @xor_ashr_not_fail_lshr_ashr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_xor_ashr_not_fail_lshr_ashr   : xor_ashr_not_fail_lshr_ashr_before  ⊑  xor_ashr_not_fail_lshr_ashr_combined := by
  unfold xor_ashr_not_fail_lshr_ashr_before xor_ashr_not_fail_lshr_ashr_combined
  simp_alive_peephole
  sorry
def xor_ashr_not_fail_ashr_lshr_combined := [llvmfunc|
  llvm.func @xor_ashr_not_fail_ashr_lshr(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.lshr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_xor_ashr_not_fail_ashr_lshr   : xor_ashr_not_fail_ashr_lshr_before  ⊑  xor_ashr_not_fail_ashr_lshr_combined := by
  unfold xor_ashr_not_fail_ashr_lshr_before xor_ashr_not_fail_ashr_lshr_combined
  simp_alive_peephole
  sorry
def xor_ashr_not_fail_invalid_xor_constant_combined := [llvmfunc|
  llvm.func @xor_ashr_not_fail_invalid_xor_constant(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.xor %arg1, %arg0  : i8
    %2 = llvm.ashr %1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_xor_ashr_not_fail_invalid_xor_constant   : xor_ashr_not_fail_invalid_xor_constant_before  ⊑  xor_ashr_not_fail_invalid_xor_constant_combined := by
  unfold xor_ashr_not_fail_invalid_xor_constant_before xor_ashr_not_fail_invalid_xor_constant_combined
  simp_alive_peephole
  sorry
def xor_ashr_not_vec_combined := [llvmfunc|
  llvm.func @xor_ashr_not_vec(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.xor %arg1, %arg0  : vector<4xi8>
    %2 = llvm.ashr %1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_xor_ashr_not_vec   : xor_ashr_not_vec_before  ⊑  xor_ashr_not_vec_combined := by
  unfold xor_ashr_not_vec_before xor_ashr_not_vec_combined
  simp_alive_peephole
  sorry
def xor_ashr_not_vec_commuted_combined := [llvmfunc|
  llvm.func @xor_ashr_not_vec_commuted(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.xor %arg1, %arg0  : vector<4xi8>
    %2 = llvm.ashr %1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_xor_ashr_not_vec_commuted   : xor_ashr_not_vec_commuted_before  ⊑  xor_ashr_not_vec_commuted_combined := by
  unfold xor_ashr_not_vec_commuted_before xor_ashr_not_vec_commuted_combined
  simp_alive_peephole
  sorry
def xor_ashr_not_vec_poison_1_combined := [llvmfunc|
  llvm.func @xor_ashr_not_vec_poison_1(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.xor %arg1, %arg0  : vector<4xi8>
    %2 = llvm.ashr %1, %arg2  : vector<4xi8>
    %3 = llvm.xor %2, %0  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

theorem inst_combine_xor_ashr_not_vec_poison_1   : xor_ashr_not_vec_poison_1_before  ⊑  xor_ashr_not_vec_poison_1_combined := by
  unfold xor_ashr_not_vec_poison_1_before xor_ashr_not_vec_poison_1_combined
  simp_alive_peephole
  sorry
def xor_ashr_not_vec_poison_2_combined := [llvmfunc|
  llvm.func @xor_ashr_not_vec_poison_2(%arg0: vector<4xi8>, %arg1: vector<4xi8>, %arg2: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    llvm.return %0 : vector<4xi8>
  }]

theorem inst_combine_xor_ashr_not_vec_poison_2   : xor_ashr_not_vec_poison_2_before  ⊑  xor_ashr_not_vec_poison_2_combined := by
  unfold xor_ashr_not_vec_poison_2_before xor_ashr_not_vec_poison_2_combined
  simp_alive_peephole
  sorry
def binop_ashr_not_fail_invalid_binop_combined := [llvmfunc|
  llvm.func @binop_ashr_not_fail_invalid_binop(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.ashr %arg0, %arg2  : i8
    %2 = llvm.ashr %arg1, %arg2  : i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.add %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_binop_ashr_not_fail_invalid_binop   : binop_ashr_not_fail_invalid_binop_before  ⊑  binop_ashr_not_fail_invalid_binop_combined := by
  unfold binop_ashr_not_fail_invalid_binop_before binop_ashr_not_fail_invalid_binop_combined
  simp_alive_peephole
  sorry
