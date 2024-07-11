import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  minmax-of-xor-x
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def umax_xor_Cpow2_before := [llvmfunc|
  llvm.func @umax_xor_Cpow2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.intr.umax(%arg0, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def umin_xor_Cpow2_before := [llvmfunc|
  llvm.func @umin_xor_Cpow2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.umin(%arg0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smax_xor_Cpow2_pos_before := [llvmfunc|
  llvm.func @smax_xor_Cpow2_pos(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.smax(%arg0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def smin_xor_Cpow2_pos_before := [llvmfunc|
  llvm.func @smin_xor_Cpow2_pos(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.intr.smin(%arg0, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def smax_xor_Cpow2_neg_before := [llvmfunc|
  llvm.func @smax_xor_Cpow2_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.intr.smax(%arg0, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def smin_xor_Cpow2_neg_before := [llvmfunc|
  llvm.func @smin_xor_Cpow2_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.smin(%arg0, %1)  : (i8, i8) -> i8
    llvm.return %2 : i8
  }]

def umax_xor_pow2_before := [llvmfunc|
  llvm.func @umax_xor_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.xor %arg0, %2  : i8
    %4 = llvm.intr.umax(%arg0, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def umin_xor_pow2_before := [llvmfunc|
  llvm.func @umin_xor_pow2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg1  : vector<2xi8>
    %3 = llvm.and %arg1, %2  : vector<2xi8>
    %4 = llvm.xor %arg0, %3  : vector<2xi8>
    %5 = llvm.intr.umin(%arg0, %4)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def smax_xor_pow2_unk_before := [llvmfunc|
  llvm.func @smax_xor_pow2_unk(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.xor %arg0, %2  : i8
    %4 = llvm.intr.smax(%arg0, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

def smin_xor_pow2_unk_before := [llvmfunc|
  llvm.func @smin_xor_pow2_unk(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg1  : vector<2xi8>
    %3 = llvm.and %arg1, %2  : vector<2xi8>
    %4 = llvm.xor %arg0, %3  : vector<2xi8>
    %5 = llvm.intr.smin(%arg0, %4)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def smax_xor_pow2_neg_before := [llvmfunc|
  llvm.func @smax_xor_pow2_neg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.xor %arg0, %2  : i8
    %5 = llvm.intr.smax(%arg0, %4)  : (i8, i8) -> i8
    llvm.return %5 : i8
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %0 : i8
  }]

def smin_xor_pow2_pos_before := [llvmfunc|
  llvm.func @smin_xor_pow2_pos(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %arg1, %1  : i8
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.xor %arg0, %2  : i8
    %5 = llvm.intr.smin(%arg0, %4)  : (i8, i8) -> i8
    llvm.return %5 : i8
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %0 : i8
  }]

def umax_xor_Cpow2_combined := [llvmfunc|
  llvm.func @umax_xor_Cpow2(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_umax_xor_Cpow2   : umax_xor_Cpow2_before  ⊑  umax_xor_Cpow2_combined := by
  unfold umax_xor_Cpow2_before umax_xor_Cpow2_combined
  simp_alive_peephole
  sorry
def umin_xor_Cpow2_combined := [llvmfunc|
  llvm.func @umin_xor_Cpow2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-65 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_umin_xor_Cpow2   : umin_xor_Cpow2_before  ⊑  umin_xor_Cpow2_combined := by
  unfold umin_xor_Cpow2_before umin_xor_Cpow2_combined
  simp_alive_peephole
  sorry
def smax_xor_Cpow2_pos_combined := [llvmfunc|
  llvm.func @smax_xor_Cpow2_pos(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(32 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_xor_Cpow2_pos   : smax_xor_Cpow2_pos_before  ⊑  smax_xor_Cpow2_pos_combined := by
  unfold smax_xor_Cpow2_pos_before smax_xor_Cpow2_pos_combined
  simp_alive_peephole
  sorry
def smin_xor_Cpow2_pos_combined := [llvmfunc|
  llvm.func @smin_xor_Cpow2_pos(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-17> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_smin_xor_Cpow2_pos   : smin_xor_Cpow2_pos_before  ⊑  smin_xor_Cpow2_pos_combined := by
  unfold smin_xor_Cpow2_pos_before smin_xor_Cpow2_pos_combined
  simp_alive_peephole
  sorry
def smax_xor_Cpow2_neg_combined := [llvmfunc|
  llvm.func @smax_xor_Cpow2_neg(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_smax_xor_Cpow2_neg   : smax_xor_Cpow2_neg_before  ⊑  smax_xor_Cpow2_neg_combined := by
  unfold smax_xor_Cpow2_neg_before smax_xor_Cpow2_neg_combined
  simp_alive_peephole
  sorry
def smin_xor_Cpow2_neg_combined := [llvmfunc|
  llvm.func @smin_xor_Cpow2_neg(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_smin_xor_Cpow2_neg   : smin_xor_Cpow2_neg_before  ⊑  smin_xor_Cpow2_neg_combined := by
  unfold smin_xor_Cpow2_neg_before smin_xor_Cpow2_neg_combined
  simp_alive_peephole
  sorry
def umax_xor_pow2_combined := [llvmfunc|
  llvm.func @umax_xor_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umax_xor_pow2   : umax_xor_pow2_before  ⊑  umax_xor_pow2_combined := by
  unfold umax_xor_pow2_before umax_xor_pow2_combined
  simp_alive_peephole
  sorry
def umin_xor_pow2_combined := [llvmfunc|
  llvm.func @umin_xor_pow2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.sub %1, %arg1  : vector<2xi8>
    %4 = llvm.and %3, %arg1  : vector<2xi8>
    %5 = llvm.xor %4, %2  : vector<2xi8>
    %6 = llvm.and %5, %arg0  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }]

theorem inst_combine_umin_xor_pow2   : umin_xor_pow2_before  ⊑  umin_xor_pow2_combined := by
  unfold umin_xor_pow2_before umin_xor_pow2_combined
  simp_alive_peephole
  sorry
def smax_xor_pow2_unk_combined := [llvmfunc|
  llvm.func @smax_xor_pow2_unk(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.xor %2, %arg0  : i8
    %4 = llvm.intr.smax(%arg0, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }]

theorem inst_combine_smax_xor_pow2_unk   : smax_xor_pow2_unk_before  ⊑  smax_xor_pow2_unk_combined := by
  unfold smax_xor_pow2_unk_before smax_xor_pow2_unk_combined
  simp_alive_peephole
  sorry
def smin_xor_pow2_unk_combined := [llvmfunc|
  llvm.func @smin_xor_pow2_unk(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg1  : vector<2xi8>
    %3 = llvm.and %2, %arg1  : vector<2xi8>
    %4 = llvm.xor %3, %arg0  : vector<2xi8>
    %5 = llvm.intr.smin(%arg0, %4)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_smin_xor_pow2_unk   : smin_xor_pow2_unk_before  ⊑  smin_xor_pow2_unk_combined := by
  unfold smin_xor_pow2_unk_before smin_xor_pow2_unk_combined
  simp_alive_peephole
  sorry
def smax_xor_pow2_neg_combined := [llvmfunc|
  llvm.func @smax_xor_pow2_neg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = llvm.icmp "eq" %arg1, %0 : i8
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.and %arg0, %2  : i8
    llvm.return %4 : i8
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %1 : i8
  }]

theorem inst_combine_smax_xor_pow2_neg   : smax_xor_pow2_neg_before  ⊑  smax_xor_pow2_neg_combined := by
  unfold smax_xor_pow2_neg_before smax_xor_pow2_neg_combined
  simp_alive_peephole
  sorry
def smin_xor_pow2_pos_combined := [llvmfunc|
  llvm.func @smin_xor_pow2_pos(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.icmp "sgt" %3, %0 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.xor %3, %1  : i8
    %6 = llvm.and %5, %arg0  : i8
    llvm.return %6 : i8
  ^bb2:  // pred: ^bb0
    llvm.call @barrier() : () -> ()
    llvm.return %0 : i8
  }]

theorem inst_combine_smin_xor_pow2_pos   : smin_xor_pow2_pos_before  ⊑  smin_xor_pow2_pos_combined := by
  unfold smin_xor_pow2_pos_before smin_xor_pow2_pos_combined
  simp_alive_peephole
  sorry
