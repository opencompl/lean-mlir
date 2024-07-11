import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-low-bit-mask-and-icmp-ne-to-icmp-ugt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_before := [llvmfunc|
  llvm.func @p0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def p1_vec_before := [llvmfunc|
  llvm.func @p1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %0, %arg1  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def p2_vec_poison_before := [llvmfunc|
  llvm.func @p2_vec_poison(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.lshr %8, %arg1  : vector<3xi8>
    %10 = llvm.and %9, %arg0  : vector<3xi8>
    %11 = llvm.icmp "ne" %10, %arg0 : vector<3xi8>
    llvm.return %11 : vector<3xi1>
  }]

def c0_before := [llvmfunc|
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "ne" %3, %2 : i8
    llvm.return %4 : i1
  }]

def c1_before := [llvmfunc|
  llvm.func @c1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.and %1, %2  : i8
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

def c2_before := [llvmfunc|
  llvm.func @c2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

def oneuse0_before := [llvmfunc|
  llvm.func @oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def oneuse1_before := [llvmfunc|
  llvm.func @oneuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def oneuse2_before := [llvmfunc|
  llvm.func @oneuse2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def n0_before := [llvmfunc|
  llvm.func @n0(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

def p0_combined := [llvmfunc|
  llvm.func @p0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_p0   : p0_before  ⊑  p0_combined := by
  unfold p0_before p0_combined
  simp_alive_peephole
  sorry
def p1_vec_combined := [llvmfunc|
  llvm.func @p1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.lshr %0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_p1_vec   : p1_vec_before  ⊑  p1_vec_combined := by
  unfold p1_vec_before p1_vec_combined
  simp_alive_peephole
  sorry
def p2_vec_poison_combined := [llvmfunc|
  llvm.func @p2_vec_poison(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.lshr %8, %arg1  : vector<3xi8>
    %10 = llvm.icmp "ult" %9, %arg0 : vector<3xi8>
    llvm.return %10 : vector<3xi1>
  }]

theorem inst_combine_p2_vec_poison   : p2_vec_poison_before  ⊑  p2_vec_poison_combined := by
  unfold p2_vec_poison_before p2_vec_poison_combined
  simp_alive_peephole
  sorry
def c0_combined := [llvmfunc|
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_c0   : c0_before  ⊑  c0_combined := by
  unfold c0_before c0_combined
  simp_alive_peephole
  sorry
def c1_combined := [llvmfunc|
  llvm.func @c1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_c1   : c1_before  ⊑  c1_combined := by
  unfold c1_before c1_combined
  simp_alive_peephole
  sorry
def c2_combined := [llvmfunc|
  llvm.func @c2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_c2   : c2_before  ⊑  c2_combined := by
  unfold c2_before c2_combined
  simp_alive_peephole
  sorry
def oneuse0_combined := [llvmfunc|
  llvm.func @oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_oneuse0   : oneuse0_before  ⊑  oneuse0_combined := by
  unfold oneuse0_before oneuse0_combined
  simp_alive_peephole
  sorry
def oneuse1_combined := [llvmfunc|
  llvm.func @oneuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_oneuse1   : oneuse1_before  ⊑  oneuse1_combined := by
  unfold oneuse1_before oneuse1_combined
  simp_alive_peephole
  sorry
def oneuse2_combined := [llvmfunc|
  llvm.func @oneuse2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.and %1, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_oneuse2   : oneuse2_before  ⊑  oneuse2_combined := by
  unfold oneuse2_before oneuse2_combined
  simp_alive_peephole
  sorry
def n0_combined := [llvmfunc|
  llvm.func @n0(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %arg2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n0   : n0_before  ⊑  n0_combined := by
  unfold n0_before n0_combined
  simp_alive_peephole
  sorry
