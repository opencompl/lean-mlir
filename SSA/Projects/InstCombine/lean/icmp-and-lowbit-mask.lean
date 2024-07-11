import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-and-lowbit-mask
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def src_is_mask_zext_before := [llvmfunc|
  llvm.func @src_is_mask_zext(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.zext %3 : i8 to i16
    %5 = llvm.and %2, %4  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    llvm.return %6 : i1
  }]

def src_is_mask_zext_fail_not_mask_before := [llvmfunc|
  llvm.func @src_is_mask_zext_fail_not_mask(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.zext %3 : i8 to i16
    %5 = llvm.and %2, %4  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    llvm.return %6 : i1
  }]

def src_is_mask_sext_before := [llvmfunc|
  llvm.func @src_is_mask_sext(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.xor %arg0, %0  : i16
    %5 = llvm.lshr %1, %arg1  : i8
    %6 = llvm.sext %5 : i8 to i16
    %7 = llvm.xor %6, %2  : i16
    %8 = llvm.and %7, %4  : i16
    %9 = llvm.icmp "eq" %8, %3 : i16
    llvm.return %9 : i1
  }]

def src_is_mask_sext_fail_multiuse_before := [llvmfunc|
  llvm.func @src_is_mask_sext_fail_multiuse(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.xor %arg0, %0  : i16
    %5 = llvm.lshr %1, %arg1  : i8
    %6 = llvm.sext %5 : i8 to i16
    %7 = llvm.xor %6, %2  : i16
    %8 = llvm.and %7, %4  : i16
    llvm.call @use.i16(%8) : (i16) -> ()
    %9 = llvm.icmp "eq" %8, %3 : i16
    llvm.return %9 : i1
  }]

def src_is_mask_and_before := [llvmfunc|
  llvm.func @src_is_mask_and(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.ashr %1, %arg1  : i8
    %5 = llvm.lshr %2, %arg2  : i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "eq" %3, %7 : i8
    llvm.return %8 : i1
  }]

def src_is_mask_and_fail_mixed_before := [llvmfunc|
  llvm.func @src_is_mask_and_fail_mixed(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.ashr %1, %arg1  : i8
    %5 = llvm.lshr %2, %arg2  : i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "eq" %3, %7 : i8
    llvm.return %8 : i1
  }]

def src_is_mask_or_before := [llvmfunc|
  llvm.func @src_is_mask_or(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.lshr %1, %arg1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.and %5, %3  : i8
    %7 = llvm.icmp "eq" %3, %6 : i8
    llvm.return %7 : i1
  }]

def src_is_mask_xor_before := [llvmfunc|
  llvm.func @src_is_mask_xor(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %arg1, %3  : i8
    %5 = llvm.and %2, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

def src_is_mask_xor_fail_notmask_before := [llvmfunc|
  llvm.func @src_is_mask_xor_fail_notmask(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %arg1, %3  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %2, %5  : i8
    %7 = llvm.icmp "ne" %6, %2 : i8
    llvm.return %7 : i1
  }]

def src_is_mask_select_before := [llvmfunc|
  llvm.func @src_is_mask_select(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "ne" %7, %3 : i8
    llvm.return %8 : i1
  }]

def src_is_mask_select_fail_wrong_pattern_before := [llvmfunc|
  llvm.func @src_is_mask_select_fail_wrong_pattern(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "ne" %7, %arg3 : i8
    llvm.return %8 : i1
  }]

def src_is_mask_shl_lshr_before := [llvmfunc|
  llvm.func @src_is_mask_shl_lshr(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.lshr %4, %arg1  : i8
    %6 = llvm.xor %5, %1  : i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "ne" %2, %7 : i8
    llvm.return %8 : i1
  }]

def src_is_mask_shl_lshr_fail_not_allones_before := [llvmfunc|
  llvm.func @src_is_mask_shl_lshr_fail_not_allones(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.shl %1, %arg1  : i8
    %6 = llvm.lshr %5, %arg1  : i8
    %7 = llvm.xor %6, %2  : i8
    %8 = llvm.and %4, %7  : i8
    %9 = llvm.icmp "ne" %3, %8 : i8
    llvm.return %9 : i1
  }]

def src_is_mask_lshr_before := [llvmfunc|
  llvm.func @src_is_mask_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg3, %5, %2 : i1, i8
    %7 = llvm.lshr %6, %arg2  : i8
    %8 = llvm.and %7, %3  : i8
    %9 = llvm.icmp "ne" %3, %8 : i8
    llvm.return %9 : i1
  }]

def src_is_mask_ashr_before := [llvmfunc|
  llvm.func @src_is_mask_ashr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg3, %5, %2 : i1, i8
    %7 = llvm.ashr %6, %arg2  : i8
    %8 = llvm.and %3, %7  : i8
    %9 = llvm.icmp "ult" %8, %3 : i8
    llvm.return %9 : i1
  }]

def src_is_mask_p2_m1_before := [llvmfunc|
  llvm.func @src_is_mask_p2_m1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.add %4, %2  : i8
    %6 = llvm.and %5, %3  : i8
    %7 = llvm.icmp "ult" %6, %3 : i8
    llvm.return %7 : i1
  }]

def src_is_mask_umax_before := [llvmfunc|
  llvm.func @src_is_mask_umax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.intr.umax(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "ugt" %3, %7 : i8
    llvm.return %8 : i1
  }]

def src_is_mask_umin_before := [llvmfunc|
  llvm.func @src_is_mask_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.lshr %2, %arg2  : i8
    %7 = llvm.intr.umin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.and %7, %3  : i8
    %9 = llvm.icmp "ugt" %3, %8 : i8
    llvm.return %9 : i1
  }]

