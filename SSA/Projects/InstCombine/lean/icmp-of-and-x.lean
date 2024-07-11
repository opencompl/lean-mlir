import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-of-and-x
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_ult_x_y_before := [llvmfunc|
  llvm.func @icmp_ult_x_y(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def icmp_ult_x_y_2_before := [llvmfunc|
  llvm.func @icmp_ult_x_y_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg0  : i8
    %1 = llvm.and %0, %arg1  : i8
    %2 = llvm.icmp "ugt" %0, %1 : i8
    llvm.return %2 : i1
  }]

def icmp_uge_x_y_before := [llvmfunc|
  llvm.func @icmp_uge_x_y(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.and %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "uge" %0, %arg0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

def icmp_uge_x_y_2_before := [llvmfunc|
  llvm.func @icmp_uge_x_y_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg0  : i8
    %1 = llvm.and %0, %arg1  : i8
    %2 = llvm.icmp "ule" %0, %1 : i8
    llvm.return %2 : i1
  }]

def icmp_sge_x_negy_before := [llvmfunc|
  llvm.func @icmp_sge_x_negy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_slt_x_negy_before := [llvmfunc|
  llvm.func @icmp_slt_x_negy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "slt" %2, %arg0 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @barrier() : () -> i1
    llvm.return %4 : i1
  }]

def icmp_slt_x_negy_fail_maybe_zero_before := [llvmfunc|
  llvm.func @icmp_slt_x_negy_fail_maybe_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "slt" %2, %arg0 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @barrier() : () -> i1
    llvm.return %4 : i1
  }]

def icmp_sle_x_negy_before := [llvmfunc|
  llvm.func @icmp_sle_x_negy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt_x_negy_before := [llvmfunc|
  llvm.func @icmp_sgt_x_negy(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_sgt_x_negy_fail_partial_before := [llvmfunc|
  llvm.func @icmp_sgt_x_negy_fail_partial(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-128, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_sle_x_posy_before := [llvmfunc|
  llvm.func @icmp_sle_x_posy(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sle" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_sle_x_posy_fail_partial_before := [llvmfunc|
  llvm.func @icmp_sle_x_posy_fail_partial(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[127, -65]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sle" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_sgt_x_posy_before := [llvmfunc|
  llvm.func @icmp_sgt_x_posy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sgt" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt_negx_y_before := [llvmfunc|
  llvm.func @icmp_sgt_negx_y(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg1  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_sle_negx_y_before := [llvmfunc|
  llvm.func @icmp_sle_negx_y(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_sle_negx_y_fail_maybe_zero_before := [llvmfunc|
  llvm.func @icmp_sle_negx_y_fail_maybe_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def icmp_eq_x_invertable_y_todo_before := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y_todo(%arg0: i8, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.and %arg0, %2  : i8
    %4 = llvm.icmp "eq" %arg0, %3 : i8
    llvm.return %4 : i1
  }]

def icmp_eq_x_invertable_y_before := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "eq" %arg0, %2 : i8
    llvm.return %3 : i1
  }]

def icmp_eq_x_invertable_y_fail_multiuse_before := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %arg0, %2 : i8
    llvm.return %3 : i1
  }]

def icmp_eq_x_invertable_y2_todo_before := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y2_todo(%arg0: i8, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.and %arg0, %2  : i8
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }]

def icmp_eq_x_invertable_y2_before := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }]

def icmp_eq_x_invertable_y_fail_immconstant_before := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y_fail_immconstant(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def icmp_ult_x_y_combined := [llvmfunc|
  llvm.func @icmp_ult_x_y(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.icmp "ne" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ult_x_y   : icmp_ult_x_y_before  ⊑  icmp_ult_x_y_combined := by
  unfold icmp_ult_x_y_before icmp_ult_x_y_combined
  simp_alive_peephole
  sorry
def icmp_ult_x_y_2_combined := [llvmfunc|
  llvm.func @icmp_ult_x_y_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg0  : i8
    %1 = llvm.and %0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_ult_x_y_2   : icmp_ult_x_y_2_before  ⊑  icmp_ult_x_y_2_combined := by
  unfold icmp_ult_x_y_2_before icmp_ult_x_y_2_combined
  simp_alive_peephole
  sorry
def icmp_uge_x_y_combined := [llvmfunc|
  llvm.func @icmp_uge_x_y(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.and %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "eq" %0, %arg0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_uge_x_y   : icmp_uge_x_y_before  ⊑  icmp_uge_x_y_combined := by
  unfold icmp_uge_x_y_before icmp_uge_x_y_combined
  simp_alive_peephole
  sorry
def icmp_uge_x_y_2_combined := [llvmfunc|
  llvm.func @icmp_uge_x_y_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg0  : i8
    %1 = llvm.and %0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_uge_x_y_2   : icmp_uge_x_y_2_before  ⊑  icmp_uge_x_y_2_combined := by
  unfold icmp_uge_x_y_2_before icmp_uge_x_y_2_combined
  simp_alive_peephole
  sorry
def icmp_sge_x_negy_combined := [llvmfunc|
  llvm.func @icmp_sge_x_negy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_sge_x_negy   : icmp_sge_x_negy_before  ⊑  icmp_sge_x_negy_combined := by
  unfold icmp_sge_x_negy_before icmp_sge_x_negy_combined
  simp_alive_peephole
  sorry
def icmp_slt_x_negy_combined := [llvmfunc|
  llvm.func @icmp_slt_x_negy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "slt" %2, %arg0 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @barrier() : () -> i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_slt_x_negy   : icmp_slt_x_negy_before  ⊑  icmp_slt_x_negy_combined := by
  unfold icmp_slt_x_negy_before icmp_slt_x_negy_combined
  simp_alive_peephole
  sorry
def icmp_slt_x_negy_fail_maybe_zero_combined := [llvmfunc|
  llvm.func @icmp_slt_x_negy_fail_maybe_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "slt" %2, %arg0 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @barrier() : () -> i1
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_slt_x_negy_fail_maybe_zero   : icmp_slt_x_negy_fail_maybe_zero_before  ⊑  icmp_slt_x_negy_fail_maybe_zero_combined := by
  unfold icmp_slt_x_negy_fail_maybe_zero_before icmp_slt_x_negy_fail_maybe_zero_combined
  simp_alive_peephole
  sorry
def icmp_sle_x_negy_combined := [llvmfunc|
  llvm.func @icmp_sle_x_negy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_sle_x_negy   : icmp_sle_x_negy_before  ⊑  icmp_sle_x_negy_combined := by
  unfold icmp_sle_x_negy_before icmp_sle_x_negy_combined
  simp_alive_peephole
  sorry
def icmp_sgt_x_negy_combined := [llvmfunc|
  llvm.func @icmp_sgt_x_negy(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_sgt_x_negy   : icmp_sgt_x_negy_before  ⊑  icmp_sgt_x_negy_combined := by
  unfold icmp_sgt_x_negy_before icmp_sgt_x_negy_combined
  simp_alive_peephole
  sorry
def icmp_sgt_x_negy_fail_partial_combined := [llvmfunc|
  llvm.func @icmp_sgt_x_negy_fail_partial(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-128, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_sgt_x_negy_fail_partial   : icmp_sgt_x_negy_fail_partial_before  ⊑  icmp_sgt_x_negy_fail_partial_combined := by
  unfold icmp_sgt_x_negy_fail_partial_before icmp_sgt_x_negy_fail_partial_combined
  simp_alive_peephole
  sorry
def icmp_sle_x_posy_combined := [llvmfunc|
  llvm.func @icmp_sle_x_posy(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sle" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_sle_x_posy   : icmp_sle_x_posy_before  ⊑  icmp_sle_x_posy_combined := by
  unfold icmp_sle_x_posy_before icmp_sle_x_posy_combined
  simp_alive_peephole
  sorry
def icmp_sle_x_posy_fail_partial_combined := [llvmfunc|
  llvm.func @icmp_sle_x_posy_fail_partial(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[127, -65]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sle" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_sle_x_posy_fail_partial   : icmp_sle_x_posy_fail_partial_before  ⊑  icmp_sle_x_posy_fail_partial_combined := by
  unfold icmp_sle_x_posy_fail_partial_before icmp_sle_x_posy_fail_partial_combined
  simp_alive_peephole
  sorry
def icmp_sgt_x_posy_combined := [llvmfunc|
  llvm.func @icmp_sgt_x_posy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sgt" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_sgt_x_posy   : icmp_sgt_x_posy_before  ⊑  icmp_sgt_x_posy_combined := by
  unfold icmp_sgt_x_posy_before icmp_sgt_x_posy_combined
  simp_alive_peephole
  sorry
def icmp_sgt_negx_y_combined := [llvmfunc|
  llvm.func @icmp_sgt_negx_y(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg1  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_sgt_negx_y   : icmp_sgt_negx_y_before  ⊑  icmp_sgt_negx_y_combined := by
  unfold icmp_sgt_negx_y_before icmp_sgt_negx_y_combined
  simp_alive_peephole
  sorry
def icmp_sle_negx_y_combined := [llvmfunc|
  llvm.func @icmp_sle_negx_y(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_sle_negx_y   : icmp_sle_negx_y_before  ⊑  icmp_sle_negx_y_combined := by
  unfold icmp_sle_negx_y_before icmp_sle_negx_y_combined
  simp_alive_peephole
  sorry
def icmp_sle_negx_y_fail_maybe_zero_combined := [llvmfunc|
  llvm.func @icmp_sle_negx_y_fail_maybe_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_sle_negx_y_fail_maybe_zero   : icmp_sle_negx_y_fail_maybe_zero_before  ⊑  icmp_sle_negx_y_fail_maybe_zero_combined := by
  unfold icmp_sle_negx_y_fail_maybe_zero_before icmp_sle_negx_y_fail_maybe_zero_combined
  simp_alive_peephole
  sorry
def icmp_eq_x_invertable_y_todo_combined := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y_todo(%arg0: i8, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_eq_x_invertable_y_todo   : icmp_eq_x_invertable_y_todo_before  ⊑  icmp_eq_x_invertable_y_todo_combined := by
  unfold icmp_eq_x_invertable_y_todo_before icmp_eq_x_invertable_y_todo_combined
  simp_alive_peephole
  sorry
def icmp_eq_x_invertable_y_combined := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_eq_x_invertable_y   : icmp_eq_x_invertable_y_before  ⊑  icmp_eq_x_invertable_y_combined := by
  unfold icmp_eq_x_invertable_y_before icmp_eq_x_invertable_y_combined
  simp_alive_peephole
  sorry
def icmp_eq_x_invertable_y_fail_multiuse_combined := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_eq_x_invertable_y_fail_multiuse   : icmp_eq_x_invertable_y_fail_multiuse_before  ⊑  icmp_eq_x_invertable_y_fail_multiuse_combined := by
  unfold icmp_eq_x_invertable_y_fail_multiuse_before icmp_eq_x_invertable_y_fail_multiuse_combined
  simp_alive_peephole
  sorry
def icmp_eq_x_invertable_y2_todo_combined := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y2_todo(%arg0: i8, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.and %2, %arg0  : i8
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_icmp_eq_x_invertable_y2_todo   : icmp_eq_x_invertable_y2_todo_before  ⊑  icmp_eq_x_invertable_y2_todo_combined := by
  unfold icmp_eq_x_invertable_y2_todo_before icmp_eq_x_invertable_y2_todo_combined
  simp_alive_peephole
  sorry
def icmp_eq_x_invertable_y2_combined := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_eq_x_invertable_y2   : icmp_eq_x_invertable_y2_before  ⊑  icmp_eq_x_invertable_y2_combined := by
  unfold icmp_eq_x_invertable_y2_before icmp_eq_x_invertable_y2_combined
  simp_alive_peephole
  sorry
def icmp_eq_x_invertable_y_fail_immconstant_combined := [llvmfunc|
  llvm.func @icmp_eq_x_invertable_y_fail_immconstant(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_icmp_eq_x_invertable_y_fail_immconstant   : icmp_eq_x_invertable_y_fail_immconstant_before  ⊑  icmp_eq_x_invertable_y_fail_immconstant_combined := by
  unfold icmp_eq_x_invertable_y_fail_immconstant_before icmp_eq_x_invertable_y_fail_immconstant_combined
  simp_alive_peephole
  sorry
