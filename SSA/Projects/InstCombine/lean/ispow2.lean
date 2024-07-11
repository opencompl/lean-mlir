import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ispow2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def is_pow2or0_negate_op_before := [llvmfunc|
  llvm.func @is_pow2or0_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def is_pow2or0_negate_op_vec_before := [llvmfunc|
  llvm.func @is_pow2or0_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %arg0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def is_pow2or0_decrement_op_before := [llvmfunc|
  llvm.func @is_pow2or0_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def is_pow2or0_decrement_op_vec_before := [llvmfunc|
  llvm.func @is_pow2or0_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def isnot_pow2or0_negate_op_before := [llvmfunc|
  llvm.func @isnot_pow2or0_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def isnot_pow2or0_negate_op_vec_before := [llvmfunc|
  llvm.func @isnot_pow2or0_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %arg0 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def isnot_pow2or0_decrement_op_before := [llvmfunc|
  llvm.func @isnot_pow2or0_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    llvm.return %4 : i1
  }]

def isnot_pow2or0_decrement_op_vec_before := [llvmfunc|
  llvm.func @isnot_pow2or0_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def is_pow2or0_negate_op_commute1_before := [llvmfunc|
  llvm.func @is_pow2or0_negate_op_commute1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }]

def isnot_pow2or0_negate_op_commute2_before := [llvmfunc|
  llvm.func @isnot_pow2or0_negate_op_commute2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.urem %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %2, %4 : i32
    llvm.return %5 : i1
  }]

def isnot_pow2or0_negate_op_commute3_before := [llvmfunc|
  llvm.func @isnot_pow2or0_negate_op_commute3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.urem %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = llvm.icmp "ne" %2, %4 : i32
    llvm.return %5 : i1
  }]

def is_pow2or0_negate_op_extra_use1_before := [llvmfunc|
  llvm.func @is_pow2or0_negate_op_extra_use1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def is_pow2or0_negate_op_extra_use2_before := [llvmfunc|
  llvm.func @is_pow2or0_negate_op_extra_use2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def is_pow2_ctpop_before := [llvmfunc|
  llvm.func @is_pow2_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2_non_zero_ult_2_before := [llvmfunc|
  llvm.func @is_pow2_non_zero_ult_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    llvm.return %4 : i1
  }]

def is_pow2_non_zero_eq_1_before := [llvmfunc|
  llvm.func @is_pow2_non_zero_eq_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def is_pow2_non_zero_ugt_1_before := [llvmfunc|
  llvm.func @is_pow2_non_zero_ugt_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    llvm.return %4 : i1
  }]

def is_pow2_non_zero_ne_1_before := [llvmfunc|
  llvm.func @is_pow2_non_zero_ne_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

def is_pow2_ctpop_logical_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2_ctpop_extra_uses_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2_ctpop_extra_uses_logical_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_extra_uses_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2_ctpop_commute_vec_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ult" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def is_pow2_ctpop_wrong_cmp_op1_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2_ctpop_wrong_cmp_op1_logical_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2_ctpop_wrong_cmp_op2_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_cmp_op2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2_ctpop_wrong_cmp_op2_logical_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_cmp_op2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2_ctpop_wrong_pred1_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_pred1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2_ctpop_wrong_pred1_logical_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_pred1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2_ctpop_wrong_pred2_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2_ctpop_wrong_pred2_logical_before := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def isnot_pow2_ctpop_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2_ctpop_logical_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

def isnot_pow2_ctpop_extra_uses_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2_ctpop_extra_uses_logical_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_extra_uses_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

def isnot_pow2_ctpop_commute_vec_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ugt" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def isnot_pow2_ctpop_wrong_cmp_op1_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2_ctpop_wrong_cmp_op1_logical_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

def isnot_pow2_ctpop_wrong_cmp_op2_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }]

def isnot_pow2_ctpop_wrong_cmp_op2_logical_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }]

def isnot_pow2_ctpop_wrong_pred2_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2_ctpop_wrong_pred2_logical_before := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2_negate_op_before := [llvmfunc|
  llvm.func @is_pow2_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    %4 = llvm.icmp "ne" %arg0, %0 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2_negate_op_logical_before := [llvmfunc|
  llvm.func @is_pow2_negate_op_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %arg0 : i32
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2_negate_op_vec_before := [llvmfunc|
  llvm.func @is_pow2_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %arg0 : vector<2xi32>
    %5 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def is_pow2_decrement_op_before := [llvmfunc|
  llvm.func @is_pow2_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    %5 = llvm.icmp "ne" %arg0, %1 : i8
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }]

def is_pow2_decrement_op_logical_before := [llvmfunc|
  llvm.func @is_pow2_decrement_op_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    %6 = llvm.icmp "ne" %arg0, %1 : i8
    %7 = llvm.select %5, %6, %2 : i1, i1
    llvm.return %7 : i1
  }]

def is_pow2_decrement_op_vec_before := [llvmfunc|
  llvm.func @is_pow2_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi8>
    %6 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %7 = llvm.and %6, %5  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }]

def isnot_pow2_negate_op_before := [llvmfunc|
  llvm.func @isnot_pow2_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %arg0 : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2_negate_op_logical_before := [llvmfunc|
  llvm.func @isnot_pow2_negate_op_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %arg0 : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.select %4, %1, %5 : i1, i1
    llvm.return %6 : i1
  }]

def isnot_pow2_negate_op_vec_before := [llvmfunc|
  llvm.func @isnot_pow2_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.and %2, %arg0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %arg0 : vector<2xi32>
    %5 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %6 = llvm.or %5, %4  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def isnot_pow2_decrement_op_before := [llvmfunc|
  llvm.func @isnot_pow2_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    %5 = llvm.icmp "eq" %arg0, %1 : i8
    %6 = llvm.or %5, %4  : i1
    llvm.return %6 : i1
  }]

def isnot_pow2_decrement_op_logical_before := [llvmfunc|
  llvm.func @isnot_pow2_decrement_op_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.add %arg0, %0  : i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "ne" %4, %1 : i8
    %6 = llvm.icmp "eq" %arg0, %1 : i8
    %7 = llvm.select %6, %2, %5 : i1, i1
    llvm.return %7 : i1
  }]

def isnot_pow2_decrement_op_vec_before := [llvmfunc|
  llvm.func @isnot_pow2_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi8>
    %6 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %7 = llvm.or %5, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }]

