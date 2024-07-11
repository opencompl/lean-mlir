import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-with-bitwise-ops
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def select_icmp_eq_and_1_0_or_2_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_and_1_0_or_2_vec_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def select_icmp_eq_and_1_0_or_2_vec_poison1_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2_vec_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %9 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %10 = llvm.and %arg0, %6  : vector<2xi32>
    %11 = llvm.icmp "eq" %10, %8 : vector<2xi32>
    %12 = llvm.or %arg1, %9  : vector<2xi32>
    %13 = llvm.select %11, %arg1, %12 : vector<2xi1>, vector<2xi32>
    llvm.return %13 : vector<2xi32>
  }]

def select_icmp_eq_and_1_0_or_2_vec_poison2_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2_vec_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %9 = llvm.and %arg0, %0  : vector<2xi32>
    %10 = llvm.icmp "eq" %9, %7 : vector<2xi32>
    %11 = llvm.or %arg1, %8  : vector<2xi32>
    %12 = llvm.select %10, %arg1, %11 : vector<2xi1>, vector<2xi32>
    llvm.return %12 : vector<2xi32>
  }]

def select_icmp_eq_and_1_0_or_2_vec_poison3_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2_vec_poison3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.undef : vector<2xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi32>
    %10 = llvm.and %arg0, %0  : vector<2xi32>
    %11 = llvm.icmp "eq" %10, %2 : vector<2xi32>
    %12 = llvm.or %arg1, %9  : vector<2xi32>
    %13 = llvm.select %11, %arg1, %12 : vector<2xi1>, vector<2xi32>
    llvm.return %13 : vector<2xi32>
  }]

def select_icmp_eq_and_1_0_xor_2_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_xor_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_and_1_0_and_not_2_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_and_not_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_and_32_0_or_8_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_32_0_or_8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_and_32_0_or_8_vec_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_32_0_or_8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def select_icmp_eq_and_32_0_xor_8_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_32_0_xor_8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_and_32_0_and_not_8_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_32_0_and_not_8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_4096_or_4096_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_or_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    llvm.return %5 : i32
  }]

def select_icmp_ne_0_and_4096_or_4096_vec_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_or_4096_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4096> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %2, %3 : vector<2xi32>
    %5 = llvm.or %arg1, %0  : vector<2xi32>
    %6 = llvm.select %4, %arg1, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def select_icmp_ne_0_and_4096_xor_4096_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_xor_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    llvm.return %5 : i32
  }]

def select_icmp_ne_0_and_4096_and_not_4096_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_and_not_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_and_4096_0_or_4096_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_4096_0_or_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    llvm.return %5 : i32
  }]

def select_icmp_eq_and_4096_0_or_4096_vec_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_4096_0_or_4096_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4096> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    %5 = llvm.or %arg1, %0  : vector<2xi32>
    %6 = llvm.select %4, %arg1, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def select_icmp_eq_and_4096_0_xor_4096_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_4096_0_xor_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    llvm.return %5 : i32
  }]

def select_icmp_eq_and_4096_0_and_not_4096_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_4096_0_and_not_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_0_and_1_or_1_before := [llvmfunc|
  llvm.func @select_icmp_eq_0_and_1_or_1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_0_and_1_or_1_vec_before := [llvmfunc|
  llvm.func @select_icmp_eq_0_and_1_or_1_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi64>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi64>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def select_icmp_eq_0_and_1_xor_1_before := [llvmfunc|
  llvm.func @select_icmp_eq_0_and_1_xor_1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_0_and_1_and_not_1_before := [llvmfunc|
  llvm.func @select_icmp_eq_0_and_1_and_not_1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_4096_or_32_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_or_32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_4096_xor_32_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_xor_32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(32 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_4096_and_not_32_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_and_not_32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-33 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_32_or_4096_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_32_or_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4096 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_32_or_4096_vec_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_32_or_4096_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<4096> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "ne" %2, %4 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def select_icmp_ne_0_and_32_xor_4096_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_32_xor_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4096 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_32_and_not_4096_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_32_and_not_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_1073741824_or_8_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_1073741824_or_8(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i8
    %6 = llvm.select %4, %arg1, %5 : i1, i8
    llvm.return %6 : i8
  }]

def select_icmp_ne_0_and_1073741824_xor_8_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_1073741824_xor_8(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i8
    %6 = llvm.select %4, %arg1, %5 : i1, i8
    llvm.return %6 : i8
  }]

def select_icmp_ne_0_and_1073741824_and_not_8_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_1073741824_and_not_8(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i8) : i8
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.select %4, %arg1, %5 : i1, i8
    llvm.return %6 : i8
  }]

def select_icmp_ne_0_and_8_or_1073741824_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_8_or_1073741824(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1073741824 : i32) : i32
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %1, %3 : i8
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_8_xor_1073741824_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_8_xor_1073741824(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1073741824 : i32) : i32
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %1, %3 : i8
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_ne_0_and_8_and_not_1073741824_before := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_8_and_not_1073741824(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-1073741825 : i32) : i32
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %1, %3 : i8
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_and_1_0_or_vector_of_2s_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_vector_of_2s(%arg0: i32, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : vector<2xi32>
    %6 = llvm.select %4, %arg1, %5 : i1, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def select_icmp_and_8_ne_0_xor_8_before := [llvmfunc|
  llvm.func @select_icmp_and_8_ne_0_xor_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    llvm.return %5 : i32
  }]

def select_icmp_and_8_eq_0_xor_8_before := [llvmfunc|
  llvm.func @select_icmp_and_8_eq_0_xor_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

def select_icmp_x_and_8_eq_0_y_xor_8_before := [llvmfunc|
  llvm.func @select_icmp_x_and_8_eq_0_y_xor_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i64
    %6 = llvm.select %4, %arg1, %5 : i1, i64
    llvm.return %6 : i64
  }]

def select_icmp_x_and_8_ne_0_y_xor_8_before := [llvmfunc|
  llvm.func @select_icmp_x_and_8_ne_0_y_xor_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }]

def select_icmp_x_and_8_ne_0_y_or_8_before := [llvmfunc|
  llvm.func @select_icmp_x_and_8_ne_0_y_or_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }]

def select_icmp_x_and_8_ne_0_y_or_8_vec_before := [llvmfunc|
  llvm.func @select_icmp_x_and_8_ne_0_y_or_8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<8> : vector<2xi64>) : vector<2xi64>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi64>
    %7 = llvm.select %5, %6, %arg1 : vector<2xi1>, vector<2xi64>
    llvm.return %7 : vector<2xi64>
  }]

def select_icmp_x_and_8_ne_0_y_and_not_8_before := [llvmfunc|
  llvm.func @select_icmp_x_and_8_ne_0_y_and_not_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i64) : i64
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }]

def select_icmp_and_2147483648_ne_0_xor_2147483648_before := [llvmfunc|
  llvm.func @select_icmp_and_2147483648_ne_0_xor_2147483648(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.select %3, %arg0, %4 : i1, i32
    llvm.return %5 : i32
  }]

