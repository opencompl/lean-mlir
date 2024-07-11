import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  signed-truncation-check
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def positive_with_signbit_before := [llvmfunc|
  llvm.func @positive_with_signbit(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def positive_with_signbit_logical_before := [llvmfunc|
  llvm.func @positive_with_signbit_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

def positive_with_mask_before := [llvmfunc|
  llvm.func @positive_with_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1107296256 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def positive_with_mask_logical_before := [llvmfunc|
  llvm.func @positive_with_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1107296256 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.add %arg0, %2  : i32
    %8 = llvm.icmp "ult" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def positive_with_icmp_before := [llvmfunc|
  llvm.func @positive_with_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(512 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def positive_with_icmp_logical_before := [llvmfunc|
  llvm.func @positive_with_icmp_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(512 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "ult" %arg0, %0 : i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

def positive_with_aggressive_icmp_before := [llvmfunc|
  llvm.func @positive_with_aggressive_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(512 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def positive_with_aggressive_icmp_logical_before := [llvmfunc|
  llvm.func @positive_with_aggressive_icmp_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(512 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "ult" %arg0, %0 : i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

def positive_with_extra_and_before := [llvmfunc|
  llvm.func @positive_with_extra_and(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.and %3, %arg1  : i1
    %7 = llvm.and %5, %6  : i1
    llvm.return %7 : i1
  }]

def positive_with_extra_and_logical_before := [llvmfunc|
  llvm.func @positive_with_extra_and_logical(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %4, %arg1, %3 : i1, i1
    %8 = llvm.select %6, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def positive_vec_splat_before := [llvmfunc|
  llvm.func @positive_vec_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<256> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.add %arg0, %1  : vector<2xi32>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi32>
    %6 = llvm.and %3, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def positive_vec_nonsplat_before := [llvmfunc|
  llvm.func @positive_vec_nonsplat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[128, 256]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[256, 512]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.add %arg0, %1  : vector<2xi32>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi32>
    %6 = llvm.and %3, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def positive_vec_poison0_before := [llvmfunc|
  llvm.func @positive_vec_poison0(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<128> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.mlir.constant(dense<256> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.icmp "sgt" %arg0, %8 : vector<3xi32>
    %12 = llvm.add %arg0, %9  : vector<3xi32>
    %13 = llvm.icmp "ult" %12, %10 : vector<3xi32>
    %14 = llvm.and %11, %13  : vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

def positive_vec_poison1_before := [llvmfunc|
  llvm.func @positive_vec_poison1(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(dense<256> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.icmp "sgt" %arg0, %0 : vector<3xi32>
    %12 = llvm.add %arg0, %9  : vector<3xi32>
    %13 = llvm.icmp "ult" %12, %10 : vector<3xi32>
    %14 = llvm.and %11, %13  : vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

def positive_vec_poison2_before := [llvmfunc|
  llvm.func @positive_vec_poison2(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<128> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.undef : vector<3xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi32>
    %11 = llvm.icmp "sgt" %arg0, %0 : vector<3xi32>
    %12 = llvm.add %arg0, %1  : vector<3xi32>
    %13 = llvm.icmp "ult" %12, %10 : vector<3xi32>
    %14 = llvm.and %11, %13  : vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

def positive_vec_poison3_before := [llvmfunc|
  llvm.func @positive_vec_poison3(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(128 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.constant(dense<256> : vector<3xi32>) : vector<3xi32>
    %18 = llvm.icmp "sgt" %arg0, %8 : vector<3xi32>
    %19 = llvm.add %arg0, %16  : vector<3xi32>
    %20 = llvm.icmp "ult" %19, %17 : vector<3xi32>
    %21 = llvm.and %18, %20  : vector<3xi1>
    llvm.return %21 : vector<3xi1>
  }]

def positive_vec_poison4_before := [llvmfunc|
  llvm.func @positive_vec_poison4(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<128> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.mlir.constant(256 : i32) : i32
    %11 = llvm.mlir.undef : vector<3xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi32>
    %18 = llvm.icmp "sgt" %arg0, %8 : vector<3xi32>
    %19 = llvm.add %arg0, %9  : vector<3xi32>
    %20 = llvm.icmp "ult" %19, %17 : vector<3xi32>
    %21 = llvm.and %18, %20  : vector<3xi1>
    llvm.return %21 : vector<3xi1>
  }]

def positive_vec_poison5_before := [llvmfunc|
  llvm.func @positive_vec_poison5(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(256 : i32) : i32
    %11 = llvm.mlir.undef : vector<3xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<3xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi32>
    %18 = llvm.icmp "sgt" %arg0, %0 : vector<3xi32>
    %19 = llvm.add %arg0, %9  : vector<3xi32>
    %20 = llvm.icmp "ult" %19, %17 : vector<3xi32>
    %21 = llvm.and %18, %20  : vector<3xi1>
    llvm.return %21 : vector<3xi1>
  }]

def positive_vec_poison6_before := [llvmfunc|
  llvm.func @positive_vec_poison6(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(128 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.constant(256 : i32) : i32
    %18 = llvm.mlir.undef : vector<3xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<3xi32>
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<3xi32>
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.insertelement %17, %22[%23 : i32] : vector<3xi32>
    %25 = llvm.icmp "sgt" %arg0, %8 : vector<3xi32>
    %26 = llvm.add %arg0, %16  : vector<3xi32>
    %27 = llvm.icmp "ult" %26, %24 : vector<3xi32>
    %28 = llvm.and %25, %27  : vector<3xi1>
    llvm.return %28 : vector<3xi1>
  }]

def commutative_before := [llvmfunc|
  llvm.func @commutative() -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.call @gen32() : () -> i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    %5 = llvm.add %3, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }]

def commutative_logical_before := [llvmfunc|
  llvm.func @commutative_logical() -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.call @gen32() : () -> i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.add %4, %1  : i32
    %7 = llvm.icmp "ult" %6, %2 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }]

def commutative_with_icmp_before := [llvmfunc|
  llvm.func @commutative_with_icmp() -> i1 {
    %0 = llvm.mlir.constant(512 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.call @gen32() : () -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.add %3, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.and %6, %4  : i1
    llvm.return %7 : i1
  }]

def commutative_with_icmp_logical_before := [llvmfunc|
  llvm.func @commutative_with_icmp_logical() -> i1 {
    %0 = llvm.mlir.constant(512 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.call @gen32() : () -> i32
    %5 = llvm.icmp "ult" %4, %0 : i32
    %6 = llvm.add %4, %1  : i32
    %7 = llvm.icmp "ult" %6, %2 : i32
    %8 = llvm.select %7, %5, %3 : i1, i1
    llvm.return %8 : i1
  }]

def positive_trunc_signbit_before := [llvmfunc|
  llvm.func @positive_trunc_signbit(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "sgt" %3, %0 : i8
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def positive_trunc_signbit_logical_before := [llvmfunc|
  llvm.func @positive_trunc_signbit_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.icmp "sgt" %4, %0 : i8
    %6 = llvm.add %arg0, %1  : i32
    %7 = llvm.icmp "ult" %6, %2 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def positive_trunc_base_before := [llvmfunc|
  llvm.func @positive_trunc_base(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.trunc %arg0 : i32 to i16
    %4 = llvm.icmp "sgt" %3, %0 : i16
    %5 = llvm.add %3, %1  : i16
    %6 = llvm.icmp "ult" %5, %2 : i16
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def positive_trunc_base_logical_before := [llvmfunc|
  llvm.func @positive_trunc_base_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.icmp "sgt" %4, %0 : i16
    %6 = llvm.add %4, %1  : i16
    %7 = llvm.icmp "ult" %6, %2 : i16
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def positive_different_trunc_both_before := [llvmfunc|
  llvm.func @positive_different_trunc_both(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i15) : i15
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.trunc %arg0 : i32 to i15
    %4 = llvm.icmp "sgt" %3, %0 : i15
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.add %5, %1  : i16
    %7 = llvm.icmp "ult" %6, %2 : i16
    %8 = llvm.and %4, %7  : i1
    llvm.return %8 : i1
  }]

def positive_different_trunc_both_logical_before := [llvmfunc|
  llvm.func @positive_different_trunc_both_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i15) : i15
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.trunc %arg0 : i32 to i15
    %5 = llvm.icmp "sgt" %4, %0 : i15
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.add %6, %1  : i16
    %8 = llvm.icmp "ult" %7, %2 : i16
    %9 = llvm.select %5, %8, %3 : i1, i1
    llvm.return %9 : i1
  }]

def oneuse_with_signbit_before := [llvmfunc|
  llvm.func @oneuse_with_signbit(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ult" %4, %2 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def oneuse_with_signbit_logical_before := [llvmfunc|
  llvm.func @oneuse_with_signbit_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

def oneuse_with_mask_before := [llvmfunc|
  llvm.func @oneuse_with_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(603979776 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.add %arg0, %2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ult" %6, %3 : i32
    llvm.call @use1(%7) : (i1) -> ()
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def oneuse_with_mask_logical_before := [llvmfunc|
  llvm.func @oneuse_with_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(603979776 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "eq" %5, %1 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.add %arg0, %2  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.icmp "ult" %7, %3 : i32
    llvm.call @use1(%8) : (i1) -> ()
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def oneuse_shl_ashr_before := [llvmfunc|
  llvm.func @oneuse_shl_ashr(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.shl %arg0, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.ashr %4, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "eq" %5, %arg0 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.and %3, %6  : i1
    llvm.return %7 : i1
  }]

def oneuse_shl_ashr_logical_before := [llvmfunc|
  llvm.func @oneuse_shl_ashr_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "sgt" %3, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.shl %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.ashr %5, %1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "eq" %6, %arg0 : i32
    llvm.call @use1(%7) : (i1) -> ()
    %8 = llvm.select %4, %7, %2 : i1, i1
    llvm.return %8 : i1
  }]

def oneuse_trunc_sext(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @oneuse_trunc_sext(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sext %3 : i8 to i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "eq" %4, %arg0 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.and %2, %5  : i1
    llvm.return %6 : i1
  }]

def oneuse_trunc_sext_logical(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @oneuse_trunc_sext_logical(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.sext %4 : i8 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "eq" %5, %arg0 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %3, %6, %1 : i1, i1
    llvm.return %7 : i1
  }]

def negative_not_arg_before := [llvmfunc|
  llvm.func @negative_not_arg(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def negative_not_arg_logical_before := [llvmfunc|
  llvm.func @negative_not_arg_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.add %arg1, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

def negative_trunc_not_arg_before := [llvmfunc|
  llvm.func @negative_trunc_not_arg(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "sgt" %3, %0 : i8
    %5 = llvm.add %arg1, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def negative_trunc_not_arg_logical_before := [llvmfunc|
  llvm.func @negative_trunc_not_arg_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.icmp "sgt" %4, %0 : i8
    %6 = llvm.add %arg1, %1  : i32
    %7 = llvm.icmp "ult" %6, %2 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def positive_with_mask_not_arg_before := [llvmfunc|
  llvm.func @positive_with_mask_not_arg(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1140850688 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def positive_with_mask_not_arg_logical_before := [llvmfunc|
  llvm.func @positive_with_mask_not_arg_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1140850688 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.add %arg1, %2  : i32
    %8 = llvm.icmp "ult" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def negative_with_nonuniform_bad_mask_before := [llvmfunc|
  llvm.func @negative_with_nonuniform_bad_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1711276033 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def negative_with_nonuniform_bad_mask_logical_before := [llvmfunc|
  llvm.func @negative_with_nonuniform_bad_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1711276033 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.add %arg0, %2  : i32
    %8 = llvm.icmp "ult" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def negative_with_uniform_bad_mask_before := [llvmfunc|
  llvm.func @negative_with_uniform_bad_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-16777152 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def negative_with_uniform_bad_mask_logical_before := [llvmfunc|
  llvm.func @negative_with_uniform_bad_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-16777152 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.add %arg0, %2  : i32
    %8 = llvm.icmp "ult" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def negative_with_wrong_mask_before := [llvmfunc|
  llvm.func @negative_with_wrong_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def negative_with_wrong_mask_logical_before := [llvmfunc|
  llvm.func @negative_with_wrong_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.add %arg0, %2  : i32
    %8 = llvm.icmp "ult" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def negative_not_less_than_before := [llvmfunc|
  llvm.func @negative_not_less_than(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.add %arg0, %1  : i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

def negative_not_less_than_logical_before := [llvmfunc|
  llvm.func @negative_not_less_than_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.select %3, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def negative_not_power_of_two_before := [llvmfunc|
  llvm.func @negative_not_power_of_two(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def negative_not_power_of_two_logical_before := [llvmfunc|
  llvm.func @negative_not_power_of_two_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

def negative_not_next_power_of_two_before := [llvmfunc|
  llvm.func @negative_not_next_power_of_two(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

def negative_not_next_power_of_two_logical_before := [llvmfunc|
  llvm.func @negative_not_next_power_of_two_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(64 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

def two_signed_truncation_checks_before := [llvmfunc|
  llvm.func @two_signed_truncation_checks(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(512 : i32) : i32
    %1 = llvm.mlir.constant(1024 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def two_signed_truncation_checks_logical_before := [llvmfunc|
  llvm.func @two_signed_truncation_checks_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(512 : i32) : i32
    %1 = llvm.mlir.constant(1024 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.icmp "ult" %5, %1 : i32
    %7 = llvm.add %arg0, %2  : i32
    %8 = llvm.icmp "ult" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def bad_trunc_stc_before := [llvmfunc|
  llvm.func @bad_trunc_stc(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.add %4, %1  : i16
    %6 = llvm.icmp "ult" %5, %2 : i16
    %7 = llvm.and %3, %6  : i1
    llvm.return %7 : i1
  }]

def bad_trunc_stc_logical_before := [llvmfunc|
  llvm.func @bad_trunc_stc_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.add %5, %1  : i16
    %7 = llvm.icmp "ult" %6, %2 : i16
    %8 = llvm.select %4, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def positive_with_signbit_combined := [llvmfunc|
  llvm.func @positive_with_signbit(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_with_signbit   : positive_with_signbit_before  ⊑  positive_with_signbit_combined := by
  unfold positive_with_signbit_before positive_with_signbit_combined
  simp_alive_peephole
  sorry
def positive_with_signbit_logical_combined := [llvmfunc|
  llvm.func @positive_with_signbit_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_with_signbit_logical   : positive_with_signbit_logical_before  ⊑  positive_with_signbit_logical_combined := by
  unfold positive_with_signbit_logical_before positive_with_signbit_logical_combined
  simp_alive_peephole
  sorry
def positive_with_mask_combined := [llvmfunc|
  llvm.func @positive_with_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_with_mask   : positive_with_mask_before  ⊑  positive_with_mask_combined := by
  unfold positive_with_mask_before positive_with_mask_combined
  simp_alive_peephole
  sorry
def positive_with_mask_logical_combined := [llvmfunc|
  llvm.func @positive_with_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_with_mask_logical   : positive_with_mask_logical_before  ⊑  positive_with_mask_logical_combined := by
  unfold positive_with_mask_logical_before positive_with_mask_logical_combined
  simp_alive_peephole
  sorry
def positive_with_icmp_combined := [llvmfunc|
  llvm.func @positive_with_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_with_icmp   : positive_with_icmp_before  ⊑  positive_with_icmp_combined := by
  unfold positive_with_icmp_before positive_with_icmp_combined
  simp_alive_peephole
  sorry
def positive_with_icmp_logical_combined := [llvmfunc|
  llvm.func @positive_with_icmp_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_with_icmp_logical   : positive_with_icmp_logical_before  ⊑  positive_with_icmp_logical_combined := by
  unfold positive_with_icmp_logical_before positive_with_icmp_logical_combined
  simp_alive_peephole
  sorry
def positive_with_aggressive_icmp_combined := [llvmfunc|
  llvm.func @positive_with_aggressive_icmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_with_aggressive_icmp   : positive_with_aggressive_icmp_before  ⊑  positive_with_aggressive_icmp_combined := by
  unfold positive_with_aggressive_icmp_before positive_with_aggressive_icmp_combined
  simp_alive_peephole
  sorry
def positive_with_aggressive_icmp_logical_combined := [llvmfunc|
  llvm.func @positive_with_aggressive_icmp_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_with_aggressive_icmp_logical   : positive_with_aggressive_icmp_logical_before  ⊑  positive_with_aggressive_icmp_logical_combined := by
  unfold positive_with_aggressive_icmp_logical_before positive_with_aggressive_icmp_logical_combined
  simp_alive_peephole
  sorry
def positive_with_extra_and_combined := [llvmfunc|
  llvm.func @positive_with_extra_and(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.and %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_positive_with_extra_and   : positive_with_extra_and_before  ⊑  positive_with_extra_and_combined := by
  unfold positive_with_extra_and_before positive_with_extra_and_combined
  simp_alive_peephole
  sorry
def positive_with_extra_and_logical_combined := [llvmfunc|
  llvm.func @positive_with_extra_and_logical(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_positive_with_extra_and_logical   : positive_with_extra_and_logical_before  ⊑  positive_with_extra_and_logical_combined := by
  unfold positive_with_extra_and_logical_before positive_with_extra_and_logical_combined
  simp_alive_peephole
  sorry
def positive_vec_splat_combined := [llvmfunc|
  llvm.func @positive_vec_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_positive_vec_splat   : positive_vec_splat_before  ⊑  positive_vec_splat_combined := by
  unfold positive_vec_splat_before positive_vec_splat_combined
  simp_alive_peephole
  sorry
def positive_vec_nonsplat_combined := [llvmfunc|
  llvm.func @positive_vec_nonsplat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[128, 256]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[256, 512]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.add %arg0, %1  : vector<2xi32>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi32>
    %6 = llvm.and %3, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_positive_vec_nonsplat   : positive_vec_nonsplat_before  ⊑  positive_vec_nonsplat_combined := by
  unfold positive_vec_nonsplat_before positive_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def positive_vec_poison0_combined := [llvmfunc|
  llvm.func @positive_vec_poison0(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<3xi32>
    llvm.return %1 : vector<3xi1>
  }]

theorem inst_combine_positive_vec_poison0   : positive_vec_poison0_before  ⊑  positive_vec_poison0_combined := by
  unfold positive_vec_poison0_before positive_vec_poison0_combined
  simp_alive_peephole
  sorry
def positive_vec_poison1_combined := [llvmfunc|
  llvm.func @positive_vec_poison1(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(dense<256> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.icmp "sgt" %arg0, %0 : vector<3xi32>
    %12 = llvm.add %arg0, %9  : vector<3xi32>
    %13 = llvm.icmp "ult" %12, %10 : vector<3xi32>
    %14 = llvm.and %11, %13  : vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

theorem inst_combine_positive_vec_poison1   : positive_vec_poison1_before  ⊑  positive_vec_poison1_combined := by
  unfold positive_vec_poison1_before positive_vec_poison1_combined
  simp_alive_peephole
  sorry
def positive_vec_poison2_combined := [llvmfunc|
  llvm.func @positive_vec_poison2(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(dense<128> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.undef : vector<3xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi32>
    %11 = llvm.icmp "sgt" %arg0, %0 : vector<3xi32>
    %12 = llvm.add %arg0, %1  : vector<3xi32>
    %13 = llvm.icmp "ult" %12, %10 : vector<3xi32>
    %14 = llvm.and %11, %13  : vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }]

theorem inst_combine_positive_vec_poison2   : positive_vec_poison2_before  ⊑  positive_vec_poison2_combined := by
  unfold positive_vec_poison2_before positive_vec_poison2_combined
  simp_alive_peephole
  sorry
def positive_vec_poison3_combined := [llvmfunc|
  llvm.func @positive_vec_poison3(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(128 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.constant(dense<256> : vector<3xi32>) : vector<3xi32>
    %18 = llvm.icmp "sgt" %arg0, %8 : vector<3xi32>
    %19 = llvm.add %arg0, %16  : vector<3xi32>
    %20 = llvm.icmp "ult" %19, %17 : vector<3xi32>
    %21 = llvm.and %18, %20  : vector<3xi1>
    llvm.return %21 : vector<3xi1>
  }]

theorem inst_combine_positive_vec_poison3   : positive_vec_poison3_before  ⊑  positive_vec_poison3_combined := by
  unfold positive_vec_poison3_before positive_vec_poison3_combined
  simp_alive_peephole
  sorry
def positive_vec_poison4_combined := [llvmfunc|
  llvm.func @positive_vec_poison4(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<128> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.mlir.constant(256 : i32) : i32
    %11 = llvm.mlir.undef : vector<3xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi32>
    %18 = llvm.icmp "sgt" %arg0, %8 : vector<3xi32>
    %19 = llvm.add %arg0, %9  : vector<3xi32>
    %20 = llvm.icmp "ult" %19, %17 : vector<3xi32>
    %21 = llvm.and %18, %20  : vector<3xi1>
    llvm.return %21 : vector<3xi1>
  }]

theorem inst_combine_positive_vec_poison4   : positive_vec_poison4_before  ⊑  positive_vec_poison4_combined := by
  unfold positive_vec_poison4_before positive_vec_poison4_combined
  simp_alive_peephole
  sorry
def positive_vec_poison5_combined := [llvmfunc|
  llvm.func @positive_vec_poison5(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(256 : i32) : i32
    %11 = llvm.mlir.undef : vector<3xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<3xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi32>
    %18 = llvm.icmp "sgt" %arg0, %0 : vector<3xi32>
    %19 = llvm.add %arg0, %9  : vector<3xi32>
    %20 = llvm.icmp "ult" %19, %17 : vector<3xi32>
    %21 = llvm.and %18, %20  : vector<3xi1>
    llvm.return %21 : vector<3xi1>
  }]

theorem inst_combine_positive_vec_poison5   : positive_vec_poison5_before  ⊑  positive_vec_poison5_combined := by
  unfold positive_vec_poison5_before positive_vec_poison5_combined
  simp_alive_peephole
  sorry
def positive_vec_poison6_combined := [llvmfunc|
  llvm.func @positive_vec_poison6(%arg0: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(128 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.constant(256 : i32) : i32
    %18 = llvm.mlir.undef : vector<3xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<3xi32>
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<3xi32>
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.insertelement %17, %22[%23 : i32] : vector<3xi32>
    %25 = llvm.icmp "sgt" %arg0, %8 : vector<3xi32>
    %26 = llvm.add %arg0, %16  : vector<3xi32>
    %27 = llvm.icmp "ult" %26, %24 : vector<3xi32>
    %28 = llvm.and %25, %27  : vector<3xi1>
    llvm.return %28 : vector<3xi1>
  }]

theorem inst_combine_positive_vec_poison6   : positive_vec_poison6_before  ⊑  positive_vec_poison6_combined := by
  unfold positive_vec_poison6_before positive_vec_poison6_combined
  simp_alive_peephole
  sorry
def commutative_combined := [llvmfunc|
  llvm.func @commutative() -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_commutative   : commutative_before  ⊑  commutative_combined := by
  unfold commutative_before commutative_combined
  simp_alive_peephole
  sorry
def commutative_logical_combined := [llvmfunc|
  llvm.func @commutative_logical() -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_commutative_logical   : commutative_logical_before  ⊑  commutative_logical_combined := by
  unfold commutative_logical_before commutative_logical_combined
  simp_alive_peephole
  sorry
def commutative_with_icmp_combined := [llvmfunc|
  llvm.func @commutative_with_icmp() -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_commutative_with_icmp   : commutative_with_icmp_before  ⊑  commutative_with_icmp_combined := by
  unfold commutative_with_icmp_before commutative_with_icmp_combined
  simp_alive_peephole
  sorry
def commutative_with_icmp_logical_combined := [llvmfunc|
  llvm.func @commutative_with_icmp_logical() -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.call @gen32() : () -> i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_commutative_with_icmp_logical   : commutative_with_icmp_logical_before  ⊑  commutative_with_icmp_logical_combined := by
  unfold commutative_with_icmp_logical_before commutative_with_icmp_logical_combined
  simp_alive_peephole
  sorry
def positive_trunc_signbit_combined := [llvmfunc|
  llvm.func @positive_trunc_signbit(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_trunc_signbit   : positive_trunc_signbit_before  ⊑  positive_trunc_signbit_combined := by
  unfold positive_trunc_signbit_before positive_trunc_signbit_combined
  simp_alive_peephole
  sorry
def positive_trunc_signbit_logical_combined := [llvmfunc|
  llvm.func @positive_trunc_signbit_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_positive_trunc_signbit_logical   : positive_trunc_signbit_logical_before  ⊑  positive_trunc_signbit_logical_combined := by
  unfold positive_trunc_signbit_logical_before positive_trunc_signbit_logical_combined
  simp_alive_peephole
  sorry
def positive_trunc_base_combined := [llvmfunc|
  llvm.func @positive_trunc_base(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(65408 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_positive_trunc_base   : positive_trunc_base_before  ⊑  positive_trunc_base_combined := by
  unfold positive_trunc_base_before positive_trunc_base_combined
  simp_alive_peephole
  sorry
def positive_trunc_base_logical_combined := [llvmfunc|
  llvm.func @positive_trunc_base_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(65408 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_positive_trunc_base_logical   : positive_trunc_base_logical_before  ⊑  positive_trunc_base_logical_combined := by
  unfold positive_trunc_base_logical_before positive_trunc_base_logical_combined
  simp_alive_peephole
  sorry
def positive_different_trunc_both_combined := [llvmfunc|
  llvm.func @positive_different_trunc_both(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16384 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i16) : i16
    %3 = llvm.mlir.constant(256 : i16) : i16
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.trunc %arg0 : i32 to i16
    %7 = llvm.add %6, %2  : i16
    %8 = llvm.icmp "ult" %7, %3 : i16
    %9 = llvm.and %5, %8  : i1
    llvm.return %9 : i1
  }]

theorem inst_combine_positive_different_trunc_both   : positive_different_trunc_both_before  ⊑  positive_different_trunc_both_combined := by
  unfold positive_different_trunc_both_before positive_different_trunc_both_combined
  simp_alive_peephole
  sorry
def positive_different_trunc_both_logical_combined := [llvmfunc|
  llvm.func @positive_different_trunc_both_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16384 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i16) : i16
    %3 = llvm.mlir.constant(256 : i16) : i16
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.trunc %arg0 : i32 to i16
    %8 = llvm.add %7, %2  : i16
    %9 = llvm.icmp "ult" %8, %3 : i16
    %10 = llvm.select %6, %9, %4 : i1, i1
    llvm.return %10 : i1
  }]

theorem inst_combine_positive_different_trunc_both_logical   : positive_different_trunc_both_logical_before  ⊑  positive_different_trunc_both_logical_combined := by
  unfold positive_different_trunc_both_logical_before positive_different_trunc_both_logical_combined
  simp_alive_peephole
  sorry
def oneuse_with_signbit_combined := [llvmfunc|
  llvm.func @oneuse_with_signbit(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ult" %4, %2 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_oneuse_with_signbit   : oneuse_with_signbit_before  ⊑  oneuse_with_signbit_combined := by
  unfold oneuse_with_signbit_before oneuse_with_signbit_combined
  simp_alive_peephole
  sorry
def oneuse_with_signbit_logical_combined := [llvmfunc|
  llvm.func @oneuse_with_signbit_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.add %arg0, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ult" %4, %2 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_oneuse_with_signbit_logical   : oneuse_with_signbit_logical_before  ⊑  oneuse_with_signbit_logical_combined := by
  unfold oneuse_with_signbit_logical_before oneuse_with_signbit_logical_combined
  simp_alive_peephole
  sorry
def oneuse_with_mask_combined := [llvmfunc|
  llvm.func @oneuse_with_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(603979776 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.add %arg0, %2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ult" %6, %3 : i32
    llvm.call @use1(%7) : (i1) -> ()
    %8 = llvm.icmp "ult" %arg0, %2 : i32
    llvm.return %8 : i1
  }]

theorem inst_combine_oneuse_with_mask   : oneuse_with_mask_before  ⊑  oneuse_with_mask_combined := by
  unfold oneuse_with_mask_before oneuse_with_mask_combined
  simp_alive_peephole
  sorry
def oneuse_with_mask_logical_combined := [llvmfunc|
  llvm.func @oneuse_with_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(603979776 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.add %arg0, %2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "ult" %6, %3 : i32
    llvm.call @use1(%7) : (i1) -> ()
    %8 = llvm.icmp "ult" %arg0, %2 : i32
    llvm.return %8 : i1
  }]

theorem inst_combine_oneuse_with_mask_logical   : oneuse_with_mask_logical_before  ⊑  oneuse_with_mask_logical_combined := by
  unfold oneuse_with_mask_logical_before oneuse_with_mask_logical_combined
  simp_alive_peephole
  sorry
def oneuse_shl_ashr_combined := [llvmfunc|
  llvm.func @oneuse_shl_ashr(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.shl %arg0, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.ashr %4, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "eq" %5, %arg0 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.and %3, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_oneuse_shl_ashr   : oneuse_shl_ashr_before  ⊑  oneuse_shl_ashr_combined := by
  unfold oneuse_shl_ashr_before oneuse_shl_ashr_combined
  simp_alive_peephole
  sorry
def oneuse_shl_ashr_logical_combined := [llvmfunc|
  llvm.func @oneuse_shl_ashr_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "sgt" %3, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.shl %arg0, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.ashr %5, %1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.icmp "eq" %6, %arg0 : i32
    llvm.call @use1(%7) : (i1) -> ()
    %8 = llvm.select %4, %7, %2 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_oneuse_shl_ashr_logical   : oneuse_shl_ashr_logical_before  ⊑  oneuse_shl_ashr_logical_combined := by
  unfold oneuse_shl_ashr_logical_before oneuse_shl_ashr_logical_combined
  simp_alive_peephole
  sorry
def oneuse_trunc_sext(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @oneuse_trunc_sext(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sext %3 : i8 to i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "eq" %4, %arg0 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.and %2, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_oneuse_trunc_sext(%arg0: i32) ->    : oneuse_trunc_sext(%arg0: i32) -> _before  ⊑  oneuse_trunc_sext(%arg0: i32) -> _combined := by
  unfold oneuse_trunc_sext(%arg0: i32) -> _before oneuse_trunc_sext(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def oneuse_trunc_sext_logical(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @oneuse_trunc_sext_logical(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.trunc %arg0 : i32 to i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.sext %4 : i8 to i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.icmp "eq" %5, %arg0 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.select %3, %6, %1 : i1, i1
    llvm.return %7 : i1
  }]

theorem inst_combine_oneuse_trunc_sext_logical(%arg0: i32) ->    : oneuse_trunc_sext_logical(%arg0: i32) -> _before  ⊑  oneuse_trunc_sext_logical(%arg0: i32) -> _combined := by
  unfold oneuse_trunc_sext_logical(%arg0: i32) -> _before oneuse_trunc_sext_logical(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def negative_not_arg_combined := [llvmfunc|
  llvm.func @negative_not_arg(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_negative_not_arg   : negative_not_arg_before  ⊑  negative_not_arg_combined := by
  unfold negative_not_arg_before negative_not_arg_combined
  simp_alive_peephole
  sorry
def negative_not_arg_logical_combined := [llvmfunc|
  llvm.func @negative_not_arg_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.add %arg1, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.return %7 : i1
  }]

theorem inst_combine_negative_not_arg_logical   : negative_not_arg_logical_before  ⊑  negative_not_arg_logical_combined := by
  unfold negative_not_arg_logical_before negative_not_arg_logical_combined
  simp_alive_peephole
  sorry
def negative_trunc_not_arg_combined := [llvmfunc|
  llvm.func @negative_trunc_not_arg(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.add %arg1, %0  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_negative_trunc_not_arg   : negative_trunc_not_arg_before  ⊑  negative_trunc_not_arg_combined := by
  unfold negative_trunc_not_arg_before negative_trunc_not_arg_combined
  simp_alive_peephole
  sorry
def negative_trunc_not_arg_logical_combined := [llvmfunc|
  llvm.func @negative_trunc_not_arg_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg1, %0  : i32
    %7 = llvm.icmp "ult" %6, %2 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_negative_trunc_not_arg_logical   : negative_trunc_not_arg_logical_before  ⊑  negative_trunc_not_arg_logical_combined := by
  unfold negative_trunc_not_arg_logical_before negative_trunc_not_arg_logical_combined
  simp_alive_peephole
  sorry
def positive_with_mask_not_arg_combined := [llvmfunc|
  llvm.func @positive_with_mask_not_arg(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1140850688 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg1, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_positive_with_mask_not_arg   : positive_with_mask_not_arg_before  ⊑  positive_with_mask_not_arg_combined := by
  unfold positive_with_mask_not_arg_before positive_with_mask_not_arg_combined
  simp_alive_peephole
  sorry
def positive_with_mask_not_arg_logical_combined := [llvmfunc|
  llvm.func @positive_with_mask_not_arg_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1140850688 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.icmp "eq" %5, %1 : i32
    %7 = llvm.add %arg1, %2  : i32
    %8 = llvm.icmp "ult" %7, %3 : i32
    %9 = llvm.select %6, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

theorem inst_combine_positive_with_mask_not_arg_logical   : positive_with_mask_not_arg_logical_before  ⊑  positive_with_mask_not_arg_logical_combined := by
  unfold positive_with_mask_not_arg_logical_before positive_with_mask_not_arg_logical_combined
  simp_alive_peephole
  sorry
def negative_with_nonuniform_bad_mask_combined := [llvmfunc|
  llvm.func @negative_with_nonuniform_bad_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1711276033 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_negative_with_nonuniform_bad_mask   : negative_with_nonuniform_bad_mask_before  ⊑  negative_with_nonuniform_bad_mask_combined := by
  unfold negative_with_nonuniform_bad_mask_before negative_with_nonuniform_bad_mask_combined
  simp_alive_peephole
  sorry
def negative_with_nonuniform_bad_mask_logical_combined := [llvmfunc|
  llvm.func @negative_with_nonuniform_bad_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1711276033 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_negative_with_nonuniform_bad_mask_logical   : negative_with_nonuniform_bad_mask_logical_before  ⊑  negative_with_nonuniform_bad_mask_logical_combined := by
  unfold negative_with_nonuniform_bad_mask_logical_before negative_with_nonuniform_bad_mask_logical_combined
  simp_alive_peephole
  sorry
def negative_with_uniform_bad_mask_combined := [llvmfunc|
  llvm.func @negative_with_uniform_bad_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-16777152 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_negative_with_uniform_bad_mask   : negative_with_uniform_bad_mask_before  ⊑  negative_with_uniform_bad_mask_combined := by
  unfold negative_with_uniform_bad_mask_before negative_with_uniform_bad_mask_combined
  simp_alive_peephole
  sorry
def negative_with_uniform_bad_mask_logical_combined := [llvmfunc|
  llvm.func @negative_with_uniform_bad_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-16777152 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_negative_with_uniform_bad_mask_logical   : negative_with_uniform_bad_mask_logical_before  ⊑  negative_with_uniform_bad_mask_logical_combined := by
  unfold negative_with_uniform_bad_mask_logical_before negative_with_uniform_bad_mask_logical_combined
  simp_alive_peephole
  sorry
def negative_with_wrong_mask_combined := [llvmfunc|
  llvm.func @negative_with_wrong_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_negative_with_wrong_mask   : negative_with_wrong_mask_before  ⊑  negative_with_wrong_mask_combined := by
  unfold negative_with_wrong_mask_before negative_with_wrong_mask_combined
  simp_alive_peephole
  sorry
def negative_with_wrong_mask_logical_combined := [llvmfunc|
  llvm.func @negative_with_wrong_mask_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(128 : i32) : i32
    %3 = llvm.mlir.constant(256 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

theorem inst_combine_negative_with_wrong_mask_logical   : negative_with_wrong_mask_logical_before  ⊑  negative_with_wrong_mask_logical_combined := by
  unfold negative_with_wrong_mask_logical_before negative_with_wrong_mask_logical_combined
  simp_alive_peephole
  sorry
def negative_not_less_than_combined := [llvmfunc|
  llvm.func @negative_not_less_than(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_negative_not_less_than   : negative_not_less_than_before  ⊑  negative_not_less_than_combined := by
  unfold negative_not_less_than_before negative_not_less_than_combined
  simp_alive_peephole
  sorry
def negative_not_less_than_logical_combined := [llvmfunc|
  llvm.func @negative_not_less_than_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_negative_not_less_than_logical   : negative_not_less_than_logical_before  ⊑  negative_not_less_than_logical_combined := by
  unfold negative_not_less_than_logical_before negative_not_less_than_logical_combined
  simp_alive_peephole
  sorry
def negative_not_power_of_two_combined := [llvmfunc|
  llvm.func @negative_not_power_of_two(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_negative_not_power_of_two   : negative_not_power_of_two_before  ⊑  negative_not_power_of_two_combined := by
  unfold negative_not_power_of_two_before negative_not_power_of_two_combined
  simp_alive_peephole
  sorry
def negative_not_power_of_two_logical_combined := [llvmfunc|
  llvm.func @negative_not_power_of_two_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_negative_not_power_of_two_logical   : negative_not_power_of_two_logical_before  ⊑  negative_not_power_of_two_logical_combined := by
  unfold negative_not_power_of_two_logical_before negative_not_power_of_two_logical_combined
  simp_alive_peephole
  sorry
def negative_not_next_power_of_two_combined := [llvmfunc|
  llvm.func @negative_not_next_power_of_two(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_negative_not_next_power_of_two   : negative_not_next_power_of_two_before  ⊑  negative_not_next_power_of_two_combined := by
  unfold negative_not_next_power_of_two_before negative_not_next_power_of_two_combined
  simp_alive_peephole
  sorry
def negative_not_next_power_of_two_logical_combined := [llvmfunc|
  llvm.func @negative_not_next_power_of_two_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(192 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_negative_not_next_power_of_two_logical   : negative_not_next_power_of_two_logical_before  ⊑  negative_not_next_power_of_two_logical_combined := by
  unfold negative_not_next_power_of_two_logical_before negative_not_next_power_of_two_logical_combined
  simp_alive_peephole
  sorry
def two_signed_truncation_checks_combined := [llvmfunc|
  llvm.func @two_signed_truncation_checks(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_two_signed_truncation_checks   : two_signed_truncation_checks_before  ⊑  two_signed_truncation_checks_combined := by
  unfold two_signed_truncation_checks_before two_signed_truncation_checks_combined
  simp_alive_peephole
  sorry
def two_signed_truncation_checks_logical_combined := [llvmfunc|
  llvm.func @two_signed_truncation_checks_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(256 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_two_signed_truncation_checks_logical   : two_signed_truncation_checks_logical_before  ⊑  two_signed_truncation_checks_logical_combined := by
  unfold two_signed_truncation_checks_logical_before two_signed_truncation_checks_logical_combined
  simp_alive_peephole
  sorry
def bad_trunc_stc_combined := [llvmfunc|
  llvm.func @bad_trunc_stc(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.trunc %arg0 : i32 to i16
    %5 = llvm.add %4, %1  : i16
    %6 = llvm.icmp "ult" %5, %2 : i16
    %7 = llvm.and %3, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_bad_trunc_stc   : bad_trunc_stc_before  ⊑  bad_trunc_stc_combined := by
  unfold bad_trunc_stc_before bad_trunc_stc_combined
  simp_alive_peephole
  sorry
def bad_trunc_stc_logical_combined := [llvmfunc|
  llvm.func @bad_trunc_stc_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.mlir.constant(256 : i16) : i16
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.trunc %arg0 : i32 to i16
    %6 = llvm.add %5, %1  : i16
    %7 = llvm.icmp "ult" %6, %2 : i16
    %8 = llvm.select %4, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

theorem inst_combine_bad_trunc_stc_logical   : bad_trunc_stc_logical_before  ⊑  bad_trunc_stc_logical_combined := by
  unfold bad_trunc_stc_logical_before bad_trunc_stc_logical_combined
  simp_alive_peephole
  sorry
