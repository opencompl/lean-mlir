import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-add
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def cvt_icmp_0_zext_plus_zext_eq_i16_before := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_zext_eq_i16(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_0_zext_plus_zext_eq_i8_before := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_zext_eq_i8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.zext %arg1 : i8 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_2_zext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_1_zext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_0_zext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_zext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_zext_plus_zext_eq_vec_before := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_eq_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.add %2, %1  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def cvt_icmp_2_zext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_2_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_2_sext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_1_sext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_0_sext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_0_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_sext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_1_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_2_sext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_2_sext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_1_sext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_0_sext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_0_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_sext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_1_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_2_sext_plus_zext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_2_zext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_1_zext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_0_zext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_zext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_zext_plus_zext_ne_extra_use_1_before := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_ne_extra_use_1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_zext_plus_zext_ne_extra_use_2_before := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_ne_extra_use_2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_2_zext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_2_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_2_sext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_1_sext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_0_sext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_0_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_sext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_1_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_2_sext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_2_sext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_1_sext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_0_sext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_0_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_sext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_1_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_2_sext_plus_zext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_2_sext_plus_zext_ne_vec_before := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_zext_ne_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.add %1, %2 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def cvt_icmp_neg_2_zext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_2_zext_plus_sext_eq_vec_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_sext_eq_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.sext %arg1 : vector<2xi1> to vector<2xi32>
    %3 = llvm.add %2, %1 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def cvt_icmp_neg_1_zext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_0_zext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_zext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_2_zext_plus_sext_eq_before := [llvmfunc|
  llvm.func @cvt_icmp_2_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_2_zext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_neg_1_zext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_0_zext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_1_zext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def cvt_icmp_2_zext_plus_sext_ne_before := [llvmfunc|
  llvm.func @cvt_icmp_2_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp1_before := [llvmfunc|
  llvm.func @test_cvt_icmp1(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg0 : i1 to i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    llvm.return %5 : i1
  }]

def test_cvt_icmp2_before := [llvmfunc|
  llvm.func @test_cvt_icmp2(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg0 : i1 to i32
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %0 : i32
    llvm.return %5 : i1
  }]

def test_zext_zext_cvt_neg_2_ult_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_neg_1_ult_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_0_ult_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_2_ult_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_neg_2_ult_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_neg_1_ult_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_0_ult_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_1_ult_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_2_ult_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_zext_cvt_neg_2_ult_icmp_before := [llvmfunc|
  llvm.func @test_sext_zext_cvt_neg_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_zext_cvt_neg_1_ult_icmp_before := [llvmfunc|
  llvm.func @test_sext_zext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_zext_cvt_0_ult_icmp_before := [llvmfunc|
  llvm.func @test_sext_zext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_zext_cvt_2_ult_icmp_before := [llvmfunc|
  llvm.func @test_sext_zext_cvt_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_neg_1_ult_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_0_ult_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_1_ult_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp4_before := [llvmfunc|
  llvm.func @test_cvt_icmp4(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_neg_2_ugt_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_1_ugt_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_1_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_2_ugt_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_neg_2_ugt_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_0_ugt_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_0_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_2_ugt_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_neg_2_ugt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_neg_1_ugt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_1_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_0_ugt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_0_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_1_ugt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_1_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_2_ugt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp5_before := [llvmfunc|
  llvm.func @test_cvt_icmp5(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "uge" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp6_before := [llvmfunc|
  llvm.func @test_cvt_icmp6(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ule" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp7_before := [llvmfunc|
  llvm.func @test_cvt_icmp7(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_neg_2_sgt_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_neg_1_sgt_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_1_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_2_sgt_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_neg_2_sgt_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_0_sgt_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_0_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_2_sgt_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_neg_2_sgt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_neg_1_sgt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_1_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_0_sgt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_0_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_1_sgt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_1_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_2_sgt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_neg_2_slt_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_neg_1_slt_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_1_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_zext_cvt_2_slt_icmp_before := [llvmfunc|
  llvm.func @test_zext_zext_cvt_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_neg_2_slt_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_0_slt_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_0_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_sext_sext_cvt_2_slt_icmp_before := [llvmfunc|
  llvm.func @test_sext_sext_cvt_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_neg_2_slt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_neg_1_slt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_1_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_0_slt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_0_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_1_slt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_1_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_zext_sext_cvt_2_slt_icmp_before := [llvmfunc|
  llvm.func @test_zext_sext_cvt_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp8_before := [llvmfunc|
  llvm.func @test_cvt_icmp8(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp9_before := [llvmfunc|
  llvm.func @test_cvt_icmp9(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp10_before := [llvmfunc|
  llvm.func @test_cvt_icmp10(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sle" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp11_before := [llvmfunc|
  llvm.func @test_cvt_icmp11(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp12_before := [llvmfunc|
  llvm.func @test_cvt_icmp12(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "uge" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp13_before := [llvmfunc|
  llvm.func @test_cvt_icmp13(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp14_before := [llvmfunc|
  llvm.func @test_cvt_icmp14(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ule" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp15_before := [llvmfunc|
  llvm.func @test_cvt_icmp15(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp16_before := [llvmfunc|
  llvm.func @test_cvt_icmp16(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp17_before := [llvmfunc|
  llvm.func @test_cvt_icmp17(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp18_before := [llvmfunc|
  llvm.func @test_cvt_icmp18(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.sext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sle" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp19_before := [llvmfunc|
  llvm.func @test_cvt_icmp19(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp20_before := [llvmfunc|
  llvm.func @test_cvt_icmp20(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "uge" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp21_before := [llvmfunc|
  llvm.func @test_cvt_icmp21(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp22_before := [llvmfunc|
  llvm.func @test_cvt_icmp22(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "ule" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp23_before := [llvmfunc|
  llvm.func @test_cvt_icmp23(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sgt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp24_before := [llvmfunc|
  llvm.func @test_cvt_icmp24(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sge" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp25_before := [llvmfunc|
  llvm.func @test_cvt_icmp25(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "slt" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test_cvt_icmp26_before := [llvmfunc|
  llvm.func @test_cvt_icmp26(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1  : i32
    %4 = llvm.icmp "sle" %3, %0 : i32
    llvm.return %4 : i1
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test1vec_before := [llvmfunc|
  llvm.func @test1vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %0  : vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test2vec_before := [llvmfunc|
  llvm.func @test2vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-2147483644 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test3vec_before := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2147483644> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483644 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "sge" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test4multiuse(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @test4multiuse(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(-2147483644 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.insertvalue %3, %2[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.struct<(i32, i1)> 
    llvm.return %6 : !llvm.struct<(i32, i1)>
  }]

def test4vec_before := [llvmfunc|
  llvm.func @test4vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-2147483644> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def nsw_slt1_before := [llvmfunc|
  llvm.func @nsw_slt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-27 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nsw_slt1_splat_vec_before := [llvmfunc|
  llvm.func @nsw_slt1_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-27> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def nsw_slt2_before := [llvmfunc|
  llvm.func @nsw_slt2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-100 : i8) : i8
    %1 = llvm.mlir.constant(27 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nsw_slt2_splat_vec_before := [llvmfunc|
  llvm.func @nsw_slt2_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<27> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def nsw_slt3_before := [llvmfunc|
  llvm.func @nsw_slt3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-26 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nsw_slt4_before := [llvmfunc|
  llvm.func @nsw_slt4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-100 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nsw_sgt1_before := [llvmfunc|
  llvm.func @nsw_sgt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-100 : i8) : i8
    %1 = llvm.mlir.constant(26 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nsw_sgt1_splat_vec_before := [llvmfunc|
  llvm.func @nsw_sgt1_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<26> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def nsw_sgt2_before := [llvmfunc|
  llvm.func @nsw_sgt2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-26 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nsw_sgt2_splat_vec_before := [llvmfunc|
  llvm.func @nsw_sgt2_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<100> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-26> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def slt_zero_add_nsw_before := [llvmfunc|
  llvm.func @slt_zero_add_nsw(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def slt_zero_add_nsw_splat_vec_before := [llvmfunc|
  llvm.func @slt_zero_add_nsw_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0 overflow<nsw>  : vector<2xi8>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def nsw_slt3_ov_no_before := [llvmfunc|
  llvm.func @nsw_slt3_ov_no(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-28 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nsw_slt4_ov_before := [llvmfunc|
  llvm.func @nsw_slt4_ov(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(-29 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nsw_slt5_ov_before := [llvmfunc|
  llvm.func @nsw_slt5_ov(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-100 : i8) : i8
    %1 = llvm.mlir.constant(28 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def slt_zero_add_nsw_signbit_before := [llvmfunc|
  llvm.func @slt_zero_add_nsw_signbit(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def slt_zero_add_nuw_signbit_before := [llvmfunc|
  llvm.func @slt_zero_add_nuw_signbit(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def reduce_add_ult_before := [llvmfunc|
  llvm.func @reduce_add_ult(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

def reduce_add_ugt_before := [llvmfunc|
  llvm.func @reduce_add_ugt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def reduce_add_ule_before := [llvmfunc|
  llvm.func @reduce_add_ule(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ule" %2, %1 : i32
    llvm.return %3 : i1
  }]

def reduce_add_uge_before := [llvmfunc|
  llvm.func @reduce_add_uge(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "uge" %2, %1 : i32
    llvm.return %3 : i1
  }]

def ult_add_ssubov_before := [llvmfunc|
  llvm.func @ult_add_ssubov(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(71 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

def ult_add_nonuw_before := [llvmfunc|
  llvm.func @ult_add_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(71 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def uge_add_nonuw_before := [llvmfunc|
  llvm.func @uge_add_nonuw(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "uge" %2, %1 : i32
    llvm.return %3 : i1
  }]

def op_ugt_sum_commute1_before := [llvmfunc|
  llvm.func @op_ugt_sum_commute1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.add %1, %2  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }]

def op_ugt_sum_vec_commute2_before := [llvmfunc|
  llvm.func @op_ugt_sum_vec_commute2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %2 = llvm.sdiv %0, %arg1  : vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "ugt" %1, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def sum_ugt_op_uses_before := [llvmfunc|
  llvm.func @sum_ugt_op_uses(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.add %1, %2  : i8
    llvm.store %3, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }]

def sum_ult_op_vec_commute1_before := [llvmfunc|
  llvm.func @sum_ult_op_vec_commute1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-42, 42]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %3 = llvm.sdiv %1, %arg1  : vector<2xi8>
    %4 = llvm.add %2, %3  : vector<2xi8>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def sum_ult_op_commute2_before := [llvmfunc|
  llvm.func @sum_ult_op_commute2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }]

def sum_ult_op_uses_before := [llvmfunc|
  llvm.func @sum_ult_op_uses(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.add %arg1, %arg0  : i8
    llvm.store %0, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def common_op_nsw_before := [llvmfunc|
  llvm.func @common_op_nsw(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nsw>  : i32
    %1 = llvm.add %arg1, %arg2 overflow<nsw>  : i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def common_op_nsw_extra_uses_before := [llvmfunc|
  llvm.func @common_op_nsw_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nsw>  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.add %arg1, %arg2 overflow<nsw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def common_op_nuw_before := [llvmfunc|
  llvm.func @common_op_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nuw>  : i32
    %1 = llvm.add %arg2, %arg1 overflow<nuw>  : i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def common_op_nuw_extra_uses_before := [llvmfunc|
  llvm.func @common_op_nuw_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nuw>  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.add %arg2, %arg1 overflow<nuw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "ugt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def common_op_nsw_commute_before := [llvmfunc|
  llvm.func @common_op_nsw_commute(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg2, %arg0 overflow<nsw>  : i32
    %1 = llvm.add %arg1, %arg2 overflow<nsw>  : i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def common_op_nuw_commute_before := [llvmfunc|
  llvm.func @common_op_nuw_commute(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg2, %arg0 overflow<nuw>  : i32
    %1 = llvm.add %arg2, %arg1 overflow<nuw>  : i32
    %2 = llvm.icmp "ult" %0, %1 : i32
    llvm.return %2 : i1
  }]

def common_op_test29_before := [llvmfunc|
  llvm.func @common_op_test29(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.add %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.icmp "sgt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def sum_nuw_before := [llvmfunc|
  llvm.func @sum_nuw(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.icmp "ugt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def sum_nsw_commute_before := [llvmfunc|
  llvm.func @sum_nsw_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.add %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

def sum_nuw_commute_before := [llvmfunc|
  llvm.func @sum_nuw_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

def bzip1_before := [llvmfunc|
  llvm.func @bzip1(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.add %arg0, %arg2  : i8
    %1 = llvm.add %arg1, %arg2  : i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    llvm.return
  }]

def bzip2_before := [llvmfunc|
  llvm.func @bzip2(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.add %arg0, %arg2  : i8
    %1 = llvm.add %arg1, %arg2  : i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.call @use1(%2) : (i1) -> ()
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return
  }]

def icmp_eq_add_undef_before := [llvmfunc|
  llvm.func @icmp_eq_add_undef(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.add %arg0, %6  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }]

def icmp_eq_add_non_splat_before := [llvmfunc|
  llvm.func @icmp_eq_add_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<10> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_eq_add_undef2_before := [llvmfunc|
  llvm.func @icmp_eq_add_undef2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.add %arg0, %0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }]

def icmp_eq_add_non_splat2_before := [llvmfunc|
  llvm.func @icmp_eq_add_non_splat2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 11]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def without_nsw_nuw_before := [llvmfunc|
  llvm.func @without_nsw_nuw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.constant(35 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }]

def with_nsw_nuw_before := [llvmfunc|
  llvm.func @with_nsw_nuw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.constant(35 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }]

def with_nsw_large_before := [llvmfunc|
  llvm.func @with_nsw_large(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.constant(35 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }]

def with_nsw_small_before := [llvmfunc|
  llvm.func @with_nsw_small(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(35 : i8) : i8
    %1 = llvm.mlir.constant(37 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }]

def with_nuw_large_before := [llvmfunc|
  llvm.func @with_nuw_large(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(37 : i8) : i8
    %1 = llvm.mlir.constant(35 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }]

def with_nuw_small_before := [llvmfunc|
  llvm.func @with_nuw_small(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(35 : i8) : i8
    %1 = llvm.mlir.constant(37 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }]

def with_nuw_large_negative_before := [llvmfunc|
  llvm.func @with_nuw_large_negative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-37 : i8) : i8
    %1 = llvm.mlir.constant(-35 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }]

def ugt_offset_before := [llvmfunc|
  llvm.func @ugt_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ugt_offset_use_before := [llvmfunc|
  llvm.func @ugt_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-2147483607 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def ugt_offset_splat_before := [llvmfunc|
  llvm.func @ugt_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(9 : i5) : i5
    %1 = llvm.mlir.constant(dense<9> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(-8 : i5) : i5
    %3 = llvm.mlir.constant(dense<-8> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.add %arg0, %1  : vector<2xi5>
    %5 = llvm.icmp "ugt" %4, %3 : vector<2xi5>
    llvm.return %5 : vector<2xi1>
  }]

def ugt_wrong_offset_before := [llvmfunc|
  llvm.func @ugt_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ugt_offset_nuw_before := [llvmfunc|
  llvm.func @ugt_offset_nuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(124 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_offset_before := [llvmfunc|
  llvm.func @ult_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(122 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_offset_use_before := [llvmfunc|
  llvm.func @ult_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-2147483606 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

def ult_offset_splat_before := [llvmfunc|
  llvm.func @ult_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(9 : i5) : i5
    %1 = llvm.mlir.constant(dense<9> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(-7 : i5) : i5
    %3 = llvm.mlir.constant(dense<-7> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.add %arg0, %1  : vector<2xi5>
    %5 = llvm.icmp "ult" %4, %3 : vector<2xi5>
    llvm.return %5 : vector<2xi1>
  }]

def ult_wrong_offset_before := [llvmfunc|
  llvm.func @ult_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_offset_nuw_before := [llvmfunc|
  llvm.func @ult_offset_nuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-86 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sgt_offset_before := [llvmfunc|
  llvm.func @sgt_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(-7 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def sgt_offset_use_before := [llvmfunc|
  llvm.func @sgt_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def sgt_offset_splat_before := [llvmfunc|
  llvm.func @sgt_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(9 : i5) : i5
    %1 = llvm.mlir.constant(dense<9> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(8 : i5) : i5
    %3 = llvm.mlir.constant(dense<8> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.add %arg0, %1  : vector<2xi5>
    %5 = llvm.icmp "sgt" %4, %3 : vector<2xi5>
    llvm.return %5 : vector<2xi1>
  }]

def sgt_wrong_offset_before := [llvmfunc|
  llvm.func @sgt_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def sgt_offset_nsw_before := [llvmfunc|
  llvm.func @sgt_offset_nsw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(41 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def slt_offset_before := [llvmfunc|
  llvm.func @slt_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def slt_offset_use_before := [llvmfunc|
  llvm.func @slt_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def slt_offset_splat_before := [llvmfunc|
  llvm.func @slt_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(9 : i5) : i5
    %1 = llvm.mlir.constant(dense<9> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.add %arg0, %1  : vector<2xi5>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi5>
    llvm.return %3 : vector<2xi1>
  }]

def slt_wrong_offset_before := [llvmfunc|
  llvm.func @slt_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(-7 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def slt_offset_nsw_before := [llvmfunc|
  llvm.func @slt_offset_nsw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def increment_max_before := [llvmfunc|
  llvm.func @increment_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def decrement_max_before := [llvmfunc|
  llvm.func @decrement_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def increment_min_before := [llvmfunc|
  llvm.func @increment_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def decrement_min_before := [llvmfunc|
  llvm.func @decrement_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def icmp_add_add_C_before := [llvmfunc|
  llvm.func @icmp_add_add_C(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def icmp_add_add_C_pred_before := [llvmfunc|
  llvm.func @icmp_add_add_C_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "uge" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def icmp_add_add_C_wrong_pred_before := [llvmfunc|
  llvm.func @icmp_add_add_C_wrong_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ule" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def icmp_add_add_C_wrong_operand_before := [llvmfunc|
  llvm.func @icmp_add_add_C_wrong_operand(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg2 : i32
    llvm.return %3 : i1
  }]

def icmp_add_add_C_different_const_before := [llvmfunc|
  llvm.func @icmp_add_add_C_different_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def icmp_add_add_C_vector_before := [llvmfunc|
  llvm.func @icmp_add_add_C_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[10, 20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %arg1  : vector<2xi8>
    %2 = llvm.add %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_add_add_C_vector_undef_before := [llvmfunc|
  llvm.func @icmp_add_add_C_vector_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.add %arg0, %arg1  : vector<2xi8>
    %8 = llvm.add %7, %6  : vector<2xi8>
    %9 = llvm.icmp "ult" %8, %arg0 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

def icmp_add_add_C_comm1_before := [llvmfunc|
  llvm.func @icmp_add_add_C_comm1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg1, %arg0  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def icmp_add_add_C_comm2_before := [llvmfunc|
  llvm.func @icmp_add_add_C_comm2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ugt" %2, %4 : i32
    llvm.return %5 : i1
  }]

def icmp_add_add_C_comm2_pred_before := [llvmfunc|
  llvm.func @icmp_add_add_C_comm2_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ule" %2, %4 : i32
    llvm.return %5 : i1
  }]

def icmp_add_add_C_comm2_wrong_pred_before := [llvmfunc|
  llvm.func @icmp_add_add_C_comm2_wrong_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ult" %2, %4 : i32
    llvm.return %5 : i1
  }]

def icmp_add_add_C_comm3_before := [llvmfunc|
  llvm.func @icmp_add_add_C_comm3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.add %arg1, %2  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ugt" %2, %4 : i32
    llvm.return %5 : i1
  }]

def icmp_add_add_C_extra_use1_before := [llvmfunc|
  llvm.func @icmp_add_add_C_extra_use1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def icmp_add_add_C_extra_use2_before := [llvmfunc|
  llvm.func @icmp_add_add_C_extra_use2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def icmp_dec_assume_nonzero_before := [llvmfunc|
  llvm.func @icmp_dec_assume_nonzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

def icmp_dec_sub_assume_nonzero_before := [llvmfunc|
  llvm.func @icmp_dec_sub_assume_nonzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(11 : i8) : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.sub %arg0, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

def icmp_dec_nonzero_before := [llvmfunc|
  llvm.func @icmp_dec_nonzero(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.mlir.constant(7 : i16) : i16
    %3 = llvm.or %arg0, %0  : i16
    %4 = llvm.add %3, %1  : i16
    %5 = llvm.icmp "ult" %4, %2 : i16
    llvm.return %5 : i1
  }]

def icmp_dec_nonzero_vec_before := [llvmfunc|
  llvm.func @icmp_dec_nonzero_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[15, 17]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg0, %0  : vector<2xi32>
    %4 = llvm.add %3, %1  : vector<2xi32>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

def icmp_dec_notnonzero_before := [llvmfunc|
  llvm.func @icmp_dec_notnonzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_addnuw_nonzero_before := [llvmfunc|
  llvm.func @icmp_addnuw_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def icmp_addnuw_nonzero_fail_multiuse_before := [llvmfunc|
  llvm.func @icmp_addnuw_nonzero_fail_multiuse(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %2 : i1
  }]

def ult_add_C2_pow2_C_neg_before := [llvmfunc|
  llvm.func @ult_add_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_add_nsw_C2_pow2_C_neg_before := [llvmfunc|
  llvm.func @ult_add_nsw_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_add_nuw_nsw_C2_pow2_C_neg_before := [llvmfunc|
  llvm.func @ult_add_nuw_nsw_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_add_C2_neg_C_pow2_before := [llvmfunc|
  llvm.func @ult_add_C2_neg_C_pow2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ult_add_C2_pow2_C_neg_vec_before := [llvmfunc|
  llvm.func @ult_add_C2_pow2_C_neg_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-32> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def ult_add_C2_pow2_C_neg_multiuse_before := [llvmfunc|
  llvm.func @ult_add_C2_pow2_C_neg_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.mlir.addressof @use : !llvm.ptr
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.call %2(%3) : !llvm.ptr, (i8) -> ()
    llvm.return %4 : i1
  }]

def uge_add_C2_pow2_C_neg_before := [llvmfunc|
  llvm.func @uge_add_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def cvt_icmp_0_zext_plus_zext_eq_i16_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_zext_eq_i16(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.sub %0, %1 overflow<nsw>  : i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_cvt_icmp_0_zext_plus_zext_eq_i16   : cvt_icmp_0_zext_plus_zext_eq_i16_before  ⊑  cvt_icmp_0_zext_plus_zext_eq_i16_combined := by
  unfold cvt_icmp_0_zext_plus_zext_eq_i16_before cvt_icmp_0_zext_plus_zext_eq_i16_combined
  simp_alive_peephole
  sorry
def cvt_icmp_0_zext_plus_zext_eq_i8_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_zext_eq_i8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.zext %arg1 : i8 to i32
    %3 = llvm.sub %0, %1 overflow<nsw>  : i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_cvt_icmp_0_zext_plus_zext_eq_i8   : cvt_icmp_0_zext_plus_zext_eq_i8_before  ⊑  cvt_icmp_0_zext_plus_zext_eq_i8_combined := by
  unfold cvt_icmp_0_zext_plus_zext_eq_i8_before cvt_icmp_0_zext_plus_zext_eq_i8_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_2_zext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_2_zext_plus_zext_eq   : cvt_icmp_neg_2_zext_plus_zext_eq_before  ⊑  cvt_icmp_neg_2_zext_plus_zext_eq_combined := by
  unfold cvt_icmp_neg_2_zext_plus_zext_eq_before cvt_icmp_neg_2_zext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_1_zext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_1_zext_plus_zext_eq   : cvt_icmp_neg_1_zext_plus_zext_eq_before  ⊑  cvt_icmp_neg_1_zext_plus_zext_eq_combined := by
  unfold cvt_icmp_neg_1_zext_plus_zext_eq_before cvt_icmp_neg_1_zext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_0_zext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_0_zext_plus_zext_eq   : cvt_icmp_0_zext_plus_zext_eq_before  ⊑  cvt_icmp_0_zext_plus_zext_eq_combined := by
  unfold cvt_icmp_0_zext_plus_zext_eq_before cvt_icmp_0_zext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_zext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_1_zext_plus_zext_eq   : cvt_icmp_1_zext_plus_zext_eq_before  ⊑  cvt_icmp_1_zext_plus_zext_eq_combined := by
  unfold cvt_icmp_1_zext_plus_zext_eq_before cvt_icmp_1_zext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_zext_plus_zext_eq_vec_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_eq_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.xor %arg1, %arg0  : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_cvt_icmp_1_zext_plus_zext_eq_vec   : cvt_icmp_1_zext_plus_zext_eq_vec_before  ⊑  cvt_icmp_1_zext_plus_zext_eq_vec_combined := by
  unfold cvt_icmp_1_zext_plus_zext_eq_vec_before cvt_icmp_1_zext_plus_zext_eq_vec_combined
  simp_alive_peephole
  sorry
def cvt_icmp_2_zext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_2_zext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_2_zext_plus_zext_eq   : cvt_icmp_2_zext_plus_zext_eq_before  ⊑  cvt_icmp_2_zext_plus_zext_eq_combined := by
  unfold cvt_icmp_2_zext_plus_zext_eq_before cvt_icmp_2_zext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_2_sext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_2_sext_plus_sext_eq   : cvt_icmp_neg_2_sext_plus_sext_eq_before  ⊑  cvt_icmp_neg_2_sext_plus_sext_eq_combined := by
  unfold cvt_icmp_neg_2_sext_plus_sext_eq_before cvt_icmp_neg_2_sext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_1_sext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_1_sext_plus_sext_eq   : cvt_icmp_neg_1_sext_plus_sext_eq_before  ⊑  cvt_icmp_neg_1_sext_plus_sext_eq_combined := by
  unfold cvt_icmp_neg_1_sext_plus_sext_eq_before cvt_icmp_neg_1_sext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_0_sext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_0_sext_plus_sext_eq   : cvt_icmp_0_sext_plus_sext_eq_before  ⊑  cvt_icmp_0_sext_plus_sext_eq_combined := by
  unfold cvt_icmp_0_sext_plus_sext_eq_before cvt_icmp_0_sext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_sext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_1_sext_plus_sext_eq   : cvt_icmp_1_sext_plus_sext_eq_before  ⊑  cvt_icmp_1_sext_plus_sext_eq_combined := by
  unfold cvt_icmp_1_sext_plus_sext_eq_before cvt_icmp_1_sext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_2_sext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_2_sext_plus_sext_eq   : cvt_icmp_2_sext_plus_sext_eq_before  ⊑  cvt_icmp_2_sext_plus_sext_eq_combined := by
  unfold cvt_icmp_2_sext_plus_sext_eq_before cvt_icmp_2_sext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_2_sext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_2_sext_plus_zext_eq   : cvt_icmp_neg_2_sext_plus_zext_eq_before  ⊑  cvt_icmp_neg_2_sext_plus_zext_eq_combined := by
  unfold cvt_icmp_neg_2_sext_plus_zext_eq_before cvt_icmp_neg_2_sext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_1_sext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_neg_1_sext_plus_zext_eq   : cvt_icmp_neg_1_sext_plus_zext_eq_before  ⊑  cvt_icmp_neg_1_sext_plus_zext_eq_combined := by
  unfold cvt_icmp_neg_1_sext_plus_zext_eq_before cvt_icmp_neg_1_sext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_0_sext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_0_sext_plus_zext_eq   : cvt_icmp_0_sext_plus_zext_eq_before  ⊑  cvt_icmp_0_sext_plus_zext_eq_combined := by
  unfold cvt_icmp_0_sext_plus_zext_eq_before cvt_icmp_0_sext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_sext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_1_sext_plus_zext_eq   : cvt_icmp_1_sext_plus_zext_eq_before  ⊑  cvt_icmp_1_sext_plus_zext_eq_combined := by
  unfold cvt_icmp_1_sext_plus_zext_eq_before cvt_icmp_1_sext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_2_sext_plus_zext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_zext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_2_sext_plus_zext_eq   : cvt_icmp_2_sext_plus_zext_eq_before  ⊑  cvt_icmp_2_sext_plus_zext_eq_combined := by
  unfold cvt_icmp_2_sext_plus_zext_eq_before cvt_icmp_2_sext_plus_zext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_2_zext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_2_zext_plus_zext_ne   : cvt_icmp_neg_2_zext_plus_zext_ne_before  ⊑  cvt_icmp_neg_2_zext_plus_zext_ne_combined := by
  unfold cvt_icmp_neg_2_zext_plus_zext_ne_before cvt_icmp_neg_2_zext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_1_zext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_1_zext_plus_zext_ne   : cvt_icmp_neg_1_zext_plus_zext_ne_before  ⊑  cvt_icmp_neg_1_zext_plus_zext_ne_combined := by
  unfold cvt_icmp_neg_1_zext_plus_zext_ne_before cvt_icmp_neg_1_zext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_0_zext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_0_zext_plus_zext_ne   : cvt_icmp_0_zext_plus_zext_ne_before  ⊑  cvt_icmp_0_zext_plus_zext_ne_combined := by
  unfold cvt_icmp_0_zext_plus_zext_ne_before cvt_icmp_0_zext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_zext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_1_zext_plus_zext_ne   : cvt_icmp_1_zext_plus_zext_ne_before  ⊑  cvt_icmp_1_zext_plus_zext_ne_combined := by
  unfold cvt_icmp_1_zext_plus_zext_ne_before cvt_icmp_1_zext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_zext_plus_zext_ne_extra_use_1_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_ne_extra_use_1(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_cvt_icmp_1_zext_plus_zext_ne_extra_use_1   : cvt_icmp_1_zext_plus_zext_ne_extra_use_1_before  ⊑  cvt_icmp_1_zext_plus_zext_ne_extra_use_1_combined := by
  unfold cvt_icmp_1_zext_plus_zext_ne_extra_use_1_before cvt_icmp_1_zext_plus_zext_ne_extra_use_1_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_zext_plus_zext_ne_extra_use_2_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_zext_ne_extra_use_2(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.xor %arg1, %arg0  : i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_cvt_icmp_1_zext_plus_zext_ne_extra_use_2   : cvt_icmp_1_zext_plus_zext_ne_extra_use_2_before  ⊑  cvt_icmp_1_zext_plus_zext_ne_extra_use_2_combined := by
  unfold cvt_icmp_1_zext_plus_zext_ne_extra_use_2_before cvt_icmp_1_zext_plus_zext_ne_extra_use_2_combined
  simp_alive_peephole
  sorry
def cvt_icmp_2_zext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_2_zext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_2_zext_plus_zext_ne   : cvt_icmp_2_zext_plus_zext_ne_before  ⊑  cvt_icmp_2_zext_plus_zext_ne_combined := by
  unfold cvt_icmp_2_zext_plus_zext_ne_before cvt_icmp_2_zext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_2_sext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_neg_2_sext_plus_sext_ne   : cvt_icmp_neg_2_sext_plus_sext_ne_before  ⊑  cvt_icmp_neg_2_sext_plus_sext_ne_combined := by
  unfold cvt_icmp_neg_2_sext_plus_sext_ne_before cvt_icmp_neg_2_sext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_1_sext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_neg_1_sext_plus_sext_ne   : cvt_icmp_neg_1_sext_plus_sext_ne_before  ⊑  cvt_icmp_neg_1_sext_plus_sext_ne_combined := by
  unfold cvt_icmp_neg_1_sext_plus_sext_ne_before cvt_icmp_neg_1_sext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_0_sext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_0_sext_plus_sext_ne   : cvt_icmp_0_sext_plus_sext_ne_before  ⊑  cvt_icmp_0_sext_plus_sext_ne_combined := by
  unfold cvt_icmp_0_sext_plus_sext_ne_before cvt_icmp_0_sext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_sext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_1_sext_plus_sext_ne   : cvt_icmp_1_sext_plus_sext_ne_before  ⊑  cvt_icmp_1_sext_plus_sext_ne_combined := by
  unfold cvt_icmp_1_sext_plus_sext_ne_before cvt_icmp_1_sext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_2_sext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_2_sext_plus_sext_ne   : cvt_icmp_2_sext_plus_sext_ne_before  ⊑  cvt_icmp_2_sext_plus_sext_ne_combined := by
  unfold cvt_icmp_2_sext_plus_sext_ne_before cvt_icmp_2_sext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_2_sext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_2_sext_plus_zext_ne   : cvt_icmp_neg_2_sext_plus_zext_ne_before  ⊑  cvt_icmp_neg_2_sext_plus_zext_ne_combined := by
  unfold cvt_icmp_neg_2_sext_plus_zext_ne_before cvt_icmp_neg_2_sext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_1_sext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_neg_1_sext_plus_zext_ne   : cvt_icmp_neg_1_sext_plus_zext_ne_before  ⊑  cvt_icmp_neg_1_sext_plus_zext_ne_combined := by
  unfold cvt_icmp_neg_1_sext_plus_zext_ne_before cvt_icmp_neg_1_sext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_0_sext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_0_sext_plus_zext_ne   : cvt_icmp_0_sext_plus_zext_ne_before  ⊑  cvt_icmp_0_sext_plus_zext_ne_combined := by
  unfold cvt_icmp_0_sext_plus_zext_ne_before cvt_icmp_0_sext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_sext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_1_sext_plus_zext_ne   : cvt_icmp_1_sext_plus_zext_ne_before  ⊑  cvt_icmp_1_sext_plus_zext_ne_combined := by
  unfold cvt_icmp_1_sext_plus_zext_ne_before cvt_icmp_1_sext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_2_sext_plus_zext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_zext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_2_sext_plus_zext_ne   : cvt_icmp_2_sext_plus_zext_ne_before  ⊑  cvt_icmp_2_sext_plus_zext_ne_combined := by
  unfold cvt_icmp_2_sext_plus_zext_ne_before cvt_icmp_2_sext_plus_zext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_2_sext_plus_zext_ne_vec_combined := [llvmfunc|
  llvm.func @cvt_icmp_2_sext_plus_zext_ne_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_cvt_icmp_2_sext_plus_zext_ne_vec   : cvt_icmp_2_sext_plus_zext_ne_vec_before  ⊑  cvt_icmp_2_sext_plus_zext_ne_vec_combined := by
  unfold cvt_icmp_2_sext_plus_zext_ne_vec_before cvt_icmp_2_sext_plus_zext_ne_vec_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_2_zext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_2_zext_plus_sext_eq   : cvt_icmp_neg_2_zext_plus_sext_eq_before  ⊑  cvt_icmp_neg_2_zext_plus_sext_eq_combined := by
  unfold cvt_icmp_neg_2_zext_plus_sext_eq_before cvt_icmp_neg_2_zext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_2_zext_plus_sext_eq_vec_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_sext_eq_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_cvt_icmp_neg_2_zext_plus_sext_eq_vec   : cvt_icmp_neg_2_zext_plus_sext_eq_vec_before  ⊑  cvt_icmp_neg_2_zext_plus_sext_eq_vec_combined := by
  unfold cvt_icmp_neg_2_zext_plus_sext_eq_vec_before cvt_icmp_neg_2_zext_plus_sext_eq_vec_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_1_zext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_neg_1_zext_plus_sext_eq   : cvt_icmp_neg_1_zext_plus_sext_eq_before  ⊑  cvt_icmp_neg_1_zext_plus_sext_eq_combined := by
  unfold cvt_icmp_neg_1_zext_plus_sext_eq_before cvt_icmp_neg_1_zext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_0_zext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_0_zext_plus_sext_eq   : cvt_icmp_0_zext_plus_sext_eq_before  ⊑  cvt_icmp_0_zext_plus_sext_eq_combined := by
  unfold cvt_icmp_0_zext_plus_sext_eq_before cvt_icmp_0_zext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_zext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_1_zext_plus_sext_eq   : cvt_icmp_1_zext_plus_sext_eq_before  ⊑  cvt_icmp_1_zext_plus_sext_eq_combined := by
  unfold cvt_icmp_1_zext_plus_sext_eq_before cvt_icmp_1_zext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_2_zext_plus_sext_eq_combined := [llvmfunc|
  llvm.func @cvt_icmp_2_zext_plus_sext_eq(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_2_zext_plus_sext_eq   : cvt_icmp_2_zext_plus_sext_eq_before  ⊑  cvt_icmp_2_zext_plus_sext_eq_combined := by
  unfold cvt_icmp_2_zext_plus_sext_eq_before cvt_icmp_2_zext_plus_sext_eq_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_2_zext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_2_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_neg_2_zext_plus_sext_ne   : cvt_icmp_neg_2_zext_plus_sext_ne_before  ⊑  cvt_icmp_neg_2_zext_plus_sext_ne_combined := by
  unfold cvt_icmp_neg_2_zext_plus_sext_ne_before cvt_icmp_neg_2_zext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_neg_1_zext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_neg_1_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_neg_1_zext_plus_sext_ne   : cvt_icmp_neg_1_zext_plus_sext_ne_before  ⊑  cvt_icmp_neg_1_zext_plus_sext_ne_combined := by
  unfold cvt_icmp_neg_1_zext_plus_sext_ne_before cvt_icmp_neg_1_zext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_0_zext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_0_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg0, %arg1  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_0_zext_plus_sext_ne   : cvt_icmp_0_zext_plus_sext_ne_before  ⊑  cvt_icmp_0_zext_plus_sext_ne_combined := by
  unfold cvt_icmp_0_zext_plus_sext_ne_before cvt_icmp_0_zext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_1_zext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_1_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_cvt_icmp_1_zext_plus_sext_ne   : cvt_icmp_1_zext_plus_sext_ne_before  ⊑  cvt_icmp_1_zext_plus_sext_ne_combined := by
  unfold cvt_icmp_1_zext_plus_sext_ne_before cvt_icmp_1_zext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def cvt_icmp_2_zext_plus_sext_ne_combined := [llvmfunc|
  llvm.func @cvt_icmp_2_zext_plus_sext_ne(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_cvt_icmp_2_zext_plus_sext_ne   : cvt_icmp_2_zext_plus_sext_ne_before  ⊑  cvt_icmp_2_zext_plus_sext_ne_combined := by
  unfold cvt_icmp_2_zext_plus_sext_ne_before cvt_icmp_2_zext_plus_sext_ne_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp1_combined := [llvmfunc|
  llvm.func @test_cvt_icmp1(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test_cvt_icmp1   : test_cvt_icmp1_before  ⊑  test_cvt_icmp1_combined := by
  unfold test_cvt_icmp1_before test_cvt_icmp1_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp1   : test_cvt_icmp1_before  ⊑  test_cvt_icmp1_combined := by
  unfold test_cvt_icmp1_before test_cvt_icmp1_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp2_combined := [llvmfunc|
  llvm.func @test_cvt_icmp2(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test_cvt_icmp2   : test_cvt_icmp2_before  ⊑  test_cvt_icmp2_combined := by
  unfold test_cvt_icmp2_before test_cvt_icmp2_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp2   : test_cvt_icmp2_before  ⊑  test_cvt_icmp2_combined := by
  unfold test_cvt_icmp2_before test_cvt_icmp2_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_neg_2_ult_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_neg_2_ult_icmp   : test_zext_zext_cvt_neg_2_ult_icmp_before  ⊑  test_zext_zext_cvt_neg_2_ult_icmp_combined := by
  unfold test_zext_zext_cvt_neg_2_ult_icmp_before test_zext_zext_cvt_neg_2_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_neg_1_ult_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_neg_1_ult_icmp   : test_zext_zext_cvt_neg_1_ult_icmp_before  ⊑  test_zext_zext_cvt_neg_1_ult_icmp_combined := by
  unfold test_zext_zext_cvt_neg_1_ult_icmp_before test_zext_zext_cvt_neg_1_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_0_ult_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_0_ult_icmp   : test_zext_zext_cvt_0_ult_icmp_before  ⊑  test_zext_zext_cvt_0_ult_icmp_combined := by
  unfold test_zext_zext_cvt_0_ult_icmp_before test_zext_zext_cvt_0_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_2_ult_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_2_ult_icmp   : test_zext_zext_cvt_2_ult_icmp_before  ⊑  test_zext_zext_cvt_2_ult_icmp_combined := by
  unfold test_zext_zext_cvt_2_ult_icmp_before test_zext_zext_cvt_2_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_neg_2_ult_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_neg_2_ult_icmp   : test_sext_sext_cvt_neg_2_ult_icmp_before  ⊑  test_sext_sext_cvt_neg_2_ult_icmp_combined := by
  unfold test_sext_sext_cvt_neg_2_ult_icmp_before test_sext_sext_cvt_neg_2_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_neg_1_ult_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_neg_1_ult_icmp   : test_sext_sext_cvt_neg_1_ult_icmp_before  ⊑  test_sext_sext_cvt_neg_1_ult_icmp_combined := by
  unfold test_sext_sext_cvt_neg_1_ult_icmp_before test_sext_sext_cvt_neg_1_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_0_ult_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_0_ult_icmp   : test_sext_sext_cvt_0_ult_icmp_before  ⊑  test_sext_sext_cvt_0_ult_icmp_combined := by
  unfold test_sext_sext_cvt_0_ult_icmp_before test_sext_sext_cvt_0_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_1_ult_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_1_ult_icmp   : test_sext_sext_cvt_1_ult_icmp_before  ⊑  test_sext_sext_cvt_1_ult_icmp_combined := by
  unfold test_sext_sext_cvt_1_ult_icmp_before test_sext_sext_cvt_1_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_2_ult_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_2_ult_icmp   : test_sext_sext_cvt_2_ult_icmp_before  ⊑  test_sext_sext_cvt_2_ult_icmp_combined := by
  unfold test_sext_sext_cvt_2_ult_icmp_before test_sext_sext_cvt_2_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_zext_cvt_neg_2_ult_icmp_combined := [llvmfunc|
  llvm.func @test_sext_zext_cvt_neg_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_sext_zext_cvt_neg_2_ult_icmp   : test_sext_zext_cvt_neg_2_ult_icmp_before  ⊑  test_sext_zext_cvt_neg_2_ult_icmp_combined := by
  unfold test_sext_zext_cvt_neg_2_ult_icmp_before test_sext_zext_cvt_neg_2_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_zext_cvt_neg_1_ult_icmp_combined := [llvmfunc|
  llvm.func @test_sext_zext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_sext_zext_cvt_neg_1_ult_icmp   : test_sext_zext_cvt_neg_1_ult_icmp_before  ⊑  test_sext_zext_cvt_neg_1_ult_icmp_combined := by
  unfold test_sext_zext_cvt_neg_1_ult_icmp_before test_sext_zext_cvt_neg_1_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_zext_cvt_0_ult_icmp_combined := [llvmfunc|
  llvm.func @test_sext_zext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_zext_cvt_0_ult_icmp   : test_sext_zext_cvt_0_ult_icmp_before  ⊑  test_sext_zext_cvt_0_ult_icmp_combined := by
  unfold test_sext_zext_cvt_0_ult_icmp_before test_sext_zext_cvt_0_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_zext_cvt_2_ult_icmp_combined := [llvmfunc|
  llvm.func @test_sext_zext_cvt_2_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_sext_zext_cvt_2_ult_icmp   : test_sext_zext_cvt_2_ult_icmp_before  ⊑  test_sext_zext_cvt_2_ult_icmp_combined := by
  unfold test_sext_zext_cvt_2_ult_icmp_before test_sext_zext_cvt_2_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_neg_1_ult_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_neg_1_ult_icmp   : test_zext_sext_cvt_neg_1_ult_icmp_before  ⊑  test_zext_sext_cvt_neg_1_ult_icmp_combined := by
  unfold test_zext_sext_cvt_neg_1_ult_icmp_before test_zext_sext_cvt_neg_1_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_0_ult_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_0_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_0_ult_icmp   : test_zext_sext_cvt_0_ult_icmp_before  ⊑  test_zext_sext_cvt_0_ult_icmp_combined := by
  unfold test_zext_sext_cvt_0_ult_icmp_before test_zext_sext_cvt_0_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_1_ult_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_1_ult_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_1_ult_icmp   : test_zext_sext_cvt_1_ult_icmp_before  ⊑  test_zext_sext_cvt_1_ult_icmp_combined := by
  unfold test_zext_sext_cvt_1_ult_icmp_before test_zext_sext_cvt_1_ult_icmp_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp4_combined := [llvmfunc|
  llvm.func @test_cvt_icmp4(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp4   : test_cvt_icmp4_before  ⊑  test_cvt_icmp4_combined := by
  unfold test_cvt_icmp4_before test_cvt_icmp4_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_neg_2_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_neg_2_ugt_icmp   : test_zext_zext_cvt_neg_2_ugt_icmp_before  ⊑  test_zext_zext_cvt_neg_2_ugt_icmp_combined := by
  unfold test_zext_zext_cvt_neg_2_ugt_icmp_before test_zext_zext_cvt_neg_2_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_1_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_1_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_1_ugt_icmp   : test_zext_zext_cvt_1_ugt_icmp_before  ⊑  test_zext_zext_cvt_1_ugt_icmp_combined := by
  unfold test_zext_zext_cvt_1_ugt_icmp_before test_zext_zext_cvt_1_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_2_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_2_ugt_icmp   : test_zext_zext_cvt_2_ugt_icmp_before  ⊑  test_zext_zext_cvt_2_ugt_icmp_combined := by
  unfold test_zext_zext_cvt_2_ugt_icmp_before test_zext_zext_cvt_2_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_neg_2_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_neg_2_ugt_icmp   : test_sext_sext_cvt_neg_2_ugt_icmp_before  ⊑  test_sext_sext_cvt_neg_2_ugt_icmp_combined := by
  unfold test_sext_sext_cvt_neg_2_ugt_icmp_before test_sext_sext_cvt_neg_2_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_0_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_0_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_0_ugt_icmp   : test_sext_sext_cvt_0_ugt_icmp_before  ⊑  test_sext_sext_cvt_0_ugt_icmp_combined := by
  unfold test_sext_sext_cvt_0_ugt_icmp_before test_sext_sext_cvt_0_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_2_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_2_ugt_icmp   : test_sext_sext_cvt_2_ugt_icmp_before  ⊑  test_sext_sext_cvt_2_ugt_icmp_combined := by
  unfold test_sext_sext_cvt_2_ugt_icmp_before test_sext_sext_cvt_2_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_neg_2_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_neg_2_ugt_icmp   : test_zext_sext_cvt_neg_2_ugt_icmp_before  ⊑  test_zext_sext_cvt_neg_2_ugt_icmp_combined := by
  unfold test_zext_sext_cvt_neg_2_ugt_icmp_before test_zext_sext_cvt_neg_2_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_neg_1_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_1_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_neg_1_ugt_icmp   : test_zext_sext_cvt_neg_1_ugt_icmp_before  ⊑  test_zext_sext_cvt_neg_1_ugt_icmp_combined := by
  unfold test_zext_sext_cvt_neg_1_ugt_icmp_before test_zext_sext_cvt_neg_1_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_0_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_0_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_0_ugt_icmp   : test_zext_sext_cvt_0_ugt_icmp_before  ⊑  test_zext_sext_cvt_0_ugt_icmp_combined := by
  unfold test_zext_sext_cvt_0_ugt_icmp_before test_zext_sext_cvt_0_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_1_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_1_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_1_ugt_icmp   : test_zext_sext_cvt_1_ugt_icmp_before  ⊑  test_zext_sext_cvt_1_ugt_icmp_combined := by
  unfold test_zext_sext_cvt_1_ugt_icmp_before test_zext_sext_cvt_1_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_2_ugt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_2_ugt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_2_ugt_icmp   : test_zext_sext_cvt_2_ugt_icmp_before  ⊑  test_zext_sext_cvt_2_ugt_icmp_combined := by
  unfold test_zext_sext_cvt_2_ugt_icmp_before test_zext_sext_cvt_2_ugt_icmp_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp5_combined := [llvmfunc|
  llvm.func @test_cvt_icmp5(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp5   : test_cvt_icmp5_before  ⊑  test_cvt_icmp5_combined := by
  unfold test_cvt_icmp5_before test_cvt_icmp5_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp6_combined := [llvmfunc|
  llvm.func @test_cvt_icmp6(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp6   : test_cvt_icmp6_before  ⊑  test_cvt_icmp6_combined := by
  unfold test_cvt_icmp6_before test_cvt_icmp6_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp7_combined := [llvmfunc|
  llvm.func @test_cvt_icmp7(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.and %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp7   : test_cvt_icmp7_before  ⊑  test_cvt_icmp7_combined := by
  unfold test_cvt_icmp7_before test_cvt_icmp7_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_neg_2_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_neg_2_sgt_icmp   : test_zext_zext_cvt_neg_2_sgt_icmp_before  ⊑  test_zext_zext_cvt_neg_2_sgt_icmp_combined := by
  unfold test_zext_zext_cvt_neg_2_sgt_icmp_before test_zext_zext_cvt_neg_2_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_neg_1_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_1_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_neg_1_sgt_icmp   : test_zext_zext_cvt_neg_1_sgt_icmp_before  ⊑  test_zext_zext_cvt_neg_1_sgt_icmp_combined := by
  unfold test_zext_zext_cvt_neg_1_sgt_icmp_before test_zext_zext_cvt_neg_1_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_2_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_2_sgt_icmp   : test_zext_zext_cvt_2_sgt_icmp_before  ⊑  test_zext_zext_cvt_2_sgt_icmp_combined := by
  unfold test_zext_zext_cvt_2_sgt_icmp_before test_zext_zext_cvt_2_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_neg_2_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_neg_2_sgt_icmp   : test_sext_sext_cvt_neg_2_sgt_icmp_before  ⊑  test_sext_sext_cvt_neg_2_sgt_icmp_combined := by
  unfold test_sext_sext_cvt_neg_2_sgt_icmp_before test_sext_sext_cvt_neg_2_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_0_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_0_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_0_sgt_icmp   : test_sext_sext_cvt_0_sgt_icmp_before  ⊑  test_sext_sext_cvt_0_sgt_icmp_combined := by
  unfold test_sext_sext_cvt_0_sgt_icmp_before test_sext_sext_cvt_0_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_2_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_2_sgt_icmp   : test_sext_sext_cvt_2_sgt_icmp_before  ⊑  test_sext_sext_cvt_2_sgt_icmp_combined := by
  unfold test_sext_sext_cvt_2_sgt_icmp_before test_sext_sext_cvt_2_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_neg_2_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_neg_2_sgt_icmp   : test_zext_sext_cvt_neg_2_sgt_icmp_before  ⊑  test_zext_sext_cvt_neg_2_sgt_icmp_combined := by
  unfold test_zext_sext_cvt_neg_2_sgt_icmp_before test_zext_sext_cvt_neg_2_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_neg_1_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_1_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.or %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_neg_1_sgt_icmp   : test_zext_sext_cvt_neg_1_sgt_icmp_before  ⊑  test_zext_sext_cvt_neg_1_sgt_icmp_combined := by
  unfold test_zext_sext_cvt_neg_1_sgt_icmp_before test_zext_sext_cvt_neg_1_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_0_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_0_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_0_sgt_icmp   : test_zext_sext_cvt_0_sgt_icmp_before  ⊑  test_zext_sext_cvt_0_sgt_icmp_combined := by
  unfold test_zext_sext_cvt_0_sgt_icmp_before test_zext_sext_cvt_0_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_1_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_1_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_1_sgt_icmp   : test_zext_sext_cvt_1_sgt_icmp_before  ⊑  test_zext_sext_cvt_1_sgt_icmp_combined := by
  unfold test_zext_sext_cvt_1_sgt_icmp_before test_zext_sext_cvt_1_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_2_sgt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_2_sgt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_2_sgt_icmp   : test_zext_sext_cvt_2_sgt_icmp_before  ⊑  test_zext_sext_cvt_2_sgt_icmp_combined := by
  unfold test_zext_sext_cvt_2_sgt_icmp_before test_zext_sext_cvt_2_sgt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_neg_2_slt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_neg_2_slt_icmp   : test_zext_zext_cvt_neg_2_slt_icmp_before  ⊑  test_zext_zext_cvt_neg_2_slt_icmp_combined := by
  unfold test_zext_zext_cvt_neg_2_slt_icmp_before test_zext_zext_cvt_neg_2_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_neg_1_slt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_neg_1_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_neg_1_slt_icmp   : test_zext_zext_cvt_neg_1_slt_icmp_before  ⊑  test_zext_zext_cvt_neg_1_slt_icmp_combined := by
  unfold test_zext_zext_cvt_neg_1_slt_icmp_before test_zext_zext_cvt_neg_1_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_zext_cvt_2_slt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_zext_cvt_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_zext_cvt_2_slt_icmp   : test_zext_zext_cvt_2_slt_icmp_before  ⊑  test_zext_zext_cvt_2_slt_icmp_combined := by
  unfold test_zext_zext_cvt_2_slt_icmp_before test_zext_zext_cvt_2_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_neg_2_slt_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_neg_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_neg_2_slt_icmp   : test_sext_sext_cvt_neg_2_slt_icmp_before  ⊑  test_sext_sext_cvt_neg_2_slt_icmp_combined := by
  unfold test_sext_sext_cvt_neg_2_slt_icmp_before test_sext_sext_cvt_neg_2_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_0_slt_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_0_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_0_slt_icmp   : test_sext_sext_cvt_0_slt_icmp_before  ⊑  test_sext_sext_cvt_0_slt_icmp_combined := by
  unfold test_sext_sext_cvt_0_slt_icmp_before test_sext_sext_cvt_0_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_sext_sext_cvt_2_slt_icmp_combined := [llvmfunc|
  llvm.func @test_sext_sext_cvt_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_sext_sext_cvt_2_slt_icmp   : test_sext_sext_cvt_2_slt_icmp_before  ⊑  test_sext_sext_cvt_2_slt_icmp_combined := by
  unfold test_sext_sext_cvt_2_slt_icmp_before test_sext_sext_cvt_2_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_neg_2_slt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_neg_2_slt_icmp   : test_zext_sext_cvt_neg_2_slt_icmp_before  ⊑  test_zext_sext_cvt_neg_2_slt_icmp_combined := by
  unfold test_zext_sext_cvt_neg_2_slt_icmp_before test_zext_sext_cvt_neg_2_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_neg_1_slt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_neg_1_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_neg_1_slt_icmp   : test_zext_sext_cvt_neg_1_slt_icmp_before  ⊑  test_zext_sext_cvt_neg_1_slt_icmp_combined := by
  unfold test_zext_sext_cvt_neg_1_slt_icmp_before test_zext_sext_cvt_neg_1_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_0_slt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_0_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.and %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_0_slt_icmp   : test_zext_sext_cvt_0_slt_icmp_before  ⊑  test_zext_sext_cvt_0_slt_icmp_combined := by
  unfold test_zext_sext_cvt_0_slt_icmp_before test_zext_sext_cvt_0_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_1_slt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_1_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_1_slt_icmp   : test_zext_sext_cvt_1_slt_icmp_before  ⊑  test_zext_sext_cvt_1_slt_icmp_combined := by
  unfold test_zext_sext_cvt_1_slt_icmp_before test_zext_sext_cvt_1_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_zext_sext_cvt_2_slt_icmp_combined := [llvmfunc|
  llvm.func @test_zext_sext_cvt_2_slt_icmp(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_zext_sext_cvt_2_slt_icmp   : test_zext_sext_cvt_2_slt_icmp_before  ⊑  test_zext_sext_cvt_2_slt_icmp_combined := by
  unfold test_zext_sext_cvt_2_slt_icmp_before test_zext_sext_cvt_2_slt_icmp_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp8_combined := [llvmfunc|
  llvm.func @test_cvt_icmp8(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp8   : test_cvt_icmp8_before  ⊑  test_cvt_icmp8_combined := by
  unfold test_cvt_icmp8_before test_cvt_icmp8_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp9_combined := [llvmfunc|
  llvm.func @test_cvt_icmp9(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp9   : test_cvt_icmp9_before  ⊑  test_cvt_icmp9_combined := by
  unfold test_cvt_icmp9_before test_cvt_icmp9_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp10_combined := [llvmfunc|
  llvm.func @test_cvt_icmp10(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp10   : test_cvt_icmp10_before  ⊑  test_cvt_icmp10_combined := by
  unfold test_cvt_icmp10_before test_cvt_icmp10_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp11_combined := [llvmfunc|
  llvm.func @test_cvt_icmp11(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp11   : test_cvt_icmp11_before  ⊑  test_cvt_icmp11_combined := by
  unfold test_cvt_icmp11_before test_cvt_icmp11_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp12_combined := [llvmfunc|
  llvm.func @test_cvt_icmp12(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp12   : test_cvt_icmp12_before  ⊑  test_cvt_icmp12_combined := by
  unfold test_cvt_icmp12_before test_cvt_icmp12_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp13_combined := [llvmfunc|
  llvm.func @test_cvt_icmp13(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp13   : test_cvt_icmp13_before  ⊑  test_cvt_icmp13_combined := by
  unfold test_cvt_icmp13_before test_cvt_icmp13_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp14_combined := [llvmfunc|
  llvm.func @test_cvt_icmp14(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg1, %arg0  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp14   : test_cvt_icmp14_before  ⊑  test_cvt_icmp14_combined := by
  unfold test_cvt_icmp14_before test_cvt_icmp14_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp15_combined := [llvmfunc|
  llvm.func @test_cvt_icmp15(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp15   : test_cvt_icmp15_before  ⊑  test_cvt_icmp15_combined := by
  unfold test_cvt_icmp15_before test_cvt_icmp15_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp16_combined := [llvmfunc|
  llvm.func @test_cvt_icmp16(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp16   : test_cvt_icmp16_before  ⊑  test_cvt_icmp16_combined := by
  unfold test_cvt_icmp16_before test_cvt_icmp16_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp17_combined := [llvmfunc|
  llvm.func @test_cvt_icmp17(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp17   : test_cvt_icmp17_before  ⊑  test_cvt_icmp17_combined := by
  unfold test_cvt_icmp17_before test_cvt_icmp17_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp18_combined := [llvmfunc|
  llvm.func @test_cvt_icmp18(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp18   : test_cvt_icmp18_before  ⊑  test_cvt_icmp18_combined := by
  unfold test_cvt_icmp18_before test_cvt_icmp18_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp19_combined := [llvmfunc|
  llvm.func @test_cvt_icmp19(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp19   : test_cvt_icmp19_before  ⊑  test_cvt_icmp19_combined := by
  unfold test_cvt_icmp19_before test_cvt_icmp19_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp20_combined := [llvmfunc|
  llvm.func @test_cvt_icmp20(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.xor %arg1, %arg0  : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp20   : test_cvt_icmp20_before  ⊑  test_cvt_icmp20_combined := by
  unfold test_cvt_icmp20_before test_cvt_icmp20_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp21_combined := [llvmfunc|
  llvm.func @test_cvt_icmp21(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp21   : test_cvt_icmp21_before  ⊑  test_cvt_icmp21_combined := by
  unfold test_cvt_icmp21_before test_cvt_icmp21_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp22_combined := [llvmfunc|
  llvm.func @test_cvt_icmp22(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp22   : test_cvt_icmp22_before  ⊑  test_cvt_icmp22_combined := by
  unfold test_cvt_icmp22_before test_cvt_icmp22_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp23_combined := [llvmfunc|
  llvm.func @test_cvt_icmp23(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp23   : test_cvt_icmp23_before  ⊑  test_cvt_icmp23_combined := by
  unfold test_cvt_icmp23_before test_cvt_icmp23_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp24_combined := [llvmfunc|
  llvm.func @test_cvt_icmp24(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.or %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp24   : test_cvt_icmp24_before  ⊑  test_cvt_icmp24_combined := by
  unfold test_cvt_icmp24_before test_cvt_icmp24_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp25_combined := [llvmfunc|
  llvm.func @test_cvt_icmp25(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg1, %0  : i1
    %2 = llvm.and %1, %arg0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_test_cvt_icmp25   : test_cvt_icmp25_before  ⊑  test_cvt_icmp25_combined := by
  unfold test_cvt_icmp25_before test_cvt_icmp25_combined
  simp_alive_peephole
  sorry
def test_cvt_icmp26_combined := [llvmfunc|
  llvm.func @test_cvt_icmp26(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_cvt_icmp26   : test_cvt_icmp26_before  ⊑  test_cvt_icmp26_combined := by
  unfold test_cvt_icmp26_before test_cvt_icmp26_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1vec_combined := [llvmfunc|
  llvm.func @test1vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test1vec   : test1vec_before  ⊑  test1vec_combined := by
  unfold test1vec_before test1vec_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2vec_combined := [llvmfunc|
  llvm.func @test2vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test2vec   : test2vec_before  ⊑  test2vec_combined := by
  unfold test2vec_before test2vec_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483643 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3vec_combined := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2147483643> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test3vec   : test3vec_before  ⊑  test3vec_combined := by
  unfold test3vec_before test3vec_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test4multiuse(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @test4multiuse(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(-2147483644 : i32) : i32
    %1 = llvm.mlir.constant(2147483640 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<(i32, i1)>
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.insertvalue %3, %2[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.insertvalue %4, %5[1] : !llvm.struct<(i32, i1)> 
    llvm.return %6 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_test4multiuse(%arg0: i32) -> !llvm.struct<   : test4multiuse(%arg0: i32) -> !llvm.struct<_before  ⊑  test4multiuse(%arg0: i32) -> !llvm.struct<_combined := by
  unfold test4multiuse(%arg0: i32) -> !llvm.struct<_before test4multiuse(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def test4vec_combined := [llvmfunc|
  llvm.func @test4vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test4vec   : test4vec_before  ⊑  test4vec_combined := by
  unfold test4vec_before test4vec_combined
  simp_alive_peephole
  sorry
def nsw_slt1_combined := [llvmfunc|
  llvm.func @nsw_slt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nsw_slt1   : nsw_slt1_before  ⊑  nsw_slt1_combined := by
  unfold nsw_slt1_before nsw_slt1_combined
  simp_alive_peephole
  sorry
def nsw_slt1_splat_vec_combined := [llvmfunc|
  llvm.func @nsw_slt1_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_nsw_slt1_splat_vec   : nsw_slt1_splat_vec_before  ⊑  nsw_slt1_splat_vec_combined := by
  unfold nsw_slt1_splat_vec_before nsw_slt1_splat_vec_combined
  simp_alive_peephole
  sorry
def nsw_slt2_combined := [llvmfunc|
  llvm.func @nsw_slt2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nsw_slt2   : nsw_slt2_before  ⊑  nsw_slt2_combined := by
  unfold nsw_slt2_before nsw_slt2_combined
  simp_alive_peephole
  sorry
def nsw_slt2_splat_vec_combined := [llvmfunc|
  llvm.func @nsw_slt2_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_nsw_slt2_splat_vec   : nsw_slt2_splat_vec_before  ⊑  nsw_slt2_splat_vec_combined := by
  unfold nsw_slt2_splat_vec_before nsw_slt2_splat_vec_combined
  simp_alive_peephole
  sorry
def nsw_slt3_combined := [llvmfunc|
  llvm.func @nsw_slt3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-126 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nsw_slt3   : nsw_slt3_before  ⊑  nsw_slt3_combined := by
  unfold nsw_slt3_before nsw_slt3_combined
  simp_alive_peephole
  sorry
def nsw_slt4_combined := [llvmfunc|
  llvm.func @nsw_slt4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nsw_slt4   : nsw_slt4_before  ⊑  nsw_slt4_combined := by
  unfold nsw_slt4_before nsw_slt4_combined
  simp_alive_peephole
  sorry
def nsw_sgt1_combined := [llvmfunc|
  llvm.func @nsw_sgt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nsw_sgt1   : nsw_sgt1_before  ⊑  nsw_sgt1_combined := by
  unfold nsw_sgt1_before nsw_sgt1_combined
  simp_alive_peephole
  sorry
def nsw_sgt1_splat_vec_combined := [llvmfunc|
  llvm.func @nsw_sgt1_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_nsw_sgt1_splat_vec   : nsw_sgt1_splat_vec_before  ⊑  nsw_sgt1_splat_vec_combined := by
  unfold nsw_sgt1_splat_vec_before nsw_sgt1_splat_vec_combined
  simp_alive_peephole
  sorry
def nsw_sgt2_combined := [llvmfunc|
  llvm.func @nsw_sgt2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-126 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nsw_sgt2   : nsw_sgt2_before  ⊑  nsw_sgt2_combined := by
  unfold nsw_sgt2_before nsw_sgt2_combined
  simp_alive_peephole
  sorry
def nsw_sgt2_splat_vec_combined := [llvmfunc|
  llvm.func @nsw_sgt2_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-126> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_nsw_sgt2_splat_vec   : nsw_sgt2_splat_vec_before  ⊑  nsw_sgt2_splat_vec_combined := by
  unfold nsw_sgt2_splat_vec_before nsw_sgt2_splat_vec_combined
  simp_alive_peephole
  sorry
def slt_zero_add_nsw_combined := [llvmfunc|
  llvm.func @slt_zero_add_nsw(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_zero_add_nsw   : slt_zero_add_nsw_before  ⊑  slt_zero_add_nsw_combined := by
  unfold slt_zero_add_nsw_before slt_zero_add_nsw_combined
  simp_alive_peephole
  sorry
def slt_zero_add_nsw_splat_vec_combined := [llvmfunc|
  llvm.func @slt_zero_add_nsw_splat_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_slt_zero_add_nsw_splat_vec   : slt_zero_add_nsw_splat_vec_before  ⊑  slt_zero_add_nsw_splat_vec_combined := by
  unfold slt_zero_add_nsw_splat_vec_before slt_zero_add_nsw_splat_vec_combined
  simp_alive_peephole
  sorry
def nsw_slt3_ov_no_combined := [llvmfunc|
  llvm.func @nsw_slt3_ov_no(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nsw_slt3_ov_no   : nsw_slt3_ov_no_before  ⊑  nsw_slt3_ov_no_combined := by
  unfold nsw_slt3_ov_no_before nsw_slt3_ov_no_combined
  simp_alive_peephole
  sorry
def nsw_slt4_ov_combined := [llvmfunc|
  llvm.func @nsw_slt4_ov(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nsw_slt4_ov   : nsw_slt4_ov_before  ⊑  nsw_slt4_ov_combined := by
  unfold nsw_slt4_ov_before nsw_slt4_ov_combined
  simp_alive_peephole
  sorry
def nsw_slt5_ov_combined := [llvmfunc|
  llvm.func @nsw_slt5_ov(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nsw_slt5_ov   : nsw_slt5_ov_before  ⊑  nsw_slt5_ov_combined := by
  unfold nsw_slt5_ov_before nsw_slt5_ov_combined
  simp_alive_peephole
  sorry
def slt_zero_add_nsw_signbit_combined := [llvmfunc|
  llvm.func @slt_zero_add_nsw_signbit(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_zero_add_nsw_signbit   : slt_zero_add_nsw_signbit_before  ⊑  slt_zero_add_nsw_signbit_combined := by
  unfold slt_zero_add_nsw_signbit_before slt_zero_add_nsw_signbit_combined
  simp_alive_peephole
  sorry
def slt_zero_add_nuw_signbit_combined := [llvmfunc|
  llvm.func @slt_zero_add_nuw_signbit(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_zero_add_nuw_signbit   : slt_zero_add_nuw_signbit_before  ⊑  slt_zero_add_nuw_signbit_combined := by
  unfold slt_zero_add_nuw_signbit_before slt_zero_add_nuw_signbit_combined
  simp_alive_peephole
  sorry
def reduce_add_ult_combined := [llvmfunc|
  llvm.func @reduce_add_ult(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_reduce_add_ult   : reduce_add_ult_before  ⊑  reduce_add_ult_combined := by
  unfold reduce_add_ult_before reduce_add_ult_combined
  simp_alive_peephole
  sorry
def reduce_add_ugt_combined := [llvmfunc|
  llvm.func @reduce_add_ugt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_reduce_add_ugt   : reduce_add_ugt_before  ⊑  reduce_add_ugt_combined := by
  unfold reduce_add_ugt_before reduce_add_ugt_combined
  simp_alive_peephole
  sorry
def reduce_add_ule_combined := [llvmfunc|
  llvm.func @reduce_add_ule(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_reduce_add_ule   : reduce_add_ule_before  ⊑  reduce_add_ule_combined := by
  unfold reduce_add_ule_before reduce_add_ule_combined
  simp_alive_peephole
  sorry
def reduce_add_uge_combined := [llvmfunc|
  llvm.func @reduce_add_uge(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_reduce_add_uge   : reduce_add_uge_before  ⊑  reduce_add_uge_combined := by
  unfold reduce_add_uge_before reduce_add_uge_combined
  simp_alive_peephole
  sorry
def ult_add_ssubov_combined := [llvmfunc|
  llvm.func @ult_add_ssubov(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_add_ssubov   : ult_add_ssubov_before  ⊑  ult_add_ssubov_combined := by
  unfold ult_add_ssubov_before ult_add_ssubov_combined
  simp_alive_peephole
  sorry
def ult_add_nonuw_combined := [llvmfunc|
  llvm.func @ult_add_nonuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(71 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ult_add_nonuw   : ult_add_nonuw_before  ⊑  ult_add_nonuw_combined := by
  unfold ult_add_nonuw_before ult_add_nonuw_combined
  simp_alive_peephole
  sorry
def uge_add_nonuw_combined := [llvmfunc|
  llvm.func @uge_add_nonuw(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-9 : i32) : i32
    %1 = llvm.mlir.constant(-12 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_uge_add_nonuw   : uge_add_nonuw_before  ⊑  uge_add_nonuw_combined := by
  unfold uge_add_nonuw_before uge_add_nonuw_combined
  simp_alive_peephole
  sorry
def op_ugt_sum_commute1_combined := [llvmfunc|
  llvm.func @op_ugt_sum_commute1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sdiv %0, %arg0  : i8
    %3 = llvm.sdiv %0, %arg1  : i8
    %4 = llvm.xor %2, %1  : i8
    %5 = llvm.icmp "ugt" %3, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_op_ugt_sum_commute1   : op_ugt_sum_commute1_before  ⊑  op_ugt_sum_commute1_combined := by
  unfold op_ugt_sum_commute1_before op_ugt_sum_commute1_combined
  simp_alive_peephole
  sorry
def op_ugt_sum_vec_commute2_combined := [llvmfunc|
  llvm.func @op_ugt_sum_vec_commute2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %3 = llvm.sdiv %0, %arg1  : vector<2xi8>
    %4 = llvm.xor %2, %1  : vector<2xi8>
    %5 = llvm.icmp "ugt" %3, %4 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_op_ugt_sum_vec_commute2   : op_ugt_sum_vec_commute2_before  ⊑  op_ugt_sum_vec_commute2_combined := by
  unfold op_ugt_sum_vec_commute2_before op_ugt_sum_vec_commute2_combined
  simp_alive_peephole
  sorry
def sum_ugt_op_uses_combined := [llvmfunc|
  llvm.func @sum_ugt_op_uses(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg0  : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.add %1, %2 overflow<nsw>  : i8
    llvm.store %3, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_sum_ugt_op_uses   : sum_ugt_op_uses_before  ⊑  sum_ugt_op_uses_combined := by
  unfold sum_ugt_op_uses_before sum_ugt_op_uses_combined
  simp_alive_peephole
  sorry
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_sum_ugt_op_uses   : sum_ugt_op_uses_before  ⊑  sum_ugt_op_uses_combined := by
  unfold sum_ugt_op_uses_before sum_ugt_op_uses_combined
  simp_alive_peephole
  sorry
def sum_ult_op_vec_commute1_combined := [llvmfunc|
  llvm.func @sum_ult_op_vec_commute1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[42, -42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-42, 42]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %4 = llvm.sdiv %1, %arg1  : vector<2xi8>
    %5 = llvm.xor %3, %2  : vector<2xi8>
    %6 = llvm.icmp "ugt" %4, %5 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_sum_ult_op_vec_commute1   : sum_ult_op_vec_commute1_before  ⊑  sum_ult_op_vec_commute1_combined := by
  unfold sum_ult_op_vec_commute1_before sum_ult_op_vec_commute1_combined
  simp_alive_peephole
  sorry
def sum_ult_op_commute2_combined := [llvmfunc|
  llvm.func @sum_ult_op_commute2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sdiv %0, %arg0  : i8
    %3 = llvm.sdiv %0, %arg1  : i8
    %4 = llvm.xor %2, %1  : i8
    %5 = llvm.icmp "ugt" %3, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_sum_ult_op_commute2   : sum_ult_op_commute2_before  ⊑  sum_ult_op_commute2_combined := by
  unfold sum_ult_op_commute2_before sum_ult_op_commute2_combined
  simp_alive_peephole
  sorry
def sum_ult_op_uses_combined := [llvmfunc|
  llvm.func @sum_ult_op_uses(%arg0: i8, %arg1: i8, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.add %arg1, %arg0  : i8
    llvm.store %0, %arg2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_sum_ult_op_uses   : sum_ult_op_uses_before  ⊑  sum_ult_op_uses_combined := by
  unfold sum_ult_op_uses_before sum_ult_op_uses_combined
  simp_alive_peephole
  sorry
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sum_ult_op_uses   : sum_ult_op_uses_before  ⊑  sum_ult_op_uses_combined := by
  unfold sum_ult_op_uses_before sum_ult_op_uses_combined
  simp_alive_peephole
  sorry
def common_op_nsw_combined := [llvmfunc|
  llvm.func @common_op_nsw(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_common_op_nsw   : common_op_nsw_before  ⊑  common_op_nsw_combined := by
  unfold common_op_nsw_before common_op_nsw_combined
  simp_alive_peephole
  sorry
def common_op_nsw_extra_uses_combined := [llvmfunc|
  llvm.func @common_op_nsw_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nsw>  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.add %arg1, %arg2 overflow<nsw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_common_op_nsw_extra_uses   : common_op_nsw_extra_uses_before  ⊑  common_op_nsw_extra_uses_combined := by
  unfold common_op_nsw_extra_uses_before common_op_nsw_extra_uses_combined
  simp_alive_peephole
  sorry
def common_op_nuw_combined := [llvmfunc|
  llvm.func @common_op_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_common_op_nuw   : common_op_nuw_before  ⊑  common_op_nuw_combined := by
  unfold common_op_nuw_before common_op_nuw_combined
  simp_alive_peephole
  sorry
def common_op_nuw_extra_uses_combined := [llvmfunc|
  llvm.func @common_op_nuw_extra_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.add %arg0, %arg2 overflow<nuw>  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.add %arg2, %arg1 overflow<nuw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_common_op_nuw_extra_uses   : common_op_nuw_extra_uses_before  ⊑  common_op_nuw_extra_uses_combined := by
  unfold common_op_nuw_extra_uses_before common_op_nuw_extra_uses_combined
  simp_alive_peephole
  sorry
def common_op_nsw_commute_combined := [llvmfunc|
  llvm.func @common_op_nsw_commute(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_common_op_nsw_commute   : common_op_nsw_commute_before  ⊑  common_op_nsw_commute_combined := by
  unfold common_op_nsw_commute_before common_op_nsw_commute_combined
  simp_alive_peephole
  sorry
def common_op_nuw_commute_combined := [llvmfunc|
  llvm.func @common_op_nuw_commute(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_common_op_nuw_commute   : common_op_nuw_commute_before  ⊑  common_op_nuw_commute_combined := by
  unfold common_op_nuw_commute_before common_op_nuw_commute_combined
  simp_alive_peephole
  sorry
def common_op_test29_combined := [llvmfunc|
  llvm.func @common_op_test29(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg1, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_common_op_test29   : common_op_test29_before  ⊑  common_op_test29_combined := by
  unfold common_op_test29_before common_op_test29_combined
  simp_alive_peephole
  sorry
def sum_nuw_combined := [llvmfunc|
  llvm.func @sum_nuw(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg1, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_sum_nuw   : sum_nuw_before  ⊑  sum_nuw_combined := by
  unfold sum_nuw_before sum_nuw_combined
  simp_alive_peephole
  sorry
def sum_nsw_commute_combined := [llvmfunc|
  llvm.func @sum_nsw_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg1, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_sum_nsw_commute   : sum_nsw_commute_before  ⊑  sum_nsw_commute_combined := by
  unfold sum_nsw_commute_before sum_nsw_commute_combined
  simp_alive_peephole
  sorry
def sum_nuw_commute_combined := [llvmfunc|
  llvm.func @sum_nuw_commute(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sum_nuw_commute   : sum_nuw_commute_before  ⊑  sum_nuw_commute_combined := by
  unfold sum_nuw_commute_before sum_nuw_commute_combined
  simp_alive_peephole
  sorry
def bzip1_combined := [llvmfunc|
  llvm.func @bzip1(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.call @use1(%0) : (i1) -> ()
    llvm.return
  }]

theorem inst_combine_bzip1   : bzip1_before  ⊑  bzip1_combined := by
  unfold bzip1_before bzip1_combined
  simp_alive_peephole
  sorry
def bzip2_combined := [llvmfunc|
  llvm.func @bzip2(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.add %arg0, %arg2  : i8
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.call @use1(%1) : (i1) -> ()
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return
  }]

theorem inst_combine_bzip2   : bzip2_before  ⊑  bzip2_combined := by
  unfold bzip2_before bzip2_combined
  simp_alive_peephole
  sorry
def icmp_eq_add_undef_combined := [llvmfunc|
  llvm.func @icmp_eq_add_undef(%arg0: vector<2xi32>) -> vector<2xi1> {
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

theorem inst_combine_icmp_eq_add_undef   : icmp_eq_add_undef_before  ⊑  icmp_eq_add_undef_combined := by
  unfold icmp_eq_add_undef_before icmp_eq_add_undef_combined
  simp_alive_peephole
  sorry
def icmp_eq_add_non_splat_combined := [llvmfunc|
  llvm.func @icmp_eq_add_non_splat(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[5, 4]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_add_non_splat   : icmp_eq_add_non_splat_before  ⊑  icmp_eq_add_non_splat_combined := by
  unfold icmp_eq_add_non_splat_before icmp_eq_add_non_splat_combined
  simp_alive_peephole
  sorry
def icmp_eq_add_undef2_combined := [llvmfunc|
  llvm.func @icmp_eq_add_undef2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(10 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.add %arg0, %0  : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %7 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_add_undef2   : icmp_eq_add_undef2_before  ⊑  icmp_eq_add_undef2_combined := by
  unfold icmp_eq_add_undef2_before icmp_eq_add_undef2_combined
  simp_alive_peephole
  sorry
def icmp_eq_add_non_splat2_combined := [llvmfunc|
  llvm.func @icmp_eq_add_non_splat2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[10, 11]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_add_non_splat2   : icmp_eq_add_non_splat2_before  ⊑  icmp_eq_add_non_splat2_combined := by
  unfold icmp_eq_add_non_splat2_before icmp_eq_add_non_splat2_combined
  simp_alive_peephole
  sorry
def without_nsw_nuw_combined := [llvmfunc|
  llvm.func @without_nsw_nuw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_without_nsw_nuw   : without_nsw_nuw_before  ⊑  without_nsw_nuw_combined := by
  unfold without_nsw_nuw_before without_nsw_nuw_combined
  simp_alive_peephole
  sorry
def with_nsw_nuw_combined := [llvmfunc|
  llvm.func @with_nsw_nuw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_with_nsw_nuw   : with_nsw_nuw_before  ⊑  with_nsw_nuw_combined := by
  unfold with_nsw_nuw_before with_nsw_nuw_combined
  simp_alive_peephole
  sorry
def with_nsw_large_combined := [llvmfunc|
  llvm.func @with_nsw_large(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_with_nsw_large   : with_nsw_large_before  ⊑  with_nsw_large_combined := by
  unfold with_nsw_large_before with_nsw_large_combined
  simp_alive_peephole
  sorry
def with_nsw_small_combined := [llvmfunc|
  llvm.func @with_nsw_small(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.add %arg1, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_with_nsw_small   : with_nsw_small_before  ⊑  with_nsw_small_combined := by
  unfold with_nsw_small_before with_nsw_small_combined
  simp_alive_peephole
  sorry
def with_nuw_large_combined := [llvmfunc|
  llvm.func @with_nuw_large(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_with_nuw_large   : with_nuw_large_before  ⊑  with_nuw_large_combined := by
  unfold with_nuw_large_before with_nuw_large_combined
  simp_alive_peephole
  sorry
def with_nuw_small_combined := [llvmfunc|
  llvm.func @with_nuw_small(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.add %arg1, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_with_nuw_small   : with_nuw_small_before  ⊑  with_nuw_small_combined := by
  unfold with_nuw_small_before with_nuw_small_combined
  simp_alive_peephole
  sorry
def with_nuw_large_negative_combined := [llvmfunc|
  llvm.func @with_nuw_large_negative(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_with_nuw_large_negative   : with_nuw_large_negative_before  ⊑  with_nuw_large_negative_combined := by
  unfold with_nuw_large_negative_before with_nuw_large_negative_combined
  simp_alive_peephole
  sorry
def ugt_offset_combined := [llvmfunc|
  llvm.func @ugt_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-124 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_offset   : ugt_offset_before  ⊑  ugt_offset_combined := by
  unfold ugt_offset_before ugt_offset_combined
  simp_alive_peephole
  sorry
def ugt_offset_use_combined := [llvmfunc|
  llvm.func @ugt_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-42 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_ugt_offset_use   : ugt_offset_use_before  ⊑  ugt_offset_use_combined := by
  unfold ugt_offset_use_before ugt_offset_use_combined
  simp_alive_peephole
  sorry
def ugt_offset_splat_combined := [llvmfunc|
  llvm.func @ugt_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-9 : i5) : i5
    %1 = llvm.mlir.constant(dense<-9> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ugt_offset_splat   : ugt_offset_splat_before  ⊑  ugt_offset_splat_combined := by
  unfold ugt_offset_splat_before ugt_offset_splat_combined
  simp_alive_peephole
  sorry
def ugt_wrong_offset_combined := [llvmfunc|
  llvm.func @ugt_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ugt_wrong_offset   : ugt_wrong_offset_before  ⊑  ugt_wrong_offset_combined := by
  unfold ugt_wrong_offset_before ugt_wrong_offset_combined
  simp_alive_peephole
  sorry
def ugt_offset_nuw_combined := [llvmfunc|
  llvm.func @ugt_offset_nuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_offset_nuw   : ugt_offset_nuw_before  ⊑  ugt_offset_nuw_combined := by
  unfold ugt_offset_nuw_before ugt_offset_nuw_combined
  simp_alive_peephole
  sorry
def ult_offset_combined := [llvmfunc|
  llvm.func @ult_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_offset   : ult_offset_before  ⊑  ult_offset_combined := by
  unfold ult_offset_before ult_offset_combined
  simp_alive_peephole
  sorry
def ult_offset_use_combined := [llvmfunc|
  llvm.func @ult_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-43 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_ult_offset_use   : ult_offset_use_before  ⊑  ult_offset_use_combined := by
  unfold ult_offset_use_before ult_offset_use_combined
  simp_alive_peephole
  sorry
def ult_offset_splat_combined := [llvmfunc|
  llvm.func @ult_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-10 : i5) : i5
    %1 = llvm.mlir.constant(dense<-10> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.icmp "sgt" %arg0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ult_offset_splat   : ult_offset_splat_before  ⊑  ult_offset_splat_combined := by
  unfold ult_offset_splat_before ult_offset_splat_combined
  simp_alive_peephole
  sorry
def ult_wrong_offset_combined := [llvmfunc|
  llvm.func @ult_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ult_wrong_offset   : ult_wrong_offset_before  ⊑  ult_wrong_offset_combined := by
  unfold ult_wrong_offset_before ult_wrong_offset_combined
  simp_alive_peephole
  sorry
def ult_offset_nuw_combined := [llvmfunc|
  llvm.func @ult_offset_nuw(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_offset_nuw   : ult_offset_nuw_before  ⊑  ult_offset_nuw_combined := by
  unfold ult_offset_nuw_before ult_offset_nuw_combined
  simp_alive_peephole
  sorry
def sgt_offset_combined := [llvmfunc|
  llvm.func @sgt_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-122 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_offset   : sgt_offset_before  ⊑  sgt_offset_combined := by
  unfold sgt_offset_before sgt_offset_combined
  simp_alive_peephole
  sorry
def sgt_offset_use_combined := [llvmfunc|
  llvm.func @sgt_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(2147483606 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_offset_use   : sgt_offset_use_before  ⊑  sgt_offset_use_combined := by
  unfold sgt_offset_use_before sgt_offset_use_combined
  simp_alive_peephole
  sorry
def sgt_offset_splat_combined := [llvmfunc|
  llvm.func @sgt_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(7 : i5) : i5
    %1 = llvm.mlir.constant(dense<7> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.icmp "ult" %arg0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_sgt_offset_splat   : sgt_offset_splat_before  ⊑  sgt_offset_splat_combined := by
  unfold sgt_offset_splat_before sgt_offset_splat_combined
  simp_alive_peephole
  sorry
def sgt_wrong_offset_combined := [llvmfunc|
  llvm.func @sgt_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_sgt_wrong_offset   : sgt_wrong_offset_before  ⊑  sgt_wrong_offset_combined := by
  unfold sgt_wrong_offset_before sgt_wrong_offset_combined
  simp_alive_peephole
  sorry
def sgt_offset_nsw_combined := [llvmfunc|
  llvm.func @sgt_offset_nsw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_offset_nsw   : sgt_offset_nsw_before  ⊑  sgt_offset_nsw_combined := by
  unfold sgt_offset_nsw_before sgt_offset_nsw_combined
  simp_alive_peephole
  sorry
def slt_offset_combined := [llvmfunc|
  llvm.func @slt_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-123 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_offset   : slt_offset_before  ⊑  slt_offset_combined := by
  unfold slt_offset_before slt_offset_combined
  simp_alive_peephole
  sorry
def slt_offset_use_combined := [llvmfunc|
  llvm.func @slt_offset_use(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(2147483605 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_offset_use   : slt_offset_use_before  ⊑  slt_offset_use_combined := by
  unfold slt_offset_use_before slt_offset_use_combined
  simp_alive_peephole
  sorry
def slt_offset_splat_combined := [llvmfunc|
  llvm.func @slt_offset_splat(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(6 : i5) : i5
    %1 = llvm.mlir.constant(dense<6> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.icmp "ugt" %arg0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_slt_offset_splat   : slt_offset_splat_before  ⊑  slt_offset_splat_combined := by
  unfold slt_offset_splat_before slt_offset_splat_combined
  simp_alive_peephole
  sorry
def slt_wrong_offset_combined := [llvmfunc|
  llvm.func @slt_wrong_offset(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.mlir.constant(-7 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_wrong_offset   : slt_wrong_offset_before  ⊑  slt_wrong_offset_combined := by
  unfold slt_wrong_offset_before slt_wrong_offset_combined
  simp_alive_peephole
  sorry
def slt_offset_nsw_combined := [llvmfunc|
  llvm.func @slt_offset_nsw(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_offset_nsw   : slt_offset_nsw_before  ⊑  slt_offset_nsw_combined := by
  unfold slt_offset_nsw_before slt_offset_nsw_combined
  simp_alive_peephole
  sorry
def increment_max_combined := [llvmfunc|
  llvm.func @increment_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_increment_max   : increment_max_before  ⊑  increment_max_combined := by
  unfold increment_max_before increment_max_combined
  simp_alive_peephole
  sorry
def decrement_max_combined := [llvmfunc|
  llvm.func @decrement_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_decrement_max   : decrement_max_before  ⊑  decrement_max_combined := by
  unfold decrement_max_before decrement_max_combined
  simp_alive_peephole
  sorry
def increment_min_combined := [llvmfunc|
  llvm.func @increment_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_increment_min   : increment_min_before  ⊑  increment_min_combined := by
  unfold increment_min_before increment_min_combined
  simp_alive_peephole
  sorry
def decrement_min_combined := [llvmfunc|
  llvm.func @decrement_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_decrement_min   : decrement_min_before  ⊑  decrement_min_combined := by
  unfold decrement_min_before decrement_min_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_combined := [llvmfunc|
  llvm.func @icmp_add_add_C(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_add_add_C   : icmp_add_add_C_before  ⊑  icmp_add_add_C_combined := by
  unfold icmp_add_add_C_before icmp_add_add_C_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_pred_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.icmp "uge" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_add_add_C_pred   : icmp_add_add_C_pred_before  ⊑  icmp_add_add_C_pred_combined := by
  unfold icmp_add_add_C_pred_before icmp_add_add_C_pred_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_wrong_pred_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_wrong_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ule" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_add_add_C_wrong_pred   : icmp_add_add_C_wrong_pred_before  ⊑  icmp_add_add_C_wrong_pred_combined := by
  unfold icmp_add_add_C_wrong_pred_before icmp_add_add_C_wrong_pred_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_wrong_operand_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_wrong_operand(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.icmp "ult" %2, %arg2 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_add_add_C_wrong_operand   : icmp_add_add_C_wrong_operand_before  ⊑  icmp_add_add_C_wrong_operand_combined := by
  unfold icmp_add_add_C_wrong_operand_before icmp_add_add_C_wrong_operand_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_different_const_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_different_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-43 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_add_add_C_different_const   : icmp_add_add_C_different_const_before  ⊑  icmp_add_add_C_different_const_combined := by
  unfold icmp_add_add_C_different_const_before icmp_add_add_C_different_const_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_vector_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-11, -21]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sub %0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_icmp_add_add_C_vector   : icmp_add_add_C_vector_before  ⊑  icmp_add_add_C_vector_combined := by
  unfold icmp_add_add_C_vector_before icmp_add_add_C_vector_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_vector_undef_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_vector_undef(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(-11 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sub %6, %arg1  : vector<2xi8>
    %8 = llvm.icmp "ult" %7, %arg0 : vector<2xi8>
    llvm.return %8 : vector<2xi1>
  }]

theorem inst_combine_icmp_add_add_C_vector_undef   : icmp_add_add_C_vector_undef_before  ⊑  icmp_add_add_C_vector_undef_combined := by
  unfold icmp_add_add_C_vector_undef_before icmp_add_add_C_vector_undef_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_comm1_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_comm1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.icmp "ult" %1, %arg0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_add_add_C_comm1   : icmp_add_add_C_comm1_before  ⊑  icmp_add_add_C_comm1_combined := by
  unfold icmp_add_add_C_comm1_before icmp_add_add_C_comm1_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_comm2_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_comm2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.icmp "ugt" %2, %3 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_add_add_C_comm2   : icmp_add_add_C_comm2_before  ⊑  icmp_add_add_C_comm2_combined := by
  unfold icmp_add_add_C_comm2_before icmp_add_add_C_comm2_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_comm2_pred_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_comm2_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.icmp "ule" %2, %3 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_add_add_C_comm2_pred   : icmp_add_add_C_comm2_pred_before  ⊑  icmp_add_add_C_comm2_pred_combined := by
  unfold icmp_add_add_C_comm2_pred_before icmp_add_add_C_comm2_pred_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_comm2_wrong_pred_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_comm2_wrong_pred(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.add %2, %arg1  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.icmp "ult" %2, %4 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_icmp_add_add_C_comm2_wrong_pred   : icmp_add_add_C_comm2_wrong_pred_before  ⊑  icmp_add_add_C_comm2_wrong_pred_combined := by
  unfold icmp_add_add_C_comm2_wrong_pred_before icmp_add_add_C_comm2_wrong_pred_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_comm3_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_comm3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.icmp "ugt" %2, %3 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_add_add_C_comm3   : icmp_add_add_C_comm3_before  ⊑  icmp_add_add_C_comm3_combined := by
  unfold icmp_add_add_C_comm3_before icmp_add_add_C_comm3_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_extra_use1_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_extra_use1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_add_add_C_extra_use1   : icmp_add_add_C_extra_use1_before  ⊑  icmp_add_add_C_extra_use1_combined := by
  unfold icmp_add_add_C_extra_use1_before icmp_add_add_C_extra_use1_combined
  simp_alive_peephole
  sorry
def icmp_add_add_C_extra_use2_combined := [llvmfunc|
  llvm.func @icmp_add_add_C_extra_use2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_add_add_C_extra_use2   : icmp_add_add_C_extra_use2_before  ⊑  icmp_add_add_C_extra_use2_combined := by
  unfold icmp_add_add_C_extra_use2_before icmp_add_add_C_extra_use2_combined
  simp_alive_peephole
  sorry
def icmp_dec_assume_nonzero_combined := [llvmfunc|
  llvm.func @icmp_dec_assume_nonzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_dec_assume_nonzero   : icmp_dec_assume_nonzero_before  ⊑  icmp_dec_assume_nonzero_combined := by
  unfold icmp_dec_assume_nonzero_before icmp_dec_assume_nonzero_combined
  simp_alive_peephole
  sorry
def icmp_dec_sub_assume_nonzero_combined := [llvmfunc|
  llvm.func @icmp_dec_sub_assume_nonzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_dec_sub_assume_nonzero   : icmp_dec_sub_assume_nonzero_before  ⊑  icmp_dec_sub_assume_nonzero_combined := by
  unfold icmp_dec_sub_assume_nonzero_before icmp_dec_sub_assume_nonzero_combined
  simp_alive_peephole
  sorry
def icmp_dec_nonzero_combined := [llvmfunc|
  llvm.func @icmp_dec_nonzero(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.icmp "ult" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_dec_nonzero   : icmp_dec_nonzero_before  ⊑  icmp_dec_nonzero_combined := by
  unfold icmp_dec_nonzero_before icmp_dec_nonzero_combined
  simp_alive_peephole
  sorry
def icmp_dec_nonzero_vec_combined := [llvmfunc|
  llvm.func @icmp_dec_nonzero_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[15, 17]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.or %arg0, %0  : vector<2xi32>
    %4 = llvm.add %3, %1 overflow<nsw>  : vector<2xi32>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_icmp_dec_nonzero_vec   : icmp_dec_nonzero_vec_before  ⊑  icmp_dec_nonzero_vec_combined := by
  unfold icmp_dec_nonzero_vec_before icmp_dec_nonzero_vec_combined
  simp_alive_peephole
  sorry
def icmp_dec_notnonzero_combined := [llvmfunc|
  llvm.func @icmp_dec_notnonzero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_dec_notnonzero   : icmp_dec_notnonzero_before  ⊑  icmp_dec_notnonzero_combined := by
  unfold icmp_dec_notnonzero_before icmp_dec_notnonzero_combined
  simp_alive_peephole
  sorry
def icmp_addnuw_nonzero_combined := [llvmfunc|
  llvm.func @icmp_addnuw_nonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_addnuw_nonzero   : icmp_addnuw_nonzero_before  ⊑  icmp_addnuw_nonzero_combined := by
  unfold icmp_addnuw_nonzero_before icmp_addnuw_nonzero_combined
  simp_alive_peephole
  sorry
def icmp_addnuw_nonzero_fail_multiuse_combined := [llvmfunc|
  llvm.func @icmp_addnuw_nonzero_fail_multiuse(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.call @use(%1) : (i32) -> ()
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_addnuw_nonzero_fail_multiuse   : icmp_addnuw_nonzero_fail_multiuse_before  ⊑  icmp_addnuw_nonzero_fail_multiuse_combined := by
  unfold icmp_addnuw_nonzero_fail_multiuse_before icmp_addnuw_nonzero_fail_multiuse_combined
  simp_alive_peephole
  sorry
def ult_add_C2_pow2_C_neg_combined := [llvmfunc|
  llvm.func @ult_add_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ult_add_C2_pow2_C_neg   : ult_add_C2_pow2_C_neg_before  ⊑  ult_add_C2_pow2_C_neg_combined := by
  unfold ult_add_C2_pow2_C_neg_before ult_add_C2_pow2_C_neg_combined
  simp_alive_peephole
  sorry
def ult_add_nsw_C2_pow2_C_neg_combined := [llvmfunc|
  llvm.func @ult_add_nsw_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ult_add_nsw_C2_pow2_C_neg   : ult_add_nsw_C2_pow2_C_neg_before  ⊑  ult_add_nsw_C2_pow2_C_neg_combined := by
  unfold ult_add_nsw_C2_pow2_C_neg_before ult_add_nsw_C2_pow2_C_neg_combined
  simp_alive_peephole
  sorry
def ult_add_nuw_nsw_C2_pow2_C_neg_combined := [llvmfunc|
  llvm.func @ult_add_nuw_nsw_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_add_nuw_nsw_C2_pow2_C_neg   : ult_add_nuw_nsw_C2_pow2_C_neg_before  ⊑  ult_add_nuw_nsw_C2_pow2_C_neg_combined := by
  unfold ult_add_nuw_nsw_C2_pow2_C_neg_before ult_add_nuw_nsw_C2_pow2_C_neg_combined
  simp_alive_peephole
  sorry
def ult_add_C2_neg_C_pow2_combined := [llvmfunc|
  llvm.func @ult_add_C2_neg_C_pow2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ult_add_C2_neg_C_pow2   : ult_add_C2_neg_C_pow2_before  ⊑  ult_add_C2_neg_C_pow2_combined := by
  unfold ult_add_C2_neg_C_pow2_before ult_add_C2_neg_C_pow2_combined
  simp_alive_peephole
  sorry
def ult_add_C2_pow2_C_neg_vec_combined := [llvmfunc|
  llvm.func @ult_add_C2_pow2_C_neg_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-32> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_ult_add_C2_pow2_C_neg_vec   : ult_add_C2_pow2_C_neg_vec_before  ⊑  ult_add_C2_pow2_C_neg_vec_combined := by
  unfold ult_add_C2_pow2_C_neg_vec_before ult_add_C2_pow2_C_neg_vec_combined
  simp_alive_peephole
  sorry
def ult_add_C2_pow2_C_neg_multiuse_combined := [llvmfunc|
  llvm.func @ult_add_C2_pow2_C_neg_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.mlir.addressof @use : !llvm.ptr
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.call %2(%3) : !llvm.ptr, (i8) -> ()
    llvm.return %4 : i1
  }]

theorem inst_combine_ult_add_C2_pow2_C_neg_multiuse   : ult_add_C2_pow2_C_neg_multiuse_before  ⊑  ult_add_C2_pow2_C_neg_multiuse_combined := by
  unfold ult_add_C2_pow2_C_neg_multiuse_before ult_add_C2_pow2_C_neg_multiuse_combined
  simp_alive_peephole
  sorry
def uge_add_C2_pow2_C_neg_combined := [llvmfunc|
  llvm.func @uge_add_C2_pow2_C_neg(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-32 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_uge_add_C2_pow2_C_neg   : uge_add_C2_pow2_C_neg_before  ⊑  uge_add_C2_pow2_C_neg_combined := by
  unfold uge_add_C2_pow2_C_neg_before uge_add_C2_pow2_C_neg_combined
  simp_alive_peephole
  sorry
