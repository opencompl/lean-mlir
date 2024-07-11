import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  reuse-constant-from-select-in-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_ult_65536_before := [llvmfunc|
  llvm.func @p0_ult_65536(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

def p1_ugt_before := [llvmfunc|
  llvm.func @p1_ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65534 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

def p2_slt_65536_before := [llvmfunc|
  llvm.func @p2_slt_65536(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

def p3_sgt_before := [llvmfunc|
  llvm.func @p3_sgt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65534 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

def p4_vec_splat_ult_65536_before := [llvmfunc|
  llvm.func @p4_vec_splat_ult_65536(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65536> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def p5_vec_splat_ugt_before := [llvmfunc|
  llvm.func @p5_vec_splat_ugt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65534> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def p6_vec_splat_slt_65536_before := [llvmfunc|
  llvm.func @p6_vec_splat_slt_65536(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65536> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def p7_vec_splat_sgt_before := [llvmfunc|
  llvm.func @p7_vec_splat_sgt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65534> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def p8_vec_nonsplat_poison0_before := [llvmfunc|
  llvm.func @p8_vec_nonsplat_poison0(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.icmp "ult" %arg0, %6 : vector<2xi32>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def p9_vec_nonsplat_poison1_before := [llvmfunc|
  llvm.func @p9_vec_nonsplat_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65536> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %9 = llvm.select %8, %arg1, %7 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

def p10_vec_nonsplat_poison2_before := [llvmfunc|
  llvm.func @p10_vec_nonsplat_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(65535 : i32) : i32
    %8 = llvm.mlir.undef : vector<2xi32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi32>
    %13 = llvm.icmp "ult" %arg0, %6 : vector<2xi32>
    %14 = llvm.select %13, %arg1, %12 : vector<2xi1>, vector<2xi32>
    llvm.return %14 : vector<2xi32>
  }]

def p11_vec_nonsplat_before := [llvmfunc|
  llvm.func @p11_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, 32768]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 32767]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def n12_extrause_before := [llvmfunc|
  llvm.func @n12_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

def p13_commutativity0_before := [llvmfunc|
  llvm.func @p13_commutativity0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def p14_commutativity1_before := [llvmfunc|
  llvm.func @p14_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.mlir.constant(42 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

def p15_commutativity2_before := [llvmfunc|
  llvm.func @p15_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    llvm.return %4 : i32
  }]

def n17_ult_zero_before := [llvmfunc|
  llvm.func @n17_ult_zero(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, -1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def n18_ugt_allones_before := [llvmfunc|
  llvm.func @n18_ugt_allones(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65534, -1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 0]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def n19_slt_int_min_before := [llvmfunc|
  llvm.func @n19_slt_int_min(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def n20_sgt_int_max_before := [llvmfunc|
  llvm.func @n20_sgt_int_max(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65534, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def n21_equality_before := [llvmfunc|
  llvm.func @n21_equality(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def t22_sign_check_before := [llvmfunc|
  llvm.func @t22_sign_check(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def t22_sign_check2_before := [llvmfunc|
  llvm.func @t22_sign_check2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def n23_type_mismatch_before := [llvmfunc|
  llvm.func @n23_type_mismatch(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

def n24_ult_65534_before := [llvmfunc|
  llvm.func @n24_ult_65534(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65534 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

def n25_all_good0_before := [llvmfunc|
  llvm.func @n25_all_good0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

def n26_all_good1_before := [llvmfunc|
  llvm.func @n26_all_good1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

def ult_inf_loop_before := [llvmfunc|
  llvm.func @ult_inf_loop(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

def ult_inf_loop_vec_before := [llvmfunc|
  llvm.func @ult_inf_loop_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-5> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.add %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "ugt" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %2, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def p0_ult_65536_combined := [llvmfunc|
  llvm.func @p0_ult_65536(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.select %1, %0, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_p0_ult_65536   : p0_ult_65536_before  ⊑  p0_ult_65536_combined := by
  unfold p0_ult_65536_before p0_ult_65536_combined
  simp_alive_peephole
  sorry
def p1_ugt_combined := [llvmfunc|
  llvm.func @p1_ugt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    %2 = llvm.select %1, %0, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_p1_ugt   : p1_ugt_before  ⊑  p1_ugt_combined := by
  unfold p1_ugt_before p1_ugt_combined
  simp_alive_peephole
  sorry
def p2_slt_65536_combined := [llvmfunc|
  llvm.func @p2_slt_65536(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.select %1, %0, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_p2_slt_65536   : p2_slt_65536_before  ⊑  p2_slt_65536_combined := by
  unfold p2_slt_65536_before p2_slt_65536_combined
  simp_alive_peephole
  sorry
def p3_sgt_combined := [llvmfunc|
  llvm.func @p3_sgt(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %0, %arg1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_p3_sgt   : p3_sgt_before  ⊑  p3_sgt_combined := by
  unfold p3_sgt_before p3_sgt_combined
  simp_alive_peephole
  sorry
def p4_vec_splat_ult_65536_combined := [llvmfunc|
  llvm.func @p4_vec_splat_ult_65536(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %0, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_p4_vec_splat_ult_65536   : p4_vec_splat_ult_65536_before  ⊑  p4_vec_splat_ult_65536_combined := by
  unfold p4_vec_splat_ult_65536_before p4_vec_splat_ult_65536_combined
  simp_alive_peephole
  sorry
def p5_vec_splat_ugt_combined := [llvmfunc|
  llvm.func @p5_vec_splat_ugt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %0, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_p5_vec_splat_ugt   : p5_vec_splat_ugt_before  ⊑  p5_vec_splat_ugt_combined := by
  unfold p5_vec_splat_ugt_before p5_vec_splat_ugt_combined
  simp_alive_peephole
  sorry
def p6_vec_splat_slt_65536_combined := [llvmfunc|
  llvm.func @p6_vec_splat_slt_65536(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %0, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_p6_vec_splat_slt_65536   : p6_vec_splat_slt_65536_before  ⊑  p6_vec_splat_slt_65536_combined := by
  unfold p6_vec_splat_slt_65536_before p6_vec_splat_slt_65536_combined
  simp_alive_peephole
  sorry
def p7_vec_splat_sgt_combined := [llvmfunc|
  llvm.func @p7_vec_splat_sgt(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %0, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_p7_vec_splat_sgt   : p7_vec_splat_sgt_before  ⊑  p7_vec_splat_sgt_combined := by
  unfold p7_vec_splat_sgt_before p7_vec_splat_sgt_combined
  simp_alive_peephole
  sorry
def p8_vec_nonsplat_poison0_combined := [llvmfunc|
  llvm.func @p8_vec_nonsplat_poison0(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %0, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_p8_vec_nonsplat_poison0   : p8_vec_nonsplat_poison0_before  ⊑  p8_vec_nonsplat_poison0_combined := by
  unfold p8_vec_nonsplat_poison0_before p8_vec_nonsplat_poison0_combined
  simp_alive_peephole
  sorry
def p9_vec_nonsplat_poison1_combined := [llvmfunc|
  llvm.func @p9_vec_nonsplat_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %9 = llvm.select %8, %7, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

theorem inst_combine_p9_vec_nonsplat_poison1   : p9_vec_nonsplat_poison1_before  ⊑  p9_vec_nonsplat_poison1_combined := by
  unfold p9_vec_nonsplat_poison1_before p9_vec_nonsplat_poison1_combined
  simp_alive_peephole
  sorry
def p10_vec_nonsplat_poison2_combined := [llvmfunc|
  llvm.func @p10_vec_nonsplat_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.mlir.undef : vector<2xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi32>
    %8 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %9 = llvm.select %8, %7, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %9 : vector<2xi32>
  }]

theorem inst_combine_p10_vec_nonsplat_poison2   : p10_vec_nonsplat_poison2_before  ⊑  p10_vec_nonsplat_poison2_combined := by
  unfold p10_vec_nonsplat_poison2_before p10_vec_nonsplat_poison2_combined
  simp_alive_peephole
  sorry
def p11_vec_nonsplat_combined := [llvmfunc|
  llvm.func @p11_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65535, 32767]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %0, %arg1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_p11_vec_nonsplat   : p11_vec_nonsplat_before  ⊑  p11_vec_nonsplat_combined := by
  unfold p11_vec_nonsplat_before p11_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n12_extrause_combined := [llvmfunc|
  llvm.func @n12_extrause(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n12_extrause   : n12_extrause_before  ⊑  n12_extrause_combined := by
  unfold n12_extrause_before n12_extrause_combined
  simp_alive_peephole
  sorry
def p13_commutativity0_combined := [llvmfunc|
  llvm.func @p13_commutativity0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_p13_commutativity0   : p13_commutativity0_before  ⊑  p13_commutativity0_combined := by
  unfold p13_commutativity0_before p13_commutativity0_combined
  simp_alive_peephole
  sorry
def p14_commutativity1_combined := [llvmfunc|
  llvm.func @p14_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_p14_commutativity1   : p14_commutativity1_before  ⊑  p14_commutativity1_combined := by
  unfold p14_commutativity1_before p14_commutativity1_combined
  simp_alive_peephole
  sorry
def p15_commutativity2_combined := [llvmfunc|
  llvm.func @p15_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(42 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_p15_commutativity2   : p15_commutativity2_before  ⊑  p15_commutativity2_combined := by
  unfold p15_commutativity2_before p15_commutativity2_combined
  simp_alive_peephole
  sorry
def n17_ult_zero_combined := [llvmfunc|
  llvm.func @n17_ult_zero(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, -1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_n17_ult_zero   : n17_ult_zero_before  ⊑  n17_ult_zero_combined := by
  unfold n17_ult_zero_before n17_ult_zero_combined
  simp_alive_peephole
  sorry
def n18_ugt_allones_combined := [llvmfunc|
  llvm.func @n18_ugt_allones(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65534, -1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 0]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_n18_ugt_allones   : n18_ugt_allones_before  ⊑  n18_ugt_allones_combined := by
  unfold n18_ugt_allones_before n18_ugt_allones_combined
  simp_alive_peephole
  sorry
def n19_slt_int_min_combined := [llvmfunc|
  llvm.func @n19_slt_int_min(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_n19_slt_int_min   : n19_slt_int_min_before  ⊑  n19_slt_int_min_combined := by
  unfold n19_slt_int_min_before n19_slt_int_min_combined
  simp_alive_peephole
  sorry
def n20_sgt_int_max_combined := [llvmfunc|
  llvm.func @n20_sgt_int_max(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65534, 2147483647]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[65535, -2147483648]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg1, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_n20_sgt_int_max   : n20_sgt_int_max_before  ⊑  n20_sgt_int_max_combined := by
  unfold n20_sgt_int_max_before n20_sgt_int_max_combined
  simp_alive_peephole
  sorry
def n21_equality_combined := [llvmfunc|
  llvm.func @n21_equality(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(2147483647 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n21_equality   : n21_equality_before  ⊑  n21_equality_combined := by
  unfold n21_equality_before n21_equality_combined
  simp_alive_peephole
  sorry
def t22_sign_check_combined := [llvmfunc|
  llvm.func @t22_sign_check(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t22_sign_check   : t22_sign_check_before  ⊑  t22_sign_check_combined := by
  unfold t22_sign_check_before t22_sign_check_combined
  simp_alive_peephole
  sorry
def t22_sign_check2_combined := [llvmfunc|
  llvm.func @t22_sign_check2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg1, %0 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t22_sign_check2   : t22_sign_check2_before  ⊑  t22_sign_check2_combined := by
  unfold t22_sign_check2_before t22_sign_check2_combined
  simp_alive_peephole
  sorry
def n23_type_mismatch_combined := [llvmfunc|
  llvm.func @n23_type_mismatch(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i64
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n23_type_mismatch   : n23_type_mismatch_before  ⊑  n23_type_mismatch_combined := by
  unfold n23_type_mismatch_before n23_type_mismatch_combined
  simp_alive_peephole
  sorry
def n24_ult_65534_combined := [llvmfunc|
  llvm.func @n24_ult_65534(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65534 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n24_ult_65534   : n24_ult_65534_before  ⊑  n24_ult_65534_combined := by
  unfold n24_ult_65534_before n24_ult_65534_combined
  simp_alive_peephole
  sorry
def n25_all_good0_combined := [llvmfunc|
  llvm.func @n25_all_good0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n25_all_good0   : n25_all_good0_before  ⊑  n25_all_good0_combined := by
  unfold n25_all_good0_before n25_all_good0_combined
  simp_alive_peephole
  sorry
def n26_all_good1_combined := [llvmfunc|
  llvm.func @n26_all_good1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %1 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_n26_all_good1   : n26_all_good1_before  ⊑  n26_all_good1_combined := by
  unfold n26_all_good1_before n26_all_good1_combined
  simp_alive_peephole
  sorry
def ult_inf_loop_combined := [llvmfunc|
  llvm.func @ult_inf_loop(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    %6 = llvm.select %5, %2, %3 : i1, i32
    llvm.return %6 : i32
  }]

theorem inst_combine_ult_inf_loop   : ult_inf_loop_before  ⊑  ult_inf_loop_combined := by
  unfold ult_inf_loop_before ult_inf_loop_combined
  simp_alive_peephole
  sorry
def ult_inf_loop_vec_combined := [llvmfunc|
  llvm.func @ult_inf_loop_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<38> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-5> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.add %arg0, %0  : vector<2xi32>
    %5 = llvm.icmp "ult" %4, %1 : vector<2xi32>
    %6 = llvm.select %5, %2, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_ult_inf_loop_vec   : ult_inf_loop_vec_before  ⊑  ult_inf_loop_vec_combined := by
  unfold ult_inf_loop_vec_before ult_inf_loop_vec_combined
  simp_alive_peephole
  sorry
