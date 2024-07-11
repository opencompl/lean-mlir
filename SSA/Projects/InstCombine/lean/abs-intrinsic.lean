import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  abs-intrinsic
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_abs_abs_a_mul_b_i8_before := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8]

    %1 = llvm.mul %0, %arg1  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8]

    llvm.return %2 : i8
  }]

def test_abs_a_mul_abs_b_i8_before := [llvmfunc|
  llvm.func @test_abs_a_mul_abs_b_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.urem %0, %arg0  : i8
    %2 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i8) -> i8]

    %3 = llvm.mul %1, %2  : i8
    %4 = "llvm.intr.abs"(%3) <{is_int_min_poison = true}> : (i8) -> i8]

    llvm.return %4 : i8
  }]

def test_abs_abs_a_mul_b_i32_before := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def test_abs_abs_a_mul_b_i32_abs_false_true_before := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i32_abs_false_true(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def test_abs_abs_a_mul_b_i32_abs_true_false_before := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i32_abs_true_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def test_abs_abs_a_mul_b_i32_abs_false_false_before := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i32_abs_false_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def test_nsw_with_true_before := [llvmfunc|
  llvm.func @test_nsw_with_true(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

    %1 = llvm.mul %0, %arg1 overflow<nsw>  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8]

    llvm.return %2 : i8
  }]

def test_nsw_with_false_before := [llvmfunc|
  llvm.func @test_nsw_with_false(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

    %1 = llvm.mul %0, %arg1 overflow<nsw>  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i8) -> i8]

    llvm.return %2 : i8
  }]

def test_abs_abs_a_mul_b_more_one_use_before := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_more_one_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.call @use(%1) : (i32) -> ()
    llvm.return %2 : i32
  }]

def test_abs_abs_a_mul_b_vector_i8_before := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_vector_i8(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>]

    %1 = llvm.mul %0, %arg1  : vector<2xi8>
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>]

    llvm.return %2 : vector<2xi8>
  }]

def abs_trailing_zeros_before := [llvmfunc|
  llvm.func @abs_trailing_zeros(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i32) -> i32]

    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def abs_trailing_zeros_vec_before := [llvmfunc|
  llvm.func @abs_trailing_zeros_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-4, -8, -16, -32]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

    %4 = llvm.and %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def abs_trailing_zeros_negative_before := [llvmfunc|
  llvm.func @abs_trailing_zeros_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i32) -> i32]

    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def abs_trailing_zeros_negative_vec_before := [llvmfunc|
  llvm.func @abs_trailing_zeros_negative_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-4> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

    %4 = llvm.and %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def abs_signbits_before := [llvmfunc|
  llvm.func @abs_signbits(%arg0: i30) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i30 to i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

    %3 = llvm.add %2, %0  : i32
    llvm.return %3 : i32
  }]

