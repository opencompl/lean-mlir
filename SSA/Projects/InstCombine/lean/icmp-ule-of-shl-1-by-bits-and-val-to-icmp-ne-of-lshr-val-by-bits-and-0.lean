import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-ule-of-shl-1-by-bits-and-val-to-icmp-ne-of-lshr-val-by-bits-and-0
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_before := [llvmfunc|
  llvm.func @p0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def p1_vec_before := [llvmfunc|
  llvm.func @p1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "ule" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def p2_vec_poison_before := [llvmfunc|
  llvm.func @p2_vec_poison(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.shl %8, %arg1  : vector<3xi8>
    %10 = llvm.icmp "ule" %9, %arg0 : vector<3xi8>
    llvm.return %10 : vector<3xi1>
  }]

def c0_before := [llvmfunc|
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def both_before := [llvmfunc|
  llvm.func @both(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.icmp "ule" %1, %2 : i8
    llvm.return %3 : i1
  }]

def oneuse0_before := [llvmfunc|
  llvm.func @oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def n0_before := [llvmfunc|
  llvm.func @n0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def n1_vec_nonsplat_before := [llvmfunc|
  llvm.func @n1_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "ule" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def n3_before := [llvmfunc|
  llvm.func @n3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def p0_combined := [llvmfunc|
  llvm.func @p0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.lshr %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_p0   : p0_before  ⊑  p0_combined := by
  unfold p0_before p0_combined
  simp_alive_peephole
  sorry
def p1_vec_combined := [llvmfunc|
  llvm.func @p1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_p1_vec   : p1_vec_before  ⊑  p1_vec_combined := by
  unfold p1_vec_before p1_vec_combined
  simp_alive_peephole
  sorry
def p2_vec_poison_combined := [llvmfunc|
  llvm.func @p2_vec_poison(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.lshr %arg0, %arg1  : vector<3xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_p2_vec_poison   : p2_vec_poison_before  ⊑  p2_vec_poison_combined := by
  unfold p2_vec_poison_before p2_vec_poison_combined
  simp_alive_peephole
  sorry
def c0_combined := [llvmfunc|
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.lshr %1, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_c0   : c0_before  ⊑  c0_combined := by
  unfold c0_before c0_combined
  simp_alive_peephole
  sorry
def both_combined := [llvmfunc|
  llvm.func @both(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %3 = llvm.lshr %2, %arg0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_both   : both_before  ⊑  both_combined := by
  unfold both_before both_combined
  simp_alive_peephole
  sorry
def oneuse0_combined := [llvmfunc|
  llvm.func @oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_oneuse0   : oneuse0_before  ⊑  oneuse0_combined := by
  unfold oneuse0_before oneuse0_combined
  simp_alive_peephole
  sorry
def n0_combined := [llvmfunc|
  llvm.func @n0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n0   : n0_before  ⊑  n0_combined := by
  unfold n0_before n0_combined
  simp_alive_peephole
  sorry
def n1_vec_nonsplat_combined := [llvmfunc|
  llvm.func @n1_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "ule" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_n1_vec_nonsplat   : n1_vec_nonsplat_before  ⊑  n1_vec_nonsplat_combined := by
  unfold n1_vec_nonsplat_before n1_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def n3_combined := [llvmfunc|
  llvm.func @n3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n3   : n3_before  ⊑  n3_combined := by
  unfold n3_before n3_combined
  simp_alive_peephole
  sorry
