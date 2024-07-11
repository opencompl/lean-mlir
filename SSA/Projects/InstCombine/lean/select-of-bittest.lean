import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-of-bittest
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def and_lshr_and_before := [llvmfunc|
  llvm.func @and_lshr_and(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.lshr %arg0, %0  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }]

def and_lshr_and_splatvec_before := [llvmfunc|
  llvm.func @and_lshr_and_splatvec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    %5 = llvm.lshr %arg0, %0  : vector<2xi32>
    %6 = llvm.and %5, %0  : vector<2xi32>
    %7 = llvm.select %4, %6, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def and_lshr_and_vec_v0_before := [llvmfunc|
  llvm.func @and_lshr_and_vec_v0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 4]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.lshr %arg0, %3  : vector<2xi32>
    %7 = llvm.and %6, %3  : vector<2xi32>
    %8 = llvm.select %5, %7, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def and_lshr_and_vec_v1_before := [llvmfunc|
  llvm.func @and_lshr_and_vec_v1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.lshr %arg0, %3  : vector<2xi32>
    %7 = llvm.and %6, %0  : vector<2xi32>
    %8 = llvm.select %5, %7, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def and_lshr_and_vec_v2_before := [llvmfunc|
  llvm.func @and_lshr_and_vec_v2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %5 = llvm.and %arg0, %0  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi32>
    %7 = llvm.lshr %arg0, %3  : vector<2xi32>
    %8 = llvm.and %7, %4  : vector<2xi32>
    %9 = llvm.select %6, %8, %4 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def and_lshr_and_vec_poison_before := [llvmfunc|
  llvm.func @and_lshr_and_vec_poison(%arg0: vector<3xi32>) -> vector<3xi32> {
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
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %16 : vector<3xi32>
    %19 = llvm.lshr %arg0, %8  : vector<3xi32>
    %20 = llvm.and %19, %8  : vector<3xi32>
    %21 = llvm.select %18, %20, %8 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }]

def and_and_before := [llvmfunc|
  llvm.func @and_and(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }]

def and_and_splatvec_before := [llvmfunc|
  llvm.func @and_and_splatvec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.and %arg0, %3  : vector<2xi32>
    %7 = llvm.select %5, %6, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def and_and_vec_before := [llvmfunc|
  llvm.func @and_and_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[6, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.and %arg0, %3  : vector<2xi32>
    %7 = llvm.select %5, %6, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def and_and_vec_poison_before := [llvmfunc|
  llvm.func @and_and_vec_poison(%arg0: vector<3xi32>) -> vector<3xi32> {
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
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.mlir.constant(1 : i32) : i32
    %18 = llvm.mlir.undef : vector<3xi32>
    %19 = llvm.mlir.constant(0 : i32) : i32
    %20 = llvm.insertelement %17, %18[%19 : i32] : vector<3xi32>
    %21 = llvm.mlir.constant(1 : i32) : i32
    %22 = llvm.insertelement %1, %20[%21 : i32] : vector<3xi32>
    %23 = llvm.mlir.constant(2 : i32) : i32
    %24 = llvm.insertelement %17, %22[%23 : i32] : vector<3xi32>
    %25 = llvm.and %arg0, %8  : vector<3xi32>
    %26 = llvm.icmp "eq" %25, %16 : vector<3xi32>
    %27 = llvm.and %arg0, %24  : vector<3xi32>
    %28 = llvm.select %26, %27, %24 : vector<3xi1>, vector<3xi32>
    llvm.return %28 : vector<3xi32>
  }]

def f_var0_before := [llvmfunc|
  llvm.func @f_var0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }]

def f_var0_commutative_and_before := [llvmfunc|
  llvm.func @f_var0_commutative_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }]

def f_var0_splatvec_before := [llvmfunc|
  llvm.func @f_var0_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    %5 = llvm.lshr %arg0, %2  : vector<2xi32>
    %6 = llvm.and %5, %2  : vector<2xi32>
    %7 = llvm.select %4, %6, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def f_var0_vec_before := [llvmfunc|
  llvm.func @f_var0_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %arg1  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %1 : vector<2xi32>
    %6 = llvm.lshr %arg0, %2  : vector<2xi32>
    %7 = llvm.and %6, %3  : vector<2xi32>
    %8 = llvm.select %5, %7, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def f_var0_vec_poison_before := [llvmfunc|
  llvm.func @f_var0_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %arg1  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %8 : vector<3xi32>
    %19 = llvm.lshr %arg0, %16  : vector<3xi32>
    %20 = llvm.and %19, %16  : vector<3xi32>
    %21 = llvm.select %18, %20, %16 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }]

def f_var1_before := [llvmfunc|
  llvm.func @f_var1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.select %3, %4, %1 : i1, i32
    llvm.return %5 : i32
  }]

def f_var1_commutative_and_before := [llvmfunc|
  llvm.func @f_var1_commutative_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.select %3, %4, %1 : i1, i32
    llvm.return %5 : i32
  }]

def f_var1_vec_before := [llvmfunc|
  llvm.func @f_var1_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    %5 = llvm.and %arg0, %2  : vector<2xi32>
    %6 = llvm.select %4, %5, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def f_var1_vec_poison_before := [llvmfunc|
  llvm.func @f_var1_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %arg1  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %8 : vector<3xi32>
    %19 = llvm.and %arg0, %16  : vector<3xi32>
    %20 = llvm.select %18, %19, %16 : vector<3xi1>, vector<3xi32>
    llvm.return %20 : vector<3xi32>
  }]

def f_var2_before := [llvmfunc|
  llvm.func @f_var2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.lshr %arg0, %arg1  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }]

def f_var2_splatvec_before := [llvmfunc|
  llvm.func @f_var2_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    %5 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %6 = llvm.and %5, %0  : vector<2xi32>
    %7 = llvm.select %4, %6, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def f_var2_vec_before := [llvmfunc|
  llvm.func @f_var2_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %7 = llvm.and %6, %3  : vector<2xi32>
    %8 = llvm.select %5, %7, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def f_var2_vec_poison_before := [llvmfunc|
  llvm.func @f_var2_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
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
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %16 : vector<3xi32>
    %19 = llvm.lshr %arg0, %arg1  : vector<3xi32>
    %20 = llvm.and %19, %8  : vector<3xi32>
    %21 = llvm.select %18, %20, %8 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }]

def f_var3_before := [llvmfunc|
  llvm.func @f_var3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }]

def f_var3_commutative_and_before := [llvmfunc|
  llvm.func @f_var3_commutative_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }]

def f_var3_splatvec_before := [llvmfunc|
  llvm.func @f_var3_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    %5 = llvm.lshr %arg0, %arg2  : vector<2xi32>
    %6 = llvm.and %5, %2  : vector<2xi32>
    %7 = llvm.select %4, %6, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def f_var3_vec_poison_before := [llvmfunc|
  llvm.func @f_var3_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %arg1  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %8 : vector<3xi32>
    %19 = llvm.lshr %arg0, %arg2  : vector<3xi32>
    %20 = llvm.and %19, %16  : vector<3xi32>
    %21 = llvm.select %18, %20, %16 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }]

def n_var0_oneuse_before := [llvmfunc|
  llvm.func @n_var0_oneuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use1(%3) : (i1) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

def n_var1_oneuse_before := [llvmfunc|
  llvm.func @n_var1_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.select %3, %4, %1 : i1, i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use1(%3) : (i1) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def n0_before := [llvmfunc|
  llvm.func @n0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.lshr %arg1, %0  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %0  : i32
    %7 = llvm.select %4, %6, %1 : i1, i32
    llvm.return %7 : i32
  }]

def n3_before := [llvmfunc|
  llvm.func @n3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.select %4, %5, %1 : i1, i32
    llvm.return %6 : i32
  }]

def n4_before := [llvmfunc|
  llvm.func @n4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.select %4, %6, %0 : i1, i32
    llvm.return %7 : i32
  }]

