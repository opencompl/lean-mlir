import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  abs-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_abs_before := [llvmfunc|
  llvm.func @test_abs(%arg0: i32) -> i32 {
    %0 = llvm.call @abs(%arg0) : (i32) -> i32
    llvm.return %0 : i32
  }]

def test_labs_before := [llvmfunc|
  llvm.func @test_labs(%arg0: i64) -> i64 {
    %0 = llvm.call @labs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }]

def test_llabs_before := [llvmfunc|
  llvm.func @test_llabs(%arg0: i64) -> i64 {
    %0 = llvm.call @llabs(%arg0) : (i64) -> i64
    llvm.return %0 : i64
  }]

def abs_canonical_1_before := [llvmfunc|
  llvm.func @abs_canonical_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }]

def abs_canonical_2_before := [llvmfunc|
  llvm.func @abs_canonical_2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    %4 = llvm.sub %2, %arg0  : vector<2xi8>
    %5 = llvm.select %3, %arg0, %4 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def abs_canonical_2_vec_poison_elts_before := [llvmfunc|
  llvm.func @abs_canonical_2_vec_poison_elts(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.icmp "sgt" %arg0, %6 : vector<2xi8>
    %10 = llvm.sub %8, %arg0  : vector<2xi8>
    %11 = llvm.select %9, %arg0, %10 : vector<2xi1>, vector<2xi8>
    llvm.return %11 : vector<2xi8>
  }]

def abs_canonical_3_before := [llvmfunc|
  llvm.func @abs_canonical_3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

def abs_canonical_4_before := [llvmfunc|
  llvm.func @abs_canonical_4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.sub %1, %arg0  : i8
    %4 = llvm.select %2, %3, %arg0 : i1, i8
    llvm.return %4 : i8
  }]

def abs_canonical_5_before := [llvmfunc|
  llvm.func @abs_canonical_5(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.sext %arg0 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.select %2, %3, %4 : i1, i32
    llvm.return %5 : i32
  }]

def abs_canonical_6_before := [llvmfunc|
  llvm.func @abs_canonical_6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.select %2, %1, %3 : i1, i32
    llvm.return %4 : i32
  }]

