import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  lshr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def lshr_ctlz_zero_is_not_undef_before := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_not_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_cttz_zero_is_not_undef_before := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_not_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32]

    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_ctpop_before := [llvmfunc|
  llvm.func @lshr_ctpop(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.intr.ctpop(%arg0)  : (i32) -> i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_ctlz_zero_is_not_undef_splat_vec_before := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_not_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = false}> : (vector<2xi8>) -> vector<2xi8>]

    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def lshr_cttz_zero_is_not_undef_splat_vec_before := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_not_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi8>) -> vector<2xi8>]

    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def lshr_ctpop_splat_vec_before := [llvmfunc|
  llvm.func @lshr_ctpop_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.intr.ctpop(%arg0)  : (vector<2xi8>) -> vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def lshr_ctlz_zero_is_undef_before := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_cttz_zero_is_undef_before := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (i32) -> i32]

    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_ctlz_zero_is_undef_splat_vec_before := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>]

    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def lshr_ctlz_zero_is_undef_vec_before := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_undef_vec(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[3, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.ctlz"(%arg0) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>]

    %3 = llvm.lshr %2, %0  : vector<2xi8>
    %4 = llvm.extractelement %3[%1 : i32] : vector<2xi8>
    llvm.return %4 : i8
  }]

def lshr_cttz_zero_is_undef_splat_vec_before := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>]

    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def lshr_cttz_zero_is_undef_vec_before := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_undef_vec(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(dense<[3, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = true}> : (vector<2xi8>) -> vector<2xi8>]

    %3 = llvm.lshr %2, %0  : vector<2xi8>
    %4 = llvm.extractelement %3[%1 : i32] : vector<2xi8>
    llvm.return %4 : i8
  }]

def lshr_exact_before := [llvmfunc|
  llvm.func @lshr_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.lshr %3, %0  : i8
    llvm.return %4 : i8
  }]

