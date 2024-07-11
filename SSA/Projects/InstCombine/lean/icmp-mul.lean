import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-mul
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def squared_nsw_eq0_before := [llvmfunc|
  llvm.func @squared_nsw_eq0(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mul %arg0, %arg0 overflow<nsw>  : i5
    %2 = llvm.icmp "eq" %1, %0 : i5
    llvm.return %2 : i1
  }]

def squared_nuw_eq0_before := [llvmfunc|
  llvm.func @squared_nuw_eq0(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %arg0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def squared_nsw_nuw_ne0_before := [llvmfunc|
  llvm.func @squared_nsw_nuw_ne0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mul %arg0, %arg0 overflow<nsw, nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def squared_eq0_before := [llvmfunc|
  llvm.func @squared_eq0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def mul_nsw_eq0_before := [llvmfunc|
  llvm.func @mul_nsw_eq0(%arg0: i5, %arg1: i5) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %2 = llvm.icmp "eq" %1, %0 : i5
    llvm.return %2 : i1
  }]

def squared_nsw_eq1_before := [llvmfunc|
  llvm.func @squared_nsw_eq1(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.mul %arg0, %arg0 overflow<nsw>  : i5
    %2 = llvm.icmp "eq" %1, %0 : i5
    llvm.return %2 : i1
  }]

def squared_nsw_sgt0_before := [llvmfunc|
  llvm.func @squared_nsw_sgt0(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mul %arg0, %arg0 overflow<nsw>  : i5
    %2 = llvm.icmp "sgt" %1, %0 : i5
    llvm.return %2 : i1
  }]

def slt_positive_multip_rem_zero_before := [llvmfunc|
  llvm.func @slt_positive_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def slt_negative_multip_rem_zero_before := [llvmfunc|
  llvm.func @slt_negative_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def slt_positive_multip_rem_nz_before := [llvmfunc|
  llvm.func @slt_positive_multip_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_rem_zero_before := [llvmfunc|
  llvm.func @ult_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_rem_zero_nsw_before := [llvmfunc|
  llvm.func @ult_rem_zero_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_rem_nz_before := [llvmfunc|
  llvm.func @ult_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_rem_nz_nsw_before := [llvmfunc|
  llvm.func @ult_rem_nz_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sgt_positive_multip_rem_zero_before := [llvmfunc|
  llvm.func @sgt_positive_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sgt_negative_multip_rem_zero_before := [llvmfunc|
  llvm.func @sgt_negative_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sgt_positive_multip_rem_nz_before := [llvmfunc|
  llvm.func @sgt_positive_multip_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ugt_rem_zero_before := [llvmfunc|
  llvm.func @ugt_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ugt_rem_zero_nsw_before := [llvmfunc|
  llvm.func @ugt_rem_zero_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ugt_rem_nz_before := [llvmfunc|
  llvm.func @ugt_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ugt_rem_nz_nsw_before := [llvmfunc|
  llvm.func @ugt_rem_nz_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def eq_nsw_rem_zero_before := [llvmfunc|
  llvm.func @eq_nsw_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ne_nsw_rem_zero_before := [llvmfunc|
  llvm.func @ne_nsw_rem_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-30> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def ne_nsw_rem_zero_undef1_before := [llvmfunc|
  llvm.func @ne_nsw_rem_zero_undef1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<-30> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mul %arg0, %6 overflow<nsw>  : vector<2xi8>
    %9 = llvm.icmp "ne" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

def ne_nsw_rem_zero_undef2_before := [llvmfunc|
  llvm.func @ne_nsw_rem_zero_undef2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.constant(-30 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mul %arg0, %0 overflow<nsw>  : vector<2xi8>
    %9 = llvm.icmp "ne" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

def eq_nsw_rem_zero_uses_before := [llvmfunc|
  llvm.func @eq_nsw_rem_zero_uses(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def eq_nsw_rem_nz_before := [llvmfunc|
  llvm.func @eq_nsw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-11 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ne_nsw_rem_nz_before := [llvmfunc|
  llvm.func @ne_nsw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-126 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def eq_nuw_rem_zero_before := [llvmfunc|
  llvm.func @eq_nuw_rem_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def eq_nuw_rem_zero_undef1_before := [llvmfunc|
  llvm.func @eq_nuw_rem_zero_undef1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mul %arg0, %6 overflow<nuw>  : vector<2xi8>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

def eq_nuw_rem_zero_undef2_before := [llvmfunc|
  llvm.func @eq_nuw_rem_zero_undef2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mul %arg0, %0 overflow<nuw>  : vector<2xi8>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

def ne_nuw_rem_zero_before := [llvmfunc|
  llvm.func @ne_nuw_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-126 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ne_nuw_rem_zero_uses_before := [llvmfunc|
  llvm.func @ne_nuw_rem_zero_uses(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-126 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def eq_nuw_rem_nz_before := [llvmfunc|
  llvm.func @eq_nuw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ne_nuw_rem_nz_before := [llvmfunc|
  llvm.func @ne_nuw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-30 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sgt_positive_multip_rem_zero_nonsw_before := [llvmfunc|
  llvm.func @sgt_positive_multip_rem_zero_nonsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_multip_rem_zero_nonsw_before := [llvmfunc|
  llvm.func @ult_multip_rem_zero_nonsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ugt_rem_zero_nonuw_before := [llvmfunc|
  llvm.func @ugt_rem_zero_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sgt_minnum_before := [llvmfunc|
  llvm.func @sgt_minnum(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ule_bignum_before := [llvmfunc|
  llvm.func @ule_bignum(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sgt_mulzero_before := [llvmfunc|
  llvm.func @sgt_mulzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def eq_rem_zero_nonuw_before := [llvmfunc|
  llvm.func @eq_rem_zero_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ne_rem_zero_nonuw_before := [llvmfunc|
  llvm.func @ne_rem_zero_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(30 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def mul_constant_eq_before := [llvmfunc|
  llvm.func @mul_constant_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def mul_constant_ne_splat_before := [llvmfunc|
  llvm.func @mul_constant_ne_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0  : vector<2xi32>
    %2 = llvm.mul %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def mul_constant_ne_extra_use1_before := [llvmfunc|
  llvm.func @mul_constant_ne_extra_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0  : i8
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

def mul_constant_eq_extra_use2_before := [llvmfunc|
  llvm.func @mul_constant_eq_extra_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.mul %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

def mul_constant_ne_extra_use3_before := [llvmfunc|
  llvm.func @mul_constant_ne_extra_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

def mul_constant_eq_nsw_before := [llvmfunc|
  llvm.func @mul_constant_eq_nsw(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def mul_constant_ne_nsw_splat_before := [llvmfunc|
  llvm.func @mul_constant_ne_nsw_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : vector<2xi32>
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def mul_constant_ne_nsw_extra_use1_before := [llvmfunc|
  llvm.func @mul_constant_ne_nsw_extra_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(74 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

def mul_constant_eq_nsw_extra_use2_before := [llvmfunc|
  llvm.func @mul_constant_eq_nsw_extra_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

def mul_constant_ne_nsw_extra_use3_before := [llvmfunc|
  llvm.func @mul_constant_ne_nsw_extra_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

def mul_constant_nuw_eq_before := [llvmfunc|
  llvm.func @mul_constant_nuw_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(22 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def mul_constant_ne_nuw_splat_before := [llvmfunc|
  llvm.func @mul_constant_ne_nuw_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : vector<2xi32>
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : vector<2xi32>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def mul_constant_ne_nuw_extra_use1_before := [llvmfunc|
  llvm.func @mul_constant_ne_nuw_extra_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

def mul_constant_eq_nuw_extra_use2_before := [llvmfunc|
  llvm.func @mul_constant_eq_nuw_extra_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(36 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

def mul_constant_ne_nuw_extra_use3_before := [llvmfunc|
  llvm.func @mul_constant_ne_nuw_extra_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(38 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

def mul_constant_ult_before := [llvmfunc|
  llvm.func @mul_constant_ult(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    llvm.return %3 : i1
  }]

def mul_constant_nuw_sgt_before := [llvmfunc|
  llvm.func @mul_constant_nuw_sgt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(46 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "sgt" %1, %2 : i32
    llvm.return %3 : i1
  }]

def mul_mismatch_constant_nuw_eq_before := [llvmfunc|
  llvm.func @mul_mismatch_constant_nuw_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(46 : i32) : i32
    %1 = llvm.mlir.constant(44 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.mul %arg1, %1 overflow<nuw>  : i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }]

def mul_constant_partial_nuw_eq_before := [llvmfunc|
  llvm.func @mul_constant_partial_nuw_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(44 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def mul_constant_mismatch_wrap_eq_before := [llvmfunc|
  llvm.func @mul_constant_mismatch_wrap_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(54 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def eq_mul_constants_with_tz_before := [llvmfunc|
  llvm.func @eq_mul_constants_with_tz(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    llvm.return %3 : i1
  }]

def eq_mul_constants_with_tz_splat_before := [llvmfunc|
  llvm.func @eq_mul_constants_with_tz_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mul %arg0, %0  : vector<2xi32>
    %2 = llvm.mul %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def oss_fuzz_39934_before := [llvmfunc|
  llvm.func @oss_fuzz_39934(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-65536 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.constant(65537 : i32) : i32
    %4 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %5 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    %6 = llvm.zext %5 : i1 to i32
    %7 = llvm.or %6, %3  : i32
    %8 = llvm.mul %7, %0  : i32
    %9 = llvm.icmp "ne" %8, %4 : i32
    llvm.return %9 : i1
  }]

def mul_of_bool_before := [llvmfunc|
  llvm.func @mul_of_bool(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def mul_of_bool_commute_before := [llvmfunc|
  llvm.func @mul_of_bool_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def mul_of_bools_before := [llvmfunc|
  llvm.func @mul_of_bools(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    llvm.return %5 : i1
  }]

def not_mul_of_bool_before := [llvmfunc|
  llvm.func @not_mul_of_bool(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def not_mul_of_bool_commute_before := [llvmfunc|
  llvm.func @not_mul_of_bool_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.mul %3, %2  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def mul_of_bool_no_lz_other_op_before := [llvmfunc|
  llvm.func @mul_of_bool_no_lz_other_op(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def mul_of_pow2_before := [llvmfunc|
  llvm.func @mul_of_pow2(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(510 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def mul_of_pow2_commute_before := [llvmfunc|
  llvm.func @mul_of_pow2_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(1020 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.mul %4, %3  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    llvm.return %6 : i1
  }]

def mul_of_pow2s_before := [llvmfunc|
  llvm.func @mul_of_pow2s(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.mul %3, %4  : i32
    %6 = llvm.or %5, %2  : i32
    llvm.return %6 : i32
  }]

def not_mul_of_pow2_before := [llvmfunc|
  llvm.func @not_mul_of_pow2(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(1530 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def not_mul_of_pow2_commute_before := [llvmfunc|
  llvm.func @not_mul_of_pow2_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(3060 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.mul %4, %3  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    llvm.return %6 : i1
  }]

def mul_of_pow2_no_lz_other_op_before := [llvmfunc|
  llvm.func @mul_of_pow2_no_lz_other_op(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(254 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def splat_mul_known_lz_before := [llvmfunc|
  llvm.func @splat_mul_known_lz(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(18446744078004518913 : i128) : i128
    %1 = llvm.mlir.constant(96 : i128) : i128
    %2 = llvm.mlir.constant(0 : i128) : i128
    %3 = llvm.zext %arg0 : i32 to i128
    %4 = llvm.mul %3, %0  : i128
    %5 = llvm.lshr %4, %1  : i128
    %6 = llvm.icmp "eq" %5, %2 : i128
    llvm.return %6 : i1
  }]

def splat_mul_unknown_lz_before := [llvmfunc|
  llvm.func @splat_mul_unknown_lz(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(18446744078004518913 : i128) : i128
    %1 = llvm.mlir.constant(95 : i128) : i128
    %2 = llvm.mlir.constant(0 : i128) : i128
    %3 = llvm.zext %arg0 : i32 to i128
    %4 = llvm.mul %3, %0  : i128
    %5 = llvm.lshr %4, %1  : i128
    %6 = llvm.icmp "eq" %5, %2 : i128
    llvm.return %6 : i1
  }]

def mul_oddC_overflow_eq_before := [llvmfunc|
  llvm.func @mul_oddC_overflow_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(101 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def mul_oddC_eq_nomod_before := [llvmfunc|
  llvm.func @mul_oddC_eq_nomod(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(34 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def mul_evenC_ne_before := [llvmfunc|
  llvm.func @mul_evenC_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(36 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def mul_oddC_ne_vec_before := [llvmfunc|
  llvm.func @mul_oddC_ne_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<12> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def mul_oddC_ne_nosplat_vec_before := [llvmfunc|
  llvm.func @mul_oddC_ne_nosplat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[12, 15]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def mul_nsuw_xy_z_maybe_zero_eq_before := [llvmfunc|
  llvm.func @mul_nsuw_xy_z_maybe_zero_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg2 overflow<nsw, nuw>  : i8
    %1 = llvm.mul %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

def mul_xy_z_assumenozero_ne_before := [llvmfunc|
  llvm.func @mul_xy_z_assumenozero_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg2, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.mul %arg0, %arg2  : i8
    %3 = llvm.mul %arg1, %arg2  : i8
    %4 = llvm.icmp "ne" %3, %2 : i8
    llvm.return %4 : i1
  }]

def mul_xy_z_assumeodd_eq_before := [llvmfunc|
  llvm.func @mul_xy_z_assumeodd_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg2, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.mul %arg0, %arg2  : i8
    %5 = llvm.mul %arg2, %arg1  : i8
    %6 = llvm.icmp "eq" %4, %5 : i8
    llvm.return %6 : i1
  }]

def reused_mul_nsw_xy_z_setnonzero_vec_ne_before := [llvmfunc|
  llvm.func @reused_mul_nsw_xy_z_setnonzero_vec_ne(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg2, %0  : vector<2xi8>
    %2 = llvm.mul %1, %arg0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.mul %arg1, %1 overflow<nsw>  : vector<2xi8>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi8>
    llvm.call @usev2xi8(%3) : (vector<2xi8>) -> ()
    llvm.return %4 : vector<2xi1>
  }]

def mul_mixed_nuw_nsw_xy_z_setodd_ult_before := [llvmfunc|
  llvm.func @mul_mixed_nuw_nsw_xy_z_setodd_ult(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg2, %0  : i8
    %2 = llvm.mul %arg0, %1 overflow<nsw>  : i8
    %3 = llvm.mul %arg1, %1 overflow<nsw, nuw>  : i8
    %4 = llvm.icmp "ult" %2, %3 : i8
    llvm.return %4 : i1
  }]

def mul_nuw_xy_z_assumenonzero_uge_before := [llvmfunc|
  llvm.func @mul_nuw_xy_z_assumenonzero_uge(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg2, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.mul %arg0, %arg2 overflow<nuw>  : i8
    %3 = llvm.mul %arg1, %arg2 overflow<nuw>  : i8
    %4 = llvm.icmp "uge" %3, %2 : i8
    llvm.call @use(%2) : (i8) -> ()
    llvm.return %4 : i1
  }]

def mul_nuw_xy_z_setnonzero_vec_eq_before := [llvmfunc|
  llvm.func @mul_nuw_xy_z_setnonzero_vec_eq(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[41, 12]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg2, %0  : vector<2xi8>
    %2 = llvm.mul %1, %arg0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.mul %1, %arg1 overflow<nuw>  : vector<2xi8>
    %4 = llvm.icmp "eq" %2, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def mul_nuw_xy_z_brnonzero_ult_before := [llvmfunc|
  llvm.func @mul_nuw_xy_z_brnonzero_ult(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg2, %0 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.mul %arg0, %arg2 overflow<nuw>  : i8
    %4 = llvm.mul %arg1, %arg2 overflow<nuw>  : i8
    %5 = llvm.icmp "ult" %4, %3 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg2) : (i8) -> ()
    llvm.return %1 : i1
  }]

def reused_mul_nuw_xy_z_selectnonzero_ugt_before := [llvmfunc|
  llvm.func @reused_mul_nuw_xy_z_selectnonzero_ugt(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ne" %arg2, %0 : i8
    %3 = llvm.mul %arg0, %arg2 overflow<nuw>  : i8
    %4 = llvm.mul %arg1, %arg2 overflow<nuw>  : i8
    %5 = llvm.icmp "ugt" %4, %3 : i8
    %6 = llvm.select %2, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_before := [llvmfunc|
  llvm.func @mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg2, %0  : vector<2xi8>
    %2 = llvm.mul %arg0, %1 overflow<nuw>  : vector<2xi8>
    %3 = llvm.mul %1, %arg1 overflow<nsw>  : vector<2xi8>
    %4 = llvm.icmp "ule" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def squared_nsw_eq0_combined := [llvmfunc|
  llvm.func @squared_nsw_eq0(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.icmp "eq" %arg0, %0 : i5
    llvm.return %1 : i1
  }]

theorem inst_combine_squared_nsw_eq0   : squared_nsw_eq0_before  ⊑  squared_nsw_eq0_combined := by
  unfold squared_nsw_eq0_before squared_nsw_eq0_combined
  simp_alive_peephole
  sorry
def squared_nuw_eq0_combined := [llvmfunc|
  llvm.func @squared_nuw_eq0(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_squared_nuw_eq0   : squared_nuw_eq0_before  ⊑  squared_nuw_eq0_combined := by
  unfold squared_nuw_eq0_before squared_nuw_eq0_combined
  simp_alive_peephole
  sorry
def squared_nsw_nuw_ne0_combined := [llvmfunc|
  llvm.func @squared_nsw_nuw_ne0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mul %arg0, %arg0 overflow<nsw, nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_squared_nsw_nuw_ne0   : squared_nsw_nuw_ne0_before  ⊑  squared_nsw_nuw_ne0_combined := by
  unfold squared_nsw_nuw_ne0_before squared_nsw_nuw_ne0_combined
  simp_alive_peephole
  sorry
def squared_eq0_combined := [llvmfunc|
  llvm.func @squared_eq0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_squared_eq0   : squared_eq0_before  ⊑  squared_eq0_combined := by
  unfold squared_eq0_before squared_eq0_combined
  simp_alive_peephole
  sorry
def mul_nsw_eq0_combined := [llvmfunc|
  llvm.func @mul_nsw_eq0(%arg0: i5, %arg1: i5) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i5
    %2 = llvm.icmp "eq" %1, %0 : i5
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_nsw_eq0   : mul_nsw_eq0_before  ⊑  mul_nsw_eq0_combined := by
  unfold mul_nsw_eq0_before mul_nsw_eq0_combined
  simp_alive_peephole
  sorry
def squared_nsw_eq1_combined := [llvmfunc|
  llvm.func @squared_nsw_eq1(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.mul %arg0, %arg0 overflow<nsw>  : i5
    %2 = llvm.icmp "eq" %1, %0 : i5
    llvm.return %2 : i1
  }]

theorem inst_combine_squared_nsw_eq1   : squared_nsw_eq1_before  ⊑  squared_nsw_eq1_combined := by
  unfold squared_nsw_eq1_before squared_nsw_eq1_combined
  simp_alive_peephole
  sorry
def squared_nsw_sgt0_combined := [llvmfunc|
  llvm.func @squared_nsw_sgt0(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(0 : i5) : i5
    %1 = llvm.icmp "ne" %arg0, %0 : i5
    llvm.return %1 : i1
  }]

theorem inst_combine_squared_nsw_sgt0   : squared_nsw_sgt0_before  ⊑  squared_nsw_sgt0_combined := by
  unfold squared_nsw_sgt0_before squared_nsw_sgt0_combined
  simp_alive_peephole
  sorry
def slt_positive_multip_rem_zero_combined := [llvmfunc|
  llvm.func @slt_positive_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_positive_multip_rem_zero   : slt_positive_multip_rem_zero_before  ⊑  slt_positive_multip_rem_zero_combined := by
  unfold slt_positive_multip_rem_zero_before slt_positive_multip_rem_zero_combined
  simp_alive_peephole
  sorry
def slt_negative_multip_rem_zero_combined := [llvmfunc|
  llvm.func @slt_negative_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_negative_multip_rem_zero   : slt_negative_multip_rem_zero_before  ⊑  slt_negative_multip_rem_zero_combined := by
  unfold slt_negative_multip_rem_zero_before slt_negative_multip_rem_zero_combined
  simp_alive_peephole
  sorry
def slt_positive_multip_rem_nz_combined := [llvmfunc|
  llvm.func @slt_positive_multip_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_positive_multip_rem_nz   : slt_positive_multip_rem_nz_before  ⊑  slt_positive_multip_rem_nz_combined := by
  unfold slt_positive_multip_rem_nz_before slt_positive_multip_rem_nz_combined
  simp_alive_peephole
  sorry
def ult_rem_zero_combined := [llvmfunc|
  llvm.func @ult_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_rem_zero   : ult_rem_zero_before  ⊑  ult_rem_zero_combined := by
  unfold ult_rem_zero_before ult_rem_zero_combined
  simp_alive_peephole
  sorry
def ult_rem_zero_nsw_combined := [llvmfunc|
  llvm.func @ult_rem_zero_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_rem_zero_nsw   : ult_rem_zero_nsw_before  ⊑  ult_rem_zero_nsw_combined := by
  unfold ult_rem_zero_nsw_before ult_rem_zero_nsw_combined
  simp_alive_peephole
  sorry
def ult_rem_nz_combined := [llvmfunc|
  llvm.func @ult_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_rem_nz   : ult_rem_nz_before  ⊑  ult_rem_nz_combined := by
  unfold ult_rem_nz_before ult_rem_nz_combined
  simp_alive_peephole
  sorry
def ult_rem_nz_nsw_combined := [llvmfunc|
  llvm.func @ult_rem_nz_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_rem_nz_nsw   : ult_rem_nz_nsw_before  ⊑  ult_rem_nz_nsw_combined := by
  unfold ult_rem_nz_nsw_before ult_rem_nz_nsw_combined
  simp_alive_peephole
  sorry
def sgt_positive_multip_rem_zero_combined := [llvmfunc|
  llvm.func @sgt_positive_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_positive_multip_rem_zero   : sgt_positive_multip_rem_zero_before  ⊑  sgt_positive_multip_rem_zero_combined := by
  unfold sgt_positive_multip_rem_zero_before sgt_positive_multip_rem_zero_combined
  simp_alive_peephole
  sorry
def sgt_negative_multip_rem_zero_combined := [llvmfunc|
  llvm.func @sgt_negative_multip_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_negative_multip_rem_zero   : sgt_negative_multip_rem_zero_before  ⊑  sgt_negative_multip_rem_zero_combined := by
  unfold sgt_negative_multip_rem_zero_before sgt_negative_multip_rem_zero_combined
  simp_alive_peephole
  sorry
def sgt_positive_multip_rem_nz_combined := [llvmfunc|
  llvm.func @sgt_positive_multip_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_positive_multip_rem_nz   : sgt_positive_multip_rem_nz_before  ⊑  sgt_positive_multip_rem_nz_combined := by
  unfold sgt_positive_multip_rem_nz_before sgt_positive_multip_rem_nz_combined
  simp_alive_peephole
  sorry
def ugt_rem_zero_combined := [llvmfunc|
  llvm.func @ugt_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_rem_zero   : ugt_rem_zero_before  ⊑  ugt_rem_zero_combined := by
  unfold ugt_rem_zero_before ugt_rem_zero_combined
  simp_alive_peephole
  sorry
def ugt_rem_zero_nsw_combined := [llvmfunc|
  llvm.func @ugt_rem_zero_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_rem_zero_nsw   : ugt_rem_zero_nsw_before  ⊑  ugt_rem_zero_nsw_combined := by
  unfold ugt_rem_zero_nsw_before ugt_rem_zero_nsw_combined
  simp_alive_peephole
  sorry
def ugt_rem_nz_combined := [llvmfunc|
  llvm.func @ugt_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_rem_nz   : ugt_rem_nz_before  ⊑  ugt_rem_nz_combined := by
  unfold ugt_rem_nz_before ugt_rem_nz_combined
  simp_alive_peephole
  sorry
def ugt_rem_nz_nsw_combined := [llvmfunc|
  llvm.func @ugt_rem_nz_nsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_rem_nz_nsw   : ugt_rem_nz_nsw_before  ⊑  ugt_rem_nz_nsw_combined := by
  unfold ugt_rem_nz_nsw_before ugt_rem_nz_nsw_combined
  simp_alive_peephole
  sorry
def eq_nsw_rem_zero_combined := [llvmfunc|
  llvm.func @eq_nsw_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_eq_nsw_rem_zero   : eq_nsw_rem_zero_before  ⊑  eq_nsw_rem_zero_combined := by
  unfold eq_nsw_rem_zero_before eq_nsw_rem_zero_combined
  simp_alive_peephole
  sorry
def ne_nsw_rem_zero_combined := [llvmfunc|
  llvm.func @ne_nsw_rem_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_ne_nsw_rem_zero   : ne_nsw_rem_zero_before  ⊑  ne_nsw_rem_zero_combined := by
  unfold ne_nsw_rem_zero_before ne_nsw_rem_zero_combined
  simp_alive_peephole
  sorry
def ne_nsw_rem_zero_undef1_combined := [llvmfunc|
  llvm.func @ne_nsw_rem_zero_undef1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<-30> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mul %arg0, %6 overflow<nsw>  : vector<2xi8>
    %9 = llvm.icmp "ne" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_ne_nsw_rem_zero_undef1   : ne_nsw_rem_zero_undef1_before  ⊑  ne_nsw_rem_zero_undef1_combined := by
  unfold ne_nsw_rem_zero_undef1_before ne_nsw_rem_zero_undef1_combined
  simp_alive_peephole
  sorry
def ne_nsw_rem_zero_undef2_combined := [llvmfunc|
  llvm.func @ne_nsw_rem_zero_undef2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.constant(-30 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mul %arg0, %0 overflow<nsw>  : vector<2xi8>
    %9 = llvm.icmp "ne" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_ne_nsw_rem_zero_undef2   : ne_nsw_rem_zero_undef2_before  ⊑  ne_nsw_rem_zero_undef2_combined := by
  unfold ne_nsw_rem_zero_undef2_before ne_nsw_rem_zero_undef2_combined
  simp_alive_peephole
  sorry
def eq_nsw_rem_zero_uses_combined := [llvmfunc|
  llvm.func @eq_nsw_rem_zero_uses(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_eq_nsw_rem_zero_uses   : eq_nsw_rem_zero_uses_before  ⊑  eq_nsw_rem_zero_uses_combined := by
  unfold eq_nsw_rem_zero_uses_before eq_nsw_rem_zero_uses_combined
  simp_alive_peephole
  sorry
def eq_nsw_rem_nz_combined := [llvmfunc|
  llvm.func @eq_nsw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_nsw_rem_nz   : eq_nsw_rem_nz_before  ⊑  eq_nsw_rem_nz_combined := by
  unfold eq_nsw_rem_nz_before eq_nsw_rem_nz_combined
  simp_alive_peephole
  sorry
def ne_nsw_rem_nz_combined := [llvmfunc|
  llvm.func @ne_nsw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_nsw_rem_nz   : ne_nsw_rem_nz_before  ⊑  ne_nsw_rem_nz_combined := by
  unfold ne_nsw_rem_nz_before ne_nsw_rem_nz_combined
  simp_alive_peephole
  sorry
def eq_nuw_rem_zero_combined := [llvmfunc|
  llvm.func @eq_nuw_rem_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_eq_nuw_rem_zero   : eq_nuw_rem_zero_before  ⊑  eq_nuw_rem_zero_combined := by
  unfold eq_nuw_rem_zero_before eq_nuw_rem_zero_combined
  simp_alive_peephole
  sorry
def eq_nuw_rem_zero_undef1_combined := [llvmfunc|
  llvm.func @eq_nuw_rem_zero_undef1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<20> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.mul %arg0, %6 overflow<nuw>  : vector<2xi8>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_eq_nuw_rem_zero_undef1   : eq_nuw_rem_zero_undef1_before  ⊑  eq_nuw_rem_zero_undef1_combined := by
  unfold eq_nuw_rem_zero_undef1_before eq_nuw_rem_zero_undef1_combined
  simp_alive_peephole
  sorry
def eq_nuw_rem_zero_undef2_combined := [llvmfunc|
  llvm.func @eq_nuw_rem_zero_undef2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mul %arg0, %0 overflow<nuw>  : vector<2xi8>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_eq_nuw_rem_zero_undef2   : eq_nuw_rem_zero_undef2_before  ⊑  eq_nuw_rem_zero_undef2_combined := by
  unfold eq_nuw_rem_zero_undef2_before eq_nuw_rem_zero_undef2_combined
  simp_alive_peephole
  sorry
def ne_nuw_rem_zero_combined := [llvmfunc|
  llvm.func @ne_nuw_rem_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(26 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ne_nuw_rem_zero   : ne_nuw_rem_zero_before  ⊑  ne_nuw_rem_zero_combined := by
  unfold ne_nuw_rem_zero_before ne_nuw_rem_zero_combined
  simp_alive_peephole
  sorry
def ne_nuw_rem_zero_uses_combined := [llvmfunc|
  llvm.func @ne_nuw_rem_zero_uses(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ne_nuw_rem_zero_uses   : ne_nuw_rem_zero_uses_before  ⊑  ne_nuw_rem_zero_uses_combined := by
  unfold ne_nuw_rem_zero_uses_before ne_nuw_rem_zero_uses_combined
  simp_alive_peephole
  sorry
def eq_nuw_rem_nz_combined := [llvmfunc|
  llvm.func @eq_nuw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_nuw_rem_nz   : eq_nuw_rem_nz_before  ⊑  eq_nuw_rem_nz_combined := by
  unfold eq_nuw_rem_nz_before eq_nuw_rem_nz_combined
  simp_alive_peephole
  sorry
def ne_nuw_rem_nz_combined := [llvmfunc|
  llvm.func @ne_nuw_rem_nz(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ne_nuw_rem_nz   : ne_nuw_rem_nz_before  ⊑  ne_nuw_rem_nz_combined := by
  unfold ne_nuw_rem_nz_before ne_nuw_rem_nz_combined
  simp_alive_peephole
  sorry
def sgt_positive_multip_rem_zero_nonsw_combined := [llvmfunc|
  llvm.func @sgt_positive_multip_rem_zero_nonsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_positive_multip_rem_zero_nonsw   : sgt_positive_multip_rem_zero_nonsw_before  ⊑  sgt_positive_multip_rem_zero_nonsw_combined := by
  unfold sgt_positive_multip_rem_zero_nonsw_before sgt_positive_multip_rem_zero_nonsw_combined
  simp_alive_peephole
  sorry
def ult_multip_rem_zero_nonsw_combined := [llvmfunc|
  llvm.func @ult_multip_rem_zero_nonsw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ult_multip_rem_zero_nonsw   : ult_multip_rem_zero_nonsw_before  ⊑  ult_multip_rem_zero_nonsw_combined := by
  unfold ult_multip_rem_zero_nonsw_before ult_multip_rem_zero_nonsw_combined
  simp_alive_peephole
  sorry
def ugt_rem_zero_nonuw_combined := [llvmfunc|
  llvm.func @ugt_rem_zero_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(21 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ugt_rem_zero_nonuw   : ugt_rem_zero_nonuw_before  ⊑  ugt_rem_zero_nonuw_combined := by
  unfold ugt_rem_zero_nonuw_before ugt_rem_zero_nonuw_combined
  simp_alive_peephole
  sorry
def sgt_minnum_combined := [llvmfunc|
  llvm.func @sgt_minnum(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_minnum   : sgt_minnum_before  ⊑  sgt_minnum_combined := by
  unfold sgt_minnum_before sgt_minnum_combined
  simp_alive_peephole
  sorry
def ule_bignum_combined := [llvmfunc|
  llvm.func @ule_bignum(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_bignum   : ule_bignum_before  ⊑  ule_bignum_combined := by
  unfold ule_bignum_before ule_bignum_combined
  simp_alive_peephole
  sorry
def sgt_mulzero_combined := [llvmfunc|
  llvm.func @sgt_mulzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_mulzero   : sgt_mulzero_before  ⊑  sgt_mulzero_combined := by
  unfold sgt_mulzero_before sgt_mulzero_combined
  simp_alive_peephole
  sorry
def eq_rem_zero_nonuw_combined := [llvmfunc|
  llvm.func @eq_rem_zero_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_eq_rem_zero_nonuw   : eq_rem_zero_nonuw_before  ⊑  eq_rem_zero_nonuw_combined := by
  unfold eq_rem_zero_nonuw_before eq_rem_zero_nonuw_combined
  simp_alive_peephole
  sorry
def ne_rem_zero_nonuw_combined := [llvmfunc|
  llvm.func @ne_rem_zero_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ne_rem_zero_nonuw   : ne_rem_zero_nonuw_before  ⊑  ne_rem_zero_nonuw_combined := by
  unfold ne_rem_zero_nonuw_before ne_rem_zero_nonuw_combined
  simp_alive_peephole
  sorry
def mul_constant_eq_combined := [llvmfunc|
  llvm.func @mul_constant_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_mul_constant_eq   : mul_constant_eq_before  ⊑  mul_constant_eq_combined := by
  unfold mul_constant_eq_before mul_constant_eq_combined
  simp_alive_peephole
  sorry
def mul_constant_ne_splat_combined := [llvmfunc|
  llvm.func @mul_constant_ne_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_mul_constant_ne_splat   : mul_constant_ne_splat_before  ⊑  mul_constant_ne_splat_combined := by
  unfold mul_constant_ne_splat_before mul_constant_ne_splat_combined
  simp_alive_peephole
  sorry
def mul_constant_ne_extra_use1_combined := [llvmfunc|
  llvm.func @mul_constant_ne_extra_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_constant_ne_extra_use1   : mul_constant_ne_extra_use1_before  ⊑  mul_constant_ne_extra_use1_combined := by
  unfold mul_constant_ne_extra_use1_before mul_constant_ne_extra_use1_combined
  simp_alive_peephole
  sorry
def mul_constant_eq_extra_use2_combined := [llvmfunc|
  llvm.func @mul_constant_eq_extra_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mul %arg1, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_constant_eq_extra_use2   : mul_constant_eq_extra_use2_before  ⊑  mul_constant_eq_extra_use2_combined := by
  unfold mul_constant_eq_extra_use2_before mul_constant_eq_extra_use2_combined
  simp_alive_peephole
  sorry
def mul_constant_ne_extra_use3_combined := [llvmfunc|
  llvm.func @mul_constant_ne_extra_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_constant_ne_extra_use3   : mul_constant_ne_extra_use3_before  ⊑  mul_constant_ne_extra_use3_combined := by
  unfold mul_constant_ne_extra_use3_before mul_constant_ne_extra_use3_combined
  simp_alive_peephole
  sorry
def mul_constant_eq_nsw_combined := [llvmfunc|
  llvm.func @mul_constant_eq_nsw(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_mul_constant_eq_nsw   : mul_constant_eq_nsw_before  ⊑  mul_constant_eq_nsw_combined := by
  unfold mul_constant_eq_nsw_before mul_constant_eq_nsw_combined
  simp_alive_peephole
  sorry
def mul_constant_ne_nsw_splat_combined := [llvmfunc|
  llvm.func @mul_constant_ne_nsw_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_mul_constant_ne_nsw_splat   : mul_constant_ne_nsw_splat_before  ⊑  mul_constant_ne_nsw_splat_combined := by
  unfold mul_constant_ne_nsw_splat_before mul_constant_ne_nsw_splat_combined
  simp_alive_peephole
  sorry
def mul_constant_ne_nsw_extra_use1_combined := [llvmfunc|
  llvm.func @mul_constant_ne_nsw_extra_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(74 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_constant_ne_nsw_extra_use1   : mul_constant_ne_nsw_extra_use1_before  ⊑  mul_constant_ne_nsw_extra_use1_combined := by
  unfold mul_constant_ne_nsw_extra_use1_before mul_constant_ne_nsw_extra_use1_combined
  simp_alive_peephole
  sorry
def mul_constant_eq_nsw_extra_use2_combined := [llvmfunc|
  llvm.func @mul_constant_eq_nsw_extra_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mul %arg1, %0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_constant_eq_nsw_extra_use2   : mul_constant_eq_nsw_extra_use2_before  ⊑  mul_constant_eq_nsw_extra_use2_combined := by
  unfold mul_constant_eq_nsw_extra_use2_before mul_constant_eq_nsw_extra_use2_combined
  simp_alive_peephole
  sorry
def mul_constant_ne_nsw_extra_use3_combined := [llvmfunc|
  llvm.func @mul_constant_ne_nsw_extra_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nsw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_constant_ne_nsw_extra_use3   : mul_constant_ne_nsw_extra_use3_before  ⊑  mul_constant_ne_nsw_extra_use3_combined := by
  unfold mul_constant_ne_nsw_extra_use3_before mul_constant_ne_nsw_extra_use3_combined
  simp_alive_peephole
  sorry
def mul_constant_nuw_eq_combined := [llvmfunc|
  llvm.func @mul_constant_nuw_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_mul_constant_nuw_eq   : mul_constant_nuw_eq_before  ⊑  mul_constant_nuw_eq_combined := by
  unfold mul_constant_nuw_eq_before mul_constant_nuw_eq_combined
  simp_alive_peephole
  sorry
def mul_constant_ne_nuw_splat_combined := [llvmfunc|
  llvm.func @mul_constant_ne_nuw_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_mul_constant_ne_nuw_splat   : mul_constant_ne_nuw_splat_before  ⊑  mul_constant_ne_nuw_splat_combined := by
  unfold mul_constant_ne_nuw_splat_before mul_constant_ne_nuw_splat_combined
  simp_alive_peephole
  sorry
def mul_constant_ne_nuw_extra_use1_combined := [llvmfunc|
  llvm.func @mul_constant_ne_nuw_extra_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_constant_ne_nuw_extra_use1   : mul_constant_ne_nuw_extra_use1_before  ⊑  mul_constant_ne_nuw_extra_use1_combined := by
  unfold mul_constant_ne_nuw_extra_use1_before mul_constant_ne_nuw_extra_use1_combined
  simp_alive_peephole
  sorry
def mul_constant_eq_nuw_extra_use2_combined := [llvmfunc|
  llvm.func @mul_constant_eq_nuw_extra_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(36 : i8) : i8
    %1 = llvm.mul %arg1, %0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_constant_eq_nuw_extra_use2   : mul_constant_eq_nuw_extra_use2_before  ⊑  mul_constant_eq_nuw_extra_use2_combined := by
  unfold mul_constant_eq_nuw_extra_use2_before mul_constant_eq_nuw_extra_use2_combined
  simp_alive_peephole
  sorry
def mul_constant_ne_nuw_extra_use3_combined := [llvmfunc|
  llvm.func @mul_constant_ne_nuw_extra_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(38 : i8) : i8
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_constant_ne_nuw_extra_use3   : mul_constant_ne_nuw_extra_use3_before  ⊑  mul_constant_ne_nuw_extra_use3_combined := by
  unfold mul_constant_ne_nuw_extra_use3_before mul_constant_ne_nuw_extra_use3_combined
  simp_alive_peephole
  sorry
def mul_constant_ult_combined := [llvmfunc|
  llvm.func @mul_constant_ult(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(47 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_constant_ult   : mul_constant_ult_before  ⊑  mul_constant_ult_combined := by
  unfold mul_constant_ult_before mul_constant_ult_combined
  simp_alive_peephole
  sorry
def mul_constant_nuw_sgt_combined := [llvmfunc|
  llvm.func @mul_constant_nuw_sgt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(46 : i32) : i32
    %1 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %2 = llvm.mul %arg1, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "sgt" %1, %2 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_constant_nuw_sgt   : mul_constant_nuw_sgt_before  ⊑  mul_constant_nuw_sgt_combined := by
  unfold mul_constant_nuw_sgt_before mul_constant_nuw_sgt_combined
  simp_alive_peephole
  sorry
def mul_mismatch_constant_nuw_eq_combined := [llvmfunc|
  llvm.func @mul_mismatch_constant_nuw_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(46 : i32) : i32
    %1 = llvm.mlir.constant(44 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.mul %arg1, %1 overflow<nuw>  : i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_mul_mismatch_constant_nuw_eq   : mul_mismatch_constant_nuw_eq_before  ⊑  mul_mismatch_constant_nuw_eq_combined := by
  unfold mul_mismatch_constant_nuw_eq_before mul_mismatch_constant_nuw_eq_combined
  simp_alive_peephole
  sorry
def mul_constant_partial_nuw_eq_combined := [llvmfunc|
  llvm.func @mul_constant_partial_nuw_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_mul_constant_partial_nuw_eq   : mul_constant_partial_nuw_eq_before  ⊑  mul_constant_partial_nuw_eq_combined := by
  unfold mul_constant_partial_nuw_eq_before mul_constant_partial_nuw_eq_combined
  simp_alive_peephole
  sorry
def mul_constant_mismatch_wrap_eq_combined := [llvmfunc|
  llvm.func @mul_constant_mismatch_wrap_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_mul_constant_mismatch_wrap_eq   : mul_constant_mismatch_wrap_eq_before  ⊑  mul_constant_mismatch_wrap_eq_combined := by
  unfold mul_constant_mismatch_wrap_eq_before mul_constant_mismatch_wrap_eq_combined
  simp_alive_peephole
  sorry
def eq_mul_constants_with_tz_combined := [llvmfunc|
  llvm.func @eq_mul_constants_with_tz(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_eq_mul_constants_with_tz   : eq_mul_constants_with_tz_before  ⊑  eq_mul_constants_with_tz_combined := by
  unfold eq_mul_constants_with_tz_before eq_mul_constants_with_tz_combined
  simp_alive_peephole
  sorry
def eq_mul_constants_with_tz_splat_combined := [llvmfunc|
  llvm.func @eq_mul_constants_with_tz_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi32>
    %4 = llvm.and %3, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_eq_mul_constants_with_tz_splat   : eq_mul_constants_with_tz_splat_before  ⊑  eq_mul_constants_with_tz_splat_combined := by
  unfold eq_mul_constants_with_tz_splat_before eq_mul_constants_with_tz_splat_combined
  simp_alive_peephole
  sorry
def oss_fuzz_39934_combined := [llvmfunc|
  llvm.func @oss_fuzz_39934(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_oss_fuzz_39934   : oss_fuzz_39934_before  ⊑  oss_fuzz_39934_combined := by
  unfold oss_fuzz_39934_before oss_fuzz_39934_combined
  simp_alive_peephole
  sorry
def mul_of_bool_combined := [llvmfunc|
  llvm.func @mul_of_bool(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_mul_of_bool   : mul_of_bool_before  ⊑  mul_of_bool_combined := by
  unfold mul_of_bool_before mul_of_bool_combined
  simp_alive_peephole
  sorry
def mul_of_bool_commute_combined := [llvmfunc|
  llvm.func @mul_of_bool_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_mul_of_bool_commute   : mul_of_bool_commute_before  ⊑  mul_of_bool_commute_combined := by
  unfold mul_of_bool_commute_before mul_of_bool_commute_combined
  simp_alive_peephole
  sorry
def mul_of_bools_combined := [llvmfunc|
  llvm.func @mul_of_bools(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_mul_of_bools   : mul_of_bools_before  ⊑  mul_of_bools_combined := by
  unfold mul_of_bools_before mul_of_bools_combined
  simp_alive_peephole
  sorry
def not_mul_of_bool_combined := [llvmfunc|
  llvm.func @not_mul_of_bool(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_not_mul_of_bool   : not_mul_of_bool_before  ⊑  not_mul_of_bool_combined := by
  unfold not_mul_of_bool_before not_mul_of_bool_combined
  simp_alive_peephole
  sorry
def not_mul_of_bool_commute_combined := [llvmfunc|
  llvm.func @not_mul_of_bool_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.mul %3, %2 overflow<nsw, nuw>  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_not_mul_of_bool_commute   : not_mul_of_bool_commute_before  ⊑  not_mul_of_bool_commute_combined := by
  unfold not_mul_of_bool_commute_before not_mul_of_bool_commute_combined
  simp_alive_peephole
  sorry
def mul_of_bool_no_lz_other_op_combined := [llvmfunc|
  llvm.func @mul_of_bool_no_lz_other_op(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_mul_of_bool_no_lz_other_op   : mul_of_bool_no_lz_other_op_before  ⊑  mul_of_bool_no_lz_other_op_combined := by
  unfold mul_of_bool_no_lz_other_op_before mul_of_bool_no_lz_other_op_combined
  simp_alive_peephole
  sorry
def mul_of_pow2_combined := [llvmfunc|
  llvm.func @mul_of_pow2(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_mul_of_pow2   : mul_of_pow2_before  ⊑  mul_of_pow2_combined := by
  unfold mul_of_pow2_before mul_of_pow2_combined
  simp_alive_peephole
  sorry
def mul_of_pow2_commute_combined := [llvmfunc|
  llvm.func @mul_of_pow2_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_mul_of_pow2_commute   : mul_of_pow2_commute_before  ⊑  mul_of_pow2_commute_combined := by
  unfold mul_of_pow2_commute_before mul_of_pow2_commute_combined
  simp_alive_peephole
  sorry
def mul_of_pow2s_combined := [llvmfunc|
  llvm.func @mul_of_pow2s(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_mul_of_pow2s   : mul_of_pow2s_before  ⊑  mul_of_pow2s_combined := by
  unfold mul_of_pow2s_before mul_of_pow2s_combined
  simp_alive_peephole
  sorry
def not_mul_of_pow2_combined := [llvmfunc|
  llvm.func @not_mul_of_pow2(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(1530 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.zext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.icmp "ugt" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_not_mul_of_pow2   : not_mul_of_pow2_before  ⊑  not_mul_of_pow2_combined := by
  unfold not_mul_of_pow2_before not_mul_of_pow2_combined
  simp_alive_peephole
  sorry
def not_mul_of_pow2_commute_combined := [llvmfunc|
  llvm.func @not_mul_of_pow2_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(3060 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.mul %4, %3 overflow<nsw, nuw>  : i32
    %6 = llvm.icmp "ugt" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_not_mul_of_pow2_commute   : not_mul_of_pow2_commute_before  ⊑  not_mul_of_pow2_commute_combined := by
  unfold not_mul_of_pow2_commute_before not_mul_of_pow2_commute_combined
  simp_alive_peephole
  sorry
def mul_of_pow2_no_lz_other_op_combined := [llvmfunc|
  llvm.func @mul_of_pow2_no_lz_other_op(%arg0: i32, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(254 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.mul %2, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_mul_of_pow2_no_lz_other_op   : mul_of_pow2_no_lz_other_op_before  ⊑  mul_of_pow2_no_lz_other_op_combined := by
  unfold mul_of_pow2_no_lz_other_op_before mul_of_pow2_no_lz_other_op_combined
  simp_alive_peephole
  sorry
def splat_mul_known_lz_combined := [llvmfunc|
  llvm.func @splat_mul_known_lz(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_splat_mul_known_lz   : splat_mul_known_lz_before  ⊑  splat_mul_known_lz_combined := by
  unfold splat_mul_known_lz_before splat_mul_known_lz_combined
  simp_alive_peephole
  sorry
def splat_mul_unknown_lz_combined := [llvmfunc|
  llvm.func @splat_mul_unknown_lz(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_splat_mul_unknown_lz   : splat_mul_unknown_lz_before  ⊑  splat_mul_unknown_lz_combined := by
  unfold splat_mul_unknown_lz_before splat_mul_unknown_lz_combined
  simp_alive_peephole
  sorry
def mul_oddC_overflow_eq_combined := [llvmfunc|
  llvm.func @mul_oddC_overflow_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(101 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_oddC_overflow_eq   : mul_oddC_overflow_eq_before  ⊑  mul_oddC_overflow_eq_combined := by
  unfold mul_oddC_overflow_eq_before mul_oddC_overflow_eq_combined
  simp_alive_peephole
  sorry
def mul_oddC_eq_nomod_combined := [llvmfunc|
  llvm.func @mul_oddC_eq_nomod(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(34 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_oddC_eq_nomod   : mul_oddC_eq_nomod_before  ⊑  mul_oddC_eq_nomod_combined := by
  unfold mul_oddC_eq_nomod_before mul_oddC_eq_nomod_combined
  simp_alive_peephole
  sorry
def mul_evenC_ne_combined := [llvmfunc|
  llvm.func @mul_evenC_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(36 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_evenC_ne   : mul_evenC_ne_before  ⊑  mul_evenC_ne_combined := by
  unfold mul_evenC_ne_before mul_evenC_ne_combined
  simp_alive_peephole
  sorry
def mul_oddC_ne_vec_combined := [llvmfunc|
  llvm.func @mul_oddC_ne_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_mul_oddC_ne_vec   : mul_oddC_ne_vec_before  ⊑  mul_oddC_ne_vec_combined := by
  unfold mul_oddC_ne_vec_before mul_oddC_ne_vec_combined
  simp_alive_peephole
  sorry
def mul_oddC_ne_nosplat_vec_combined := [llvmfunc|
  llvm.func @mul_oddC_ne_nosplat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[12, 15]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_mul_oddC_ne_nosplat_vec   : mul_oddC_ne_nosplat_vec_before  ⊑  mul_oddC_ne_nosplat_vec_combined := by
  unfold mul_oddC_ne_nosplat_vec_before mul_oddC_ne_nosplat_vec_combined
  simp_alive_peephole
  sorry
def mul_nsuw_xy_z_maybe_zero_eq_combined := [llvmfunc|
  llvm.func @mul_nsuw_xy_z_maybe_zero_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg2 overflow<nsw, nuw>  : i8
    %1 = llvm.mul %arg1, %arg2 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_mul_nsuw_xy_z_maybe_zero_eq   : mul_nsuw_xy_z_maybe_zero_eq_before  ⊑  mul_nsuw_xy_z_maybe_zero_eq_combined := by
  unfold mul_nsuw_xy_z_maybe_zero_eq_before mul_nsuw_xy_z_maybe_zero_eq_combined
  simp_alive_peephole
  sorry
def mul_xy_z_assumenozero_ne_combined := [llvmfunc|
  llvm.func @mul_xy_z_assumenozero_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg2, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.mul %arg0, %arg2  : i8
    %3 = llvm.mul %arg1, %arg2  : i8
    %4 = llvm.icmp "ne" %3, %2 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_mul_xy_z_assumenozero_ne   : mul_xy_z_assumenozero_ne_before  ⊑  mul_xy_z_assumenozero_ne_combined := by
  unfold mul_xy_z_assumenozero_ne_before mul_xy_z_assumenozero_ne_combined
  simp_alive_peephole
  sorry
def mul_xy_z_assumeodd_eq_combined := [llvmfunc|
  llvm.func @mul_xy_z_assumeodd_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg2, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_mul_xy_z_assumeodd_eq   : mul_xy_z_assumeodd_eq_before  ⊑  mul_xy_z_assumeodd_eq_combined := by
  unfold mul_xy_z_assumeodd_eq_before mul_xy_z_assumeodd_eq_combined
  simp_alive_peephole
  sorry
def reused_mul_nsw_xy_z_setnonzero_vec_ne_combined := [llvmfunc|
  llvm.func @reused_mul_nsw_xy_z_setnonzero_vec_ne(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg2, %0  : vector<2xi8>
    %2 = llvm.mul %1, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "ne" %arg1, %arg0 : vector<2xi8>
    llvm.call @usev2xi8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_reused_mul_nsw_xy_z_setnonzero_vec_ne   : reused_mul_nsw_xy_z_setnonzero_vec_ne_before  ⊑  reused_mul_nsw_xy_z_setnonzero_vec_ne_combined := by
  unfold reused_mul_nsw_xy_z_setnonzero_vec_ne_before reused_mul_nsw_xy_z_setnonzero_vec_ne_combined
  simp_alive_peephole
  sorry
def mul_mixed_nuw_nsw_xy_z_setodd_ult_combined := [llvmfunc|
  llvm.func @mul_mixed_nuw_nsw_xy_z_setodd_ult(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg2, %0  : i8
    %2 = llvm.mul %1, %arg0 overflow<nsw>  : i8
    %3 = llvm.mul %1, %arg1 overflow<nsw, nuw>  : i8
    %4 = llvm.icmp "ult" %2, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_mul_mixed_nuw_nsw_xy_z_setodd_ult   : mul_mixed_nuw_nsw_xy_z_setodd_ult_before  ⊑  mul_mixed_nuw_nsw_xy_z_setodd_ult_combined := by
  unfold mul_mixed_nuw_nsw_xy_z_setodd_ult_before mul_mixed_nuw_nsw_xy_z_setodd_ult_combined
  simp_alive_peephole
  sorry
def mul_nuw_xy_z_assumenonzero_uge_combined := [llvmfunc|
  llvm.func @mul_nuw_xy_z_assumenonzero_uge(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg2, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.mul %arg0, %arg2 overflow<nuw>  : i8
    %3 = llvm.icmp "uge" %arg1, %arg0 : i8
    llvm.call @use(%2) : (i8) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_mul_nuw_xy_z_assumenonzero_uge   : mul_nuw_xy_z_assumenonzero_uge_before  ⊑  mul_nuw_xy_z_assumenonzero_uge_combined := by
  unfold mul_nuw_xy_z_assumenonzero_uge_before mul_nuw_xy_z_assumenonzero_uge_combined
  simp_alive_peephole
  sorry
def mul_nuw_xy_z_setnonzero_vec_eq_combined := [llvmfunc|
  llvm.func @mul_nuw_xy_z_setnonzero_vec_eq(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<2xi8>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_mul_nuw_xy_z_setnonzero_vec_eq   : mul_nuw_xy_z_setnonzero_vec_eq_before  ⊑  mul_nuw_xy_z_setnonzero_vec_eq_combined := by
  unfold mul_nuw_xy_z_setnonzero_vec_eq_before mul_nuw_xy_z_setnonzero_vec_eq_combined
  simp_alive_peephole
  sorry
def mul_nuw_xy_z_brnonzero_ult_combined := [llvmfunc|
  llvm.func @mul_nuw_xy_z_brnonzero_ult(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg2, %0 : i8
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "ult" %arg1, %arg0 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg2) : (i8) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_mul_nuw_xy_z_brnonzero_ult   : mul_nuw_xy_z_brnonzero_ult_before  ⊑  mul_nuw_xy_z_brnonzero_ult_combined := by
  unfold mul_nuw_xy_z_brnonzero_ult_before mul_nuw_xy_z_brnonzero_ult_combined
  simp_alive_peephole
  sorry
def reused_mul_nuw_xy_z_selectnonzero_ugt_combined := [llvmfunc|
  llvm.func @reused_mul_nuw_xy_z_selectnonzero_ugt(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "eq" %arg2, %0 : i8
    %3 = llvm.mul %arg0, %arg2 overflow<nuw>  : i8
    %4 = llvm.mul %arg1, %arg2 overflow<nuw>  : i8
    %5 = llvm.icmp "ugt" %4, %3 : i8
    %6 = llvm.select %2, %1, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_reused_mul_nuw_xy_z_selectnonzero_ugt   : reused_mul_nuw_xy_z_selectnonzero_ugt_before  ⊑  reused_mul_nuw_xy_z_selectnonzero_ugt_combined := by
  unfold reused_mul_nuw_xy_z_selectnonzero_ugt_before reused_mul_nuw_xy_z_selectnonzero_ugt_combined
  simp_alive_peephole
  sorry
def mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_combined := [llvmfunc|
  llvm.func @mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg2, %0  : vector<2xi8>
    %2 = llvm.mul %1, %arg0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.mul %1, %arg1 overflow<nsw>  : vector<2xi8>
    %4 = llvm.icmp "ule" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule   : mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_before  ⊑  mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_combined := by
  unfold mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_before mul_mixed_nsw_nuw_xy_z_setnonzero_vec_ule_combined
  simp_alive_peephole
  sorry
