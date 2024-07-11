import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-clamp-like-pattern-between-zero-and-positive-threshold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_ult_slt_65536_before := [llvmfunc|
  llvm.func @t0_ult_slt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg1, %arg2 : i1, i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    llvm.return %4 : i32
  }]

def t1_ult_slt_0_before := [llvmfunc|
  llvm.func @t1_ult_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def t2_ult_sgt_65536_before := [llvmfunc|
  llvm.func @t2_ult_sgt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg2, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def t3_ult_sgt_neg1_before := [llvmfunc|
  llvm.func @t3_ult_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg2, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def t4_ugt_slt_65536_before := [llvmfunc|
  llvm.func @t4_ugt_slt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

def t5_ugt_slt_0_before := [llvmfunc|
  llvm.func @t5_ugt_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

def t6_ugt_sgt_65536_before := [llvmfunc|
  llvm.func @t6_ugt_sgt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg2, %arg1 : i1, i32
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    llvm.return %4 : i32
  }]

def t7_ugt_sgt_neg1_before := [llvmfunc|
  llvm.func @t7_ugt_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg2, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    %5 = llvm.select %4, %3, %arg0 : i1, i32
    llvm.return %5 : i32
  }]

def n8_ult_slt_65537_before := [llvmfunc|
  llvm.func @n8_ult_slt_65537(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def n9_ult_slt_neg1_before := [llvmfunc|
  llvm.func @n9_ult_slt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def n10_oneuse0_before := [llvmfunc|
  llvm.func @n10_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def n11_oneuse1_before := [llvmfunc|
  llvm.func @n11_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def n12_oneuse2_before := [llvmfunc|
  llvm.func @n12_oneuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def n13_oneuse3_before := [llvmfunc|
  llvm.func @n13_oneuse3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def n14_oneuse4_before := [llvmfunc|
  llvm.func @n14_oneuse4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def n15_oneuse5_before := [llvmfunc|
  llvm.func @n15_oneuse5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def n16_oneuse6_before := [llvmfunc|
  llvm.func @n16_oneuse6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

def t17_ult_slt_vec_splat_before := [llvmfunc|
  llvm.func @t17_ult_slt_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<65536> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def t18_ult_slt_vec_nonsplat_before := [llvmfunc|
  llvm.func @t18_ult_slt_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[65536, 32768]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %arg1, %arg2 : vector<2xi1>, vector<2xi32>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def t19_ult_slt_vec_poison0_before := [llvmfunc|
  llvm.func @t19_ult_slt_vec_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<65536> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.icmp "slt" %arg0, %8 : vector<3xi32>
    %11 = llvm.select %10, %arg1, %arg2 : vector<3xi1>, vector<3xi32>
    %12 = llvm.icmp "ult" %arg0, %9 : vector<3xi32>
    %13 = llvm.select %12, %arg0, %11 : vector<3xi1>, vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }]

def t20_ult_slt_vec_poison1_before := [llvmfunc|
  llvm.func @t20_ult_slt_vec_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<[65536, 65537, 65536]> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.icmp "slt" %arg0, %0 : vector<3xi32>
    %11 = llvm.select %10, %arg1, %arg2 : vector<3xi1>, vector<3xi32>
    %12 = llvm.icmp "ult" %arg0, %9 : vector<3xi32>
    %13 = llvm.select %12, %arg0, %11 : vector<3xi1>, vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }]

def t21_ult_slt_vec_poison2_before := [llvmfunc|
  llvm.func @t21_ult_slt_vec_poison2(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.icmp "slt" %arg0, %8 : vector<3xi32>
    %10 = llvm.select %9, %arg1, %arg2 : vector<3xi1>, vector<3xi32>
    %11 = llvm.icmp "ult" %arg0, %8 : vector<3xi32>
    %12 = llvm.select %11, %arg0, %10 : vector<3xi1>, vector<3xi32>
    llvm.return %12 : vector<3xi32>
  }]

def t22_pointers_before := [llvmfunc|
  llvm.func @t22_pointers(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    %2 = llvm.icmp "slt" %arg0, %1 : !llvm.ptr
    %3 = llvm.select %2, %arg1, %arg2 : i1, !llvm.ptr
    %4 = llvm.icmp "ult" %arg0, %1 : !llvm.ptr
    %5 = llvm.select %4, %arg0, %3 : i1, !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

def t0_ult_slt_65536_combined := [llvmfunc|
  llvm.func @t0_ult_slt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t0_ult_slt_65536   : t0_ult_slt_65536_before  ⊑  t0_ult_slt_65536_combined := by
  unfold t0_ult_slt_65536_before t0_ult_slt_65536_combined
  simp_alive_peephole
  sorry
def t1_ult_slt_0_combined := [llvmfunc|
  llvm.func @t1_ult_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t1_ult_slt_0   : t1_ult_slt_0_before  ⊑  t1_ult_slt_0_combined := by
  unfold t1_ult_slt_0_before t1_ult_slt_0_combined
  simp_alive_peephole
  sorry
def t2_ult_sgt_65536_combined := [llvmfunc|
  llvm.func @t2_ult_sgt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t2_ult_sgt_65536   : t2_ult_sgt_65536_before  ⊑  t2_ult_sgt_65536_combined := by
  unfold t2_ult_sgt_65536_before t2_ult_sgt_65536_combined
  simp_alive_peephole
  sorry
def t3_ult_sgt_neg1_combined := [llvmfunc|
  llvm.func @t3_ult_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t3_ult_sgt_neg1   : t3_ult_sgt_neg1_before  ⊑  t3_ult_sgt_neg1_combined := by
  unfold t3_ult_sgt_neg1_before t3_ult_sgt_neg1_combined
  simp_alive_peephole
  sorry
def t4_ugt_slt_65536_combined := [llvmfunc|
  llvm.func @t4_ugt_slt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t4_ugt_slt_65536   : t4_ugt_slt_65536_before  ⊑  t4_ugt_slt_65536_combined := by
  unfold t4_ugt_slt_65536_before t4_ugt_slt_65536_combined
  simp_alive_peephole
  sorry
def t5_ugt_slt_0_combined := [llvmfunc|
  llvm.func @t5_ugt_slt_0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t5_ugt_slt_0   : t5_ugt_slt_0_before  ⊑  t5_ugt_slt_0_combined := by
  unfold t5_ugt_slt_0_before t5_ugt_slt_0_combined
  simp_alive_peephole
  sorry
def t6_ugt_sgt_65536_combined := [llvmfunc|
  llvm.func @t6_ugt_sgt_65536(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t6_ugt_sgt_65536   : t6_ugt_sgt_65536_before  ⊑  t6_ugt_sgt_65536_combined := by
  unfold t6_ugt_sgt_65536_before t6_ugt_sgt_65536_combined
  simp_alive_peephole
  sorry
def t7_ugt_sgt_neg1_combined := [llvmfunc|
  llvm.func @t7_ugt_sgt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %arg0 : i1, i32
    %5 = llvm.select %3, %arg2, %4 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_t7_ugt_sgt_neg1   : t7_ugt_sgt_neg1_before  ⊑  t7_ugt_sgt_neg1_combined := by
  unfold t7_ugt_sgt_neg1_before t7_ugt_sgt_neg1_combined
  simp_alive_peephole
  sorry
def n8_ult_slt_65537_combined := [llvmfunc|
  llvm.func @n8_ult_slt_65537(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(65537 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n8_ult_slt_65537   : n8_ult_slt_65537_before  ⊑  n8_ult_slt_65537_combined := by
  unfold n8_ult_slt_65537_before n8_ult_slt_65537_combined
  simp_alive_peephole
  sorry
def n9_ult_slt_neg1_combined := [llvmfunc|
  llvm.func @n9_ult_slt_neg1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n9_ult_slt_neg1   : n9_ult_slt_neg1_before  ⊑  n9_ult_slt_neg1_combined := by
  unfold n9_ult_slt_neg1_before n9_ult_slt_neg1_combined
  simp_alive_peephole
  sorry
def n10_oneuse0_combined := [llvmfunc|
  llvm.func @n10_oneuse0(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n10_oneuse0   : n10_oneuse0_before  ⊑  n10_oneuse0_combined := by
  unfold n10_oneuse0_before n10_oneuse0_combined
  simp_alive_peephole
  sorry
def n11_oneuse1_combined := [llvmfunc|
  llvm.func @n11_oneuse1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n11_oneuse1   : n11_oneuse1_before  ⊑  n11_oneuse1_combined := by
  unfold n11_oneuse1_before n11_oneuse1_combined
  simp_alive_peephole
  sorry
def n12_oneuse2_combined := [llvmfunc|
  llvm.func @n12_oneuse2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n12_oneuse2   : n12_oneuse2_before  ⊑  n12_oneuse2_combined := by
  unfold n12_oneuse2_before n12_oneuse2_combined
  simp_alive_peephole
  sorry
def n13_oneuse3_combined := [llvmfunc|
  llvm.func @n13_oneuse3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n13_oneuse3   : n13_oneuse3_before  ⊑  n13_oneuse3_combined := by
  unfold n13_oneuse3_before n13_oneuse3_combined
  simp_alive_peephole
  sorry
def n14_oneuse4_combined := [llvmfunc|
  llvm.func @n14_oneuse4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n14_oneuse4   : n14_oneuse4_before  ⊑  n14_oneuse4_combined := by
  unfold n14_oneuse4_before n14_oneuse4_combined
  simp_alive_peephole
  sorry
def n15_oneuse5_combined := [llvmfunc|
  llvm.func @n15_oneuse5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n15_oneuse5   : n15_oneuse5_before  ⊑  n15_oneuse5_combined := by
  unfold n15_oneuse5_before n15_oneuse5_combined
  simp_alive_peephole
  sorry
def n16_oneuse6_combined := [llvmfunc|
  llvm.func @n16_oneuse6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ult" %arg0, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %4, %arg0, %3 : i1, i32
    llvm.return %5 : i32
  }]

theorem inst_combine_n16_oneuse6   : n16_oneuse6_before  ⊑  n16_oneuse6_combined := by
  unfold n16_oneuse6_before n16_oneuse6_combined
  simp_alive_peephole
  sorry
def t17_ult_slt_vec_splat_combined := [llvmfunc|
  llvm.func @t17_ult_slt_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<65535> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %4 = llvm.icmp "sgt" %arg0, %2 : vector<2xi32>
    %5 = llvm.select %3, %arg1, %arg0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.select %4, %arg2, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_t17_ult_slt_vec_splat   : t17_ult_slt_vec_splat_before  ⊑  t17_ult_slt_vec_splat_combined := by
  unfold t17_ult_slt_vec_splat_before t17_ult_slt_vec_splat_combined
  simp_alive_peephole
  sorry
def t18_ult_slt_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t18_ult_slt_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[65535, 32767]> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %4 = llvm.icmp "sgt" %arg0, %2 : vector<2xi32>
    %5 = llvm.select %3, %arg1, %arg0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.select %4, %arg2, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

theorem inst_combine_t18_ult_slt_vec_nonsplat   : t18_ult_slt_vec_nonsplat_before  ⊑  t18_ult_slt_vec_nonsplat_combined := by
  unfold t18_ult_slt_vec_nonsplat_before t18_ult_slt_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t19_ult_slt_vec_poison0_combined := [llvmfunc|
  llvm.func @t19_ult_slt_vec_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(dense<65535> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<3xi32>
    %4 = llvm.icmp "sgt" %arg0, %2 : vector<3xi32>
    %5 = llvm.select %3, %arg1, %arg0 : vector<3xi1>, vector<3xi32>
    %6 = llvm.select %4, %arg2, %5 : vector<3xi1>, vector<3xi32>
    llvm.return %6 : vector<3xi32>
  }]

theorem inst_combine_t19_ult_slt_vec_poison0   : t19_ult_slt_vec_poison0_before  ⊑  t19_ult_slt_vec_poison0_combined := by
  unfold t19_ult_slt_vec_poison0_before t19_ult_slt_vec_poison0_combined
  simp_alive_peephole
  sorry
def t20_ult_slt_vec_poison1_combined := [llvmfunc|
  llvm.func @t20_ult_slt_vec_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(dense<65535> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<3xi32>
    %4 = llvm.icmp "sgt" %arg0, %2 : vector<3xi32>
    %5 = llvm.select %3, %arg1, %arg0 : vector<3xi1>, vector<3xi32>
    %6 = llvm.select %4, %arg2, %5 : vector<3xi1>, vector<3xi32>
    llvm.return %6 : vector<3xi32>
  }]

theorem inst_combine_t20_ult_slt_vec_poison1   : t20_ult_slt_vec_poison1_before  ⊑  t20_ult_slt_vec_poison1_combined := by
  unfold t20_ult_slt_vec_poison1_before t20_ult_slt_vec_poison1_combined
  simp_alive_peephole
  sorry
def t21_ult_slt_vec_poison2_combined := [llvmfunc|
  llvm.func @t21_ult_slt_vec_poison2(%arg0: vector<3xi32>, %arg1: vector<3xi32>, %arg2: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(dense<65535> : vector<3xi32>) : vector<3xi32>
    %3 = llvm.icmp "slt" %arg0, %1 : vector<3xi32>
    %4 = llvm.icmp "sgt" %arg0, %2 : vector<3xi32>
    %5 = llvm.select %3, %arg1, %arg0 : vector<3xi1>, vector<3xi32>
    %6 = llvm.select %4, %arg2, %5 : vector<3xi1>, vector<3xi32>
    llvm.return %6 : vector<3xi32>
  }]

theorem inst_combine_t21_ult_slt_vec_poison2   : t21_ult_slt_vec_poison2_before  ⊑  t21_ult_slt_vec_poison2_combined := by
  unfold t21_ult_slt_vec_poison2_before t21_ult_slt_vec_poison2_combined
  simp_alive_peephole
  sorry
def t22_pointers_combined := [llvmfunc|
  llvm.func @t22_pointers(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(65536 : i64) : i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    %2 = llvm.icmp "slt" %arg0, %1 : !llvm.ptr
    %3 = llvm.select %2, %arg1, %arg2 : i1, !llvm.ptr
    %4 = llvm.icmp "ult" %arg0, %1 : !llvm.ptr
    %5 = llvm.select %4, %arg0, %3 : i1, !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_t22_pointers   : t22_pointers_before  ⊑  t22_pointers_combined := by
  unfold t22_pointers_before t22_pointers_combined
  simp_alive_peephole
  sorry
