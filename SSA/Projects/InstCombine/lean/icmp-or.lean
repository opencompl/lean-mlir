import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def set_low_bit_mask_eq_before := [llvmfunc|
  llvm.func @set_low_bit_mask_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def set_low_bit_mask_ne_before := [llvmfunc|
  llvm.func @set_low_bit_mask_ne(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<19> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def set_low_bit_mask_ugt_before := [llvmfunc|
  llvm.func @set_low_bit_mask_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def set_low_bit_mask_ult_before := [llvmfunc|
  llvm.func @set_low_bit_mask_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def set_low_bit_mask_uge_before := [llvmfunc|
  llvm.func @set_low_bit_mask_uge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def set_low_bit_mask_ule_before := [llvmfunc|
  llvm.func @set_low_bit_mask_ule(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(18 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }]

def set_low_bit_mask_sgt_before := [llvmfunc|
  llvm.func @set_low_bit_mask_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def set_low_bit_mask_slt_before := [llvmfunc|
  llvm.func @set_low_bit_mask_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def set_low_bit_mask_sge_before := [llvmfunc|
  llvm.func @set_low_bit_mask_sge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(51 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def set_low_bit_mask_sle_before := [llvmfunc|
  llvm.func @set_low_bit_mask_sle(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(68 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def eq_const_mask_before := [llvmfunc|
  llvm.func @eq_const_mask(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

def ne_const_mask_before := [llvmfunc|
  llvm.func @ne_const_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-106, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi8>
    %2 = llvm.or %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def eq_const_mask_not_equality_before := [llvmfunc|
  llvm.func @eq_const_mask_not_equality(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.icmp "sgt" %1, %2 : i8
    llvm.return %3 : i1
  }]

def eq_const_mask_not_same_before := [llvmfunc|
  llvm.func @eq_const_mask_not_same(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }]

def eq_const_mask_wrong_opcode_before := [llvmfunc|
  llvm.func @eq_const_mask_wrong_opcode(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

def eq_const_mask_use1_before := [llvmfunc|
  llvm.func @eq_const_mask_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

def eq_const_mask_use2_before := [llvmfunc|
  llvm.func @eq_const_mask_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

def decrement_slt_0_before := [llvmfunc|
  llvm.func @decrement_slt_0(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.or %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "slt" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def decrement_slt_0_commute_use1_before := [llvmfunc|
  llvm.func @decrement_slt_0_commute_use1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.or %3, %4  : i8
    %6 = llvm.icmp "slt" %5, %2 : i8
    llvm.return %6 : i1
  }]

def decrement_slt_0_use2_before := [llvmfunc|
  llvm.func @decrement_slt_0_use2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

def decrement_slt_n1_before := [llvmfunc|
  llvm.func @decrement_slt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.return %3 : i1
  }]

def not_decrement_slt_0_before := [llvmfunc|
  llvm.func @not_decrement_slt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

def decrement_sgt_n1_before := [llvmfunc|
  llvm.func @decrement_sgt_n1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.or %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def decrement_sgt_n1_commute_use1_before := [llvmfunc|
  llvm.func @decrement_sgt_n1_commute_use1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "sgt" %4, %1 : i8
    llvm.return %5 : i1
  }]

def decrement_sgt_n1_use2_before := [llvmfunc|
  llvm.func @decrement_sgt_n1_use2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.return %3 : i1
  }]

def decrement_sgt_0_before := [llvmfunc|
  llvm.func @decrement_sgt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "sgt" %3, %1 : i8
    llvm.return %4 : i1
  }]

def not_decrement_sgt_n1_before := [llvmfunc|
  llvm.func @not_decrement_sgt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "sgt" %3, %1 : i8
    llvm.return %4 : i1
  }]

def icmp_or_xor_2_eq_before := [llvmfunc|
  llvm.func @icmp_or_xor_2_eq(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_xor_2_ne_before := [llvmfunc|
  llvm.func @icmp_or_xor_2_ne(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_xor_2_eq_fail_before := [llvmfunc|
  llvm.func @icmp_or_xor_2_eq_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_xor_2_ne_fail_before := [llvmfunc|
  llvm.func @icmp_or_xor_2_ne_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_xor_2_3_fail_before := [llvmfunc|
  llvm.func @icmp_or_xor_2_3_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    %5 = llvm.icmp "eq" %1, %0 : i64
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }]

def icmp_or_xor_2_4_fail_before := [llvmfunc|
  llvm.func @icmp_or_xor_2_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    %5 = llvm.icmp "eq" %2, %0 : i64
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }]

def icmp_or_xor_3_1_before := [llvmfunc|
  llvm.func @icmp_or_xor_3_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_xor_3_2_fail_before := [llvmfunc|
  llvm.func @icmp_or_xor_3_2_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_xor_3_3_before := [llvmfunc|
  llvm.func @icmp_or_xor_3_3(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_xor_3_4_fail_before := [llvmfunc|
  llvm.func @icmp_or_xor_3_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_xor_4_1_before := [llvmfunc|
  llvm.func @icmp_or_xor_4_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.xor %arg6, %arg7  : i64
    %6 = llvm.or %4, %5  : i64
    %7 = llvm.or %3, %6  : i64
    %8 = llvm.icmp "eq" %7, %0 : i64
    llvm.return %8 : i1
  }]

def icmp_or_xor_4_2_before := [llvmfunc|
  llvm.func @icmp_or_xor_4_2(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.xor %arg6, %arg7  : i64
    %6 = llvm.or %4, %5  : i64
    %7 = llvm.or %6, %3  : i64
    %8 = llvm.icmp "eq" %7, %0 : i64
    llvm.return %8 : i1
  }]

def icmp_or_sub_2_eq_before := [llvmfunc|
  llvm.func @icmp_or_sub_2_eq(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_sub_2_ne_before := [llvmfunc|
  llvm.func @icmp_or_sub_2_ne(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_sub_2_eq_fail_before := [llvmfunc|
  llvm.func @icmp_or_sub_2_eq_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_sub_2_ne_fail_before := [llvmfunc|
  llvm.func @icmp_or_sub_2_ne_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_sub_2_3_fail_before := [llvmfunc|
  llvm.func @icmp_or_sub_2_3_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.sub %arg2, %arg3  : i64
    %4 = llvm.or %2, %3  : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    %6 = llvm.icmp "eq" %2, %1 : i64
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }]

def icmp_or_sub_2_4_fail_before := [llvmfunc|
  llvm.func @icmp_or_sub_2_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.sub %arg2, %arg3  : i64
    %4 = llvm.or %2, %3  : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    %6 = llvm.icmp "eq" %3, %1 : i64
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }]

def icmp_or_sub_3_1_before := [llvmfunc|
  llvm.func @icmp_or_sub_3_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_sub_3_2_fail_before := [llvmfunc|
  llvm.func @icmp_or_sub_3_2_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_sub_3_3_before := [llvmfunc|
  llvm.func @icmp_or_sub_3_3(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_sub_3_4_fail_before := [llvmfunc|
  llvm.func @icmp_or_sub_3_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_sub_4_1_before := [llvmfunc|
  llvm.func @icmp_or_sub_4_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.sub %arg6, %arg7  : i64
    %6 = llvm.or %4, %5  : i64
    %7 = llvm.or %3, %6  : i64
    %8 = llvm.icmp "eq" %7, %0 : i64
    llvm.return %8 : i1
  }]

def icmp_or_sub_4_2_before := [llvmfunc|
  llvm.func @icmp_or_sub_4_2(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.sub %arg6, %arg7  : i64
    %6 = llvm.or %4, %5  : i64
    %7 = llvm.or %6, %3  : i64
    %8 = llvm.icmp "eq" %7, %0 : i64
    llvm.return %8 : i1
  }]

def icmp_or_xor_with_sub_2_eq_before := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_2_eq(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_xor_with_sub_2_ne_before := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_2_ne(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }]

def icmp_or_xor_with_sub_3_1_before := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_xor_with_sub_3_2_before := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_2(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_xor_with_sub_3_3_before := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_3(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_xor_with_sub_3_4_before := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_4(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_xor_with_sub_3_5_before := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_5(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def icmp_or_xor_with_sub_3_6_before := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_6(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

def or_disjoint_with_constants_before := [llvmfunc|
  llvm.func @or_disjoint_with_constants(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def or_disjoint_with_constants2_before := [llvmfunc|
  llvm.func @or_disjoint_with_constants2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(71 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.call @use(%2) : (i8) -> ()
    llvm.return %3 : i1
  }]

def or_disjoint_with_constants_fail_missing_const1_before := [llvmfunc|
  llvm.func @or_disjoint_with_constants_fail_missing_const1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def or_disjoint_with_constants_fail_missing_const2_before := [llvmfunc|
  llvm.func @or_disjoint_with_constants_fail_missing_const2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def set_low_bit_mask_eq_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(18 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_set_low_bit_mask_eq   : set_low_bit_mask_eq_before  ⊑  set_low_bit_mask_eq_combined := by
  unfold set_low_bit_mask_eq_before set_low_bit_mask_eq_combined
  simp_alive_peephole
  sorry
def set_low_bit_mask_ne_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_ne(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_set_low_bit_mask_ne   : set_low_bit_mask_ne_before  ⊑  set_low_bit_mask_ne_combined := by
  unfold set_low_bit_mask_ne_before set_low_bit_mask_ne_combined
  simp_alive_peephole
  sorry
def set_low_bit_mask_ugt_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_set_low_bit_mask_ugt   : set_low_bit_mask_ugt_before  ⊑  set_low_bit_mask_ugt_combined := by
  unfold set_low_bit_mask_ugt_before set_low_bit_mask_ugt_combined
  simp_alive_peephole
  sorry
def set_low_bit_mask_ult_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_set_low_bit_mask_ult   : set_low_bit_mask_ult_before  ⊑  set_low_bit_mask_ult_combined := by
  unfold set_low_bit_mask_ult_before set_low_bit_mask_ult_combined
  simp_alive_peephole
  sorry
def set_low_bit_mask_uge_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_uge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_set_low_bit_mask_uge   : set_low_bit_mask_uge_before  ⊑  set_low_bit_mask_uge_combined := by
  unfold set_low_bit_mask_uge_before set_low_bit_mask_uge_combined
  simp_alive_peephole
  sorry
def set_low_bit_mask_ule_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_ule(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_set_low_bit_mask_ule   : set_low_bit_mask_ule_before  ⊑  set_low_bit_mask_ule_combined := by
  unfold set_low_bit_mask_ule_before set_low_bit_mask_ule_combined
  simp_alive_peephole
  sorry
def set_low_bit_mask_sgt_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_set_low_bit_mask_sgt   : set_low_bit_mask_sgt_before  ⊑  set_low_bit_mask_sgt_combined := by
  unfold set_low_bit_mask_sgt_before set_low_bit_mask_sgt_combined
  simp_alive_peephole
  sorry
def set_low_bit_mask_slt_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_set_low_bit_mask_slt   : set_low_bit_mask_slt_before  ⊑  set_low_bit_mask_slt_combined := by
  unfold set_low_bit_mask_slt_before set_low_bit_mask_slt_combined
  simp_alive_peephole
  sorry
def set_low_bit_mask_sge_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_sge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(50 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_set_low_bit_mask_sge   : set_low_bit_mask_sge_before  ⊑  set_low_bit_mask_sge_combined := by
  unfold set_low_bit_mask_sge_before set_low_bit_mask_sge_combined
  simp_alive_peephole
  sorry
def set_low_bit_mask_sle_combined := [llvmfunc|
  llvm.func @set_low_bit_mask_sle(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(69 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_set_low_bit_mask_sle   : set_low_bit_mask_sle_before  ⊑  set_low_bit_mask_sle_combined := by
  unfold set_low_bit_mask_sle_before set_low_bit_mask_sle_combined
  simp_alive_peephole
  sorry
def eq_const_mask_combined := [llvmfunc|
  llvm.func @eq_const_mask(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-43 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %arg1  : i8
    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_eq_const_mask   : eq_const_mask_before  ⊑  eq_const_mask_combined := by
  unfold eq_const_mask_before eq_const_mask_combined
  simp_alive_peephole
  sorry
def ne_const_mask_combined := [llvmfunc|
  llvm.func @ne_const_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[105, -6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi8>
    %4 = llvm.and %3, %0  : vector<2xi8>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_ne_const_mask   : ne_const_mask_before  ⊑  ne_const_mask_combined := by
  unfold ne_const_mask_before ne_const_mask_combined
  simp_alive_peephole
  sorry
def eq_const_mask_not_equality_combined := [llvmfunc|
  llvm.func @eq_const_mask_not_equality(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.icmp "sgt" %1, %2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_eq_const_mask_not_equality   : eq_const_mask_not_equality_before  ⊑  eq_const_mask_not_equality_combined := by
  unfold eq_const_mask_not_equality_before eq_const_mask_not_equality_combined
  simp_alive_peephole
  sorry
def eq_const_mask_not_same_combined := [llvmfunc|
  llvm.func @eq_const_mask_not_same(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_eq_const_mask_not_same   : eq_const_mask_not_same_before  ⊑  eq_const_mask_not_same_combined := by
  unfold eq_const_mask_not_same_before eq_const_mask_not_same_combined
  simp_alive_peephole
  sorry
def eq_const_mask_wrong_opcode_combined := [llvmfunc|
  llvm.func @eq_const_mask_wrong_opcode(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.xor %1, %arg1  : i8
    %3 = llvm.icmp "eq" %2, %0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_eq_const_mask_wrong_opcode   : eq_const_mask_wrong_opcode_before  ⊑  eq_const_mask_wrong_opcode_combined := by
  unfold eq_const_mask_wrong_opcode_before eq_const_mask_wrong_opcode_combined
  simp_alive_peephole
  sorry
def eq_const_mask_use1_combined := [llvmfunc|
  llvm.func @eq_const_mask_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_eq_const_mask_use1   : eq_const_mask_use1_before  ⊑  eq_const_mask_use1_combined := by
  unfold eq_const_mask_use1_before eq_const_mask_use1_combined
  simp_alive_peephole
  sorry
def eq_const_mask_use2_combined := [llvmfunc|
  llvm.func @eq_const_mask_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_eq_const_mask_use2   : eq_const_mask_use2_before  ⊑  eq_const_mask_use2_combined := by
  unfold eq_const_mask_use2_before eq_const_mask_use2_combined
  simp_alive_peephole
  sorry
def decrement_slt_0_combined := [llvmfunc|
  llvm.func @decrement_slt_0(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_decrement_slt_0   : decrement_slt_0_before  ⊑  decrement_slt_0_combined := by
  unfold decrement_slt_0_before decrement_slt_0_combined
  simp_alive_peephole
  sorry
def decrement_slt_0_commute_use1_combined := [llvmfunc|
  llvm.func @decrement_slt_0_commute_use1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "slt" %3, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_decrement_slt_0_commute_use1   : decrement_slt_0_commute_use1_before  ⊑  decrement_slt_0_commute_use1_combined := by
  unfold decrement_slt_0_commute_use1_before decrement_slt_0_commute_use1_combined
  simp_alive_peephole
  sorry
def decrement_slt_0_use2_combined := [llvmfunc|
  llvm.func @decrement_slt_0_use2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_decrement_slt_0_use2   : decrement_slt_0_use2_before  ⊑  decrement_slt_0_use2_combined := by
  unfold decrement_slt_0_use2_before decrement_slt_0_use2_combined
  simp_alive_peephole
  sorry
def decrement_slt_n1_combined := [llvmfunc|
  llvm.func @decrement_slt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_decrement_slt_n1   : decrement_slt_n1_before  ⊑  decrement_slt_n1_combined := by
  unfold decrement_slt_n1_before decrement_slt_n1_combined
  simp_alive_peephole
  sorry
def not_decrement_slt_0_combined := [llvmfunc|
  llvm.func @not_decrement_slt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_not_decrement_slt_0   : not_decrement_slt_0_before  ⊑  not_decrement_slt_0_combined := by
  unfold not_decrement_slt_0_before not_decrement_slt_0_combined
  simp_alive_peephole
  sorry
def decrement_sgt_n1_combined := [llvmfunc|
  llvm.func @decrement_sgt_n1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "sgt" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_decrement_sgt_n1   : decrement_sgt_n1_before  ⊑  decrement_sgt_n1_combined := by
  unfold decrement_sgt_n1_before decrement_sgt_n1_combined
  simp_alive_peephole
  sorry
def decrement_sgt_n1_commute_use1_combined := [llvmfunc|
  llvm.func @decrement_sgt_n1_commute_use1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "sgt" %3, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_decrement_sgt_n1_commute_use1   : decrement_sgt_n1_commute_use1_before  ⊑  decrement_sgt_n1_commute_use1_combined := by
  unfold decrement_sgt_n1_commute_use1_before decrement_sgt_n1_commute_use1_combined
  simp_alive_peephole
  sorry
def decrement_sgt_n1_use2_combined := [llvmfunc|
  llvm.func @decrement_sgt_n1_use2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.icmp "sgt" %arg0, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_decrement_sgt_n1_use2   : decrement_sgt_n1_use2_before  ⊑  decrement_sgt_n1_use2_combined := by
  unfold decrement_sgt_n1_use2_before decrement_sgt_n1_use2_combined
  simp_alive_peephole
  sorry
def decrement_sgt_0_combined := [llvmfunc|
  llvm.func @decrement_sgt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "sgt" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_decrement_sgt_0   : decrement_sgt_0_before  ⊑  decrement_sgt_0_combined := by
  unfold decrement_sgt_0_before decrement_sgt_0_combined
  simp_alive_peephole
  sorry
def not_decrement_sgt_n1_combined := [llvmfunc|
  llvm.func @not_decrement_sgt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "sgt" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_not_decrement_sgt_n1   : not_decrement_sgt_n1_before  ⊑  not_decrement_sgt_n1_combined := by
  unfold not_decrement_sgt_n1_before not_decrement_sgt_n1_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_2_eq_combined := [llvmfunc|
  llvm.func @icmp_or_xor_2_eq(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_or_xor_2_eq   : icmp_or_xor_2_eq_before  ⊑  icmp_or_xor_2_eq_combined := by
  unfold icmp_or_xor_2_eq_before icmp_or_xor_2_eq_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_2_ne_combined := [llvmfunc|
  llvm.func @icmp_or_xor_2_ne(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %arg2, %arg3 : i64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_or_xor_2_ne   : icmp_or_xor_2_ne_before  ⊑  icmp_or_xor_2_ne_combined := by
  unfold icmp_or_xor_2_ne_before icmp_or_xor_2_ne_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_2_eq_fail_combined := [llvmfunc|
  llvm.func @icmp_or_xor_2_eq_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_2_eq_fail   : icmp_or_xor_2_eq_fail_before  ⊑  icmp_or_xor_2_eq_fail_combined := by
  unfold icmp_or_xor_2_eq_fail_before icmp_or_xor_2_eq_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_2_ne_fail_combined := [llvmfunc|
  llvm.func @icmp_or_xor_2_ne_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_2_ne_fail   : icmp_or_xor_2_ne_fail_before  ⊑  icmp_or_xor_2_ne_fail_combined := by
  unfold icmp_or_xor_2_ne_fail_before icmp_or_xor_2_ne_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_2_3_fail_combined := [llvmfunc|
  llvm.func @icmp_or_xor_2_3_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    %5 = llvm.icmp "eq" %1, %0 : i64
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_xor_2_3_fail   : icmp_or_xor_2_3_fail_before  ⊑  icmp_or_xor_2_3_fail_combined := by
  unfold icmp_or_xor_2_3_fail_before icmp_or_xor_2_3_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_2_4_fail_combined := [llvmfunc|
  llvm.func @icmp_or_xor_2_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    %5 = llvm.icmp "eq" %2, %0 : i64
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_xor_2_4_fail   : icmp_or_xor_2_4_fail_before  ⊑  icmp_or_xor_2_4_fail_combined := by
  unfold icmp_or_xor_2_4_fail_before icmp_or_xor_2_4_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_3_1_combined := [llvmfunc|
  llvm.func @icmp_or_xor_3_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_3_1   : icmp_or_xor_3_1_before  ⊑  icmp_or_xor_3_1_combined := by
  unfold icmp_or_xor_3_1_before icmp_or_xor_3_1_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_3_2_fail_combined := [llvmfunc|
  llvm.func @icmp_or_xor_3_2_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_xor_3_2_fail   : icmp_or_xor_3_2_fail_before  ⊑  icmp_or_xor_3_2_fail_combined := by
  unfold icmp_or_xor_3_2_fail_before icmp_or_xor_3_2_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_3_3_combined := [llvmfunc|
  llvm.func @icmp_or_xor_3_3(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_3_3   : icmp_or_xor_3_3_before  ⊑  icmp_or_xor_3_3_combined := by
  unfold icmp_or_xor_3_3_before icmp_or_xor_3_3_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_3_4_fail_combined := [llvmfunc|
  llvm.func @icmp_or_xor_3_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_xor_3_4_fail   : icmp_or_xor_3_4_fail_before  ⊑  icmp_or_xor_3_4_fail_combined := by
  unfold icmp_or_xor_3_4_fail_before icmp_or_xor_3_4_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_4_1_combined := [llvmfunc|
  llvm.func @icmp_or_xor_4_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg4, %arg5 : i64
    %1 = llvm.icmp "eq" %arg6, %arg7 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.icmp "eq" %arg2, %arg3 : i64
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_xor_4_1   : icmp_or_xor_4_1_before  ⊑  icmp_or_xor_4_1_combined := by
  unfold icmp_or_xor_4_1_before icmp_or_xor_4_1_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_4_2_combined := [llvmfunc|
  llvm.func @icmp_or_xor_4_2(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.icmp "eq" %arg6, %arg7 : i64
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_xor_4_2   : icmp_or_xor_4_2_before  ⊑  icmp_or_xor_4_2_combined := by
  unfold icmp_or_xor_4_2_before icmp_or_xor_4_2_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_2_eq_combined := [llvmfunc|
  llvm.func @icmp_or_sub_2_eq(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_or_sub_2_eq   : icmp_or_sub_2_eq_before  ⊑  icmp_or_sub_2_eq_combined := by
  unfold icmp_or_sub_2_eq_before icmp_or_sub_2_eq_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_2_ne_combined := [llvmfunc|
  llvm.func @icmp_or_sub_2_ne(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %arg2, %arg3 : i64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_or_sub_2_ne   : icmp_or_sub_2_ne_before  ⊑  icmp_or_sub_2_ne_combined := by
  unfold icmp_or_sub_2_ne_before icmp_or_sub_2_ne_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_2_eq_fail_combined := [llvmfunc|
  llvm.func @icmp_or_sub_2_eq_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_sub_2_eq_fail   : icmp_or_sub_2_eq_fail_before  ⊑  icmp_or_sub_2_eq_fail_combined := by
  unfold icmp_or_sub_2_eq_fail_before icmp_or_sub_2_eq_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_2_ne_fail_combined := [llvmfunc|
  llvm.func @icmp_or_sub_2_ne_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_sub_2_ne_fail   : icmp_or_sub_2_ne_fail_before  ⊑  icmp_or_sub_2_ne_fail_combined := by
  unfold icmp_or_sub_2_ne_fail_before icmp_or_sub_2_ne_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_2_3_fail_combined := [llvmfunc|
  llvm.func @icmp_or_sub_2_3_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.sub %arg2, %arg3  : i64
    %4 = llvm.or %2, %3  : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    %6 = llvm.icmp "eq" %2, %1 : i64
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_icmp_or_sub_2_3_fail   : icmp_or_sub_2_3_fail_before  ⊑  icmp_or_sub_2_3_fail_combined := by
  unfold icmp_or_sub_2_3_fail_before icmp_or_sub_2_3_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_2_4_fail_combined := [llvmfunc|
  llvm.func @icmp_or_sub_2_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.sub %arg2, %arg3  : i64
    %4 = llvm.or %2, %3  : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    %6 = llvm.icmp "eq" %3, %1 : i64
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_icmp_or_sub_2_4_fail   : icmp_or_sub_2_4_fail_before  ⊑  icmp_or_sub_2_4_fail_combined := by
  unfold icmp_or_sub_2_4_fail_before icmp_or_sub_2_4_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_3_1_combined := [llvmfunc|
  llvm.func @icmp_or_sub_3_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_sub_3_1   : icmp_or_sub_3_1_before  ⊑  icmp_or_sub_3_1_combined := by
  unfold icmp_or_sub_3_1_before icmp_or_sub_3_1_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_3_2_fail_combined := [llvmfunc|
  llvm.func @icmp_or_sub_3_2_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_sub_3_2_fail   : icmp_or_sub_3_2_fail_before  ⊑  icmp_or_sub_3_2_fail_combined := by
  unfold icmp_or_sub_3_2_fail_before icmp_or_sub_3_2_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_3_3_combined := [llvmfunc|
  llvm.func @icmp_or_sub_3_3(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_sub_3_3   : icmp_or_sub_3_3_before  ⊑  icmp_or_sub_3_3_combined := by
  unfold icmp_or_sub_3_3_before icmp_or_sub_3_3_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_3_4_fail_combined := [llvmfunc|
  llvm.func @icmp_or_sub_3_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_sub_3_4_fail   : icmp_or_sub_3_4_fail_before  ⊑  icmp_or_sub_3_4_fail_combined := by
  unfold icmp_or_sub_3_4_fail_before icmp_or_sub_3_4_fail_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_4_1_combined := [llvmfunc|
  llvm.func @icmp_or_sub_4_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg4, %arg5 : i64
    %1 = llvm.icmp "eq" %arg6, %arg7 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.icmp "eq" %arg2, %arg3 : i64
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_sub_4_1   : icmp_or_sub_4_1_before  ⊑  icmp_or_sub_4_1_combined := by
  unfold icmp_or_sub_4_1_before icmp_or_sub_4_1_combined
  simp_alive_peephole
  sorry
def icmp_or_sub_4_2_combined := [llvmfunc|
  llvm.func @icmp_or_sub_4_2(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    %5 = llvm.icmp "eq" %arg6, %arg7 : i64
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_icmp_or_sub_4_2   : icmp_or_sub_4_2_before  ⊑  icmp_or_sub_4_2_combined := by
  unfold icmp_or_sub_4_2_before icmp_or_sub_4_2_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_with_sub_2_eq_combined := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_2_eq(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_or_xor_with_sub_2_eq   : icmp_or_xor_with_sub_2_eq_before  ⊑  icmp_or_xor_with_sub_2_eq_combined := by
  unfold icmp_or_xor_with_sub_2_eq_before icmp_or_xor_with_sub_2_eq_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_with_sub_2_ne_combined := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_2_ne(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i64
    %1 = llvm.icmp "ne" %arg2, %arg3 : i64
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_or_xor_with_sub_2_ne   : icmp_or_xor_with_sub_2_ne_before  ⊑  icmp_or_xor_with_sub_2_ne_combined := by
  unfold icmp_or_xor_with_sub_2_ne_before icmp_or_xor_with_sub_2_ne_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_with_sub_3_1_combined := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_with_sub_3_1   : icmp_or_xor_with_sub_3_1_before  ⊑  icmp_or_xor_with_sub_3_1_combined := by
  unfold icmp_or_xor_with_sub_3_1_before icmp_or_xor_with_sub_3_1_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_with_sub_3_2_combined := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_2(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_with_sub_3_2   : icmp_or_xor_with_sub_3_2_before  ⊑  icmp_or_xor_with_sub_3_2_combined := by
  unfold icmp_or_xor_with_sub_3_2_before icmp_or_xor_with_sub_3_2_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_with_sub_3_3_combined := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_3(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_with_sub_3_3   : icmp_or_xor_with_sub_3_3_before  ⊑  icmp_or_xor_with_sub_3_3_combined := by
  unfold icmp_or_xor_with_sub_3_3_before icmp_or_xor_with_sub_3_3_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_with_sub_3_4_combined := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_4(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_with_sub_3_4   : icmp_or_xor_with_sub_3_4_before  ⊑  icmp_or_xor_with_sub_3_4_combined := by
  unfold icmp_or_xor_with_sub_3_4_before icmp_or_xor_with_sub_3_4_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_with_sub_3_5_combined := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_5(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_with_sub_3_5   : icmp_or_xor_with_sub_3_5_before  ⊑  icmp_or_xor_with_sub_3_5_combined := by
  unfold icmp_or_xor_with_sub_3_5_before icmp_or_xor_with_sub_3_5_combined
  simp_alive_peephole
  sorry
def icmp_or_xor_with_sub_3_6_combined := [llvmfunc|
  llvm.func @icmp_or_xor_with_sub_3_6(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i64
    %1 = llvm.icmp "eq" %arg2, %arg3 : i64
    %2 = llvm.and %0, %1  : i1
    %3 = llvm.icmp "eq" %arg4, %arg5 : i64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_or_xor_with_sub_3_6   : icmp_or_xor_with_sub_3_6_before  ⊑  icmp_or_xor_with_sub_3_6_combined := by
  unfold icmp_or_xor_with_sub_3_6_before icmp_or_xor_with_sub_3_6_combined
  simp_alive_peephole
  sorry
def or_disjoint_with_constants_combined := [llvmfunc|
  llvm.func @or_disjoint_with_constants(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(18 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_or_disjoint_with_constants   : or_disjoint_with_constants_before  ⊑  or_disjoint_with_constants_combined := by
  unfold or_disjoint_with_constants_before or_disjoint_with_constants_combined
  simp_alive_peephole
  sorry
def or_disjoint_with_constants2_combined := [llvmfunc|
  llvm.func @or_disjoint_with_constants2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(71 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.call @use(%2) : (i8) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_or_disjoint_with_constants2   : or_disjoint_with_constants2_before  ⊑  or_disjoint_with_constants2_combined := by
  unfold or_disjoint_with_constants2_before or_disjoint_with_constants2_combined
  simp_alive_peephole
  sorry
def or_disjoint_with_constants_fail_missing_const1_combined := [llvmfunc|
  llvm.func @or_disjoint_with_constants_fail_missing_const1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_or_disjoint_with_constants_fail_missing_const1   : or_disjoint_with_constants_fail_missing_const1_before  ⊑  or_disjoint_with_constants_fail_missing_const1_combined := by
  unfold or_disjoint_with_constants_fail_missing_const1_before or_disjoint_with_constants_fail_missing_const1_combined
  simp_alive_peephole
  sorry
def or_disjoint_with_constants_fail_missing_const2_combined := [llvmfunc|
  llvm.func @or_disjoint_with_constants_fail_missing_const2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_or_disjoint_with_constants_fail_missing_const2   : or_disjoint_with_constants_fail_missing_const2_before  ⊑  or_disjoint_with_constants_fail_missing_const2_combined := by
  unfold or_disjoint_with_constants_fail_missing_const2_before or_disjoint_with_constants_fail_missing_const2_combined
  simp_alive_peephole
  sorry