def is_pow2or0_ctpop_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2or0_ctpop_swap_cmp_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_swap_cmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def is_pow2or0_ctpop_logical_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2or0_ctpop_commute_vec_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %5, %4  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def is_pow2or0_ctpop_extra_uses_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2or0_ctpop_logical_extra_uses_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_logical_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2or0_ctpop_wrong_cmp_op1_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2or0_ctpop_wrong_cmp_op1_logical_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2or0_ctpop_commute_vec_wrong_cmp_op1_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_commute_vec_wrong_cmp_op1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def is_pow2or0_ctpop_wrong_pred1_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_pred1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2or0_ctpop_wrong_pred2_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

def is_pow2or0_ctpop_wrong_pred2_logical_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

def is_pow2or0_ctpop_commute_vec_wrong_pred3_before := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_commute_vec_wrong_pred3(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def isnot_pow2nor0_ctpop_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2nor0_ctpop_swap_cmp_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_swap_cmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2nor0_ctpop_logical_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def isnot_pow2nor0_ctpop_commute_vec_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %5, %4  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def isnot_pow2nor0_ctpop_extra_uses_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2nor0_ctpop_logical_extra_uses_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_logical_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def isnot_pow2nor0_ctpop_wrong_cmp_op1_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2nor0_ctpop_wrong_cmp_op1_logical_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def isnot_pow2nor0_ctpop_wrong_pred1_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_pred1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2nor0_ctpop_wrong_pred2_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def isnot_pow2nor0_ctpop_wrong_pred2_logical_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

def isnot_pow2nor0_wrong_pred3_ctpop_commute_vec_before := [llvmfunc|
  llvm.func @isnot_pow2nor0_wrong_pred3_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

def is_pow2_fail_pr63327_before := [llvmfunc|
  llvm.func @is_pow2_fail_pr63327(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %arg0, %1  : i32
    %3 = llvm.icmp "sge" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def blsmsk_is_p2_or_z_before := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.icmp "uge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def blsmsk_isnt_p2_or_z_before := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def blsmsk_is_p2_or_z_fail_before := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_fail(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def blsmsk_isnt_p2_or_z_fail_before := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "ule" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def blsmsk_isnt_p2_or_z_fail_multiuse_before := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_fail_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    llvm.call @use.i32(%2) : (i32) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def blsmsk_isnt_p2_or_z_fail_wrong_add_before := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_fail_wrong_add(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def blsmsk_isnt_p2_or_z_fail_bad_xor_before := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_fail_bad_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg1, %1  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

def blsmsk_is_p2_or_z_fail_bad_cmp_before := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_fail_bad_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %arg0, %1  : i32
    %3 = llvm.icmp "uge" %2, %arg1 : i32
    llvm.return %3 : i1
  }]

def blsmsk_is_p2_or_z_ule_xy_before := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_ule_xy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ule" %1, %3 : i8
    llvm.return %4 : i1
  }]

def blsmsk_is_p2_or_z_ule_yx_fail_before := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_ule_yx_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ule" %3, %1 : i8
    llvm.return %4 : i1
  }]

def blsmsk_is_p2_or_z_uge_yx_before := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_uge_yx(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "uge" %3, %1 : i8
    llvm.return %4 : i1
  }]

def blsmsk_is_p2_or_z_uge_xy_fail_before := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_uge_xy_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "uge" %1, %3 : i8
    llvm.return %4 : i1
  }]

def blsmsk_isnt_p2_or_z_ugt_xy_before := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_ugt_xy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ugt" %1, %3 : i8
    llvm.return %4 : i1
  }]

def blsmsk_isnt_p2_or_z_ugt_yx_fail_before := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_ugt_yx_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    llvm.return %4 : i1
  }]

def blsmsk_isnt_p2_or_z_ult_yx_before := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_ult_yx(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }]

def blsmsk_isnt_p2_or_z_ult_xy_fail_before := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_ult_xy_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    llvm.return %4 : i1
  }]