def select_icmp_and_2147483648_eq_0_xor_2147483648_before := [llvmfunc|
  llvm.func @select_icmp_and_2147483648_eq_0_xor_2147483648(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg0, %0  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

def select_icmp_x_and_2147483648_ne_0_or_2147483648_before := [llvmfunc|
  llvm.func @select_icmp_x_and_2147483648_ne_0_or_2147483648(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.select %3, %4, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

def test68_before := [llvmfunc|
  llvm.func @test68(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test68vec_before := [llvmfunc|
  llvm.func @test68vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test68_xor_before := [llvmfunc|
  llvm.func @test68_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test68_and_before := [llvmfunc|
  llvm.func @test68_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test69_before := [llvmfunc|
  llvm.func @test69(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test69vec_before := [llvmfunc|
  llvm.func @test69vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    %6 = llvm.or %arg1, %3  : vector<2xi32>
    %7 = llvm.select %5, %arg1, %6 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def test69_xor_before := [llvmfunc|
  llvm.func @test69_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test69_and_before := [llvmfunc|
  llvm.func @test69_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test70_before := [llvmfunc|
  llvm.func @test70(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.select %2, %3, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

def test70_multiuse_before := [llvmfunc|
  llvm.func @test70_multiuse(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.or %arg1, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %2, %3, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

def shift_no_xor_multiuse_or_before := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

def shift_no_xor_multiuse_xor_before := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

def shift_no_xor_multiuse_and_before := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

def no_shift_no_xor_multiuse_or_before := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }]

def no_shift_no_xor_multiuse_xor_before := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }]

def no_shift_no_xor_multiuse_and_before := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.add %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

def no_shift_xor_multiuse_or_before := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }]

def no_shift_xor_multiuse_xor_before := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.mul %5, %4  : i32
    llvm.return %6 : i32
  }]

def no_shift_xor_multiuse_and_before := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

def shift_xor_multiuse_or_before := [llvmfunc|
  llvm.func @shift_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

def shift_xor_multiuse_xor_before := [llvmfunc|
  llvm.func @shift_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

def shift_xor_multiuse_and_before := [llvmfunc|
  llvm.func @shift_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2049 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

def shift_no_xor_multiuse_cmp_before := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

def shift_no_xor_multiuse_cmp_with_xor_before := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

def shift_no_xor_multiuse_cmp_with_and_before := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

def no_shift_no_xor_multiuse_cmp_before := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }]

def no_shift_no_xor_multiuse_cmp_with_xor_before := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }]

def no_shift_no_xor_multiuse_cmp_with_and_before := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

def no_shift_xor_multiuse_cmp_before := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }]

def no_shift_xor_multiuse_cmp_with_xor_before := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }]

def no_shift_xor_multiuse_cmp_with_and_before := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

def shift_xor_multiuse_cmp_before := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

def shift_xor_multiuse_cmp_with_xor_before := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

def shift_xor_multiuse_cmp_with_and_before := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2049 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

def shift_no_xor_multiuse_cmp_or_before := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

def shift_no_xor_multiuse_cmp_xor_before := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

def shift_no_xor_multiuse_cmp_and_before := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

def no_shift_no_xor_multiuse_cmp_or_before := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }]

def no_shift_no_xor_multiuse_cmp_xor_before := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }]

def no_shift_no_xor_multiuse_cmp_and_before := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

def no_shift_xor_multiuse_cmp_or_before := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }]

def no_shift_xor_multiuse_cmp_xor_before := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %arg1, %4 : i1, i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }]

def no_shift_xor_multiuse_cmp_and_before := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

def shift_xor_multiuse_cmp_or_before := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

def shift_xor_multiuse_cmp_xor_before := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

def shift_xor_multiuse_cmp_and_before := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

def set_bits_before := [llvmfunc|
  llvm.func @set_bits(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }]

def set_bits_not_inverse_constant_before := [llvmfunc|
  llvm.func @set_bits_not_inverse_constant(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }]

def set_bits_extra_use1_before := [llvmfunc|
  llvm.func @set_bits_extra_use1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }]

def set_bits_extra_use2_before := [llvmfunc|
  llvm.func @set_bits_extra_use2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }]

