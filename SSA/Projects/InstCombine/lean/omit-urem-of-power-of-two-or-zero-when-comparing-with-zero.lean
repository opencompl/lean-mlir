import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  omit-urem-of-power-of-two-or-zero-when-comparing-with-zero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_scalar_urem_by_const_before := [llvmfunc|
  llvm.func @p0_scalar_urem_by_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.urem %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }]

def p1_scalar_urem_by_nonconst_before := [llvmfunc|
  llvm.func @p1_scalar_urem_by_nonconst(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.urem %3, %4  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def p2_scalar_shifted_urem_by_const_before := [llvmfunc|
  llvm.func @p2_scalar_shifted_urem_by_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %arg1  : i32
    %5 = llvm.urem %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def p3_scalar_shifted2_urem_by_const_before := [llvmfunc|
  llvm.func @p3_scalar_shifted2_urem_by_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %arg1  : i32
    %5 = llvm.urem %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def p4_vector_urem_by_const__splat_before := [llvmfunc|
  llvm.func @p4_vector_urem_by_const__splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.and %arg0, %0  : vector<4xi32>
    %5 = llvm.urem %4, %1  : vector<4xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<4xi32>
    llvm.return %6 : vector<4xi1>
  }]

def p5_vector_urem_by_const__nonsplat_before := [llvmfunc|
  llvm.func @p5_vector_urem_by_const__nonsplat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[128, 2, 4, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[3, 5, 6, 9]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.and %arg0, %0  : vector<4xi32>
    %5 = llvm.urem %4, %1  : vector<4xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<4xi32>
    llvm.return %6 : vector<4xi1>
  }]

def p6_vector_urem_by_const__nonsplat_poison0_before := [llvmfunc|
  llvm.func @p6_vector_urem_by_const__nonsplat_poison0(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.and %arg0, %10  : vector<4xi32>
    %15 = llvm.urem %14, %11  : vector<4xi32>
    %16 = llvm.icmp "eq" %15, %13 : vector<4xi32>
    llvm.return %16 : vector<4xi1>
  }]

def p7_vector_urem_by_const__nonsplat_poison2_before := [llvmfunc|
  llvm.func @p7_vector_urem_by_const__nonsplat_poison2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.poison : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %3, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %2, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.and %arg0, %0  : vector<4xi32>
    %14 = llvm.urem %13, %1  : vector<4xi32>
    %15 = llvm.icmp "eq" %14, %12 : vector<4xi32>
    llvm.return %15 : vector<4xi1>
  }]

def p8_vector_urem_by_const__nonsplat_poison3_before := [llvmfunc|
  llvm.func @p8_vector_urem_by_const__nonsplat_poison3(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(dense<6> : vector<4xi32>) : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.undef : vector<4xi32>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<4xi32>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %12, %15[%16 : i32] : vector<4xi32>
    %18 = llvm.mlir.constant(2 : i32) : i32
    %19 = llvm.insertelement %1, %17[%18 : i32] : vector<4xi32>
    %20 = llvm.mlir.constant(3 : i32) : i32
    %21 = llvm.insertelement %12, %19[%20 : i32] : vector<4xi32>
    %22 = llvm.and %arg0, %10  : vector<4xi32>
    %23 = llvm.urem %22, %11  : vector<4xi32>
    %24 = llvm.icmp "eq" %23, %21 : vector<4xi32>
    llvm.return %24 : vector<4xi1>
  }]

def n0_urem_of_maybe_not_power_of_two_before := [llvmfunc|
  llvm.func @n0_urem_of_maybe_not_power_of_two(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.urem %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

def n1_urem_by_maybe_power_of_two_before := [llvmfunc|
  llvm.func @n1_urem_by_maybe_power_of_two(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.urem %3, %4  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

def p0_scalar_urem_by_const_combined := [llvmfunc|
  llvm.func @p0_scalar_urem_by_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_p0_scalar_urem_by_const   : p0_scalar_urem_by_const_before  ⊑  p0_scalar_urem_by_const_combined := by
  unfold p0_scalar_urem_by_const_before p0_scalar_urem_by_const_combined
  simp_alive_peephole
  sorry
def p1_scalar_urem_by_nonconst_combined := [llvmfunc|
  llvm.func @p1_scalar_urem_by_nonconst(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_p1_scalar_urem_by_nonconst   : p1_scalar_urem_by_nonconst_before  ⊑  p1_scalar_urem_by_nonconst_combined := by
  unfold p1_scalar_urem_by_nonconst_before p1_scalar_urem_by_nonconst_combined
  simp_alive_peephole
  sorry
def p2_scalar_shifted_urem_by_const_combined := [llvmfunc|
  llvm.func @p2_scalar_shifted_urem_by_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %arg1 overflow<nuw>  : i32
    %5 = llvm.urem %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_p2_scalar_shifted_urem_by_const   : p2_scalar_shifted_urem_by_const_before  ⊑  p2_scalar_shifted_urem_by_const_combined := by
  unfold p2_scalar_shifted_urem_by_const_before p2_scalar_shifted_urem_by_const_combined
  simp_alive_peephole
  sorry
def p3_scalar_shifted2_urem_by_const_combined := [llvmfunc|
  llvm.func @p3_scalar_shifted2_urem_by_const(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %arg1  : i32
    %5 = llvm.urem %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_p3_scalar_shifted2_urem_by_const   : p3_scalar_shifted2_urem_by_const_before  ⊑  p3_scalar_shifted2_urem_by_const_combined := by
  unfold p3_scalar_shifted2_urem_by_const_before p3_scalar_shifted2_urem_by_const_combined
  simp_alive_peephole
  sorry
def p4_vector_urem_by_const__splat_combined := [llvmfunc|
  llvm.func @p4_vector_urem_by_const__splat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.and %arg0, %0  : vector<4xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<4xi32>
    llvm.return %4 : vector<4xi1>
  }]

theorem inst_combine_p4_vector_urem_by_const__splat   : p4_vector_urem_by_const__splat_before  ⊑  p4_vector_urem_by_const__splat_combined := by
  unfold p4_vector_urem_by_const__splat_before p4_vector_urem_by_const__splat_combined
  simp_alive_peephole
  sorry
def p5_vector_urem_by_const__nonsplat_combined := [llvmfunc|
  llvm.func @p5_vector_urem_by_const__nonsplat(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[128, 2, 4, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[3, 5, 6, 9]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.and %arg0, %0  : vector<4xi32>
    %5 = llvm.urem %4, %1  : vector<4xi32>
    %6 = llvm.icmp "eq" %5, %3 : vector<4xi32>
    llvm.return %6 : vector<4xi1>
  }]

theorem inst_combine_p5_vector_urem_by_const__nonsplat   : p5_vector_urem_by_const__nonsplat_before  ⊑  p5_vector_urem_by_const__nonsplat_combined := by
  unfold p5_vector_urem_by_const__nonsplat_before p5_vector_urem_by_const__nonsplat_combined
  simp_alive_peephole
  sorry
def p6_vector_urem_by_const__nonsplat_poison0_combined := [llvmfunc|
  llvm.func @p6_vector_urem_by_const__nonsplat_poison0(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %13 = llvm.and %arg0, %10  : vector<4xi32>
    %14 = llvm.icmp "eq" %13, %12 : vector<4xi32>
    llvm.return %14 : vector<4xi1>
  }]

theorem inst_combine_p6_vector_urem_by_const__nonsplat_poison0   : p6_vector_urem_by_const__nonsplat_poison0_before  ⊑  p6_vector_urem_by_const__nonsplat_poison0_combined := by
  unfold p6_vector_urem_by_const__nonsplat_poison0_before p6_vector_urem_by_const__nonsplat_poison0_combined
  simp_alive_peephole
  sorry
def p7_vector_urem_by_const__nonsplat_poison2_combined := [llvmfunc|
  llvm.func @p7_vector_urem_by_const__nonsplat_poison2(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.and %arg0, %0  : vector<4xi32>
    %13 = llvm.icmp "eq" %12, %11 : vector<4xi32>
    llvm.return %13 : vector<4xi1>
  }]

theorem inst_combine_p7_vector_urem_by_const__nonsplat_poison2   : p7_vector_urem_by_const__nonsplat_poison2_before  ⊑  p7_vector_urem_by_const__nonsplat_poison2_combined := by
  unfold p7_vector_urem_by_const__nonsplat_poison2_before p7_vector_urem_by_const__nonsplat_poison2_combined
  simp_alive_peephole
  sorry
def p8_vector_urem_by_const__nonsplat_poison3_combined := [llvmfunc|
  llvm.func @p8_vector_urem_by_const__nonsplat_poison3(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %1, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %11, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.and %arg0, %10  : vector<4xi32>
    %22 = llvm.icmp "eq" %21, %20 : vector<4xi32>
    llvm.return %22 : vector<4xi1>
  }]

theorem inst_combine_p8_vector_urem_by_const__nonsplat_poison3   : p8_vector_urem_by_const__nonsplat_poison3_before  ⊑  p8_vector_urem_by_const__nonsplat_poison3_combined := by
  unfold p8_vector_urem_by_const__nonsplat_poison3_before p8_vector_urem_by_const__nonsplat_poison3_combined
  simp_alive_peephole
  sorry
def n0_urem_of_maybe_not_power_of_two_combined := [llvmfunc|
  llvm.func @n0_urem_of_maybe_not_power_of_two(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.urem %2, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_n0_urem_of_maybe_not_power_of_two   : n0_urem_of_maybe_not_power_of_two_before  ⊑  n0_urem_of_maybe_not_power_of_two_combined := by
  unfold n0_urem_of_maybe_not_power_of_two_before n0_urem_of_maybe_not_power_of_two_combined
  simp_alive_peephole
  sorry
def n1_urem_by_maybe_power_of_two_combined := [llvmfunc|
  llvm.func @n1_urem_by_maybe_power_of_two(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(128 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.or %arg1, %1  : i32
    %5 = llvm.urem %3, %4  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_n1_urem_by_maybe_power_of_two   : n1_urem_by_maybe_power_of_two_before  ⊑  n1_urem_by_maybe_power_of_two_combined := by
  unfold n1_urem_by_maybe_power_of_two_before n1_urem_by_maybe_power_of_two_combined
  simp_alive_peephole
  sorry