def lshr_exact_splat_vec_before := [llvmfunc|
  llvm.func @lshr_exact_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def lshr_exact_splat_vec_nuw_before := [llvmfunc|
  llvm.func @lshr_exact_splat_vec_nuw(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = llvm.add %2, %1 overflow<nuw>  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def shl_add_before := [llvmfunc|
  llvm.func @shl_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.add %1, %arg1  : i8
    %3 = llvm.lshr %2, %0  : i8
    llvm.return %3 : i8
  }]

def shl_add_commute_vec_before := [llvmfunc|
  llvm.func @shl_add_commute_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mul %arg1, %arg1  : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.add %1, %2  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def shl_add_use1_before := [llvmfunc|
  llvm.func @shl_add_use1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }]

def shl_add_use2_before := [llvmfunc|
  llvm.func @shl_add_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }]

def bool_zext_before := [llvmfunc|
  llvm.func @bool_zext(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.sext %arg0 : i1 to i16
    %2 = llvm.lshr %1, %0  : i16
    llvm.return %2 : i16
  }]

def bool_zext_use_before := [llvmfunc|
  llvm.func @bool_zext_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def bool_zext_splat_before := [llvmfunc|
  llvm.func @bool_zext_splat(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def smear_sign_and_widen_before := [llvmfunc|
  llvm.func @smear_sign_and_widen(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def smear_sign_and_widen_should_not_change_type_before := [llvmfunc|
  llvm.func @smear_sign_and_widen_should_not_change_type(%arg0: i4) -> i16 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.sext %arg0 : i4 to i16
    %2 = llvm.lshr %1, %0  : i16
    llvm.return %2 : i16
  }]

def smear_sign_and_widen_splat_before := [llvmfunc|
  llvm.func @smear_sign_and_widen_splat(%arg0: vector<2xi6>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi6> to vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def fake_sext_before := [llvmfunc|
  llvm.func @fake_sext(%arg0: i3) -> i18 {
    %0 = llvm.mlir.constant(17 : i18) : i18
    %1 = llvm.sext %arg0 : i3 to i18
    %2 = llvm.lshr %1, %0  : i18
    llvm.return %2 : i18
  }]

def fake_sext_but_should_not_change_type_before := [llvmfunc|
  llvm.func @fake_sext_but_should_not_change_type(%arg0: i3) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg0 : i3 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def fake_sext_splat_before := [llvmfunc|
  llvm.func @fake_sext_splat(%arg0: vector<2xi3>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi3> to vector<2xi8>
    %2 = llvm.lshr %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def narrow_lshr_constant_before := [llvmfunc|
  llvm.func @narrow_lshr_constant(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def mul_splat_fold_before := [llvmfunc|
  llvm.func @mul_splat_fold(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def mul_splat_fold_vec_before := [llvmfunc|
  llvm.func @mul_splat_fold_vec(%arg0: vector<3xi14>) -> vector<3xi14> {
    %0 = llvm.mlir.constant(129 : i14) : i14
    %1 = llvm.mlir.constant(dense<129> : vector<3xi14>) : vector<3xi14>
    %2 = llvm.mlir.constant(7 : i14) : i14
    %3 = llvm.mlir.constant(dense<7> : vector<3xi14>) : vector<3xi14>
    %4 = llvm.mul %arg0, %1 overflow<nuw>  : vector<3xi14>
    llvm.call @usevec(%4) : (vector<3xi14>) -> ()
    %5 = llvm.lshr %4, %3  : vector<3xi14>
    llvm.return %5 : vector<3xi14>
  }]

def shl_add_lshr_flag_preservation_before := [llvmfunc|
  llvm.func @shl_add_lshr_flag_preservation(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_add_lshr_before := [llvmfunc|
  llvm.func @shl_add_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_add_lshr_comm_before := [llvmfunc|
  llvm.func @shl_add_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.mul %arg2, %arg2  : i32
    %2 = llvm.add %1, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

def shl_add_lshr_no_nuw_before := [llvmfunc|
  llvm.func @shl_add_lshr_no_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_not_exact_before := [llvmfunc|
  llvm.func @shl_sub_lshr_not_exact(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %0, %arg2 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_no_nuw_before := [llvmfunc|
  llvm.func @shl_sub_lshr_no_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.sub %0, %arg2 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_before := [llvmfunc|
  llvm.func @shl_sub_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_reverse_before := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_reverse_no_nsw_before := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_no_nsw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_reverse_nsw_on_op1_before := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_nsw_on_op1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_reverse_no_exact_before := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_no_exact(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_reverse_multiuse_before := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_multiuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_reverse_multiuse2_before := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_multiuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_reverse_no_nuw_before := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_no_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_sub_lshr_reverse_no_nsw_2_before := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_no_nsw_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.sub %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_or_lshr_before := [llvmfunc|
  llvm.func @shl_or_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_or_disjoint_lshr_before := [llvmfunc|
  llvm.func @shl_or_disjoint_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_or_lshr_comm_before := [llvmfunc|
  llvm.func @shl_or_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_or_disjoint_lshr_comm_before := [llvmfunc|
  llvm.func @shl_or_disjoint_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_xor_lshr_before := [llvmfunc|
  llvm.func @shl_xor_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.xor %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_xor_lshr_comm_before := [llvmfunc|
  llvm.func @shl_xor_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.xor %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_and_lshr_before := [llvmfunc|
  llvm.func @shl_and_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_and_lshr_comm_before := [llvmfunc|
  llvm.func @shl_and_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.and %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_lshr_and_exact_before := [llvmfunc|
  llvm.func @shl_lshr_and_exact(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

def shl_add_lshr_neg_before := [llvmfunc|
  llvm.func @shl_add_lshr_neg(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

def mul_splat_fold_wrong_mul_const_before := [llvmfunc|
  llvm.func @mul_splat_fold_wrong_mul_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65538 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def shl_add_lshr_multiuse_before := [llvmfunc|
  llvm.func @shl_add_lshr_multiuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nsw, nuw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

def mul_splat_fold_wrong_lshr_const_before := [llvmfunc|
  llvm.func @mul_splat_fold_wrong_lshr_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def mul_splat_fold_no_nuw_before := [llvmfunc|
  llvm.func @mul_splat_fold_no_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def mul_splat_fold_no_flags_before := [llvmfunc|
  llvm.func @mul_splat_fold_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def mul_splat_fold_too_narrow_before := [llvmfunc|
  llvm.func @mul_splat_fold_too_narrow(%arg0: i2) -> i2 {
    %0 = llvm.mlir.constant(-2 : i2) : i2
    %1 = llvm.mlir.constant(1 : i2) : i2
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i2
    %3 = llvm.lshr %2, %1  : i2
    llvm.return %3 : i2
  }]

def negative_and_odd_before := [llvmfunc|
  llvm.func @negative_and_odd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def negative_and_odd_vec_before := [llvmfunc|
  llvm.func @negative_and_odd_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(2 : i7) : i7
    %1 = llvm.mlir.constant(dense<2> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(6 : i7) : i7
    %3 = llvm.mlir.constant(dense<6> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.srem %arg0, %1  : vector<2xi7>
    %5 = llvm.lshr %4, %3  : vector<2xi7>
    llvm.return %5 : vector<2xi7>
  }]

def negative_and_odd_uses_before := [llvmfunc|
  llvm.func @negative_and_odd_uses(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def srem3_before := [llvmfunc|
  llvm.func @srem3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def srem2_lshr30_before := [llvmfunc|
  llvm.func @srem2_lshr30(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def trunc_sandwich_before := [llvmfunc|
  llvm.func @trunc_sandwich(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(2 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_splat_vec_before := [llvmfunc|
  llvm.func @trunc_sandwich_splat_vec(%arg0: vector<2xi32>) -> vector<2xi12> {
    %0 = llvm.mlir.constant(dense<22> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(8 : i12) : i12
    %2 = llvm.mlir.constant(dense<8> : vector<2xi12>) : vector<2xi12>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.trunc %3 : vector<2xi32> to vector<2xi12>
    %5 = llvm.lshr %4, %2  : vector<2xi12>
    llvm.return %5 : vector<2xi12>
  }]

def trunc_sandwich_min_shift1_before := [llvmfunc|
  llvm.func @trunc_sandwich_min_shift1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_small_shift1_before := [llvmfunc|
  llvm.func @trunc_sandwich_small_shift1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_max_sum_shift_before := [llvmfunc|
  llvm.func @trunc_sandwich_max_sum_shift(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(11 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_max_sum_shift2_before := [llvmfunc|
  llvm.func @trunc_sandwich_max_sum_shift2(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_big_sum_shift1_before := [llvmfunc|
  llvm.func @trunc_sandwich_big_sum_shift1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(11 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_big_sum_shift2_before := [llvmfunc|
  llvm.func @trunc_sandwich_big_sum_shift2(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_use1_before := [llvmfunc|
  llvm.func @trunc_sandwich_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(2 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_splat_vec_use1_before := [llvmfunc|
  llvm.func @trunc_sandwich_splat_vec_use1(%arg0: vector<3xi14>) -> vector<3xi9> {
    %0 = llvm.mlir.constant(6 : i14) : i14
    %1 = llvm.mlir.constant(dense<6> : vector<3xi14>) : vector<3xi14>
    %2 = llvm.mlir.constant(5 : i9) : i9
    %3 = llvm.mlir.constant(dense<5> : vector<3xi9>) : vector<3xi9>
    %4 = llvm.lshr %arg0, %1  : vector<3xi14>
    llvm.call @usevec(%4) : (vector<3xi14>) -> ()
    %5 = llvm.trunc %4 : vector<3xi14> to vector<3xi9>
    %6 = llvm.lshr %5, %3  : vector<3xi9>
    llvm.return %6 : vector<3xi9>
  }]

def trunc_sandwich_min_shift1_use1_before := [llvmfunc|
  llvm.func @trunc_sandwich_min_shift1_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_small_shift1_use1_before := [llvmfunc|
  llvm.func @trunc_sandwich_small_shift1_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_max_sum_shift_use1_before := [llvmfunc|
  llvm.func @trunc_sandwich_max_sum_shift_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(11 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_max_sum_shift2_use1_before := [llvmfunc|
  llvm.func @trunc_sandwich_max_sum_shift2_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_big_sum_shift1_use1_before := [llvmfunc|
  llvm.func @trunc_sandwich_big_sum_shift1_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(11 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def trunc_sandwich_big_sum_shift2_use1_before := [llvmfunc|
  llvm.func @trunc_sandwich_big_sum_shift2_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

def lshr_sext_i1_to_i16_before := [llvmfunc|
  llvm.func @lshr_sext_i1_to_i16(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.sext %arg0 : i1 to i16
    %2 = llvm.lshr %1, %0  : i16
    llvm.return %2 : i16
  }]

def lshr_sext_i1_to_i128_before := [llvmfunc|
  llvm.func @lshr_sext_i1_to_i128(%arg0: i1) -> i128 {
    %0 = llvm.mlir.constant(42 : i128) : i128
    %1 = llvm.sext %arg0 : i1 to i128
    %2 = llvm.lshr %1, %0  : i128
    llvm.return %2 : i128
  }]

def lshr_sext_i1_to_i32_use_before := [llvmfunc|
  llvm.func @lshr_sext_i1_to_i32_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(14 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

def lshr_sext_i1_to_i14_splat_vec_use1_before := [llvmfunc|
  llvm.func @lshr_sext_i1_to_i14_splat_vec_use1(%arg0: vector<3xi1>) -> vector<3xi14> {
    %0 = llvm.mlir.constant(4 : i14) : i14
    %1 = llvm.mlir.constant(dense<4> : vector<3xi14>) : vector<3xi14>
    %2 = llvm.sext %arg0 : vector<3xi1> to vector<3xi14>
    llvm.call @usevec(%2) : (vector<3xi14>) -> ()
    %3 = llvm.lshr %2, %1  : vector<3xi14>
    llvm.return %3 : vector<3xi14>
  }]

def icmp_ule_before := [llvmfunc|
  llvm.func @icmp_ule(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ule" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def icmp_ult_before := [llvmfunc|
  llvm.func @icmp_ult(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ult" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def icmp_eq_before := [llvmfunc|
  llvm.func @icmp_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "eq" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def icmp_ne_before := [llvmfunc|
  llvm.func @icmp_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ne" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def icmp_ugt_before := [llvmfunc|
  llvm.func @icmp_ugt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ugt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def icmp_uge_before := [llvmfunc|
  llvm.func @icmp_uge(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "uge" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def icmp_sle_before := [llvmfunc|
  llvm.func @icmp_sle(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "sle" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def icmp_slt_before := [llvmfunc|
  llvm.func @icmp_slt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "slt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def icmp_sgt_before := [llvmfunc|
  llvm.func @icmp_sgt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "sgt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def icmp_sge_before := [llvmfunc|
  llvm.func @icmp_sge(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "sge" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

def narrow_bswap_before := [llvmfunc|
  llvm.func @narrow_bswap(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }]

def narrow_bswap_extra_wide_before := [llvmfunc|
  llvm.func @narrow_bswap_extra_wide(%arg0: i16) -> i128 {
    %0 = llvm.mlir.constant(112 : i128) : i128
    %1 = llvm.zext %arg0 : i16 to i128
    %2 = llvm.intr.bswap(%1)  : (i128) -> i128
    %3 = llvm.lshr %2, %0  : i128
    llvm.return %3 : i128
  }]

def narrow_bswap_undershift_before := [llvmfunc|
  llvm.func @narrow_bswap_undershift(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }]

def narrow_bswap_splat_before := [llvmfunc|
  llvm.func @narrow_bswap_splat(%arg0: vector<2xi16>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg0 : vector<2xi16> to vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    %3 = llvm.lshr %2, %0  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def narrow_bswap_splat_poison_elt_before := [llvmfunc|
  llvm.func @narrow_bswap_splat_poison_elt(%arg0: vector<2xi16>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(48 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.zext %arg0 : vector<2xi16> to vector<2xi64>
    %8 = llvm.intr.bswap(%7)  : (vector<2xi64>) -> vector<2xi64>
    %9 = llvm.lshr %8, %6  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }]

def narrow_bswap_overshift_before := [llvmfunc|
  llvm.func @narrow_bswap_overshift(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<48> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %2 = llvm.intr.bswap(%1)  : (vector<2xi64>) -> vector<2xi64>
    %3 = llvm.lshr %2, %0  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def narrow_bswap_overshift2_before := [llvmfunc|
  llvm.func @narrow_bswap_overshift2(%arg0: i96) -> i128 {
    %0 = llvm.mlir.constant(61 : i128) : i128
    %1 = llvm.zext %arg0 : i96 to i128
    %2 = llvm.intr.bswap(%1)  : (i128) -> i128
    %3 = llvm.lshr %2, %0  : i128
    llvm.return %3 : i128
  }]

def not_narrow_bswap_before := [llvmfunc|
  llvm.func @not_narrow_bswap(%arg0: i24) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i24 to i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }]

def not_signbit_before := [llvmfunc|
  llvm.func @not_signbit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_signbit_vec_before := [llvmfunc|
  llvm.func @not_signbit_vec(%arg0: vector<2xi6>) -> vector<2xi6> {
    %0 = llvm.mlir.poison : i6
    %1 = llvm.mlir.constant(-1 : i6) : i6
    %2 = llvm.mlir.undef : vector<2xi6>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi6>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi6>
    %7 = llvm.mlir.constant(5 : i6) : i6
    %8 = llvm.mlir.undef : vector<2xi6>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi6>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi6>
    %13 = llvm.xor %arg0, %6  : vector<2xi6>
    %14 = llvm.lshr %13, %12  : vector<2xi6>
    llvm.return %14 : vector<2xi6>
  }]

def not_signbit_alt_xor_before := [llvmfunc|
  llvm.func @not_signbit_alt_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_not_signbit_before := [llvmfunc|
  llvm.func @not_not_signbit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }]

def not_signbit_use_before := [llvmfunc|
  llvm.func @not_signbit_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

def not_signbit_zext_before := [llvmfunc|
  llvm.func @not_signbit_zext(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %2, %1  : i16
    %4 = llvm.zext %3 : i16 to i32
    llvm.return %4 : i32
  }]

def not_signbit_trunc_before := [llvmfunc|
  llvm.func @not_signbit_trunc(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(15 : i16) : i16
    %2 = llvm.xor %arg0, %0  : i16
    %3 = llvm.lshr %2, %1  : i16
    %4 = llvm.trunc %3 : i16 to i8
    llvm.return %4 : i8
  }]

def bool_add_lshr_before := [llvmfunc|
  llvm.func @bool_add_lshr(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2  : i2
    %4 = llvm.lshr %3, %0  : i2
    llvm.return %4 : i2
  }]

def not_bool_add_lshr_before := [llvmfunc|
  llvm.func @not_bool_add_lshr(%arg0: i2, %arg1: i2) -> i4 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.zext %arg0 : i2 to i4
    %2 = llvm.zext %arg1 : i2 to i4
    %3 = llvm.add %1, %2  : i4
    %4 = llvm.lshr %3, %0  : i4
    llvm.return %4 : i4
  }]

def bool_add_ashr_before := [llvmfunc|
  llvm.func @bool_add_ashr(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2  : i2
    %4 = llvm.ashr %3, %0  : i2
    llvm.return %4 : i2
  }]

def bool_add_lshr_vec_before := [llvmfunc|
  llvm.func @bool_add_lshr_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.add %1, %2  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def bool_add_lshr_uses_before := [llvmfunc|
  llvm.func @bool_add_lshr_uses(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %1, %2  : i32
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }]

def bool_add_lshr_uses2_before := [llvmfunc|
  llvm.func @bool_add_lshr_uses2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %1, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }]

def bool_add_lshr_uses3_before := [llvmfunc|
  llvm.func @bool_add_lshr_uses3(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %1, %2  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }]

def bool_add_lshr_vec_wrong_shift_amt_before := [llvmfunc|
  llvm.func @bool_add_lshr_vec_wrong_shift_amt(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.add %1, %2  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def lshr_ctlz_zero_is_not_undef_combined := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_not_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr_ctlz_zero_is_not_undef   : lshr_ctlz_zero_is_not_undef_before  ⊑  lshr_ctlz_zero_is_not_undef_combined := by
  unfold lshr_ctlz_zero_is_not_undef_before lshr_ctlz_zero_is_not_undef_combined
  simp_alive_peephole
  sorry
def lshr_cttz_zero_is_not_undef_combined := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_not_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr_cttz_zero_is_not_undef   : lshr_cttz_zero_is_not_undef_before  ⊑  lshr_cttz_zero_is_not_undef_combined := by
  unfold lshr_cttz_zero_is_not_undef_before lshr_cttz_zero_is_not_undef_combined
  simp_alive_peephole
  sorry
def lshr_ctpop_combined := [llvmfunc|
  llvm.func @lshr_ctpop(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_lshr_ctpop   : lshr_ctpop_before  ⊑  lshr_ctpop_combined := by
  unfold lshr_ctpop_before lshr_ctpop_combined
  simp_alive_peephole
  sorry
def lshr_ctlz_zero_is_not_undef_splat_vec_combined := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_not_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_lshr_ctlz_zero_is_not_undef_splat_vec   : lshr_ctlz_zero_is_not_undef_splat_vec_before  ⊑  lshr_ctlz_zero_is_not_undef_splat_vec_combined := by
  unfold lshr_ctlz_zero_is_not_undef_splat_vec_before lshr_ctlz_zero_is_not_undef_splat_vec_combined
  simp_alive_peephole
  sorry
def lshr_cttz_zero_is_not_undef_splat_vec_combined := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_not_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_lshr_cttz_zero_is_not_undef_splat_vec   : lshr_cttz_zero_is_not_undef_splat_vec_before  ⊑  lshr_cttz_zero_is_not_undef_splat_vec_combined := by
  unfold lshr_cttz_zero_is_not_undef_splat_vec_before lshr_cttz_zero_is_not_undef_splat_vec_combined
  simp_alive_peephole
  sorry
def lshr_ctpop_splat_vec_combined := [llvmfunc|
  llvm.func @lshr_ctpop_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_lshr_ctpop_splat_vec   : lshr_ctpop_splat_vec_before  ⊑  lshr_ctpop_splat_vec_combined := by
  unfold lshr_ctpop_splat_vec_before lshr_ctpop_splat_vec_combined
  simp_alive_peephole
  sorry
def lshr_ctlz_zero_is_undef_combined := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_lshr_ctlz_zero_is_undef   : lshr_ctlz_zero_is_undef_before  ⊑  lshr_ctlz_zero_is_undef_combined := by
  unfold lshr_ctlz_zero_is_undef_before lshr_ctlz_zero_is_undef_combined
  simp_alive_peephole
  sorry
def lshr_cttz_zero_is_undef_combined := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_undef(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_lshr_cttz_zero_is_undef   : lshr_cttz_zero_is_undef_before  ⊑  lshr_cttz_zero_is_undef_combined := by
  unfold lshr_cttz_zero_is_undef_before lshr_cttz_zero_is_undef_combined
  simp_alive_peephole
  sorry
def lshr_ctlz_zero_is_undef_splat_vec_combined := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_lshr_ctlz_zero_is_undef_splat_vec   : lshr_ctlz_zero_is_undef_splat_vec_before  ⊑  lshr_ctlz_zero_is_undef_splat_vec_combined := by
  unfold lshr_ctlz_zero_is_undef_splat_vec_before lshr_ctlz_zero_is_undef_splat_vec_combined
  simp_alive_peephole
  sorry
def lshr_ctlz_zero_is_undef_vec_combined := [llvmfunc|
  llvm.func @lshr_ctlz_zero_is_undef_vec(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_lshr_ctlz_zero_is_undef_vec   : lshr_ctlz_zero_is_undef_vec_before  ⊑  lshr_ctlz_zero_is_undef_vec_combined := by
  unfold lshr_ctlz_zero_is_undef_vec_before lshr_ctlz_zero_is_undef_vec_combined
  simp_alive_peephole
  sorry
def lshr_cttz_zero_is_undef_splat_vec_combined := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_undef_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_lshr_cttz_zero_is_undef_splat_vec   : lshr_cttz_zero_is_undef_splat_vec_before  ⊑  lshr_cttz_zero_is_undef_splat_vec_combined := by
  unfold lshr_cttz_zero_is_undef_splat_vec_before lshr_cttz_zero_is_undef_splat_vec_combined
  simp_alive_peephole
  sorry
def lshr_cttz_zero_is_undef_vec_combined := [llvmfunc|
  llvm.func @lshr_cttz_zero_is_undef_vec(%arg0: vector<2xi8>) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_lshr_cttz_zero_is_undef_vec   : lshr_cttz_zero_is_undef_vec_before  ⊑  lshr_cttz_zero_is_undef_vec_combined := by
  unfold lshr_cttz_zero_is_undef_vec_before lshr_cttz_zero_is_undef_vec_combined
  simp_alive_peephole
  sorry
def lshr_exact_combined := [llvmfunc|
  llvm.func @lshr_exact(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.and %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_lshr_exact   : lshr_exact_before  ⊑  lshr_exact_combined := by
  unfold lshr_exact_before lshr_exact_combined
  simp_alive_peephole
  sorry
def lshr_exact_splat_vec_combined := [llvmfunc|
  llvm.func @lshr_exact_splat_vec(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<63> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_lshr_exact_splat_vec   : lshr_exact_splat_vec_before  ⊑  lshr_exact_splat_vec_combined := by
  unfold lshr_exact_splat_vec_before lshr_exact_splat_vec_combined
  simp_alive_peephole
  sorry
def lshr_exact_splat_vec_nuw_combined := [llvmfunc|
  llvm.func @lshr_exact_splat_vec_nuw(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<63> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.and %2, %1  : vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_lshr_exact_splat_vec_nuw   : lshr_exact_splat_vec_nuw_before  ⊑  lshr_exact_splat_vec_nuw_combined := by
  unfold lshr_exact_splat_vec_nuw_before lshr_exact_splat_vec_nuw_combined
  simp_alive_peephole
  sorry
def shl_add_combined := [llvmfunc|
  llvm.func @shl_add(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.add %2, %arg0  : i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_shl_add   : shl_add_before  ⊑  shl_add_combined := by
  unfold shl_add_before shl_add_combined
  simp_alive_peephole
  sorry
def shl_add_commute_vec_combined := [llvmfunc|
  llvm.func @shl_add_commute_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<31> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg1, %arg1  : vector<2xi8>
    %3 = llvm.lshr %2, %0  : vector<2xi8>
    %4 = llvm.add %3, %arg0  : vector<2xi8>
    %5 = llvm.and %4, %1  : vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_shl_add_commute_vec   : shl_add_commute_vec_before  ⊑  shl_add_commute_vec_combined := by
  unfold shl_add_commute_vec_before shl_add_commute_vec_combined
  simp_alive_peephole
  sorry
def shl_add_use1_combined := [llvmfunc|
  llvm.func @shl_add_use1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.add %1, %arg1  : i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_shl_add_use1   : shl_add_use1_before  ⊑  shl_add_use1_combined := by
  unfold shl_add_use1_before shl_add_use1_combined
  simp_alive_peephole
  sorry
def shl_add_use2_combined := [llvmfunc|
  llvm.func @shl_add_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_shl_add_use2   : shl_add_use2_before  ⊑  shl_add_use2_combined := by
  unfold shl_add_use2_before shl_add_use2_combined
  simp_alive_peephole
  sorry
def bool_zext_combined := [llvmfunc|
  llvm.func @bool_zext(%arg0: i1) -> i16 {
    %0 = llvm.zext %arg0 : i1 to i16
    llvm.return %0 : i16
  }]

theorem inst_combine_bool_zext   : bool_zext_before  ⊑  bool_zext_combined := by
  unfold bool_zext_before bool_zext_combined
  simp_alive_peephole
  sorry
def bool_zext_use_combined := [llvmfunc|
  llvm.func @bool_zext_use(%arg0: i1) -> i32 {
    %0 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_bool_zext_use   : bool_zext_use_before  ⊑  bool_zext_use_combined := by
  unfold bool_zext_use_before bool_zext_use_combined
  simp_alive_peephole
  sorry
def bool_zext_splat_combined := [llvmfunc|
  llvm.func @bool_zext_splat(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    llvm.return %0 : vector<2xi8>
  }]

theorem inst_combine_bool_zext_splat   : bool_zext_splat_before  ⊑  bool_zext_splat_combined := by
  unfold bool_zext_splat_before bool_zext_splat_combined
  simp_alive_peephole
  sorry
def smear_sign_and_widen_combined := [llvmfunc|
  llvm.func @smear_sign_and_widen(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_smear_sign_and_widen   : smear_sign_and_widen_before  ⊑  smear_sign_and_widen_combined := by
  unfold smear_sign_and_widen_before smear_sign_and_widen_combined
  simp_alive_peephole
  sorry
def smear_sign_and_widen_should_not_change_type_combined := [llvmfunc|
  llvm.func @smear_sign_and_widen_should_not_change_type(%arg0: i4) -> i16 {
    %0 = llvm.mlir.constant(12 : i16) : i16
    %1 = llvm.sext %arg0 : i4 to i16
    %2 = llvm.lshr %1, %0  : i16
    llvm.return %2 : i16
  }]

theorem inst_combine_smear_sign_and_widen_should_not_change_type   : smear_sign_and_widen_should_not_change_type_before  ⊑  smear_sign_and_widen_should_not_change_type_combined := by
  unfold smear_sign_and_widen_should_not_change_type_before smear_sign_and_widen_should_not_change_type_combined
  simp_alive_peephole
  sorry
def smear_sign_and_widen_splat_combined := [llvmfunc|
  llvm.func @smear_sign_and_widen_splat(%arg0: vector<2xi6>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(2 : i6) : i6
    %1 = llvm.mlir.constant(dense<2> : vector<2xi6>) : vector<2xi6>
    %2 = llvm.ashr %arg0, %1  : vector<2xi6>
    %3 = llvm.zext %2 : vector<2xi6> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_smear_sign_and_widen_splat   : smear_sign_and_widen_splat_before  ⊑  smear_sign_and_widen_splat_combined := by
  unfold smear_sign_and_widen_splat_before smear_sign_and_widen_splat_combined
  simp_alive_peephole
  sorry
def fake_sext_combined := [llvmfunc|
  llvm.func @fake_sext(%arg0: i3) -> i18 {
    %0 = llvm.mlir.constant(2 : i3) : i3
    %1 = llvm.lshr %arg0, %0  : i3
    %2 = llvm.zext %1 : i3 to i18
    llvm.return %2 : i18
  }]

theorem inst_combine_fake_sext   : fake_sext_before  ⊑  fake_sext_combined := by
  unfold fake_sext_before fake_sext_combined
  simp_alive_peephole
  sorry
def fake_sext_but_should_not_change_type_combined := [llvmfunc|
  llvm.func @fake_sext_but_should_not_change_type(%arg0: i3) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg0 : i3 to i32
    %2 = llvm.lshr %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fake_sext_but_should_not_change_type   : fake_sext_but_should_not_change_type_before  ⊑  fake_sext_but_should_not_change_type_combined := by
  unfold fake_sext_but_should_not_change_type_before fake_sext_but_should_not_change_type_combined
  simp_alive_peephole
  sorry
def fake_sext_splat_combined := [llvmfunc|
  llvm.func @fake_sext_splat(%arg0: vector<2xi3>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(2 : i3) : i3
    %1 = llvm.mlir.constant(dense<2> : vector<2xi3>) : vector<2xi3>
    %2 = llvm.lshr %arg0, %1  : vector<2xi3>
    %3 = llvm.zext %2 : vector<2xi3> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_fake_sext_splat   : fake_sext_splat_before  ⊑  fake_sext_splat_combined := by
  unfold fake_sext_splat_before fake_sext_splat_combined
  simp_alive_peephole
  sorry
def narrow_lshr_constant_combined := [llvmfunc|
  llvm.func @narrow_lshr_constant(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %arg0, %0  : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi8> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_narrow_lshr_constant   : narrow_lshr_constant_before  ⊑  narrow_lshr_constant_combined := by
  unfold narrow_lshr_constant_before narrow_lshr_constant_combined
  simp_alive_peephole
  sorry
def mul_splat_fold_combined := [llvmfunc|
  llvm.func @mul_splat_fold(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_mul_splat_fold   : mul_splat_fold_before  ⊑  mul_splat_fold_combined := by
  unfold mul_splat_fold_before mul_splat_fold_combined
  simp_alive_peephole
  sorry
def mul_splat_fold_vec_combined := [llvmfunc|
  llvm.func @mul_splat_fold_vec(%arg0: vector<3xi14>) -> vector<3xi14> {
    %0 = llvm.mlir.constant(129 : i14) : i14
    %1 = llvm.mlir.constant(dense<129> : vector<3xi14>) : vector<3xi14>
    %2 = llvm.mlir.constant(127 : i14) : i14
    %3 = llvm.mlir.constant(dense<127> : vector<3xi14>) : vector<3xi14>
    %4 = llvm.mul %arg0, %1 overflow<nuw>  : vector<3xi14>
    llvm.call @usevec(%4) : (vector<3xi14>) -> ()
    %5 = llvm.and %arg0, %3  : vector<3xi14>
    llvm.return %5 : vector<3xi14>
  }]

theorem inst_combine_mul_splat_fold_vec   : mul_splat_fold_vec_before  ⊑  mul_splat_fold_vec_combined := by
  unfold mul_splat_fold_vec_before mul_splat_fold_vec_combined
  simp_alive_peephole
  sorry
def shl_add_lshr_flag_preservation_combined := [llvmfunc|
  llvm.func @shl_add_lshr_flag_preservation(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_add_lshr_flag_preservation   : shl_add_lshr_flag_preservation_before  ⊑  shl_add_lshr_flag_preservation_combined := by
  unfold shl_add_lshr_flag_preservation_before shl_add_lshr_flag_preservation_combined
  simp_alive_peephole
  sorry
def shl_add_lshr_combined := [llvmfunc|
  llvm.func @shl_add_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_add_lshr   : shl_add_lshr_before  ⊑  shl_add_lshr_combined := by
  unfold shl_add_lshr_before shl_add_lshr_combined
  simp_alive_peephole
  sorry
def shl_add_lshr_comm_combined := [llvmfunc|
  llvm.func @shl_add_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.mul %arg2, %arg2  : i32
    %2 = llvm.add %1, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %arg1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_shl_add_lshr_comm   : shl_add_lshr_comm_before  ⊑  shl_add_lshr_comm_combined := by
  unfold shl_add_lshr_comm_before shl_add_lshr_comm_combined
  simp_alive_peephole
  sorry
def shl_add_lshr_no_nuw_combined := [llvmfunc|
  llvm.func @shl_add_lshr_no_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_add_lshr_no_nuw   : shl_add_lshr_no_nuw_before  ⊑  shl_add_lshr_no_nuw_combined := by
  unfold shl_add_lshr_no_nuw_before shl_add_lshr_no_nuw_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_not_exact_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_not_exact(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %0, %arg2 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_not_exact   : shl_sub_lshr_not_exact_before  ⊑  shl_sub_lshr_not_exact_combined := by
  unfold shl_sub_lshr_not_exact_before shl_sub_lshr_not_exact_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_no_nuw_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_no_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw>  : i32
    %1 = llvm.sub %0, %arg2 overflow<nsw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_no_nuw   : shl_sub_lshr_no_nuw_before  ⊑  shl_sub_lshr_no_nuw_combined := by
  unfold shl_sub_lshr_no_nuw_before shl_sub_lshr_no_nuw_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_combined := [llvmfunc|
  llvm.func @shl_sub_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr   : shl_sub_lshr_before  ⊑  shl_sub_lshr_combined := by
  unfold shl_sub_lshr_before shl_sub_lshr_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_reverse_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_reverse   : shl_sub_lshr_reverse_before  ⊑  shl_sub_lshr_reverse_combined := by
  unfold shl_sub_lshr_reverse_before shl_sub_lshr_reverse_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_reverse_no_nsw_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_no_nsw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_reverse_no_nsw   : shl_sub_lshr_reverse_no_nsw_before  ⊑  shl_sub_lshr_reverse_no_nsw_combined := by
  unfold shl_sub_lshr_reverse_no_nsw_before shl_sub_lshr_reverse_no_nsw_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_reverse_nsw_on_op1_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_nsw_on_op1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_reverse_nsw_on_op1   : shl_sub_lshr_reverse_nsw_on_op1_before  ⊑  shl_sub_lshr_reverse_nsw_on_op1_combined := by
  unfold shl_sub_lshr_reverse_nsw_on_op1_before shl_sub_lshr_reverse_nsw_on_op1_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_reverse_no_exact_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_no_exact(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_reverse_no_exact   : shl_sub_lshr_reverse_no_exact_before  ⊑  shl_sub_lshr_reverse_no_exact_combined := by
  unfold shl_sub_lshr_reverse_no_exact_before shl_sub_lshr_reverse_no_exact_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_reverse_multiuse_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_multiuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_reverse_multiuse   : shl_sub_lshr_reverse_multiuse_before  ⊑  shl_sub_lshr_reverse_multiuse_combined := by
  unfold shl_sub_lshr_reverse_multiuse_before shl_sub_lshr_reverse_multiuse_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_reverse_multiuse2_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_multiuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_reverse_multiuse2   : shl_sub_lshr_reverse_multiuse2_before  ⊑  shl_sub_lshr_reverse_multiuse2_combined := by
  unfold shl_sub_lshr_reverse_multiuse2_before shl_sub_lshr_reverse_multiuse2_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_reverse_no_nuw_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_no_nuw(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1  : i32
    %1 = llvm.sub %arg2, %0 overflow<nuw>  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_reverse_no_nuw   : shl_sub_lshr_reverse_no_nuw_before  ⊑  shl_sub_lshr_reverse_no_nuw_combined := by
  unfold shl_sub_lshr_reverse_no_nuw_before shl_sub_lshr_reverse_no_nuw_combined
  simp_alive_peephole
  sorry
def shl_sub_lshr_reverse_no_nsw_2_combined := [llvmfunc|
  llvm.func @shl_sub_lshr_reverse_no_nsw_2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nsw, nuw>  : i32
    %1 = llvm.sub %arg2, %0  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_sub_lshr_reverse_no_nsw_2   : shl_sub_lshr_reverse_no_nsw_2_before  ⊑  shl_sub_lshr_reverse_no_nsw_2_combined := by
  unfold shl_sub_lshr_reverse_no_nsw_2_before shl_sub_lshr_reverse_no_nsw_2_combined
  simp_alive_peephole
  sorry
def shl_or_lshr_combined := [llvmfunc|
  llvm.func @shl_or_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_or_lshr   : shl_or_lshr_before  ⊑  shl_or_lshr_combined := by
  unfold shl_or_lshr_before shl_or_lshr_combined
  simp_alive_peephole
  sorry
def shl_or_disjoint_lshr_combined := [llvmfunc|
  llvm.func @shl_or_disjoint_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_or_disjoint_lshr   : shl_or_disjoint_lshr_before  ⊑  shl_or_disjoint_lshr_combined := by
  unfold shl_or_disjoint_lshr_before shl_or_disjoint_lshr_combined
  simp_alive_peephole
  sorry
def shl_or_lshr_comm_combined := [llvmfunc|
  llvm.func @shl_or_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_or_lshr_comm   : shl_or_lshr_comm_before  ⊑  shl_or_lshr_comm_combined := by
  unfold shl_or_lshr_comm_before shl_or_lshr_comm_combined
  simp_alive_peephole
  sorry
def shl_or_disjoint_lshr_comm_combined := [llvmfunc|
  llvm.func @shl_or_disjoint_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.or %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_or_disjoint_lshr_comm   : shl_or_disjoint_lshr_comm_before  ⊑  shl_or_disjoint_lshr_comm_combined := by
  unfold shl_or_disjoint_lshr_comm_before shl_or_disjoint_lshr_comm_combined
  simp_alive_peephole
  sorry
def shl_xor_lshr_combined := [llvmfunc|
  llvm.func @shl_xor_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.xor %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_xor_lshr   : shl_xor_lshr_before  ⊑  shl_xor_lshr_combined := by
  unfold shl_xor_lshr_before shl_xor_lshr_combined
  simp_alive_peephole
  sorry
def shl_xor_lshr_comm_combined := [llvmfunc|
  llvm.func @shl_xor_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.xor %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_xor_lshr_comm   : shl_xor_lshr_comm_before  ⊑  shl_xor_lshr_comm_combined := by
  unfold shl_xor_lshr_comm_before shl_xor_lshr_comm_combined
  simp_alive_peephole
  sorry
def shl_and_lshr_combined := [llvmfunc|
  llvm.func @shl_and_lshr(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_and_lshr   : shl_and_lshr_before  ⊑  shl_and_lshr_combined := by
  unfold shl_and_lshr_before shl_and_lshr_combined
  simp_alive_peephole
  sorry
def shl_and_lshr_comm_combined := [llvmfunc|
  llvm.func @shl_and_lshr_comm(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_and_lshr_comm   : shl_and_lshr_comm_before  ⊑  shl_and_lshr_comm_combined := by
  unfold shl_and_lshr_comm_before shl_and_lshr_comm_combined
  simp_alive_peephole
  sorry
def shl_lshr_and_exact_combined := [llvmfunc|
  llvm.func @shl_lshr_and_exact(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.and %0, %arg2  : i32
    %2 = llvm.lshr %1, %arg1  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_lshr_and_exact   : shl_lshr_and_exact_before  ⊑  shl_lshr_and_exact_combined := by
  unfold shl_lshr_and_exact_before shl_lshr_and_exact_combined
  simp_alive_peephole
  sorry
def shl_add_lshr_neg_combined := [llvmfunc|
  llvm.func @shl_add_lshr_neg(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nsw, nuw>  : i32
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_add_lshr_neg   : shl_add_lshr_neg_before  ⊑  shl_add_lshr_neg_combined := by
  unfold shl_add_lshr_neg_before shl_add_lshr_neg_combined
  simp_alive_peephole
  sorry
def mul_splat_fold_wrong_mul_const_combined := [llvmfunc|
  llvm.func @mul_splat_fold_wrong_mul_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65538 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_splat_fold_wrong_mul_const   : mul_splat_fold_wrong_mul_const_before  ⊑  mul_splat_fold_wrong_mul_const_combined := by
  unfold mul_splat_fold_wrong_mul_const_before mul_splat_fold_wrong_mul_const_combined
  simp_alive_peephole
  sorry
def shl_add_lshr_multiuse_combined := [llvmfunc|
  llvm.func @shl_add_lshr_multiuse(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.shl %arg0, %arg1 overflow<nuw>  : i32
    %1 = llvm.add %0, %arg2 overflow<nsw, nuw>  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.lshr %1, %arg2  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shl_add_lshr_multiuse   : shl_add_lshr_multiuse_before  ⊑  shl_add_lshr_multiuse_combined := by
  unfold shl_add_lshr_multiuse_before shl_add_lshr_multiuse_combined
  simp_alive_peephole
  sorry
def mul_splat_fold_wrong_lshr_const_combined := [llvmfunc|
  llvm.func @mul_splat_fold_wrong_lshr_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nuw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_splat_fold_wrong_lshr_const   : mul_splat_fold_wrong_lshr_const_before  ⊑  mul_splat_fold_wrong_lshr_const_combined := by
  unfold mul_splat_fold_wrong_lshr_const_before mul_splat_fold_wrong_lshr_const_combined
  simp_alive_peephole
  sorry
def mul_splat_fold_no_nuw_combined := [llvmfunc|
  llvm.func @mul_splat_fold_no_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_splat_fold_no_nuw   : mul_splat_fold_no_nuw_before  ⊑  mul_splat_fold_no_nuw_combined := by
  unfold mul_splat_fold_no_nuw_before mul_splat_fold_no_nuw_combined
  simp_alive_peephole
  sorry
def mul_splat_fold_no_flags_combined := [llvmfunc|
  llvm.func @mul_splat_fold_no_flags(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(16 : i32) : i32
    %2 = llvm.mul %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_splat_fold_no_flags   : mul_splat_fold_no_flags_before  ⊑  mul_splat_fold_no_flags_combined := by
  unfold mul_splat_fold_no_flags_before mul_splat_fold_no_flags_combined
  simp_alive_peephole
  sorry
def mul_splat_fold_too_narrow_combined := [llvmfunc|
  llvm.func @mul_splat_fold_too_narrow(%arg0: i2) -> i2 {
    llvm.return %arg0 : i2
  }]

theorem inst_combine_mul_splat_fold_too_narrow   : mul_splat_fold_too_narrow_before  ⊑  mul_splat_fold_too_narrow_combined := by
  unfold mul_splat_fold_too_narrow_before mul_splat_fold_too_narrow_combined
  simp_alive_peephole
  sorry
def negative_and_odd_combined := [llvmfunc|
  llvm.func @negative_and_odd(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.and %1, %arg0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_negative_and_odd   : negative_and_odd_before  ⊑  negative_and_odd_combined := by
  unfold negative_and_odd_before negative_and_odd_combined
  simp_alive_peephole
  sorry
def negative_and_odd_vec_combined := [llvmfunc|
  llvm.func @negative_and_odd_vec(%arg0: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(6 : i7) : i7
    %1 = llvm.mlir.constant(dense<6> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.lshr %arg0, %1  : vector<2xi7>
    %3 = llvm.and %2, %arg0  : vector<2xi7>
    llvm.return %3 : vector<2xi7>
  }]

theorem inst_combine_negative_and_odd_vec   : negative_and_odd_vec_before  ⊑  negative_and_odd_vec_combined := by
  unfold negative_and_odd_vec_before negative_and_odd_vec_combined
  simp_alive_peephole
  sorry
def negative_and_odd_uses_combined := [llvmfunc|
  llvm.func @negative_and_odd_uses(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_negative_and_odd_uses   : negative_and_odd_uses_before  ⊑  negative_and_odd_uses_combined := by
  unfold negative_and_odd_uses_before negative_and_odd_uses_combined
  simp_alive_peephole
  sorry
def srem3_combined := [llvmfunc|
  llvm.func @srem3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_srem3   : srem3_before  ⊑  srem3_combined := by
  unfold srem3_before srem3_combined
  simp_alive_peephole
  sorry
def srem2_lshr30_combined := [llvmfunc|
  llvm.func @srem2_lshr30(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_srem2_lshr30   : srem2_lshr30_before  ⊑  srem2_lshr30_combined := by
  unfold srem2_lshr30_before srem2_lshr30_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_combined := [llvmfunc|
  llvm.func @trunc_sandwich(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i12
    llvm.return %2 : i12
  }]

theorem inst_combine_trunc_sandwich   : trunc_sandwich_before  ⊑  trunc_sandwich_combined := by
  unfold trunc_sandwich_before trunc_sandwich_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_splat_vec_combined := [llvmfunc|
  llvm.func @trunc_sandwich_splat_vec(%arg0: vector<2xi32>) -> vector<2xi12> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi12>
    llvm.return %2 : vector<2xi12>
  }]

theorem inst_combine_trunc_sandwich_splat_vec   : trunc_sandwich_splat_vec_before  ⊑  trunc_sandwich_splat_vec_combined := by
  unfold trunc_sandwich_splat_vec_before trunc_sandwich_splat_vec_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_min_shift1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_min_shift1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i12
    llvm.return %2 : i12
  }]

theorem inst_combine_trunc_sandwich_min_shift1   : trunc_sandwich_min_shift1_before  ⊑  trunc_sandwich_min_shift1_combined := by
  unfold trunc_sandwich_min_shift1_before trunc_sandwich_min_shift1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_small_shift1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_small_shift1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(2047 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.and %3, %1  : i12
    llvm.return %4 : i12
  }]

theorem inst_combine_trunc_sandwich_small_shift1   : trunc_sandwich_small_shift1_before  ⊑  trunc_sandwich_small_shift1_combined := by
  unfold trunc_sandwich_small_shift1_before trunc_sandwich_small_shift1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_max_sum_shift_combined := [llvmfunc|
  llvm.func @trunc_sandwich_max_sum_shift(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i12
    llvm.return %2 : i12
  }]

theorem inst_combine_trunc_sandwich_max_sum_shift   : trunc_sandwich_max_sum_shift_before  ⊑  trunc_sandwich_max_sum_shift_combined := by
  unfold trunc_sandwich_max_sum_shift_before trunc_sandwich_max_sum_shift_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_max_sum_shift2_combined := [llvmfunc|
  llvm.func @trunc_sandwich_max_sum_shift2(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i12
    llvm.return %2 : i12
  }]

theorem inst_combine_trunc_sandwich_max_sum_shift2   : trunc_sandwich_max_sum_shift2_before  ⊑  trunc_sandwich_max_sum_shift2_combined := by
  unfold trunc_sandwich_max_sum_shift2_before trunc_sandwich_max_sum_shift2_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_big_sum_shift1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_big_sum_shift1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(0 : i12) : i12
    llvm.return %0 : i12
  }]

theorem inst_combine_trunc_sandwich_big_sum_shift1   : trunc_sandwich_big_sum_shift1_before  ⊑  trunc_sandwich_big_sum_shift1_combined := by
  unfold trunc_sandwich_big_sum_shift1_before trunc_sandwich_big_sum_shift1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_big_sum_shift2_combined := [llvmfunc|
  llvm.func @trunc_sandwich_big_sum_shift2(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(0 : i12) : i12
    llvm.return %0 : i12
  }]

theorem inst_combine_trunc_sandwich_big_sum_shift2   : trunc_sandwich_big_sum_shift2_before  ⊑  trunc_sandwich_big_sum_shift2_combined := by
  unfold trunc_sandwich_big_sum_shift2_before trunc_sandwich_big_sum_shift2_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_use1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(28 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.trunc %3 : i32 to i12
    llvm.return %4 : i12
  }]

theorem inst_combine_trunc_sandwich_use1   : trunc_sandwich_use1_before  ⊑  trunc_sandwich_use1_combined := by
  unfold trunc_sandwich_use1_before trunc_sandwich_use1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_splat_vec_use1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_splat_vec_use1(%arg0: vector<3xi14>) -> vector<3xi9> {
    %0 = llvm.mlir.constant(6 : i14) : i14
    %1 = llvm.mlir.constant(dense<6> : vector<3xi14>) : vector<3xi14>
    %2 = llvm.mlir.constant(11 : i14) : i14
    %3 = llvm.mlir.constant(dense<11> : vector<3xi14>) : vector<3xi14>
    %4 = llvm.lshr %arg0, %1  : vector<3xi14>
    llvm.call @usevec(%4) : (vector<3xi14>) -> ()
    %5 = llvm.lshr %arg0, %3  : vector<3xi14>
    %6 = llvm.trunc %5 : vector<3xi14> to vector<3xi9>
    llvm.return %6 : vector<3xi9>
  }]

theorem inst_combine_trunc_sandwich_splat_vec_use1   : trunc_sandwich_splat_vec_use1_before  ⊑  trunc_sandwich_splat_vec_use1_combined := by
  unfold trunc_sandwich_splat_vec_use1_before trunc_sandwich_splat_vec_use1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_min_shift1_use1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_min_shift1_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(21 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.trunc %3 : i32 to i12
    llvm.return %4 : i12
  }]

theorem inst_combine_trunc_sandwich_min_shift1_use1   : trunc_sandwich_min_shift1_use1_before  ⊑  trunc_sandwich_min_shift1_use1_combined := by
  unfold trunc_sandwich_min_shift1_use1_before trunc_sandwich_min_shift1_use1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_small_shift1_use1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_small_shift1_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(19 : i32) : i32
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.trunc %2 : i32 to i12
    %4 = llvm.lshr %3, %1  : i12
    llvm.return %4 : i12
  }]

theorem inst_combine_trunc_sandwich_small_shift1_use1   : trunc_sandwich_small_shift1_use1_before  ⊑  trunc_sandwich_small_shift1_use1_combined := by
  unfold trunc_sandwich_small_shift1_use1_before trunc_sandwich_small_shift1_use1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_max_sum_shift_use1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_max_sum_shift_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.trunc %3 : i32 to i12
    llvm.return %4 : i12
  }]

theorem inst_combine_trunc_sandwich_max_sum_shift_use1   : trunc_sandwich_max_sum_shift_use1_before  ⊑  trunc_sandwich_max_sum_shift_use1_combined := by
  unfold trunc_sandwich_max_sum_shift_use1_before trunc_sandwich_max_sum_shift_use1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_max_sum_shift2_use1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_max_sum_shift2_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.trunc %3 : i32 to i12
    llvm.return %4 : i12
  }]

theorem inst_combine_trunc_sandwich_max_sum_shift2_use1   : trunc_sandwich_max_sum_shift2_use1_before  ⊑  trunc_sandwich_max_sum_shift2_use1_combined := by
  unfold trunc_sandwich_max_sum_shift2_use1_before trunc_sandwich_max_sum_shift2_use1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_big_sum_shift1_use1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_big_sum_shift1_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(0 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %1 : i12
  }]

theorem inst_combine_trunc_sandwich_big_sum_shift1_use1   : trunc_sandwich_big_sum_shift1_use1_before  ⊑  trunc_sandwich_big_sum_shift1_use1_combined := by
  unfold trunc_sandwich_big_sum_shift1_use1_before trunc_sandwich_big_sum_shift1_use1_combined
  simp_alive_peephole
  sorry
def trunc_sandwich_big_sum_shift2_use1_combined := [llvmfunc|
  llvm.func @trunc_sandwich_big_sum_shift2_use1(%arg0: i32) -> i12 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i12) : i12
    %2 = llvm.lshr %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %1 : i12
  }]

theorem inst_combine_trunc_sandwich_big_sum_shift2_use1   : trunc_sandwich_big_sum_shift2_use1_before  ⊑  trunc_sandwich_big_sum_shift2_use1_combined := by
  unfold trunc_sandwich_big_sum_shift2_use1_before trunc_sandwich_big_sum_shift2_use1_combined
  simp_alive_peephole
  sorry
def lshr_sext_i1_to_i16_combined := [llvmfunc|
  llvm.func @lshr_sext_i1_to_i16(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(4095 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.select %arg0, %0, %1 : i1, i16
    llvm.return %2 : i16
  }]

theorem inst_combine_lshr_sext_i1_to_i16   : lshr_sext_i1_to_i16_before  ⊑  lshr_sext_i1_to_i16_combined := by
  unfold lshr_sext_i1_to_i16_before lshr_sext_i1_to_i16_combined
  simp_alive_peephole
  sorry
def lshr_sext_i1_to_i128_combined := [llvmfunc|
  llvm.func @lshr_sext_i1_to_i128(%arg0: i1) -> i128 {
    %0 = llvm.mlir.constant(77371252455336267181195263 : i128) : i128
    %1 = llvm.mlir.constant(0 : i128) : i128
    %2 = llvm.select %arg0, %0, %1 : i1, i128
    llvm.return %2 : i128
  }]

theorem inst_combine_lshr_sext_i1_to_i128   : lshr_sext_i1_to_i128_before  ⊑  lshr_sext_i1_to_i128_combined := by
  unfold lshr_sext_i1_to_i128_before lshr_sext_i1_to_i128_combined
  simp_alive_peephole
  sorry
def lshr_sext_i1_to_i32_use_combined := [llvmfunc|
  llvm.func @lshr_sext_i1_to_i32_use(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(262143 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sext %arg0 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_lshr_sext_i1_to_i32_use   : lshr_sext_i1_to_i32_use_before  ⊑  lshr_sext_i1_to_i32_use_combined := by
  unfold lshr_sext_i1_to_i32_use_before lshr_sext_i1_to_i32_use_combined
  simp_alive_peephole
  sorry
def lshr_sext_i1_to_i14_splat_vec_use1_combined := [llvmfunc|
  llvm.func @lshr_sext_i1_to_i14_splat_vec_use1(%arg0: vector<3xi1>) -> vector<3xi14> {
    %0 = llvm.mlir.constant(1023 : i14) : i14
    %1 = llvm.mlir.constant(dense<1023> : vector<3xi14>) : vector<3xi14>
    %2 = llvm.mlir.constant(0 : i14) : i14
    %3 = llvm.mlir.constant(dense<0> : vector<3xi14>) : vector<3xi14>
    %4 = llvm.sext %arg0 : vector<3xi1> to vector<3xi14>
    llvm.call @usevec(%4) : (vector<3xi14>) -> ()
    %5 = llvm.select %arg0, %1, %3 : vector<3xi1>, vector<3xi14>
    llvm.return %5 : vector<3xi14>
  }]

theorem inst_combine_lshr_sext_i1_to_i14_splat_vec_use1   : lshr_sext_i1_to_i14_splat_vec_use1_before  ⊑  lshr_sext_i1_to_i14_splat_vec_use1_combined := by
  unfold lshr_sext_i1_to_i14_splat_vec_use1_before lshr_sext_i1_to_i14_splat_vec_use1_combined
  simp_alive_peephole
  sorry
def icmp_ule_combined := [llvmfunc|
  llvm.func @icmp_ule(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_ule   : icmp_ule_before  ⊑  icmp_ule_combined := by
  unfold icmp_ule_before icmp_ule_combined
  simp_alive_peephole
  sorry
def icmp_ult_combined := [llvmfunc|
  llvm.func @icmp_ult(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ult" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ult   : icmp_ult_before  ⊑  icmp_ult_combined := by
  unfold icmp_ult_before icmp_ult_combined
  simp_alive_peephole
  sorry
def icmp_eq_combined := [llvmfunc|
  llvm.func @icmp_eq(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "eq" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_eq   : icmp_eq_before  ⊑  icmp_eq_combined := by
  unfold icmp_eq_before icmp_eq_combined
  simp_alive_peephole
  sorry
def icmp_ne_combined := [llvmfunc|
  llvm.func @icmp_ne(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "ne" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ne   : icmp_ne_before  ⊑  icmp_ne_combined := by
  unfold icmp_ne_before icmp_ne_combined
  simp_alive_peephole
  sorry
def icmp_ugt_combined := [llvmfunc|
  llvm.func @icmp_ugt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_ugt   : icmp_ugt_before  ⊑  icmp_ugt_combined := by
  unfold icmp_ugt_before icmp_ugt_combined
  simp_alive_peephole
  sorry
def icmp_uge_combined := [llvmfunc|
  llvm.func @icmp_uge(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "uge" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_uge   : icmp_uge_before  ⊑  icmp_uge_combined := by
  unfold icmp_uge_before icmp_uge_combined
  simp_alive_peephole
  sorry
def icmp_sle_combined := [llvmfunc|
  llvm.func @icmp_sle(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "sle" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle   : icmp_sle_before  ⊑  icmp_sle_combined := by
  unfold icmp_sle_before icmp_sle_combined
  simp_alive_peephole
  sorry
def icmp_slt_combined := [llvmfunc|
  llvm.func @icmp_slt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "slt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_slt   : icmp_slt_before  ⊑  icmp_slt_combined := by
  unfold icmp_slt_before icmp_slt_combined
  simp_alive_peephole
  sorry
def icmp_sgt_combined := [llvmfunc|
  llvm.func @icmp_sgt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "sgt" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt   : icmp_sgt_before  ⊑  icmp_sgt_combined := by
  unfold icmp_sgt_before icmp_sgt_combined
  simp_alive_peephole
  sorry
def icmp_sge_combined := [llvmfunc|
  llvm.func @icmp_sge(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.lshr %arg0, %arg1  : i32
    %1 = llvm.icmp "sge" %0, %arg0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sge   : icmp_sge_before  ⊑  icmp_sge_combined := by
  unfold icmp_sge_before icmp_sge_combined
  simp_alive_peephole
  sorry
def narrow_bswap_combined := [llvmfunc|
  llvm.func @narrow_bswap(%arg0: i16) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.zext %0 : i16 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_narrow_bswap   : narrow_bswap_before  ⊑  narrow_bswap_combined := by
  unfold narrow_bswap_before narrow_bswap_combined
  simp_alive_peephole
  sorry
def narrow_bswap_extra_wide_combined := [llvmfunc|
  llvm.func @narrow_bswap_extra_wide(%arg0: i16) -> i128 {
    %0 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %1 = llvm.zext %0 : i16 to i128
    llvm.return %1 : i128
  }]

theorem inst_combine_narrow_bswap_extra_wide   : narrow_bswap_extra_wide_before  ⊑  narrow_bswap_extra_wide_combined := by
  unfold narrow_bswap_extra_wide_before narrow_bswap_extra_wide_combined
  simp_alive_peephole
  sorry
def narrow_bswap_undershift_combined := [llvmfunc|
  llvm.func @narrow_bswap_undershift(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i16) -> i16
    %2 = llvm.zext %1 : i16 to i32
    %3 = llvm.shl %2, %0 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_narrow_bswap_undershift   : narrow_bswap_undershift_before  ⊑  narrow_bswap_undershift_combined := by
  unfold narrow_bswap_undershift_before narrow_bswap_undershift_combined
  simp_alive_peephole
  sorry
def narrow_bswap_splat_combined := [llvmfunc|
  llvm.func @narrow_bswap_splat(%arg0: vector<2xi16>) -> vector<2xi64> {
    %0 = llvm.intr.bswap(%arg0)  : (vector<2xi16>) -> vector<2xi16>
    %1 = llvm.zext %0 : vector<2xi16> to vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }]

theorem inst_combine_narrow_bswap_splat   : narrow_bswap_splat_before  ⊑  narrow_bswap_splat_combined := by
  unfold narrow_bswap_splat_before narrow_bswap_splat_combined
  simp_alive_peephole
  sorry
def narrow_bswap_splat_poison_elt_combined := [llvmfunc|
  llvm.func @narrow_bswap_splat_poison_elt(%arg0: vector<2xi16>) -> vector<2xi64> {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(48 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.zext %arg0 : vector<2xi16> to vector<2xi64>
    %8 = llvm.intr.bswap(%7)  : (vector<2xi64>) -> vector<2xi64>
    %9 = llvm.lshr %8, %6  : vector<2xi64>
    llvm.return %9 : vector<2xi64>
  }]

theorem inst_combine_narrow_bswap_splat_poison_elt   : narrow_bswap_splat_poison_elt_before  ⊑  narrow_bswap_splat_poison_elt_combined := by
  unfold narrow_bswap_splat_poison_elt_before narrow_bswap_splat_poison_elt_combined
  simp_alive_peephole
  sorry
def narrow_bswap_overshift_combined := [llvmfunc|
  llvm.func @narrow_bswap_overshift(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.bswap(%arg0)  : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_narrow_bswap_overshift   : narrow_bswap_overshift_before  ⊑  narrow_bswap_overshift_combined := by
  unfold narrow_bswap_overshift_before narrow_bswap_overshift_combined
  simp_alive_peephole
  sorry
def narrow_bswap_overshift2_combined := [llvmfunc|
  llvm.func @narrow_bswap_overshift2(%arg0: i96) -> i128 {
    %0 = llvm.mlir.constant(29 : i96) : i96
    %1 = llvm.intr.bswap(%arg0)  : (i96) -> i96
    %2 = llvm.lshr %1, %0  : i96
    %3 = llvm.zext %2 : i96 to i128
    llvm.return %3 : i128
  }]

theorem inst_combine_narrow_bswap_overshift2   : narrow_bswap_overshift2_before  ⊑  narrow_bswap_overshift2_combined := by
  unfold narrow_bswap_overshift2_before narrow_bswap_overshift2_combined
  simp_alive_peephole
  sorry
def not_narrow_bswap_combined := [llvmfunc|
  llvm.func @not_narrow_bswap(%arg0: i24) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.zext %arg0 : i24 to i32
    %2 = llvm.intr.bswap(%1)  : (i32) -> i32
    %3 = llvm.lshr %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_narrow_bswap   : not_narrow_bswap_before  ⊑  not_narrow_bswap_combined := by
  unfold not_narrow_bswap_before not_narrow_bswap_combined
  simp_alive_peephole
  sorry
def not_signbit_combined := [llvmfunc|
  llvm.func @not_signbit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_not_signbit   : not_signbit_before  ⊑  not_signbit_combined := by
  unfold not_signbit_before not_signbit_combined
  simp_alive_peephole
  sorry
def not_signbit_vec_combined := [llvmfunc|
  llvm.func @not_signbit_vec(%arg0: vector<2xi6>) -> vector<2xi6> {
    %0 = llvm.mlir.constant(-1 : i6) : i6
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi6>) : vector<2xi6>
    %2 = llvm.icmp "sgt" %arg0, %1 : vector<2xi6>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi6>
    llvm.return %3 : vector<2xi6>
  }]

theorem inst_combine_not_signbit_vec   : not_signbit_vec_before  ⊑  not_signbit_vec_combined := by
  unfold not_signbit_vec_before not_signbit_vec_combined
  simp_alive_peephole
  sorry
def not_signbit_alt_xor_combined := [llvmfunc|
  llvm.func @not_signbit_alt_xor(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_not_signbit_alt_xor   : not_signbit_alt_xor_before  ⊑  not_signbit_alt_xor_combined := by
  unfold not_signbit_alt_xor_before not_signbit_alt_xor_combined
  simp_alive_peephole
  sorry
def not_not_signbit_combined := [llvmfunc|
  llvm.func @not_not_signbit(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_not_signbit   : not_not_signbit_before  ⊑  not_not_signbit_combined := by
  unfold not_not_signbit_before not_not_signbit_combined
  simp_alive_peephole
  sorry
def not_signbit_use_combined := [llvmfunc|
  llvm.func @not_signbit_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.lshr %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_not_signbit_use   : not_signbit_use_before  ⊑  not_signbit_use_combined := by
  unfold not_signbit_use_before not_signbit_use_combined
  simp_alive_peephole
  sorry
def not_signbit_zext_combined := [llvmfunc|
  llvm.func @not_signbit_zext(%arg0: i16) -> i32 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.icmp "sgt" %arg0, %0 : i16
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_not_signbit_zext   : not_signbit_zext_before  ⊑  not_signbit_zext_combined := by
  unfold not_signbit_zext_before not_signbit_zext_combined
  simp_alive_peephole
  sorry
def not_signbit_trunc_combined := [llvmfunc|
  llvm.func @not_signbit_trunc(%arg0: i16) -> i8 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.icmp "sgt" %arg0, %0 : i16
    %2 = llvm.zext %1 : i1 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_not_signbit_trunc   : not_signbit_trunc_before  ⊑  not_signbit_trunc_combined := by
  unfold not_signbit_trunc_before not_signbit_trunc_combined
  simp_alive_peephole
  sorry
def bool_add_lshr_combined := [llvmfunc|
  llvm.func @bool_add_lshr(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.and %arg0, %arg1  : i1
    %1 = llvm.zext %0 : i1 to i2
    llvm.return %1 : i2
  }]

theorem inst_combine_bool_add_lshr   : bool_add_lshr_before  ⊑  bool_add_lshr_combined := by
  unfold bool_add_lshr_before bool_add_lshr_combined
  simp_alive_peephole
  sorry
def not_bool_add_lshr_combined := [llvmfunc|
  llvm.func @not_bool_add_lshr(%arg0: i2, %arg1: i2) -> i4 {
    %0 = llvm.mlir.constant(-1 : i2) : i2
    %1 = llvm.xor %arg0, %0  : i2
    %2 = llvm.icmp "ult" %1, %arg1 : i2
    %3 = llvm.zext %2 : i1 to i4
    llvm.return %3 : i4
  }]

theorem inst_combine_not_bool_add_lshr   : not_bool_add_lshr_before  ⊑  not_bool_add_lshr_combined := by
  unfold not_bool_add_lshr_before not_bool_add_lshr_combined
  simp_alive_peephole
  sorry
def bool_add_ashr_combined := [llvmfunc|
  llvm.func @bool_add_ashr(%arg0: i1, %arg1: i1) -> i2 {
    %0 = llvm.mlir.constant(1 : i2) : i2
    %1 = llvm.zext %arg0 : i1 to i2
    %2 = llvm.zext %arg1 : i1 to i2
    %3 = llvm.add %1, %2 overflow<nuw>  : i2
    %4 = llvm.ashr %3, %0  : i2
    llvm.return %4 : i2
  }]

theorem inst_combine_bool_add_ashr   : bool_add_ashr_before  ⊑  bool_add_ashr_combined := by
  unfold bool_add_ashr_before bool_add_ashr_combined
  simp_alive_peephole
  sorry
def bool_add_lshr_vec_combined := [llvmfunc|
  llvm.func @bool_add_lshr_vec(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.and %arg0, %arg1  : vector<2xi1>
    %1 = llvm.zext %0 : vector<2xi1> to vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_bool_add_lshr_vec   : bool_add_lshr_vec_before  ⊑  bool_add_lshr_vec_combined := by
  unfold bool_add_lshr_vec_before bool_add_lshr_vec_combined
  simp_alive_peephole
  sorry
def bool_add_lshr_uses_combined := [llvmfunc|
  llvm.func @bool_add_lshr_uses(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_bool_add_lshr_uses   : bool_add_lshr_uses_before  ⊑  bool_add_lshr_uses_combined := by
  unfold bool_add_lshr_uses_before bool_add_lshr_uses_combined
  simp_alive_peephole
  sorry
def bool_add_lshr_uses2_combined := [llvmfunc|
  llvm.func @bool_add_lshr_uses2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.and %arg0, %arg1  : i1
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_bool_add_lshr_uses2   : bool_add_lshr_uses2_before  ⊑  bool_add_lshr_uses2_combined := by
  unfold bool_add_lshr_uses2_before bool_add_lshr_uses2_combined
  simp_alive_peephole
  sorry
def bool_add_lshr_uses3_combined := [llvmfunc|
  llvm.func @bool_add_lshr_uses3(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.zext %arg1 : i1 to i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : i32
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.lshr %3, %0  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_bool_add_lshr_uses3   : bool_add_lshr_uses3_before  ⊑  bool_add_lshr_uses3_combined := by
  unfold bool_add_lshr_uses3_before bool_add_lshr_uses3_combined
  simp_alive_peephole
  sorry
def bool_add_lshr_vec_wrong_shift_amt_combined := [llvmfunc|
  llvm.func @bool_add_lshr_vec_wrong_shift_amt(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %2 = llvm.zext %arg1 : vector<2xi1> to vector<2xi8>
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : vector<2xi8>
    %4 = llvm.lshr %3, %0  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

theorem inst_combine_bool_add_lshr_vec_wrong_shift_amt   : bool_add_lshr_vec_wrong_shift_amt_before  ⊑  bool_add_lshr_vec_wrong_shift_amt_combined := by
  unfold bool_add_lshr_vec_wrong_shift_amt_before bool_add_lshr_vec_wrong_shift_amt_combined
  simp_alive_peephole
  sorry
