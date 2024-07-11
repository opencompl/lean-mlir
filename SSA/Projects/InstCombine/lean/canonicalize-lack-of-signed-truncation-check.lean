import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-lack-of-signed-truncation-check
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_before := [llvmfunc|
  llvm.func @p0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def pb_before := [llvmfunc|
  llvm.func @pb(%arg0: i65) -> i1 {
    %0 = llvm.mlir.constant(1 : i65) : i65
    %1 = llvm.shl %arg0, %0  : i65
    %2 = llvm.ashr %1, %0  : i65
    %3 = llvm.icmp "eq" %arg0, %2 : i65
    llvm.return %3 : i1
  }]

def p1_vec_splat_before := [llvmfunc|
  llvm.func @p1_vec_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.ashr %1, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def p2_vec_nonsplat_before := [llvmfunc|
  llvm.func @p2_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.ashr %1, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def p3_vec_undef0_before := [llvmfunc|
  llvm.func @p3_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %arg0, %8  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    %12 = llvm.icmp "eq" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }]

def p4_vec_undef1_before := [llvmfunc|
  llvm.func @p4_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.shl %arg0, %0  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    %12 = llvm.icmp "eq" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }]

def p5_vec_undef2_before := [llvmfunc|
  llvm.func @p5_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.shl %arg0, %8  : vector<3xi8>
    %10 = llvm.ashr %9, %8  : vector<3xi8>
    %11 = llvm.icmp "eq" %10, %arg0 : vector<3xi8>
    llvm.return %11 : vector<3xi1>
  }]

def c0_before := [llvmfunc|
  llvm.func @c0() -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.ashr %2, %0  : i8
    %4 = llvm.icmp "eq" %1, %3 : i8
    llvm.return %4 : i1
  }]

def n_oneuse0_before := [llvmfunc|
  llvm.func @n_oneuse0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def n_oneuse1_before := [llvmfunc|
  llvm.func @n_oneuse1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def n_oneuse2_before := [llvmfunc|
  llvm.func @n_oneuse2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def n0_before := [llvmfunc|
  llvm.func @n0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.lshr %1, %0  : i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.icmp "eq" %2, %arg1 : i8
    llvm.return %3 : i1
  }]

def n3_vec_nonsplat_before := [llvmfunc|
  llvm.func @n3_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.ashr %2, %1  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def p0_combined := [llvmfunc|
  llvm.func @p0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_p0   : p0_before  ⊑  p0_combined := by
  unfold p0_before p0_combined
  simp_alive_peephole
  sorry
def pb_combined := [llvmfunc|
  llvm.func @pb(%arg0: i65) -> i1 {
    %0 = llvm.mlir.constant(9223372036854775808 : i65) : i65
    %1 = llvm.mlir.constant(-1 : i65) : i65
    %2 = llvm.add %arg0, %0  : i65
    %3 = llvm.icmp "sgt" %2, %1 : i65
    llvm.return %3 : i1
  }]

theorem inst_combine_pb   : pb_before  ⊑  pb_combined := by
  unfold pb_before pb_combined
  simp_alive_peephole
  sorry
def p1_vec_splat_combined := [llvmfunc|
  llvm.func @p1_vec_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_p1_vec_splat   : p1_vec_splat_before  ⊑  p1_vec_splat_combined := by
  unfold p1_vec_splat_before p1_vec_splat_combined
  simp_alive_peephole
  sorry
def p2_vec_nonsplat_combined := [llvmfunc|
  llvm.func @p2_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %arg0, %0  : vector<2xi8>
    %2 = llvm.ashr %1, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_p2_vec_nonsplat   : p2_vec_nonsplat_before  ⊑  p2_vec_nonsplat_combined := by
  unfold p2_vec_nonsplat_before p2_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def p3_vec_undef0_combined := [llvmfunc|
  llvm.func @p3_vec_undef0(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.mlir.constant(dense<5> : vector<3xi8>) : vector<3xi8>
    %10 = llvm.shl %arg0, %8  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    %12 = llvm.icmp "eq" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }]

theorem inst_combine_p3_vec_undef0   : p3_vec_undef0_before  ⊑  p3_vec_undef0_combined := by
  unfold p3_vec_undef0_before p3_vec_undef0_combined
  simp_alive_peephole
  sorry
def p4_vec_undef1_combined := [llvmfunc|
  llvm.func @p4_vec_undef1(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.shl %arg0, %0  : vector<3xi8>
    %11 = llvm.ashr %10, %9  : vector<3xi8>
    %12 = llvm.icmp "eq" %11, %arg0 : vector<3xi8>
    llvm.return %12 : vector<3xi1>
  }]

theorem inst_combine_p4_vec_undef1   : p4_vec_undef1_before  ⊑  p4_vec_undef1_combined := by
  unfold p4_vec_undef1_before p4_vec_undef1_combined
  simp_alive_peephole
  sorry
def p5_vec_undef2_combined := [llvmfunc|
  llvm.func @p5_vec_undef2(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.shl %arg0, %8  : vector<3xi8>
    %10 = llvm.ashr %9, %8  : vector<3xi8>
    %11 = llvm.icmp "eq" %10, %arg0 : vector<3xi8>
    llvm.return %11 : vector<3xi1>
  }]

theorem inst_combine_p5_vec_undef2   : p5_vec_undef2_before  ⊑  p5_vec_undef2_combined := by
  unfold p5_vec_undef2_before p5_vec_undef2_combined
  simp_alive_peephole
  sorry
def c0_combined := [llvmfunc|
  llvm.func @c0() -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.add %2, %0  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_c0   : c0_before  ⊑  c0_combined := by
  unfold c0_before c0_combined
  simp_alive_peephole
  sorry
def n_oneuse0_combined := [llvmfunc|
  llvm.func @n_oneuse0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.mlir.constant(8 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_n_oneuse0   : n_oneuse0_before  ⊑  n_oneuse0_combined := by
  unfold n_oneuse0_before n_oneuse0_combined
  simp_alive_peephole
  sorry
def n_oneuse1_combined := [llvmfunc|
  llvm.func @n_oneuse1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n_oneuse1   : n_oneuse1_before  ⊑  n_oneuse1_combined := by
  unfold n_oneuse1_before n_oneuse1_combined
  simp_alive_peephole
  sorry
def n_oneuse2_combined := [llvmfunc|
  llvm.func @n_oneuse2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.ashr %1, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n_oneuse2   : n_oneuse2_before  ⊑  n_oneuse2_combined := by
  unfold n_oneuse2_before n_oneuse2_combined
  simp_alive_peephole
  sorry
def n0_combined := [llvmfunc|
  llvm.func @n0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.ashr %2, %1  : i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_n0   : n0_before  ⊑  n0_combined := by
  unfold n0_before n0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.shl %arg0, %0  : i8
    %2 = llvm.ashr %1, %0  : i8
    %3 = llvm.icmp "eq" %2, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def n3_vec_nonsplat_combined := [llvmfunc|
  llvm.func @n3_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 3]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0  : vector<2xi8>
    %3 = llvm.ashr %2, %1  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %arg0 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_n3_vec_nonsplat   : n3_vec_nonsplat_before  ⊑  n3_vec_nonsplat_combined := by
  unfold n3_vec_nonsplat_before n3_vec_nonsplat_combined
  simp_alive_peephole
  sorry
