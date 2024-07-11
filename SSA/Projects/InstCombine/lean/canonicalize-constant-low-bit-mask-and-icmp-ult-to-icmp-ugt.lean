import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-constant-low-bit-mask-and-icmp-ult-to-icmp-ugt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_before := [llvmfunc|
  llvm.func @p0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def pv_before := [llvmfunc|
  llvm.func @pv(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def p1_vec_splat_before := [llvmfunc|
  llvm.func @p1_vec_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def p2_vec_nonsplat_before := [llvmfunc|
  llvm.func @p2_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 15]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def p2_vec_nonsplat_edgecase0_before := [llvmfunc|
  llvm.func @p2_vec_nonsplat_edgecase0(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def p2_vec_nonsplat_edgecase1_before := [llvmfunc|
  llvm.func @p2_vec_nonsplat_edgecase1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def p3_vec_splat_poison_before := [llvmfunc|
  llvm.func @p3_vec_splat_poison(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.and %arg0, %8  : vector<3xi8>
    %10 = llvm.icmp "ult" %9, %arg0 : vector<3xi8>
    llvm.return %10 : vector<3xi1>
  }]

def p3_vec_nonsplat_poison_before := [llvmfunc|
  llvm.func @p3_vec_nonsplat_poison(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.and %arg0, %9  : vector<3xi8>
    %11 = llvm.icmp "ult" %10, %arg0 : vector<3xi8>
    llvm.return %11 : vector<3xi1>
  }]

def c0_before := [llvmfunc|
  llvm.func @c0() -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.and %1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    llvm.return %3 : i1
  }]

def cv0_before := [llvmfunc|
  llvm.func @cv0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.and %1, %2  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    llvm.return %4 : i1
  }]

def cv1_before := [llvmfunc|
  llvm.func @cv1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.and %2, %1  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    llvm.return %4 : i1
  }]

def cv2_before := [llvmfunc|
  llvm.func @cv2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.and %1, %2  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    llvm.return %4 : i1
  }]

def oneuse0_before := [llvmfunc|
  llvm.func @oneuse0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def n0_before := [llvmfunc|
  llvm.func @n0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "ult" %1, %arg2 : i8
    llvm.return %2 : i1
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 16]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def p0_combined := [llvmfunc|
  llvm.func @p0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_p0   : p0_before  ⊑  p0_combined := by
  unfold p0_before p0_combined
  simp_alive_peephole
  sorry
def pv_combined := [llvmfunc|
  llvm.func @pv(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.lshr %0, %arg1  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_pv   : pv_before  ⊑  pv_combined := by
  unfold pv_before pv_combined
  simp_alive_peephole
  sorry
def p1_vec_splat_combined := [llvmfunc|
  llvm.func @p1_vec_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_p1_vec_splat   : p1_vec_splat_before  ⊑  p1_vec_splat_combined := by
  unfold p1_vec_splat_before p1_vec_splat_combined
  simp_alive_peephole
  sorry
def p2_vec_nonsplat_combined := [llvmfunc|
  llvm.func @p2_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 15]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_p2_vec_nonsplat   : p2_vec_nonsplat_before  ⊑  p2_vec_nonsplat_combined := by
  unfold p2_vec_nonsplat_before p2_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def p2_vec_nonsplat_edgecase0_combined := [llvmfunc|
  llvm.func @p2_vec_nonsplat_edgecase0(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-4, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_p2_vec_nonsplat_edgecase0   : p2_vec_nonsplat_edgecase0_before  ⊑  p2_vec_nonsplat_edgecase0_combined := by
  unfold p2_vec_nonsplat_edgecase0_before p2_vec_nonsplat_edgecase0_combined
  simp_alive_peephole
  sorry
def p2_vec_nonsplat_edgecase1_combined := [llvmfunc|
  llvm.func @p2_vec_nonsplat_edgecase1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, -1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_p2_vec_nonsplat_edgecase1   : p2_vec_nonsplat_edgecase1_before  ⊑  p2_vec_nonsplat_edgecase1_combined := by
  unfold p2_vec_nonsplat_edgecase1_before p2_vec_nonsplat_edgecase1_combined
  simp_alive_peephole
  sorry
def p3_vec_splat_poison_combined := [llvmfunc|
  llvm.func @p3_vec_splat_poison(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<3xi8>
    llvm.return %1 : vector<3xi1>
  }]

theorem inst_combine_p3_vec_splat_poison   : p3_vec_splat_poison_before  ⊑  p3_vec_splat_poison_combined := by
  unfold p3_vec_splat_poison_before p3_vec_splat_poison_combined
  simp_alive_peephole
  sorry
def p3_vec_nonsplat_poison_combined := [llvmfunc|
  llvm.func @p3_vec_nonsplat_poison(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[7, 31, 7]> : vector<3xi8>) : vector<3xi8>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<3xi8>
    llvm.return %1 : vector<3xi1>
  }]

theorem inst_combine_p3_vec_nonsplat_poison   : p3_vec_nonsplat_poison_before  ⊑  p3_vec_nonsplat_poison_combined := by
  unfold p3_vec_nonsplat_poison_before p3_vec_nonsplat_poison_combined
  simp_alive_peephole
  sorry
def c0_combined := [llvmfunc|
  llvm.func @c0() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @gen8() : () -> i8
    llvm.return %0 : i1
  }]

theorem inst_combine_c0   : c0_before  ⊑  c0_combined := by
  unfold c0_before c0_combined
  simp_alive_peephole
  sorry
def cv0_combined := [llvmfunc|
  llvm.func @cv0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %1, %2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_cv0   : cv0_before  ⊑  cv0_combined := by
  unfold cv0_before cv0_combined
  simp_alive_peephole
  sorry
def cv1_combined := [llvmfunc|
  llvm.func @cv1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @gen8() : () -> i8
    llvm.return %0 : i1
  }]

theorem inst_combine_cv1   : cv1_before  ⊑  cv1_combined := by
  unfold cv1_before cv1_combined
  simp_alive_peephole
  sorry
def cv2_combined := [llvmfunc|
  llvm.func @cv2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.call @gen8() : () -> i8
    llvm.return %0 : i1
  }]

theorem inst_combine_cv2   : cv2_before  ⊑  cv2_combined := by
  unfold cv2_before cv2_combined
  simp_alive_peephole
  sorry
def oneuse0_combined := [llvmfunc|
  llvm.func @oneuse0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_oneuse0   : oneuse0_before  ⊑  oneuse0_combined := by
  unfold oneuse0_before oneuse0_combined
  simp_alive_peephole
  sorry
def n0_combined := [llvmfunc|
  llvm.func @n0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n0   : n0_before  ⊑  n0_combined := by
  unfold n0_before n0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "ult" %1, %arg2 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-4, -17]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
