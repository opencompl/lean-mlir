import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-uge-of-add-of-shl-one-by-bits-to-allones-and-val-to-icmp-eq-of-lshr-val-by-bits-and-0
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_before := [llvmfunc|
  llvm.func @p0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.icmp "uge" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def p1_vec_before := [llvmfunc|
  llvm.func @p1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    llvm.call @use2i8(%2) : (vector<2xi8>) -> ()
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "uge" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def p2_vec_undef0_before := [llvmfunc|
  llvm.func @p2_vec_undef0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<-1> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %8, %arg1  : vector<3xi8>
    llvm.call @use3i8(%10) : (vector<3xi8>) -> ()
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.icmp "uge" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }]

def p2_vec_poison0_before := [llvmfunc|
  llvm.func @p2_vec_poison0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
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
    llvm.call @use3i8(%10) : (vector<3xi8>) -> ()
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.icmp "uge" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }]

def p2_vec_poison1_before := [llvmfunc|
  llvm.func @p2_vec_poison1(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
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
    llvm.call @use3i8(%10) : (vector<3xi8>) -> ()
    %11 = llvm.add %10, %9  : vector<3xi8>
    %12 = llvm.icmp "uge" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }]

def p2_vec_poison2_before := [llvmfunc|
  llvm.func @p2_vec_poison2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(-1 : i8) : i8
    %10 = llvm.mlir.undef : vector<3xi8>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi8>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi8>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi8>
    %17 = llvm.shl %8, %arg1  : vector<3xi8>
    llvm.call @use3i8(%17) : (vector<3xi8>) -> ()
    %18 = llvm.add %17, %16  : vector<3xi8>
    %19 = llvm.icmp "uge" %18, %arg0 : vector<3xi8>
    llvm.return %19 : vector<3xi1>
  }]

def c0_before := [llvmfunc|
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.call @gen8() : () -> i8
    %5 = llvm.icmp "ule" %4, %3 : i8
    llvm.return %5 : i1
  }]

def both_before := [llvmfunc|
  llvm.func @both(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.add %4, %1  : i8
    %6 = llvm.icmp "uge" %3, %5 : i8
    llvm.return %6 : i1
  }]