def src_is_mask_umin_fail_mismatch_before := [llvmfunc|
  llvm.func @src_is_mask_umin_fail_mismatch(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-32 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.intr.umin(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "ugt" %3, %7 : i8
    llvm.return %8 : i1
  }]

def src_is_mask_smax_before := [llvmfunc|
  llvm.func @src_is_mask_smax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %arg1, %3  : i8
    %5 = llvm.intr.smax(%4, %1)  : (i8, i8) -> i8
    %6 = llvm.and %2, %5  : i8
    %7 = llvm.icmp "uge" %6, %2 : i8
    llvm.return %7 : i1
  }]

def src_is_mask_smin_before := [llvmfunc|
  llvm.func @src_is_mask_smin(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.intr.smin(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "uge" %7, %3 : i8
    llvm.return %8 : i1
  }]

def src_is_mask_bitreverse_not_mask_before := [llvmfunc|
  llvm.func @src_is_mask_bitreverse_not_mask(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.shl %1, %arg1  : i8
    %4 = llvm.intr.bitreverse(%3)  : (i8) -> i8
    %5 = llvm.and %2, %4  : i8
    %6 = llvm.icmp "ule" %2, %5 : i8
    llvm.return %6 : i1
  }]

def src_is_notmask_sext_before := [llvmfunc|
  llvm.func @src_is_notmask_sext(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.xor %arg0, %0  : i16
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.sext %4 : i8 to i16
    %6 = llvm.xor %5, %2  : i16
    %7 = llvm.and %6, %3  : i16
    %8 = llvm.icmp "ule" %3, %7 : i16
    llvm.return %8 : i1
  }]

def src_is_notmask_shl_before := [llvmfunc|
  llvm.func @src_is_notmask_shl(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.shl %1, %arg1  : i8
    %6 = llvm.intr.bitreverse(%5)  : (i8) -> i8
    %7 = llvm.xor %6, %1  : i8
    %8 = llvm.select %arg2, %7, %2 : i1, i8
    %9 = llvm.and %4, %8  : i8
    %10 = llvm.icmp "eq" %9, %3 : i8
    llvm.return %10 : i1
  }]

def src_is_notmask_x_xor_neg_x_before := [llvmfunc|
  llvm.func @src_is_notmask_x_xor_neg_x(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.sub %1, %arg1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "eq" %7, %1 : i8
    llvm.return %8 : i1
  }]

def src_is_notmask_x_xor_neg_x_inv_before := [llvmfunc|
  llvm.func @src_is_notmask_x_xor_neg_x_inv(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.sub %1, %arg1  : i8
    %5 = llvm.xor %arg1, %4  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "eq" %7, %1 : i8
    llvm.return %8 : i1
  }]

def src_is_notmask_shl_fail_multiuse_invert_before := [llvmfunc|
  llvm.func @src_is_notmask_shl_fail_multiuse_invert(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.shl %1, %arg1  : i8
    %6 = llvm.intr.bitreverse(%5)  : (i8) -> i8
    %7 = llvm.xor %6, %1  : i8
    %8 = llvm.select %arg2, %7, %2 : i1, i8
    llvm.call @use.i8(%8) : (i8) -> ()
    %9 = llvm.and %4, %8  : i8
    %10 = llvm.icmp "eq" %9, %3 : i8
    llvm.return %10 : i1
  }]

def src_is_notmask_lshr_shl_before := [llvmfunc|
  llvm.func @src_is_notmask_lshr_shl(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.shl %3, %arg1  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %5, %2  : i8
    %7 = llvm.icmp "eq" %6, %2 : i8
    llvm.return %7 : i1
  }]

def src_is_notmask_lshr_shl_fail_mismatch_shifts_before := [llvmfunc|
  llvm.func @src_is_notmask_lshr_shl_fail_mismatch_shifts(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.shl %3, %arg2  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %5, %2  : i8
    %7 = llvm.icmp "eq" %6, %2 : i8
    llvm.return %7 : i1
  }]

def src_is_notmask_ashr_before := [llvmfunc|
  llvm.func @src_is_notmask_ashr(%arg0: i16, %arg1: i8, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.xor %arg0, %0  : i16
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.sext %4 : i8 to i16
    %6 = llvm.ashr %5, %arg2  : i16
    %7 = llvm.xor %6, %2  : i16
    %8 = llvm.and %3, %7  : i16
    %9 = llvm.icmp "eq" %3, %8 : i16
    llvm.return %9 : i1
  }]

def src_is_notmask_neg_p2_before := [llvmfunc|
  llvm.func @src_is_notmask_neg_p2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.sub %1, %arg1  : i8
    %5 = llvm.and %4, %arg1  : i8
    %6 = llvm.sub %1, %5  : i8
    %7 = llvm.intr.bitreverse(%6)  : (i8) -> i8
    %8 = llvm.xor %7, %2  : i8
    %9 = llvm.and %8, %3  : i8
    %10 = llvm.icmp "eq" %1, %9 : i8
    llvm.return %10 : i1
  }]

def src_is_notmask_neg_p2_fail_not_invertable_before := [llvmfunc|
  llvm.func @src_is_notmask_neg_p2_fail_not_invertable(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.sub %1, %arg1  : i8
    %4 = llvm.and %3, %arg1  : i8
    %5 = llvm.sub %1, %4  : i8
    %6 = llvm.and %5, %2  : i8
    %7 = llvm.icmp "eq" %1, %6 : i8
    llvm.return %7 : i1
  }]

def src_is_notmask_xor_fail_before := [llvmfunc|
  llvm.func @src_is_notmask_xor_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %arg1, %3  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.intr.bitreverse(%5)  : (i8) -> i8
    %7 = llvm.and %2, %6  : i8
    %8 = llvm.icmp "slt" %7, %2 : i8
    llvm.return %8 : i1
  }]