def clear_bits_before := [llvmfunc|
  llvm.func @clear_bits(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<37> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-38> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.or %arg0, %1  : vector<2xi8>
    %4 = llvm.select %arg1, %2, %3 : vector<2xi1>, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def clear_bits_not_inverse_constant_before := [llvmfunc|
  llvm.func @clear_bits_not_inverse_constant(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<-38> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.and %arg0, %6  : vector<2xi8>
    %9 = llvm.or %arg0, %7  : vector<2xi8>
    %10 = llvm.select %arg1, %8, %9 : vector<2xi1>, vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

def clear_bits_extra_use1_before := [llvmfunc|
  llvm.func @clear_bits_extra_use1(%arg0: vector<2xi8>, %arg1: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<37> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-38> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    llvm.call @use_vec(%2) : (vector<2xi8>) -> ()
    %3 = llvm.or %arg0, %1  : vector<2xi8>
    %4 = llvm.select %arg1, %2, %3 : i1, vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def clear_bits_extra_use2_before := [llvmfunc|
  llvm.func @clear_bits_extra_use2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    llvm.return %4 : i8
  }]

def xor_i8_to_i64_shl_save_and_eq_before := [llvmfunc|
  llvm.func @xor_i8_to_i64_shl_save_and_eq(%arg0: i8, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.xor %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }]

def xor_i8_to_i64_shl_save_and_ne_before := [llvmfunc|
  llvm.func @xor_i8_to_i64_shl_save_and_ne(%arg0: i8, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    %5 = llvm.xor %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }]

def select_icmp_eq_and_1_0_srem_2_fail_null_identity_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_srem_2_fail_null_identity(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.srem %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sdiv %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def select_icmp_eq_and_1_0_lshr_fv_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_lshr_fv(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.lshr %arg1, %2  : i8
    %6 = llvm.select %4, %arg1, %5 : i1, i8
    llvm.return %6 : i8
  }]

def select_icmp_eq_and_1_0_lshr_tv_before := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_lshr_tv(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    %5 = llvm.lshr %arg1, %2  : i8
    %6 = llvm.select %4, %5, %arg1 : i1, i8
    llvm.return %6 : i8
  }]

def select_icmp_eq_and_1_0_or_2_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.or %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_select_icmp_eq_and_1_0_or_2   : select_icmp_eq_and_1_0_or_2_before  ⊑  select_icmp_eq_and_1_0_or_2_combined := by
  unfold select_icmp_eq_and_1_0_or_2_before select_icmp_eq_and_1_0_or_2_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_or_2_vec_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.or %3, %arg1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_eq_and_1_0_or_2_vec   : select_icmp_eq_and_1_0_or_2_vec_before  ⊑  select_icmp_eq_and_1_0_or_2_vec_combined := by
  unfold select_icmp_eq_and_1_0_or_2_vec_before select_icmp_eq_and_1_0_or_2_vec_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_or_2_vec_poison1_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2_vec_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %9 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %10 = llvm.and %arg0, %6  : vector<2xi32>
    %11 = llvm.icmp "eq" %10, %8 : vector<2xi32>
    %12 = llvm.or %arg1, %9  : vector<2xi32>
    %13 = llvm.select %11, %arg1, %12 : vector<2xi1>, vector<2xi32>
    llvm.return %13 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_eq_and_1_0_or_2_vec_poison1   : select_icmp_eq_and_1_0_or_2_vec_poison1_before  ⊑  select_icmp_eq_and_1_0_or_2_vec_poison1_combined := by
  unfold select_icmp_eq_and_1_0_or_2_vec_poison1_before select_icmp_eq_and_1_0_or_2_vec_poison1_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_or_2_vec_poison2_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2_vec_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.or %3, %arg1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_eq_and_1_0_or_2_vec_poison2   : select_icmp_eq_and_1_0_or_2_vec_poison2_before  ⊑  select_icmp_eq_and_1_0_or_2_vec_poison2_combined := by
  unfold select_icmp_eq_and_1_0_or_2_vec_poison2_before select_icmp_eq_and_1_0_or_2_vec_poison2_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_or_2_vec_poison3_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_2_vec_poison3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.undef : vector<2xi32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<2xi32>
    %10 = llvm.and %arg0, %0  : vector<2xi32>
    %11 = llvm.icmp "eq" %10, %2 : vector<2xi32>
    %12 = llvm.or %arg1, %9  : vector<2xi32>
    %13 = llvm.select %11, %arg1, %12 : vector<2xi1>, vector<2xi32>
    llvm.return %13 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_eq_and_1_0_or_2_vec_poison3   : select_icmp_eq_and_1_0_or_2_vec_poison3_before  ⊑  select_icmp_eq_and_1_0_or_2_vec_poison3_combined := by
  unfold select_icmp_eq_and_1_0_or_2_vec_poison3_before select_icmp_eq_and_1_0_or_2_vec_poison3_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_xor_2_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_xor_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_select_icmp_eq_and_1_0_xor_2   : select_icmp_eq_and_1_0_xor_2_before  ⊑  select_icmp_eq_and_1_0_xor_2_combined := by
  unfold select_icmp_eq_and_1_0_xor_2_before select_icmp_eq_and_1_0_xor_2_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_and_not_2_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_and_not_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_eq_and_1_0_and_not_2   : select_icmp_eq_and_1_0_and_not_2_before  ⊑  select_icmp_eq_and_1_0_and_not_2_combined := by
  unfold select_icmp_eq_and_1_0_and_not_2_before select_icmp_eq_and_1_0_and_not_2_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_32_0_or_8_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_32_0_or_8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.or %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_select_icmp_eq_and_32_0_or_8   : select_icmp_eq_and_32_0_or_8_before  ⊑  select_icmp_eq_and_32_0_or_8_combined := by
  unfold select_icmp_eq_and_32_0_or_8_before select_icmp_eq_and_32_0_or_8_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_32_0_or_8_vec_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_32_0_or_8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.or %3, %arg1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_eq_and_32_0_or_8_vec   : select_icmp_eq_and_32_0_or_8_vec_before  ⊑  select_icmp_eq_and_32_0_or_8_vec_combined := by
  unfold select_icmp_eq_and_32_0_or_8_vec_before select_icmp_eq_and_32_0_or_8_vec_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_32_0_xor_8_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_32_0_xor_8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_select_icmp_eq_and_32_0_xor_8   : select_icmp_eq_and_32_0_xor_8_before  ⊑  select_icmp_eq_and_32_0_xor_8_combined := by
  unfold select_icmp_eq_and_32_0_xor_8_before select_icmp_eq_and_32_0_xor_8_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_32_0_and_not_8_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_32_0_and_not_8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_eq_and_32_0_and_not_8   : select_icmp_eq_and_32_0_and_not_8_before  ⊑  select_icmp_eq_and_32_0_and_not_8_combined := by
  unfold select_icmp_eq_and_32_0_and_not_8_before select_icmp_eq_and_32_0_and_not_8_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_4096_or_4096_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_or_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_4096_or_4096   : select_icmp_ne_0_and_4096_or_4096_before  ⊑  select_icmp_ne_0_and_4096_or_4096_combined := by
  unfold select_icmp_ne_0_and_4096_or_4096_before select_icmp_ne_0_and_4096_or_4096_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_4096_or_4096_vec_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_or_4096_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4096> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    %3 = llvm.or %2, %arg1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_ne_0_and_4096_or_4096_vec   : select_icmp_ne_0_and_4096_or_4096_vec_before  ⊑  select_icmp_ne_0_and_4096_or_4096_vec_combined := by
  unfold select_icmp_ne_0_and_4096_or_4096_vec_before select_icmp_ne_0_and_4096_or_4096_vec_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_4096_xor_4096_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_xor_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.xor %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_4096_xor_4096   : select_icmp_ne_0_and_4096_xor_4096_before  ⊑  select_icmp_ne_0_and_4096_xor_4096_combined := by
  unfold select_icmp_ne_0_and_4096_xor_4096_before select_icmp_ne_0_and_4096_xor_4096_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_4096_and_not_4096_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_and_not_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_4096_and_not_4096   : select_icmp_ne_0_and_4096_and_not_4096_before  ⊑  select_icmp_ne_0_and_4096_and_not_4096_combined := by
  unfold select_icmp_ne_0_and_4096_and_not_4096_before select_icmp_ne_0_and_4096_and_not_4096_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_4096_0_or_4096_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_4096_0_or_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_icmp_eq_and_4096_0_or_4096   : select_icmp_eq_and_4096_0_or_4096_before  ⊑  select_icmp_eq_and_4096_0_or_4096_combined := by
  unfold select_icmp_eq_and_4096_0_or_4096_before select_icmp_eq_and_4096_0_or_4096_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_4096_0_or_4096_vec_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_4096_0_or_4096_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4096> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.or %1, %arg1  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_eq_and_4096_0_or_4096_vec   : select_icmp_eq_and_4096_0_or_4096_vec_before  ⊑  select_icmp_eq_and_4096_0_or_4096_vec_combined := by
  unfold select_icmp_eq_and_4096_0_or_4096_vec_before select_icmp_eq_and_4096_0_or_4096_vec_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_4096_0_xor_4096_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_4096_0_xor_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_select_icmp_eq_and_4096_0_xor_4096   : select_icmp_eq_and_4096_0_xor_4096_before  ⊑  select_icmp_eq_and_4096_0_xor_4096_combined := by
  unfold select_icmp_eq_and_4096_0_xor_4096_before select_icmp_eq_and_4096_0_xor_4096_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_4096_0_and_not_4096_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_4096_0_and_not_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_eq_and_4096_0_and_not_4096   : select_icmp_eq_and_4096_0_and_not_4096_before  ⊑  select_icmp_eq_and_4096_0_and_not_4096_combined := by
  unfold select_icmp_eq_and_4096_0_and_not_4096_before select_icmp_eq_and_4096_0_and_not_4096_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_0_and_1_or_1_combined := [llvmfunc|
  llvm.func @select_icmp_eq_0_and_1_or_1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.or %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_icmp_eq_0_and_1_or_1   : select_icmp_eq_0_and_1_or_1_before  ⊑  select_icmp_eq_0_and_1_or_1_combined := by
  unfold select_icmp_eq_0_and_1_or_1_before select_icmp_eq_0_and_1_or_1_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_0_and_1_or_1_vec_combined := [llvmfunc|
  llvm.func @select_icmp_eq_0_and_1_or_1_vec(%arg0: vector<2xi64>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.or %2, %arg1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_eq_0_and_1_or_1_vec   : select_icmp_eq_0_and_1_or_1_vec_before  ⊑  select_icmp_eq_0_and_1_or_1_vec_combined := by
  unfold select_icmp_eq_0_and_1_or_1_vec_before select_icmp_eq_0_and_1_or_1_vec_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_0_and_1_xor_1_combined := [llvmfunc|
  llvm.func @select_icmp_eq_0_and_1_xor_1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.xor %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select_icmp_eq_0_and_1_xor_1   : select_icmp_eq_0_and_1_xor_1_before  ⊑  select_icmp_eq_0_and_1_xor_1_combined := by
  unfold select_icmp_eq_0_and_1_xor_1_before select_icmp_eq_0_and_1_xor_1_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_0_and_1_and_not_1_combined := [llvmfunc|
  llvm.func @select_icmp_eq_0_and_1_and_not_1(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i64
    %4 = llvm.icmp "eq" %3, %1 : i64
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_eq_0_and_1_and_not_1   : select_icmp_eq_0_and_1_and_not_1_before  ⊑  select_icmp_eq_0_and_1_and_not_1_combined := by
  unfold select_icmp_eq_0_and_1_and_not_1_before select_icmp_eq_0_and_1_and_not_1_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_4096_or_32_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_or_32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %4, %arg1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_4096_or_32   : select_icmp_ne_0_and_4096_or_32_before  ⊑  select_icmp_ne_0_and_4096_or_32_combined := by
  unfold select_icmp_ne_0_and_4096_or_32_before select_icmp_ne_0_and_4096_or_32_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_4096_xor_32_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_xor_32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_4096_xor_32   : select_icmp_ne_0_and_4096_xor_32_before  ⊑  select_icmp_ne_0_and_4096_xor_32_combined := by
  unfold select_icmp_ne_0_and_4096_xor_32_before select_icmp_ne_0_and_4096_xor_32_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_4096_and_not_32_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_4096_and_not_32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-33 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_4096_and_not_32   : select_icmp_ne_0_and_4096_and_not_32_before  ⊑  select_icmp_ne_0_and_4096_and_not_32_combined := by
  unfold select_icmp_ne_0_and_4096_and_not_32_before select_icmp_ne_0_and_4096_and_not_32_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_32_or_4096_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_32_or_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(4096 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %4, %arg1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_32_or_4096   : select_icmp_ne_0_and_32_or_4096_before  ⊑  select_icmp_ne_0_and_32_or_4096_combined := by
  unfold select_icmp_ne_0_and_32_or_4096_before select_icmp_ne_0_and_32_or_4096_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_32_or_4096_vec_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_32_or_4096_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4096> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.or %4, %arg1  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_ne_0_and_32_or_4096_vec   : select_icmp_ne_0_and_32_or_4096_vec_before  ⊑  select_icmp_ne_0_and_32_or_4096_vec_combined := by
  unfold select_icmp_ne_0_and_32_or_4096_vec_before select_icmp_ne_0_and_32_or_4096_vec_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_32_xor_4096_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_32_xor_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(4096 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_32_xor_4096   : select_icmp_ne_0_and_32_xor_4096_before  ⊑  select_icmp_ne_0_and_32_xor_4096_combined := by
  unfold select_icmp_ne_0_and_32_xor_4096_before select_icmp_ne_0_and_32_xor_4096_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_32_and_not_4096_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_32_and_not_4096(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_32_and_not_4096   : select_icmp_ne_0_and_32_and_not_4096_before  ⊑  select_icmp_ne_0_and_32_and_not_4096_combined := by
  unfold select_icmp_ne_0_and_32_and_not_4096_before select_icmp_ne_0_and_32_and_not_4096_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_1073741824_or_8_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_1073741824_or_8(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i8
    %6 = llvm.select %4, %5, %arg1 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_select_icmp_ne_0_and_1073741824_or_8   : select_icmp_ne_0_and_1073741824_or_8_before  ⊑  select_icmp_ne_0_and_1073741824_or_8_combined := by
  unfold select_icmp_ne_0_and_1073741824_or_8_before select_icmp_ne_0_and_1073741824_or_8_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_1073741824_xor_8_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_1073741824_xor_8(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i8
    %6 = llvm.select %4, %5, %arg1 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_select_icmp_ne_0_and_1073741824_xor_8   : select_icmp_ne_0_and_1073741824_xor_8_before  ⊑  select_icmp_ne_0_and_1073741824_xor_8_combined := by
  unfold select_icmp_ne_0_and_1073741824_xor_8_before select_icmp_ne_0_and_1073741824_xor_8_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_1073741824_and_not_8_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_1073741824_and_not_8(%arg0: i32, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i8) : i8
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.select %4, %5, %arg1 : i1, i8
    llvm.return %6 : i8
  }]

theorem inst_combine_select_icmp_ne_0_and_1073741824_and_not_8   : select_icmp_ne_0_and_1073741824_and_not_8_before  ⊑  select_icmp_ne_0_and_1073741824_and_not_8_combined := by
  unfold select_icmp_ne_0_and_1073741824_and_not_8_before select_icmp_ne_0_and_1073741824_and_not_8_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_8_or_1073741824_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_8_or_1073741824(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1073741824 : i32) : i32
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_8_or_1073741824   : select_icmp_ne_0_and_8_or_1073741824_before  ⊑  select_icmp_ne_0_and_8_or_1073741824_combined := by
  unfold select_icmp_ne_0_and_8_or_1073741824_before select_icmp_ne_0_and_8_or_1073741824_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_8_xor_1073741824_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_8_xor_1073741824(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1073741824 : i32) : i32
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_8_xor_1073741824   : select_icmp_ne_0_and_8_xor_1073741824_before  ⊑  select_icmp_ne_0_and_8_xor_1073741824_combined := by
  unfold select_icmp_ne_0_and_8_xor_1073741824_before select_icmp_ne_0_and_8_xor_1073741824_combined
  simp_alive_peephole
  sorry
def select_icmp_ne_0_and_8_and_not_1073741824_combined := [llvmfunc|
  llvm.func @select_icmp_ne_0_and_8_and_not_1073741824(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-1073741825 : i32) : i32
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_ne_0_and_8_and_not_1073741824   : select_icmp_ne_0_and_8_and_not_1073741824_before  ⊑  select_icmp_ne_0_and_8_and_not_1073741824_combined := by
  unfold select_icmp_ne_0_and_8_and_not_1073741824_before select_icmp_ne_0_and_8_and_not_1073741824_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_or_vector_of_2s_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_or_vector_of_2s(%arg0: i32, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : vector<2xi32>
    %6 = llvm.select %4, %arg1, %5 : i1, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_select_icmp_eq_and_1_0_or_vector_of_2s   : select_icmp_eq_and_1_0_or_vector_of_2s_before  ⊑  select_icmp_eq_and_1_0_or_vector_of_2s_combined := by
  unfold select_icmp_eq_and_1_0_or_vector_of_2s_before select_icmp_eq_and_1_0_or_vector_of_2s_combined
  simp_alive_peephole
  sorry
def select_icmp_and_8_ne_0_xor_8_combined := [llvmfunc|
  llvm.func @select_icmp_and_8_ne_0_xor_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-9 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_select_icmp_and_8_ne_0_xor_8   : select_icmp_and_8_ne_0_xor_8_before  ⊑  select_icmp_and_8_ne_0_xor_8_combined := by
  unfold select_icmp_and_8_ne_0_xor_8_before select_icmp_and_8_ne_0_xor_8_combined
  simp_alive_peephole
  sorry
def select_icmp_and_8_eq_0_xor_8_combined := [llvmfunc|
  llvm.func @select_icmp_and_8_eq_0_xor_8(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_select_icmp_and_8_eq_0_xor_8   : select_icmp_and_8_eq_0_xor_8_before  ⊑  select_icmp_and_8_eq_0_xor_8_combined := by
  unfold select_icmp_and_8_eq_0_xor_8_before select_icmp_and_8_eq_0_xor_8_combined
  simp_alive_peephole
  sorry
def select_icmp_x_and_8_eq_0_y_xor_8_combined := [llvmfunc|
  llvm.func @select_icmp_x_and_8_eq_0_y_xor_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.zext %1 : i32 to i64
    %3 = llvm.xor %2, %arg1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_select_icmp_x_and_8_eq_0_y_xor_8   : select_icmp_x_and_8_eq_0_y_xor_8_before  ⊑  select_icmp_x_and_8_eq_0_y_xor_8_combined := by
  unfold select_icmp_x_and_8_eq_0_y_xor_8_before select_icmp_x_and_8_eq_0_y_xor_8_combined
  simp_alive_peephole
  sorry
def select_icmp_x_and_8_ne_0_y_xor_8_combined := [llvmfunc|
  llvm.func @select_icmp_x_and_8_ne_0_y_xor_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.xor %3, %arg1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_select_icmp_x_and_8_ne_0_y_xor_8   : select_icmp_x_and_8_ne_0_y_xor_8_before  ⊑  select_icmp_x_and_8_ne_0_y_xor_8_combined := by
  unfold select_icmp_x_and_8_ne_0_y_xor_8_before select_icmp_x_and_8_ne_0_y_xor_8_combined
  simp_alive_peephole
  sorry
def select_icmp_x_and_8_ne_0_y_or_8_combined := [llvmfunc|
  llvm.func @select_icmp_x_and_8_ne_0_y_or_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.or %3, %arg1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_select_icmp_x_and_8_ne_0_y_or_8   : select_icmp_x_and_8_ne_0_y_or_8_before  ⊑  select_icmp_x_and_8_ne_0_y_or_8_combined := by
  unfold select_icmp_x_and_8_ne_0_y_or_8_before select_icmp_x_and_8_ne_0_y_or_8_combined
  simp_alive_peephole
  sorry
def select_icmp_x_and_8_ne_0_y_or_8_vec_combined := [llvmfunc|
  llvm.func @select_icmp_x_and_8_ne_0_y_or_8_vec(%arg0: vector<2xi32>, %arg1: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    %4 = llvm.or %3, %arg1  : vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }]

theorem inst_combine_select_icmp_x_and_8_ne_0_y_or_8_vec   : select_icmp_x_and_8_ne_0_y_or_8_vec_before  ⊑  select_icmp_x_and_8_ne_0_y_or_8_vec_combined := by
  unfold select_icmp_x_and_8_ne_0_y_or_8_vec_before select_icmp_x_and_8_ne_0_y_or_8_vec_combined
  simp_alive_peephole
  sorry
def select_icmp_x_and_8_ne_0_y_and_not_8_combined := [llvmfunc|
  llvm.func @select_icmp_x_and_8_ne_0_y_and_not_8(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-9 : i64) : i64
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }]

theorem inst_combine_select_icmp_x_and_8_ne_0_y_and_not_8   : select_icmp_x_and_8_ne_0_y_and_not_8_before  ⊑  select_icmp_x_and_8_ne_0_y_and_not_8_combined := by
  unfold select_icmp_x_and_8_ne_0_y_and_not_8_before select_icmp_x_and_8_ne_0_y_and_not_8_combined
  simp_alive_peephole
  sorry
def select_icmp_and_2147483648_ne_0_xor_2147483648_combined := [llvmfunc|
  llvm.func @select_icmp_and_2147483648_ne_0_xor_2147483648(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_select_icmp_and_2147483648_ne_0_xor_2147483648   : select_icmp_and_2147483648_ne_0_xor_2147483648_before  ⊑  select_icmp_and_2147483648_ne_0_xor_2147483648_combined := by
  unfold select_icmp_and_2147483648_ne_0_xor_2147483648_before select_icmp_and_2147483648_ne_0_xor_2147483648_combined
  simp_alive_peephole
  sorry
def select_icmp_and_2147483648_eq_0_xor_2147483648_combined := [llvmfunc|
  llvm.func @select_icmp_and_2147483648_eq_0_xor_2147483648(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_select_icmp_and_2147483648_eq_0_xor_2147483648   : select_icmp_and_2147483648_eq_0_xor_2147483648_before  ⊑  select_icmp_and_2147483648_eq_0_xor_2147483648_combined := by
  unfold select_icmp_and_2147483648_eq_0_xor_2147483648_before select_icmp_and_2147483648_eq_0_xor_2147483648_combined
  simp_alive_peephole
  sorry
def select_icmp_x_and_2147483648_ne_0_or_2147483648_combined := [llvmfunc|
  llvm.func @select_icmp_x_and_2147483648_ne_0_or_2147483648(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_select_icmp_x_and_2147483648_ne_0_or_2147483648   : select_icmp_x_and_2147483648_ne_0_or_2147483648_before  ⊑  select_icmp_x_and_2147483648_ne_0_or_2147483648_combined := by
  unfold select_icmp_x_and_2147483648_ne_0_or_2147483648_before select_icmp_x_and_2147483648_ne_0_or_2147483648_combined
  simp_alive_peephole
  sorry
def test68_combined := [llvmfunc|
  llvm.func @test68(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.or %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test68   : test68_before  ⊑  test68_combined := by
  unfold test68_before test68_combined
  simp_alive_peephole
  sorry
def test68vec_combined := [llvmfunc|
  llvm.func @test68vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.or %3, %arg1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_test68vec   : test68vec_before  ⊑  test68vec_combined := by
  unfold test68vec_before test68vec_combined
  simp_alive_peephole
  sorry
def test68_xor_combined := [llvmfunc|
  llvm.func @test68_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %arg1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test68_xor   : test68_xor_before  ⊑  test68_xor_combined := by
  unfold test68_xor_before test68_xor_combined
  simp_alive_peephole
  sorry
def test68_and_combined := [llvmfunc|
  llvm.func @test68_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test68_and   : test68_and_before  ⊑  test68_and_combined := by
  unfold test68_and_before test68_and_combined
  simp_alive_peephole
  sorry
def test69_combined := [llvmfunc|
  llvm.func @test69(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.or %4, %arg1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test69   : test69_before  ⊑  test69_combined := by
  unfold test69_before test69_combined
  simp_alive_peephole
  sorry
def test69vec_combined := [llvmfunc|
  llvm.func @test69vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.and %2, %1  : vector<2xi32>
    %4 = llvm.xor %3, %1  : vector<2xi32>
    %5 = llvm.or %4, %arg1  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_test69vec   : test69vec_before  ⊑  test69vec_combined := by
  unfold test69vec_before test69vec_combined
  simp_alive_peephole
  sorry
def test69_xor_combined := [llvmfunc|
  llvm.func @test69_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %arg1  : i32
    %5 = llvm.xor %4, %1  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test69_xor   : test69_xor_before  ⊑  test69_xor_combined := by
  unfold test69_xor_before test69_xor_combined
  simp_alive_peephole
  sorry
def test69_and_combined := [llvmfunc|
  llvm.func @test69_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_test69_and   : test69_and_before  ⊑  test69_and_combined := by
  unfold test69_and_before test69_and_combined
  simp_alive_peephole
  sorry
def test70_combined := [llvmfunc|
  llvm.func @test70(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.or %3, %arg1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test70   : test70_before  ⊑  test70_combined := by
  unfold test70_before test70_combined
  simp_alive_peephole
  sorry
def test70_multiuse_combined := [llvmfunc|
  llvm.func @test70_multiuse(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    %3 = llvm.or %arg1, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %2, %3, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_test70_multiuse   : test70_multiuse_before  ⊑  test70_multiuse_combined := by
  unfold test70_multiuse_before test70_multiuse_combined
  simp_alive_peephole
  sorry
def shift_no_xor_multiuse_or_combined := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = llvm.shl %arg0, %1  : i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.mul %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_shift_no_xor_multiuse_or   : shift_no_xor_multiuse_or_before  ⊑  shift_no_xor_multiuse_or_combined := by
  unfold shift_no_xor_multiuse_or_before shift_no_xor_multiuse_or_combined
  simp_alive_peephole
  sorry
def shift_no_xor_multiuse_xor_combined := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.shl %arg0, %1  : i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.xor %4, %arg1  : i32
    %6 = llvm.mul %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_shift_no_xor_multiuse_xor   : shift_no_xor_multiuse_xor_before  ⊑  shift_no_xor_multiuse_xor_combined := by
  unfold shift_no_xor_multiuse_xor_before shift_no_xor_multiuse_xor_combined
  simp_alive_peephole
  sorry
def shift_no_xor_multiuse_and_combined := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_shift_no_xor_multiuse_and   : shift_no_xor_multiuse_and_before  ⊑  shift_no_xor_multiuse_and_combined := by
  unfold shift_no_xor_multiuse_and_before shift_no_xor_multiuse_and_combined
  simp_alive_peephole
  sorry
def no_shift_no_xor_multiuse_or_combined := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = llvm.or %1, %arg1  : i32
    %4 = llvm.mul %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_no_shift_no_xor_multiuse_or   : no_shift_no_xor_multiuse_or_before  ⊑  no_shift_no_xor_multiuse_or_combined := by
  unfold no_shift_no_xor_multiuse_or_before no_shift_no_xor_multiuse_or_combined
  simp_alive_peephole
  sorry
def no_shift_no_xor_multiuse_xor_combined := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.xor %1, %arg1  : i32
    %4 = llvm.mul %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_no_shift_no_xor_multiuse_xor   : no_shift_no_xor_multiuse_xor_before  ⊑  no_shift_no_xor_multiuse_xor_combined := by
  unfold no_shift_no_xor_multiuse_xor_before no_shift_no_xor_multiuse_xor_combined
  simp_alive_peephole
  sorry
def no_shift_no_xor_multiuse_and_combined := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.add %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_no_shift_no_xor_multiuse_and   : no_shift_no_xor_multiuse_and_before  ⊑  no_shift_no_xor_multiuse_and_combined := by
  unfold no_shift_no_xor_multiuse_and_before no_shift_no_xor_multiuse_and_combined
  simp_alive_peephole
  sorry
def no_shift_xor_multiuse_or_combined := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %arg1, %0  : i32
    %3 = llvm.xor %1, %0  : i32
    %4 = llvm.or %3, %arg1  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_no_shift_xor_multiuse_or   : no_shift_xor_multiuse_or_before  ⊑  no_shift_xor_multiuse_or_combined := by
  unfold no_shift_xor_multiuse_or_before no_shift_xor_multiuse_or_combined
  simp_alive_peephole
  sorry
def no_shift_xor_multiuse_xor_combined := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.xor %1, %arg1  : i32
    %4 = llvm.xor %3, %0  : i32
    %5 = llvm.mul %4, %2  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_no_shift_xor_multiuse_xor   : no_shift_xor_multiuse_xor_before  ⊑  no_shift_xor_multiuse_xor_combined := by
  unfold no_shift_xor_multiuse_xor_before no_shift_xor_multiuse_xor_combined
  simp_alive_peephole
  sorry
def no_shift_xor_multiuse_and_combined := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_no_shift_xor_multiuse_and   : no_shift_xor_multiuse_and_before  ⊑  no_shift_xor_multiuse_and_combined := by
  unfold no_shift_xor_multiuse_and_before no_shift_xor_multiuse_and_combined
  simp_alive_peephole
  sorry
def shift_xor_multiuse_or_combined := [llvmfunc|
  llvm.func @shift_xor_multiuse_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_shift_xor_multiuse_or   : shift_xor_multiuse_or_before  ⊑  shift_xor_multiuse_or_combined := by
  unfold shift_xor_multiuse_or_before shift_xor_multiuse_or_combined
  simp_alive_peephole
  sorry
def shift_xor_multiuse_xor_combined := [llvmfunc|
  llvm.func @shift_xor_multiuse_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_shift_xor_multiuse_xor   : shift_xor_multiuse_xor_before  ⊑  shift_xor_multiuse_xor_combined := by
  unfold shift_xor_multiuse_xor_before shift_xor_multiuse_xor_combined
  simp_alive_peephole
  sorry
def shift_xor_multiuse_and_combined := [llvmfunc|
  llvm.func @shift_xor_multiuse_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2049 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.mul %6, %5  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_shift_xor_multiuse_and   : shift_xor_multiuse_and_before  ⊑  shift_xor_multiuse_and_combined := by
  unfold shift_xor_multiuse_and_before shift_xor_multiuse_and_combined
  simp_alive_peephole
  sorry
def shift_no_xor_multiuse_cmp_combined := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.shl %2, %0 overflow<nsw, nuw>  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_shift_no_xor_multiuse_cmp   : shift_no_xor_multiuse_cmp_before  ⊑  shift_no_xor_multiuse_cmp_combined := by
  unfold shift_no_xor_multiuse_cmp_before shift_no_xor_multiuse_cmp_combined
  simp_alive_peephole
  sorry
def shift_no_xor_multiuse_cmp_with_xor_combined := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.shl %2, %0 overflow<nsw, nuw>  : i32
    %5 = llvm.xor %4, %arg1  : i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_shift_no_xor_multiuse_cmp_with_xor   : shift_no_xor_multiuse_cmp_with_xor_before  ⊑  shift_no_xor_multiuse_cmp_with_xor_combined := by
  unfold shift_no_xor_multiuse_cmp_with_xor_before shift_no_xor_multiuse_cmp_with_xor_combined
  simp_alive_peephole
  sorry
def shift_no_xor_multiuse_cmp_with_and_combined := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_shift_no_xor_multiuse_cmp_with_and   : shift_no_xor_multiuse_cmp_with_and_before  ⊑  shift_no_xor_multiuse_cmp_with_and_combined := by
  unfold shift_no_xor_multiuse_cmp_with_and_before shift_no_xor_multiuse_cmp_with_and_combined
  simp_alive_peephole
  sorry
def no_shift_no_xor_multiuse_cmp_combined := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %2, %arg1  : i32
    %5 = llvm.select %3, %arg2, %arg3 : i1, i32
    %6 = llvm.mul %4, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_no_shift_no_xor_multiuse_cmp   : no_shift_no_xor_multiuse_cmp_before  ⊑  no_shift_no_xor_multiuse_cmp_combined := by
  unfold no_shift_no_xor_multiuse_cmp_before no_shift_no_xor_multiuse_cmp_combined
  simp_alive_peephole
  sorry
def no_shift_no_xor_multiuse_cmp_with_xor_combined := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %2, %arg1  : i32
    %5 = llvm.select %3, %arg2, %arg3 : i1, i32
    %6 = llvm.mul %4, %5  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_no_shift_no_xor_multiuse_cmp_with_xor   : no_shift_no_xor_multiuse_cmp_with_xor_before  ⊑  no_shift_no_xor_multiuse_cmp_with_xor_combined := by
  unfold no_shift_no_xor_multiuse_cmp_with_xor_before no_shift_no_xor_multiuse_cmp_with_xor_combined
  simp_alive_peephole
  sorry
def no_shift_no_xor_multiuse_cmp_with_and_combined := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_no_shift_no_xor_multiuse_cmp_with_and   : no_shift_no_xor_multiuse_cmp_with_and_before  ⊑  no_shift_no_xor_multiuse_cmp_with_and_combined := by
  unfold no_shift_no_xor_multiuse_cmp_with_and_before no_shift_no_xor_multiuse_cmp_with_and_combined
  simp_alive_peephole
  sorry
def no_shift_xor_multiuse_cmp_combined := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %2, %0  : i32
    %5 = llvm.or %4, %arg1  : i32
    %6 = llvm.select %3, %arg3, %arg2 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_no_shift_xor_multiuse_cmp   : no_shift_xor_multiuse_cmp_before  ⊑  no_shift_xor_multiuse_cmp_combined := by
  unfold no_shift_xor_multiuse_cmp_before no_shift_xor_multiuse_cmp_combined
  simp_alive_peephole
  sorry
def no_shift_xor_multiuse_cmp_with_xor_combined := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %2, %arg1  : i32
    %5 = llvm.xor %4, %0  : i32
    %6 = llvm.select %3, %arg3, %arg2 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    llvm.return %7 : i32
  }]

theorem inst_combine_no_shift_xor_multiuse_cmp_with_xor   : no_shift_xor_multiuse_cmp_with_xor_before  ⊑  no_shift_xor_multiuse_cmp_with_xor_combined := by
  unfold no_shift_xor_multiuse_cmp_with_xor_before no_shift_xor_multiuse_cmp_with_xor_combined
  simp_alive_peephole
  sorry
def no_shift_xor_multiuse_cmp_with_and_combined := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.select %4, %arg3, %arg2 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_no_shift_xor_multiuse_cmp_with_and   : no_shift_xor_multiuse_cmp_with_and_before  ⊑  no_shift_xor_multiuse_cmp_with_and_combined := by
  unfold no_shift_xor_multiuse_cmp_with_and_before no_shift_xor_multiuse_cmp_with_and_combined
  simp_alive_peephole
  sorry
def shift_xor_multiuse_cmp_combined := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.select %4, %arg3, %arg2 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_shift_xor_multiuse_cmp   : shift_xor_multiuse_cmp_before  ⊑  shift_xor_multiuse_cmp_combined := by
  unfold shift_xor_multiuse_cmp_before shift_xor_multiuse_cmp_combined
  simp_alive_peephole
  sorry
def shift_xor_multiuse_cmp_with_xor_combined := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_with_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.select %4, %arg3, %arg2 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_shift_xor_multiuse_cmp_with_xor   : shift_xor_multiuse_cmp_with_xor_before  ⊑  shift_xor_multiuse_cmp_with_xor_combined := by
  unfold shift_xor_multiuse_cmp_with_xor_before shift_xor_multiuse_cmp_with_xor_combined
  simp_alive_peephole
  sorry
def shift_xor_multiuse_cmp_with_and_combined := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_with_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-2049 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.select %4, %arg3, %arg2 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_shift_xor_multiuse_cmp_with_and   : shift_xor_multiuse_cmp_with_and_before  ⊑  shift_xor_multiuse_cmp_with_and_combined := by
  unfold shift_xor_multiuse_cmp_with_and_before shift_xor_multiuse_cmp_with_and_combined
  simp_alive_peephole
  sorry
def shift_no_xor_multiuse_cmp_or_combined := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_shift_no_xor_multiuse_cmp_or   : shift_no_xor_multiuse_cmp_or_before  ⊑  shift_no_xor_multiuse_cmp_or_combined := by
  unfold shift_no_xor_multiuse_cmp_or_before shift_no_xor_multiuse_cmp_or_combined
  simp_alive_peephole
  sorry
def shift_no_xor_multiuse_cmp_xor_combined := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_shift_no_xor_multiuse_cmp_xor   : shift_no_xor_multiuse_cmp_xor_before  ⊑  shift_no_xor_multiuse_cmp_xor_combined := by
  unfold shift_no_xor_multiuse_cmp_xor_before shift_no_xor_multiuse_cmp_xor_combined
  simp_alive_peephole
  sorry
def shift_no_xor_multiuse_cmp_and_combined := [llvmfunc|
  llvm.func @shift_no_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_shift_no_xor_multiuse_cmp_and   : shift_no_xor_multiuse_cmp_and_before  ⊑  shift_no_xor_multiuse_cmp_and_combined := by
  unfold shift_no_xor_multiuse_cmp_and_before shift_no_xor_multiuse_cmp_and_combined
  simp_alive_peephole
  sorry
def no_shift_no_xor_multiuse_cmp_or_combined := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.or %2, %arg1  : i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_no_shift_no_xor_multiuse_cmp_or   : no_shift_no_xor_multiuse_cmp_or_before  ⊑  no_shift_no_xor_multiuse_cmp_or_combined := by
  unfold no_shift_no_xor_multiuse_cmp_or_before no_shift_no_xor_multiuse_cmp_or_combined
  simp_alive_peephole
  sorry
def no_shift_no_xor_multiuse_cmp_xor_combined := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.xor %2, %arg1  : i32
    %6 = llvm.select %3, %arg2, %arg3 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_no_shift_no_xor_multiuse_cmp_xor   : no_shift_no_xor_multiuse_cmp_xor_before  ⊑  no_shift_no_xor_multiuse_cmp_xor_combined := by
  unfold no_shift_no_xor_multiuse_cmp_xor_before no_shift_no_xor_multiuse_cmp_xor_combined
  simp_alive_peephole
  sorry
def no_shift_no_xor_multiuse_cmp_and_combined := [llvmfunc|
  llvm.func @no_shift_no_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    %7 = llvm.select %4, %arg2, %arg3 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_no_shift_no_xor_multiuse_cmp_and   : no_shift_no_xor_multiuse_cmp_and_before  ⊑  no_shift_no_xor_multiuse_cmp_and_combined := by
  unfold no_shift_no_xor_multiuse_cmp_and_before no_shift_no_xor_multiuse_cmp_and_combined
  simp_alive_peephole
  sorry
def no_shift_xor_multiuse_cmp_or_combined := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.or %arg1, %0  : i32
    %5 = llvm.select %3, %4, %arg1 : i1, i32
    %6 = llvm.select %3, %arg3, %arg2 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_no_shift_xor_multiuse_cmp_or   : no_shift_xor_multiuse_cmp_or_before  ⊑  no_shift_xor_multiuse_cmp_or_combined := by
  unfold no_shift_xor_multiuse_cmp_or_before no_shift_xor_multiuse_cmp_or_combined
  simp_alive_peephole
  sorry
def no_shift_xor_multiuse_cmp_xor_combined := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.xor %arg1, %0  : i32
    %5 = llvm.select %3, %4, %arg1 : i1, i32
    %6 = llvm.select %3, %arg3, %arg2 : i1, i32
    %7 = llvm.mul %5, %6  : i32
    %8 = llvm.mul %7, %4  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_no_shift_xor_multiuse_cmp_xor   : no_shift_xor_multiuse_cmp_xor_before  ⊑  no_shift_xor_multiuse_cmp_xor_combined := by
  unfold no_shift_xor_multiuse_cmp_xor_before no_shift_xor_multiuse_cmp_xor_combined
  simp_alive_peephole
  sorry
def no_shift_xor_multiuse_cmp_and_combined := [llvmfunc|
  llvm.func @no_shift_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4097 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.select %4, %arg3, %arg2 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_no_shift_xor_multiuse_cmp_and   : no_shift_xor_multiuse_cmp_and_before  ⊑  no_shift_xor_multiuse_cmp_and_combined := by
  unfold no_shift_xor_multiuse_cmp_and_before no_shift_xor_multiuse_cmp_and_combined
  simp_alive_peephole
  sorry
def shift_xor_multiuse_cmp_or_combined := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_or(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.or %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.select %4, %arg3, %arg2 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_shift_xor_multiuse_cmp_or   : shift_xor_multiuse_cmp_or_before  ⊑  shift_xor_multiuse_cmp_or_combined := by
  unfold shift_xor_multiuse_cmp_or_before shift_xor_multiuse_cmp_or_combined
  simp_alive_peephole
  sorry
def shift_xor_multiuse_cmp_xor_combined := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_xor(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.xor %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.select %4, %arg3, %arg2 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_shift_xor_multiuse_cmp_xor   : shift_xor_multiuse_cmp_xor_before  ⊑  shift_xor_multiuse_cmp_xor_combined := by
  unfold shift_xor_multiuse_cmp_xor_before shift_xor_multiuse_cmp_xor_combined
  simp_alive_peephole
  sorry
def shift_xor_multiuse_cmp_and_combined := [llvmfunc|
  llvm.func @shift_xor_multiuse_cmp_and(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2048 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.and %arg1, %2  : i32
    %6 = llvm.select %4, %5, %arg1 : i1, i32
    %7 = llvm.select %4, %arg3, %arg2 : i1, i32
    %8 = llvm.mul %6, %7  : i32
    %9 = llvm.mul %8, %5  : i32
    llvm.return %9 : i32
  }]

theorem inst_combine_shift_xor_multiuse_cmp_and   : shift_xor_multiuse_cmp_and_before  ⊑  shift_xor_multiuse_cmp_and_combined := by
  unfold shift_xor_multiuse_cmp_and_before shift_xor_multiuse_cmp_and_combined
  simp_alive_peephole
  sorry
def set_bits_combined := [llvmfunc|
  llvm.func @set_bits(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.select %arg1, %1, %2 : i1, i8
    %5 = llvm.or %3, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_set_bits   : set_bits_before  ⊑  set_bits_combined := by
  unfold set_bits_before set_bits_combined
  simp_alive_peephole
  sorry
def set_bits_not_inverse_constant_combined := [llvmfunc|
  llvm.func @set_bits_not_inverse_constant(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_set_bits_not_inverse_constant   : set_bits_not_inverse_constant_before  ⊑  set_bits_not_inverse_constant_combined := by
  unfold set_bits_not_inverse_constant_before set_bits_not_inverse_constant_combined
  simp_alive_peephole
  sorry
def set_bits_extra_use1_combined := [llvmfunc|
  llvm.func @set_bits_extra_use1(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %1, %2 : i1, i8
    %5 = llvm.or %3, %4  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_set_bits_extra_use1   : set_bits_extra_use1_before  ⊑  set_bits_extra_use1_combined := by
  unfold set_bits_extra_use1_before set_bits_extra_use1_combined
  simp_alive_peephole
  sorry
def set_bits_extra_use2_combined := [llvmfunc|
  llvm.func @set_bits_extra_use2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %3, %2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_set_bits_extra_use2   : set_bits_extra_use2_before  ⊑  set_bits_extra_use2_combined := by
  unfold set_bits_extra_use2_before set_bits_extra_use2_combined
  simp_alive_peephole
  sorry
def clear_bits_combined := [llvmfunc|
  llvm.func @clear_bits(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<37> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-38> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.and %arg0, %0  : vector<2xi8>
    %5 = llvm.select %arg1, %2, %3 : vector<2xi1>, vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_clear_bits   : clear_bits_before  ⊑  clear_bits_combined := by
  unfold clear_bits_before clear_bits_combined
  simp_alive_peephole
  sorry
def clear_bits_not_inverse_constant_combined := [llvmfunc|
  llvm.func @clear_bits_not_inverse_constant(%arg0: vector<2xi8>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<-38> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.and %arg0, %6  : vector<2xi8>
    %9 = llvm.or %arg0, %7  : vector<2xi8>
    %10 = llvm.select %arg1, %8, %9 : vector<2xi1>, vector<2xi8>
    llvm.return %10 : vector<2xi8>
  }]

theorem inst_combine_clear_bits_not_inverse_constant   : clear_bits_not_inverse_constant_before  ⊑  clear_bits_not_inverse_constant_combined := by
  unfold clear_bits_not_inverse_constant_before clear_bits_not_inverse_constant_combined
  simp_alive_peephole
  sorry
def clear_bits_extra_use1_combined := [llvmfunc|
  llvm.func @clear_bits_extra_use1(%arg0: vector<2xi8>, %arg1: i1) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<37> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-38> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.and %arg0, %0  : vector<2xi8>
    llvm.call @use_vec(%4) : (vector<2xi8>) -> ()
    %5 = llvm.select %arg1, %2, %3 : i1, vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_clear_bits_extra_use1   : clear_bits_extra_use1_before  ⊑  clear_bits_extra_use1_combined := by
  unfold clear_bits_extra_use1_before clear_bits_extra_use1_combined
  simp_alive_peephole
  sorry
def clear_bits_extra_use2_combined := [llvmfunc|
  llvm.func @clear_bits_extra_use2(%arg0: i8, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_clear_bits_extra_use2   : clear_bits_extra_use2_before  ⊑  clear_bits_extra_use2_combined := by
  unfold clear_bits_extra_use2_before clear_bits_extra_use2_combined
  simp_alive_peephole
  sorry
def xor_i8_to_i64_shl_save_and_eq_combined := [llvmfunc|
  llvm.func @xor_i8_to_i64_shl_save_and_eq(%arg0: i8, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-9223372036854775808 : i64) : i64
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.xor %arg1, %2  : i64
    %6 = llvm.select %4, %5, %arg1 : i1, i64
    llvm.return %6 : i64
  }]

theorem inst_combine_xor_i8_to_i64_shl_save_and_eq   : xor_i8_to_i64_shl_save_and_eq_before  ⊑  xor_i8_to_i64_shl_save_and_eq_combined := by
  unfold xor_i8_to_i64_shl_save_and_eq_before xor_i8_to_i64_shl_save_and_eq_combined
  simp_alive_peephole
  sorry
def xor_i8_to_i64_shl_save_and_ne_combined := [llvmfunc|
  llvm.func @xor_i8_to_i64_shl_save_and_ne(%arg0: i8, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.zext %arg0 : i8 to i64
    %2 = llvm.shl %1, %0  : i64
    %3 = llvm.xor %2, %arg1  : i64
    llvm.return %3 : i64
  }]

theorem inst_combine_xor_i8_to_i64_shl_save_and_ne   : xor_i8_to_i64_shl_save_and_ne_before  ⊑  xor_i8_to_i64_shl_save_and_ne_combined := by
  unfold xor_i8_to_i64_shl_save_and_ne_before xor_i8_to_i64_shl_save_and_ne_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_srem_2_fail_null_identity_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_srem_2_fail_null_identity(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.srem %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_eq_and_1_0_srem_2_fail_null_identity   : select_icmp_eq_and_1_0_srem_2_fail_null_identity_before  ⊑  select_icmp_eq_and_1_0_srem_2_fail_null_identity_combined := by
  unfold select_icmp_eq_and_1_0_srem_2_fail_null_identity_before select_icmp_eq_and_1_0_srem_2_fail_null_identity_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sdiv %arg1, %2  : i32
    %6 = llvm.select %4, %arg1, %5 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity   : select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity_before  ⊑  select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity_combined := by
  unfold select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity_before select_icmp_eq_and_1_0_sdiv_2_fail_null_1_identity_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_lshr_fv_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_lshr_fv(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.lshr %arg1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_select_icmp_eq_and_1_0_lshr_fv   : select_icmp_eq_and_1_0_lshr_fv_before  ⊑  select_icmp_eq_and_1_0_lshr_fv_combined := by
  unfold select_icmp_eq_and_1_0_lshr_fv_before select_icmp_eq_and_1_0_lshr_fv_combined
  simp_alive_peephole
  sorry
def select_icmp_eq_and_1_0_lshr_tv_combined := [llvmfunc|
  llvm.func @select_icmp_eq_and_1_0_lshr_tv(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.lshr %arg1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_select_icmp_eq_and_1_0_lshr_tv   : select_icmp_eq_and_1_0_lshr_tv_before  ⊑  select_icmp_eq_and_1_0_lshr_tv_combined := by
  unfold select_icmp_eq_and_1_0_lshr_tv_before select_icmp_eq_and_1_0_lshr_tv_combined
  simp_alive_peephole
  sorry
