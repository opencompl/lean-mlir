import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-minmax
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def max_na_b_minux_na_before := [llvmfunc|
  llvm.func @max_na_b_minux_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.sub %3, %1  : i32
    llvm.return %4 : i32
  }]

def na_minus_max_na_b_before := [llvmfunc|
  llvm.func @na_minus_max_na_b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ult" %1, %arg1 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def sub_umin_before := [llvmfunc|
  llvm.func @sub_umin(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i5, i5) -> i5
    %1 = llvm.sub %arg0, %0  : i5
    llvm.return %1 : i5
  }]

def sub_umin_commute_vec_before := [llvmfunc|
  llvm.func @sub_umin_commute_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.sub %arg1, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def sub_umin_uses_before := [llvmfunc|
  llvm.func @sub_umin_uses(%arg0: i5, %arg1: i5, %arg2: !llvm.ptr) -> i5 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i5, i5) -> i5
    llvm.store %0, %arg2 {alignment = 1 : i64} : i5, !llvm.ptr]

    %1 = llvm.sub %arg0, %0  : i5
    llvm.return %1 : i5
  }]

def sub_umin_no_common_op_before := [llvmfunc|
  llvm.func @sub_umin_no_common_op(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i5, i5) -> i5
    %1 = llvm.sub %arg2, %0  : i5
    llvm.return %1 : i5
  }]

def max_b_na_minus_na_before := [llvmfunc|
  llvm.func @max_b_na_minus_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.sub %3, %1  : i32
    llvm.return %4 : i32
  }]

def na_minus_max_b_na_before := [llvmfunc|
  llvm.func @na_minus_max_b_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.icmp "ugt" %1, %arg1 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

def max_na_bi_minux_na_before := [llvmfunc|
  llvm.func @max_na_bi_minux_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %2  : i32
    llvm.return %5 : i32
  }]

def na_minus_max_na_bi_before := [llvmfunc|
  llvm.func @na_minus_max_na_bi(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %2, %4  : i32
    llvm.return %5 : i32
  }]

def max_bi_na_minus_na_before := [llvmfunc|
  llvm.func @max_bi_na_minus_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.sub %4, %2  : i32
    llvm.return %5 : i32
  }]

def na_minus_max_bi_na_before := [llvmfunc|
  llvm.func @na_minus_max_bi_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.sub %2, %4  : i32
    llvm.return %5 : i32
  }]

def max_na_bi_minux_na_use_before := [llvmfunc|
  llvm.func @max_na_bi_minux_na_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def na_minus_max_na_bi_use_before := [llvmfunc|
  llvm.func @na_minus_max_na_bi_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %2, %4  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def max_bi_na_minus_na_use_before := [llvmfunc|
  llvm.func @max_bi_na_minus_na_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def na_minus_max_bi_na_use_before := [llvmfunc|
  llvm.func @na_minus_max_bi_na_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %1, %4  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.return %5 : i32
  }]

def max_na_bi_minux_na_use2_before := [llvmfunc|
  llvm.func @max_na_bi_minux_na_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

def na_minus_max_na_bi_use2_before := [llvmfunc|
  llvm.func @na_minus_max_na_bi_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %2, %4  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %5 : i32
  }]

def max_bi_na_minus_na_use2_before := [llvmfunc|
  llvm.func @max_bi_na_minus_na_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %4, %1  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %5 : i32
  }]

def na_minus_max_bi_na_use2_before := [llvmfunc|
  llvm.func @na_minus_max_bi_na_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.xor %arg1, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    %5 = llvm.sub %1, %4  : i32
    llvm.call @use32(%4) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %5 : i32
  }]

def umin_not_sub_before := [llvmfunc|
  llvm.func @umin_not_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    %5 = llvm.sub %1, %4  : i8
    %6 = llvm.sub %2, %4  : i8
    llvm.call @use8(%5) : (i8) -> ()
    llvm.call @use8(%6) : (i8) -> ()
    llvm.return %4 : i8
  }]

def umin_not_sub_rev_before := [llvmfunc|
  llvm.func @umin_not_sub_rev(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    %5 = llvm.sub %4, %1  : i8
    %6 = llvm.sub %4, %2  : i8
    llvm.call @use8(%5) : (i8) -> ()
    llvm.call @use8(%6) : (i8) -> ()
    llvm.return %4 : i8
  }]

def umin3_not_all_ops_extra_uses_invert_subs_before := [llvmfunc|
  llvm.func @umin3_not_all_ops_extra_uses_invert_subs(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    %5 = llvm.select %4, %1, %3 : i1, i8
    %6 = llvm.icmp "ult" %5, %2 : i8
    %7 = llvm.select %6, %5, %2 : i1, i8
    %8 = llvm.sub %1, %7  : i8
    %9 = llvm.sub %2, %7  : i8
    %10 = llvm.sub %3, %7  : i8
    llvm.call @use8(%7) : (i8) -> ()
    llvm.call @use8(%8) : (i8) -> ()
    llvm.call @use8(%9) : (i8) -> ()
    llvm.call @use8(%10) : (i8) -> ()
    llvm.return
  }]

