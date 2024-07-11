import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-sub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_nuw_and_unsigned_pred_before := [llvmfunc|
  llvm.func @test_nuw_and_unsigned_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

def test_nsw_and_signed_pred_before := [llvmfunc|
  llvm.func @test_nsw_and_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    llvm.return %3 : i1
  }]

def test_nuw_nsw_and_unsigned_pred_before := [llvmfunc|
  llvm.func @test_nuw_nsw_and_unsigned_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw, nuw>  : i64
    %3 = llvm.icmp "ule" %2, %1 : i64
    llvm.return %3 : i1
  }]

def test_nuw_nsw_and_signed_pred_before := [llvmfunc|
  llvm.func @test_nuw_nsw_and_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw, nuw>  : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }]

def test_negative_nuw_and_signed_pred_before := [llvmfunc|
  llvm.func @test_negative_nuw_and_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }]

def test_negative_nsw_and_unsigned_pred_before := [llvmfunc|
  llvm.func @test_negative_nsw_and_unsigned_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

def test_negative_combined_sub_unsigned_overflow_before := [llvmfunc|
  llvm.func @test_negative_combined_sub_unsigned_overflow(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(11 : i64) : i64
    %2 = llvm.sub %0, %arg0 overflow<nuw>  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

def test_negative_combined_sub_signed_overflow_before := [llvmfunc|
  llvm.func @test_negative_combined_sub_signed_overflow(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def test_sub_0_Y_eq_0_before := [llvmfunc|
  llvm.func @test_sub_0_Y_eq_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def test_sub_0_Y_ne_0_before := [llvmfunc|
  llvm.func @test_sub_0_Y_ne_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def test_sub_4_Y_ne_4_before := [llvmfunc|
  llvm.func @test_sub_4_Y_ne_4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def test_sub_127_Y_eq_127_before := [llvmfunc|
  llvm.func @test_sub_127_Y_eq_127(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def test_sub_255_Y_eq_255_before := [llvmfunc|
  llvm.func @test_sub_255_Y_eq_255(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def test_sub_255_Y_eq_255_vec_before := [llvmfunc|
  llvm.func @test_sub_255_Y_eq_255_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg0  : vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def icmp_eq_sub_undef_before := [llvmfunc|
  llvm.func @icmp_eq_sub_undef(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.sub %6, %arg0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }]

def icmp_eq_sub_non_splat_before := [llvmfunc|
  llvm.func @icmp_eq_sub_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[15, 16]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_eq_sub_undef2_before := [llvmfunc|
  llvm.func @icmp_eq_sub_undef2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.sub %0, %arg0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }]

def icmp_eq_sub_non_splat2_before := [llvmfunc|
  llvm.func @icmp_eq_sub_non_splat2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 11]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def neg_sgt_42_before := [llvmfunc|
  llvm.func @neg_sgt_42(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def neg_eq_43_before := [llvmfunc|
  llvm.func @neg_eq_43(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def neg_ne_44_before := [llvmfunc|
  llvm.func @neg_ne_44(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(44 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def neg_nsw_eq_45_before := [llvmfunc|
  llvm.func @neg_nsw_eq_45(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(45 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def neg_nsw_ne_46_before := [llvmfunc|
  llvm.func @neg_nsw_ne_46(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(46 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def subC_eq_before := [llvmfunc|
  llvm.func @subC_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(43 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def subC_ne_before := [llvmfunc|
  llvm.func @subC_ne(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-6, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-44> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %0, %arg0  : vector<2xi8>
    llvm.call @use_vec(%2) : (vector<2xi8>) -> ()
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def subC_nsw_eq_before := [llvmfunc|
  llvm.func @subC_nsw_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-100 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def subC_nsw_ne_before := [llvmfunc|
  llvm.func @subC_nsw_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(46 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def neg_slt_42_before := [llvmfunc|
  llvm.func @neg_slt_42(%arg0: i128) -> i1 {
    %0 = llvm.mlir.constant(0 : i128) : i128
    %1 = llvm.mlir.constant(42 : i128) : i128
    %2 = llvm.sub %0, %arg0  : i128
    %3 = llvm.icmp "slt" %2, %1 : i128
    llvm.return %3 : i1
  }]

def neg_ugt_42_splat_before := [llvmfunc|
  llvm.func @neg_ugt_42_splat(%arg0: vector<2xi7>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i7) : i7
    %1 = llvm.mlir.constant(dense<0> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(42 : i7) : i7
    %3 = llvm.mlir.constant(dense<42> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.sub %1, %arg0  : vector<2xi7>
    %5 = llvm.icmp "ugt" %4, %3 : vector<2xi7>
    llvm.return %5 : vector<2xi1>
  }]

def neg_sgt_42_use_before := [llvmfunc|
  llvm.func @neg_sgt_42_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def neg_slt_n1_before := [llvmfunc|
  llvm.func @neg_slt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def neg_slt_0_before := [llvmfunc|
  llvm.func @neg_slt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def neg_slt_1_before := [llvmfunc|
  llvm.func @neg_slt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def neg_sgt_n1_before := [llvmfunc|
  llvm.func @neg_sgt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def neg_sgt_0_before := [llvmfunc|
  llvm.func @neg_sgt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def neg_sgt_1_before := [llvmfunc|
  llvm.func @neg_sgt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def neg_nsw_slt_n1_before := [llvmfunc|
  llvm.func @neg_nsw_slt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def neg_nsw_slt_0_before := [llvmfunc|
  llvm.func @neg_nsw_slt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def neg_nsw_slt_1_before := [llvmfunc|
  llvm.func @neg_nsw_slt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def neg_nsw_sgt_n1_before := [llvmfunc|
  llvm.func @neg_nsw_sgt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def neg_nsw_sgt_0_before := [llvmfunc|
  llvm.func @neg_nsw_sgt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def neg_nsw_sgt_1_before := [llvmfunc|
  llvm.func @neg_nsw_sgt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sub_eq_zero_use_before := [llvmfunc|
  llvm.func @sub_eq_zero_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def sub_ne_zero_use_before := [llvmfunc|
  llvm.func @sub_ne_zero_use(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1  : vector<2xi8>
    llvm.call @use_vec(%2) : (vector<2xi8>) -> ()
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def sub_eq_zero_select_before := [llvmfunc|
  llvm.func @sub_eq_zero_select(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.icmp "eq" %1, %0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def PR54558_reduced_before := [llvmfunc|
  llvm.func @PR54558_reduced(%arg0: i32) {
    %0 = llvm.mlir.constant(43 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%arg0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.intr.umin(%2, %0)  : (i32, i32) -> i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb2, ^bb1(%4 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def PR54558_reduced_more_before := [llvmfunc|
  llvm.func @PR54558_reduced_more(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%arg0 : i32)
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.sub %1, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.cond_br %3, ^bb2, ^bb1(%2 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def PR60818_ne_before := [llvmfunc|
  llvm.func @PR60818_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "ne" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def PR60818_eq_before := [llvmfunc|
  llvm.func @PR60818_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def PR60818_eq_commuted_before := [llvmfunc|
  llvm.func @PR60818_eq_commuted(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(43 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }]

def PR60818_ne_vector_before := [llvmfunc|
  llvm.func @PR60818_ne_vector(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ne" %arg0, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def PR60818_eq_multi_use_before := [llvmfunc|
  llvm.func @PR60818_eq_multi_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def PR60818_sgt_before := [llvmfunc|
  llvm.func @PR60818_sgt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

def test_nuw_and_unsigned_pred_combined := [llvmfunc|
  llvm.func @test_nuw_and_unsigned_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_test_nuw_and_unsigned_pred   : test_nuw_and_unsigned_pred_before  ⊑  test_nuw_and_unsigned_pred_combined := by
  unfold test_nuw_and_unsigned_pred_before test_nuw_and_unsigned_pred_combined
  simp_alive_peephole
  sorry
def test_nsw_and_signed_pred_combined := [llvmfunc|
  llvm.func @test_nsw_and_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-7 : i64) : i64
    %1 = llvm.icmp "slt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_test_nsw_and_signed_pred   : test_nsw_and_signed_pred_before  ⊑  test_nsw_and_signed_pred_combined := by
  unfold test_nsw_and_signed_pred_before test_nsw_and_signed_pred_combined
  simp_alive_peephole
  sorry
def test_nuw_nsw_and_unsigned_pred_combined := [llvmfunc|
  llvm.func @test_nuw_nsw_and_unsigned_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_test_nuw_nsw_and_unsigned_pred   : test_nuw_nsw_and_unsigned_pred_before  ⊑  test_nuw_nsw_and_unsigned_pred_combined := by
  unfold test_nuw_nsw_and_unsigned_pred_before test_nuw_nsw_and_unsigned_pred_combined
  simp_alive_peephole
  sorry
def test_nuw_nsw_and_signed_pred_combined := [llvmfunc|
  llvm.func @test_nuw_nsw_and_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.icmp "sgt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_test_nuw_nsw_and_signed_pred   : test_nuw_nsw_and_signed_pred_before  ⊑  test_nuw_nsw_and_signed_pred_combined := by
  unfold test_nuw_nsw_and_signed_pred_before test_nuw_nsw_and_signed_pred_combined
  simp_alive_peephole
  sorry
def test_negative_nuw_and_signed_pred_combined := [llvmfunc|
  llvm.func @test_negative_nuw_and_signed_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-11 : i64) : i64
    %1 = llvm.mlir.constant(-4 : i64) : i64
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i64
    %3 = llvm.icmp "sgt" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_test_negative_nuw_and_signed_pred   : test_negative_nuw_and_signed_pred_before  ⊑  test_negative_nuw_and_signed_pred_combined := by
  unfold test_negative_nuw_and_signed_pred_before test_negative_nuw_and_signed_pred_combined
  simp_alive_peephole
  sorry
def test_negative_nsw_and_unsigned_pred_combined := [llvmfunc|
  llvm.func @test_negative_nsw_and_unsigned_pred(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-8 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_test_negative_nsw_and_unsigned_pred   : test_negative_nsw_and_unsigned_pred_before  ⊑  test_negative_nsw_and_unsigned_pred_combined := by
  unfold test_negative_nsw_and_unsigned_pred_before test_negative_nsw_and_unsigned_pred_combined
  simp_alive_peephole
  sorry
def test_negative_combined_sub_unsigned_overflow_combined := [llvmfunc|
  llvm.func @test_negative_combined_sub_unsigned_overflow(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_negative_combined_sub_unsigned_overflow   : test_negative_combined_sub_unsigned_overflow_before  ⊑  test_negative_combined_sub_unsigned_overflow_combined := by
  unfold test_negative_combined_sub_unsigned_overflow_before test_negative_combined_sub_unsigned_overflow_combined
  simp_alive_peephole
  sorry
def test_negative_combined_sub_signed_overflow_combined := [llvmfunc|
  llvm.func @test_negative_combined_sub_signed_overflow(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_negative_combined_sub_signed_overflow   : test_negative_combined_sub_signed_overflow_before  ⊑  test_negative_combined_sub_signed_overflow_combined := by
  unfold test_negative_combined_sub_signed_overflow_before test_negative_combined_sub_signed_overflow_combined
  simp_alive_peephole
  sorry
def test_sub_0_Y_eq_0_combined := [llvmfunc|
  llvm.func @test_sub_0_Y_eq_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_sub_0_Y_eq_0   : test_sub_0_Y_eq_0_before  ⊑  test_sub_0_Y_eq_0_combined := by
  unfold test_sub_0_Y_eq_0_before test_sub_0_Y_eq_0_combined
  simp_alive_peephole
  sorry
def test_sub_0_Y_ne_0_combined := [llvmfunc|
  llvm.func @test_sub_0_Y_ne_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_sub_0_Y_ne_0   : test_sub_0_Y_ne_0_before  ⊑  test_sub_0_Y_ne_0_combined := by
  unfold test_sub_0_Y_ne_0_before test_sub_0_Y_ne_0_combined
  simp_alive_peephole
  sorry
def test_sub_4_Y_ne_4_combined := [llvmfunc|
  llvm.func @test_sub_4_Y_ne_4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_sub_4_Y_ne_4   : test_sub_4_Y_ne_4_before  ⊑  test_sub_4_Y_ne_4_combined := by
  unfold test_sub_4_Y_ne_4_before test_sub_4_Y_ne_4_combined
  simp_alive_peephole
  sorry
def test_sub_127_Y_eq_127_combined := [llvmfunc|
  llvm.func @test_sub_127_Y_eq_127(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_sub_127_Y_eq_127   : test_sub_127_Y_eq_127_before  ⊑  test_sub_127_Y_eq_127_combined := by
  unfold test_sub_127_Y_eq_127_before test_sub_127_Y_eq_127_combined
  simp_alive_peephole
  sorry
def test_sub_255_Y_eq_255_combined := [llvmfunc|
  llvm.func @test_sub_255_Y_eq_255(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test_sub_255_Y_eq_255   : test_sub_255_Y_eq_255_before  ⊑  test_sub_255_Y_eq_255_combined := by
  unfold test_sub_255_Y_eq_255_before test_sub_255_Y_eq_255_combined
  simp_alive_peephole
  sorry
def test_sub_255_Y_eq_255_vec_combined := [llvmfunc|
  llvm.func @test_sub_255_Y_eq_255_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_test_sub_255_Y_eq_255_vec   : test_sub_255_Y_eq_255_vec_before  ⊑  test_sub_255_Y_eq_255_vec_combined := by
  unfold test_sub_255_Y_eq_255_vec_before test_sub_255_Y_eq_255_vec_combined
  simp_alive_peephole
  sorry
def icmp_eq_sub_undef_combined := [llvmfunc|
  llvm.func @icmp_eq_sub_undef(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi32>
    llvm.return %7 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_sub_undef   : icmp_eq_sub_undef_before  ⊑  icmp_eq_sub_undef_combined := by
  unfold icmp_eq_sub_undef_before icmp_eq_sub_undef_combined
  simp_alive_peephole
  sorry
def icmp_eq_sub_non_splat_combined := [llvmfunc|
  llvm.func @icmp_eq_sub_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_sub_non_splat   : icmp_eq_sub_non_splat_before  ⊑  icmp_eq_sub_non_splat_combined := by
  unfold icmp_eq_sub_non_splat_before icmp_eq_sub_non_splat_combined
  simp_alive_peephole
  sorry
def icmp_eq_sub_undef2_combined := [llvmfunc|
  llvm.func @icmp_eq_sub_undef2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.sub %0, %arg0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_sub_undef2   : icmp_eq_sub_undef2_before  ⊑  icmp_eq_sub_undef2_combined := by
  unfold icmp_eq_sub_undef2_before icmp_eq_sub_undef2_combined
  simp_alive_peephole
  sorry
def icmp_eq_sub_non_splat2_combined := [llvmfunc|
  llvm.func @icmp_eq_sub_non_splat2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 11]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_sub_non_splat2   : icmp_eq_sub_non_splat2_before  ⊑  icmp_eq_sub_non_splat2_combined := by
  unfold icmp_eq_sub_non_splat2_before icmp_eq_sub_non_splat2_combined
  simp_alive_peephole
  sorry
def neg_sgt_42_combined := [llvmfunc|
  llvm.func @neg_sgt_42(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-43 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_sgt_42   : neg_sgt_42_before  ⊑  neg_sgt_42_combined := by
  unfold neg_sgt_42_before neg_sgt_42_combined
  simp_alive_peephole
  sorry
def neg_eq_43_combined := [llvmfunc|
  llvm.func @neg_eq_43(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-43 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_eq_43   : neg_eq_43_before  ⊑  neg_eq_43_combined := by
  unfold neg_eq_43_before neg_eq_43_combined
  simp_alive_peephole
  sorry
def neg_ne_44_combined := [llvmfunc|
  llvm.func @neg_ne_44(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-44 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_ne_44   : neg_ne_44_before  ⊑  neg_ne_44_combined := by
  unfold neg_ne_44_before neg_ne_44_combined
  simp_alive_peephole
  sorry
def neg_nsw_eq_45_combined := [llvmfunc|
  llvm.func @neg_nsw_eq_45(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-45 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_nsw_eq_45   : neg_nsw_eq_45_before  ⊑  neg_nsw_eq_45_combined := by
  unfold neg_nsw_eq_45_before neg_nsw_eq_45_combined
  simp_alive_peephole
  sorry
def neg_nsw_ne_46_combined := [llvmfunc|
  llvm.func @neg_nsw_ne_46(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-46 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_nsw_ne_46   : neg_nsw_ne_46_before  ⊑  neg_nsw_ne_46_combined := by
  unfold neg_nsw_ne_46_before neg_nsw_ne_46_combined
  simp_alive_peephole
  sorry
def subC_eq_combined := [llvmfunc|
  llvm.func @subC_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2147483605 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_subC_eq   : subC_eq_before  ⊑  subC_eq_combined := by
  unfold subC_eq_before subC_eq_combined
  simp_alive_peephole
  sorry
def subC_ne_combined := [llvmfunc|
  llvm.func @subC_ne(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-6, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[38, -84]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %0, %arg0  : vector<2xi8>
    llvm.call @use_vec(%2) : (vector<2xi8>) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_subC_ne   : subC_ne_before  ⊑  subC_ne_combined := by
  unfold subC_ne_before subC_ne_combined
  simp_alive_peephole
  sorry
def subC_nsw_eq_combined := [llvmfunc|
  llvm.func @subC_nsw_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-100 : i32) : i32
    %1 = llvm.mlir.constant(2147483548 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_subC_nsw_eq   : subC_nsw_eq_before  ⊑  subC_nsw_eq_combined := by
  unfold subC_nsw_eq_before subC_nsw_eq_combined
  simp_alive_peephole
  sorry
def subC_nsw_ne_combined := [llvmfunc|
  llvm.func @subC_nsw_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483647 : i32) : i32
    %1 = llvm.mlir.constant(2147483603 : i32) : i32
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_subC_nsw_ne   : subC_nsw_ne_before  ⊑  subC_nsw_ne_combined := by
  unfold subC_nsw_ne_before subC_nsw_ne_combined
  simp_alive_peephole
  sorry
def neg_slt_42_combined := [llvmfunc|
  llvm.func @neg_slt_42(%arg0: i128) -> i1 {
    %0 = llvm.mlir.constant(-1 : i128) : i128
    %1 = llvm.mlir.constant(-43 : i128) : i128
    %2 = llvm.add %arg0, %0  : i128
    %3 = llvm.icmp "sgt" %2, %1 : i128
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_slt_42   : neg_slt_42_before  ⊑  neg_slt_42_combined := by
  unfold neg_slt_42_before neg_slt_42_combined
  simp_alive_peephole
  sorry
def neg_ugt_42_splat_combined := [llvmfunc|
  llvm.func @neg_ugt_42_splat(%arg0: vector<2xi7>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i7) : i7
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(-43 : i7) : i7
    %3 = llvm.mlir.constant(dense<-43> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.add %arg0, %1  : vector<2xi7>
    %5 = llvm.icmp "ult" %4, %3 : vector<2xi7>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_neg_ugt_42_splat   : neg_ugt_42_splat_before  ⊑  neg_ugt_42_splat_combined := by
  unfold neg_ugt_42_splat_before neg_ugt_42_splat_combined
  simp_alive_peephole
  sorry
def neg_sgt_42_use_combined := [llvmfunc|
  llvm.func @neg_sgt_42_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_sgt_42_use   : neg_sgt_42_use_before  ⊑  neg_sgt_42_use_combined := by
  unfold neg_sgt_42_use_before neg_sgt_42_use_combined
  simp_alive_peephole
  sorry
def neg_slt_n1_combined := [llvmfunc|
  llvm.func @neg_slt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_slt_n1   : neg_slt_n1_before  ⊑  neg_slt_n1_combined := by
  unfold neg_slt_n1_before neg_slt_n1_combined
  simp_alive_peephole
  sorry
def neg_slt_0_combined := [llvmfunc|
  llvm.func @neg_slt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_neg_slt_0   : neg_slt_0_before  ⊑  neg_slt_0_combined := by
  unfold neg_slt_0_before neg_slt_0_combined
  simp_alive_peephole
  sorry
def neg_slt_1_combined := [llvmfunc|
  llvm.func @neg_slt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_neg_slt_1   : neg_slt_1_before  ⊑  neg_slt_1_combined := by
  unfold neg_slt_1_before neg_slt_1_combined
  simp_alive_peephole
  sorry
def neg_sgt_n1_combined := [llvmfunc|
  llvm.func @neg_sgt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_sgt_n1   : neg_sgt_n1_before  ⊑  neg_sgt_n1_combined := by
  unfold neg_sgt_n1_before neg_sgt_n1_combined
  simp_alive_peephole
  sorry
def neg_sgt_0_combined := [llvmfunc|
  llvm.func @neg_sgt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_neg_sgt_0   : neg_sgt_0_before  ⊑  neg_sgt_0_combined := by
  unfold neg_sgt_0_before neg_sgt_0_combined
  simp_alive_peephole
  sorry
def neg_sgt_1_combined := [llvmfunc|
  llvm.func @neg_sgt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_neg_sgt_1   : neg_sgt_1_before  ⊑  neg_sgt_1_combined := by
  unfold neg_sgt_1_before neg_sgt_1_combined
  simp_alive_peephole
  sorry
def neg_nsw_slt_n1_combined := [llvmfunc|
  llvm.func @neg_nsw_slt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_neg_nsw_slt_n1   : neg_nsw_slt_n1_before  ⊑  neg_nsw_slt_n1_combined := by
  unfold neg_nsw_slt_n1_before neg_nsw_slt_n1_combined
  simp_alive_peephole
  sorry
def neg_nsw_slt_0_combined := [llvmfunc|
  llvm.func @neg_nsw_slt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_neg_nsw_slt_0   : neg_nsw_slt_0_before  ⊑  neg_nsw_slt_0_combined := by
  unfold neg_nsw_slt_0_before neg_nsw_slt_0_combined
  simp_alive_peephole
  sorry
def neg_nsw_slt_1_combined := [llvmfunc|
  llvm.func @neg_nsw_slt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_neg_nsw_slt_1   : neg_nsw_slt_1_before  ⊑  neg_nsw_slt_1_combined := by
  unfold neg_nsw_slt_1_before neg_nsw_slt_1_combined
  simp_alive_peephole
  sorry
def neg_nsw_sgt_n1_combined := [llvmfunc|
  llvm.func @neg_nsw_sgt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_neg_nsw_sgt_n1   : neg_nsw_sgt_n1_before  ⊑  neg_nsw_sgt_n1_combined := by
  unfold neg_nsw_sgt_n1_before neg_nsw_sgt_n1_combined
  simp_alive_peephole
  sorry
def neg_nsw_sgt_0_combined := [llvmfunc|
  llvm.func @neg_nsw_sgt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_neg_nsw_sgt_0   : neg_nsw_sgt_0_before  ⊑  neg_nsw_sgt_0_combined := by
  unfold neg_nsw_sgt_0_before neg_nsw_sgt_0_combined
  simp_alive_peephole
  sorry
def neg_nsw_sgt_1_combined := [llvmfunc|
  llvm.func @neg_nsw_sgt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_neg_nsw_sgt_1   : neg_nsw_sgt_1_before  ⊑  neg_nsw_sgt_1_combined := by
  unfold neg_nsw_sgt_1_before neg_nsw_sgt_1_combined
  simp_alive_peephole
  sorry
def sub_eq_zero_use_combined := [llvmfunc|
  llvm.func @sub_eq_zero_use(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_sub_eq_zero_use   : sub_eq_zero_use_before  ⊑  sub_eq_zero_use_combined := by
  unfold sub_eq_zero_use_before sub_eq_zero_use_combined
  simp_alive_peephole
  sorry
def sub_ne_zero_use_combined := [llvmfunc|
  llvm.func @sub_ne_zero_use(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sub %arg0, %arg1  : vector<2xi8>
    llvm.call @use_vec(%0) : (vector<2xi8>) -> ()
    %1 = llvm.icmp "eq" %arg0, %arg1 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sub_ne_zero_use   : sub_ne_zero_use_before  ⊑  sub_ne_zero_use_combined := by
  unfold sub_ne_zero_use_before sub_ne_zero_use_combined
  simp_alive_peephole
  sorry
def sub_eq_zero_select_combined := [llvmfunc|
  llvm.func @sub_eq_zero_select(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i32 {
    %0 = llvm.sub %arg0, %arg1  : i32
    llvm.store %0, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %arg1 : i32
  }]

theorem inst_combine_sub_eq_zero_select   : sub_eq_zero_select_before  ⊑  sub_eq_zero_select_combined := by
  unfold sub_eq_zero_select_before sub_eq_zero_select_combined
  simp_alive_peephole
  sorry
def PR54558_reduced_combined := [llvmfunc|
  llvm.func @PR54558_reduced(%arg0: i32) {
    %0 = llvm.mlir.constant(43 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%arg0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.intr.umin(%2, %0)  : (i32, i32) -> i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.sub %2, %3  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.cond_br %5, ^bb2, ^bb1(%4 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_PR54558_reduced   : PR54558_reduced_before  ⊑  PR54558_reduced_combined := by
  unfold PR54558_reduced_before PR54558_reduced_combined
  simp_alive_peephole
  sorry
def PR54558_reduced_more_combined := [llvmfunc|
  llvm.func @PR54558_reduced_more(%arg0: i32, %arg1: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%arg0 : i32)
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.sub %1, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.cond_br %3, ^bb2, ^bb1(%2 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_PR54558_reduced_more   : PR54558_reduced_more_before  ⊑  PR54558_reduced_more_combined := by
  unfold PR54558_reduced_more_before PR54558_reduced_more_combined
  simp_alive_peephole
  sorry
def PR60818_ne_combined := [llvmfunc|
  llvm.func @PR60818_ne(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR60818_ne   : PR60818_ne_before  ⊑  PR60818_ne_combined := by
  unfold PR60818_ne_before PR60818_ne_combined
  simp_alive_peephole
  sorry
def PR60818_eq_combined := [llvmfunc|
  llvm.func @PR60818_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_PR60818_eq   : PR60818_eq_before  ⊑  PR60818_eq_combined := by
  unfold PR60818_eq_before PR60818_eq_combined
  simp_alive_peephole
  sorry
def PR60818_eq_commuted_combined := [llvmfunc|
  llvm.func @PR60818_eq_commuted(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(43 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mul %arg0, %0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_PR60818_eq_commuted   : PR60818_eq_commuted_before  ⊑  PR60818_eq_commuted_combined := by
  unfold PR60818_eq_commuted_before PR60818_eq_commuted_combined
  simp_alive_peephole
  sorry
def PR60818_ne_vector_combined := [llvmfunc|
  llvm.func @PR60818_ne_vector(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2147483647> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_PR60818_ne_vector   : PR60818_ne_vector_before  ⊑  PR60818_ne_vector_combined := by
  unfold PR60818_ne_vector_before PR60818_ne_vector_combined
  simp_alive_peephole
  sorry
def PR60818_eq_multi_use_combined := [llvmfunc|
  llvm.func @PR60818_eq_multi_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_PR60818_eq_multi_use   : PR60818_eq_multi_use_before  ⊑  PR60818_eq_multi_use_combined := by
  unfold PR60818_eq_multi_use_before PR60818_eq_multi_use_combined
  simp_alive_peephole
  sorry
def PR60818_sgt_combined := [llvmfunc|
  llvm.func @PR60818_sgt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "sgt" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_PR60818_sgt   : PR60818_sgt_before  ⊑  PR60818_sgt_combined := by
  unfold PR60818_sgt_before PR60818_sgt_combined
  simp_alive_peephole
  sorry
