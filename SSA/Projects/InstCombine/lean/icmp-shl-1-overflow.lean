import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-shl-1-overflow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_shl_ugt_1_before := [llvmfunc|
  llvm.func @icmp_shl_ugt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.icmp "ugt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def icmp_shl_ugt_2_before := [llvmfunc|
  llvm.func @icmp_shl_ugt_2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %0, %arg0  : vector<2xi32>
    %3 = llvm.shl %2, %1  : vector<2xi32>
    %4 = llvm.icmp "ugt" %2, %3 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def icmp_shl_uge_1_before := [llvmfunc|
  llvm.func @icmp_shl_uge_1(%arg0: vector<3xi7>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i7) : i7
    %1 = llvm.mlir.constant(dense<1> : vector<3xi7>) : vector<3xi7>
    %2 = llvm.shl %arg0, %1  : vector<3xi7>
    %3 = llvm.icmp "uge" %2, %arg0 : vector<3xi7>
    llvm.return %3 : vector<3xi1>
  }]

def icmp_shl_uge_2_before := [llvmfunc|
  llvm.func @icmp_shl_uge_2(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(10 : i5) : i5
    %1 = llvm.mlir.constant(1 : i5) : i5
    %2 = llvm.add %0, %arg0  : i5
    %3 = llvm.shl %2, %1  : i5
    %4 = llvm.icmp "uge" %2, %3 : i5
    llvm.return %4 : i1
  }]

def icmp_shl_ult_1_before := [llvmfunc|
  llvm.func @icmp_shl_ult_1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    llvm.call @use16(%1) : (i16) -> ()
    %2 = llvm.icmp "ult" %1, %arg0 : i16
    llvm.return %2 : i1
  }]

def icmp_shl_ult_2_before := [llvmfunc|
  llvm.func @icmp_shl_ult_2(%arg0: vector<4xi4>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.mlir.constant(dense<-6> : vector<4xi4>) : vector<4xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<4xi4>) : vector<4xi4>
    %4 = llvm.add %1, %arg0  : vector<4xi4>
    %5 = llvm.shl %4, %3  : vector<4xi4>
    llvm.call @usev4(%5) : (vector<4xi4>) -> ()
    %6 = llvm.icmp "ult" %4, %5 : vector<4xi4>
    llvm.return %6 : vector<4xi1>
  }]

def icmp_shl_ule_1_before := [llvmfunc|
  llvm.func @icmp_shl_ule_1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.shl %arg0, %6  : vector<2xi8>
    %8 = llvm.icmp "ule" %7, %arg0 : vector<2xi8>
    llvm.return %8 : vector<2xi1>
  }]

def icmp_shl_ule_2_before := [llvmfunc|
  llvm.func @icmp_shl_ule_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.add %0, %arg0  : i8
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.icmp "ule" %2, %3 : i8
    llvm.return %4 : i1
  }]

