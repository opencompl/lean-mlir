import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-ult-of-not-of-shl-allones-by-bits-and-val-to-icmp-ne-of-lshr-val-by-bits-and-0
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_before := [llvmfunc|
  llvm.func @p0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def p1_vec_before := [llvmfunc|
  llvm.func @p1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg1  : vector<2xi8>
    %2 = llvm.xor %1, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def p2_vec_poison0_before := [llvmfunc|
  llvm.func @p2_vec_poison0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %8, %arg1  : vector<3xi8>
    %11 = llvm.xor %10, %9  : vector<3xi8>
    %12 = llvm.icmp "ult" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }]

def p2_vec_poison1_before := [llvmfunc|
  llvm.func @p2_vec_poison1(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.shl %0, %arg1  : vector<3xi8>
    %11 = llvm.xor %10, %9  : vector<3xi8>
    %12 = llvm.icmp "ult" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }]

def p2_vec_poison2_before := [llvmfunc|
  llvm.func @p2_vec_poison2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.shl %8, %arg1  : vector<3xi8>
    %10 = llvm.xor %9, %8  : vector<3xi8>
    %11 = llvm.icmp "ult" %10, %arg0 : vector<3xi8>
    llvm.return %11 : vector<3xi1>
  }]

def c0_before := [llvmfunc|
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.call @gen8() : () -> i8
    %4 = llvm.icmp "ugt" %3, %2 : i8
    llvm.return %4 : i1
  }]

def both_before := [llvmfunc|
  llvm.func @both(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.shl %0, %arg1  : i8
    %4 = llvm.xor %3, %0  : i8
    %5 = llvm.icmp "ult" %2, %4 : i8
    llvm.return %5 : i1
  }]

def oneuse0_before := [llvmfunc|
  llvm.func @oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def oneuse1_before := [llvmfunc|
  llvm.func @oneuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def oneuse2_before := [llvmfunc|
  llvm.func @oneuse2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def n0_before := [llvmfunc|
  llvm.func @n0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def n2_vec_nonsplat_before := [llvmfunc|
  llvm.func @n2_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def n3_vec_nonsplat_before := [llvmfunc|
  llvm.func @n3_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def n3_before := [llvmfunc|
  llvm.func @n3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.icmp "ule" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def n4_before := [llvmfunc|
  llvm.func @n4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg0  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.call @gen8() : () -> i8
    %4 = llvm.icmp "uge" %3, %2 : i8
    llvm.return %4 : i1
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
def p2_vec_poison0_combined := [llvmfunc|
  llvm.func @p2_vec_poison0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.lshr %arg0, %arg1  : vector<3xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_p2_vec_poison0   : p2_vec_poison0_before  ⊑  p2_vec_poison0_combined := by
  unfold p2_vec_poison0_before p2_vec_poison0_combined
  simp_alive_peephole
  sorry
def p2_vec_poison1_combined := [llvmfunc|
  llvm.func @p2_vec_poison1(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.lshr %arg0, %arg1  : vector<3xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_p2_vec_poison1   : p2_vec_poison1_before  ⊑  p2_vec_poison1_combined := by
  unfold p2_vec_poison1_before p2_vec_poison1_combined
  simp_alive_peephole
  sorry
def p2_vec_poison2_combined := [llvmfunc|
  llvm.func @p2_vec_poison2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %2 = llvm.lshr %arg0, %arg1  : vector<3xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<3xi8>
    llvm.return %3 : vector<3xi1>
  }]

theorem inst_combine_p2_vec_poison2   : p2_vec_poison2_before  ⊑  p2_vec_poison2_combined := by
  unfold p2_vec_poison2_before p2_vec_poison2_combined
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
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.icmp "ugt" %1, %2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_both   : both_before  ⊑  both_combined := by
  unfold both_before both_combined
  simp_alive_peephole
  sorry
def oneuse0_combined := [llvmfunc|
  llvm.func @oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.lshr %arg0, %arg1  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_oneuse0   : oneuse0_before  ⊑  oneuse0_combined := by
  unfold oneuse0_before oneuse0_combined
  simp_alive_peephole
  sorry
def oneuse1_combined := [llvmfunc|
  llvm.func @oneuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_oneuse1   : oneuse1_before  ⊑  oneuse1_combined := by
  unfold oneuse1_before oneuse1_combined
  simp_alive_peephole
  sorry
def oneuse2_combined := [llvmfunc|
  llvm.func @oneuse2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.xor %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_oneuse2   : oneuse2_before  ⊑  oneuse2_combined := by
  unfold oneuse2_before oneuse2_combined
  simp_alive_peephole
  sorry
def n0_combined := [llvmfunc|
  llvm.func @n0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_n0   : n0_before  ⊑  n0_combined := by
  unfold n0_before n0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %3 = llvm.xor %2, %1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def n2_vec_nonsplat_combined := [llvmfunc|
  llvm.func @n2_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_n2_vec_nonsplat   : n2_vec_nonsplat_before  ⊑  n2_vec_nonsplat_combined := by
  unfold n2_vec_nonsplat_before n2_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n3_vec_nonsplat_combined := [llvmfunc|
  llvm.func @n3_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1 overflow<nsw>  : vector<2xi8>
    %3 = llvm.xor %2, %1  : vector<2xi8>
    %4 = llvm.icmp "ult" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_n3_vec_nonsplat   : n3_vec_nonsplat_before  ⊑  n3_vec_nonsplat_combined := by
  unfold n3_vec_nonsplat_before n3_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n3_combined := [llvmfunc|
  llvm.func @n3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.icmp "ule" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n3   : n3_before  ⊑  n3_combined := by
  unfold n3_before n3_combined
  simp_alive_peephole
  sorry
def n4_combined := [llvmfunc|
  llvm.func @n4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.xor %1, %0  : i8
    %3 = llvm.call @gen8() : () -> i8
    %4 = llvm.icmp "uge" %3, %2 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_n4   : n4_before  ⊑  n4_combined := by
  unfold n4_before n4_combined
  simp_alive_peephole
  sorry
