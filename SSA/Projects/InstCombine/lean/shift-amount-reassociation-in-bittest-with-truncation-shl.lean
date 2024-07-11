import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-amount-reassociation-in-bittest-with-truncation-shl
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_const_after_fold_lshr_shl_ne_before := [llvmfunc|
  llvm.func @t0_const_after_fold_lshr_shl_ne(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.shl %arg1, %6  : i64
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t1_vec_splat_before := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.lshr %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }]

def t2_vec_nonsplat_before := [llvmfunc|
  llvm.func @t2_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[30, 32]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[1, -2]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.sub %0, %arg2  : vector<2xi32>
    %5 = llvm.lshr %arg0, %4  : vector<2xi32>
    %6 = llvm.add %arg2, %1  : vector<2xi32>
    %7 = llvm.zext %6 : vector<2xi32> to vector<2xi64>
    %8 = llvm.shl %arg1, %7  : vector<2xi64>
    %9 = llvm.trunc %8 : vector<2xi64> to vector<2xi32>
    %10 = llvm.and %5, %9  : vector<2xi32>
    %11 = llvm.icmp "ne" %10, %3 : vector<2xi32>
    llvm.return %11 : vector<2xi1>
  }]

def t3_oneuse0_before := [llvmfunc|
  llvm.func @t3_oneuse0(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t4_oneuse1_before := [llvmfunc|
  llvm.func @t4_oneuse1(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t5_oneuse2_before := [llvmfunc|
  llvm.func @t5_oneuse2(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t6_oneuse3_before := [llvmfunc|
  llvm.func @t6_oneuse3(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t7_oneuse4_before := [llvmfunc|
  llvm.func @t7_oneuse4(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def t8_oneuse5_before := [llvmfunc|
  llvm.func @t8_oneuse5(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-52543054 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %1, %4  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.add %arg2, %2  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.zext %6 : i32 to i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.shl %arg1, %7  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def t9_oneuse5_before := [llvmfunc|
  llvm.func @t9_oneuse5(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(4242424242 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %arg0, %4  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.zext %6 : i32 to i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.shl %2, %7  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.and %5, %9  : i32
    %11 = llvm.icmp "ne" %10, %3 : i32
    llvm.return %11 : i1
  }]

def t10_constants_before := [llvmfunc|
  llvm.func @t10_constants(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(14 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.shl %arg1, %1  : i64
    %5 = llvm.trunc %4 : i64 to i32
    %6 = llvm.and %3, %5  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.return %7 : i1
  }]

def t11_constants_vec_splat_before := [llvmfunc|
  llvm.func @t11_constants_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<14> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg1, %1  : vector<2xi64>
    %6 = llvm.trunc %5 : vector<2xi64> to vector<2xi32>
    %7 = llvm.and %4, %6  : vector<2xi32>
    %8 = llvm.icmp "ne" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }]

def t12_constants_vec_nonsplat_before := [llvmfunc|
  llvm.func @t12_constants_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[12, 14]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[16, 14]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.shl %arg1, %1  : vector<2xi64>
    %6 = llvm.trunc %5 : vector<2xi64> to vector<2xi32>
    %7 = llvm.and %4, %6  : vector<2xi32>
    %8 = llvm.icmp "ne" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }]

def n13_overshift_before := [llvmfunc|
  llvm.func @n13_overshift(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %0, %arg2  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg2, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %arg1, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.and %3, %7  : i32
    %9 = llvm.icmp "ne" %8, %1 : i32
    llvm.return %9 : i1
  }]

def n14_trunc_of_lshr_before := [llvmfunc|
  llvm.func @n14_trunc_of_lshr(%arg0: i64, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.add %arg2, %1  : i32
    %8 = llvm.shl %arg1, %7  : i32
    %9 = llvm.and %6, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

def n15_variable_shamts_before := [llvmfunc|
  llvm.func @n15_variable_shamts(%arg0: i32, %arg1: i64, %arg2: i32, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.and %3, %1  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    llvm.return %5 : i1
  }]

def t0_const_after_fold_lshr_shl_ne_combined := [llvmfunc|
  llvm.func @t0_const_after_fold_lshr_shl_ne(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.and %3, %arg1  : i64
    %5 = llvm.icmp "ne" %4, %1 : i64
    llvm.return %5 : i1
  }]

theorem inst_combine_t0_const_after_fold_lshr_shl_ne   : t0_const_after_fold_lshr_shl_ne_before  ⊑  t0_const_after_fold_lshr_shl_ne_combined := by
  unfold t0_const_after_fold_lshr_shl_ne_before t0_const_after_fold_lshr_shl_ne_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_combined := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.lshr %arg0, %0  : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    %5 = llvm.and %4, %arg1  : vector<2xi64>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi64>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_t1_vec_splat   : t1_vec_splat_before  ⊑  t1_vec_splat_combined := by
  unfold t1_vec_splat_before t1_vec_splat_combined
  simp_alive_peephole
  sorry
def t2_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t2_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi64>, %arg2: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[31, 30]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %4 = llvm.lshr %3, %0  : vector<2xi64>
    %5 = llvm.and %4, %arg1  : vector<2xi64>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi64>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_t2_vec_nonsplat   : t2_vec_nonsplat_before  ⊑  t2_vec_nonsplat_combined := by
  unfold t2_vec_nonsplat_before t2_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def t3_oneuse0_combined := [llvmfunc|
  llvm.func @t3_oneuse0(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    llvm.call @use32(%9) : (i32) -> ()
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

theorem inst_combine_t3_oneuse0   : t3_oneuse0_before  ⊑  t3_oneuse0_combined := by
  unfold t3_oneuse0_before t3_oneuse0_combined
  simp_alive_peephole
  sorry
def t4_oneuse1_combined := [llvmfunc|
  llvm.func @t4_oneuse1(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

theorem inst_combine_t4_oneuse1   : t4_oneuse1_before  ⊑  t4_oneuse1_combined := by
  unfold t4_oneuse1_before t4_oneuse1_combined
  simp_alive_peephole
  sorry
def t5_oneuse2_combined := [llvmfunc|
  llvm.func @t5_oneuse2(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.trunc %7 : i64 to i32
    llvm.call @use32(%8) : (i32) -> ()
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

theorem inst_combine_t5_oneuse2   : t5_oneuse2_before  ⊑  t5_oneuse2_combined := by
  unfold t5_oneuse2_before t5_oneuse2_combined
  simp_alive_peephole
  sorry
def t6_oneuse3_combined := [llvmfunc|
  llvm.func @t6_oneuse3(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(31 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.zext %5 : i32 to i64
    llvm.call @use64(%6) : (i64) -> ()
    %7 = llvm.shl %arg1, %6  : i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.lshr %arg0, %2  : i32
    %9 = llvm.zext %8 : i32 to i64
    %10 = llvm.and %9, %arg1  : i64
    %11 = llvm.icmp "ne" %10, %3 : i64
    llvm.return %11 : i1
  }]

theorem inst_combine_t6_oneuse3   : t6_oneuse3_before  ⊑  t6_oneuse3_combined := by
  unfold t6_oneuse3_before t6_oneuse3_combined
  simp_alive_peephole
  sorry
def t7_oneuse4_combined := [llvmfunc|
  llvm.func @t7_oneuse4(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.add %arg2, %0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.zext %3 : i32 to i64
    llvm.call @use64(%4) : (i64) -> ()
    %5 = llvm.shl %arg1, %4  : i64
    llvm.call @use64(%5) : (i64) -> ()
    %6 = llvm.trunc %5 : i64 to i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.lshr %arg0, %1  : i32
    %8 = llvm.zext %7 : i32 to i64
    %9 = llvm.and %8, %arg1  : i64
    %10 = llvm.icmp "ne" %9, %2 : i64
    llvm.return %10 : i1
  }]

theorem inst_combine_t7_oneuse4   : t7_oneuse4_before  ⊑  t7_oneuse4_combined := by
  unfold t7_oneuse4_before t7_oneuse4_combined
  simp_alive_peephole
  sorry
def t8_oneuse5_combined := [llvmfunc|
  llvm.func @t8_oneuse5(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-52543054 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.lshr %1, %5  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.add %arg2, %2  : i32
    llvm.call @use32(%7) : (i32) -> ()
    %8 = llvm.zext %7 : i32 to i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.shl %arg1, %8  : i64
    llvm.call @use64(%9) : (i64) -> ()
    %10 = llvm.trunc %9 : i64 to i32
    llvm.call @use32(%10) : (i32) -> ()
    %11 = llvm.and %arg1, %3  : i64
    %12 = llvm.icmp "ne" %11, %4 : i64
    llvm.return %12 : i1
  }]

theorem inst_combine_t8_oneuse5   : t8_oneuse5_before  ⊑  t8_oneuse5_combined := by
  unfold t8_oneuse5_before t8_oneuse5_combined
  simp_alive_peephole
  sorry
def t9_oneuse5_combined := [llvmfunc|
  llvm.func @t9_oneuse5(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(4242424242 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.sub %0, %arg2  : i32
    llvm.call @use32(%4) : (i32) -> ()
    %5 = llvm.lshr %arg0, %4  : i32
    llvm.call @use32(%5) : (i32) -> ()
    %6 = llvm.add %arg2, %1  : i32
    llvm.call @use32(%6) : (i32) -> ()
    %7 = llvm.zext %6 : i32 to i64
    llvm.call @use64(%7) : (i64) -> ()
    %8 = llvm.shl %2, %7  : i64
    llvm.call @use64(%8) : (i64) -> ()
    %9 = llvm.trunc %8 : i64 to i32
    llvm.call @use32(%9) : (i32) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_t9_oneuse5   : t9_oneuse5_before  ⊑  t9_oneuse5_combined := by
  unfold t9_oneuse5_before t9_oneuse5_combined
  simp_alive_peephole
  sorry
def t10_constants_combined := [llvmfunc|
  llvm.func @t10_constants(%arg0: i32, %arg1: i64) -> i1 {
    %0 = llvm.mlir.constant(26 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.trunc %arg1 : i64 to i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_t10_constants   : t10_constants_before  ⊑  t10_constants_combined := by
  unfold t10_constants_before t10_constants_combined
  simp_alive_peephole
  sorry
def t11_constants_vec_splat_combined := [llvmfunc|
  llvm.func @t11_constants_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<26> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_t11_constants_vec_splat   : t11_constants_vec_splat_before  ⊑  t11_constants_vec_splat_combined := by
  unfold t11_constants_vec_splat_before t11_constants_vec_splat_combined
  simp_alive_peephole
  sorry
def t12_constants_vec_nonsplat_combined := [llvmfunc|
  llvm.func @t12_constants_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<28> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.trunc %arg1 : vector<2xi64> to vector<2xi32>
    %4 = llvm.lshr %arg0, %0  : vector<2xi32>
    %5 = llvm.and %4, %3  : vector<2xi32>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_t12_constants_vec_nonsplat   : t12_constants_vec_nonsplat_before  ⊑  t12_constants_vec_nonsplat_combined := by
  unfold t12_constants_vec_nonsplat_before t12_constants_vec_nonsplat_combined
  simp_alive_peephole
  sorry
def n13_overshift_combined := [llvmfunc|
  llvm.func @n13_overshift(%arg0: i32, %arg1: i64, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.sub %0, %arg2  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg2, %0  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.shl %arg1, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.and %3, %7  : i32
    %9 = llvm.icmp "ne" %8, %1 : i32
    llvm.return %9 : i1
  }]

theorem inst_combine_n13_overshift   : n13_overshift_before  ⊑  n13_overshift_combined := by
  unfold n13_overshift_before n13_overshift_combined
  simp_alive_peephole
  sorry
def n14_trunc_of_lshr_combined := [llvmfunc|
  llvm.func @n14_trunc_of_lshr(%arg0: i64, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.lshr %arg0, %4  : i64
    %6 = llvm.trunc %5 : i64 to i32
    %7 = llvm.add %arg2, %1  : i32
    %8 = llvm.shl %arg1, %7  : i32
    %9 = llvm.and %8, %6  : i32
    %10 = llvm.icmp "ne" %9, %2 : i32
    llvm.return %10 : i1
  }]

theorem inst_combine_n14_trunc_of_lshr   : n14_trunc_of_lshr_before  ⊑  n14_trunc_of_lshr_combined := by
  unfold n14_trunc_of_lshr_before n14_trunc_of_lshr_combined
  simp_alive_peephole
  sorry
def n15_variable_shamts_combined := [llvmfunc|
  llvm.func @n15_variable_shamts(%arg0: i32, %arg1: i64, %arg2: i32, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg2  : i32
    %2 = llvm.shl %arg1, %arg3  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_n15_variable_shamts   : n15_variable_shamts_before  ⊑  n15_variable_shamts_combined := by
  unfold n15_variable_shamts_before n15_variable_shamts_combined
  simp_alive_peephole
  sorry