def n5_before := [llvmfunc|
  llvm.func @n5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }]

def n6_before := [llvmfunc|
  llvm.func @n6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %0  : i32
    %7 = llvm.select %4, %6, %0 : i1, i32
    llvm.return %7 : i32
  }]

def n7_before := [llvmfunc|
  llvm.func @n7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }]

def n8_before := [llvmfunc|
  llvm.func @n8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }]

def and_lshr_and_combined := [llvmfunc|
  llvm.func @and_lshr_and(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_lshr_and   : and_lshr_and_before  ⊑  and_lshr_and_combined := by
  unfold and_lshr_and_before and_lshr_and_combined
  simp_alive_peephole
  sorry
def and_lshr_and_splatvec_combined := [llvmfunc|
  llvm.func @and_lshr_and_splatvec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_and_lshr_and_splatvec   : and_lshr_and_splatvec_before  ⊑  and_lshr_and_splatvec_combined := by
  unfold and_lshr_and_splatvec_before and_lshr_and_splatvec_combined
  simp_alive_peephole
  sorry
def and_lshr_and_vec_v0_combined := [llvmfunc|
  llvm.func @and_lshr_and_vec_v0(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[3, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_and_lshr_and_vec_v0   : and_lshr_and_vec_v0_before  ⊑  and_lshr_and_vec_v0_combined := by
  unfold and_lshr_and_vec_v0_before and_lshr_and_vec_v0_combined
  simp_alive_peephole
  sorry
def and_lshr_and_vec_v1_combined := [llvmfunc|
  llvm.func @and_lshr_and_vec_v1(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[3, 5]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_and_lshr_and_vec_v1   : and_lshr_and_vec_v1_before  ⊑  and_lshr_and_vec_v1_combined := by
  unfold and_lshr_and_vec_v1_before and_lshr_and_vec_v1_combined
  simp_alive_peephole
  sorry
def and_lshr_and_vec_v2_combined := [llvmfunc|
  llvm.func @and_lshr_and_vec_v2(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[12, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_and_lshr_and_vec_v2   : and_lshr_and_vec_v2_before  ⊑  and_lshr_and_vec_v2_combined := by
  unfold and_lshr_and_vec_v2_before and_lshr_and_vec_v2_combined
  simp_alive_peephole
  sorry
def and_lshr_and_vec_poison_combined := [llvmfunc|
  llvm.func @and_lshr_and_vec_poison(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
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
    %11 = llvm.and %arg0, %8  : vector<3xi32>
    %12 = llvm.icmp "ne" %11, %10 : vector<3xi32>
    %13 = llvm.zext %12 : vector<3xi1> to vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }]

theorem inst_combine_and_lshr_and_vec_poison   : and_lshr_and_vec_poison_before  ⊑  and_lshr_and_vec_poison_combined := by
  unfold and_lshr_and_vec_poison_before and_lshr_and_vec_poison_combined
  simp_alive_peephole
  sorry
def and_and_combined := [llvmfunc|
  llvm.func @and_and(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_and_and   : and_and_before  ⊑  and_and_combined := by
  unfold and_and_before and_and_combined
  simp_alive_peephole
  sorry
def and_and_splatvec_combined := [llvmfunc|
  llvm.func @and_and_splatvec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_and_and_splatvec   : and_and_splatvec_before  ⊑  and_and_splatvec_combined := by
  unfold and_and_splatvec_before and_and_splatvec_combined
  simp_alive_peephole
  sorry
def and_and_vec_combined := [llvmfunc|
  llvm.func @and_and_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[7, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_and_and_vec   : and_and_vec_before  ⊑  and_and_vec_combined := by
  unfold and_and_vec_before and_and_vec_combined
  simp_alive_peephole
  sorry
def and_and_vec_poison_combined := [llvmfunc|
  llvm.func @and_and_vec_poison(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
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
    %11 = llvm.and %arg0, %8  : vector<3xi32>
    %12 = llvm.icmp "ne" %11, %10 : vector<3xi32>
    %13 = llvm.zext %12 : vector<3xi1> to vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }]

theorem inst_combine_and_and_vec_poison   : and_and_vec_poison_before  ⊑  and_and_vec_poison_combined := by
  unfold and_and_vec_poison_before and_and_vec_poison_combined
  simp_alive_peephole
  sorry
def f_var0_combined := [llvmfunc|
  llvm.func @f_var0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_f_var0   : f_var0_before  ⊑  f_var0_combined := by
  unfold f_var0_before f_var0_combined
  simp_alive_peephole
  sorry
def f_var0_commutative_and_combined := [llvmfunc|
  llvm.func @f_var0_commutative_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_f_var0_commutative_and   : f_var0_commutative_and_before  ⊑  f_var0_commutative_and_combined := by
  unfold f_var0_commutative_and_before f_var0_commutative_and_combined
  simp_alive_peephole
  sorry
def f_var0_splatvec_combined := [llvmfunc|
  llvm.func @f_var0_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg1, %0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.zext %5 : vector<2xi1> to vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_f_var0_splatvec   : f_var0_splatvec_before  ⊑  f_var0_splatvec_combined := by
  unfold f_var0_splatvec_before f_var0_splatvec_combined
  simp_alive_peephole
  sorry
def f_var0_vec_combined := [llvmfunc|
  llvm.func @f_var0_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 4]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg1, %0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.zext %5 : vector<2xi1> to vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_f_var0_vec   : f_var0_vec_before  ⊑  f_var0_vec_combined := by
  unfold f_var0_vec_before f_var0_vec_combined
  simp_alive_peephole
  sorry
def f_var0_vec_poison_combined := [llvmfunc|
  llvm.func @f_var0_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
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
    %11 = llvm.or %arg1, %8  : vector<3xi32>
    %12 = llvm.and %11, %arg0  : vector<3xi32>
    %13 = llvm.icmp "ne" %12, %10 : vector<3xi32>
    %14 = llvm.zext %13 : vector<3xi1> to vector<3xi32>
    llvm.return %14 : vector<3xi32>
  }]

theorem inst_combine_f_var0_vec_poison   : f_var0_vec_poison_before  ⊑  f_var0_vec_poison_combined := by
  unfold f_var0_vec_poison_before f_var0_vec_poison_combined
  simp_alive_peephole
  sorry
def f_var1_combined := [llvmfunc|
  llvm.func @f_var1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_f_var1   : f_var1_before  ⊑  f_var1_combined := by
  unfold f_var1_before f_var1_combined
  simp_alive_peephole
  sorry
def f_var1_commutative_and_combined := [llvmfunc|
  llvm.func @f_var1_commutative_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }]

theorem inst_combine_f_var1_commutative_and   : f_var1_commutative_and_before  ⊑  f_var1_commutative_and_combined := by
  unfold f_var1_commutative_and_before f_var1_commutative_and_combined
  simp_alive_peephole
  sorry
def f_var1_vec_combined := [llvmfunc|
  llvm.func @f_var1_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg1, %0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.zext %5 : vector<2xi1> to vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_f_var1_vec   : f_var1_vec_before  ⊑  f_var1_vec_combined := by
  unfold f_var1_vec_before f_var1_vec_combined
  simp_alive_peephole
  sorry
def f_var1_vec_poison_combined := [llvmfunc|
  llvm.func @f_var1_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.or %arg1, %0  : vector<3xi32>
    %4 = llvm.and %3, %arg0  : vector<3xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<3xi32>
    %6 = llvm.zext %5 : vector<3xi1> to vector<3xi32>
    llvm.return %6 : vector<3xi32>
  }]

theorem inst_combine_f_var1_vec_poison   : f_var1_vec_poison_before  ⊑  f_var1_vec_poison_combined := by
  unfold f_var1_vec_poison_before f_var1_vec_poison_combined
  simp_alive_peephole
  sorry
def f_var2_combined := [llvmfunc|
  llvm.func @f_var2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.lshr %arg0, %arg1  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_f_var2   : f_var2_before  ⊑  f_var2_combined := by
  unfold f_var2_before f_var2_combined
  simp_alive_peephole
  sorry
def f_var2_splatvec_combined := [llvmfunc|
  llvm.func @f_var2_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    %5 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %6 = llvm.and %5, %0  : vector<2xi32>
    %7 = llvm.select %4, %6, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_f_var2_splatvec   : f_var2_splatvec_before  ⊑  f_var2_splatvec_combined := by
  unfold f_var2_splatvec_before f_var2_splatvec_combined
  simp_alive_peephole
  sorry
def f_var2_vec_combined := [llvmfunc|
  llvm.func @f_var2_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %7 = llvm.and %6, %3  : vector<2xi32>
    %8 = llvm.select %5, %7, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

theorem inst_combine_f_var2_vec   : f_var2_vec_before  ⊑  f_var2_vec_combined := by
  unfold f_var2_vec_before f_var2_vec_combined
  simp_alive_peephole
  sorry
def f_var2_vec_poison_combined := [llvmfunc|
  llvm.func @f_var2_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
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
    %17 = llvm.and %arg0, %8  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %16 : vector<3xi32>
    %19 = llvm.lshr %arg0, %arg1  : vector<3xi32>
    %20 = llvm.and %19, %8  : vector<3xi32>
    %21 = llvm.select %18, %20, %8 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }]

theorem inst_combine_f_var2_vec_poison   : f_var2_vec_poison_before  ⊑  f_var2_vec_poison_combined := by
  unfold f_var2_vec_poison_before f_var2_vec_poison_combined
  simp_alive_peephole
  sorry
def f_var3_combined := [llvmfunc|
  llvm.func @f_var3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_f_var3   : f_var3_before  ⊑  f_var3_combined := by
  unfold f_var3_before f_var3_combined
  simp_alive_peephole
  sorry
def f_var3_commutative_and_combined := [llvmfunc|
  llvm.func @f_var3_commutative_and(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_f_var3_commutative_and   : f_var3_commutative_and_before  ⊑  f_var3_commutative_and_combined := by
  unfold f_var3_commutative_and_before f_var3_commutative_and_combined
  simp_alive_peephole
  sorry
def f_var3_splatvec_combined := [llvmfunc|
  llvm.func @f_var3_splatvec(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %arg1  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi32>
    %5 = llvm.lshr %arg0, %arg2  : vector<2xi32>
    %6 = llvm.and %5, %2  : vector<2xi32>
    %7 = llvm.select %4, %6, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

theorem inst_combine_f_var3_splatvec   : f_var3_splatvec_before  ⊑  f_var3_splatvec_combined := by
  unfold f_var3_splatvec_before f_var3_splatvec_combined
  simp_alive_peephole
  sorry
def f_var3_vec_poison_combined := [llvmfunc|
  llvm.func @f_var3_vec_poison(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.and %arg0, %arg1  : vector<3xi32>
    %18 = llvm.icmp "eq" %17, %8 : vector<3xi32>
    %19 = llvm.lshr %arg0, %arg2  : vector<3xi32>
    %20 = llvm.and %19, %16  : vector<3xi32>
    %21 = llvm.select %18, %20, %16 : vector<3xi1>, vector<3xi32>
    llvm.return %21 : vector<3xi32>
  }]

theorem inst_combine_f_var3_vec_poison   : f_var3_vec_poison_before  ⊑  f_var3_vec_poison_combined := by
  unfold f_var3_vec_poison_before f_var3_vec_poison_combined
  simp_alive_peephole
  sorry
def n_var0_oneuse_combined := [llvmfunc|
  llvm.func @n_var0_oneuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.lshr %arg0, %arg2  : i32
    %5 = llvm.and %4, %1  : i32
    %6 = llvm.select %3, %5, %1 : i1, i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use1(%3) : (i1) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%5) : (i32) -> ()
    llvm.return %6 : i32
  }]

theorem inst_combine_n_var0_oneuse   : n_var0_oneuse_before  ⊑  n_var0_oneuse_combined := by
  unfold n_var0_oneuse_before n_var0_oneuse_combined
  simp_alive_peephole
  sorry
def n_var1_oneuse_combined := [llvmfunc|
  llvm.func @n_var1_oneuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %arg1  : i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.select %3, %4, %1 : i1, i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.call @use1(%3) : (i1) -> ()
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

theorem inst_combine_n_var1_oneuse   : n_var1_oneuse_before  ⊑  n_var1_oneuse_combined := by
  unfold n_var1_oneuse_before n_var1_oneuse_combined
  simp_alive_peephole
  sorry
def n0_combined := [llvmfunc|
  llvm.func @n0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.lshr %arg1, %0  : i32
    %5 = llvm.and %4, %0  : i32
    %6 = llvm.select %3, %5, %0 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_n0   : n0_before  ⊑  n0_combined := by
  unfold n0_before n0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %0  : i32
    %7 = llvm.select %4, %6, %1 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def n3_combined := [llvmfunc|
  llvm.func @n3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.select %4, %5, %1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_n3   : n3_before  ⊑  n3_combined := by
  unfold n3_before n3_combined
  simp_alive_peephole
  sorry
def n4_combined := [llvmfunc|
  llvm.func @n4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %2  : i32
    %7 = llvm.select %4, %6, %0 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n4   : n4_before  ⊑  n4_combined := by
  unfold n4_before n4_combined
  simp_alive_peephole
  sorry
def n5_combined := [llvmfunc|
  llvm.func @n5(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %0  : i32
    %6 = llvm.select %4, %5, %2 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_n5   : n5_before  ⊑  n5_combined := by
  unfold n5_before n5_combined
  simp_alive_peephole
  sorry
def n6_combined := [llvmfunc|
  llvm.func @n6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %0  : i32
    %7 = llvm.select %4, %0, %6 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n6   : n6_before  ⊑  n6_combined := by
  unfold n6_before n6_combined
  simp_alive_peephole
  sorry
def n7_combined := [llvmfunc|
  llvm.func @n7(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg0, %2  : i32
    %6 = llvm.select %4, %2, %5 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_n7   : n7_before  ⊑  n7_combined := by
  unfold n7_before n7_combined
  simp_alive_peephole
  sorry
def n8_combined := [llvmfunc|
  llvm.func @n8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.lshr %arg0, %2  : i32
    %6 = llvm.and %5, %0  : i32
    %7 = llvm.select %4, %0, %6 : i1, i32
    llvm.return %7 : i32
  }]

theorem inst_combine_n8   : n8_before  ⊑  n8_combined := by
  unfold n8_before n8_combined
  simp_alive_peephole
  sorry
