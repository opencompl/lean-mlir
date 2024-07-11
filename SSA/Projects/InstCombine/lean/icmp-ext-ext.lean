import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-ext-ext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def zext_zext_sgt_before := [llvmfunc|
  llvm.func @zext_zext_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_zext_ugt_before := [llvmfunc|
  llvm.func @zext_zext_ugt(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ugt" %0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def zext_zext_eq_before := [llvmfunc|
  llvm.func @zext_zext_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_zext_sle_op0_narrow_before := [llvmfunc|
  llvm.func @zext_zext_sle_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i16 to i32
    %2 = llvm.icmp "sle" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_zext_ule_op0_wide_before := [llvmfunc|
  llvm.func @zext_zext_ule_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "ule" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_sext_slt_before := [llvmfunc|
  llvm.func @sext_sext_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_sext_ult_before := [llvmfunc|
  llvm.func @sext_sext_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ult" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_sext_ne_before := [llvmfunc|
  llvm.func @sext_sext_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ne" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_sext_sge_op0_narrow_before := [llvmfunc|
  llvm.func @sext_sext_sge_op0_narrow(%arg0: i5, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i5 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_sext_uge_op0_wide_before := [llvmfunc|
  llvm.func @sext_sext_uge_op0_wide(%arg0: vector<2xi16>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "uge" %0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def zext_sext_sgt_before := [llvmfunc|
  llvm.func @zext_sext_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_nneg_sext_sgt_before := [llvmfunc|
  llvm.func @zext_nneg_sext_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_sext_ugt_before := [llvmfunc|
  llvm.func @zext_sext_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_nneg_sext_ugt_before := [llvmfunc|
  llvm.func @zext_nneg_sext_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_sext_eq_before := [llvmfunc|
  llvm.func @zext_sext_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_nneg_sext_eq_before := [llvmfunc|
  llvm.func @zext_nneg_sext_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_sext_sle_op0_narrow_before := [llvmfunc|
  llvm.func @zext_sext_sle_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i16 to i32
    %2 = llvm.icmp "sle" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_nneg_sext_sle_op0_narrow_before := [llvmfunc|
  llvm.func @zext_nneg_sext_sle_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i16 to i32
    %2 = llvm.icmp "sle" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_sext_ule_op0_wide_before := [llvmfunc|
  llvm.func @zext_sext_ule_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ule" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_nneg_sext_ule_op0_wide_before := [llvmfunc|
  llvm.func @zext_nneg_sext_ule_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ule" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_zext_slt_before := [llvmfunc|
  llvm.func @sext_zext_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_zext_nneg_slt_before := [llvmfunc|
  llvm.func @sext_zext_nneg_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_zext_ult_before := [llvmfunc|
  llvm.func @sext_zext_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "ult" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_zext_nneg_ult_before := [llvmfunc|
  llvm.func @sext_zext_nneg_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "ult" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_zext_ne_before := [llvmfunc|
  llvm.func @sext_zext_ne(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ne" %0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def sext_zext_nneg_ne_before := [llvmfunc|
  llvm.func @sext_zext_nneg_ne(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ne" %0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def sext_zext_sge_op0_narrow_before := [llvmfunc|
  llvm.func @sext_zext_sge_op0_narrow(%arg0: i5, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i5 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_zext_nneg_sge_op0_narrow_before := [llvmfunc|
  llvm.func @sext_zext_nneg_sge_op0_narrow(%arg0: i5, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i5 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_zext_uge_op0_wide_before := [llvmfunc|
  llvm.func @sext_zext_uge_op0_wide(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "uge" %0, %1 : i32
    llvm.return %2 : i1
  }]

def sext_zext_nneg_uge_op0_wide_before := [llvmfunc|
  llvm.func @sext_zext_nneg_uge_op0_wide(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "uge" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_sext_sgt_known_nonneg_before := [llvmfunc|
  llvm.func @zext_sext_sgt_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.icmp "sgt" %2, %3 : i32
    llvm.return %4 : i1
  }]

def zext_sext_ugt_known_nonneg_before := [llvmfunc|
  llvm.func @zext_sext_ugt_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.icmp "ugt" %2, %3 : i32
    llvm.return %4 : i1
  }]

def zext_sext_eq_known_nonneg_before := [llvmfunc|
  llvm.func @zext_sext_eq_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }]

def zext_sext_sle_known_nonneg_op0_narrow_before := [llvmfunc|
  llvm.func @zext_sext_sle_known_nonneg_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.icmp "sle" %2, %3 : i32
    llvm.return %4 : i1
  }]

def zext_sext_ule_known_nonneg_op0_wide_before := [llvmfunc|
  llvm.func @zext_sext_ule_known_nonneg_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(254 : i9) : i9
    %1 = llvm.urem %arg0, %0  : i9
    %2 = llvm.zext %1 : i9 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.icmp "ule" %2, %3 : i32
    llvm.return %4 : i1
  }]

def sext_zext_slt_known_nonneg_before := [llvmfunc|
  llvm.func @sext_zext_slt_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sext_zext_ult_known_nonneg_before := [llvmfunc|
  llvm.func @sext_zext_ult_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.icmp "ult" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sext_zext_ne_known_nonneg_before := [llvmfunc|
  llvm.func @sext_zext_ne_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.udiv %arg1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }]

def sext_zext_sge_known_nonneg_op0_narrow_before := [llvmfunc|
  llvm.func @sext_zext_sge_known_nonneg_op0_narrow(%arg0: vector<2xi5>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi5> to vector<2xi32>
    %1 = llvm.mul %arg1, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi8> to vector<2xi32>
    %3 = llvm.icmp "sge" %0, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def sext_zext_uge_known_nonneg_op0_wide_before := [llvmfunc|
  llvm.func @sext_zext_uge_known_nonneg_op0_wide(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.icmp "uge" %1, %3 : i32
    llvm.return %4 : i1
  }]

def zext_eq_sext_before := [llvmfunc|
  llvm.func @zext_eq_sext(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sext %arg1 : i1 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_eq_sext_fail_not_i1_before := [llvmfunc|
  llvm.func @zext_eq_sext_fail_not_i1(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

def zext_ne_sext_before := [llvmfunc|
  llvm.func @zext_ne_sext(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi8>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def zext_zext_sgt_combined := [llvmfunc|
  llvm.func @zext_zext_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_zext_zext_sgt   : zext_zext_sgt_before  ⊑  zext_zext_sgt_combined := by
  unfold zext_zext_sgt_before zext_zext_sgt_combined
  simp_alive_peephole
  sorry
def zext_zext_ugt_combined := [llvmfunc|
  llvm.func @zext_zext_ugt(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_zext_zext_ugt   : zext_zext_ugt_before  ⊑  zext_zext_ugt_combined := by
  unfold zext_zext_ugt_before zext_zext_ugt_combined
  simp_alive_peephole
  sorry
def zext_zext_eq_combined := [llvmfunc|
  llvm.func @zext_zext_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_zext_zext_eq   : zext_zext_eq_before  ⊑  zext_zext_eq_combined := by
  unfold zext_zext_eq_before zext_zext_eq_combined
  simp_alive_peephole
  sorry
def zext_zext_sle_op0_narrow_combined := [llvmfunc|
  llvm.func @zext_zext_sle_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i16
    %1 = llvm.icmp "ule" %0, %arg1 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_zext_zext_sle_op0_narrow   : zext_zext_sle_op0_narrow_before  ⊑  zext_zext_sle_op0_narrow_combined := by
  unfold zext_zext_sle_op0_narrow_before zext_zext_sle_op0_narrow_combined
  simp_alive_peephole
  sorry
def zext_zext_ule_op0_wide_combined := [llvmfunc|
  llvm.func @zext_zext_ule_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg1 : i8 to i9
    %1 = llvm.icmp "uge" %0, %arg0 : i9
    llvm.return %1 : i1
  }]

theorem inst_combine_zext_zext_ule_op0_wide   : zext_zext_ule_op0_wide_before  ⊑  zext_zext_ule_op0_wide_combined := by
  unfold zext_zext_ule_op0_wide_before zext_zext_ule_op0_wide_combined
  simp_alive_peephole
  sorry
def sext_sext_slt_combined := [llvmfunc|
  llvm.func @sext_sext_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sext_sext_slt   : sext_sext_slt_before  ⊑  sext_sext_slt_combined := by
  unfold sext_sext_slt_before sext_sext_slt_combined
  simp_alive_peephole
  sorry
def sext_sext_ult_combined := [llvmfunc|
  llvm.func @sext_sext_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sext_sext_ult   : sext_sext_ult_before  ⊑  sext_sext_ult_combined := by
  unfold sext_sext_ult_before sext_sext_ult_combined
  simp_alive_peephole
  sorry
def sext_sext_ne_combined := [llvmfunc|
  llvm.func @sext_sext_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sext_sext_ne   : sext_sext_ne_before  ⊑  sext_sext_ne_combined := by
  unfold sext_sext_ne_before sext_sext_ne_combined
  simp_alive_peephole
  sorry
def sext_sext_sge_op0_narrow_combined := [llvmfunc|
  llvm.func @sext_sext_sge_op0_narrow(%arg0: i5, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i5 to i8
    %1 = llvm.icmp "sge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sext_sext_sge_op0_narrow   : sext_sext_sge_op0_narrow_before  ⊑  sext_sext_sge_op0_narrow_combined := by
  unfold sext_sext_sge_op0_narrow_before sext_sext_sge_op0_narrow_combined
  simp_alive_peephole
  sorry
def sext_sext_uge_op0_wide_combined := [llvmfunc|
  llvm.func @sext_sext_uge_op0_wide(%arg0: vector<2xi16>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg1 : vector<2xi8> to vector<2xi16>
    %1 = llvm.icmp "ule" %0, %arg0 : vector<2xi16>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_sext_sext_uge_op0_wide   : sext_sext_uge_op0_wide_before  ⊑  sext_sext_uge_op0_wide_combined := by
  unfold sext_sext_uge_op0_wide_before sext_sext_uge_op0_wide_combined
  simp_alive_peephole
  sorry
def zext_sext_sgt_combined := [llvmfunc|
  llvm.func @zext_sext_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_sext_sgt   : zext_sext_sgt_before  ⊑  zext_sext_sgt_combined := by
  unfold zext_sext_sgt_before zext_sext_sgt_combined
  simp_alive_peephole
  sorry
def zext_nneg_sext_sgt_combined := [llvmfunc|
  llvm.func @zext_nneg_sext_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_zext_nneg_sext_sgt   : zext_nneg_sext_sgt_before  ⊑  zext_nneg_sext_sgt_combined := by
  unfold zext_nneg_sext_sgt_before zext_nneg_sext_sgt_combined
  simp_alive_peephole
  sorry
def zext_sext_ugt_combined := [llvmfunc|
  llvm.func @zext_sext_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_sext_ugt   : zext_sext_ugt_before  ⊑  zext_sext_ugt_combined := by
  unfold zext_sext_ugt_before zext_sext_ugt_combined
  simp_alive_peephole
  sorry
def zext_nneg_sext_ugt_combined := [llvmfunc|
  llvm.func @zext_nneg_sext_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_zext_nneg_sext_ugt   : zext_nneg_sext_ugt_before  ⊑  zext_nneg_sext_ugt_combined := by
  unfold zext_nneg_sext_ugt_before zext_nneg_sext_ugt_combined
  simp_alive_peephole
  sorry
def zext_sext_eq_combined := [llvmfunc|
  llvm.func @zext_sext_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_sext_eq   : zext_sext_eq_before  ⊑  zext_sext_eq_combined := by
  unfold zext_sext_eq_before zext_sext_eq_combined
  simp_alive_peephole
  sorry
def zext_nneg_sext_eq_combined := [llvmfunc|
  llvm.func @zext_nneg_sext_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_zext_nneg_sext_eq   : zext_nneg_sext_eq_before  ⊑  zext_nneg_sext_eq_combined := by
  unfold zext_nneg_sext_eq_before zext_nneg_sext_eq_combined
  simp_alive_peephole
  sorry
def zext_sext_sle_op0_narrow_combined := [llvmfunc|
  llvm.func @zext_sext_sle_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i16 to i32
    %2 = llvm.icmp "sle" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_sext_sle_op0_narrow   : zext_sext_sle_op0_narrow_before  ⊑  zext_sext_sle_op0_narrow_combined := by
  unfold zext_sext_sle_op0_narrow_before zext_sext_sle_op0_narrow_combined
  simp_alive_peephole
  sorry
def zext_nneg_sext_sle_op0_narrow_combined := [llvmfunc|
  llvm.func @zext_nneg_sext_sle_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i16
    %1 = llvm.icmp "sle" %0, %arg1 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_zext_nneg_sext_sle_op0_narrow   : zext_nneg_sext_sle_op0_narrow_before  ⊑  zext_nneg_sext_sle_op0_narrow_combined := by
  unfold zext_nneg_sext_sle_op0_narrow_before zext_nneg_sext_sle_op0_narrow_combined
  simp_alive_peephole
  sorry
def zext_sext_ule_op0_wide_combined := [llvmfunc|
  llvm.func @zext_sext_ule_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ule" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_sext_ule_op0_wide   : zext_sext_ule_op0_wide_before  ⊑  zext_sext_ule_op0_wide_combined := by
  unfold zext_sext_ule_op0_wide_before zext_sext_ule_op0_wide_combined
  simp_alive_peephole
  sorry
def zext_nneg_sext_ule_op0_wide_combined := [llvmfunc|
  llvm.func @zext_nneg_sext_ule_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg1 : i8 to i9
    %1 = llvm.icmp "uge" %0, %arg0 : i9
    llvm.return %1 : i1
  }]

theorem inst_combine_zext_nneg_sext_ule_op0_wide   : zext_nneg_sext_ule_op0_wide_before  ⊑  zext_nneg_sext_ule_op0_wide_combined := by
  unfold zext_nneg_sext_ule_op0_wide_before zext_nneg_sext_ule_op0_wide_combined
  simp_alive_peephole
  sorry
def sext_zext_slt_combined := [llvmfunc|
  llvm.func @sext_zext_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sext_zext_slt   : sext_zext_slt_before  ⊑  sext_zext_slt_combined := by
  unfold sext_zext_slt_before sext_zext_slt_combined
  simp_alive_peephole
  sorry
def sext_zext_nneg_slt_combined := [llvmfunc|
  llvm.func @sext_zext_nneg_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sext_zext_nneg_slt   : sext_zext_nneg_slt_before  ⊑  sext_zext_nneg_slt_combined := by
  unfold sext_zext_nneg_slt_before sext_zext_nneg_slt_combined
  simp_alive_peephole
  sorry
def sext_zext_ult_combined := [llvmfunc|
  llvm.func @sext_zext_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "ult" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sext_zext_ult   : sext_zext_ult_before  ⊑  sext_zext_ult_combined := by
  unfold sext_zext_ult_before sext_zext_ult_combined
  simp_alive_peephole
  sorry
def sext_zext_nneg_ult_combined := [llvmfunc|
  llvm.func @sext_zext_nneg_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sext_zext_nneg_ult   : sext_zext_nneg_ult_before  ⊑  sext_zext_nneg_ult_combined := by
  unfold sext_zext_nneg_ult_before sext_zext_nneg_ult_combined
  simp_alive_peephole
  sorry
def sext_zext_ne_combined := [llvmfunc|
  llvm.func @sext_zext_ne(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ne" %0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_sext_zext_ne   : sext_zext_ne_before  ⊑  sext_zext_ne_combined := by
  unfold sext_zext_ne_before sext_zext_ne_combined
  simp_alive_peephole
  sorry
def sext_zext_nneg_ne_combined := [llvmfunc|
  llvm.func @sext_zext_nneg_ne(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.icmp "ne" %arg0, %arg1 : vector<2xi8>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_sext_zext_nneg_ne   : sext_zext_nneg_ne_before  ⊑  sext_zext_nneg_ne_combined := by
  unfold sext_zext_nneg_ne_before sext_zext_nneg_ne_combined
  simp_alive_peephole
  sorry
def sext_zext_sge_op0_narrow_combined := [llvmfunc|
  llvm.func @sext_zext_sge_op0_narrow(%arg0: i5, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i5 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sext_zext_sge_op0_narrow   : sext_zext_sge_op0_narrow_before  ⊑  sext_zext_sge_op0_narrow_combined := by
  unfold sext_zext_sge_op0_narrow_before sext_zext_sge_op0_narrow_combined
  simp_alive_peephole
  sorry
def sext_zext_nneg_sge_op0_narrow_combined := [llvmfunc|
  llvm.func @sext_zext_nneg_sge_op0_narrow(%arg0: i5, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i5 to i8
    %1 = llvm.icmp "sge" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sext_zext_nneg_sge_op0_narrow   : sext_zext_nneg_sge_op0_narrow_before  ⊑  sext_zext_nneg_sge_op0_narrow_combined := by
  unfold sext_zext_nneg_sge_op0_narrow_before sext_zext_nneg_sge_op0_narrow_combined
  simp_alive_peephole
  sorry
def sext_zext_uge_op0_wide_combined := [llvmfunc|
  llvm.func @sext_zext_uge_op0_wide(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "uge" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_sext_zext_uge_op0_wide   : sext_zext_uge_op0_wide_before  ⊑  sext_zext_uge_op0_wide_combined := by
  unfold sext_zext_uge_op0_wide_before sext_zext_uge_op0_wide_combined
  simp_alive_peephole
  sorry
def sext_zext_nneg_uge_op0_wide_combined := [llvmfunc|
  llvm.func @sext_zext_nneg_uge_op0_wide(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg1 : i8 to i16
    %1 = llvm.icmp "ule" %0, %arg0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_sext_zext_nneg_uge_op0_wide   : sext_zext_nneg_uge_op0_wide_before  ⊑  sext_zext_nneg_uge_op0_wide_combined := by
  unfold sext_zext_nneg_uge_op0_wide_before sext_zext_nneg_uge_op0_wide_combined
  simp_alive_peephole
  sorry
def zext_sext_sgt_known_nonneg_combined := [llvmfunc|
  llvm.func @zext_sext_sgt_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "sgt" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_sext_sgt_known_nonneg   : zext_sext_sgt_known_nonneg_before  ⊑  zext_sext_sgt_known_nonneg_combined := by
  unfold zext_sext_sgt_known_nonneg_before zext_sext_sgt_known_nonneg_combined
  simp_alive_peephole
  sorry
def zext_sext_ugt_known_nonneg_combined := [llvmfunc|
  llvm.func @zext_sext_ugt_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "ugt" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_sext_ugt_known_nonneg   : zext_sext_ugt_known_nonneg_before  ⊑  zext_sext_ugt_known_nonneg_combined := by
  unfold zext_sext_ugt_known_nonneg_before zext_sext_ugt_known_nonneg_combined
  simp_alive_peephole
  sorry
def zext_sext_eq_known_nonneg_combined := [llvmfunc|
  llvm.func @zext_sext_eq_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_sext_eq_known_nonneg   : zext_sext_eq_known_nonneg_before  ⊑  zext_sext_eq_known_nonneg_combined := by
  unfold zext_sext_eq_known_nonneg_before zext_sext_eq_known_nonneg_combined
  simp_alive_peephole
  sorry
def zext_sext_sle_known_nonneg_op0_narrow_combined := [llvmfunc|
  llvm.func @zext_sext_sle_known_nonneg_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i16
    %3 = llvm.icmp "sle" %2, %arg1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_zext_sext_sle_known_nonneg_op0_narrow   : zext_sext_sle_known_nonneg_op0_narrow_before  ⊑  zext_sext_sle_known_nonneg_op0_narrow_combined := by
  unfold zext_sext_sle_known_nonneg_op0_narrow_before zext_sext_sle_known_nonneg_op0_narrow_combined
  simp_alive_peephole
  sorry
def zext_sext_ule_known_nonneg_op0_wide_combined := [llvmfunc|
  llvm.func @zext_sext_ule_known_nonneg_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(254 : i9) : i9
    %1 = llvm.urem %arg0, %0  : i9
    %2 = llvm.sext %arg1 : i8 to i9
    %3 = llvm.icmp "ule" %1, %2 : i9
    llvm.return %3 : i1
  }]

theorem inst_combine_zext_sext_ule_known_nonneg_op0_wide   : zext_sext_ule_known_nonneg_op0_wide_before  ⊑  zext_sext_ule_known_nonneg_op0_wide_combined := by
  unfold zext_sext_ule_known_nonneg_op0_wide_before zext_sext_ule_known_nonneg_op0_wide_combined
  simp_alive_peephole
  sorry
def sext_zext_slt_known_nonneg_combined := [llvmfunc|
  llvm.func @sext_zext_slt_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.and %arg1, %0  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_sext_zext_slt_known_nonneg   : sext_zext_slt_known_nonneg_before  ⊑  sext_zext_slt_known_nonneg_combined := by
  unfold sext_zext_slt_known_nonneg_before sext_zext_slt_known_nonneg_combined
  simp_alive_peephole
  sorry
def sext_zext_ult_known_nonneg_combined := [llvmfunc|
  llvm.func @sext_zext_ult_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.lshr %arg1, %0  : i8
    %2 = llvm.icmp "ugt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_sext_zext_ult_known_nonneg   : sext_zext_ult_known_nonneg_before  ⊑  sext_zext_ult_known_nonneg_combined := by
  unfold sext_zext_ult_known_nonneg_before sext_zext_ult_known_nonneg_combined
  simp_alive_peephole
  sorry
def sext_zext_ne_known_nonneg_combined := [llvmfunc|
  llvm.func @sext_zext_ne_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.udiv %arg1, %0  : i8
    %2 = llvm.icmp "ne" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_sext_zext_ne_known_nonneg   : sext_zext_ne_known_nonneg_before  ⊑  sext_zext_ne_known_nonneg_combined := by
  unfold sext_zext_ne_known_nonneg_before sext_zext_ne_known_nonneg_combined
  simp_alive_peephole
  sorry
def sext_zext_sge_known_nonneg_op0_narrow_combined := [llvmfunc|
  llvm.func @sext_zext_sge_known_nonneg_op0_narrow(%arg0: vector<2xi5>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mul %arg1, %arg1 overflow<nsw>  : vector<2xi8>
    %1 = llvm.sext %arg0 : vector<2xi5> to vector<2xi8>
    %2 = llvm.icmp "sle" %0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_sext_zext_sge_known_nonneg_op0_narrow   : sext_zext_sge_known_nonneg_op0_narrow_before  ⊑  sext_zext_sge_known_nonneg_op0_narrow_combined := by
  unfold sext_zext_sge_known_nonneg_op0_narrow_before sext_zext_sge_known_nonneg_op0_narrow_combined
  simp_alive_peephole
  sorry
def sext_zext_uge_known_nonneg_op0_wide_combined := [llvmfunc|
  llvm.func @sext_zext_uge_known_nonneg_op0_wide(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.and %arg1, %0  : i8
    %2 = llvm.zext %1 : i8 to i16
    %3 = llvm.icmp "ule" %2, %arg0 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_sext_zext_uge_known_nonneg_op0_wide   : sext_zext_uge_known_nonneg_op0_wide_before  ⊑  sext_zext_uge_known_nonneg_op0_wide_combined := by
  unfold sext_zext_uge_known_nonneg_op0_wide_before sext_zext_uge_known_nonneg_op0_wide_combined
  simp_alive_peephole
  sorry
def zext_eq_sext_combined := [llvmfunc|
  llvm.func @zext_eq_sext(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_eq_sext   : zext_eq_sext_before  ⊑  zext_eq_sext_combined := by
  unfold zext_eq_sext_before zext_eq_sext_combined
  simp_alive_peephole
  sorry
def zext_eq_sext_fail_not_i1_combined := [llvmfunc|
  llvm.func @zext_eq_sext_fail_not_i1(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_zext_eq_sext_fail_not_i1   : zext_eq_sext_fail_not_i1_before  ⊑  zext_eq_sext_fail_not_i1_combined := by
  unfold zext_eq_sext_fail_not_i1_before zext_eq_sext_fail_not_i1_combined
  simp_alive_peephole
  sorry
def zext_ne_sext_combined := [llvmfunc|
  llvm.func @zext_ne_sext(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.or %arg1, %arg0  : vector<2xi1>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_zext_ne_sext   : zext_ne_sext_before  ⊑  zext_ne_sext_combined := by
  unfold zext_ne_sext_before zext_ne_sext_combined
  simp_alive_peephole
  sorry