def icmp_shl_eq_1_before := [llvmfunc|
  llvm.func @icmp_shl_eq_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def icmp_shl_eq_2_before := [llvmfunc|
  llvm.func @icmp_shl_eq_2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %3 = llvm.shl %2, %1  : vector<2xi8>
    %4 = llvm.icmp "eq" %2, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def icmp_shl_ne_1_before := [llvmfunc|
  llvm.func @icmp_shl_ne_1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ne" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def icmp_shl_ne_2_before := [llvmfunc|
  llvm.func @icmp_shl_ne_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sdiv %0, %arg0  : i8
    %3 = llvm.shl %2, %1  : i8
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

def negative_test_signed_pred_before := [llvmfunc|
  llvm.func @negative_test_signed_pred(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.icmp "slt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def negative_test_shl_more_than_1_before := [llvmfunc|
  llvm.func @negative_test_shl_more_than_1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg0 : i16
    llvm.return %2 : i1
  }]

def negative_test_compare_with_different_value_before := [llvmfunc|
  llvm.func @negative_test_compare_with_different_value(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg1 : i16
    llvm.return %2 : i1
  }]

def icmp_shl_ugt_1_combined := [llvmfunc|
  llvm.func @icmp_shl_ugt_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_shl_ugt_1   : icmp_shl_ugt_1_before  ⊑  icmp_shl_ugt_1_combined := by
  unfold icmp_shl_ugt_1_before icmp_shl_ugt_1_combined
  simp_alive_peephole
  sorry
def icmp_shl_ugt_2_combined := [llvmfunc|
  llvm.func @icmp_shl_ugt_2(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.add %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_icmp_shl_ugt_2   : icmp_shl_ugt_2_before  ⊑  icmp_shl_ugt_2_combined := by
  unfold icmp_shl_ugt_2_before icmp_shl_ugt_2_combined
  simp_alive_peephole
  sorry
def icmp_shl_uge_1_combined := [llvmfunc|
  llvm.func @icmp_shl_uge_1(%arg0: vector<3xi7>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i7) : i7
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi7>) : vector<3xi7>
    %2 = llvm.icmp "sgt" %arg0, %1 : vector<3xi7>
    llvm.return %2 : vector<3xi1>
  }]

theorem inst_combine_icmp_shl_uge_1   : icmp_shl_uge_1_before  ⊑  icmp_shl_uge_1_combined := by
  unfold icmp_shl_uge_1_before icmp_shl_uge_1_combined
  simp_alive_peephole
  sorry
def icmp_shl_uge_2_combined := [llvmfunc|
  llvm.func @icmp_shl_uge_2(%arg0: i5) -> i1 {
    %0 = llvm.mlir.constant(10 : i5) : i5
    %1 = llvm.mlir.constant(1 : i5) : i5
    %2 = llvm.add %arg0, %0  : i5
    %3 = llvm.icmp "slt" %2, %1 : i5
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_shl_uge_2   : icmp_shl_uge_2_before  ⊑  icmp_shl_uge_2_combined := by
  unfold icmp_shl_uge_2_before icmp_shl_uge_2_combined
  simp_alive_peephole
  sorry
def icmp_shl_ult_1_combined := [llvmfunc|
  llvm.func @icmp_shl_ult_1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.shl %arg0, %0  : i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.icmp "slt" %arg0, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_shl_ult_1   : icmp_shl_ult_1_before  ⊑  icmp_shl_ult_1_combined := by
  unfold icmp_shl_ult_1_before icmp_shl_ult_1_combined
  simp_alive_peephole
  sorry
def icmp_shl_ult_2_combined := [llvmfunc|
  llvm.func @icmp_shl_ult_2(%arg0: vector<4xi4>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.mlir.constant(dense<-6> : vector<4xi4>) : vector<4xi4>
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<1> : vector<4xi4>) : vector<4xi4>
    %4 = llvm.mlir.constant(0 : i4) : i4
    %5 = llvm.mlir.constant(dense<0> : vector<4xi4>) : vector<4xi4>
    %6 = llvm.add %arg0, %1  : vector<4xi4>
    %7 = llvm.shl %6, %3  : vector<4xi4>
    llvm.call @usev4(%7) : (vector<4xi4>) -> ()
    %8 = llvm.icmp "sgt" %6, %5 : vector<4xi4>
    llvm.return %8 : vector<4xi1>
  }]

theorem inst_combine_icmp_shl_ult_2   : icmp_shl_ult_2_before  ⊑  icmp_shl_ult_2_combined := by
  unfold icmp_shl_ult_2_before icmp_shl_ult_2_combined
  simp_alive_peephole
  sorry
def icmp_shl_ule_1_combined := [llvmfunc|
  llvm.func @icmp_shl_ule_1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_shl_ule_1   : icmp_shl_ule_1_before  ⊑  icmp_shl_ule_1_combined := by
  unfold icmp_shl_ule_1_before icmp_shl_ule_1_combined
  simp_alive_peephole
  sorry
def icmp_shl_ule_2_combined := [llvmfunc|
  llvm.func @icmp_shl_ule_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_shl_ule_2   : icmp_shl_ule_2_before  ⊑  icmp_shl_ule_2_combined := by
  unfold icmp_shl_ule_2_before icmp_shl_ule_2_combined
  simp_alive_peephole
  sorry
def icmp_shl_eq_1_combined := [llvmfunc|
  llvm.func @icmp_shl_eq_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_shl_eq_1   : icmp_shl_eq_1_before  ⊑  icmp_shl_eq_1_combined := by
  unfold icmp_shl_eq_1_before icmp_shl_eq_1_combined
  simp_alive_peephole
  sorry
def icmp_shl_eq_2_combined := [llvmfunc|
  llvm.func @icmp_shl_eq_2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.sdiv %0, %arg0  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_icmp_shl_eq_2   : icmp_shl_eq_2_before  ⊑  icmp_shl_eq_2_combined := by
  unfold icmp_shl_eq_2_before icmp_shl_eq_2_combined
  simp_alive_peephole
  sorry
def icmp_shl_ne_1_combined := [llvmfunc|
  llvm.func @icmp_shl_ne_1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_icmp_shl_ne_1   : icmp_shl_ne_1_before  ⊑  icmp_shl_ne_1_combined := by
  unfold icmp_shl_ne_1_before icmp_shl_ne_1_combined
  simp_alive_peephole
  sorry
def icmp_shl_ne_2_combined := [llvmfunc|
  llvm.func @icmp_shl_ne_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sdiv %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_shl_ne_2   : icmp_shl_ne_2_before  ⊑  icmp_shl_ne_2_combined := by
  unfold icmp_shl_ne_2_before icmp_shl_ne_2_combined
  simp_alive_peephole
  sorry
def negative_test_signed_pred_combined := [llvmfunc|
  llvm.func @negative_test_signed_pred(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.icmp "slt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_negative_test_signed_pred   : negative_test_signed_pred_before  ⊑  negative_test_signed_pred_combined := by
  unfold negative_test_signed_pred_before negative_test_signed_pred_combined
  simp_alive_peephole
  sorry
def negative_test_shl_more_than_1_combined := [llvmfunc|
  llvm.func @negative_test_shl_more_than_1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_negative_test_shl_more_than_1   : negative_test_shl_more_than_1_before  ⊑  negative_test_shl_more_than_1_combined := by
  unfold negative_test_shl_more_than_1_before negative_test_shl_more_than_1_combined
  simp_alive_peephole
  sorry
def negative_test_compare_with_different_value_combined := [llvmfunc|
  llvm.func @negative_test_compare_with_different_value(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.shl %arg0, %0  : i16
    %2 = llvm.icmp "ult" %1, %arg1 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_negative_test_compare_with_different_value   : negative_test_compare_with_different_value_before  ⊑  negative_test_compare_with_different_value_combined := by
  unfold negative_test_compare_with_different_value_before negative_test_compare_with_different_value_combined
  simp_alive_peephole
  sorry