def abs_canonical_7_before := [llvmfunc|
  llvm.func @abs_canonical_7(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi8>
    %3 = llvm.sub %arg1, %arg0  : vector<2xi8>
    %4 = llvm.select %2, %1, %3 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def abs_canonical_8_before := [llvmfunc|
  llvm.func @abs_canonical_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def abs_canonical_9_before := [llvmfunc|
  llvm.func @abs_canonical_9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.select %2, %1, %3 : i1, i32
    %5 = llvm.add %4, %3  : i32
    llvm.return %5 : i32
  }]

def abs_canonical_10_before := [llvmfunc|
  llvm.func @abs_canonical_10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.icmp "sgt" %2, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def nabs_canonical_1_before := [llvmfunc|
  llvm.func @nabs_canonical_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

def nabs_canonical_2_before := [llvmfunc|
  llvm.func @nabs_canonical_2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    %4 = llvm.sub %2, %arg0  : vector<2xi8>
    %5 = llvm.select %3, %4, %arg0 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def nabs_canonical_2_vec_poison_elts_before := [llvmfunc|
  llvm.func @nabs_canonical_2_vec_poison_elts(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.icmp "sgt" %arg0, %6 : vector<2xi8>
    %10 = llvm.sub %8, %arg0  : vector<2xi8>
    %11 = llvm.select %9, %10, %arg0 : vector<2xi1>, vector<2xi8>
    llvm.return %11 : vector<2xi8>
  }]

def nabs_canonical_3_before := [llvmfunc|
  llvm.func @nabs_canonical_3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }]

def nabs_canonical_4_before := [llvmfunc|
  llvm.func @nabs_canonical_4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.sub %1, %arg0  : i8
    %4 = llvm.select %2, %arg0, %3 : i1, i8
    llvm.return %4 : i8
  }]

def nabs_canonical_5_before := [llvmfunc|
  llvm.func @nabs_canonical_5(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.sext %arg0 : i8 to i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.select %2, %4, %3 : i1, i32
    llvm.return %5 : i32
  }]

def nabs_canonical_6_before := [llvmfunc|
  llvm.func @nabs_canonical_6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    llvm.return %4 : i32
  }]

def nabs_canonical_7_before := [llvmfunc|
  llvm.func @nabs_canonical_7(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi8>
    %3 = llvm.sub %arg1, %arg0  : vector<2xi8>
    %4 = llvm.select %2, %3, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def nabs_canonical_8_before := [llvmfunc|
  llvm.func @nabs_canonical_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    llvm.return %3 : i32
  }]

def nabs_canonical_9_before := [llvmfunc|
  llvm.func @nabs_canonical_9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.sub %arg1, %arg0  : i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    %5 = llvm.add %3, %4  : i32
    llvm.return %5 : i32
  }]

def nabs_canonical_10_before := [llvmfunc|
  llvm.func @nabs_canonical_10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.icmp "slt" %2, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def shifty_abs_commute0_before := [llvmfunc|
  llvm.func @shifty_abs_commute0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def shifty_abs_commute0_nsw_before := [llvmfunc|
  llvm.func @shifty_abs_commute0_nsw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.add %1, %arg0 overflow<nsw>  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def shifty_abs_commute0_nuw_before := [llvmfunc|
  llvm.func @shifty_abs_commute0_nuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.add %1, %arg0 overflow<nuw>  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.return %3 : i8
  }]

def shifty_abs_commute1_before := [llvmfunc|
  llvm.func @shifty_abs_commute1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    %2 = llvm.add %1, %arg0  : vector<2xi8>
    %3 = llvm.xor %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def shifty_abs_commute2_before := [llvmfunc|
  llvm.func @shifty_abs_commute2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0  : vector<2xi8>
    %3 = llvm.ashr %2, %1  : vector<2xi8>
    %4 = llvm.add %2, %3  : vector<2xi8>
    %5 = llvm.xor %3, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def shifty_abs_commute3_before := [llvmfunc|
  llvm.func @shifty_abs_commute3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    %4 = llvm.add %2, %3  : i8
    %5 = llvm.xor %4, %3  : i8
    llvm.return %5 : i8
  }]

def shifty_abs_too_many_uses_before := [llvmfunc|
  llvm.func @shifty_abs_too_many_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.add %arg0, %1  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.return %3 : i8
  }]

def shifty_sub_before := [llvmfunc|
  llvm.func @shifty_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.xor %arg0, %1  : i8
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }]

def shifty_sub_nsw_commute_before := [llvmfunc|
  llvm.func @shifty_sub_nsw_commute(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.xor %1, %arg0  : i8
    %3 = llvm.sub %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }]

def shifty_sub_nuw_vec_commute_before := [llvmfunc|
  llvm.func @shifty_sub_nuw_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.ashr %arg0, %0  : vector<4xi32>
    %2 = llvm.xor %1, %arg0  : vector<4xi32>
    %3 = llvm.sub %2, %1 overflow<nuw>  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def shifty_sub_nsw_nuw_before := [llvmfunc|
  llvm.func @shifty_sub_nsw_nuw(%arg0: i12) -> i12 {
    %0 = llvm.mlir.constant(11 : i12) : i12
    %1 = llvm.ashr %arg0, %0  : i12
    %2 = llvm.xor %arg0, %1  : i12
    %3 = llvm.sub %2, %1 overflow<nsw, nuw>  : i12
    llvm.return %3 : i12
  }]

def negate_abs_before := [llvmfunc|
  llvm.func @negate_abs(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg0 : i1, i8
    %4 = llvm.sub %0, %3  : i8
    llvm.return %4 : i8
  }]

def negate_nabs_before := [llvmfunc|
  llvm.func @negate_nabs(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi8>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi8>
    %5 = llvm.sub %1, %4  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def abs_must_be_positive_before := [llvmfunc|
  llvm.func @abs_must_be_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    llvm.return %4 : i1
  }]

def abs_swapped_before := [llvmfunc|
  llvm.func @abs_swapped(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg0, %1 : i1, i8
    llvm.return %3 : i8
  }]

def nabs_swapped_before := [llvmfunc|
  llvm.func @nabs_swapped(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

def abs_different_constants_before := [llvmfunc|
  llvm.func @abs_different_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg0, %2 : i1, i8
    llvm.return %4 : i8
  }]

def nabs_different_constants_before := [llvmfunc|
  llvm.func @nabs_different_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg0, %1 : i8
    %4 = llvm.select %3, %2, %arg0 : i1, i8
    llvm.return %4 : i8
  }]

def infinite_loop_constant_expression_abs_before := [llvmfunc|
  llvm.func @infinite_loop_constant_expression_abs(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.sub %1, %arg0  : i64
    %4 = llvm.icmp "slt" %3, %2 : i64
    %5 = llvm.sub %2, %3 overflow<nsw>  : i64
    %6 = llvm.select %4, %5, %3 : i1, i64
    llvm.return %6 : i64
  }]

def abs_extra_use_icmp_before := [llvmfunc|
  llvm.func @abs_extra_use_icmp(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

def abs_extra_use_sub_before := [llvmfunc|
  llvm.func @abs_extra_use_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

def abs_extra_use_icmp_sub_before := [llvmfunc|
  llvm.func @abs_extra_use_icmp_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

def nabs_extra_use_icmp_before := [llvmfunc|
  llvm.func @nabs_extra_use_icmp(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }]

def nabs_extra_use_sub_before := [llvmfunc|
  llvm.func @nabs_extra_use_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }]

def nabs_extra_use_icmp_sub_before := [llvmfunc|
  llvm.func @nabs_extra_use_icmp_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }]

def nabs_diff_signed_slt_before := [llvmfunc|
  llvm.func @nabs_diff_signed_slt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %2, %1 : i1, i32
    llvm.return %3 : i32
  }]

def nabs_diff_signed_sle_before := [llvmfunc|
  llvm.func @nabs_diff_signed_sle(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.icmp "sle" %arg0, %arg1 : vector<2xi8>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.select %0, %2, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def abs_diff_signed_sgt_before := [llvmfunc|
  llvm.func @abs_diff_signed_sgt(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

def abs_diff_signed_sge_before := [llvmfunc|
  llvm.func @abs_diff_signed_sge(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

def abs_diff_signed_slt_no_nsw_before := [llvmfunc|
  llvm.func @abs_diff_signed_slt_no_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.select %0, %2, %1 : i1, i32
    llvm.return %3 : i32
  }]

def abs_diff_signed_sgt_nsw_nuw_before := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nsw_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw, nuw>  : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw, nuw>  : i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

def abs_diff_signed_sgt_nuw_before := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

def abs_diff_signed_sgt_nuw_extra_use1_before := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nuw_extra_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

def abs_diff_signed_sgt_nuw_extra_use2_before := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nuw_extra_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

def abs_diff_signed_sgt_nuw_extra_use3_before := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nuw_extra_use3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

def abs_diff_signed_slt_swap_wrong_pred1_before := [llvmfunc|
  llvm.func @abs_diff_signed_slt_swap_wrong_pred1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def abs_diff_signed_slt_swap_wrong_pred2_before := [llvmfunc|
  llvm.func @abs_diff_signed_slt_swap_wrong_pred2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def abs_diff_signed_slt_swap_wrong_op_before := [llvmfunc|
  llvm.func @abs_diff_signed_slt_swap_wrong_op(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg2 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def abs_diff_signed_slt_swap_before := [llvmfunc|
  llvm.func @abs_diff_signed_slt_swap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def abs_diff_signed_sle_swap_before := [llvmfunc|
  llvm.func @abs_diff_signed_sle_swap(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.icmp "sle" %arg0, %arg1 : vector<2xi8>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.select %0, %1, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def nabs_diff_signed_sgt_swap_before := [llvmfunc|
  llvm.func @nabs_diff_signed_sgt_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %0, %1, %2 : i1, i8
    llvm.return %3 : i8
  }]

def nabs_diff_signed_sge_swap_before := [llvmfunc|
  llvm.func @nabs_diff_signed_sge_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %1, %2 : i1, i8
    llvm.return %3 : i8
  }]

def abs_diff_signed_slt_no_nsw_swap_before := [llvmfunc|
  llvm.func @abs_diff_signed_slt_no_nsw_swap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

def test_abs_combined := [llvmfunc|
  llvm.func @test_abs(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_abs   : test_abs_before  ⊑  test_abs_combined := by
  unfold test_abs_before test_abs_combined
  simp_alive_peephole
  sorry
def test_labs_combined := [llvmfunc|
  llvm.func @test_labs(%arg0: i64) -> i64 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_labs   : test_labs_before  ⊑  test_labs_combined := by
  unfold test_labs_before test_labs_combined
  simp_alive_peephole
  sorry
def test_llabs_combined := [llvmfunc|
  llvm.func @test_llabs(%arg0: i64) -> i64 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i64) -> i64
    llvm.return %0 : i64
  }]

theorem inst_combine_test_llabs   : test_llabs_before  ⊑  test_llabs_combined := by
  unfold test_llabs_before test_llabs_combined
  simp_alive_peephole
  sorry
def abs_canonical_1_combined := [llvmfunc|
  llvm.func @abs_canonical_1(%arg0: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_abs_canonical_1   : abs_canonical_1_before  ⊑  abs_canonical_1_combined := by
  unfold abs_canonical_1_before abs_canonical_1_combined
  simp_alive_peephole
  sorry
def abs_canonical_2_combined := [llvmfunc|
  llvm.func @abs_canonical_2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_abs_canonical_2   : abs_canonical_2_before  ⊑  abs_canonical_2_combined := by
  unfold abs_canonical_2_before abs_canonical_2_combined
  simp_alive_peephole
  sorry
def abs_canonical_2_vec_poison_elts_combined := [llvmfunc|
  llvm.func @abs_canonical_2_vec_poison_elts(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_abs_canonical_2_vec_poison_elts   : abs_canonical_2_vec_poison_elts_before  ⊑  abs_canonical_2_vec_poison_elts_combined := by
  unfold abs_canonical_2_vec_poison_elts_before abs_canonical_2_vec_poison_elts_combined
  simp_alive_peephole
  sorry
def abs_canonical_3_combined := [llvmfunc|
  llvm.func @abs_canonical_3(%arg0: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_abs_canonical_3   : abs_canonical_3_before  ⊑  abs_canonical_3_combined := by
  unfold abs_canonical_3_before abs_canonical_3_combined
  simp_alive_peephole
  sorry
def abs_canonical_4_combined := [llvmfunc|
  llvm.func @abs_canonical_4(%arg0: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_abs_canonical_4   : abs_canonical_4_before  ⊑  abs_canonical_4_combined := by
  unfold abs_canonical_4_before abs_canonical_4_combined
  simp_alive_peephole
  sorry
def abs_canonical_5_combined := [llvmfunc|
  llvm.func @abs_canonical_5(%arg0: i8) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_abs_canonical_5   : abs_canonical_5_before  ⊑  abs_canonical_5_combined := by
  unfold abs_canonical_5_before abs_canonical_5_combined
  simp_alive_peephole
  sorry
def abs_canonical_6_combined := [llvmfunc|
  llvm.func @abs_canonical_6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sub %arg0, %arg1  : i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_abs_canonical_6   : abs_canonical_6_before  ⊑  abs_canonical_6_combined := by
  unfold abs_canonical_6_before abs_canonical_6_combined
  simp_alive_peephole
  sorry
def abs_canonical_7_combined := [llvmfunc|
  llvm.func @abs_canonical_7(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_abs_canonical_7   : abs_canonical_7_before  ⊑  abs_canonical_7_combined := by
  unfold abs_canonical_7_before abs_canonical_7_combined
  simp_alive_peephole
  sorry
def abs_canonical_8_combined := [llvmfunc|
  llvm.func @abs_canonical_8(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_abs_canonical_8   : abs_canonical_8_before  ⊑  abs_canonical_8_combined := by
  unfold abs_canonical_8_before abs_canonical_8_combined
  simp_alive_peephole
  sorry
def abs_canonical_9_combined := [llvmfunc|
  llvm.func @abs_canonical_9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sub %arg0, %arg1  : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_abs_canonical_9   : abs_canonical_9_before  ⊑  abs_canonical_9_combined := by
  unfold abs_canonical_9_before abs_canonical_9_combined
  simp_alive_peephole
  sorry
def abs_canonical_10_combined := [llvmfunc|
  llvm.func @abs_canonical_10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sub %arg0, %arg1  : i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_abs_canonical_10   : abs_canonical_10_before  ⊑  abs_canonical_10_combined := by
  unfold abs_canonical_10_before abs_canonical_10_combined
  simp_alive_peephole
  sorry
def nabs_canonical_1_combined := [llvmfunc|
  llvm.func @nabs_canonical_1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_nabs_canonical_1   : nabs_canonical_1_before  ⊑  nabs_canonical_1_combined := by
  unfold nabs_canonical_1_before nabs_canonical_1_combined
  simp_alive_peephole
  sorry
def nabs_canonical_2_combined := [llvmfunc|
  llvm.func @nabs_canonical_2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    %3 = llvm.sub %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_nabs_canonical_2   : nabs_canonical_2_before  ⊑  nabs_canonical_2_combined := by
  unfold nabs_canonical_2_before nabs_canonical_2_combined
  simp_alive_peephole
  sorry
def nabs_canonical_2_vec_poison_elts_combined := [llvmfunc|
  llvm.func @nabs_canonical_2_vec_poison_elts(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    %3 = llvm.sub %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_nabs_canonical_2_vec_poison_elts   : nabs_canonical_2_vec_poison_elts_before  ⊑  nabs_canonical_2_vec_poison_elts_combined := by
  unfold nabs_canonical_2_vec_poison_elts_before nabs_canonical_2_vec_poison_elts_combined
  simp_alive_peephole
  sorry
def nabs_canonical_3_combined := [llvmfunc|
  llvm.func @nabs_canonical_3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_nabs_canonical_3   : nabs_canonical_3_before  ⊑  nabs_canonical_3_combined := by
  unfold nabs_canonical_3_before nabs_canonical_3_combined
  simp_alive_peephole
  sorry
def nabs_canonical_4_combined := [llvmfunc|
  llvm.func @nabs_canonical_4(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_nabs_canonical_4   : nabs_canonical_4_before  ⊑  nabs_canonical_4_combined := by
  unfold nabs_canonical_4_before nabs_canonical_4_combined
  simp_alive_peephole
  sorry
def nabs_canonical_5_combined := [llvmfunc|
  llvm.func @nabs_canonical_5(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sub %0, %2 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_nabs_canonical_5   : nabs_canonical_5_before  ⊑  nabs_canonical_5_combined := by
  unfold nabs_canonical_5_before nabs_canonical_5_combined
  simp_alive_peephole
  sorry
def nabs_canonical_6_combined := [llvmfunc|
  llvm.func @nabs_canonical_6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32
    %3 = llvm.sub %0, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_nabs_canonical_6   : nabs_canonical_6_before  ⊑  nabs_canonical_6_combined := by
  unfold nabs_canonical_6_before nabs_canonical_6_combined
  simp_alive_peephole
  sorry
def nabs_canonical_7_combined := [llvmfunc|
  llvm.func @nabs_canonical_7(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1  : vector<2xi8>
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.sub %1, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_nabs_canonical_7   : nabs_canonical_7_before  ⊑  nabs_canonical_7_combined := by
  unfold nabs_canonical_7_before nabs_canonical_7_combined
  simp_alive_peephole
  sorry
def nabs_canonical_8_combined := [llvmfunc|
  llvm.func @nabs_canonical_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_nabs_canonical_8   : nabs_canonical_8_before  ⊑  nabs_canonical_8_combined := by
  unfold nabs_canonical_8_before nabs_canonical_8_combined
  simp_alive_peephole
  sorry
def nabs_canonical_9_combined := [llvmfunc|
  llvm.func @nabs_canonical_9(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sub %arg0, %arg1  : i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = false}> : (i32) -> i32
    %2 = llvm.add %1, %arg0  : i32
    %3 = llvm.sub %arg1, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_nabs_canonical_9   : nabs_canonical_9_before  ⊑  nabs_canonical_9_combined := by
  unfold nabs_canonical_9_before nabs_canonical_9_combined
  simp_alive_peephole
  sorry
def nabs_canonical_10_combined := [llvmfunc|
  llvm.func @nabs_canonical_10(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %arg0, %arg1  : i32
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i32) -> i32
    %3 = llvm.sub %0, %2  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_nabs_canonical_10   : nabs_canonical_10_before  ⊑  nabs_canonical_10_combined := by
  unfold nabs_canonical_10_before nabs_canonical_10_combined
  simp_alive_peephole
  sorry
def shifty_abs_commute0_combined := [llvmfunc|
  llvm.func @shifty_abs_commute0(%arg0: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_shifty_abs_commute0   : shifty_abs_commute0_before  ⊑  shifty_abs_commute0_combined := by
  unfold shifty_abs_commute0_before shifty_abs_commute0_combined
  simp_alive_peephole
  sorry
def shifty_abs_commute0_nsw_combined := [llvmfunc|
  llvm.func @shifty_abs_commute0_nsw(%arg0: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_shifty_abs_commute0_nsw   : shifty_abs_commute0_nsw_before  ⊑  shifty_abs_commute0_nsw_combined := by
  unfold shifty_abs_commute0_nsw_before shifty_abs_commute0_nsw_combined
  simp_alive_peephole
  sorry
def shifty_abs_commute0_nuw_combined := [llvmfunc|
  llvm.func @shifty_abs_commute0_nuw(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %0)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_shifty_abs_commute0_nuw   : shifty_abs_commute0_nuw_before  ⊑  shifty_abs_commute0_nuw_combined := by
  unfold shifty_abs_commute0_nuw_before shifty_abs_commute0_nuw_combined
  simp_alive_peephole
  sorry
def shifty_abs_commute1_combined := [llvmfunc|
  llvm.func @shifty_abs_commute1(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_shifty_abs_commute1   : shifty_abs_commute1_before  ⊑  shifty_abs_commute1_combined := by
  unfold shifty_abs_commute1_before shifty_abs_commute1_combined
  simp_alive_peephole
  sorry
def shifty_abs_commute2_combined := [llvmfunc|
  llvm.func @shifty_abs_commute2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mul %arg0, %0  : vector<2xi8>
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_shifty_abs_commute2   : shifty_abs_commute2_before  ⊑  shifty_abs_commute2_combined := by
  unfold shifty_abs_commute2_before shifty_abs_commute2_combined
  simp_alive_peephole
  sorry
def shifty_abs_commute3_combined := [llvmfunc|
  llvm.func @shifty_abs_commute3(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_shifty_abs_commute3   : shifty_abs_commute3_before  ⊑  shifty_abs_commute3_combined := by
  unfold shifty_abs_commute3_before shifty_abs_commute3_combined
  simp_alive_peephole
  sorry
def shifty_abs_too_many_uses_combined := [llvmfunc|
  llvm.func @shifty_abs_too_many_uses(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.add %1, %arg0  : i8
    %3 = llvm.xor %2, %1  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.return %3 : i8
  }]

theorem inst_combine_shifty_abs_too_many_uses   : shifty_abs_too_many_uses_before  ⊑  shifty_abs_too_many_uses_combined := by
  unfold shifty_abs_too_many_uses_before shifty_abs_too_many_uses_combined
  simp_alive_peephole
  sorry
def shifty_sub_combined := [llvmfunc|
  llvm.func @shifty_sub(%arg0: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_shifty_sub   : shifty_sub_before  ⊑  shifty_sub_combined := by
  unfold shifty_sub_before shifty_sub_combined
  simp_alive_peephole
  sorry
def shifty_sub_nsw_commute_combined := [llvmfunc|
  llvm.func @shifty_sub_nsw_commute(%arg0: i8) -> i8 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_shifty_sub_nsw_commute   : shifty_sub_nsw_commute_before  ⊑  shifty_sub_nsw_commute_combined := by
  unfold shifty_sub_nsw_commute_before shifty_sub_nsw_commute_combined
  simp_alive_peephole
  sorry
def shifty_sub_nuw_vec_commute_combined := [llvmfunc|
  llvm.func @shifty_sub_nuw_vec_commute(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.intr.smax(%arg0, %1)  : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_shifty_sub_nuw_vec_commute   : shifty_sub_nuw_vec_commute_before  ⊑  shifty_sub_nuw_vec_commute_combined := by
  unfold shifty_sub_nuw_vec_commute_before shifty_sub_nuw_vec_commute_combined
  simp_alive_peephole
  sorry
def shifty_sub_nsw_nuw_combined := [llvmfunc|
  llvm.func @shifty_sub_nsw_nuw(%arg0: i12) -> i12 {
    %0 = llvm.mlir.constant(0 : i12) : i12
    %1 = llvm.intr.smax(%arg0, %0)  : (i12, i12) -> i12
    llvm.return %1 : i12
  }]

theorem inst_combine_shifty_sub_nsw_nuw   : shifty_sub_nsw_nuw_before  ⊑  shifty_sub_nsw_nuw_combined := by
  unfold shifty_sub_nsw_nuw_before shifty_sub_nsw_nuw_combined
  simp_alive_peephole
  sorry
def negate_abs_combined := [llvmfunc|
  llvm.func @negate_abs(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_negate_abs   : negate_abs_before  ⊑  negate_abs_combined := by
  unfold negate_abs_before negate_abs_combined
  simp_alive_peephole
  sorry
def negate_nabs_combined := [llvmfunc|
  llvm.func @negate_nabs(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_negate_nabs   : negate_nabs_before  ⊑  negate_nabs_combined := by
  unfold negate_nabs_before negate_nabs_combined
  simp_alive_peephole
  sorry
def abs_must_be_positive_combined := [llvmfunc|
  llvm.func @abs_must_be_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_abs_must_be_positive   : abs_must_be_positive_before  ⊑  abs_must_be_positive_combined := by
  unfold abs_must_be_positive_before abs_must_be_positive_combined
  simp_alive_peephole
  sorry
def abs_swapped_combined := [llvmfunc|
  llvm.func @abs_swapped(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_abs_swapped   : abs_swapped_before  ⊑  abs_swapped_combined := by
  unfold abs_swapped_before abs_swapped_combined
  simp_alive_peephole
  sorry
def nabs_swapped_combined := [llvmfunc|
  llvm.func @nabs_swapped(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %3 = llvm.sub %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_nabs_swapped   : nabs_swapped_before  ⊑  nabs_swapped_combined := by
  unfold nabs_swapped_before nabs_swapped_combined
  simp_alive_peephole
  sorry
def abs_different_constants_combined := [llvmfunc|
  llvm.func @abs_different_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_abs_different_constants   : abs_different_constants_before  ⊑  abs_different_constants_combined := by
  unfold abs_different_constants_before abs_different_constants_combined
  simp_alive_peephole
  sorry
def nabs_different_constants_combined := [llvmfunc|
  llvm.func @nabs_different_constants(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %3 = llvm.sub %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_nabs_different_constants   : nabs_different_constants_before  ⊑  nabs_different_constants_combined := by
  unfold nabs_different_constants_before nabs_different_constants_combined
  simp_alive_peephole
  sorry
def infinite_loop_constant_expression_abs_combined := [llvmfunc|
  llvm.func @infinite_loop_constant_expression_abs(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.sub %1, %arg0  : i64
    %3 = "llvm.intr.abs"(%2) <{is_int_min_poison = true}> : (i64) -> i64
    llvm.return %3 : i64
  }]

theorem inst_combine_infinite_loop_constant_expression_abs   : infinite_loop_constant_expression_abs_before  ⊑  infinite_loop_constant_expression_abs_combined := by
  unfold infinite_loop_constant_expression_abs_before infinite_loop_constant_expression_abs_combined
  simp_alive_peephole
  sorry
def abs_extra_use_icmp_combined := [llvmfunc|
  llvm.func @abs_extra_use_icmp(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_abs_extra_use_icmp   : abs_extra_use_icmp_before  ⊑  abs_extra_use_icmp_combined := by
  unfold abs_extra_use_icmp_before abs_extra_use_icmp_combined
  simp_alive_peephole
  sorry
def abs_extra_use_sub_combined := [llvmfunc|
  llvm.func @abs_extra_use_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_abs_extra_use_sub   : abs_extra_use_sub_before  ⊑  abs_extra_use_sub_combined := by
  unfold abs_extra_use_sub_before abs_extra_use_sub_combined
  simp_alive_peephole
  sorry
def abs_extra_use_icmp_sub_combined := [llvmfunc|
  llvm.func @abs_extra_use_icmp_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %2, %arg0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_abs_extra_use_icmp_sub   : abs_extra_use_icmp_sub_before  ⊑  abs_extra_use_icmp_sub_combined := by
  unfold abs_extra_use_icmp_sub_before abs_extra_use_icmp_sub_combined
  simp_alive_peephole
  sorry
def nabs_extra_use_icmp_combined := [llvmfunc|
  llvm.func @nabs_extra_use_icmp(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %3 = llvm.sub %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_nabs_extra_use_icmp   : nabs_extra_use_icmp_before  ⊑  nabs_extra_use_icmp_combined := by
  unfold nabs_extra_use_icmp_before nabs_extra_use_icmp_combined
  simp_alive_peephole
  sorry
def nabs_extra_use_sub_combined := [llvmfunc|
  llvm.func @nabs_extra_use_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i8) -> i8
    %3 = llvm.sub %0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_nabs_extra_use_sub   : nabs_extra_use_sub_before  ⊑  nabs_extra_use_sub_combined := by
  unfold nabs_extra_use_sub_before nabs_extra_use_sub_combined
  simp_alive_peephole
  sorry
def nabs_extra_use_icmp_sub_combined := [llvmfunc|
  llvm.func @nabs_extra_use_icmp_sub(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @extra_use_i1(%1) : (i1) -> ()
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg0, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_nabs_extra_use_icmp_sub   : nabs_extra_use_icmp_sub_before  ⊑  nabs_extra_use_icmp_sub_combined := by
  unfold nabs_extra_use_icmp_sub_before nabs_extra_use_icmp_sub_combined
  simp_alive_peephole
  sorry
def nabs_diff_signed_slt_combined := [llvmfunc|
  llvm.func @nabs_diff_signed_slt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %2, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_nabs_diff_signed_slt   : nabs_diff_signed_slt_before  ⊑  nabs_diff_signed_slt_combined := by
  unfold nabs_diff_signed_slt_before nabs_diff_signed_slt_combined
  simp_alive_peephole
  sorry
def nabs_diff_signed_sle_combined := [llvmfunc|
  llvm.func @nabs_diff_signed_sle(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi8>
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.select %0, %1, %2 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_nabs_diff_signed_sle   : nabs_diff_signed_sle_before  ⊑  nabs_diff_signed_sle_combined := by
  unfold nabs_diff_signed_sle_before nabs_diff_signed_sle_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_sgt_combined := [llvmfunc|
  llvm.func @abs_diff_signed_sgt(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @extra_use(%0) : (i8) -> ()
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_abs_diff_signed_sgt   : abs_diff_signed_sgt_before  ⊑  abs_diff_signed_sgt_combined := by
  unfold abs_diff_signed_sgt_before abs_diff_signed_sgt_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_sge_combined := [llvmfunc|
  llvm.func @abs_diff_signed_sge(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.call @extra_use(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_abs_diff_signed_sge   : abs_diff_signed_sge_before  ⊑  abs_diff_signed_sge_combined := by
  unfold abs_diff_signed_sge_before abs_diff_signed_sge_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_slt_no_nsw_combined := [llvmfunc|
  llvm.func @abs_diff_signed_slt_no_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.select %0, %2, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_abs_diff_signed_slt_no_nsw   : abs_diff_signed_slt_no_nsw_before  ⊑  abs_diff_signed_slt_no_nsw_combined := by
  unfold abs_diff_signed_slt_no_nsw_before abs_diff_signed_slt_no_nsw_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_sgt_nsw_nuw_combined := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nsw_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_abs_diff_signed_sgt_nsw_nuw   : abs_diff_signed_sgt_nsw_nuw_before  ⊑  abs_diff_signed_sgt_nsw_nuw_combined := by
  unfold abs_diff_signed_sgt_nsw_nuw_before abs_diff_signed_sgt_nsw_nuw_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_sgt_nuw_combined := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_abs_diff_signed_sgt_nuw   : abs_diff_signed_sgt_nuw_before  ⊑  abs_diff_signed_sgt_nuw_combined := by
  unfold abs_diff_signed_sgt_nuw_before abs_diff_signed_sgt_nuw_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_sgt_nuw_extra_use1_combined := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nuw_extra_use1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @extra_use(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_abs_diff_signed_sgt_nuw_extra_use1   : abs_diff_signed_sgt_nuw_extra_use1_before  ⊑  abs_diff_signed_sgt_nuw_extra_use1_combined := by
  unfold abs_diff_signed_sgt_nuw_extra_use1_before abs_diff_signed_sgt_nuw_extra_use1_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_sgt_nuw_extra_use2_combined := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nuw_extra_use2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @extra_use(%0) : (i8) -> ()
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_abs_diff_signed_sgt_nuw_extra_use2   : abs_diff_signed_sgt_nuw_extra_use2_before  ⊑  abs_diff_signed_sgt_nuw_extra_use2_combined := by
  unfold abs_diff_signed_sgt_nuw_extra_use2_before abs_diff_signed_sgt_nuw_extra_use2_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_sgt_nuw_extra_use3_combined := [llvmfunc|
  llvm.func @abs_diff_signed_sgt_nuw_extra_use3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg1, %arg0 overflow<nuw>  : i8
    llvm.call @extra_use(%0) : (i8) -> ()
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = "llvm.intr.abs"(%1) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %2 : i8
  }]

theorem inst_combine_abs_diff_signed_sgt_nuw_extra_use3   : abs_diff_signed_sgt_nuw_extra_use3_before  ⊑  abs_diff_signed_sgt_nuw_extra_use3_combined := by
  unfold abs_diff_signed_sgt_nuw_extra_use3_before abs_diff_signed_sgt_nuw_extra_use3_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_slt_swap_wrong_pred1_combined := [llvmfunc|
  llvm.func @abs_diff_signed_slt_swap_wrong_pred1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_abs_diff_signed_slt_swap_wrong_pred1   : abs_diff_signed_slt_swap_wrong_pred1_before  ⊑  abs_diff_signed_slt_swap_wrong_pred1_combined := by
  unfold abs_diff_signed_slt_swap_wrong_pred1_before abs_diff_signed_slt_swap_wrong_pred1_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_slt_swap_wrong_pred2_combined := [llvmfunc|
  llvm.func @abs_diff_signed_slt_swap_wrong_pred2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_abs_diff_signed_slt_swap_wrong_pred2   : abs_diff_signed_slt_swap_wrong_pred2_before  ⊑  abs_diff_signed_slt_swap_wrong_pred2_combined := by
  unfold abs_diff_signed_slt_swap_wrong_pred2_before abs_diff_signed_slt_swap_wrong_pred2_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_slt_swap_wrong_op_combined := [llvmfunc|
  llvm.func @abs_diff_signed_slt_swap_wrong_op(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg2 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_abs_diff_signed_slt_swap_wrong_op   : abs_diff_signed_slt_swap_wrong_op_before  ⊑  abs_diff_signed_slt_swap_wrong_op_combined := by
  unfold abs_diff_signed_slt_swap_wrong_op_before abs_diff_signed_slt_swap_wrong_op_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_slt_swap_combined := [llvmfunc|
  llvm.func @abs_diff_signed_slt_swap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i32
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_abs_diff_signed_slt_swap   : abs_diff_signed_slt_swap_before  ⊑  abs_diff_signed_slt_swap_combined := by
  unfold abs_diff_signed_slt_swap_before abs_diff_signed_slt_swap_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_sle_swap_combined := [llvmfunc|
  llvm.func @abs_diff_signed_sle_swap(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_abs_diff_signed_sle_swap   : abs_diff_signed_sle_swap_before  ⊑  abs_diff_signed_sle_swap_combined := by
  unfold abs_diff_signed_sle_swap_before abs_diff_signed_sle_swap_combined
  simp_alive_peephole
  sorry
def nabs_diff_signed_sgt_swap_combined := [llvmfunc|
  llvm.func @nabs_diff_signed_sgt_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %0, %1, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_nabs_diff_signed_sgt_swap   : nabs_diff_signed_sgt_swap_before  ⊑  nabs_diff_signed_sgt_swap_combined := by
  unfold nabs_diff_signed_sgt_swap_before nabs_diff_signed_sgt_swap_combined
  simp_alive_peephole
  sorry
def nabs_diff_signed_sge_swap_combined := [llvmfunc|
  llvm.func @nabs_diff_signed_sge_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @extra_use(%2) : (i8) -> ()
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_nabs_diff_signed_sge_swap   : nabs_diff_signed_sge_swap_before  ⊑  nabs_diff_signed_sge_swap_combined := by
  unfold nabs_diff_signed_sge_swap_before nabs_diff_signed_sge_swap_combined
  simp_alive_peephole
  sorry
def abs_diff_signed_slt_no_nsw_swap_combined := [llvmfunc|
  llvm.func @abs_diff_signed_slt_no_nsw_swap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i32
    %2 = llvm.sub %arg0, %arg1  : i32
    %3 = llvm.select %0, %1, %2 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_abs_diff_signed_slt_no_nsw_swap   : abs_diff_signed_slt_no_nsw_swap_before  ⊑  abs_diff_signed_slt_no_nsw_swap_combined := by
  unfold abs_diff_signed_slt_no_nsw_swap_before abs_diff_signed_slt_no_nsw_swap_combined
  simp_alive_peephole
  sorry