def umin_not_sub_intrinsic_commute0_before := [llvmfunc|
  llvm.func @umin_not_sub_intrinsic_commute0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def umax_not_sub_intrinsic_commute1_before := [llvmfunc|
  llvm.func @umax_not_sub_intrinsic_commute1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.umax(%2, %1)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def smin_not_sub_intrinsic_commute2_before := [llvmfunc|
  llvm.func @smin_not_sub_intrinsic_commute2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %3, %1  : i8
    llvm.return %4 : i8
  }]

def smax_not_sub_intrinsic_commute3_before := [llvmfunc|
  llvm.func @smax_not_sub_intrinsic_commute3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.smax(%2, %1)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %3, %1  : i8
    llvm.return %4 : i8
  }]

def umin_not_sub_intrinsic_uses_before := [llvmfunc|
  llvm.func @umin_not_sub_intrinsic_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

def umax_sub_op0_before := [llvmfunc|
  llvm.func @umax_sub_op0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def umax_sub_op0_vec_commute_before := [llvmfunc|
  llvm.func @umax_sub_op0_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.sub %0, %arg1  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def umax_sub_op0_use_before := [llvmfunc|
  llvm.func @umax_sub_op0_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def umax_sub_op1_before := [llvmfunc|
  llvm.func @umax_sub_op1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def umax_sub_op1_vec_commute_before := [llvmfunc|
  llvm.func @umax_sub_op1_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.sub %arg1, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def umax_sub_op1_use_before := [llvmfunc|
  llvm.func @umax_sub_op1_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def umin_sub_op1_before := [llvmfunc|
  llvm.func @umin_sub_op1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def umin_sub_op1_commute_before := [llvmfunc|
  llvm.func @umin_sub_op1_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def umin_sub_op0_before := [llvmfunc|
  llvm.func @umin_sub_op0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def umin_sub_op0_commute_before := [llvmfunc|
  llvm.func @umin_sub_op0_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def umin_sub_op1_use_before := [llvmfunc|
  llvm.func @umin_sub_op1_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

def umin_sub_op0_use_before := [llvmfunc|
  llvm.func @umin_sub_op0_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

def diff_add_smin_before := [llvmfunc|
  llvm.func @diff_add_smin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def diff_add_smax_before := [llvmfunc|
  llvm.func @diff_add_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def diff_add_umin_before := [llvmfunc|
  llvm.func @diff_add_umin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def diff_add_umax_before := [llvmfunc|
  llvm.func @diff_add_umax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def diff_add_smin_use_before := [llvmfunc|
  llvm.func @diff_add_smin_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

def diff_add_use_smax_before := [llvmfunc|
  llvm.func @diff_add_use_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.smax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return %2 : i8
  }]

def diff_add_use_umin_use_before := [llvmfunc|
  llvm.func @diff_add_use_umin_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.call @use8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

def sub_add_umin_before := [llvmfunc|
  llvm.func @sub_add_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def sub_add_umin_commute_umin_before := [llvmfunc|
  llvm.func @sub_add_umin_commute_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg2, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def sub_add_umin_commute_add_before := [llvmfunc|
  llvm.func @sub_add_umin_commute_add(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg0  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def sub_add_umin_commute_add_umin_before := [llvmfunc|
  llvm.func @sub_add_umin_commute_add_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg0  : i8
    %1 = llvm.intr.umin(%arg2, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def sub_add_umin_vec_before := [llvmfunc|
  llvm.func @sub_add_umin_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.add %arg0, %arg1  : vector<2xi8>
    %1 = llvm.intr.umin(%arg1, %arg2)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %0, %1  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def sub_add_umin_mismatch_before := [llvmfunc|
  llvm.func @sub_add_umin_mismatch(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg3, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

def sub_add_umin_use_a_before := [llvmfunc|
  llvm.func @sub_add_umin_use_a(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return %2 : i8
  }]

def sub_add_umin_use_m_before := [llvmfunc|
  llvm.func @sub_add_umin_use_m(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

def sub_smax0_sub_nsw_before := [llvmfunc|
  llvm.func @sub_smax0_sub_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %8 = llvm.intr.smax(%7, %6)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %9 = llvm.sub %arg0, %8  : vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }]

def sub_smax0_sub_nsw_use_before := [llvmfunc|
  llvm.func @sub_smax0_sub_nsw_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def sub_smax0_sub_before := [llvmfunc|
  llvm.func @sub_smax0_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def sub_smax0_sub_commute_before := [llvmfunc|
  llvm.func @sub_smax0_sub_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

def sub_smin0_sub_nsw_use_before := [llvmfunc|
  llvm.func @sub_smin0_sub_nsw_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def sub_smin0_sub_nsw_before := [llvmfunc|
  llvm.func @sub_smin0_sub_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.intr.smin(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %4 = llvm.sub %arg0, %3  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def sub_smin0_sub_before := [llvmfunc|
  llvm.func @sub_smin0_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def sub_smin0_sub_nsw_commute_before := [llvmfunc|
  llvm.func @sub_smin0_sub_nsw_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

def sub_max_min_nsw_before := [llvmfunc|
  llvm.func @sub_max_min_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

def sub_max_min_nuw_before := [llvmfunc|
  llvm.func @sub_max_min_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %1, %0 overflow<nuw>  : i8
    llvm.return %2 : i8
  }]

def sub_max_min_nsw_commute_before := [llvmfunc|
  llvm.func @sub_max_min_nsw_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

def sub_max_min_nuw_commute_before := [llvmfunc|
  llvm.func @sub_max_min_nuw_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %1, %0 overflow<nuw>  : i8
    llvm.return %2 : i8
  }]

def sub_max_min_vec_nsw_before := [llvmfunc|
  llvm.func @sub_max_min_vec_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %1, %0 overflow<nsw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def sub_max_min_vec_nuw_before := [llvmfunc|
  llvm.func @sub_max_min_vec_nuw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %1, %0 overflow<nuw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def sub_max_min_vec_nsw_commute_before := [llvmfunc|
  llvm.func @sub_max_min_vec_nsw_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %1, %0 overflow<nsw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def sub_max_min_vec_nuw_commute_before := [llvmfunc|
  llvm.func @sub_max_min_vec_nuw_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.sub %1, %0 overflow<nuw>  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def sub_max_min_multi_use_before := [llvmfunc|
  llvm.func @sub_max_min_multi_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

def sub_max_min_vec_multi_use_before := [llvmfunc|
  llvm.func @sub_max_min_vec_multi_use(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.addressof @use8v2 : !llvm.ptr
    %1 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.call %0(%1) : !llvm.ptr, (vector<2xi8>) -> ()
    %2 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.call %0(%2) : !llvm.ptr, (vector<2xi8>) -> ()
    %3 = llvm.sub %2, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def max_na_b_minux_na_combined := [llvmfunc|
  llvm.func @max_na_b_minux_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.intr.usub.sat(%2, %arg1)  : (i32, i32) -> i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_max_na_b_minux_na   : max_na_b_minux_na_before  ⊑  max_na_b_minux_na_combined := by
  unfold max_na_b_minux_na_before max_na_b_minux_na_combined
  simp_alive_peephole
  sorry
def na_minus_max_na_b_combined := [llvmfunc|
  llvm.func @na_minus_max_na_b(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.usub.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_na_minus_max_na_b   : na_minus_max_na_b_before  ⊑  na_minus_max_na_b_combined := by
  unfold na_minus_max_na_b_before na_minus_max_na_b_combined
  simp_alive_peephole
  sorry
def sub_umin_combined := [llvmfunc|
  llvm.func @sub_umin(%arg0: i5, %arg1: i5) -> i5 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i5, i5) -> i5
    llvm.return %0 : i5
  }]

theorem inst_combine_sub_umin   : sub_umin_before  ⊑  sub_umin_combined := by
  unfold sub_umin_before sub_umin_combined
  simp_alive_peephole
  sorry
def sub_umin_commute_vec_combined := [llvmfunc|
  llvm.func @sub_umin_commute_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.usub.sat(%arg1, %arg0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_sub_umin_commute_vec   : sub_umin_commute_vec_before  ⊑  sub_umin_commute_vec_combined := by
  unfold sub_umin_commute_vec_before sub_umin_commute_vec_combined
  simp_alive_peephole
  sorry
def sub_umin_uses_combined := [llvmfunc|
  llvm.func @sub_umin_uses(%arg0: i5, %arg1: i5, %arg2: !llvm.ptr) -> i5 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i5, i5) -> i5
    llvm.store %0, %arg2 {alignment = 1 : i64} : i5, !llvm.ptr
    %1 = llvm.sub %arg0, %0  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_sub_umin_uses   : sub_umin_uses_before  ⊑  sub_umin_uses_combined := by
  unfold sub_umin_uses_before sub_umin_uses_combined
  simp_alive_peephole
  sorry
def sub_umin_no_common_op_combined := [llvmfunc|
  llvm.func @sub_umin_no_common_op(%arg0: i5, %arg1: i5, %arg2: i5) -> i5 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i5, i5) -> i5
    %1 = llvm.sub %arg2, %0  : i5
    llvm.return %1 : i5
  }]

theorem inst_combine_sub_umin_no_common_op   : sub_umin_no_common_op_before  ⊑  sub_umin_no_common_op_combined := by
  unfold sub_umin_no_common_op_before sub_umin_no_common_op_combined
  simp_alive_peephole
  sorry
def max_b_na_minus_na_combined := [llvmfunc|
  llvm.func @max_b_na_minus_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.intr.usub.sat(%2, %arg1)  : (i32, i32) -> i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_max_b_na_minus_na   : max_b_na_minus_na_before  ⊑  max_b_na_minus_na_combined := by
  unfold max_b_na_minus_na_before max_b_na_minus_na_combined
  simp_alive_peephole
  sorry
def na_minus_max_b_na_combined := [llvmfunc|
  llvm.func @na_minus_max_b_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.usub.sat(%1, %arg1)  : (i32, i32) -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_na_minus_max_b_na   : na_minus_max_b_na_before  ⊑  na_minus_max_b_na_combined := by
  unfold na_minus_max_b_na_before na_minus_max_b_na_combined
  simp_alive_peephole
  sorry
def max_na_bi_minux_na_combined := [llvmfunc|
  llvm.func @max_na_bi_minux_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.usub.sat(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_max_na_bi_minux_na   : max_na_bi_minux_na_before  ⊑  max_na_bi_minux_na_combined := by
  unfold max_na_bi_minux_na_before max_na_bi_minux_na_combined
  simp_alive_peephole
  sorry
def na_minus_max_na_bi_combined := [llvmfunc|
  llvm.func @na_minus_max_na_bi(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.usub.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_na_minus_max_na_bi   : na_minus_max_na_bi_before  ⊑  na_minus_max_na_bi_combined := by
  unfold na_minus_max_na_bi_before na_minus_max_na_bi_combined
  simp_alive_peephole
  sorry
def max_bi_na_minus_na_combined := [llvmfunc|
  llvm.func @max_bi_na_minus_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.intr.usub.sat(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.sub %0, %1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_max_bi_na_minus_na   : max_bi_na_minus_na_before  ⊑  max_bi_na_minus_na_combined := by
  unfold max_bi_na_minus_na_before max_bi_na_minus_na_combined
  simp_alive_peephole
  sorry
def na_minus_max_bi_na_combined := [llvmfunc|
  llvm.func @na_minus_max_bi_na(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.usub.sat(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_na_minus_max_bi_na   : na_minus_max_bi_na_before  ⊑  na_minus_max_bi_na_combined := by
  unfold na_minus_max_bi_na_before na_minus_max_bi_na_combined
  simp_alive_peephole
  sorry
def max_na_bi_minux_na_use_combined := [llvmfunc|
  llvm.func @max_na_bi_minux_na_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.sub %arg0, %2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_max_na_bi_minux_na_use   : max_na_bi_minux_na_use_before  ⊑  max_na_bi_minux_na_use_combined := by
  unfold max_na_bi_minux_na_use_before max_na_bi_minux_na_use_combined
  simp_alive_peephole
  sorry
def na_minus_max_na_bi_use_combined := [llvmfunc|
  llvm.func @na_minus_max_na_bi_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.umax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.sub %2, %arg0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_na_minus_max_na_bi_use   : na_minus_max_na_bi_use_before  ⊑  na_minus_max_na_bi_use_combined := by
  unfold na_minus_max_na_bi_use_before na_minus_max_na_bi_use_combined
  simp_alive_peephole
  sorry
def max_bi_na_minus_na_use_combined := [llvmfunc|
  llvm.func @max_bi_na_minus_na_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.sub %arg0, %1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_max_bi_na_minus_na_use   : max_bi_na_minus_na_use_before  ⊑  max_bi_na_minus_na_use_combined := by
  unfold max_bi_na_minus_na_use_before max_bi_na_minus_na_use_combined
  simp_alive_peephole
  sorry
def na_minus_max_bi_na_use_combined := [llvmfunc|
  llvm.func @na_minus_max_bi_na_use(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.sub %1, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_na_minus_max_bi_na_use   : na_minus_max_bi_na_use_before  ⊑  na_minus_max_bi_na_use_combined := by
  unfold na_minus_max_bi_na_use_before na_minus_max_bi_na_use_combined
  simp_alive_peephole
  sorry
def max_na_bi_minux_na_use2_combined := [llvmfunc|
  llvm.func @max_na_bi_minux_na_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.intr.umin(%2, %1)  : (i32, i32) -> i32
    %4 = llvm.sub %3, %2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_max_na_bi_minux_na_use2   : max_na_bi_minux_na_use2_before  ⊑  max_na_bi_minux_na_use2_combined := by
  unfold max_na_bi_minux_na_use2_before max_na_bi_minux_na_use2_combined
  simp_alive_peephole
  sorry
def na_minus_max_na_bi_use2_combined := [llvmfunc|
  llvm.func @na_minus_max_na_bi_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.intr.umin(%2, %1)  : (i32, i32) -> i32
    %4 = llvm.sub %2, %3  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%2) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_na_minus_max_na_bi_use2   : na_minus_max_na_bi_use2_before  ⊑  na_minus_max_na_bi_use2_combined := by
  unfold na_minus_max_na_bi_use2_before na_minus_max_na_bi_use2_combined
  simp_alive_peephole
  sorry
def max_bi_na_minus_na_use2_combined := [llvmfunc|
  llvm.func @max_bi_na_minus_na_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.sub %arg0, %2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_max_bi_na_minus_na_use2   : max_bi_na_minus_na_use2_before  ⊑  max_bi_na_minus_na_use2_combined := by
  unfold max_bi_na_minus_na_use2_before max_bi_na_minus_na_use2_combined
  simp_alive_peephole
  sorry
def na_minus_max_bi_na_use2_combined := [llvmfunc|
  llvm.func @na_minus_max_bi_na_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %3 = llvm.xor %2, %0  : i32
    %4 = llvm.sub %2, %arg0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    llvm.call @use32(%1) : (i32) -> ()
    llvm.return %4 : i32
  }]

theorem inst_combine_na_minus_max_bi_na_use2   : na_minus_max_bi_na_use2_before  ⊑  na_minus_max_bi_na_use2_combined := by
  unfold na_minus_max_bi_na_use2_before na_minus_max_bi_na_use2_combined
  simp_alive_peephole
  sorry
def umin_not_sub_combined := [llvmfunc|
  llvm.func @umin_not_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.sub %1, %arg0  : i8
    %4 = llvm.sub %1, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    llvm.call @use8(%4) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_not_sub   : umin_not_sub_before  ⊑  umin_not_sub_combined := by
  unfold umin_not_sub_before umin_not_sub_combined
  simp_alive_peephole
  sorry
def umin_not_sub_rev_combined := [llvmfunc|
  llvm.func @umin_not_sub_rev(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.sub %arg0, %1  : i8
    %4 = llvm.sub %arg1, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    llvm.call @use8(%4) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_not_sub_rev   : umin_not_sub_rev_before  ⊑  umin_not_sub_rev_combined := by
  unfold umin_not_sub_rev_before umin_not_sub_rev_combined
  simp_alive_peephole
  sorry
def umin3_not_all_ops_extra_uses_invert_subs_combined := [llvmfunc|
  llvm.func @umin3_not_all_ops_extra_uses_invert_subs(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg2)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%arg1, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use8(%3) : (i8) -> ()
    llvm.call @use8(%4) : (i8) -> ()
    llvm.call @use8(%5) : (i8) -> ()
    llvm.call @use8(%6) : (i8) -> ()
    llvm.return
  }]

theorem inst_combine_umin3_not_all_ops_extra_uses_invert_subs   : umin3_not_all_ops_extra_uses_invert_subs_before  ⊑  umin3_not_all_ops_extra_uses_invert_subs_combined := by
  unfold umin3_not_all_ops_extra_uses_invert_subs_before umin3_not_all_ops_extra_uses_invert_subs_combined
  simp_alive_peephole
  sorry
def umin_not_sub_intrinsic_commute0_combined := [llvmfunc|
  llvm.func @umin_not_sub_intrinsic_commute0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %2, %arg0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_umin_not_sub_intrinsic_commute0   : umin_not_sub_intrinsic_commute0_before  ⊑  umin_not_sub_intrinsic_commute0_combined := by
  unfold umin_not_sub_intrinsic_commute0_before umin_not_sub_intrinsic_commute0_combined
  simp_alive_peephole
  sorry
def umax_not_sub_intrinsic_commute1_combined := [llvmfunc|
  llvm.func @umax_not_sub_intrinsic_commute1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %2, %arg0  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_umax_not_sub_intrinsic_commute1   : umax_not_sub_intrinsic_commute1_before  ⊑  umax_not_sub_intrinsic_commute1_combined := by
  unfold umax_not_sub_intrinsic_commute1_before umax_not_sub_intrinsic_commute1_combined
  simp_alive_peephole
  sorry
def smin_not_sub_intrinsic_commute2_combined := [llvmfunc|
  llvm.func @smin_not_sub_intrinsic_commute2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %arg0, %2  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_smin_not_sub_intrinsic_commute2   : smin_not_sub_intrinsic_commute2_before  ⊑  smin_not_sub_intrinsic_commute2_combined := by
  unfold smin_not_sub_intrinsic_commute2_before smin_not_sub_intrinsic_commute2_combined
  simp_alive_peephole
  sorry
def smax_not_sub_intrinsic_commute3_combined := [llvmfunc|
  llvm.func @smax_not_sub_intrinsic_commute3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %arg0, %2  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_smax_not_sub_intrinsic_commute3   : smax_not_sub_intrinsic_commute3_before  ⊑  smax_not_sub_intrinsic_commute3_combined := by
  unfold smax_not_sub_intrinsic_commute3_before smax_not_sub_intrinsic_commute3_combined
  simp_alive_peephole
  sorry
def umin_not_sub_intrinsic_uses_combined := [llvmfunc|
  llvm.func @umin_not_sub_intrinsic_uses(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %arg1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.sub %1, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_umin_not_sub_intrinsic_uses   : umin_not_sub_intrinsic_uses_before  ⊑  umin_not_sub_intrinsic_uses_combined := by
  unfold umin_not_sub_intrinsic_uses_before umin_not_sub_intrinsic_uses_combined
  simp_alive_peephole
  sorry
def umax_sub_op0_combined := [llvmfunc|
  llvm.func @umax_sub_op0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_umax_sub_op0   : umax_sub_op0_before  ⊑  umax_sub_op0_combined := by
  unfold umax_sub_op0_before umax_sub_op0_combined
  simp_alive_peephole
  sorry
def umax_sub_op0_vec_commute_combined := [llvmfunc|
  llvm.func @umax_sub_op0_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.usub.sat(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_umax_sub_op0_vec_commute   : umax_sub_op0_vec_commute_before  ⊑  umax_sub_op0_vec_commute_combined := by
  unfold umax_sub_op0_vec_commute_before umax_sub_op0_vec_commute_combined
  simp_alive_peephole
  sorry
def umax_sub_op0_use_combined := [llvmfunc|
  llvm.func @umax_sub_op0_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umax_sub_op0_use   : umax_sub_op0_use_before  ⊑  umax_sub_op0_use_combined := by
  unfold umax_sub_op0_use_before umax_sub_op0_use_combined
  simp_alive_peephole
  sorry
def umax_sub_op1_combined := [llvmfunc|
  llvm.func @umax_sub_op1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umax_sub_op1   : umax_sub_op1_before  ⊑  umax_sub_op1_combined := by
  unfold umax_sub_op1_before umax_sub_op1_combined
  simp_alive_peephole
  sorry
def umax_sub_op1_vec_commute_combined := [llvmfunc|
  llvm.func @umax_sub_op1_vec_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.sub %1, %2  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_umax_sub_op1_vec_commute   : umax_sub_op1_vec_commute_before  ⊑  umax_sub_op1_vec_commute_combined := by
  unfold umax_sub_op1_vec_commute_before umax_sub_op1_vec_commute_combined
  simp_alive_peephole
  sorry
def umax_sub_op1_use_combined := [llvmfunc|
  llvm.func @umax_sub_op1_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umax_sub_op1_use   : umax_sub_op1_use_before  ⊑  umax_sub_op1_use_combined := by
  unfold umax_sub_op1_use_before umax_sub_op1_use_combined
  simp_alive_peephole
  sorry
def umin_sub_op1_combined := [llvmfunc|
  llvm.func @umin_sub_op1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_umin_sub_op1   : umin_sub_op1_before  ⊑  umin_sub_op1_combined := by
  unfold umin_sub_op1_before umin_sub_op1_combined
  simp_alive_peephole
  sorry
def umin_sub_op1_commute_combined := [llvmfunc|
  llvm.func @umin_sub_op1_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_umin_sub_op1_commute   : umin_sub_op1_commute_before  ⊑  umin_sub_op1_commute_combined := by
  unfold umin_sub_op1_commute_before umin_sub_op1_commute_combined
  simp_alive_peephole
  sorry
def umin_sub_op0_combined := [llvmfunc|
  llvm.func @umin_sub_op0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_sub_op0   : umin_sub_op0_before  ⊑  umin_sub_op0_combined := by
  unfold umin_sub_op0_before umin_sub_op0_combined
  simp_alive_peephole
  sorry
def umin_sub_op0_commute_combined := [llvmfunc|
  llvm.func @umin_sub_op0_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_umin_sub_op0_commute   : umin_sub_op0_commute_before  ⊑  umin_sub_op0_commute_combined := by
  unfold umin_sub_op0_commute_before umin_sub_op0_commute_combined
  simp_alive_peephole
  sorry
def umin_sub_op1_use_combined := [llvmfunc|
  llvm.func @umin_sub_op1_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %arg1, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umin_sub_op1_use   : umin_sub_op1_use_before  ⊑  umin_sub_op1_use_combined := by
  unfold umin_sub_op1_use_before umin_sub_op1_use_combined
  simp_alive_peephole
  sorry
def umin_sub_op0_use_combined := [llvmfunc|
  llvm.func @umin_sub_op0_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %0, %arg1  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umin_sub_op0_use   : umin_sub_op0_use_before  ⊑  umin_sub_op0_use_combined := by
  unfold umin_sub_op0_use_before umin_sub_op0_use_combined
  simp_alive_peephole
  sorry
def diff_add_smin_combined := [llvmfunc|
  llvm.func @diff_add_smin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_diff_add_smin   : diff_add_smin_before  ⊑  diff_add_smin_combined := by
  unfold diff_add_smin_before diff_add_smin_combined
  simp_alive_peephole
  sorry
def diff_add_smax_combined := [llvmfunc|
  llvm.func @diff_add_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_diff_add_smax   : diff_add_smax_before  ⊑  diff_add_smax_combined := by
  unfold diff_add_smax_before diff_add_smax_combined
  simp_alive_peephole
  sorry
def diff_add_umin_combined := [llvmfunc|
  llvm.func @diff_add_umin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_diff_add_umin   : diff_add_umin_before  ⊑  diff_add_umin_combined := by
  unfold diff_add_umin_before diff_add_umin_combined
  simp_alive_peephole
  sorry
def diff_add_umax_combined := [llvmfunc|
  llvm.func @diff_add_umax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_diff_add_umax   : diff_add_umax_before  ⊑  diff_add_umax_combined := by
  unfold diff_add_umax_before diff_add_umax_combined
  simp_alive_peephole
  sorry
def diff_add_smin_use_combined := [llvmfunc|
  llvm.func @diff_add_smin_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return %1 : i8
  }]

theorem inst_combine_diff_add_smin_use   : diff_add_smin_use_before  ⊑  diff_add_smin_use_combined := by
  unfold diff_add_smin_use_before diff_add_smin_use_combined
  simp_alive_peephole
  sorry
def diff_add_use_smax_combined := [llvmfunc|
  llvm.func @diff_add_use_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.smin(%arg1, %arg0)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return %1 : i8
  }]

theorem inst_combine_diff_add_use_smax   : diff_add_use_smax_before  ⊑  diff_add_use_smax_combined := by
  unfold diff_add_use_smax_before diff_add_use_smax_combined
  simp_alive_peephole
  sorry
def diff_add_use_umin_use_combined := [llvmfunc|
  llvm.func @diff_add_use_umin_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.call @use8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_diff_add_use_umin_use   : diff_add_use_umin_use_before  ⊑  diff_add_use_umin_use_combined := by
  unfold diff_add_use_umin_use_before diff_add_use_umin_use_combined
  simp_alive_peephole
  sorry
def sub_add_umin_combined := [llvmfunc|
  llvm.func @sub_add_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg1, %arg2)  : (i8, i8) -> i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_add_umin   : sub_add_umin_before  ⊑  sub_add_umin_combined := by
  unfold sub_add_umin_before sub_add_umin_combined
  simp_alive_peephole
  sorry
def sub_add_umin_commute_umin_combined := [llvmfunc|
  llvm.func @sub_add_umin_commute_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg1, %arg2)  : (i8, i8) -> i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_add_umin_commute_umin   : sub_add_umin_commute_umin_before  ⊑  sub_add_umin_commute_umin_combined := by
  unfold sub_add_umin_commute_umin_before sub_add_umin_commute_umin_combined
  simp_alive_peephole
  sorry
def sub_add_umin_commute_add_combined := [llvmfunc|
  llvm.func @sub_add_umin_commute_add(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg1, %arg2)  : (i8, i8) -> i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_add_umin_commute_add   : sub_add_umin_commute_add_before  ⊑  sub_add_umin_commute_add_combined := by
  unfold sub_add_umin_commute_add_before sub_add_umin_commute_add_combined
  simp_alive_peephole
  sorry
def sub_add_umin_commute_add_umin_combined := [llvmfunc|
  llvm.func @sub_add_umin_commute_add_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.intr.usub.sat(%arg1, %arg2)  : (i8, i8) -> i8
    %1 = llvm.add %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_add_umin_commute_add_umin   : sub_add_umin_commute_add_umin_before  ⊑  sub_add_umin_commute_add_umin_combined := by
  unfold sub_add_umin_commute_add_umin_before sub_add_umin_commute_add_umin_combined
  simp_alive_peephole
  sorry
def sub_add_umin_vec_combined := [llvmfunc|
  llvm.func @sub_add_umin_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>, %arg2: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.usub.sat(%arg1, %arg2)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.add %0, %arg0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_sub_add_umin_vec   : sub_add_umin_vec_before  ⊑  sub_add_umin_vec_combined := by
  unfold sub_add_umin_vec_before sub_add_umin_vec_combined
  simp_alive_peephole
  sorry
def sub_add_umin_mismatch_combined := [llvmfunc|
  llvm.func @sub_add_umin_mismatch(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg3, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_add_umin_mismatch   : sub_add_umin_mismatch_before  ⊑  sub_add_umin_mismatch_combined := by
  unfold sub_add_umin_mismatch_before sub_add_umin_mismatch_combined
  simp_alive_peephole
  sorry
def sub_add_umin_use_a_combined := [llvmfunc|
  llvm.func @sub_add_umin_use_a(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_add_umin_use_a   : sub_add_umin_use_a_before  ⊑  sub_add_umin_use_a_combined := by
  unfold sub_add_umin_use_a_before sub_add_umin_use_a_combined
  simp_alive_peephole
  sorry
def sub_add_umin_use_m_combined := [llvmfunc|
  llvm.func @sub_add_umin_use_m(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    %1 = llvm.intr.umin(%arg1, %arg2)  : (i8, i8) -> i8
    %2 = llvm.sub %0, %1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_add_umin_use_m   : sub_add_umin_use_m_before  ⊑  sub_add_umin_use_m_combined := by
  unfold sub_add_umin_use_m_before sub_add_umin_use_m_combined
  simp_alive_peephole
  sorry
def sub_smax0_sub_nsw_combined := [llvmfunc|
  llvm.func @sub_smax0_sub_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_sub_smax0_sub_nsw   : sub_smax0_sub_nsw_before  ⊑  sub_smax0_sub_nsw_combined := by
  unfold sub_smax0_sub_nsw_before sub_smax0_sub_nsw_combined
  simp_alive_peephole
  sorry
def sub_smax0_sub_nsw_use_combined := [llvmfunc|
  llvm.func @sub_smax0_sub_nsw_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_smax0_sub_nsw_use   : sub_smax0_sub_nsw_use_before  ⊑  sub_smax0_sub_nsw_use_combined := by
  unfold sub_smax0_sub_nsw_use_before sub_smax0_sub_nsw_use_combined
  simp_alive_peephole
  sorry
def sub_smax0_sub_combined := [llvmfunc|
  llvm.func @sub_smax0_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_smax0_sub   : sub_smax0_sub_before  ⊑  sub_smax0_sub_combined := by
  unfold sub_smax0_sub_before sub_smax0_sub_combined
  simp_alive_peephole
  sorry
def sub_smax0_sub_commute_combined := [llvmfunc|
  llvm.func @sub_smax0_sub_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.intr.smax(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_smax0_sub_commute   : sub_smax0_sub_commute_before  ⊑  sub_smax0_sub_commute_combined := by
  unfold sub_smax0_sub_commute_before sub_smax0_sub_commute_combined
  simp_alive_peephole
  sorry
def sub_smin0_sub_nsw_use_combined := [llvmfunc|
  llvm.func @sub_smin0_sub_nsw_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_smin0_sub_nsw_use   : sub_smin0_sub_nsw_use_before  ⊑  sub_smin0_sub_nsw_use_combined := by
  unfold sub_smin0_sub_nsw_use_before sub_smin0_sub_nsw_use_combined
  simp_alive_peephole
  sorry
def sub_smin0_sub_nsw_combined := [llvmfunc|
  llvm.func @sub_smin0_sub_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_sub_smin0_sub_nsw   : sub_smin0_sub_nsw_before  ⊑  sub_smin0_sub_nsw_combined := by
  unfold sub_smin0_sub_nsw_before sub_smin0_sub_nsw_combined
  simp_alive_peephole
  sorry
def sub_smin0_sub_combined := [llvmfunc|
  llvm.func @sub_smin0_sub(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_smin0_sub   : sub_smin0_sub_before  ⊑  sub_smin0_sub_combined := by
  unfold sub_smin0_sub_before sub_smin0_sub_combined
  simp_alive_peephole
  sorry
def sub_smin0_sub_nsw_commute_combined := [llvmfunc|
  llvm.func @sub_smin0_sub_nsw_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %arg1, %arg0 overflow<nsw>  : i8
    %2 = llvm.intr.smin(%1, %0)  : (i8, i8) -> i8
    %3 = llvm.sub %arg0, %2  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_sub_smin0_sub_nsw_commute   : sub_smin0_sub_nsw_commute_before  ⊑  sub_smin0_sub_nsw_commute_combined := by
  unfold sub_smin0_sub_nsw_commute_before sub_smin0_sub_nsw_commute_combined
  simp_alive_peephole
  sorry
def sub_max_min_nsw_combined := [llvmfunc|
  llvm.func @sub_max_min_nsw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_max_min_nsw   : sub_max_min_nsw_before  ⊑  sub_max_min_nsw_combined := by
  unfold sub_max_min_nsw_before sub_max_min_nsw_combined
  simp_alive_peephole
  sorry
def sub_max_min_nuw_combined := [llvmfunc|
  llvm.func @sub_max_min_nuw(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_max_min_nuw   : sub_max_min_nuw_before  ⊑  sub_max_min_nuw_combined := by
  unfold sub_max_min_nuw_before sub_max_min_nuw_combined
  simp_alive_peephole
  sorry
def sub_max_min_nsw_commute_combined := [llvmfunc|
  llvm.func @sub_max_min_nsw_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_max_min_nsw_commute   : sub_max_min_nsw_commute_before  ⊑  sub_max_min_nsw_commute_combined := by
  unfold sub_max_min_nsw_commute_before sub_max_min_nsw_commute_combined
  simp_alive_peephole
  sorry
def sub_max_min_nuw_commute_combined := [llvmfunc|
  llvm.func @sub_max_min_nuw_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (i8) -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_sub_max_min_nuw_commute   : sub_max_min_nuw_commute_before  ⊑  sub_max_min_nuw_commute_combined := by
  unfold sub_max_min_nuw_commute_before sub_max_min_nuw_commute_combined
  simp_alive_peephole
  sorry
def sub_max_min_vec_nsw_combined := [llvmfunc|
  llvm.func @sub_max_min_vec_nsw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_sub_max_min_vec_nsw   : sub_max_min_vec_nsw_before  ⊑  sub_max_min_vec_nsw_combined := by
  unfold sub_max_min_vec_nsw_before sub_max_min_vec_nsw_combined
  simp_alive_peephole
  sorry
def sub_max_min_vec_nuw_combined := [llvmfunc|
  llvm.func @sub_max_min_vec_nuw(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_sub_max_min_vec_nuw   : sub_max_min_vec_nuw_before  ⊑  sub_max_min_vec_nuw_combined := by
  unfold sub_max_min_vec_nuw_before sub_max_min_vec_nuw_combined
  simp_alive_peephole
  sorry
def sub_max_min_vec_nsw_commute_combined := [llvmfunc|
  llvm.func @sub_max_min_vec_nsw_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_sub_max_min_vec_nsw_commute   : sub_max_min_vec_nsw_commute_before  ⊑  sub_max_min_vec_nsw_commute_combined := by
  unfold sub_max_min_vec_nsw_commute_before sub_max_min_vec_nsw_commute_combined
  simp_alive_peephole
  sorry
def sub_max_min_vec_nuw_commute_combined := [llvmfunc|
  llvm.func @sub_max_min_vec_nuw_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi8>
    %1 = "llvm.intr.abs"(%0) <{is_int_min_poison = true}> : (vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_sub_max_min_vec_nuw_commute   : sub_max_min_vec_nuw_commute_before  ⊑  sub_max_min_vec_nuw_commute_combined := by
  unfold sub_max_min_vec_nuw_commute_before sub_max_min_vec_nuw_commute_combined
  simp_alive_peephole
  sorry
def sub_max_min_multi_use_combined := [llvmfunc|
  llvm.func @sub_max_min_multi_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %0 overflow<nsw>  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_sub_max_min_multi_use   : sub_max_min_multi_use_before  ⊑  sub_max_min_multi_use_combined := by
  unfold sub_max_min_multi_use_before sub_max_min_multi_use_combined
  simp_alive_peephole
  sorry
def sub_max_min_vec_multi_use_combined := [llvmfunc|
  llvm.func @sub_max_min_vec_multi_use(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.addressof @use8v2 : !llvm.ptr
    %1 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.call %0(%1) : !llvm.ptr, (vector<2xi8>) -> ()
    %2 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.call %0(%2) : !llvm.ptr, (vector<2xi8>) -> ()
    %3 = llvm.sub %2, %1 overflow<nsw>  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_sub_max_min_vec_multi_use   : sub_max_min_vec_multi_use_before  ⊑  sub_max_min_vec_multi_use_combined := by
  unfold sub_max_min_vec_multi_use_before sub_max_min_vec_multi_use_combined
  simp_alive_peephole
  sorry