def src_is_mask_const_slt_before := [llvmfunc|
  llvm.func @src_is_mask_const_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "slt" %2, %3 : i8
    llvm.return %4 : i1
  }]

def src_is_mask_const_sgt_before := [llvmfunc|
  llvm.func @src_is_mask_const_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "sgt" %2, %3 : i8
    llvm.return %4 : i1
  }]

def src_is_mask_const_sle_before := [llvmfunc|
  llvm.func @src_is_mask_const_sle(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "sle" %3, %2 : i8
    llvm.return %4 : i1
  }]

def src_is_mask_const_sge_before := [llvmfunc|
  llvm.func @src_is_mask_const_sge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "sge" %3, %2 : i8
    llvm.return %4 : i1
  }]

def src_x_and_mask_slt_before := [llvmfunc|
  llvm.func @src_x_and_mask_slt(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.icmp "sge" %3, %1 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %3  : i8
    %6 = llvm.icmp "slt" %5, %arg0 : i8
    llvm.return %6 : i1
  }]

def src_x_and_mask_sge_before := [llvmfunc|
  llvm.func @src_x_and_mask_sge(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.icmp "sge" %3, %1 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %3  : i8
    %6 = llvm.icmp "sge" %5, %arg0 : i8
    llvm.return %6 : i1
  }]

def src_x_and_mask_slt_fail_maybe_neg_before := [llvmfunc|
  llvm.func @src_x_and_mask_slt_fail_maybe_neg(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "slt" %4, %arg0 : i8
    llvm.return %5 : i1
  }]

def src_x_and_mask_sge_fail_maybe_neg_before := [llvmfunc|
  llvm.func @src_x_and_mask_sge_fail_maybe_neg(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "sge" %4, %arg0 : i8
    llvm.return %5 : i1
  }]

def src_x_and_nmask_eq_before := [llvmfunc|
  llvm.func @src_x_and_nmask_eq(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "eq" %3, %4 : i8
    llvm.return %5 : i1
  }]

def src_x_and_nmask_ne_before := [llvmfunc|
  llvm.func @src_x_and_nmask_ne(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "ne" %4, %3 : i8
    llvm.return %5 : i1
  }]

def src_x_and_nmask_ult_before := [llvmfunc|
  llvm.func @src_x_and_nmask_ult(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "ult" %4, %3 : i8
    llvm.return %5 : i1
  }]

def src_x_and_nmask_uge_before := [llvmfunc|
  llvm.func @src_x_and_nmask_uge(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "uge" %4, %3 : i8
    llvm.return %5 : i1
  }]