def oneuse_before := [llvmfunc|
  llvm.func @oneuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "uge" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def n0_before := [llvmfunc|
  llvm.func @n0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def n2_vec_nonsplat_before := [llvmfunc|
  llvm.func @n2_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    llvm.call @use2i8(%2) : (vector<2xi8>) -> ()
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "uge" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def n3_vec_nonsplat_before := [llvmfunc|
  llvm.func @n3_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    llvm.call @use2i8(%2) : (vector<2xi8>) -> ()
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "uge" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def n3_before := [llvmfunc|
  llvm.func @n3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.icmp "ugt" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def n4_before := [llvmfunc|
  llvm.func @n4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.call @gen8() : () -> i8
    %5 = llvm.icmp "ult" %4, %3 : i8
    llvm.return %5 : i1
  }]

def p0_combined := [llvmfunc|
  llvm.func @p0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.lshr %arg0, %arg1  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_p0   : p0_before  ⊑  p0_combined := by
  unfold p0_before p0_combined
  simp_alive_peephole
  sorry
def p1_vec_combined := [llvmfunc|
  llvm.func @p1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : vector<2xi8>
    llvm.call @use2i8(%3) : (vector<2xi8>) -> ()
    %4 = llvm.lshr %arg0, %arg1  : vector<2xi8>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_p1_vec   : p1_vec_before  ⊑  p1_vec_combined := by
  unfold p1_vec_before p1_vec_combined
  simp_alive_peephole
  sorry
def p2_vec_undef0_combined := [llvmfunc|
  llvm.func @p2_vec_undef0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(0 : i8) : i8
    %10 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %11 = llvm.shl %8, %arg1  : vector<3xi8>
    llvm.call @use3i8(%11) : (vector<3xi8>) -> ()
    %12 = llvm.lshr %arg0, %arg1  : vector<3xi8>
    %13 = llvm.icmp "eq" %12, %10 : vector<3xi8>
    llvm.return %13 : vector<3xi1>
  }]

theorem inst_combine_p2_vec_undef0   : p2_vec_undef0_before  ⊑  p2_vec_undef0_combined := by
  unfold p2_vec_undef0_before p2_vec_undef0_combined
  simp_alive_peephole
  sorry
def p2_vec_poison0_combined := [llvmfunc|
  llvm.func @p2_vec_poison0(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(0 : i8) : i8
    %10 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %11 = llvm.shl %8, %arg1 overflow<nuw>  : vector<3xi8>
    llvm.call @use3i8(%11) : (vector<3xi8>) -> ()
    %12 = llvm.lshr %arg0, %arg1  : vector<3xi8>
    %13 = llvm.icmp "eq" %12, %10 : vector<3xi8>
    llvm.return %13 : vector<3xi1>
  }]

theorem inst_combine_p2_vec_poison0   : p2_vec_poison0_before  ⊑  p2_vec_poison0_combined := by
  unfold p2_vec_poison0_before p2_vec_poison0_combined
  simp_alive_peephole
  sorry
def p2_vec_poison1_combined := [llvmfunc|
  llvm.func @p2_vec_poison1(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %3 = llvm.shl %0, %arg1 overflow<nuw>  : vector<3xi8>
    llvm.call @use3i8(%3) : (vector<3xi8>) -> ()
    %4 = llvm.lshr %arg0, %arg1  : vector<3xi8>
    %5 = llvm.icmp "eq" %4, %2 : vector<3xi8>
    llvm.return %5 : vector<3xi1>
  }]

theorem inst_combine_p2_vec_poison1   : p2_vec_poison1_before  ⊑  p2_vec_poison1_combined := by
  unfold p2_vec_poison1_before p2_vec_poison1_combined
  simp_alive_peephole
  sorry
def p2_vec_poison2_combined := [llvmfunc|
  llvm.func @p2_vec_poison2(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(0 : i8) : i8
    %10 = llvm.mlir.constant(dense<0> : vector<3xi8>) : vector<3xi8>
    %11 = llvm.shl %8, %arg1 overflow<nuw>  : vector<3xi8>
    llvm.call @use3i8(%11) : (vector<3xi8>) -> ()
    %12 = llvm.lshr %arg0, %arg1  : vector<3xi8>
    %13 = llvm.icmp "eq" %12, %10 : vector<3xi8>
    llvm.return %13 : vector<3xi1>
  }]

theorem inst_combine_p2_vec_poison2   : p2_vec_poison2_before  ⊑  p2_vec_poison2_combined := by
  unfold p2_vec_poison2_before p2_vec_poison2_combined
  simp_alive_peephole
  sorry
def c0_combined := [llvmfunc|
  llvm.func @c0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.call @gen8() : () -> i8
    %4 = llvm.lshr %3, %arg0  : i8
    %5 = llvm.icmp "eq" %4, %1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_c0   : c0_before  ⊑  c0_combined := by
  unfold c0_before c0_combined
  simp_alive_peephole
  sorry
def both_combined := [llvmfunc|
  llvm.func @both(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.add %4, %1  : i8
    %6 = llvm.lshr %5, %arg0  : i8
    %7 = llvm.icmp "eq" %6, %2 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_both   : both_before  ⊑  both_combined := by
  unfold both_before both_combined
  simp_alive_peephole
  sorry
def oneuse_combined := [llvmfunc|
  llvm.func @oneuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "uge" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_oneuse   : oneuse_before  ⊑  oneuse_combined := by
  unfold oneuse_before oneuse_combined
  simp_alive_peephole
  sorry
def n0_combined := [llvmfunc|
  llvm.func @n0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nsw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %1, %0  : i8
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n0   : n0_before  ⊑  n0_combined := by
  unfold n0_before n0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %1, %0 overflow<nuw>  : i8
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def n2_vec_nonsplat_combined := [llvmfunc|
  llvm.func @n2_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1  : vector<2xi8>
    llvm.call @use2i8(%2) : (vector<2xi8>) -> ()
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "uge" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_n2_vec_nonsplat   : n2_vec_nonsplat_before  ⊑  n2_vec_nonsplat_combined := by
  unfold n2_vec_nonsplat_before n2_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n3_vec_nonsplat_combined := [llvmfunc|
  llvm.func @n3_vec_nonsplat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : vector<2xi8>
    llvm.call @use2i8(%2) : (vector<2xi8>) -> ()
    %3 = llvm.add %2, %1  : vector<2xi8>
    %4 = llvm.icmp "uge" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_n3_vec_nonsplat   : n3_vec_nonsplat_before  ⊑  n3_vec_nonsplat_combined := by
  unfold n3_vec_nonsplat_before n3_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n3_combined := [llvmfunc|
  llvm.func @n3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg1 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.icmp "ugt" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_n3   : n3_before  ⊑  n3_combined := by
  unfold n3_before n3_combined
  simp_alive_peephole
  sorry
def n4_combined := [llvmfunc|
  llvm.func @n4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.call @gen8() : () -> i8
    %5 = llvm.icmp "ult" %4, %3 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_n4   : n4_before  ⊑  n4_combined := by
  unfold n4_before n4_combined
  simp_alive_peephole
  sorry
