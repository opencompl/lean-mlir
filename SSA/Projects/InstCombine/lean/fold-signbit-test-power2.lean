import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-signbit-test-power2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pow2_or_zero_is_negative_before := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.and %arg0, %2  : i8
    %4 = llvm.icmp "slt" %3, %0 : i8
    %5 = llvm.icmp "ugt" %3, %1 : i8
    llvm.call @use_i1(%5) : (i1) -> ()
    llvm.return %4 : i1
  }]

def pow2_or_zero_is_negative_commute_before := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative_commute(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mul %0, %arg0  : i8
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.and %3, %2  : i8
    %5 = llvm.icmp "slt" %4, %1 : i8
    llvm.return %5 : i1
  }]

def pow2_or_zero_is_negative_vec_before := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.and %arg0, %3  : vector<2xi8>
    %5 = llvm.icmp "slt" %4, %1 : vector<2xi8>
    %6 = llvm.icmp "ugt" %4, %2 : vector<2xi8>
    llvm.call @use_i1_vec(%6) : (vector<2xi1>) -> ()
    llvm.return %5 : vector<2xi1>
  }]

def pow2_or_zero_is_negative_vec_commute_before := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative_vec_commute(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mul %0, %arg0  : vector<2xi8>
    %4 = llvm.sub %2, %3  : vector<2xi8>
    %5 = llvm.and %4, %3  : vector<2xi8>
    %6 = llvm.icmp "slt" %5, %2 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }]

def pow2_or_zero_is_not_negative_before := [llvmfunc|
  llvm.func @pow2_or_zero_is_not_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "sgt" %4, %1 : i8
    %6 = llvm.icmp "ult" %4, %2 : i8
    llvm.call @use_i1(%6) : (i1) -> ()
    llvm.return %5 : i1
  }]

def pow2_or_zero_is_not_negative_commute_before := [llvmfunc|
  llvm.func @pow2_or_zero_is_not_negative_commute(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mul %0, %arg0  : i8
    %4 = llvm.sub %1, %3  : i8
    %5 = llvm.and %4, %3  : i8
    %6 = llvm.icmp "sgt" %5, %2 : i8
    llvm.return %6 : i1
  }]

def pow2_or_zero_is_not_negative_vec_before := [llvmfunc|
  llvm.func @pow2_or_zero_is_not_negative_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.sub %1, %arg0  : vector<2xi8>
    %5 = llvm.and %arg0, %4  : vector<2xi8>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi8>
    %7 = llvm.icmp "ult" %5, %3 : vector<2xi8>
    llvm.call @use_i1_vec(%7) : (vector<2xi1>) -> ()
    llvm.return %6 : vector<2xi1>
  }]

def pow2_or_zero_is_not_negative_vec_commute_before := [llvmfunc|
  llvm.func @pow2_or_zero_is_not_negative_vec_commute(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mul %0, %arg0  : vector<2xi8>
    %5 = llvm.sub %2, %4  : vector<2xi8>
    %6 = llvm.and %5, %4  : vector<2xi8>
    %7 = llvm.icmp "sgt" %6, %3 : vector<2xi8>
    llvm.return %7 : vector<2xi1>
  }]

def pow2_or_zero_is_negative_extra_use_before := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative_extra_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.and %arg0, %1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.return %3 : i1
  }]

def pow2_or_zero_is_negative_combined := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.call @use_i1(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_pow2_or_zero_is_negative   : pow2_or_zero_is_negative_before  ⊑  pow2_or_zero_is_negative_combined := by
  unfold pow2_or_zero_is_negative_before pow2_or_zero_is_negative_combined
  simp_alive_peephole
  sorry
def pow2_or_zero_is_negative_commute_combined := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative_commute(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_pow2_or_zero_is_negative_commute   : pow2_or_zero_is_negative_commute_before  ⊑  pow2_or_zero_is_negative_commute_combined := by
  unfold pow2_or_zero_is_negative_commute_before pow2_or_zero_is_negative_commute_combined
  simp_alive_peephole
  sorry
def pow2_or_zero_is_negative_vec_combined := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    llvm.call @use_i1_vec(%2) : (vector<2xi1>) -> ()
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_pow2_or_zero_is_negative_vec   : pow2_or_zero_is_negative_vec_before  ⊑  pow2_or_zero_is_negative_vec_combined := by
  unfold pow2_or_zero_is_negative_vec_before pow2_or_zero_is_negative_vec_combined
  simp_alive_peephole
  sorry
def pow2_or_zero_is_negative_vec_commute_combined := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative_vec_commute(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_pow2_or_zero_is_negative_vec_commute   : pow2_or_zero_is_negative_vec_commute_before  ⊑  pow2_or_zero_is_negative_vec_commute_combined := by
  unfold pow2_or_zero_is_negative_vec_commute_before pow2_or_zero_is_negative_vec_commute_combined
  simp_alive_peephole
  sorry
def pow2_or_zero_is_not_negative_combined := [llvmfunc|
  llvm.func @pow2_or_zero_is_not_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.call @use_i1(%2) : (i1) -> ()
    llvm.return %1 : i1
  }]

theorem inst_combine_pow2_or_zero_is_not_negative   : pow2_or_zero_is_not_negative_before  ⊑  pow2_or_zero_is_not_negative_combined := by
  unfold pow2_or_zero_is_not_negative_before pow2_or_zero_is_not_negative_combined
  simp_alive_peephole
  sorry
def pow2_or_zero_is_not_negative_commute_combined := [llvmfunc|
  llvm.func @pow2_or_zero_is_not_negative_commute(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_pow2_or_zero_is_not_negative_commute   : pow2_or_zero_is_not_negative_commute_before  ⊑  pow2_or_zero_is_not_negative_commute_combined := by
  unfold pow2_or_zero_is_not_negative_commute_before pow2_or_zero_is_not_negative_commute_combined
  simp_alive_peephole
  sorry
def pow2_or_zero_is_not_negative_vec_combined := [llvmfunc|
  llvm.func @pow2_or_zero_is_not_negative_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %0 : vector<2xi8>
    llvm.call @use_i1_vec(%2) : (vector<2xi1>) -> ()
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_pow2_or_zero_is_not_negative_vec   : pow2_or_zero_is_not_negative_vec_before  ⊑  pow2_or_zero_is_not_negative_vec_combined := by
  unfold pow2_or_zero_is_not_negative_vec_before pow2_or_zero_is_not_negative_vec_combined
  simp_alive_peephole
  sorry
def pow2_or_zero_is_not_negative_vec_commute_combined := [llvmfunc|
  llvm.func @pow2_or_zero_is_not_negative_vec_commute(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mul %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_pow2_or_zero_is_not_negative_vec_commute   : pow2_or_zero_is_not_negative_vec_commute_before  ⊑  pow2_or_zero_is_not_negative_vec_commute_combined := by
  unfold pow2_or_zero_is_not_negative_vec_commute_before pow2_or_zero_is_not_negative_vec_commute_combined
  simp_alive_peephole
  sorry
def pow2_or_zero_is_negative_extra_use_combined := [llvmfunc|
  llvm.func @pow2_or_zero_is_negative_extra_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.and %2, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %arg0, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_pow2_or_zero_is_negative_extra_use   : pow2_or_zero_is_negative_extra_use_before  ⊑  pow2_or_zero_is_negative_extra_use_combined := by
  unfold pow2_or_zero_is_negative_extra_use_before pow2_or_zero_is_negative_extra_use_combined
  simp_alive_peephole
  sorry