def src_x_and_nmask_slt_before := [llvmfunc|
  llvm.func @src_x_and_nmask_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def src_x_and_nmask_sge_before := [llvmfunc|
  llvm.func @src_x_and_nmask_sge(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def src_x_and_nmask_slt_fail_maybe_z_before := [llvmfunc|
  llvm.func @src_x_and_nmask_slt_fail_maybe_z(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "slt" %4, %3 : i8
    llvm.return %5 : i1
  }]

def src_x_and_nmask_sge_fail_maybe_z_before := [llvmfunc|
  llvm.func @src_x_and_nmask_sge_fail_maybe_z(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "sge" %4, %3 : i8
    llvm.return %5 : i1
  }]

def src_x_or_mask_eq_before := [llvmfunc|
  llvm.func @src_x_or_mask_eq(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(123 : i8) : i8
    %3 = llvm.mlir.constant(45 : i8) : i8
    %4 = llvm.mlir.constant(12 : i8) : i8
    %5 = llvm.lshr %0, %arg1  : i8
    %6 = llvm.select %arg4, %5, %1 : i1, i8
    %7 = llvm.xor %arg0, %2  : i8
    %8 = llvm.select %arg3, %7, %3 : i1, i8
    %9 = llvm.xor %arg2, %0  : i8
    %10 = llvm.intr.umin(%9, %8)  : (i8, i8) -> i8
    %11 = llvm.add %10, %4  : i8
    %12 = llvm.or %11, %6  : i8
    %13 = llvm.icmp "eq" %12, %0 : i8
    llvm.return %13 : i1
  }]

def src_x_or_mask_ne_before := [llvmfunc|
  llvm.func @src_x_or_mask_ne(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.or %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %0 : i8
    llvm.return %6 : i1
  }]

def src_x_or_mask_ne_fail_multiuse_before := [llvmfunc|
  llvm.func @src_x_or_mask_ne_fail_multiuse(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.or %3, %4  : i8
    llvm.call @use.i8(%5) : (i8) -> ()
    %6 = llvm.icmp "ne" %5, %0 : i8
    llvm.return %6 : i1
  }]

def src_is_mask_zext_combined := [llvmfunc|
  llvm.func @src_is_mask_zext(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.zext %3 : i8 to i16
    %5 = llvm.and %2, %4  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    llvm.return %6 : i1
  }]

theorem inst_combine_src_is_mask_zext   : src_is_mask_zext_before  ⊑  src_is_mask_zext_combined := by
  unfold src_is_mask_zext_before src_is_mask_zext_combined
  simp_alive_peephole
  sorry
def src_is_mask_zext_fail_not_mask_combined := [llvmfunc|
  llvm.func @src_is_mask_zext_fail_not_mask(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.zext %3 : i8 to i16
    %5 = llvm.and %2, %4  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    llvm.return %6 : i1
  }]

theorem inst_combine_src_is_mask_zext_fail_not_mask   : src_is_mask_zext_fail_not_mask_before  ⊑  src_is_mask_zext_fail_not_mask_combined := by
  unfold src_is_mask_zext_fail_not_mask_before src_is_mask_zext_fail_not_mask_combined
  simp_alive_peephole
  sorry
def src_is_mask_sext_combined := [llvmfunc|
  llvm.func @src_is_mask_sext(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.xor %arg0, %0  : i16
    %5 = llvm.lshr %1, %arg1  : i8
    %6 = llvm.zext %5 : i8 to i16
    %7 = llvm.xor %6, %2  : i16
    %8 = llvm.and %4, %7  : i16
    %9 = llvm.icmp "eq" %8, %3 : i16
    llvm.return %9 : i1
  }]

theorem inst_combine_src_is_mask_sext   : src_is_mask_sext_before  ⊑  src_is_mask_sext_combined := by
  unfold src_is_mask_sext_before src_is_mask_sext_combined
  simp_alive_peephole
  sorry
def src_is_mask_sext_fail_multiuse_combined := [llvmfunc|
  llvm.func @src_is_mask_sext_fail_multiuse(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(122 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.xor %arg0, %0  : i16
    %4 = llvm.lshr %1, %arg1  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.sext %5 : i8 to i16
    %7 = llvm.and %3, %6  : i16
    llvm.call @use.i16(%7) : (i16) -> ()
    %8 = llvm.icmp "eq" %7, %2 : i16
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_mask_sext_fail_multiuse   : src_is_mask_sext_fail_multiuse_before  ⊑  src_is_mask_sext_fail_multiuse_combined := by
  unfold src_is_mask_sext_fail_multiuse_before src_is_mask_sext_fail_multiuse_combined
  simp_alive_peephole
  sorry
def src_is_mask_and_combined := [llvmfunc|
  llvm.func @src_is_mask_and(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.lshr %1, %arg1  : i8
    %5 = llvm.lshr %2, %arg2  : i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "eq" %3, %7 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_mask_and   : src_is_mask_and_before  ⊑  src_is_mask_and_combined := by
  unfold src_is_mask_and_before src_is_mask_and_combined
  simp_alive_peephole
  sorry
def src_is_mask_and_fail_mixed_combined := [llvmfunc|
  llvm.func @src_is_mask_and_fail_mixed(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.ashr %1, %arg1  : i8
    %5 = llvm.lshr %2, %arg2  : i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "eq" %3, %7 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_mask_and_fail_mixed   : src_is_mask_and_fail_mixed_before  ⊑  src_is_mask_and_fail_mixed_combined := by
  unfold src_is_mask_and_fail_mixed_before src_is_mask_and_fail_mixed_combined
  simp_alive_peephole
  sorry
def src_is_mask_or_combined := [llvmfunc|
  llvm.func @src_is_mask_or(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.lshr %1, %arg1  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.and %5, %3  : i8
    %7 = llvm.icmp "eq" %3, %6 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_src_is_mask_or   : src_is_mask_or_before  ⊑  src_is_mask_or_combined := by
  unfold src_is_mask_or_before src_is_mask_or_combined
  simp_alive_peephole
  sorry
def src_is_mask_xor_combined := [llvmfunc|
  llvm.func @src_is_mask_xor(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %3, %arg1  : i8
    %5 = llvm.and %2, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_src_is_mask_xor   : src_is_mask_xor_before  ⊑  src_is_mask_xor_combined := by
  unfold src_is_mask_xor_before src_is_mask_xor_combined
  simp_alive_peephole
  sorry
def src_is_mask_xor_fail_notmask_combined := [llvmfunc|
  llvm.func @src_is_mask_xor_fail_notmask(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.sub %1, %arg1  : i8
    %4 = llvm.xor %3, %arg1  : i8
    %5 = llvm.and %2, %4  : i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_src_is_mask_xor_fail_notmask   : src_is_mask_xor_fail_notmask_before  ⊑  src_is_mask_xor_fail_notmask_combined := by
  unfold src_is_mask_xor_fail_notmask_before src_is_mask_xor_fail_notmask_combined
  simp_alive_peephole
  sorry
def src_is_mask_select_combined := [llvmfunc|
  llvm.func @src_is_mask_select(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "ne" %7, %3 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_mask_select   : src_is_mask_select_before  ⊑  src_is_mask_select_combined := by
  unfold src_is_mask_select_before src_is_mask_select_combined
  simp_alive_peephole
  sorry
def src_is_mask_select_fail_wrong_pattern_combined := [llvmfunc|
  llvm.func @src_is_mask_select_fail_wrong_pattern(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "ne" %7, %arg3 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_mask_select_fail_wrong_pattern   : src_is_mask_select_fail_wrong_pattern_before  ⊑  src_is_mask_select_fail_wrong_pattern_combined := by
  unfold src_is_mask_select_fail_wrong_pattern_before src_is_mask_select_fail_wrong_pattern_combined
  simp_alive_peephole
  sorry
def src_is_mask_shl_lshr_combined := [llvmfunc|
  llvm.func @src_is_mask_shl_lshr(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(122 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.lshr %1, %arg1  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %3, %5  : i8
    %7 = llvm.icmp "ne" %6, %2 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_src_is_mask_shl_lshr   : src_is_mask_shl_lshr_before  ⊑  src_is_mask_shl_lshr_combined := by
  unfold src_is_mask_shl_lshr_before src_is_mask_shl_lshr_combined
  simp_alive_peephole
  sorry
def src_is_mask_shl_lshr_fail_not_allones_combined := [llvmfunc|
  llvm.func @src_is_mask_shl_lshr_fail_not_allones(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-2 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.lshr %1, %arg1  : i8
    %6 = llvm.and %5, %2  : i8
    %7 = llvm.xor %6, %1  : i8
    %8 = llvm.and %4, %7  : i8
    %9 = llvm.icmp "ne" %8, %3 : i8
    llvm.return %9 : i1
  }]

theorem inst_combine_src_is_mask_shl_lshr_fail_not_allones   : src_is_mask_shl_lshr_fail_not_allones_before  ⊑  src_is_mask_shl_lshr_fail_not_allones_combined := by
  unfold src_is_mask_shl_lshr_fail_not_allones_before src_is_mask_shl_lshr_fail_not_allones_combined
  simp_alive_peephole
  sorry
def src_is_mask_lshr_combined := [llvmfunc|
  llvm.func @src_is_mask_lshr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.select %arg3, %5, %2 : i1, i8
    %7 = llvm.lshr %6, %arg2  : i8
    %8 = llvm.and %7, %3  : i8
    %9 = llvm.icmp "ne" %3, %8 : i8
    llvm.return %9 : i1
  }]

theorem inst_combine_src_is_mask_lshr   : src_is_mask_lshr_before  ⊑  src_is_mask_lshr_combined := by
  unfold src_is_mask_lshr_before src_is_mask_lshr_combined
  simp_alive_peephole
  sorry
def src_is_mask_ashr_combined := [llvmfunc|
  llvm.func @src_is_mask_ashr(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.select %arg3, %5, %2 : i1, i8
    %7 = llvm.ashr %6, %arg2  : i8
    %8 = llvm.and %3, %7  : i8
    %9 = llvm.icmp "ne" %8, %3 : i8
    llvm.return %9 : i1
  }]

theorem inst_combine_src_is_mask_ashr   : src_is_mask_ashr_before  ⊑  src_is_mask_ashr_combined := by
  unfold src_is_mask_ashr_before src_is_mask_ashr_combined
  simp_alive_peephole
  sorry
def src_is_mask_p2_m1_combined := [llvmfunc|
  llvm.func @src_is_mask_p2_m1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.add %4, %2  : i8
    %6 = llvm.and %5, %3  : i8
    %7 = llvm.icmp "ne" %6, %3 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_src_is_mask_p2_m1   : src_is_mask_p2_m1_before  ⊑  src_is_mask_p2_m1_combined := by
  unfold src_is_mask_p2_m1_before src_is_mask_p2_m1_combined
  simp_alive_peephole
  sorry
def src_is_mask_umax_combined := [llvmfunc|
  llvm.func @src_is_mask_umax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.intr.umax(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "ne" %7, %3 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_mask_umax   : src_is_mask_umax_before  ⊑  src_is_mask_umax_combined := by
  unfold src_is_mask_umax_before src_is_mask_umax_combined
  simp_alive_peephole
  sorry
def src_is_mask_umin_combined := [llvmfunc|
  llvm.func @src_is_mask_umin(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(15 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.lshr %2, %arg2  : i8
    %7 = llvm.intr.umin(%5, %6)  : (i8, i8) -> i8
    %8 = llvm.and %7, %3  : i8
    %9 = llvm.icmp "ne" %8, %3 : i8
    llvm.return %9 : i1
  }]

theorem inst_combine_src_is_mask_umin   : src_is_mask_umin_before  ⊑  src_is_mask_umin_combined := by
  unfold src_is_mask_umin_before src_is_mask_umin_combined
  simp_alive_peephole
  sorry
def src_is_mask_umin_fail_mismatch_combined := [llvmfunc|
  llvm.func @src_is_mask_umin_fail_mismatch(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-32 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.intr.umin(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "ne" %7, %3 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_mask_umin_fail_mismatch   : src_is_mask_umin_fail_mismatch_before  ⊑  src_is_mask_umin_fail_mismatch_combined := by
  unfold src_is_mask_umin_fail_mismatch_before src_is_mask_umin_fail_mismatch_combined
  simp_alive_peephole
  sorry
def src_is_mask_smax_combined := [llvmfunc|
  llvm.func @src_is_mask_smax(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %3, %arg1  : i8
    %5 = llvm.intr.smax(%4, %1)  : (i8, i8) -> i8
    %6 = llvm.and %2, %5  : i8
    %7 = llvm.icmp "eq" %6, %2 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_src_is_mask_smax   : src_is_mask_smax_before  ⊑  src_is_mask_smax_combined := by
  unfold src_is_mask_smax_before src_is_mask_smax_combined
  simp_alive_peephole
  sorry
def src_is_mask_smin_combined := [llvmfunc|
  llvm.func @src_is_mask_smin(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.intr.smin(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "eq" %7, %3 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_mask_smin   : src_is_mask_smin_before  ⊑  src_is_mask_smin_combined := by
  unfold src_is_mask_smin_before src_is_mask_smin_combined
  simp_alive_peephole
  sorry
def src_is_mask_bitreverse_not_mask_combined := [llvmfunc|
  llvm.func @src_is_mask_bitreverse_not_mask(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.shl %1, %arg1 overflow<nsw>  : i8
    %4 = llvm.intr.bitreverse(%3)  : (i8) -> i8
    %5 = llvm.and %2, %4  : i8
    %6 = llvm.icmp "eq" %5, %2 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_src_is_mask_bitreverse_not_mask   : src_is_mask_bitreverse_not_mask_before  ⊑  src_is_mask_bitreverse_not_mask_combined := by
  unfold src_is_mask_bitreverse_not_mask_before src_is_mask_bitreverse_not_mask_combined
  simp_alive_peephole
  sorry
def src_is_notmask_sext_combined := [llvmfunc|
  llvm.func @src_is_notmask_sext(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i16
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.xor %4, %2  : i8
    %6 = llvm.sext %5 : i8 to i16
    %7 = llvm.and %3, %6  : i16
    %8 = llvm.icmp "eq" %7, %3 : i16
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_notmask_sext   : src_is_notmask_sext_before  ⊑  src_is_notmask_sext_combined := by
  unfold src_is_notmask_sext_before src_is_notmask_sext_combined
  simp_alive_peephole
  sorry
def src_is_notmask_shl_combined := [llvmfunc|
  llvm.func @src_is_notmask_shl(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(122 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.shl %1, %arg1 overflow<nsw>  : i8
    %6 = llvm.xor %5, %1  : i8
    %7 = llvm.intr.bitreverse(%6)  : (i8) -> i8
    %8 = llvm.select %arg2, %7, %2 : i1, i8
    %9 = llvm.and %4, %8  : i8
    %10 = llvm.icmp "eq" %9, %3 : i8
    llvm.return %10 : i1
  }]

theorem inst_combine_src_is_notmask_shl   : src_is_notmask_shl_before  ⊑  src_is_notmask_shl_combined := by
  unfold src_is_notmask_shl_before src_is_notmask_shl_combined
  simp_alive_peephole
  sorry
def src_is_notmask_x_xor_neg_x_combined := [llvmfunc|
  llvm.func @src_is_notmask_x_xor_neg_x(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.sub %1, %arg1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %3, %6  : i8
    %8 = llvm.icmp "eq" %7, %1 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_notmask_x_xor_neg_x   : src_is_notmask_x_xor_neg_x_before  ⊑  src_is_notmask_x_xor_neg_x_combined := by
  unfold src_is_notmask_x_xor_neg_x_before src_is_notmask_x_xor_neg_x_combined
  simp_alive_peephole
  sorry
def src_is_notmask_x_xor_neg_x_inv_combined := [llvmfunc|
  llvm.func @src_is_notmask_x_xor_neg_x_inv(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.sub %1, %arg1  : i8
    %5 = llvm.xor %4, %arg1  : i8
    %6 = llvm.select %arg2, %5, %2 : i1, i8
    %7 = llvm.and %6, %3  : i8
    %8 = llvm.icmp "eq" %7, %1 : i8
    llvm.return %8 : i1
  }]

theorem inst_combine_src_is_notmask_x_xor_neg_x_inv   : src_is_notmask_x_xor_neg_x_inv_before  ⊑  src_is_notmask_x_xor_neg_x_inv_combined := by
  unfold src_is_notmask_x_xor_neg_x_inv_before src_is_notmask_x_xor_neg_x_inv_combined
  simp_alive_peephole
  sorry
def src_is_notmask_shl_fail_multiuse_invert_combined := [llvmfunc|
  llvm.func @src_is_notmask_shl_fail_multiuse_invert(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(122 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.shl %1, %arg1 overflow<nsw>  : i8
    %6 = llvm.xor %5, %1  : i8
    %7 = llvm.intr.bitreverse(%6)  : (i8) -> i8
    %8 = llvm.select %arg2, %7, %2 : i1, i8
    llvm.call @use.i8(%8) : (i8) -> ()
    %9 = llvm.and %4, %8  : i8
    %10 = llvm.icmp "eq" %9, %3 : i8
    llvm.return %10 : i1
  }]

theorem inst_combine_src_is_notmask_shl_fail_multiuse_invert   : src_is_notmask_shl_fail_multiuse_invert_before  ⊑  src_is_notmask_shl_fail_multiuse_invert_combined := by
  unfold src_is_notmask_shl_fail_multiuse_invert_before src_is_notmask_shl_fail_multiuse_invert_combined
  simp_alive_peephole
  sorry
def src_is_notmask_lshr_shl_combined := [llvmfunc|
  llvm.func @src_is_notmask_lshr_shl(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-124 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.icmp "uge" %3, %2 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_src_is_notmask_lshr_shl   : src_is_notmask_lshr_shl_before  ⊑  src_is_notmask_lshr_shl_combined := by
  unfold src_is_notmask_lshr_shl_before src_is_notmask_lshr_shl_combined
  simp_alive_peephole
  sorry
def src_is_notmask_lshr_shl_fail_mismatch_shifts_combined := [llvmfunc|
  llvm.func @src_is_notmask_lshr_shl_fail_mismatch_shifts(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %1, %arg1  : i8
    %4 = llvm.shl %3, %arg2  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %2, %5  : i8
    %7 = llvm.icmp "eq" %6, %2 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_src_is_notmask_lshr_shl_fail_mismatch_shifts   : src_is_notmask_lshr_shl_fail_mismatch_shifts_before  ⊑  src_is_notmask_lshr_shl_fail_mismatch_shifts_combined := by
  unfold src_is_notmask_lshr_shl_fail_mismatch_shifts_before src_is_notmask_lshr_shl_fail_mismatch_shifts_combined
  simp_alive_peephole
  sorry
def src_is_notmask_ashr_combined := [llvmfunc|
  llvm.func @src_is_notmask_ashr(%arg0: i16, %arg1: i8, %arg2: i16) -> i1 {
    %0 = llvm.mlir.constant(123 : i16) : i16
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.xor %arg0, %0  : i16
    %4 = llvm.shl %1, %arg1  : i8
    %5 = llvm.sext %4 : i8 to i16
    %6 = llvm.ashr %5, %arg2  : i16
    %7 = llvm.xor %6, %2  : i16
    %8 = llvm.and %3, %7  : i16
    %9 = llvm.icmp "eq" %3, %8 : i16
    llvm.return %9 : i1
  }]

theorem inst_combine_src_is_notmask_ashr   : src_is_notmask_ashr_before  ⊑  src_is_notmask_ashr_combined := by
  unfold src_is_notmask_ashr_before src_is_notmask_ashr_combined
  simp_alive_peephole
  sorry
def src_is_notmask_neg_p2_combined := [llvmfunc|
  llvm.func @src_is_notmask_neg_p2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.xor %arg0, %0  : i8
    %4 = llvm.add %arg1, %1  : i8
    %5 = llvm.xor %arg1, %1  : i8
    %6 = llvm.and %4, %5  : i8
    %7 = llvm.intr.bitreverse(%6)  : (i8) -> i8
    %8 = llvm.and %7, %3  : i8
    %9 = llvm.icmp "eq" %8, %2 : i8
    llvm.return %9 : i1
  }]

theorem inst_combine_src_is_notmask_neg_p2   : src_is_notmask_neg_p2_before  ⊑  src_is_notmask_neg_p2_combined := by
  unfold src_is_notmask_neg_p2_before src_is_notmask_neg_p2_combined
  simp_alive_peephole
  sorry
def src_is_notmask_neg_p2_fail_not_invertable_combined := [llvmfunc|
  llvm.func @src_is_notmask_neg_p2_fail_not_invertable(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.sub %1, %arg1  : i8
    %4 = llvm.and %3, %arg1  : i8
    %5 = llvm.sub %1, %4  : i8
    %6 = llvm.and %2, %5  : i8
    %7 = llvm.icmp "eq" %6, %1 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_src_is_notmask_neg_p2_fail_not_invertable   : src_is_notmask_neg_p2_fail_not_invertable_before  ⊑  src_is_notmask_neg_p2_fail_not_invertable_combined := by
  unfold src_is_notmask_neg_p2_fail_not_invertable_before src_is_notmask_neg_p2_fail_not_invertable_combined
  simp_alive_peephole
  sorry
def src_is_notmask_xor_fail_combined := [llvmfunc|
  llvm.func @src_is_notmask_xor_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.sub %1, %arg1  : i8
    %4 = llvm.xor %3, %arg1  : i8
    %5 = llvm.intr.bitreverse(%4)  : (i8) -> i8
    %6 = llvm.and %2, %5  : i8
    %7 = llvm.icmp "slt" %6, %2 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_src_is_notmask_xor_fail   : src_is_notmask_xor_fail_before  ⊑  src_is_notmask_xor_fail_combined := by
  unfold src_is_notmask_xor_fail_before src_is_notmask_xor_fail_combined
  simp_alive_peephole
  sorry
def src_is_mask_const_slt_combined := [llvmfunc|
  llvm.func @src_is_mask_const_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "slt" %2, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_src_is_mask_const_slt   : src_is_mask_const_slt_before  ⊑  src_is_mask_const_slt_combined := by
  unfold src_is_mask_const_slt_before src_is_mask_const_slt_combined
  simp_alive_peephole
  sorry
def src_is_mask_const_sgt_combined := [llvmfunc|
  llvm.func @src_is_mask_const_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_src_is_mask_const_sgt   : src_is_mask_const_sgt_before  ⊑  src_is_mask_const_sgt_combined := by
  unfold src_is_mask_const_sgt_before src_is_mask_const_sgt_combined
  simp_alive_peephole
  sorry
def src_is_mask_const_sle_combined := [llvmfunc|
  llvm.func @src_is_mask_const_sle(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "sle" %3, %2 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_src_is_mask_const_sle   : src_is_mask_const_sle_before  ⊑  src_is_mask_const_sle_combined := by
  unfold src_is_mask_const_sle_before src_is_mask_const_sle_combined
  simp_alive_peephole
  sorry
def src_is_mask_const_sge_combined := [llvmfunc|
  llvm.func @src_is_mask_const_sge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(32 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_src_is_mask_const_sge   : src_is_mask_const_sge_before  ⊑  src_is_mask_const_sge_combined := by
  unfold src_is_mask_const_sge_before src_is_mask_const_sge_combined
  simp_alive_peephole
  sorry
def src_x_and_mask_slt_combined := [llvmfunc|
  llvm.func @src_x_and_mask_slt(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.icmp "sgt" %3, %0 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %3, %arg0  : i8
    %6 = llvm.icmp "slt" %5, %arg0 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_src_x_and_mask_slt   : src_x_and_mask_slt_before  ⊑  src_x_and_mask_slt_combined := by
  unfold src_x_and_mask_slt_before src_x_and_mask_slt_combined
  simp_alive_peephole
  sorry
def src_x_and_mask_sge_combined := [llvmfunc|
  llvm.func @src_x_and_mask_sge(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.icmp "sgt" %3, %0 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %3, %arg0  : i8
    %6 = llvm.icmp "sge" %5, %arg0 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_src_x_and_mask_sge   : src_x_and_mask_sge_before  ⊑  src_x_and_mask_sge_combined := by
  unfold src_x_and_mask_sge_before src_x_and_mask_sge_combined
  simp_alive_peephole
  sorry
def src_x_and_mask_slt_fail_maybe_neg_combined := [llvmfunc|
  llvm.func @src_x_and_mask_slt_fail_maybe_neg(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "slt" %4, %arg0 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_x_and_mask_slt_fail_maybe_neg   : src_x_and_mask_slt_fail_maybe_neg_before  ⊑  src_x_and_mask_slt_fail_maybe_neg_combined := by
  unfold src_x_and_mask_slt_fail_maybe_neg_before src_x_and_mask_slt_fail_maybe_neg_combined
  simp_alive_peephole
  sorry
def src_x_and_mask_sge_fail_maybe_neg_combined := [llvmfunc|
  llvm.func @src_x_and_mask_sge_fail_maybe_neg(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "sge" %4, %arg0 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_x_and_mask_sge_fail_maybe_neg   : src_x_and_mask_sge_fail_maybe_neg_before  ⊑  src_x_and_mask_sge_fail_maybe_neg_combined := by
  unfold src_x_and_mask_sge_fail_maybe_neg_before src_x_and_mask_sge_fail_maybe_neg_combined
  simp_alive_peephole
  sorry
def src_x_and_nmask_eq_combined := [llvmfunc|
  llvm.func @src_x_and_nmask_eq(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "eq" %3, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_x_and_nmask_eq   : src_x_and_nmask_eq_before  ⊑  src_x_and_nmask_eq_combined := by
  unfold src_x_and_nmask_eq_before src_x_and_nmask_eq_combined
  simp_alive_peephole
  sorry
def src_x_and_nmask_ne_combined := [llvmfunc|
  llvm.func @src_x_and_nmask_ne(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "ne" %4, %3 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_x_and_nmask_ne   : src_x_and_nmask_ne_before  ⊑  src_x_and_nmask_ne_combined := by
  unfold src_x_and_nmask_ne_before src_x_and_nmask_ne_combined
  simp_alive_peephole
  sorry
def src_x_and_nmask_ult_combined := [llvmfunc|
  llvm.func @src_x_and_nmask_ult(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "ne" %4, %3 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_x_and_nmask_ult   : src_x_and_nmask_ult_before  ⊑  src_x_and_nmask_ult_combined := by
  unfold src_x_and_nmask_ult_before src_x_and_nmask_ult_combined
  simp_alive_peephole
  sorry
def src_x_and_nmask_uge_combined := [llvmfunc|
  llvm.func @src_x_and_nmask_uge(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "eq" %4, %3 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_x_and_nmask_uge   : src_x_and_nmask_uge_before  ⊑  src_x_and_nmask_uge_combined := by
  unfold src_x_and_nmask_uge_before src_x_and_nmask_uge_combined
  simp_alive_peephole
  sorry
def src_x_and_nmask_slt_combined := [llvmfunc|
  llvm.func @src_x_and_nmask_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_src_x_and_nmask_slt   : src_x_and_nmask_slt_before  ⊑  src_x_and_nmask_slt_combined := by
  unfold src_x_and_nmask_slt_before src_x_and_nmask_slt_combined
  simp_alive_peephole
  sorry
def src_x_and_nmask_sge_combined := [llvmfunc|
  llvm.func @src_x_and_nmask_sge(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_src_x_and_nmask_sge   : src_x_and_nmask_sge_before  ⊑  src_x_and_nmask_sge_combined := by
  unfold src_x_and_nmask_sge_before src_x_and_nmask_sge_combined
  simp_alive_peephole
  sorry
def src_x_and_nmask_slt_fail_maybe_z_combined := [llvmfunc|
  llvm.func @src_x_and_nmask_slt_fail_maybe_z(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "slt" %4, %3 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_x_and_nmask_slt_fail_maybe_z   : src_x_and_nmask_slt_fail_maybe_z_before  ⊑  src_x_and_nmask_slt_fail_maybe_z_combined := by
  unfold src_x_and_nmask_slt_fail_maybe_z_before src_x_and_nmask_slt_fail_maybe_z_combined
  simp_alive_peephole
  sorry
def src_x_and_nmask_sge_fail_maybe_z_combined := [llvmfunc|
  llvm.func @src_x_and_nmask_sge_fail_maybe_z(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.and %3, %arg0  : i8
    %5 = llvm.icmp "sge" %4, %3 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_x_and_nmask_sge_fail_maybe_z   : src_x_and_nmask_sge_fail_maybe_z_before  ⊑  src_x_and_nmask_sge_fail_maybe_z_combined := by
  unfold src_x_and_nmask_sge_fail_maybe_z_before src_x_and_nmask_sge_fail_maybe_z_combined
  simp_alive_peephole
  sorry
def src_x_or_mask_eq_combined := [llvmfunc|
  llvm.func @src_x_or_mask_eq(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-124 : i8) : i8
    %3 = llvm.mlir.constant(-46 : i8) : i8
    %4 = llvm.mlir.constant(11 : i8) : i8
    %5 = llvm.lshr %0, %arg1  : i8
    %6 = llvm.select %arg4, %5, %1 : i1, i8
    %7 = llvm.xor %arg0, %2  : i8
    %8 = llvm.select %arg3, %7, %3 : i1, i8
    %9 = llvm.intr.umax(%arg2, %8)  : (i8, i8) -> i8
    %10 = llvm.sub %4, %9  : i8
    %11 = llvm.or %10, %6  : i8
    %12 = llvm.icmp "eq" %11, %0 : i8
    llvm.return %12 : i1
  }]

theorem inst_combine_src_x_or_mask_eq   : src_x_or_mask_eq_before  ⊑  src_x_or_mask_eq_combined := by
  unfold src_x_or_mask_eq_before src_x_or_mask_eq_combined
  simp_alive_peephole
  sorry
def src_x_or_mask_ne_combined := [llvmfunc|
  llvm.func @src_x_or_mask_ne(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.or %3, %4  : i8
    %6 = llvm.icmp "ne" %5, %0 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_src_x_or_mask_ne   : src_x_or_mask_ne_before  ⊑  src_x_or_mask_ne_combined := by
  unfold src_x_or_mask_ne_before src_x_or_mask_ne_combined
  simp_alive_peephole
  sorry
def src_x_or_mask_ne_fail_multiuse_combined := [llvmfunc|
  llvm.func @src_x_or_mask_ne_fail_multiuse(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg1  : i8
    %3 = llvm.select %arg2, %2, %1 : i1, i8
    %4 = llvm.xor %arg0, %0  : i8
    %5 = llvm.or %3, %4  : i8
    llvm.call @use.i8(%5) : (i8) -> ()
    %6 = llvm.icmp "ne" %5, %0 : i8
    llvm.return %6 : i1
  }]

theorem inst_combine_src_x_or_mask_ne_fail_multiuse   : src_x_or_mask_ne_fail_multiuse_before  ⊑  src_x_or_mask_ne_fail_multiuse_combined := by
  unfold src_x_or_mask_ne_fail_multiuse_before src_x_or_mask_ne_fail_multiuse_combined
  simp_alive_peephole
  sorry