def is_pow2_nz_known_bits_before := [llvmfunc|
  llvm.func @is_pow2_nz_known_bits(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def is_pow2_nz_known_bits_fail_multiuse_before := [llvmfunc|
  llvm.func @is_pow2_nz_known_bits_fail_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    llvm.call @use.i32(%3) : (i32) -> ()
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def not_pow2_nz_known_bits_before := [llvmfunc|
  llvm.func @not_pow2_nz_known_bits(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }]

def not_pow2_nz_known_bits_fail_not_p2_test_before := [llvmfunc|
  llvm.func @not_pow2_nz_known_bits_fail_not_p2_test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

def is_pow2_or_z_known_bits_before := [llvmfunc|
  llvm.func @is_pow2_or_z_known_bits(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    llvm.return %4 : i1
  }]

def not_pow2_or_z_known_bits_before := [llvmfunc|
  llvm.func @not_pow2_or_z_known_bits(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi32>) -> vector<2xi32>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def not_pow2_or_z_known_bits_fail_wrong_cmp_before := [llvmfunc|
  llvm.func @not_pow2_or_z_known_bits_fail_wrong_cmp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi32>) -> vector<2xi32>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def is_pow2or0_negate_op_combined := [llvmfunc|
  llvm.func @is_pow2or0_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2or0_negate_op   : is_pow2or0_negate_op_before  ⊑  is_pow2or0_negate_op_combined := by
  unfold is_pow2or0_negate_op_before is_pow2or0_negate_op_combined
  simp_alive_peephole
  sorry
def is_pow2or0_negate_op_vec_combined := [llvmfunc|
  llvm.func @is_pow2or0_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_is_pow2or0_negate_op_vec   : is_pow2or0_negate_op_vec_before  ⊑  is_pow2or0_negate_op_vec_combined := by
  unfold is_pow2or0_negate_op_vec_before is_pow2or0_negate_op_vec_combined
  simp_alive_peephole
  sorry
def is_pow2or0_decrement_op_combined := [llvmfunc|
  llvm.func @is_pow2or0_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2or0_decrement_op   : is_pow2or0_decrement_op_before  ⊑  is_pow2or0_decrement_op_combined := by
  unfold is_pow2or0_decrement_op_before is_pow2or0_decrement_op_combined
  simp_alive_peephole
  sorry
def is_pow2or0_decrement_op_vec_combined := [llvmfunc|
  llvm.func @is_pow2or0_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_is_pow2or0_decrement_op_vec   : is_pow2or0_decrement_op_vec_before  ⊑  is_pow2or0_decrement_op_vec_combined := by
  unfold is_pow2or0_decrement_op_vec_before is_pow2or0_decrement_op_vec_combined
  simp_alive_peephole
  sorry
def isnot_pow2or0_negate_op_combined := [llvmfunc|
  llvm.func @isnot_pow2or0_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2or0_negate_op   : isnot_pow2or0_negate_op_before  ⊑  isnot_pow2or0_negate_op_combined := by
  unfold isnot_pow2or0_negate_op_before isnot_pow2or0_negate_op_combined
  simp_alive_peephole
  sorry
def isnot_pow2or0_negate_op_vec_combined := [llvmfunc|
  llvm.func @isnot_pow2or0_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ugt" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_isnot_pow2or0_negate_op_vec   : isnot_pow2or0_negate_op_vec_before  ⊑  isnot_pow2or0_negate_op_vec_combined := by
  unfold isnot_pow2or0_negate_op_vec_before isnot_pow2or0_negate_op_vec_combined
  simp_alive_peephole
  sorry
def isnot_pow2or0_decrement_op_combined := [llvmfunc|
  llvm.func @isnot_pow2or0_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "ugt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2or0_decrement_op   : isnot_pow2or0_decrement_op_before  ⊑  isnot_pow2or0_decrement_op_combined := by
  unfold isnot_pow2or0_decrement_op_before isnot_pow2or0_decrement_op_combined
  simp_alive_peephole
  sorry
def isnot_pow2or0_decrement_op_vec_combined := [llvmfunc|
  llvm.func @isnot_pow2or0_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "ugt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_isnot_pow2or0_decrement_op_vec   : isnot_pow2or0_decrement_op_vec_before  ⊑  isnot_pow2or0_decrement_op_vec_combined := by
  unfold isnot_pow2or0_decrement_op_vec_before isnot_pow2or0_decrement_op_vec_combined
  simp_alive_peephole
  sorry
def is_pow2or0_negate_op_commute1_combined := [llvmfunc|
  llvm.func @is_pow2or0_negate_op_commute1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.srem %0, %arg0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_is_pow2or0_negate_op_commute1   : is_pow2or0_negate_op_commute1_before  ⊑  is_pow2or0_negate_op_commute1_combined := by
  unfold is_pow2or0_negate_op_commute1_before is_pow2or0_negate_op_commute1_combined
  simp_alive_peephole
  sorry
def isnot_pow2or0_negate_op_commute2_combined := [llvmfunc|
  llvm.func @isnot_pow2or0_negate_op_commute2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.urem %0, %arg0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_isnot_pow2or0_negate_op_commute2   : isnot_pow2or0_negate_op_commute2_before  ⊑  isnot_pow2or0_negate_op_commute2_combined := by
  unfold isnot_pow2or0_negate_op_commute2_before isnot_pow2or0_negate_op_commute2_combined
  simp_alive_peephole
  sorry
def isnot_pow2or0_negate_op_commute3_combined := [llvmfunc|
  llvm.func @isnot_pow2or0_negate_op_commute3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.urem %0, %arg0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_isnot_pow2or0_negate_op_commute3   : isnot_pow2or0_negate_op_commute3_before  ⊑  isnot_pow2or0_negate_op_commute3_combined := by
  unfold isnot_pow2or0_negate_op_commute3_before isnot_pow2or0_negate_op_commute3_combined
  simp_alive_peephole
  sorry
def is_pow2or0_negate_op_extra_use1_combined := [llvmfunc|
  llvm.func @is_pow2or0_negate_op_extra_use1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_is_pow2or0_negate_op_extra_use1   : is_pow2or0_negate_op_extra_use1_before  ⊑  is_pow2or0_negate_op_extra_use1_combined := by
  unfold is_pow2or0_negate_op_extra_use1_before is_pow2or0_negate_op_extra_use1_combined
  simp_alive_peephole
  sorry
def is_pow2or0_negate_op_extra_use2_combined := [llvmfunc|
  llvm.func @is_pow2or0_negate_op_extra_use2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_is_pow2or0_negate_op_extra_use2   : is_pow2or0_negate_op_extra_use2_before  ⊑  is_pow2or0_negate_op_extra_use2_combined := by
  unfold is_pow2or0_negate_op_extra_use2_before is_pow2or0_negate_op_extra_use2_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2_ctpop   : is_pow2_ctpop_before  ⊑  is_pow2_ctpop_combined := by
  unfold is_pow2_ctpop_before is_pow2_ctpop_combined
  simp_alive_peephole
  sorry
def is_pow2_non_zero_ult_2_combined := [llvmfunc|
  llvm.func @is_pow2_non_zero_ult_2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_is_pow2_non_zero_ult_2   : is_pow2_non_zero_ult_2_before  ⊑  is_pow2_non_zero_ult_2_combined := by
  unfold is_pow2_non_zero_ult_2_before is_pow2_non_zero_ult_2_combined
  simp_alive_peephole
  sorry
def is_pow2_non_zero_eq_1_combined := [llvmfunc|
  llvm.func @is_pow2_non_zero_eq_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_is_pow2_non_zero_eq_1   : is_pow2_non_zero_eq_1_before  ⊑  is_pow2_non_zero_eq_1_combined := by
  unfold is_pow2_non_zero_eq_1_before is_pow2_non_zero_eq_1_combined
  simp_alive_peephole
  sorry
def is_pow2_non_zero_ugt_1_combined := [llvmfunc|
  llvm.func @is_pow2_non_zero_ugt_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_is_pow2_non_zero_ugt_1   : is_pow2_non_zero_ugt_1_before  ⊑  is_pow2_non_zero_ugt_1_combined := by
  unfold is_pow2_non_zero_ugt_1_before is_pow2_non_zero_ugt_1_combined
  simp_alive_peephole
  sorry
def is_pow2_non_zero_ne_1_combined := [llvmfunc|
  llvm.func @is_pow2_non_zero_ne_1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_is_pow2_non_zero_ne_1   : is_pow2_non_zero_ne_1_before  ⊑  is_pow2_non_zero_ne_1_combined := by
  unfold is_pow2_non_zero_ne_1_before is_pow2_non_zero_ne_1_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_logical_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2_ctpop_logical   : is_pow2_ctpop_logical_before  ⊑  is_pow2_ctpop_logical_combined := by
  unfold is_pow2_ctpop_logical_before is_pow2_ctpop_logical_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_extra_uses_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.icmp "eq" %3, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_is_pow2_ctpop_extra_uses   : is_pow2_ctpop_extra_uses_before  ⊑  is_pow2_ctpop_extra_uses_combined := by
  unfold is_pow2_ctpop_extra_uses_before is_pow2_ctpop_extra_uses_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_extra_uses_logical_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_extra_uses_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.icmp "eq" %3, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_is_pow2_ctpop_extra_uses_logical   : is_pow2_ctpop_extra_uses_logical_before  ⊑  is_pow2_ctpop_extra_uses_logical_combined := by
  unfold is_pow2_ctpop_extra_uses_logical_before is_pow2_ctpop_extra_uses_logical_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_commute_vec_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_is_pow2_ctpop_commute_vec   : is_pow2_ctpop_commute_vec_before  ⊑  is_pow2_ctpop_commute_vec_combined := by
  unfold is_pow2_ctpop_commute_vec_before is_pow2_ctpop_commute_vec_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_wrong_cmp_op1_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_is_pow2_ctpop_wrong_cmp_op1   : is_pow2_ctpop_wrong_cmp_op1_before  ⊑  is_pow2_ctpop_wrong_cmp_op1_combined := by
  unfold is_pow2_ctpop_wrong_cmp_op1_before is_pow2_ctpop_wrong_cmp_op1_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_wrong_cmp_op1_logical_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_is_pow2_ctpop_wrong_cmp_op1_logical   : is_pow2_ctpop_wrong_cmp_op1_logical_before  ⊑  is_pow2_ctpop_wrong_cmp_op1_logical_combined := by
  unfold is_pow2_ctpop_wrong_cmp_op1_logical_before is_pow2_ctpop_wrong_cmp_op1_logical_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_wrong_cmp_op2_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_cmp_op2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_is_pow2_ctpop_wrong_cmp_op2   : is_pow2_ctpop_wrong_cmp_op2_before  ⊑  is_pow2_ctpop_wrong_cmp_op2_combined := by
  unfold is_pow2_ctpop_wrong_cmp_op2_before is_pow2_ctpop_wrong_cmp_op2_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_wrong_cmp_op2_logical_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_cmp_op2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_is_pow2_ctpop_wrong_cmp_op2_logical   : is_pow2_ctpop_wrong_cmp_op2_logical_before  ⊑  is_pow2_ctpop_wrong_cmp_op2_logical_combined := by
  unfold is_pow2_ctpop_wrong_cmp_op2_logical_before is_pow2_ctpop_wrong_cmp_op2_logical_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_wrong_pred1_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_pred1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2_ctpop_wrong_pred1   : is_pow2_ctpop_wrong_pred1_before  ⊑  is_pow2_ctpop_wrong_pred1_combined := by
  unfold is_pow2_ctpop_wrong_pred1_before is_pow2_ctpop_wrong_pred1_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_wrong_pred1_logical_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_pred1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2_ctpop_wrong_pred1_logical   : is_pow2_ctpop_wrong_pred1_logical_before  ⊑  is_pow2_ctpop_wrong_pred1_logical_combined := by
  unfold is_pow2_ctpop_wrong_pred1_logical_before is_pow2_ctpop_wrong_pred1_logical_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_wrong_pred2_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ult" %2, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_is_pow2_ctpop_wrong_pred2   : is_pow2_ctpop_wrong_pred2_before  ⊑  is_pow2_ctpop_wrong_pred2_combined := by
  unfold is_pow2_ctpop_wrong_pred2_before is_pow2_ctpop_wrong_pred2_combined
  simp_alive_peephole
  sorry
def is_pow2_ctpop_wrong_pred2_logical_combined := [llvmfunc|
  llvm.func @is_pow2_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ult" %3, %0 : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_is_pow2_ctpop_wrong_pred2_logical   : is_pow2_ctpop_wrong_pred2_logical_before  ⊑  is_pow2_ctpop_wrong_pred2_logical_combined := by
  unfold is_pow2_ctpop_wrong_pred2_logical_before is_pow2_ctpop_wrong_pred2_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop   : isnot_pow2_ctpop_before  ⊑  isnot_pow2_ctpop_combined := by
  unfold isnot_pow2_ctpop_before isnot_pow2_ctpop_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop_logical   : isnot_pow2_ctpop_logical_before  ⊑  isnot_pow2_ctpop_logical_combined := by
  unfold isnot_pow2_ctpop_logical_before isnot_pow2_ctpop_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_extra_uses_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop_extra_uses   : isnot_pow2_ctpop_extra_uses_before  ⊑  isnot_pow2_ctpop_extra_uses_combined := by
  unfold isnot_pow2_ctpop_extra_uses_before isnot_pow2_ctpop_extra_uses_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_extra_uses_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_extra_uses_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop_extra_uses_logical   : isnot_pow2_ctpop_extra_uses_logical_before  ⊑  isnot_pow2_ctpop_extra_uses_logical_combined := by
  unfold isnot_pow2_ctpop_extra_uses_logical_before isnot_pow2_ctpop_extra_uses_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_commute_vec_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_isnot_pow2_ctpop_commute_vec   : isnot_pow2_ctpop_commute_vec_before  ⊑  isnot_pow2_ctpop_commute_vec_combined := by
  unfold isnot_pow2_ctpop_commute_vec_before isnot_pow2_ctpop_commute_vec_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_wrong_cmp_op1_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop_wrong_cmp_op1   : isnot_pow2_ctpop_wrong_cmp_op1_before  ⊑  isnot_pow2_ctpop_wrong_cmp_op1_combined := by
  unfold isnot_pow2_ctpop_wrong_cmp_op1_before isnot_pow2_ctpop_wrong_cmp_op1_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_wrong_cmp_op1_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop_wrong_cmp_op1_logical   : isnot_pow2_ctpop_wrong_cmp_op1_logical_before  ⊑  isnot_pow2_ctpop_wrong_cmp_op1_logical_combined := by
  unfold isnot_pow2_ctpop_wrong_cmp_op1_logical_before isnot_pow2_ctpop_wrong_cmp_op1_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_wrong_cmp_op2_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.or %3, %2  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop_wrong_cmp_op2   : isnot_pow2_ctpop_wrong_cmp_op2_before  ⊑  isnot_pow2_ctpop_wrong_cmp_op2_combined := by
  unfold isnot_pow2_ctpop_wrong_cmp_op2_before isnot_pow2_ctpop_wrong_cmp_op2_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_wrong_cmp_op2_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_cmp_op2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.select %4, %1, %3 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop_wrong_cmp_op2_logical   : isnot_pow2_ctpop_wrong_cmp_op2_logical_before  ⊑  isnot_pow2_ctpop_wrong_cmp_op2_logical_combined := by
  unfold isnot_pow2_ctpop_wrong_cmp_op2_logical_before isnot_pow2_ctpop_wrong_cmp_op2_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_wrong_pred2_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop_wrong_pred2   : isnot_pow2_ctpop_wrong_pred2_before  ⊑  isnot_pow2_ctpop_wrong_pred2_combined := by
  unfold isnot_pow2_ctpop_wrong_pred2_before isnot_pow2_ctpop_wrong_pred2_combined
  simp_alive_peephole
  sorry
def isnot_pow2_ctpop_wrong_pred2_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ugt" %3, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_isnot_pow2_ctpop_wrong_pred2_logical   : isnot_pow2_ctpop_wrong_pred2_logical_before  ⊑  isnot_pow2_ctpop_wrong_pred2_logical_combined := by
  unfold isnot_pow2_ctpop_wrong_pred2_logical_before isnot_pow2_ctpop_wrong_pred2_logical_combined
  simp_alive_peephole
  sorry
def is_pow2_negate_op_combined := [llvmfunc|
  llvm.func @is_pow2_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2_negate_op   : is_pow2_negate_op_before  ⊑  is_pow2_negate_op_combined := by
  unfold is_pow2_negate_op_before is_pow2_negate_op_combined
  simp_alive_peephole
  sorry
def is_pow2_negate_op_logical_combined := [llvmfunc|
  llvm.func @is_pow2_negate_op_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2_negate_op_logical   : is_pow2_negate_op_logical_before  ⊑  is_pow2_negate_op_logical_combined := by
  unfold is_pow2_negate_op_logical_before is_pow2_negate_op_logical_combined
  simp_alive_peephole
  sorry
def is_pow2_negate_op_vec_combined := [llvmfunc|
  llvm.func @is_pow2_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_is_pow2_negate_op_vec   : is_pow2_negate_op_vec_before  ⊑  is_pow2_negate_op_vec_combined := by
  unfold is_pow2_negate_op_vec_before is_pow2_negate_op_vec_combined
  simp_alive_peephole
  sorry
def is_pow2_decrement_op_combined := [llvmfunc|
  llvm.func @is_pow2_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2_decrement_op   : is_pow2_decrement_op_before  ⊑  is_pow2_decrement_op_combined := by
  unfold is_pow2_decrement_op_before is_pow2_decrement_op_combined
  simp_alive_peephole
  sorry
def is_pow2_decrement_op_logical_combined := [llvmfunc|
  llvm.func @is_pow2_decrement_op_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2_decrement_op_logical   : is_pow2_decrement_op_logical_before  ⊑  is_pow2_decrement_op_logical_combined := by
  unfold is_pow2_decrement_op_logical_before is_pow2_decrement_op_logical_combined
  simp_alive_peephole
  sorry
def is_pow2_decrement_op_vec_combined := [llvmfunc|
  llvm.func @is_pow2_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_is_pow2_decrement_op_vec   : is_pow2_decrement_op_vec_before  ⊑  is_pow2_decrement_op_vec_combined := by
  unfold is_pow2_decrement_op_vec_before is_pow2_decrement_op_vec_combined
  simp_alive_peephole
  sorry
def isnot_pow2_negate_op_combined := [llvmfunc|
  llvm.func @isnot_pow2_negate_op(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2_negate_op   : isnot_pow2_negate_op_before  ⊑  isnot_pow2_negate_op_combined := by
  unfold isnot_pow2_negate_op_before isnot_pow2_negate_op_combined
  simp_alive_peephole
  sorry
def isnot_pow2_negate_op_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2_negate_op_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2_negate_op_logical   : isnot_pow2_negate_op_logical_before  ⊑  isnot_pow2_negate_op_logical_combined := by
  unfold isnot_pow2_negate_op_logical_before isnot_pow2_negate_op_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2_negate_op_vec_combined := [llvmfunc|
  llvm.func @isnot_pow2_negate_op_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_isnot_pow2_negate_op_vec   : isnot_pow2_negate_op_vec_before  ⊑  isnot_pow2_negate_op_vec_combined := by
  unfold isnot_pow2_negate_op_vec_before isnot_pow2_negate_op_vec_combined
  simp_alive_peephole
  sorry
def isnot_pow2_decrement_op_combined := [llvmfunc|
  llvm.func @isnot_pow2_decrement_op(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2_decrement_op   : isnot_pow2_decrement_op_before  ⊑  isnot_pow2_decrement_op_combined := by
  unfold isnot_pow2_decrement_op_before isnot_pow2_decrement_op_combined
  simp_alive_peephole
  sorry
def isnot_pow2_decrement_op_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2_decrement_op_logical(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.ctpop(%arg0)  : (i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2_decrement_op_logical   : isnot_pow2_decrement_op_logical_before  ⊑  isnot_pow2_decrement_op_logical_combined := by
  unfold isnot_pow2_decrement_op_logical_before isnot_pow2_decrement_op_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2_decrement_op_vec_combined := [llvmfunc|
  llvm.func @isnot_pow2_decrement_op_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_isnot_pow2_decrement_op_vec   : isnot_pow2_decrement_op_vec_before  ⊑  isnot_pow2_decrement_op_vec_combined := by
  unfold isnot_pow2_decrement_op_vec_before isnot_pow2_decrement_op_vec_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop   : is_pow2or0_ctpop_before  ⊑  is_pow2or0_ctpop_combined := by
  unfold is_pow2or0_ctpop_before is_pow2or0_ctpop_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_swap_cmp_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_swap_cmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop_swap_cmp   : is_pow2or0_ctpop_swap_cmp_before  ⊑  is_pow2or0_ctpop_swap_cmp_combined := by
  unfold is_pow2or0_ctpop_swap_cmp_before is_pow2or0_ctpop_swap_cmp_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_logical_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop_logical   : is_pow2or0_ctpop_logical_before  ⊑  is_pow2or0_ctpop_logical_combined := by
  unfold is_pow2or0_ctpop_logical_before is_pow2or0_ctpop_logical_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_commute_vec_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_is_pow2or0_ctpop_commute_vec   : is_pow2or0_ctpop_commute_vec_before  ⊑  is_pow2or0_ctpop_commute_vec_combined := by
  unfold is_pow2or0_ctpop_commute_vec_before is_pow2or0_ctpop_commute_vec_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_extra_uses_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %3, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop_extra_uses   : is_pow2or0_ctpop_extra_uses_before  ⊑  is_pow2or0_ctpop_extra_uses_combined := by
  unfold is_pow2or0_ctpop_extra_uses_before is_pow2or0_ctpop_extra_uses_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_logical_extra_uses_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_logical_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.icmp "eq" %3, %0 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @use_i1(%5) : (i1) -> ()
    %6 = llvm.icmp "ult" %3, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop_logical_extra_uses   : is_pow2or0_ctpop_logical_extra_uses_before  ⊑  is_pow2or0_ctpop_logical_extra_uses_combined := by
  unfold is_pow2or0_ctpop_logical_extra_uses_before is_pow2or0_ctpop_logical_extra_uses_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_wrong_cmp_op1_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    %5 = llvm.or %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop_wrong_cmp_op1   : is_pow2or0_ctpop_wrong_cmp_op1_before  ⊑  is_pow2or0_ctpop_wrong_cmp_op1_combined := by
  unfold is_pow2or0_ctpop_wrong_cmp_op1_before is_pow2or0_ctpop_wrong_cmp_op1_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_wrong_cmp_op1_logical_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.icmp "eq" %arg0, %1 : i32
    %6 = llvm.select %5, %2, %4 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop_wrong_cmp_op1_logical   : is_pow2or0_ctpop_wrong_cmp_op1_logical_before  ⊑  is_pow2or0_ctpop_wrong_cmp_op1_logical_combined := by
  unfold is_pow2or0_ctpop_wrong_cmp_op1_logical_before is_pow2or0_ctpop_wrong_cmp_op1_logical_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_commute_vec_wrong_cmp_op1_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_commute_vec_wrong_cmp_op1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_is_pow2or0_ctpop_commute_vec_wrong_cmp_op1   : is_pow2or0_ctpop_commute_vec_wrong_cmp_op1_before  ⊑  is_pow2or0_ctpop_commute_vec_wrong_cmp_op1_combined := by
  unfold is_pow2or0_ctpop_commute_vec_wrong_cmp_op1_before is_pow2or0_ctpop_commute_vec_wrong_cmp_op1_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_wrong_pred1_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_pred1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop_wrong_pred1   : is_pow2or0_ctpop_wrong_pred1_before  ⊑  is_pow2or0_ctpop_wrong_pred1_combined := by
  unfold is_pow2or0_ctpop_wrong_pred1_before is_pow2or0_ctpop_wrong_pred1_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_wrong_pred2_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop_wrong_pred2   : is_pow2or0_ctpop_wrong_pred2_before  ⊑  is_pow2or0_ctpop_wrong_pred2_combined := by
  unfold is_pow2or0_ctpop_wrong_pred2_before is_pow2or0_ctpop_wrong_pred2_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_wrong_pred2_logical_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_is_pow2or0_ctpop_wrong_pred2_logical   : is_pow2or0_ctpop_wrong_pred2_logical_before  ⊑  is_pow2or0_ctpop_wrong_pred2_logical_combined := by
  unfold is_pow2or0_ctpop_wrong_pred2_logical_before is_pow2or0_ctpop_wrong_pred2_logical_combined
  simp_alive_peephole
  sorry
def is_pow2or0_ctpop_commute_vec_wrong_pred3_combined := [llvmfunc|
  llvm.func @is_pow2or0_ctpop_commute_vec_wrong_pred3(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "eq" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "eq" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_is_pow2or0_ctpop_commute_vec_wrong_pred3   : is_pow2or0_ctpop_commute_vec_wrong_pred3_before  ⊑  is_pow2or0_ctpop_commute_vec_wrong_pred3_combined := by
  unfold is_pow2or0_ctpop_commute_vec_wrong_pred3_before is_pow2or0_ctpop_commute_vec_wrong_pred3_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop   : isnot_pow2nor0_ctpop_before  ⊑  isnot_pow2nor0_ctpop_combined := by
  unfold isnot_pow2nor0_ctpop_before isnot_pow2nor0_ctpop_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_swap_cmp_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_swap_cmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_swap_cmp   : isnot_pow2nor0_ctpop_swap_cmp_before  ⊑  isnot_pow2nor0_ctpop_swap_cmp_combined := by
  unfold isnot_pow2nor0_ctpop_swap_cmp_before isnot_pow2nor0_ctpop_swap_cmp_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_logical   : isnot_pow2nor0_ctpop_logical_before  ⊑  isnot_pow2nor0_ctpop_logical_combined := by
  unfold isnot_pow2nor0_ctpop_logical_before isnot_pow2nor0_ctpop_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_commute_vec_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.icmp "ugt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_commute_vec   : isnot_pow2nor0_ctpop_commute_vec_before  ⊑  isnot_pow2nor0_ctpop_commute_vec_combined := by
  unfold isnot_pow2nor0_ctpop_commute_vec_before isnot_pow2nor0_ctpop_commute_vec_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_extra_uses_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ugt" %2, %0 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_extra_uses   : isnot_pow2nor0_ctpop_extra_uses_before  ⊑  isnot_pow2nor0_ctpop_extra_uses_combined := by
  unfold isnot_pow2nor0_ctpop_extra_uses_before isnot_pow2nor0_ctpop_extra_uses_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_logical_extra_uses_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_logical_extra_uses(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.call @use_i1(%3) : (i1) -> ()
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    llvm.call @use_i1(%4) : (i1) -> ()
    %5 = llvm.icmp "ugt" %2, %0 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_logical_extra_uses   : isnot_pow2nor0_ctpop_logical_extra_uses_before  ⊑  isnot_pow2nor0_ctpop_logical_extra_uses_combined := by
  unfold isnot_pow2nor0_ctpop_logical_extra_uses_before isnot_pow2nor0_ctpop_logical_extra_uses_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_wrong_cmp_op1_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_cmp_op1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.icmp "ne" %arg0, %1 : i32
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_wrong_cmp_op1   : isnot_pow2nor0_ctpop_wrong_cmp_op1_before  ⊑  isnot_pow2nor0_ctpop_wrong_cmp_op1_combined := by
  unfold isnot_pow2nor0_ctpop_wrong_cmp_op1_before isnot_pow2nor0_ctpop_wrong_cmp_op1_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_wrong_cmp_op1_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_cmp_op1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.icmp "ne" %arg0, %1 : i32
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_wrong_cmp_op1_logical   : isnot_pow2nor0_ctpop_wrong_cmp_op1_logical_before  ⊑  isnot_pow2nor0_ctpop_wrong_cmp_op1_logical_combined := by
  unfold isnot_pow2nor0_ctpop_wrong_cmp_op1_logical_before isnot_pow2nor0_ctpop_wrong_cmp_op1_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1   : isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1_before  ⊑  isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1_combined := by
  unfold isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1_before isnot_pow2nor0_ctpop_commute_vec_wrong_cmp_op1_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_wrong_pred1_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_pred1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_wrong_pred1   : isnot_pow2nor0_ctpop_wrong_pred1_before  ⊑  isnot_pow2nor0_ctpop_wrong_pred1_combined := by
  unfold isnot_pow2nor0_ctpop_wrong_pred1_before isnot_pow2nor0_ctpop_wrong_pred1_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_wrong_pred2_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_pred2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_wrong_pred2   : isnot_pow2nor0_ctpop_wrong_pred2_before  ⊑  isnot_pow2nor0_ctpop_wrong_pred2_combined := by
  unfold isnot_pow2nor0_ctpop_wrong_pred2_before isnot_pow2nor0_ctpop_wrong_pred2_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_ctpop_wrong_pred2_logical_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_ctpop_wrong_pred2_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_isnot_pow2nor0_ctpop_wrong_pred2_logical   : isnot_pow2nor0_ctpop_wrong_pred2_logical_before  ⊑  isnot_pow2nor0_ctpop_wrong_pred2_logical_combined := by
  unfold isnot_pow2nor0_ctpop_wrong_pred2_logical_before isnot_pow2nor0_ctpop_wrong_pred2_logical_combined
  simp_alive_peephole
  sorry
def isnot_pow2nor0_wrong_pred3_ctpop_commute_vec_combined := [llvmfunc|
  llvm.func @isnot_pow2nor0_wrong_pred3_ctpop_commute_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.icmp "ne" %arg0, %2 : vector<2xi8>
    %6 = llvm.or %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_isnot_pow2nor0_wrong_pred3_ctpop_commute_vec   : isnot_pow2nor0_wrong_pred3_ctpop_commute_vec_before  ⊑  isnot_pow2nor0_wrong_pred3_ctpop_commute_vec_combined := by
  unfold isnot_pow2nor0_wrong_pred3_ctpop_commute_vec_before isnot_pow2nor0_wrong_pred3_ctpop_commute_vec_combined
  simp_alive_peephole
  sorry
def is_pow2_fail_pr63327_combined := [llvmfunc|
  llvm.func @is_pow2_fail_pr63327(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "sge" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_is_pow2_fail_pr63327   : is_pow2_fail_pr63327_before  ⊑  is_pow2_fail_pr63327_combined := by
  unfold is_pow2_fail_pr63327_before is_pow2_fail_pr63327_combined
  simp_alive_peephole
  sorry
def blsmsk_is_p2_or_z_combined := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.xor %1, %2  : i32
    %4 = llvm.icmp "uge" %1, %3 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_blsmsk_is_p2_or_z   : blsmsk_is_p2_or_z_before  ⊑  blsmsk_is_p2_or_z_combined := by
  unfold blsmsk_is_p2_or_z_before blsmsk_is_p2_or_z_combined
  simp_alive_peephole
  sorry
def blsmsk_isnt_p2_or_z_combined := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_blsmsk_isnt_p2_or_z   : blsmsk_isnt_p2_or_z_before  ⊑  blsmsk_isnt_p2_or_z_combined := by
  unfold blsmsk_isnt_p2_or_z_before blsmsk_isnt_p2_or_z_combined
  simp_alive_peephole
  sorry
def blsmsk_is_p2_or_z_fail_combined := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_fail(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.or %arg0, %arg1  : i32
    %2 = llvm.intr.ctpop(%1)  : (i32) -> i32
    %3 = llvm.icmp "ugt" %2, %0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_is_p2_or_z_fail   : blsmsk_is_p2_or_z_fail_before  ⊑  blsmsk_is_p2_or_z_fail_combined := by
  unfold blsmsk_is_p2_or_z_fail_before blsmsk_is_p2_or_z_fail_combined
  simp_alive_peephole
  sorry
def blsmsk_isnt_p2_or_z_fail_combined := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_fail(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.icmp "ule" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_isnt_p2_or_z_fail   : blsmsk_isnt_p2_or_z_fail_before  ⊑  blsmsk_isnt_p2_or_z_fail_combined := by
  unfold blsmsk_isnt_p2_or_z_fail_before blsmsk_isnt_p2_or_z_fail_combined
  simp_alive_peephole
  sorry
def blsmsk_isnt_p2_or_z_fail_multiuse_combined := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_fail_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %1, %arg0  : i32
    llvm.call @use.i32(%2) : (i32) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_isnt_p2_or_z_fail_multiuse   : blsmsk_isnt_p2_or_z_fail_multiuse_before  ⊑  blsmsk_isnt_p2_or_z_fail_multiuse_combined := by
  unfold blsmsk_isnt_p2_or_z_fail_multiuse_before blsmsk_isnt_p2_or_z_fail_multiuse_combined
  simp_alive_peephole
  sorry
def blsmsk_isnt_p2_or_z_fail_wrong_add_combined := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_fail_wrong_add(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg1, %0  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_isnt_p2_or_z_fail_wrong_add   : blsmsk_isnt_p2_or_z_fail_wrong_add_before  ⊑  blsmsk_isnt_p2_or_z_fail_wrong_add_combined := by
  unfold blsmsk_isnt_p2_or_z_fail_wrong_add_before blsmsk_isnt_p2_or_z_fail_wrong_add_combined
  simp_alive_peephole
  sorry
def blsmsk_isnt_p2_or_z_fail_bad_xor_combined := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_fail_bad_xor(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %1, %arg1  : i32
    %3 = llvm.icmp "ult" %2, %arg0 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_isnt_p2_or_z_fail_bad_xor   : blsmsk_isnt_p2_or_z_fail_bad_xor_before  ⊑  blsmsk_isnt_p2_or_z_fail_bad_xor_combined := by
  unfold blsmsk_isnt_p2_or_z_fail_bad_xor_before blsmsk_isnt_p2_or_z_fail_bad_xor_combined
  simp_alive_peephole
  sorry
def blsmsk_is_p2_or_z_fail_bad_cmp_combined := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_fail_bad_cmp(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.xor %1, %arg0  : i32
    %3 = llvm.icmp "uge" %2, %arg1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_is_p2_or_z_fail_bad_cmp   : blsmsk_is_p2_or_z_fail_bad_cmp_before  ⊑  blsmsk_is_p2_or_z_fail_bad_cmp_combined := by
  unfold blsmsk_is_p2_or_z_fail_bad_cmp_before blsmsk_is_p2_or_z_fail_bad_cmp_combined
  simp_alive_peephole
  sorry
def blsmsk_is_p2_or_z_ule_xy_combined := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_ule_xy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.icmp "ult" %2, %0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_is_p2_or_z_ule_xy   : blsmsk_is_p2_or_z_ule_xy_before  ⊑  blsmsk_is_p2_or_z_ule_xy_combined := by
  unfold blsmsk_is_p2_or_z_ule_xy_before blsmsk_is_p2_or_z_ule_xy_combined
  simp_alive_peephole
  sorry
def blsmsk_is_p2_or_z_ule_yx_fail_combined := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_ule_yx_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ule" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_blsmsk_is_p2_or_z_ule_yx_fail   : blsmsk_is_p2_or_z_ule_yx_fail_before  ⊑  blsmsk_is_p2_or_z_ule_yx_fail_combined := by
  unfold blsmsk_is_p2_or_z_ule_yx_fail_before blsmsk_is_p2_or_z_ule_yx_fail_combined
  simp_alive_peephole
  sorry
def blsmsk_is_p2_or_z_uge_yx_combined := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_uge_yx(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.icmp "ult" %2, %0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_is_p2_or_z_uge_yx   : blsmsk_is_p2_or_z_uge_yx_before  ⊑  blsmsk_is_p2_or_z_uge_yx_combined := by
  unfold blsmsk_is_p2_or_z_uge_yx_before blsmsk_is_p2_or_z_uge_yx_combined
  simp_alive_peephole
  sorry
def blsmsk_is_p2_or_z_uge_xy_fail_combined := [llvmfunc|
  llvm.func @blsmsk_is_p2_or_z_uge_xy_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "uge" %1, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_blsmsk_is_p2_or_z_uge_xy_fail   : blsmsk_is_p2_or_z_uge_xy_fail_before  ⊑  blsmsk_is_p2_or_z_uge_xy_fail_combined := by
  unfold blsmsk_is_p2_or_z_uge_xy_fail_before blsmsk_is_p2_or_z_uge_xy_fail_combined
  simp_alive_peephole
  sorry
def blsmsk_isnt_p2_or_z_ugt_xy_combined := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_ugt_xy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.icmp "ugt" %2, %0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_isnt_p2_or_z_ugt_xy   : blsmsk_isnt_p2_or_z_ugt_xy_before  ⊑  blsmsk_isnt_p2_or_z_ugt_xy_combined := by
  unfold blsmsk_isnt_p2_or_z_ugt_xy_before blsmsk_isnt_p2_or_z_ugt_xy_combined
  simp_alive_peephole
  sorry
def blsmsk_isnt_p2_or_z_ugt_yx_fail_combined := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_ugt_yx_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ugt" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_blsmsk_isnt_p2_or_z_ugt_yx_fail   : blsmsk_isnt_p2_or_z_ugt_yx_fail_before  ⊑  blsmsk_isnt_p2_or_z_ugt_yx_fail_combined := by
  unfold blsmsk_isnt_p2_or_z_ugt_yx_fail_before blsmsk_isnt_p2_or_z_ugt_yx_fail_combined
  simp_alive_peephole
  sorry
def blsmsk_isnt_p2_or_z_ult_yx_combined := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_ult_yx(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.intr.ctpop(%1)  : (i8) -> i8
    %3 = llvm.icmp "ugt" %2, %0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_blsmsk_isnt_p2_or_z_ult_yx   : blsmsk_isnt_p2_or_z_ult_yx_before  ⊑  blsmsk_isnt_p2_or_z_ult_yx_combined := by
  unfold blsmsk_isnt_p2_or_z_ult_yx_before blsmsk_isnt_p2_or_z_ult_yx_combined
  simp_alive_peephole
  sorry
def blsmsk_isnt_p2_or_z_ult_xy_fail_combined := [llvmfunc|
  llvm.func @blsmsk_isnt_p2_or_z_ult_xy_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.xor %1, %2  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_blsmsk_isnt_p2_or_z_ult_xy_fail   : blsmsk_isnt_p2_or_z_ult_xy_fail_before  ⊑  blsmsk_isnt_p2_or_z_ult_xy_fail_combined := by
  unfold blsmsk_isnt_p2_or_z_ult_xy_fail_before blsmsk_isnt_p2_or_z_ult_xy_fail_combined
  simp_alive_peephole
  sorry
def is_pow2_nz_known_bits_combined := [llvmfunc|
  llvm.func @is_pow2_nz_known_bits(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-65 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_is_pow2_nz_known_bits   : is_pow2_nz_known_bits_before  ⊑  is_pow2_nz_known_bits_combined := by
  unfold is_pow2_nz_known_bits_before is_pow2_nz_known_bits_combined
  simp_alive_peephole
  sorry
def is_pow2_nz_known_bits_fail_multiuse_combined := [llvmfunc|
  llvm.func @is_pow2_nz_known_bits_fail_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    llvm.call @use.i32(%3) : (i32) -> ()
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_is_pow2_nz_known_bits_fail_multiuse   : is_pow2_nz_known_bits_fail_multiuse_before  ⊑  is_pow2_nz_known_bits_fail_multiuse_combined := by
  unfold is_pow2_nz_known_bits_fail_multiuse_before is_pow2_nz_known_bits_fail_multiuse_combined
  simp_alive_peephole
  sorry
def not_pow2_nz_known_bits_combined := [llvmfunc|
  llvm.func @not_pow2_nz_known_bits(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_not_pow2_nz_known_bits   : not_pow2_nz_known_bits_before  ⊑  not_pow2_nz_known_bits_combined := by
  unfold not_pow2_nz_known_bits_before not_pow2_nz_known_bits_combined
  simp_alive_peephole
  sorry
def not_pow2_nz_known_bits_fail_not_p2_test_combined := [llvmfunc|
  llvm.func @not_pow2_nz_known_bits_fail_not_p2_test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.intr.ctpop(%2)  : (i32) -> i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_not_pow2_nz_known_bits_fail_not_p2_test   : not_pow2_nz_known_bits_fail_not_p2_test_before  ⊑  not_pow2_nz_known_bits_fail_not_p2_test_combined := by
  unfold not_pow2_nz_known_bits_fail_not_p2_test_before not_pow2_nz_known_bits_fail_not_p2_test_combined
  simp_alive_peephole
  sorry
def is_pow2_or_z_known_bits_combined := [llvmfunc|
  llvm.func @is_pow2_or_z_known_bits(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_is_pow2_or_z_known_bits   : is_pow2_or_z_known_bits_before  ⊑  is_pow2_or_z_known_bits_combined := by
  unfold is_pow2_or_z_known_bits_before is_pow2_or_z_known_bits_combined
  simp_alive_peephole
  sorry
def not_pow2_or_z_known_bits_combined := [llvmfunc|
  llvm.func @not_pow2_or_z_known_bits(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-65> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_not_pow2_or_z_known_bits   : not_pow2_or_z_known_bits_before  ⊑  not_pow2_or_z_known_bits_combined := by
  unfold not_pow2_or_z_known_bits_before not_pow2_or_z_known_bits_combined
  simp_alive_peephole
  sorry
def not_pow2_or_z_known_bits_fail_wrong_cmp_combined := [llvmfunc|
  llvm.func @not_pow2_or_z_known_bits_fail_wrong_cmp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<64> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = llvm.intr.ctpop(%2)  : (vector<2xi32>) -> vector<2xi32>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_not_pow2_or_z_known_bits_fail_wrong_cmp   : not_pow2_or_z_known_bits_fail_wrong_cmp_before  ⊑  not_pow2_or_z_known_bits_fail_wrong_cmp_combined := by
  unfold not_pow2_or_z_known_bits_fail_wrong_cmp_before not_pow2_or_z_known_bits_fail_wrong_cmp_combined
  simp_alive_peephole
  sorry
