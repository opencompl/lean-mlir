import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-amount-reassociation-in-bittest
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_const_lshr_shl_ne_before := [llvmfunc|
  llvm.func @t0_const_lshr_shl_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t1_const_shl_lshr_ne_before := [llvmfunc|
  llvm.func @t1_const_shl_lshr_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.lshr %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t2_const_lshr_shl_eq_before := [llvmfunc|
  llvm.func @t2_const_lshr_shl_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t3_const_after_fold_lshr_shl_ne_before := [llvmfunc|
  llvm.func @t3_const_after_fold_lshr_shl_ne(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.shl %arg1, %5  : i32
    %7 = llvm.and %4, %6  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.return %8 : i1
  }]

def t4_const_after_fold_lshr_shl_ne_before := [llvmfunc|
  llvm.func @t4_const_after_fold_lshr_shl_ne(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.shl %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.lshr %arg1, %5  : i32
    %7 = llvm.and %4, %6  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.return %8 : i1
  }]

def t5_const_lshr_shl_ne_before := [llvmfunc|
  llvm.func @t5_const_lshr_shl_ne(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t6_const_shl_lshr_ne_before := [llvmfunc|
  llvm.func @t6_const_shl_lshr_ne(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg2  : i32
    %2 = llvm.lshr %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t7_const_lshr_shl_ne_vec_splat_before := [llvmfunc|
  llvm.func @t7_const_lshr_shl_ne_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.shl %arg1, %0  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }]

def t8_const_lshr_shl_ne_vec_nonsplat_before := [llvmfunc|
  llvm.func @t8_const_lshr_shl_ne_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[3, 4]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg1, %1  : vector<2xi32>
    %6 = llvm.and %5, %4  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %3 : vector<2xi32>
    llvm.return %7 : vector<2xi1>
  }]

def t9_const_lshr_shl_ne_vec_poison0_before := [llvmfunc|
  llvm.func @t9_const_lshr_shl_ne_vec_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %12 = llvm.lshr %arg0, %8  : vector<3xi32>
    %13 = llvm.shl %arg1, %9  : vector<3xi32>
    %14 = llvm.and %13, %12  : vector<3xi32>
    %15 = llvm.icmp "ne" %14, %11 : vector<3xi32>
    llvm.return %15 : vector<3xi1>
  }]

def t10_const_lshr_shl_ne_vec_poison1_before := [llvmfunc|
  llvm.func @t10_const_lshr_shl_ne_vec_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %12 = llvm.lshr %arg0, %0  : vector<3xi32>
    %13 = llvm.shl %arg1, %9  : vector<3xi32>
    %14 = llvm.and %13, %12  : vector<3xi32>
    %15 = llvm.icmp "ne" %14, %11 : vector<3xi32>
    llvm.return %15 : vector<3xi1>
  }]

def t11_const_lshr_shl_ne_vec_poison2_before := [llvmfunc|
  llvm.func @t11_const_lshr_shl_ne_vec_poison2(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.lshr %arg0, %0  : vector<3xi32>
    %11 = llvm.shl %arg1, %0  : vector<3xi32>
    %12 = llvm.and %11, %10  : vector<3xi32>
    %13 = llvm.icmp "ne" %12, %9 : vector<3xi32>
    llvm.return %13 : vector<3xi1>
  }]

def t12_const_lshr_shl_ne_vec_poison3_before := [llvmfunc|
  llvm.func @t12_const_lshr_shl_ne_vec_poison3(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.lshr %arg0, %8  : vector<3xi32>
    %12 = llvm.shl %arg1, %8  : vector<3xi32>
    %13 = llvm.and %12, %11  : vector<3xi32>
    %14 = llvm.icmp "ne" %13, %10 : vector<3xi32>
    llvm.return %14 : vector<3xi1>
  }]

def t13_const_lshr_shl_ne_vec_poison4_before := [llvmfunc|
  llvm.func @t13_const_lshr_shl_ne_vec_poison4(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.undef : vector<3xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %2, %13[%14 : i32] : vector<3xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi32>
    %18 = llvm.lshr %arg0, %0  : vector<3xi32>
    %19 = llvm.shl %arg1, %9  : vector<3xi32>
    %20 = llvm.and %19, %18  : vector<3xi32>
    %21 = llvm.icmp "ne" %20, %17 : vector<3xi32>
    llvm.return %21 : vector<3xi1>
  }]

def t14_const_lshr_shl_ne_vec_poison5_before := [llvmfunc|
  llvm.func @t14_const_lshr_shl_ne_vec_poison5(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.mlir.undef : vector<3xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.insertelement %10, %11[%12 : i32] : vector<3xi32>
    %14 = llvm.mlir.constant(1 : i32) : i32
    %15 = llvm.insertelement %1, %13[%14 : i32] : vector<3xi32>
    %16 = llvm.mlir.constant(2 : i32) : i32
    %17 = llvm.insertelement %10, %15[%16 : i32] : vector<3xi32>
    %18 = llvm.lshr %arg0, %8  : vector<3xi32>
    %19 = llvm.shl %arg1, %9  : vector<3xi32>
    %20 = llvm.and %19, %18  : vector<3xi32>
    %21 = llvm.icmp "ne" %20, %17 : vector<3xi32>
    llvm.return %21 : vector<3xi1>
  }]

def t15_const_lshr_shl_ne_vec_poison6_before := [llvmfunc|
  llvm.func @t15_const_lshr_shl_ne_vec_poison6(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.lshr %arg0, %8  : vector<3xi32>
    %18 = llvm.shl %arg1, %8  : vector<3xi32>
    %19 = llvm.and %18, %17  : vector<3xi32>
    %20 = llvm.icmp "ne" %19, %16 : vector<3xi32>
    llvm.return %20 : vector<3xi1>
  }]

def t16_commutativity0_before := [llvmfunc|
  llvm.func @t16_commutativity0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.shl %2, %0  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }]

def t17_commutativity1_before := [llvmfunc|
  llvm.func @t17_commutativity1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }]

def t18_const_oneuse0_before := [llvmfunc|
  llvm.func @t18_const_oneuse0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t19_const_oneuse1_before := [llvmfunc|
  llvm.func @t19_const_oneuse1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t20_const_oneuse2_before := [llvmfunc|
  llvm.func @t20_const_oneuse2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t21_const_oneuse3_before := [llvmfunc|
  llvm.func @t21_const_oneuse3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t22_const_oneuse4_before := [llvmfunc|
  llvm.func @t22_const_oneuse4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t23_const_oneuse5_before := [llvmfunc|
  llvm.func @t23_const_oneuse5(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t24_const_oneuse6_before := [llvmfunc|
  llvm.func @t24_const_oneuse6(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

def t25_var_oneuse0_before := [llvmfunc|
  llvm.func @t25_var_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t26_var_oneuse1_before := [llvmfunc|
  llvm.func @t26_var_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t27_var_oneuse2_before := [llvmfunc|
  llvm.func @t27_var_oneuse2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t28_var_oneuse3_before := [llvmfunc|
  llvm.func @t28_var_oneuse3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t29_var_oneuse4_before := [llvmfunc|
  llvm.func @t29_var_oneuse4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t30_var_oneuse5_before := [llvmfunc|
  llvm.func @t30_var_oneuse5(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t31_var_oneuse6_before := [llvmfunc|
  llvm.func @t31_var_oneuse6(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def t32_shift_of_const_oneuse0_before := [llvmfunc|
  llvm.func @t32_shift_of_const_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-52543054 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %1, %4  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.add %arg2, %2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %arg1, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %5, %7  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    llvm.return %9 : i1
  }]

def t33_shift_of_const_oneuse1_before := [llvmfunc|
  llvm.func @t33_shift_of_const_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-52543054 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %arg0, %4  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %2, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.and %5, %7  : i32
    %9 = llvm.icmp "ne" %8, %3 : i32
    llvm.return %9 : i1
  }]

def t34_commutativity0_oneuse0_before := [llvmfunc|
  llvm.func @t34_commutativity0_oneuse0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %2, %0  : i32
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }]

def t35_commutativity0_oneuse1_before := [llvmfunc|
  llvm.func @t35_commutativity0_oneuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.shl %2, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %4, %3  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }]

def t36_commutativity1_oneuse0_before := [llvmfunc|
  llvm.func @t36_commutativity1_oneuse0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.shl %arg0, %0  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }]

def t37_commutativity1_oneuse1_before := [llvmfunc|
  llvm.func @t37_commutativity1_oneuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.icmp "ne" %5, %1 : i32
    llvm.return %6 : i1
  }]

def n38_overshift_before := [llvmfunc|
  llvm.func @n38_overshift(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[15, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[17, 1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg1, %1  : vector<2xi32>
    %6 = llvm.and %5, %4  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %3 : vector<2xi32>
    llvm.return %7 : vector<2xi1>
  }]

def constantexpr_before := [llvmfunc|
  llvm.func @constantexpr() -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @f.a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i16
    %4 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %5 = llvm.ashr %4, %2  : i16
    %6 = llvm.icmp "ne" %3, %2 : i16
    %7 = llvm.zext %6 : i1 to i16
    %8 = llvm.ashr %5, %7  : i16
    %9 = llvm.and %8, %2  : i16
    %10 = llvm.icmp "ne" %9, %0 : i16
    llvm.return %10 : i1
  }]

def pr44802_before := [llvmfunc|
  llvm.func @pr44802(%arg0: i3, %arg1: i3, %arg2: i3) -> i1 {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.icmp "ne" %arg0, %0 : i3
    %2 = llvm.zext %1 : i1 to i3
    %3 = llvm.lshr %arg1, %2  : i3
    %4 = llvm.shl %arg2, %2  : i3
    %5 = llvm.and %3, %4  : i3
    %6 = llvm.icmp "ne" %5, %0 : i3
    llvm.return %6 : i1
  }]

def t0_const_lshr_shl_ne_combined := [llvmfunc|
  llvm.func @t0_const_lshr_shl_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t0_const_lshr_shl_ne   : t0_const_lshr_shl_ne_before  ⊑  t0_const_lshr_shl_ne_combined := by
  unfold t0_const_lshr_shl_ne_before t0_const_lshr_shl_ne_combined
  simp_alive_peephole
  sorry
def t1_const_shl_lshr_ne_combined := [llvmfunc|
  llvm.func @t1_const_shl_lshr_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t1_const_shl_lshr_ne   : t1_const_shl_lshr_ne_before  ⊑  t1_const_shl_lshr_ne_combined := by
  unfold t1_const_shl_lshr_ne_before t1_const_shl_lshr_ne_combined
  simp_alive_peephole
  sorry
def t2_const_lshr_shl_eq_combined := [llvmfunc|
  llvm.func @t2_const_lshr_shl_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t2_const_lshr_shl_eq   : t2_const_lshr_shl_eq_before  ⊑  t2_const_lshr_shl_eq_combined := by
  unfold t2_const_lshr_shl_eq_before t2_const_lshr_shl_eq_combined
  simp_alive_peephole
  sorry
def t3_const_after_fold_lshr_shl_ne_combined := [llvmfunc|
  llvm.func @t3_const_after_fold_lshr_shl_ne(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t3_const_after_fold_lshr_shl_ne   : t3_const_after_fold_lshr_shl_ne_before  ⊑  t3_const_after_fold_lshr_shl_ne_combined := by
  unfold t3_const_after_fold_lshr_shl_ne_before t3_const_after_fold_lshr_shl_ne_combined
  simp_alive_peephole
  sorry
def t4_const_after_fold_lshr_shl_ne_combined := [llvmfunc|
  llvm.func @t4_const_after_fold_lshr_shl_ne(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t4_const_after_fold_lshr_shl_ne   : t4_const_after_fold_lshr_shl_ne_before  ⊑  t4_const_after_fold_lshr_shl_ne_combined := by
  unfold t4_const_after_fold_lshr_shl_ne_before t4_const_after_fold_lshr_shl_ne_combined
  simp_alive_peephole
  sorry
def t5_const_lshr_shl_ne_combined := [llvmfunc|
  llvm.func @t5_const_lshr_shl_ne(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t5_const_lshr_shl_ne   : t5_const_lshr_shl_ne_before  ⊑  t5_const_lshr_shl_ne_combined := by
  unfold t5_const_lshr_shl_ne_before t5_const_lshr_shl_ne_combined
  simp_alive_peephole
  sorry
def t6_const_shl_lshr_ne_combined := [llvmfunc|
  llvm.func @t6_const_shl_lshr_ne(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.shl %arg0, %arg2  : i32
    %2 = llvm.lshr %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t6_const_shl_lshr_ne   : t6_const_shl_lshr_ne_before  ⊑  t6_const_shl_lshr_ne_combined := by
  unfold t6_const_shl_lshr_ne_before t6_const_shl_lshr_ne_combined
  simp_alive_peephole
  sorry
def t7_const_lshr_shl_ne_vec_splat_combined := [llvmfunc|
  llvm.func @t7_const_lshr_shl_ne_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.and %3, %arg1  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_t7_const_lshr_shl_ne_vec_splat   : t7_const_lshr_shl_ne_vec_splat_before  ⊑  t7_const_lshr_shl_ne_vec_splat_combined := by
  unfold t7_const_lshr_shl_ne_vec_splat_before t7_const_lshr_shl_ne_vec_splat_combined
  simp_alive_peephole
  sorry
def t8_const_lshr_shl_ne_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t8_const_lshr_shl_ne_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[4, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.and %3, %arg1  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_t8_const_lshr_shl_ne_vec_nonsplat   : t8_const_lshr_shl_ne_vec_nonsplat_before  ⊑  t8_const_lshr_shl_ne_vec_nonsplat_combined := by
  unfold t8_const_lshr_shl_ne_vec_nonsplat_before t8_const_lshr_shl_ne_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t9_const_lshr_shl_ne_vec_poison0_combined := [llvmfunc|
  llvm.func @t9_const_lshr_shl_ne_vec_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.lshr %arg0, %8  : vector<3xi32>
    %12 = llvm.and %11, %arg1  : vector<3xi32>
    %13 = llvm.icmp "ne" %12, %10 : vector<3xi32>
    llvm.return %13 : vector<3xi1>
  }]

theorem inst_combine_t9_const_lshr_shl_ne_vec_poison0   : t9_const_lshr_shl_ne_vec_poison0_before  ⊑  t9_const_lshr_shl_ne_vec_poison0_combined := by
  unfold t9_const_lshr_shl_ne_vec_poison0_before t9_const_lshr_shl_ne_vec_poison0_combined
  simp_alive_peephole
  sorry
def t10_const_lshr_shl_ne_vec_poison1_combined := [llvmfunc|
  llvm.func @t10_const_lshr_shl_ne_vec_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.lshr %arg0, %8  : vector<3xi32>
    %12 = llvm.and %11, %arg1  : vector<3xi32>
    %13 = llvm.icmp "ne" %12, %10 : vector<3xi32>
    llvm.return %13 : vector<3xi1>
  }]

theorem inst_combine_t10_const_lshr_shl_ne_vec_poison1   : t10_const_lshr_shl_ne_vec_poison1_before  ⊑  t10_const_lshr_shl_ne_vec_poison1_combined := by
  unfold t10_const_lshr_shl_ne_vec_poison1_before t10_const_lshr_shl_ne_vec_poison1_combined
  simp_alive_peephole
  sorry
def t11_const_lshr_shl_ne_vec_poison2_combined := [llvmfunc|
  llvm.func @t11_const_lshr_shl_ne_vec_poison2(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.lshr %arg0, %0  : vector<3xi32>
    %4 = llvm.and %3, %arg1  : vector<3xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<3xi32>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_t11_const_lshr_shl_ne_vec_poison2   : t11_const_lshr_shl_ne_vec_poison2_before  ⊑  t11_const_lshr_shl_ne_vec_poison2_combined := by
  unfold t11_const_lshr_shl_ne_vec_poison2_before t11_const_lshr_shl_ne_vec_poison2_combined
  simp_alive_peephole
  sorry
def t12_const_lshr_shl_ne_vec_poison3_combined := [llvmfunc|
  llvm.func @t12_const_lshr_shl_ne_vec_poison3(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.lshr %arg0, %8  : vector<3xi32>
    %12 = llvm.and %11, %arg1  : vector<3xi32>
    %13 = llvm.icmp "ne" %12, %10 : vector<3xi32>
    llvm.return %13 : vector<3xi1>
  }]

theorem inst_combine_t12_const_lshr_shl_ne_vec_poison3   : t12_const_lshr_shl_ne_vec_poison3_before  ⊑  t12_const_lshr_shl_ne_vec_poison3_combined := by
  unfold t12_const_lshr_shl_ne_vec_poison3_before t12_const_lshr_shl_ne_vec_poison3_combined
  simp_alive_peephole
  sorry
def t13_const_lshr_shl_ne_vec_poison4_combined := [llvmfunc|
  llvm.func @t13_const_lshr_shl_ne_vec_poison4(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.lshr %arg0, %8  : vector<3xi32>
    %12 = llvm.and %11, %arg1  : vector<3xi32>
    %13 = llvm.icmp "ne" %12, %10 : vector<3xi32>
    llvm.return %13 : vector<3xi1>
  }]

theorem inst_combine_t13_const_lshr_shl_ne_vec_poison4   : t13_const_lshr_shl_ne_vec_poison4_before  ⊑  t13_const_lshr_shl_ne_vec_poison4_combined := by
  unfold t13_const_lshr_shl_ne_vec_poison4_before t13_const_lshr_shl_ne_vec_poison4_combined
  simp_alive_peephole
  sorry
def t14_const_lshr_shl_ne_vec_poison5_combined := [llvmfunc|
  llvm.func @t14_const_lshr_shl_ne_vec_poison5(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.lshr %arg0, %8  : vector<3xi32>
    %12 = llvm.and %11, %arg1  : vector<3xi32>
    %13 = llvm.icmp "ne" %12, %10 : vector<3xi32>
    llvm.return %13 : vector<3xi1>
  }]

theorem inst_combine_t14_const_lshr_shl_ne_vec_poison5   : t14_const_lshr_shl_ne_vec_poison5_before  ⊑  t14_const_lshr_shl_ne_vec_poison5_combined := by
  unfold t14_const_lshr_shl_ne_vec_poison5_before t14_const_lshr_shl_ne_vec_poison5_combined
  simp_alive_peephole
  sorry
def t15_const_lshr_shl_ne_vec_poison6_combined := [llvmfunc|
  llvm.func @t15_const_lshr_shl_ne_vec_poison6(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %11 = llvm.lshr %arg0, %8  : vector<3xi32>
    %12 = llvm.and %11, %arg1  : vector<3xi32>
    %13 = llvm.icmp "ne" %12, %10 : vector<3xi32>
    llvm.return %13 : vector<3xi1>
  }]

theorem inst_combine_t15_const_lshr_shl_ne_vec_poison6   : t15_const_lshr_shl_ne_vec_poison6_before  ⊑  t15_const_lshr_shl_ne_vec_poison6_combined := by
  unfold t15_const_lshr_shl_ne_vec_poison6_before t15_const_lshr_shl_ne_vec_poison6_combined
  simp_alive_peephole
  sorry
def t16_commutativity0_combined := [llvmfunc|
  llvm.func @t16_commutativity0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t16_commutativity0   : t16_commutativity0_before  ⊑  t16_commutativity0_combined := by
  unfold t16_commutativity0_before t16_commutativity0_combined
  simp_alive_peephole
  sorry
def t17_commutativity1_combined := [llvmfunc|
  llvm.func @t17_commutativity1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.call @gen32() : () -> i32
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.and %3, %arg0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t17_commutativity1   : t17_commutativity1_before  ⊑  t17_commutativity1_combined := by
  unfold t17_commutativity1_before t17_commutativity1_combined
  simp_alive_peephole
  sorry
def t18_const_oneuse0_combined := [llvmfunc|
  llvm.func @t18_const_oneuse0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_t18_const_oneuse0   : t18_const_oneuse0_before  ⊑  t18_const_oneuse0_combined := by
  unfold t18_const_oneuse0_before t18_const_oneuse0_combined
  simp_alive_peephole
  sorry
def t19_const_oneuse1_combined := [llvmfunc|
  llvm.func @t19_const_oneuse1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %arg1  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_t19_const_oneuse1   : t19_const_oneuse1_before  ⊑  t19_const_oneuse1_combined := by
  unfold t19_const_oneuse1_before t19_const_oneuse1_combined
  simp_alive_peephole
  sorry
def t20_const_oneuse2_combined := [llvmfunc|
  llvm.func @t20_const_oneuse2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t20_const_oneuse2   : t20_const_oneuse2_before  ⊑  t20_const_oneuse2_combined := by
  unfold t20_const_oneuse2_before t20_const_oneuse2_combined
  simp_alive_peephole
  sorry
def t21_const_oneuse3_combined := [llvmfunc|
  llvm.func @t21_const_oneuse3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t21_const_oneuse3   : t21_const_oneuse3_before  ⊑  t21_const_oneuse3_combined := by
  unfold t21_const_oneuse3_before t21_const_oneuse3_combined
  simp_alive_peephole
  sorry
def t22_const_oneuse4_combined := [llvmfunc|
  llvm.func @t22_const_oneuse4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t22_const_oneuse4   : t22_const_oneuse4_before  ⊑  t22_const_oneuse4_combined := by
  unfold t22_const_oneuse4_before t22_const_oneuse4_combined
  simp_alive_peephole
  sorry
def t23_const_oneuse5_combined := [llvmfunc|
  llvm.func @t23_const_oneuse5(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t23_const_oneuse5   : t23_const_oneuse5_before  ⊑  t23_const_oneuse5_combined := by
  unfold t23_const_oneuse5_before t23_const_oneuse5_combined
  simp_alive_peephole
  sorry
def t24_const_oneuse6_combined := [llvmfunc|
  llvm.func @t24_const_oneuse6(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.shl %arg1, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.and %3, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t24_const_oneuse6   : t24_const_oneuse6_before  ⊑  t24_const_oneuse6_combined := by
  unfold t24_const_oneuse6_before t24_const_oneuse6_combined
  simp_alive_peephole
  sorry
def t25_var_oneuse0_combined := [llvmfunc|
  llvm.func @t25_var_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t25_var_oneuse0   : t25_var_oneuse0_before  ⊑  t25_var_oneuse0_combined := by
  unfold t25_var_oneuse0_before t25_var_oneuse0_combined
  simp_alive_peephole
  sorry
def t26_var_oneuse1_combined := [llvmfunc|
  llvm.func @t26_var_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t26_var_oneuse1   : t26_var_oneuse1_before  ⊑  t26_var_oneuse1_combined := by
  unfold t26_var_oneuse1_before t26_var_oneuse1_combined
  simp_alive_peephole
  sorry
def t27_var_oneuse2_combined := [llvmfunc|
  llvm.func @t27_var_oneuse2(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t27_var_oneuse2   : t27_var_oneuse2_before  ⊑  t27_var_oneuse2_combined := by
  unfold t27_var_oneuse2_before t27_var_oneuse2_combined
  simp_alive_peephole
  sorry
def t28_var_oneuse3_combined := [llvmfunc|
  llvm.func @t28_var_oneuse3(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t28_var_oneuse3   : t28_var_oneuse3_before  ⊑  t28_var_oneuse3_combined := by
  unfold t28_var_oneuse3_before t28_var_oneuse3_combined
  simp_alive_peephole
  sorry
def t29_var_oneuse4_combined := [llvmfunc|
  llvm.func @t29_var_oneuse4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t29_var_oneuse4   : t29_var_oneuse4_before  ⊑  t29_var_oneuse4_combined := by
  unfold t29_var_oneuse4_before t29_var_oneuse4_combined
  simp_alive_peephole
  sorry
def t30_var_oneuse5_combined := [llvmfunc|
  llvm.func @t30_var_oneuse5(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t30_var_oneuse5   : t30_var_oneuse5_before  ⊑  t30_var_oneuse5_combined := by
  unfold t30_var_oneuse5_before t30_var_oneuse5_combined
  simp_alive_peephole
  sorry
def t31_var_oneuse6_combined := [llvmfunc|
  llvm.func @t31_var_oneuse6(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.shl %arg1, %arg3  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %1  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_t31_var_oneuse6   : t31_var_oneuse6_before  ⊑  t31_var_oneuse6_combined := by
  unfold t31_var_oneuse6_before t31_var_oneuse6_combined
  simp_alive_peephole
  sorry
def t32_shift_of_const_oneuse0_combined := [llvmfunc|
  llvm.func @t32_shift_of_const_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-52543054 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.lshr %1, %5  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.add %arg2, %2  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.shl %arg1, %7  : i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %arg1, %3  : i32
    %10 = llvm.icmp "ne" %9, %4 : i32
    llvm.return %10 : i1
  }]

theorem inst_combine_t32_shift_of_const_oneuse0   : t32_shift_of_const_oneuse0_before  ⊑  t32_shift_of_const_oneuse0_combined := by
  unfold t32_shift_of_const_oneuse0_before t32_shift_of_const_oneuse0_combined
  simp_alive_peephole
  sorry
def t33_shift_of_const_oneuse1_combined := [llvmfunc|
  llvm.func @t33_shift_of_const_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-52543054 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %arg0, %4  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.shl %2, %6  : i32
    llvm.call @use32(%7) : (i32) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_t33_shift_of_const_oneuse1   : t33_shift_of_const_oneuse1_before  ⊑  t33_shift_of_const_oneuse1_combined := by
  unfold t33_shift_of_const_oneuse1_before t33_shift_of_const_oneuse1_combined
  simp_alive_peephole
  sorry
def t34_commutativity0_oneuse0_combined := [llvmfunc|
  llvm.func @t34_commutativity0_oneuse0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @gen32() : () -> i32
    %4 = llvm.lshr %arg0, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.and %5, %3  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_t34_commutativity0_oneuse0   : t34_commutativity0_oneuse0_before  ⊑  t34_commutativity0_oneuse0_combined := by
  unfold t34_commutativity0_oneuse0_before t34_commutativity0_oneuse0_combined
  simp_alive_peephole
  sorry
def t35_commutativity0_oneuse1_combined := [llvmfunc|
  llvm.func @t35_commutativity0_oneuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @gen32() : () -> i32
    %4 = llvm.shl %3, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %arg0, %1  : i32
    %6 = llvm.and %5, %3  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_t35_commutativity0_oneuse1   : t35_commutativity0_oneuse1_before  ⊑  t35_commutativity0_oneuse1_combined := by
  unfold t35_commutativity0_oneuse1_before t35_commutativity0_oneuse1_combined
  simp_alive_peephole
  sorry
def t36_commutativity1_oneuse0_combined := [llvmfunc|
  llvm.func @t36_commutativity1_oneuse0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @gen32() : () -> i32
    %4 = llvm.lshr %3, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %3, %1  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_t36_commutativity1_oneuse0   : t36_commutativity1_oneuse0_before  ⊑  t36_commutativity1_oneuse0_combined := by
  unfold t36_commutativity1_oneuse0_before t36_commutativity1_oneuse0_combined
  simp_alive_peephole
  sorry
def t37_commutativity1_oneuse1_combined := [llvmfunc|
  llvm.func @t37_commutativity1_oneuse1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @gen32() : () -> i32
    %4 = llvm.shl %arg0, %0  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %3, %1  : i32
    %6 = llvm.and %5, %arg0  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_t37_commutativity1_oneuse1   : t37_commutativity1_oneuse1_before  ⊑  t37_commutativity1_oneuse1_combined := by
  unfold t37_commutativity1_oneuse1_before t37_commutativity1_oneuse1_combined
  simp_alive_peephole
  sorry
def n38_overshift_combined := [llvmfunc|
  llvm.func @n38_overshift(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[15, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[17, 1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg1, %1  : vector<2xi32>
    %6 = llvm.and %5, %4  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %3 : vector<2xi32>
    llvm.return %7 : vector<2xi1>
  }]

theorem inst_combine_n38_overshift   : n38_overshift_before  ⊑  n38_overshift_combined := by
  unfold n38_overshift_before n38_overshift_combined
  simp_alive_peephole
  sorry
def constantexpr_combined := [llvmfunc|
  llvm.func @constantexpr() -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @f.a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i16) : i16
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i16
    %4 = llvm.icmp "ne" %3, %2 : i16
    %5 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> i16
    %6 = llvm.lshr %5, %2  : i16
    %7 = llvm.zext %4 : i1 to i16
    %8 = llvm.shl %2, %7 overflow<nsw, nuw>  : i16
    %9 = llvm.and %6, %8  : i16
    %10 = llvm.icmp "ne" %9, %0 : i16
    llvm.return %10 : i1
  }]

theorem inst_combine_constantexpr   : constantexpr_before  ⊑  constantexpr_combined := by
  unfold constantexpr_before constantexpr_combined
  simp_alive_peephole
  sorry
def pr44802_combined := [llvmfunc|
  llvm.func @pr44802(%arg0: i3, %arg1: i3, %arg2: i3) -> i1 {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.icmp "ne" %arg0, %0 : i3
    %2 = llvm.zext %1 : i1 to i3
    %3 = llvm.lshr %arg1, %2  : i3
    %4 = llvm.shl %arg2, %2  : i3
    %5 = llvm.and %3, %4  : i3
    %6 = llvm.icmp "ne" %5, %0 : i3
    llvm.return %6 : i1
  }]

theorem inst_combine_pr44802   : pr44802_before  ⊑  pr44802_combined := by
  unfold pr44802_before pr44802_combined
  simp_alive_peephole
  sorry
