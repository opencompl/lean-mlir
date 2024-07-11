import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-and-shift
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_eq_and_pow2_shl1_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_shl1_vec_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_ne_and_pow2_shl1_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_ne_and_pow2_shl1_vec_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_eq_and_pow2_shl_pow2_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_shl_pow2_vec_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_ne_and_pow2_shl_pow2_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_ne_and_pow2_shl_pow2_vec_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_eq_and_pow2_shl_pow2_negative1_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2_negative1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_shl_pow2_negative2_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2_negative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(14 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_shl_pow2_negative3_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2_negative3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_minus1_shl1_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_minus1_shl1_vec_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_ne_and_pow2_minus1_shl1_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_minus1_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_ne_and_pow2_minus1_shl1_vec_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_minus1_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_eq_and_pow2_minus1_shl_pow2_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_minus1_shl_pow2_vec_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_ne_and_pow2_minus1_shl_pow2_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_minus1_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_ne_and_pow2_minus1_shl_pow2_vec_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_minus1_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.shl %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_eq_and_pow2_minus1_shl1_negative1_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl1_negative1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_minus1_shl1_negative2_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl1_negative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and1_lshr_pow2_before := [llvmfunc|
  llvm.func @icmp_eq_and1_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and1_lshr_pow2_vec_before := [llvmfunc|
  llvm.func @icmp_eq_and1_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_ne_and1_lshr_pow2_before := [llvmfunc|
  llvm.func @icmp_ne_and1_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_ne_and1_lshr_pow2_vec_before := [llvmfunc|
  llvm.func @icmp_ne_and1_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_eq_and_pow2_lshr_pow2_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_lshr_pow2_case2_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_lshr_pow2_case2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and_pow2_lshr_pow2_vec_before := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_ne_and_pow2_lshr_pow2_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_ne_and_pow2_lshr_pow2_case2_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_lshr_pow2_case2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_ne_and_pow2_lshr_pow2_vec_before := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %0, %arg0  : vector<2xi32>
    %5 = llvm.and %4, %1  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi1> to vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def icmp_eq_and1_lshr_pow2_negative1_before := [llvmfunc|
  llvm.func @icmp_eq_and1_lshr_pow2_negative1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def icmp_eq_and1_lshr_pow2_negative2_before := [llvmfunc|
  llvm.func @icmp_eq_and1_lshr_pow2_negative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

def eq_and_shl_one_before := [llvmfunc|
  llvm.func @eq_and_shl_one(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ne_and_shl_one_commute_before := [llvmfunc|
  llvm.func @ne_and_shl_one_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.shl %6, %arg1  : vector<2xi8>
    %8 = llvm.and %7, %arg0  : vector<2xi8>
    %9 = llvm.icmp "ne" %7, %8 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

def ne_and_lshr_minval_before := [llvmfunc|
  llvm.func @ne_and_lshr_minval(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.and %1, %2  : i8
    %4 = llvm.icmp "ne" %3, %2 : i8
    llvm.return %4 : i1
  }]

def eq_and_lshr_minval_commute_before := [llvmfunc|
  llvm.func @eq_and_lshr_minval_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mul %arg0, %arg0  : i8
    %2 = llvm.lshr %0, %arg1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %1, %2  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }]

def eq_and_shl_two_before := [llvmfunc|
  llvm.func @eq_and_shl_two(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def slt_and_shl_one_before := [llvmfunc|
  llvm.func @slt_and_shl_one(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def fold_eq_lhs_before := [llvmfunc|
  llvm.func @fold_eq_lhs(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def fold_eq_lhs_fail_eq_nonzero_before := [llvmfunc|
  llvm.func @fold_eq_lhs_fail_eq_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def fold_eq_lhs_fail_multiuse_shl_before := [llvmfunc|
  llvm.func @fold_eq_lhs_fail_multiuse_shl(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def fold_ne_rhs_before := [llvmfunc|
  llvm.func @fold_ne_rhs(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg1, %0  : i8
    %4 = llvm.shl %1, %arg0  : i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

def fold_ne_rhs_fail_multiuse_and_before := [llvmfunc|
  llvm.func @fold_ne_rhs_fail_multiuse_and(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg1, %0  : i8
    %4 = llvm.shl %1, %arg0  : i8
    %5 = llvm.and %3, %4  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

def fold_ne_rhs_fail_shift_not_1s_before := [llvmfunc|
  llvm.func @fold_ne_rhs_fail_shift_not_1s(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg1, %0  : i8
    %4 = llvm.shl %1, %arg0  : i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

def icmp_eq_and_pow2_shl1_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_shl1   : icmp_eq_and_pow2_shl1_before  ⊑  icmp_eq_and_pow2_shl1_combined := by
  unfold icmp_eq_and_pow2_shl1_before icmp_eq_and_pow2_shl1_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_shl1_vec_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_eq_and_pow2_shl1_vec   : icmp_eq_and_pow2_shl1_vec_before  ⊑  icmp_eq_and_pow2_shl1_vec_combined := by
  unfold icmp_eq_and_pow2_shl1_vec_before icmp_eq_and_pow2_shl1_vec_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_shl1_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_ne_and_pow2_shl1   : icmp_ne_and_pow2_shl1_before  ⊑  icmp_ne_and_pow2_shl1_combined := by
  unfold icmp_ne_and_pow2_shl1_before icmp_ne_and_pow2_shl1_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_shl1_vec_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_ne_and_pow2_shl1_vec   : icmp_ne_and_pow2_shl1_vec_before  ⊑  icmp_ne_and_pow2_shl1_vec_combined := by
  unfold icmp_ne_and_pow2_shl1_vec_before icmp_ne_and_pow2_shl1_vec_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_shl_pow2_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_shl_pow2   : icmp_eq_and_pow2_shl_pow2_before  ⊑  icmp_eq_and_pow2_shl_pow2_combined := by
  unfold icmp_eq_and_pow2_shl_pow2_before icmp_eq_and_pow2_shl_pow2_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_shl_pow2_vec_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_eq_and_pow2_shl_pow2_vec   : icmp_eq_and_pow2_shl_pow2_vec_before  ⊑  icmp_eq_and_pow2_shl_pow2_vec_combined := by
  unfold icmp_eq_and_pow2_shl_pow2_vec_before icmp_eq_and_pow2_shl_pow2_vec_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_shl_pow2_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_ne_and_pow2_shl_pow2   : icmp_ne_and_pow2_shl_pow2_before  ⊑  icmp_ne_and_pow2_shl_pow2_combined := by
  unfold icmp_ne_and_pow2_shl_pow2_before icmp_ne_and_pow2_shl_pow2_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_shl_pow2_vec_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_ne_and_pow2_shl_pow2_vec   : icmp_ne_and_pow2_shl_pow2_vec_before  ⊑  icmp_ne_and_pow2_shl_pow2_vec_combined := by
  unfold icmp_ne_and_pow2_shl_pow2_vec_before icmp_ne_and_pow2_shl_pow2_vec_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_shl_pow2_negative1_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2_negative1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(11 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.and %4, %2  : i32
    %6 = llvm.xor %5, %2  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_shl_pow2_negative1   : icmp_eq_and_pow2_shl_pow2_negative1_before  ⊑  icmp_eq_and_pow2_shl_pow2_negative1_combined := by
  unfold icmp_eq_and_pow2_shl_pow2_negative1_before icmp_eq_and_pow2_shl_pow2_negative1_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_shl_pow2_negative2_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2_negative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_shl_pow2_negative2   : icmp_eq_and_pow2_shl_pow2_negative2_before  ⊑  icmp_eq_and_pow2_shl_pow2_negative2_combined := by
  unfold icmp_eq_and_pow2_shl_pow2_negative2_before icmp_eq_and_pow2_shl_pow2_negative2_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_shl_pow2_negative3_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_shl_pow2_negative3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_shl_pow2_negative3   : icmp_eq_and_pow2_shl_pow2_negative3_before  ⊑  icmp_eq_and_pow2_shl_pow2_negative3_combined := by
  unfold icmp_eq_and_pow2_shl_pow2_negative3_before icmp_eq_and_pow2_shl_pow2_negative3_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_minus1_shl1_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_minus1_shl1   : icmp_eq_and_pow2_minus1_shl1_before  ⊑  icmp_eq_and_pow2_minus1_shl1_combined := by
  unfold icmp_eq_and_pow2_minus1_shl1_before icmp_eq_and_pow2_minus1_shl1_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_minus1_shl1_vec_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_eq_and_pow2_minus1_shl1_vec   : icmp_eq_and_pow2_minus1_shl1_vec_before  ⊑  icmp_eq_and_pow2_minus1_shl1_vec_combined := by
  unfold icmp_eq_and_pow2_minus1_shl1_vec_before icmp_eq_and_pow2_minus1_shl1_vec_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_minus1_shl1_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_minus1_shl1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_ne_and_pow2_minus1_shl1   : icmp_ne_and_pow2_minus1_shl1_before  ⊑  icmp_ne_and_pow2_minus1_shl1_combined := by
  unfold icmp_ne_and_pow2_minus1_shl1_before icmp_ne_and_pow2_minus1_shl1_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_minus1_shl1_vec_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_minus1_shl1_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_ne_and_pow2_minus1_shl1_vec   : icmp_ne_and_pow2_minus1_shl1_vec_before  ⊑  icmp_ne_and_pow2_minus1_shl1_vec_combined := by
  unfold icmp_ne_and_pow2_minus1_shl1_vec_before icmp_ne_and_pow2_minus1_shl1_vec_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_minus1_shl_pow2_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_minus1_shl_pow2   : icmp_eq_and_pow2_minus1_shl_pow2_before  ⊑  icmp_eq_and_pow2_minus1_shl_pow2_combined := by
  unfold icmp_eq_and_pow2_minus1_shl_pow2_before icmp_eq_and_pow2_minus1_shl_pow2_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_minus1_shl_pow2_vec_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_eq_and_pow2_minus1_shl_pow2_vec   : icmp_eq_and_pow2_minus1_shl_pow2_vec_before  ⊑  icmp_eq_and_pow2_minus1_shl_pow2_vec_combined := by
  unfold icmp_eq_and_pow2_minus1_shl_pow2_vec_before icmp_eq_and_pow2_minus1_shl_pow2_vec_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_minus1_shl_pow2_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_minus1_shl_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_ne_and_pow2_minus1_shl_pow2   : icmp_ne_and_pow2_minus1_shl_pow2_before  ⊑  icmp_ne_and_pow2_minus1_shl_pow2_combined := by
  unfold icmp_ne_and_pow2_minus1_shl_pow2_before icmp_ne_and_pow2_minus1_shl_pow2_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_minus1_shl_pow2_vec_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_minus1_shl_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_ne_and_pow2_minus1_shl_pow2_vec   : icmp_ne_and_pow2_minus1_shl_pow2_vec_before  ⊑  icmp_ne_and_pow2_minus1_shl_pow2_vec_combined := by
  unfold icmp_ne_and_pow2_minus1_shl_pow2_vec_before icmp_ne_and_pow2_minus1_shl_pow2_vec_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_minus1_shl1_negative1_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl1_negative1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.shl %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_minus1_shl1_negative1   : icmp_eq_and_pow2_minus1_shl1_negative1_before  ⊑  icmp_eq_and_pow2_minus1_shl1_negative1_combined := by
  unfold icmp_eq_and_pow2_minus1_shl1_negative1_before icmp_eq_and_pow2_minus1_shl1_negative1_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_minus1_shl1_negative2_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_minus1_shl1_negative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_minus1_shl1_negative2   : icmp_eq_and_pow2_minus1_shl1_negative2_before  ⊑  icmp_eq_and_pow2_minus1_shl1_negative2_combined := by
  unfold icmp_eq_and_pow2_minus1_shl1_negative2_before icmp_eq_and_pow2_minus1_shl1_negative2_combined
  simp_alive_peephole
  sorry
def icmp_eq_and1_lshr_pow2_combined := [llvmfunc|
  llvm.func @icmp_eq_and1_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_eq_and1_lshr_pow2   : icmp_eq_and1_lshr_pow2_before  ⊑  icmp_eq_and1_lshr_pow2_combined := by
  unfold icmp_eq_and1_lshr_pow2_before icmp_eq_and1_lshr_pow2_combined
  simp_alive_peephole
  sorry
def icmp_eq_and1_lshr_pow2_vec_combined := [llvmfunc|
  llvm.func @icmp_eq_and1_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_eq_and1_lshr_pow2_vec   : icmp_eq_and1_lshr_pow2_vec_before  ⊑  icmp_eq_and1_lshr_pow2_vec_combined := by
  unfold icmp_eq_and1_lshr_pow2_vec_before icmp_eq_and1_lshr_pow2_vec_combined
  simp_alive_peephole
  sorry
def icmp_ne_and1_lshr_pow2_combined := [llvmfunc|
  llvm.func @icmp_ne_and1_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_ne_and1_lshr_pow2   : icmp_ne_and1_lshr_pow2_before  ⊑  icmp_ne_and1_lshr_pow2_combined := by
  unfold icmp_ne_and1_lshr_pow2_before icmp_ne_and1_lshr_pow2_combined
  simp_alive_peephole
  sorry
def icmp_ne_and1_lshr_pow2_vec_combined := [llvmfunc|
  llvm.func @icmp_ne_and1_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_ne_and1_lshr_pow2_vec   : icmp_ne_and1_lshr_pow2_vec_before  ⊑  icmp_ne_and1_lshr_pow2_vec_combined := by
  unfold icmp_ne_and1_lshr_pow2_vec_before icmp_ne_and1_lshr_pow2_vec_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_lshr_pow2_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_lshr_pow2   : icmp_eq_and_pow2_lshr_pow2_before  ⊑  icmp_eq_and_pow2_lshr_pow2_combined := by
  unfold icmp_eq_and_pow2_lshr_pow2_before icmp_eq_and_pow2_lshr_pow2_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_lshr_pow2_case2_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_lshr_pow2_case2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_icmp_eq_and_pow2_lshr_pow2_case2   : icmp_eq_and_pow2_lshr_pow2_case2_before  ⊑  icmp_eq_and_pow2_lshr_pow2_case2_combined := by
  unfold icmp_eq_and_pow2_lshr_pow2_case2_before icmp_eq_and_pow2_lshr_pow2_case2_combined
  simp_alive_peephole
  sorry
def icmp_eq_and_pow2_lshr_pow2_vec_combined := [llvmfunc|
  llvm.func @icmp_eq_and_pow2_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_eq_and_pow2_lshr_pow2_vec   : icmp_eq_and_pow2_lshr_pow2_vec_before  ⊑  icmp_eq_and_pow2_lshr_pow2_vec_combined := by
  unfold icmp_eq_and_pow2_lshr_pow2_vec_before icmp_eq_and_pow2_lshr_pow2_vec_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_lshr_pow2_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_lshr_pow2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_icmp_ne_and_pow2_lshr_pow2   : icmp_ne_and_pow2_lshr_pow2_before  ⊑  icmp_ne_and_pow2_lshr_pow2_combined := by
  unfold icmp_ne_and_pow2_lshr_pow2_before icmp_ne_and_pow2_lshr_pow2_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_lshr_pow2_case2_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_lshr_pow2_case2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_icmp_ne_and_pow2_lshr_pow2_case2   : icmp_ne_and_pow2_lshr_pow2_case2_before  ⊑  icmp_ne_and_pow2_lshr_pow2_case2_combined := by
  unfold icmp_ne_and_pow2_lshr_pow2_case2_before icmp_ne_and_pow2_lshr_pow2_case2_combined
  simp_alive_peephole
  sorry
def icmp_ne_and_pow2_lshr_pow2_vec_combined := [llvmfunc|
  llvm.func @icmp_ne_and_pow2_lshr_pow2_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_icmp_ne_and_pow2_lshr_pow2_vec   : icmp_ne_and_pow2_lshr_pow2_vec_before  ⊑  icmp_ne_and_pow2_lshr_pow2_vec_combined := by
  unfold icmp_ne_and_pow2_lshr_pow2_vec_before icmp_ne_and_pow2_lshr_pow2_vec_combined
  simp_alive_peephole
  sorry
def icmp_eq_and1_lshr_pow2_negative1_combined := [llvmfunc|
  llvm.func @icmp_eq_and1_lshr_pow2_negative1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_icmp_eq_and1_lshr_pow2_negative1   : icmp_eq_and1_lshr_pow2_negative1_before  ⊑  icmp_eq_and1_lshr_pow2_negative1_combined := by
  unfold icmp_eq_and1_lshr_pow2_negative1_before icmp_eq_and1_lshr_pow2_negative1_combined
  simp_alive_peephole
  sorry
def icmp_eq_and1_lshr_pow2_negative2_combined := [llvmfunc|
  llvm.func @icmp_eq_and1_lshr_pow2_negative2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %0, %arg0  : i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.zext %5 : i1 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_icmp_eq_and1_lshr_pow2_negative2   : icmp_eq_and1_lshr_pow2_negative2_before  ⊑  icmp_eq_and1_lshr_pow2_negative2_combined := by
  unfold icmp_eq_and1_lshr_pow2_negative2_before icmp_eq_and1_lshr_pow2_negative2_combined
  simp_alive_peephole
  sorry
def eq_and_shl_one_combined := [llvmfunc|
  llvm.func @eq_and_shl_one(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_eq_and_shl_one   : eq_and_shl_one_before  ⊑  eq_and_shl_one_combined := by
  unfold eq_and_shl_one_before eq_and_shl_one_combined
  simp_alive_peephole
  sorry
def ne_and_shl_one_commute_combined := [llvmfunc|
  llvm.func @ne_and_shl_one_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.shl %6, %arg1 overflow<nuw>  : vector<2xi8>
    %10 = llvm.and %9, %arg0  : vector<2xi8>
    %11 = llvm.icmp "eq" %10, %8 : vector<2xi8>
    llvm.return %11 : vector<2xi1>
  }]

theorem inst_combine_ne_and_shl_one_commute   : ne_and_shl_one_commute_before  ⊑  ne_and_shl_one_commute_combined := by
  unfold ne_and_shl_one_commute_before ne_and_shl_one_commute_combined
  simp_alive_peephole
  sorry
def ne_and_lshr_minval_combined := [llvmfunc|
  llvm.func @ne_and_lshr_minval(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mul %arg0, %arg0  : i8
    %3 = llvm.lshr %0, %arg1  : i8
    %4 = llvm.and %2, %3  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_ne_and_lshr_minval   : ne_and_lshr_minval_before  ⊑  ne_and_lshr_minval_combined := by
  unfold ne_and_lshr_minval_before ne_and_lshr_minval_combined
  simp_alive_peephole
  sorry
def eq_and_lshr_minval_commute_combined := [llvmfunc|
  llvm.func @eq_and_lshr_minval_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mul %arg0, %arg0  : i8
    %3 = llvm.lshr %0, %arg1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.and %2, %3  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %4, %1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_eq_and_lshr_minval_commute   : eq_and_lshr_minval_commute_before  ⊑  eq_and_lshr_minval_commute_combined := by
  unfold eq_and_lshr_minval_commute_before eq_and_lshr_minval_commute_combined
  simp_alive_peephole
  sorry
def eq_and_shl_two_combined := [llvmfunc|
  llvm.func @eq_and_shl_two(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_eq_and_shl_two   : eq_and_shl_two_before  ⊑  eq_and_shl_two_combined := by
  unfold eq_and_shl_two_before eq_and_shl_two_combined
  simp_alive_peephole
  sorry
def slt_and_shl_one_combined := [llvmfunc|
  llvm.func @slt_and_shl_one(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_and_shl_one   : slt_and_shl_one_before  ⊑  slt_and_shl_one_combined := by
  unfold slt_and_shl_one_before slt_and_shl_one_combined
  simp_alive_peephole
  sorry
def fold_eq_lhs_combined := [llvmfunc|
  llvm.func @fold_eq_lhs(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_fold_eq_lhs   : fold_eq_lhs_before  ⊑  fold_eq_lhs_combined := by
  unfold fold_eq_lhs_before fold_eq_lhs_combined
  simp_alive_peephole
  sorry
def fold_eq_lhs_fail_eq_nonzero_combined := [llvmfunc|
  llvm.func @fold_eq_lhs_fail_eq_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_fold_eq_lhs_fail_eq_nonzero   : fold_eq_lhs_fail_eq_nonzero_before  ⊑  fold_eq_lhs_fail_eq_nonzero_combined := by
  unfold fold_eq_lhs_fail_eq_nonzero_before fold_eq_lhs_fail_eq_nonzero_combined
  simp_alive_peephole
  sorry
def fold_eq_lhs_fail_multiuse_shl_combined := [llvmfunc|
  llvm.func @fold_eq_lhs_fail_multiuse_shl(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_fold_eq_lhs_fail_multiuse_shl   : fold_eq_lhs_fail_multiuse_shl_before  ⊑  fold_eq_lhs_fail_multiuse_shl_combined := by
  unfold fold_eq_lhs_fail_multiuse_shl_before fold_eq_lhs_fail_multiuse_shl_combined
  simp_alive_peephole
  sorry
def fold_ne_rhs_combined := [llvmfunc|
  llvm.func @fold_ne_rhs(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg1, %0  : i8
    %4 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_fold_ne_rhs   : fold_ne_rhs_before  ⊑  fold_ne_rhs_combined := by
  unfold fold_ne_rhs_before fold_ne_rhs_combined
  simp_alive_peephole
  sorry
def fold_ne_rhs_fail_multiuse_and_combined := [llvmfunc|
  llvm.func @fold_ne_rhs_fail_multiuse_and(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg1, %0  : i8
    %4 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %5 = llvm.and %3, %4  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_fold_ne_rhs_fail_multiuse_and   : fold_ne_rhs_fail_multiuse_and_before  ⊑  fold_ne_rhs_fail_multiuse_and_combined := by
  unfold fold_ne_rhs_fail_multiuse_and_before fold_ne_rhs_fail_multiuse_and_combined
  simp_alive_peephole
  sorry
def fold_ne_rhs_fail_shift_not_1s_combined := [llvmfunc|
  llvm.func @fold_ne_rhs_fail_shift_not_1s(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(122 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg1, %0  : i8
    %4 = llvm.shl %1, %arg0  : i8
    %5 = llvm.and %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_fold_ne_rhs_fail_shift_not_1s   : fold_ne_rhs_fail_shift_not_1s_before  ⊑  fold_ne_rhs_fail_shift_not_1s_combined := by
  unfold fold_ne_rhs_fail_shift_not_1s_before fold_ne_rhs_fail_shift_not_1s_combined
  simp_alive_peephole
  sorry