def abs_signbits_vec_before := [llvmfunc|
  llvm.func @abs_signbits_vec(%arg0: vector<4xi30>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.sext %arg0 : vector<4xi30> to vector<4xi32>
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

    %3 = llvm.add %2, %0  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def abs_of_neg_before := [llvmfunc|
  llvm.func @abs_of_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def abs_of_neg_vec_before := [llvmfunc|
  llvm.func @abs_of_neg_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<4xi32>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

    llvm.return %3 : vector<4xi32>
  }]

def abs_of_select_neg_true_val_before := [llvmfunc|
  llvm.func @abs_of_select_neg_true_val(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.select %arg0, %1, %arg1 : i1, i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def abs_of_select_neg_false_val_before := [llvmfunc|
  llvm.func @abs_of_select_neg_false_val(%arg0: vector<4xi1>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.sub %1, %arg1  : vector<4xi32>
    %3 = llvm.select %arg0, %arg1, %2 : vector<4xi1>, vector<4xi32>
    %4 = "llvm.intr.abs"(%3) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

    llvm.return %4 : vector<4xi32>
  }]

def abs_dom_cond_nopoison_before := [llvmfunc|
  llvm.func @abs_dom_cond_nopoison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    %3 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def abs_dom_cond_poison_before := [llvmfunc|
  llvm.func @abs_dom_cond_poison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  ^bb2:  // pred: ^bb0
    %3 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def zext_abs_before := [llvmfunc|
  llvm.func @zext_abs(%arg0: i31) -> i32 {
    %0 = llvm.zext %arg0 : i31 to i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def lshr_abs_before := [llvmfunc|
  llvm.func @lshr_abs(%arg0: vector<3xi82>) -> vector<3xi82> {
    %0 = llvm.mlir.constant(1 : i82) : i82
    %1 = llvm.mlir.constant(dense<1> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.lshr %arg0, %1  : vector<3xi82>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (vector<3xi82>) -> vector<3xi82>]

    llvm.return %3 : vector<3xi82>
  }]

def and_abs_before := [llvmfunc|
  llvm.func @and_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483644 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def select_abs_before := [llvmfunc|
  llvm.func @select_abs(%arg0: vector<3xi1>) -> vector<3xi82> {
    %0 = llvm.mlir.constant(0 : i82) : i82
    %1 = llvm.mlir.constant(dense<0> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.mlir.constant(1 : i82) : i82
    %3 = llvm.mlir.constant(42 : i82) : i82
    %4 = llvm.mlir.constant(2147483647 : i82) : i82
    %5 = llvm.mlir.constant(dense<[2147483647, 42, 1]> : vector<3xi82>) : vector<3xi82>
    %6 = llvm.select %arg0, %1, %5 : vector<3xi1>, vector<3xi82>
    %7 = "llvm.intr.abs"(%6) <{is_int_min_poison = false}> : (vector<3xi82>) -> vector<3xi82>]

    llvm.return %7 : vector<3xi82>
  }]

def assume_abs_before := [llvmfunc|
  llvm.func @assume_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def abs_assume_neg_before := [llvmfunc|
  llvm.func @abs_assume_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def abs_known_neg_before := [llvmfunc|
  llvm.func @abs_known_neg(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %3 : i32
  }]

def abs_eq_int_min_poison_before := [llvmfunc|
  llvm.func @abs_eq_int_min_poison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8]

    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def abs_ne_int_min_poison_before := [llvmfunc|
  llvm.func @abs_ne_int_min_poison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8]

    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def abs_eq_int_min_nopoison_before := [llvmfunc|
  llvm.func @abs_eq_int_min_nopoison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def abs_ne_int_min_nopoison_before := [llvmfunc|
  llvm.func @abs_ne_int_min_nopoison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def abs_sext_before := [llvmfunc|
  llvm.func @abs_sext(%arg0: i8) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def abs_nsw_sext_before := [llvmfunc|
  llvm.func @abs_nsw_sext(%arg0: vector<3xi7>) -> vector<3xi82> {
    %0 = llvm.sext %arg0 : vector<3xi7> to vector<3xi82>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (vector<3xi82>) -> vector<3xi82>]

    llvm.return %1 : vector<3xi82>
  }]

def abs_sext_extra_use_before := [llvmfunc|
  llvm.func @abs_sext_extra_use(%arg0: i8, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.return %1 : i32
  }]

def trunc_abs_sext_before := [llvmfunc|
  llvm.func @trunc_abs_sext(%arg0: i8) -> i8 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i32) -> i32]

    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }]

def trunc_abs_sext_vec_before := [llvmfunc|
  llvm.func @trunc_abs_sext_vec(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.sext %arg0 : vector<4xi8> to vector<4xi32>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (vector<4xi32>) -> vector<4xi32>]

    %2 = llvm.trunc %1 : vector<4xi32> to vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def demand_low_bit_before := [llvmfunc|
  llvm.func @demand_low_bit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def demand_low_bit_int_min_is_poison_before := [llvmfunc|
  llvm.func @demand_low_bit_int_min_is_poison(%arg0: vector<3xi82>) -> vector<3xi82> {
    %0 = llvm.mlir.constant(81 : i82) : i82
    %1 = llvm.mlir.constant(dense<81> : vector<3xi82>) : vector<3xi82>
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<3xi82>) -> vector<3xi82>]

    %3 = llvm.shl %2, %1  : vector<3xi82>
    llvm.return %3 : vector<3xi82>
  }]

def demand_low_bits_before := [llvmfunc|
  llvm.func @demand_low_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def srem_by_2_int_min_is_poison_before := [llvmfunc|
  llvm.func @srem_by_2_int_min_is_poison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def srem_by_2_before := [llvmfunc|
  llvm.func @srem_by_2(%arg0: vector<3xi82>, %arg1: !llvm.ptr) -> vector<3xi82> {
    %0 = llvm.mlir.constant(2 : i82) : i82
    %1 = llvm.mlir.constant(dense<2> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.srem %arg0, %1  : vector<3xi82>
    llvm.store %2, %arg1 {alignment = 32 : i64} : vector<3xi82>, !llvm.ptr]

    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<3xi82>) -> vector<3xi82>]

    llvm.return %3 : vector<3xi82>
  }]

def srem_by_3_before := [llvmfunc|
  llvm.func @srem_by_3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.return %2 : i32
  }]

def sub_abs_gt_before := [llvmfunc|
  llvm.func @sub_abs_gt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def sub_abs_sgeT_before := [llvmfunc|
  llvm.func @sub_abs_sgeT(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def sub_abs_sgeT_swap_before := [llvmfunc|
  llvm.func @sub_abs_sgeT_swap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg1, %arg0 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def sub_abs_sgeT_false_before := [llvmfunc|
  llvm.func @sub_abs_sgeT_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def sub_abs_lt_before := [llvmfunc|
  llvm.func @sub_abs_lt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def sub_abs_sle_before := [llvmfunc|
  llvm.func @sub_abs_sle(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def sub_abs_sleF_before := [llvmfunc|
  llvm.func @sub_abs_sleF(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i8) -> i8]

    llvm.br ^bb2(%3 : i8)
  ^bb2(%4: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i8
  }]

def sub_abs_sleT_before := [llvmfunc|
  llvm.func @sub_abs_sleT(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i8) -> i8]

    llvm.br ^bb2(%3 : i8)
  ^bb2(%4: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i8
  }]

def sub_abs_lt_min_not_poison_before := [llvmfunc|
  llvm.func @sub_abs_lt_min_not_poison(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i32) -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def sub_abs_wrong_pred_before := [llvmfunc|
  llvm.func @sub_abs_wrong_pred(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def sub_abs_no_nsw_before := [llvmfunc|
  llvm.func @sub_abs_no_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def test_abs_abs_a_mul_b_i8_combined := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8]

theorem inst_combine_test_abs_abs_a_mul_b_i8   : test_abs_abs_a_mul_b_i8_before  ⊑  test_abs_abs_a_mul_b_i8_combined := by
  unfold test_abs_abs_a_mul_b_i8_before test_abs_abs_a_mul_b_i8_combined
  simp_alive_peephole
  sorry
    %1 = llvm.mul %0, %arg1  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8]

theorem inst_combine_test_abs_abs_a_mul_b_i8   : test_abs_abs_a_mul_b_i8_before  ⊑  test_abs_abs_a_mul_b_i8_combined := by
  unfold test_abs_abs_a_mul_b_i8_before test_abs_abs_a_mul_b_i8_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_test_abs_abs_a_mul_b_i8   : test_abs_abs_a_mul_b_i8_before  ⊑  test_abs_abs_a_mul_b_i8_combined := by
  unfold test_abs_abs_a_mul_b_i8_before test_abs_abs_a_mul_b_i8_combined
  simp_alive_peephole
  sorry
def test_abs_a_mul_abs_b_i8_combined := [llvmfunc|
  llvm.func @test_abs_a_mul_abs_b_i8(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.urem %0, %arg0  : i8
    %2 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i8) -> i8]

theorem inst_combine_test_abs_a_mul_abs_b_i8   : test_abs_a_mul_abs_b_i8_before  ⊑  test_abs_a_mul_abs_b_i8_combined := by
  unfold test_abs_a_mul_abs_b_i8_before test_abs_a_mul_abs_b_i8_combined
  simp_alive_peephole
  sorry
    %3 = llvm.mul %1, %2  : i8
    %4 = "llvm.intr.abs"(%3) <{is_int_min_poison = true}> : (i8) -> i8]

theorem inst_combine_test_abs_a_mul_abs_b_i8   : test_abs_a_mul_abs_b_i8_before  ⊑  test_abs_a_mul_abs_b_i8_combined := by
  unfold test_abs_a_mul_abs_b_i8_before test_abs_a_mul_abs_b_i8_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i8
  }]

theorem inst_combine_test_abs_a_mul_abs_b_i8   : test_abs_a_mul_abs_b_i8_before  ⊑  test_abs_a_mul_abs_b_i8_combined := by
  unfold test_abs_a_mul_abs_b_i8_before test_abs_a_mul_abs_b_i8_combined
  simp_alive_peephole
  sorry
def test_abs_abs_a_mul_b_i32_combined := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_i32   : test_abs_abs_a_mul_b_i32_before  ⊑  test_abs_abs_a_mul_b_i32_combined := by
  unfold test_abs_abs_a_mul_b_i32_before test_abs_abs_a_mul_b_i32_combined
  simp_alive_peephole
  sorry
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_i32   : test_abs_abs_a_mul_b_i32_before  ⊑  test_abs_abs_a_mul_b_i32_combined := by
  unfold test_abs_abs_a_mul_b_i32_before test_abs_abs_a_mul_b_i32_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_test_abs_abs_a_mul_b_i32   : test_abs_abs_a_mul_b_i32_before  ⊑  test_abs_abs_a_mul_b_i32_combined := by
  unfold test_abs_abs_a_mul_b_i32_before test_abs_abs_a_mul_b_i32_combined
  simp_alive_peephole
  sorry
def test_abs_abs_a_mul_b_i32_abs_false_true_combined := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i32_abs_false_true(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_i32_abs_false_true   : test_abs_abs_a_mul_b_i32_abs_false_true_before  ⊑  test_abs_abs_a_mul_b_i32_abs_false_true_combined := by
  unfold test_abs_abs_a_mul_b_i32_abs_false_true_before test_abs_abs_a_mul_b_i32_abs_false_true_combined
  simp_alive_peephole
  sorry
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_i32_abs_false_true   : test_abs_abs_a_mul_b_i32_abs_false_true_before  ⊑  test_abs_abs_a_mul_b_i32_abs_false_true_combined := by
  unfold test_abs_abs_a_mul_b_i32_abs_false_true_before test_abs_abs_a_mul_b_i32_abs_false_true_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_test_abs_abs_a_mul_b_i32_abs_false_true   : test_abs_abs_a_mul_b_i32_abs_false_true_before  ⊑  test_abs_abs_a_mul_b_i32_abs_false_true_combined := by
  unfold test_abs_abs_a_mul_b_i32_abs_false_true_before test_abs_abs_a_mul_b_i32_abs_false_true_combined
  simp_alive_peephole
  sorry
def test_abs_abs_a_mul_b_i32_abs_true_false_combined := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i32_abs_true_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_i32_abs_true_false   : test_abs_abs_a_mul_b_i32_abs_true_false_before  ⊑  test_abs_abs_a_mul_b_i32_abs_true_false_combined := by
  unfold test_abs_abs_a_mul_b_i32_abs_true_false_before test_abs_abs_a_mul_b_i32_abs_true_false_combined
  simp_alive_peephole
  sorry
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_i32_abs_true_false   : test_abs_abs_a_mul_b_i32_abs_true_false_before  ⊑  test_abs_abs_a_mul_b_i32_abs_true_false_combined := by
  unfold test_abs_abs_a_mul_b_i32_abs_true_false_before test_abs_abs_a_mul_b_i32_abs_true_false_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_test_abs_abs_a_mul_b_i32_abs_true_false   : test_abs_abs_a_mul_b_i32_abs_true_false_before  ⊑  test_abs_abs_a_mul_b_i32_abs_true_false_combined := by
  unfold test_abs_abs_a_mul_b_i32_abs_true_false_before test_abs_abs_a_mul_b_i32_abs_true_false_combined
  simp_alive_peephole
  sorry
def test_abs_abs_a_mul_b_i32_abs_false_false_combined := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_i32_abs_false_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_i32_abs_false_false   : test_abs_abs_a_mul_b_i32_abs_false_false_before  ⊑  test_abs_abs_a_mul_b_i32_abs_false_false_combined := by
  unfold test_abs_abs_a_mul_b_i32_abs_false_false_before test_abs_abs_a_mul_b_i32_abs_false_false_combined
  simp_alive_peephole
  sorry
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_i32_abs_false_false   : test_abs_abs_a_mul_b_i32_abs_false_false_before  ⊑  test_abs_abs_a_mul_b_i32_abs_false_false_combined := by
  unfold test_abs_abs_a_mul_b_i32_abs_false_false_before test_abs_abs_a_mul_b_i32_abs_false_false_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_test_abs_abs_a_mul_b_i32_abs_false_false   : test_abs_abs_a_mul_b_i32_abs_false_false_before  ⊑  test_abs_abs_a_mul_b_i32_abs_false_false_combined := by
  unfold test_abs_abs_a_mul_b_i32_abs_false_false_before test_abs_abs_a_mul_b_i32_abs_false_false_combined
  simp_alive_peephole
  sorry
def test_nsw_with_true_combined := [llvmfunc|
  llvm.func @test_nsw_with_true(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_test_nsw_with_true   : test_nsw_with_true_before  ⊑  test_nsw_with_true_combined := by
  unfold test_nsw_with_true_before test_nsw_with_true_combined
  simp_alive_peephole
  sorry
    %1 = llvm.mul %0, %arg1 overflow<nsw>  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8]

theorem inst_combine_test_nsw_with_true   : test_nsw_with_true_before  ⊑  test_nsw_with_true_combined := by
  unfold test_nsw_with_true_before test_nsw_with_true_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_test_nsw_with_true   : test_nsw_with_true_before  ⊑  test_nsw_with_true_combined := by
  unfold test_nsw_with_true_before test_nsw_with_true_combined
  simp_alive_peephole
  sorry
def test_nsw_with_false_combined := [llvmfunc|
  llvm.func @test_nsw_with_false(%arg0: i8, %arg1: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_test_nsw_with_false   : test_nsw_with_false_before  ⊑  test_nsw_with_false_combined := by
  unfold test_nsw_with_false_before test_nsw_with_false_combined
  simp_alive_peephole
  sorry
    %1 = llvm.mul %0, %arg1 overflow<nsw>  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_test_nsw_with_false   : test_nsw_with_false_before  ⊑  test_nsw_with_false_combined := by
  unfold test_nsw_with_false_before test_nsw_with_false_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_test_nsw_with_false   : test_nsw_with_false_before  ⊑  test_nsw_with_false_combined := by
  unfold test_nsw_with_false_before test_nsw_with_false_combined
  simp_alive_peephole
  sorry
def test_abs_abs_a_mul_b_more_one_use_combined := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_more_one_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_more_one_use   : test_abs_abs_a_mul_b_more_one_use_before  ⊑  test_abs_abs_a_mul_b_more_one_use_combined := by
  unfold test_abs_abs_a_mul_b_more_one_use_before test_abs_abs_a_mul_b_more_one_use_combined
  simp_alive_peephole
  sorry
    %1 = llvm.mul %0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_test_abs_abs_a_mul_b_more_one_use   : test_abs_abs_a_mul_b_more_one_use_before  ⊑  test_abs_abs_a_mul_b_more_one_use_combined := by
  unfold test_abs_abs_a_mul_b_more_one_use_before test_abs_abs_a_mul_b_more_one_use_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %2 : i32
  }]

theorem inst_combine_test_abs_abs_a_mul_b_more_one_use   : test_abs_abs_a_mul_b_more_one_use_before  ⊑  test_abs_abs_a_mul_b_more_one_use_combined := by
  unfold test_abs_abs_a_mul_b_more_one_use_before test_abs_abs_a_mul_b_more_one_use_combined
  simp_alive_peephole
  sorry
def test_abs_abs_a_mul_b_vector_i8_combined := [llvmfunc|
  llvm.func @test_abs_abs_a_mul_b_vector_i8(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>]

theorem inst_combine_test_abs_abs_a_mul_b_vector_i8   : test_abs_abs_a_mul_b_vector_i8_before  ⊑  test_abs_abs_a_mul_b_vector_i8_combined := by
  unfold test_abs_abs_a_mul_b_vector_i8_before test_abs_abs_a_mul_b_vector_i8_combined
  simp_alive_peephole
  sorry
    %1 = llvm.mul %0, %arg1  : vector<2xi8>
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>]

theorem inst_combine_test_abs_abs_a_mul_b_vector_i8   : test_abs_abs_a_mul_b_vector_i8_before  ⊑  test_abs_abs_a_mul_b_vector_i8_combined := by
  unfold test_abs_abs_a_mul_b_vector_i8_before test_abs_abs_a_mul_b_vector_i8_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_test_abs_abs_a_mul_b_vector_i8   : test_abs_abs_a_mul_b_vector_i8_before  ⊑  test_abs_abs_a_mul_b_vector_i8_combined := by
  unfold test_abs_abs_a_mul_b_vector_i8_before test_abs_abs_a_mul_b_vector_i8_combined
  simp_alive_peephole
  sorry
def abs_trailing_zeros_combined := [llvmfunc|
  llvm.func @abs_trailing_zeros(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_trailing_zeros   : abs_trailing_zeros_before  ⊑  abs_trailing_zeros_combined := by
  unfold abs_trailing_zeros_before abs_trailing_zeros_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_abs_trailing_zeros   : abs_trailing_zeros_before  ⊑  abs_trailing_zeros_combined := by
  unfold abs_trailing_zeros_before abs_trailing_zeros_combined
  simp_alive_peephole
  sorry
def abs_trailing_zeros_vec_combined := [llvmfunc|
  llvm.func @abs_trailing_zeros_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-4, -8, -16, -32]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_abs_trailing_zeros_vec   : abs_trailing_zeros_vec_before  ⊑  abs_trailing_zeros_vec_combined := by
  unfold abs_trailing_zeros_vec_before abs_trailing_zeros_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_abs_trailing_zeros_vec   : abs_trailing_zeros_vec_before  ⊑  abs_trailing_zeros_vec_combined := by
  unfold abs_trailing_zeros_vec_before abs_trailing_zeros_vec_combined
  simp_alive_peephole
  sorry
def abs_trailing_zeros_negative_combined := [llvmfunc|
  llvm.func @abs_trailing_zeros_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_trailing_zeros_negative   : abs_trailing_zeros_negative_before  ⊑  abs_trailing_zeros_negative_combined := by
  unfold abs_trailing_zeros_negative_before abs_trailing_zeros_negative_combined
  simp_alive_peephole
  sorry
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_abs_trailing_zeros_negative   : abs_trailing_zeros_negative_before  ⊑  abs_trailing_zeros_negative_combined := by
  unfold abs_trailing_zeros_negative_before abs_trailing_zeros_negative_combined
  simp_alive_peephole
  sorry
def abs_trailing_zeros_negative_vec_combined := [llvmfunc|
  llvm.func @abs_trailing_zeros_negative_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<-4> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.and %arg0, %0  : vector<4xi32>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_abs_trailing_zeros_negative_vec   : abs_trailing_zeros_negative_vec_before  ⊑  abs_trailing_zeros_negative_vec_combined := by
  unfold abs_trailing_zeros_negative_vec_before abs_trailing_zeros_negative_vec_combined
  simp_alive_peephole
  sorry
    %4 = llvm.and %3, %1  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_abs_trailing_zeros_negative_vec   : abs_trailing_zeros_negative_vec_before  ⊑  abs_trailing_zeros_negative_vec_combined := by
  unfold abs_trailing_zeros_negative_vec_before abs_trailing_zeros_negative_vec_combined
  simp_alive_peephole
  sorry
def abs_signbits_combined := [llvmfunc|
  llvm.func @abs_signbits(%arg0: i30) -> i32 {
    %0 = llvm.mlir.constant(1 : i30) : i30
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i30) -> i30]

theorem inst_combine_abs_signbits   : abs_signbits_before  ⊑  abs_signbits_combined := by
  unfold abs_signbits_before abs_signbits_combined
  simp_alive_peephole
  sorry
    %2 = llvm.add %1, %0 overflow<nuw>  : i30
    %3 = llvm.zext %2 : i30 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_abs_signbits   : abs_signbits_before  ⊑  abs_signbits_combined := by
  unfold abs_signbits_before abs_signbits_combined
  simp_alive_peephole
  sorry
def abs_signbits_vec_combined := [llvmfunc|
  llvm.func @abs_signbits_vec(%arg0: vector<4xi30>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i30) : i30
    %1 = llvm.mlir.constant(dense<1> : vector<4xi30>) : vector<4xi30>
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<4xi30>) -> vector<4xi30>]

theorem inst_combine_abs_signbits_vec   : abs_signbits_vec_before  ⊑  abs_signbits_vec_combined := by
  unfold abs_signbits_vec_before abs_signbits_vec_combined
  simp_alive_peephole
  sorry
    %3 = llvm.add %2, %1 overflow<nuw>  : vector<4xi30>
    %4 = llvm.zext %3 : vector<4xi30> to vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_abs_signbits_vec   : abs_signbits_vec_before  ⊑  abs_signbits_vec_combined := by
  unfold abs_signbits_vec_before abs_signbits_vec_combined
  simp_alive_peephole
  sorry
def abs_of_neg_combined := [llvmfunc|
  llvm.func @abs_of_neg(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_of_neg   : abs_of_neg_before  ⊑  abs_of_neg_combined := by
  unfold abs_of_neg_before abs_of_neg_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_of_neg   : abs_of_neg_before  ⊑  abs_of_neg_combined := by
  unfold abs_of_neg_before abs_of_neg_combined
  simp_alive_peephole
  sorry
def abs_of_neg_vec_combined := [llvmfunc|
  llvm.func @abs_of_neg_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_abs_of_neg_vec   : abs_of_neg_vec_before  ⊑  abs_of_neg_vec_combined := by
  unfold abs_of_neg_vec_before abs_of_neg_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_abs_of_neg_vec   : abs_of_neg_vec_before  ⊑  abs_of_neg_vec_combined := by
  unfold abs_of_neg_vec_before abs_of_neg_vec_combined
  simp_alive_peephole
  sorry
def abs_of_select_neg_true_val_combined := [llvmfunc|
  llvm.func @abs_of_select_neg_true_val(%arg0: i1, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_abs_of_select_neg_true_val   : abs_of_select_neg_true_val_before  ⊑  abs_of_select_neg_true_val_combined := by
  unfold abs_of_select_neg_true_val_before abs_of_select_neg_true_val_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_of_select_neg_true_val   : abs_of_select_neg_true_val_before  ⊑  abs_of_select_neg_true_val_combined := by
  unfold abs_of_select_neg_true_val_before abs_of_select_neg_true_val_combined
  simp_alive_peephole
  sorry
def abs_of_select_neg_false_val_combined := [llvmfunc|
  llvm.func @abs_of_select_neg_false_val(%arg0: vector<4xi1>, %arg1: vector<4xi32>) -> vector<4xi32> {
    %0 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = false}> : (vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_abs_of_select_neg_false_val   : abs_of_select_neg_false_val_before  ⊑  abs_of_select_neg_false_val_combined := by
  unfold abs_of_select_neg_false_val_before abs_of_select_neg_false_val_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_abs_of_select_neg_false_val   : abs_of_select_neg_false_val_before  ⊑  abs_of_select_neg_false_val_combined := by
  unfold abs_of_select_neg_false_val_before abs_of_select_neg_false_val_combined
  simp_alive_peephole
  sorry
def abs_dom_cond_nopoison_combined := [llvmfunc|
  llvm.func @abs_dom_cond_nopoison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %arg0 : i32
  ^bb2:  // pred: ^bb0
    %3 = llvm.sub %1, %arg0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_abs_dom_cond_nopoison   : abs_dom_cond_nopoison_before  ⊑  abs_dom_cond_nopoison_combined := by
  unfold abs_dom_cond_nopoison_before abs_dom_cond_nopoison_combined
  simp_alive_peephole
  sorry
def abs_dom_cond_poison_combined := [llvmfunc|
  llvm.func @abs_dom_cond_poison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %arg0 : i32
  ^bb2:  // pred: ^bb0
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_abs_dom_cond_poison   : abs_dom_cond_poison_before  ⊑  abs_dom_cond_poison_combined := by
  unfold abs_dom_cond_poison_before abs_dom_cond_poison_combined
  simp_alive_peephole
  sorry
def zext_abs_combined := [llvmfunc|
  llvm.func @zext_abs(%arg0: i31) -> i32 {
    %0 = llvm.zext %arg0 : i31 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_zext_abs   : zext_abs_before  ⊑  zext_abs_combined := by
  unfold zext_abs_before zext_abs_combined
  simp_alive_peephole
  sorry
def lshr_abs_combined := [llvmfunc|
  llvm.func @lshr_abs(%arg0: vector<3xi82>) -> vector<3xi82> {
    %0 = llvm.mlir.constant(1 : i82) : i82
    %1 = llvm.mlir.constant(dense<1> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.lshr %arg0, %1  : vector<3xi82>
    llvm.return %2 : vector<3xi82>
  }]

theorem inst_combine_lshr_abs   : lshr_abs_before  ⊑  lshr_abs_combined := by
  unfold lshr_abs_before lshr_abs_combined
  simp_alive_peephole
  sorry
def and_abs_combined := [llvmfunc|
  llvm.func @and_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483644 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_and_abs   : and_abs_before  ⊑  and_abs_combined := by
  unfold and_abs_before and_abs_combined
  simp_alive_peephole
  sorry
def select_abs_combined := [llvmfunc|
  llvm.func @select_abs(%arg0: vector<3xi1>) -> vector<3xi82> {
    %0 = llvm.mlir.constant(0 : i82) : i82
    %1 = llvm.mlir.constant(dense<0> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.mlir.constant(1 : i82) : i82
    %3 = llvm.mlir.constant(42 : i82) : i82
    %4 = llvm.mlir.constant(2147483647 : i82) : i82
    %5 = llvm.mlir.constant(dense<[2147483647, 42, 1]> : vector<3xi82>) : vector<3xi82>
    %6 = llvm.select %arg0, %1, %5 : vector<3xi1>, vector<3xi82>
    llvm.return %6 : vector<3xi82>
  }]

theorem inst_combine_select_abs   : select_abs_before  ⊑  select_abs_combined := by
  unfold select_abs_before select_abs_combined
  simp_alive_peephole
  sorry
def assume_abs_combined := [llvmfunc|
  llvm.func @assume_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    llvm.return %arg0 : i32
  }]

theorem inst_combine_assume_abs   : assume_abs_before  ⊑  assume_abs_combined := by
  unfold assume_abs_before assume_abs_combined
  simp_alive_peephole
  sorry
def abs_assume_neg_combined := [llvmfunc|
  llvm.func @abs_assume_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_abs_assume_neg   : abs_assume_neg_before  ⊑  abs_assume_neg_combined := by
  unfold abs_assume_neg_before abs_assume_neg_combined
  simp_alive_peephole
  sorry
def abs_known_neg_combined := [llvmfunc|
  llvm.func @abs_known_neg(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_abs_known_neg   : abs_known_neg_before  ⊑  abs_known_neg_combined := by
  unfold abs_known_neg_before abs_known_neg_combined
  simp_alive_peephole
  sorry
def abs_eq_int_min_poison_combined := [llvmfunc|
  llvm.func @abs_eq_int_min_poison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_abs_eq_int_min_poison   : abs_eq_int_min_poison_before  ⊑  abs_eq_int_min_poison_combined := by
  unfold abs_eq_int_min_poison_before abs_eq_int_min_poison_combined
  simp_alive_peephole
  sorry
def abs_ne_int_min_poison_combined := [llvmfunc|
  llvm.func @abs_ne_int_min_poison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_abs_ne_int_min_poison   : abs_ne_int_min_poison_before  ⊑  abs_ne_int_min_poison_combined := by
  unfold abs_ne_int_min_poison_before abs_ne_int_min_poison_combined
  simp_alive_peephole
  sorry
def abs_eq_int_min_nopoison_combined := [llvmfunc|
  llvm.func @abs_eq_int_min_nopoison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_abs_eq_int_min_nopoison   : abs_eq_int_min_nopoison_before  ⊑  abs_eq_int_min_nopoison_combined := by
  unfold abs_eq_int_min_nopoison_before abs_eq_int_min_nopoison_combined
  simp_alive_peephole
  sorry
def abs_ne_int_min_nopoison_combined := [llvmfunc|
  llvm.func @abs_ne_int_min_nopoison(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_abs_ne_int_min_nopoison   : abs_ne_int_min_nopoison_before  ⊑  abs_ne_int_min_nopoison_combined := by
  unfold abs_ne_int_min_nopoison_before abs_ne_int_min_nopoison_combined
  simp_alive_peephole
  sorry
def abs_sext_combined := [llvmfunc|
  llvm.func @abs_sext(%arg0: i8) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_abs_sext   : abs_sext_before  ⊑  abs_sext_combined := by
  unfold abs_sext_before abs_sext_combined
  simp_alive_peephole
  sorry
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_abs_sext   : abs_sext_before  ⊑  abs_sext_combined := by
  unfold abs_sext_before abs_sext_combined
  simp_alive_peephole
  sorry
def abs_nsw_sext_combined := [llvmfunc|
  llvm.func @abs_nsw_sext(%arg0: vector<3xi7>) -> vector<3xi82> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<3xi7>) -> vector<3xi7>]

theorem inst_combine_abs_nsw_sext   : abs_nsw_sext_before  ⊑  abs_nsw_sext_combined := by
  unfold abs_nsw_sext_before abs_nsw_sext_combined
  simp_alive_peephole
  sorry
    %1 = llvm.zext %0 : vector<3xi7> to vector<3xi82>
    llvm.return %1 : vector<3xi82>
  }]

theorem inst_combine_abs_nsw_sext   : abs_nsw_sext_before  ⊑  abs_nsw_sext_combined := by
  unfold abs_nsw_sext_before abs_nsw_sext_combined
  simp_alive_peephole
  sorry
def abs_sext_extra_use_combined := [llvmfunc|
  llvm.func @abs_sext_extra_use(%arg0: i8, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_abs_sext_extra_use   : abs_sext_extra_use_before  ⊑  abs_sext_extra_use_combined := by
  unfold abs_sext_extra_use_before abs_sext_extra_use_combined
  simp_alive_peephole
  sorry
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_abs_sext_extra_use   : abs_sext_extra_use_before  ⊑  abs_sext_extra_use_combined := by
  unfold abs_sext_extra_use_before abs_sext_extra_use_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_abs_sext_extra_use   : abs_sext_extra_use_before  ⊑  abs_sext_extra_use_combined := by
  unfold abs_sext_extra_use_before abs_sext_extra_use_combined
  simp_alive_peephole
  sorry
def trunc_abs_sext_combined := [llvmfunc|
  llvm.func @trunc_abs_sext(%arg0: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8]

theorem inst_combine_trunc_abs_sext   : trunc_abs_sext_before  ⊑  trunc_abs_sext_combined := by
  unfold trunc_abs_sext_before trunc_abs_sext_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i8
  }]

theorem inst_combine_trunc_abs_sext   : trunc_abs_sext_before  ⊑  trunc_abs_sext_combined := by
  unfold trunc_abs_sext_before trunc_abs_sext_combined
  simp_alive_peephole
  sorry
def trunc_abs_sext_vec_combined := [llvmfunc|
  llvm.func @trunc_abs_sext_vec(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<4xi8>) -> vector<4xi8>]

theorem inst_combine_trunc_abs_sext_vec   : trunc_abs_sext_vec_before  ⊑  trunc_abs_sext_vec_combined := by
  unfold trunc_abs_sext_vec_before trunc_abs_sext_vec_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<4xi8>
  }]

theorem inst_combine_trunc_abs_sext_vec   : trunc_abs_sext_vec_before  ⊑  trunc_abs_sext_vec_combined := by
  unfold trunc_abs_sext_vec_before trunc_abs_sext_vec_combined
  simp_alive_peephole
  sorry
def demand_low_bit_combined := [llvmfunc|
  llvm.func @demand_low_bit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_demand_low_bit   : demand_low_bit_before  ⊑  demand_low_bit_combined := by
  unfold demand_low_bit_before demand_low_bit_combined
  simp_alive_peephole
  sorry
def demand_low_bit_int_min_is_poison_combined := [llvmfunc|
  llvm.func @demand_low_bit_int_min_is_poison(%arg0: vector<3xi82>) -> vector<3xi82> {
    %0 = llvm.mlir.constant(81 : i82) : i82
    %1 = llvm.mlir.constant(dense<81> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.shl %arg0, %1  : vector<3xi82>
    llvm.return %2 : vector<3xi82>
  }]

theorem inst_combine_demand_low_bit_int_min_is_poison   : demand_low_bit_int_min_is_poison_before  ⊑  demand_low_bit_int_min_is_poison_combined := by
  unfold demand_low_bit_int_min_is_poison_before demand_low_bit_int_min_is_poison_combined
  simp_alive_peephole
  sorry
def demand_low_bits_combined := [llvmfunc|
  llvm.func @demand_low_bits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32]

theorem inst_combine_demand_low_bits   : demand_low_bits_before  ⊑  demand_low_bits_combined := by
  unfold demand_low_bits_before demand_low_bits_combined
  simp_alive_peephole
  sorry
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_demand_low_bits   : demand_low_bits_before  ⊑  demand_low_bits_combined := by
  unfold demand_low_bits_before demand_low_bits_combined
  simp_alive_peephole
  sorry
def srem_by_2_int_min_is_poison_combined := [llvmfunc|
  llvm.func @srem_by_2_int_min_is_poison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_srem_by_2_int_min_is_poison   : srem_by_2_int_min_is_poison_before  ⊑  srem_by_2_int_min_is_poison_combined := by
  unfold srem_by_2_int_min_is_poison_before srem_by_2_int_min_is_poison_combined
  simp_alive_peephole
  sorry
def srem_by_2_combined := [llvmfunc|
  llvm.func @srem_by_2(%arg0: vector<3xi82>, %arg1: !llvm.ptr) -> vector<3xi82> {
    %0 = llvm.mlir.constant(2 : i82) : i82
    %1 = llvm.mlir.constant(dense<2> : vector<3xi82>) : vector<3xi82>
    %2 = llvm.mlir.constant(1 : i82) : i82
    %3 = llvm.mlir.constant(dense<1> : vector<3xi82>) : vector<3xi82>
    %4 = llvm.srem %arg0, %1  : vector<3xi82>
    llvm.store %4, %arg1 {alignment = 32 : i64} : vector<3xi82>, !llvm.ptr]

theorem inst_combine_srem_by_2   : srem_by_2_before  ⊑  srem_by_2_combined := by
  unfold srem_by_2_before srem_by_2_combined
  simp_alive_peephole
  sorry
    %5 = llvm.and %arg0, %3  : vector<3xi82>
    llvm.return %5 : vector<3xi82>
  }]

theorem inst_combine_srem_by_2   : srem_by_2_before  ⊑  srem_by_2_combined := by
  unfold srem_by_2_before srem_by_2_combined
  simp_alive_peephole
  sorry
def srem_by_3_combined := [llvmfunc|
  llvm.func @srem_by_3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.srem %arg0, %0  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_srem_by_3   : srem_by_3_before  ⊑  srem_by_3_combined := by
  unfold srem_by_3_before srem_by_3_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_srem_by_3   : srem_by_3_before  ⊑  srem_by_3_combined := by
  unfold srem_by_3_before srem_by_3_combined
  simp_alive_peephole
  sorry
def sub_abs_gt_combined := [llvmfunc|
  llvm.func @sub_abs_gt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_abs_gt   : sub_abs_gt_before  ⊑  sub_abs_gt_combined := by
  unfold sub_abs_gt_before sub_abs_gt_combined
  simp_alive_peephole
  sorry
def sub_abs_sgeT_combined := [llvmfunc|
  llvm.func @sub_abs_sgeT(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_abs_sgeT   : sub_abs_sgeT_before  ⊑  sub_abs_sgeT_combined := by
  unfold sub_abs_sgeT_before sub_abs_sgeT_combined
  simp_alive_peephole
  sorry
def sub_abs_sgeT_swap_combined := [llvmfunc|
  llvm.func @sub_abs_sgeT_swap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %arg0 : i32
    llvm.cond_br %1, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_abs_sgeT_swap   : sub_abs_sgeT_swap_before  ⊑  sub_abs_sgeT_swap_combined := by
  unfold sub_abs_sgeT_swap_before sub_abs_sgeT_swap_combined
  simp_alive_peephole
  sorry
def sub_abs_sgeT_false_combined := [llvmfunc|
  llvm.func @sub_abs_sgeT_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_abs_sgeT_false   : sub_abs_sgeT_false_before  ⊑  sub_abs_sgeT_false_combined := by
  unfold sub_abs_sgeT_false_before sub_abs_sgeT_false_combined
  simp_alive_peephole
  sorry
def sub_abs_lt_combined := [llvmfunc|
  llvm.func @sub_abs_lt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_abs_lt   : sub_abs_lt_before  ⊑  sub_abs_lt_combined := by
  unfold sub_abs_lt_before sub_abs_lt_combined
  simp_alive_peephole
  sorry
def sub_abs_sle_combined := [llvmfunc|
  llvm.func @sub_abs_sle(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_abs_sle   : sub_abs_sle_before  ⊑  sub_abs_sle_combined := by
  unfold sub_abs_sle_before sub_abs_sle_combined
  simp_alive_peephole
  sorry
def sub_abs_sleF_combined := [llvmfunc|
  llvm.func @sub_abs_sleF(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.cond_br %1, ^bb2(%0 : i8), ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg1, %arg0  : i8
    llvm.br ^bb2(%2 : i8)
  ^bb2(%3: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_abs_sleF   : sub_abs_sleF_before  ⊑  sub_abs_sleF_combined := by
  unfold sub_abs_sleF_before sub_abs_sleF_combined
  simp_alive_peephole
  sorry
def sub_abs_sleT_combined := [llvmfunc|
  llvm.func @sub_abs_sleT(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.cond_br %1, ^bb2(%0 : i8), ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.br ^bb2(%2 : i8)
  ^bb2(%3: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_abs_sleT   : sub_abs_sleT_before  ⊑  sub_abs_sleT_combined := by
  unfold sub_abs_sleT_before sub_abs_sleT_combined
  simp_alive_peephole
  sorry
def sub_abs_lt_min_not_poison_combined := [llvmfunc|
  llvm.func @sub_abs_lt_min_not_poison(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg1, %arg0  : i32
    llvm.br ^bb2(%2 : i32)
  ^bb2(%3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }]

theorem inst_combine_sub_abs_lt_min_not_poison   : sub_abs_lt_min_not_poison_before  ⊑  sub_abs_lt_min_not_poison_combined := by
  unfold sub_abs_lt_min_not_poison_before sub_abs_lt_min_not_poison_combined
  simp_alive_peephole
  sorry
def sub_abs_wrong_pred_combined := [llvmfunc|
  llvm.func @sub_abs_wrong_pred(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_sub_abs_wrong_pred   : sub_abs_wrong_pred_before  ⊑  sub_abs_wrong_pred_combined := by
  unfold sub_abs_wrong_pred_before sub_abs_wrong_pred_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

theorem inst_combine_sub_abs_wrong_pred   : sub_abs_wrong_pred_before  ⊑  sub_abs_wrong_pred_combined := by
  unfold sub_abs_wrong_pred_before sub_abs_wrong_pred_combined
  simp_alive_peephole
  sorry
def sub_abs_no_nsw_combined := [llvmfunc|
  llvm.func @sub_abs_no_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i32) -> i32]

theorem inst_combine_sub_abs_no_nsw   : sub_abs_no_nsw_before  ⊑  sub_abs_no_nsw_combined := by
  unfold sub_abs_no_nsw_before sub_abs_no_nsw_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

theorem inst_combine_sub_abs_no_nsw   : sub_abs_no_nsw_before  ⊑  sub_abs_no_nsw_combined := by
  unfold sub_abs_no_nsw_before sub_abs_no_nsw_combined
  simp_alive_peephole
  sorry
