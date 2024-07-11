import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-amount-reassociation-with-truncation-lshr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    %7 = llvm.lshr %5, %6  : i16
    llvm.return %7 : i16
  }]

def t1_vec_splat_before := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.sub %0, %arg1  : vector<2xi16>
    %3 = llvm.zext %2 : vector<2xi16> to vector<2xi32>
    %4 = llvm.lshr %arg0, %3  : vector<2xi32>
    %5 = llvm.trunc %4 : vector<2xi32> to vector<2xi16>
    %6 = llvm.add %arg1, %1  : vector<2xi16>
    %7 = llvm.lshr %5, %6  : vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }]

def t3_vec_nonsplat_poison0_before := [llvmfunc|
  llvm.func @t3_vec_nonsplat_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(dense<-1> : vector<3xi16>) : vector<3xi16>
    %10 = llvm.sub %8, %arg1  : vector<3xi16>
    %11 = llvm.zext %10 : vector<3xi16> to vector<3xi32>
    %12 = llvm.lshr %arg0, %11  : vector<3xi32>
    %13 = llvm.trunc %12 : vector<3xi32> to vector<3xi16>
    %14 = llvm.add %arg1, %9  : vector<3xi16>
    %15 = llvm.lshr %13, %14  : vector<3xi16>
    llvm.return %15 : vector<3xi16>
  }]

def t4_vec_nonsplat_poison1_before := [llvmfunc|
  llvm.func @t4_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(dense<32> : vector<3xi16>) : vector<3xi16>
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.mlir.poison : i16
    %3 = llvm.mlir.undef : vector<3xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi16>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi16>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi16>
    %10 = llvm.sub %0, %arg1  : vector<3xi16>
    %11 = llvm.zext %10 : vector<3xi16> to vector<3xi32>
    %12 = llvm.lshr %arg0, %11  : vector<3xi32>
    %13 = llvm.trunc %12 : vector<3xi32> to vector<3xi16>
    %14 = llvm.add %arg1, %9  : vector<3xi16>
    %15 = llvm.lshr %13, %14  : vector<3xi16>
    llvm.return %15 : vector<3xi16>
  }]

def t5_vec_nonsplat_poison1_before := [llvmfunc|
  llvm.func @t5_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.poison : i16
    %2 = llvm.mlir.undef : vector<3xi16>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi16>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi16>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi16>
    %9 = llvm.mlir.constant(-1 : i16) : i16
    %10 = llvm.mlir.undef : vector<3xi16>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi16>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi16>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi16>
    %17 = llvm.sub %8, %arg1  : vector<3xi16>
    %18 = llvm.zext %17 : vector<3xi16> to vector<3xi32>
    %19 = llvm.lshr %arg0, %18  : vector<3xi32>
    %20 = llvm.trunc %19 : vector<3xi32> to vector<3xi16>
    %21 = llvm.add %arg1, %16  : vector<3xi16>
    %22 = llvm.lshr %20, %21  : vector<3xi16>
    llvm.return %22 : vector<3xi16>
  }]

def t6_extrause0_before := [llvmfunc|
  llvm.func @t6_extrause0(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    llvm.call @use16(%5) : (i16) -> ()
    %7 = llvm.lshr %5, %6  : i16
    llvm.return %7 : i16
  }]

def t7_extrause1_before := [llvmfunc|
  llvm.func @t7_extrause1(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    llvm.call @use16(%6) : (i16) -> ()
    %7 = llvm.lshr %5, %6  : i16
    llvm.return %7 : i16
  }]

def t8_extrause2_before := [llvmfunc|
  llvm.func @t8_extrause2(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    llvm.call @use16(%5) : (i16) -> ()
    llvm.call @use16(%6) : (i16) -> ()
    %7 = llvm.lshr %5, %6  : i16
    llvm.return %7 : i16
  }]

def t9_lshr_before := [llvmfunc|
  llvm.func @t9_lshr(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-2 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    %7 = llvm.lshr %5, %6  : i16
    llvm.return %7 : i16
  }]

def n10_ashr_lshr_before := [llvmfunc|
  llvm.func @n10_ashr_lshr(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    %7 = llvm.lshr %5, %6  : i16
    llvm.return %7 : i16
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.trunc %1 : i32 to i16
    llvm.return %2 : i16
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_vec_splat_combined := [llvmfunc|
  llvm.func @t1_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi16>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.trunc %1 : vector<2xi32> to vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }]

theorem inst_combine_t1_vec_splat   : t1_vec_splat_before  ⊑  t1_vec_splat_combined := by
  unfold t1_vec_splat_before t1_vec_splat_combined
  simp_alive_peephole
  sorry
def t3_vec_nonsplat_poison0_combined := [llvmfunc|
  llvm.func @t3_vec_nonsplat_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.lshr %arg0, %8  : vector<3xi32>
    %10 = llvm.trunc %9 : vector<3xi32> to vector<3xi16>
    llvm.return %10 : vector<3xi16>
  }]

theorem inst_combine_t3_vec_nonsplat_poison0   : t3_vec_nonsplat_poison0_before  ⊑  t3_vec_nonsplat_poison0_combined := by
  unfold t3_vec_nonsplat_poison0_before t3_vec_nonsplat_poison0_combined
  simp_alive_peephole
  sorry
def t4_vec_nonsplat_poison1_combined := [llvmfunc|
  llvm.func @t4_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.lshr %arg0, %8  : vector<3xi32>
    %10 = llvm.trunc %9 : vector<3xi32> to vector<3xi16>
    llvm.return %10 : vector<3xi16>
  }]

theorem inst_combine_t4_vec_nonsplat_poison1   : t4_vec_nonsplat_poison1_before  ⊑  t4_vec_nonsplat_poison1_combined := by
  unfold t4_vec_nonsplat_poison1_before t4_vec_nonsplat_poison1_combined
  simp_alive_peephole
  sorry
def t5_vec_nonsplat_poison1_combined := [llvmfunc|
  llvm.func @t5_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi16>) -> vector<3xi16> {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.lshr %arg0, %8  : vector<3xi32>
    %10 = llvm.trunc %9 : vector<3xi32> to vector<3xi16>
    llvm.return %10 : vector<3xi16>
  }]

theorem inst_combine_t5_vec_nonsplat_poison1   : t5_vec_nonsplat_poison1_before  ⊑  t5_vec_nonsplat_poison1_combined := by
  unfold t5_vec_nonsplat_poison1_before t5_vec_nonsplat_poison1_combined
  simp_alive_peephole
  sorry
def t6_extrause0_combined := [llvmfunc|
  llvm.func @t6_extrause0(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.call @use16(%5) : (i16) -> ()
    %6 = llvm.lshr %arg0, %1  : i32
    %7 = llvm.trunc %6 : i32 to i16
    llvm.return %7 : i16
  }]

theorem inst_combine_t6_extrause0   : t6_extrause0_before  ⊑  t6_extrause0_combined := by
  unfold t6_extrause0_before t6_extrause0_combined
  simp_alive_peephole
  sorry
def t7_extrause1_combined := [llvmfunc|
  llvm.func @t7_extrause1(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-1 : i16) : i16
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.add %arg1, %0  : i16
    llvm.call @use16(%2) : (i16) -> ()
    %3 = llvm.lshr %arg0, %1  : i32
    %4 = llvm.trunc %3 : i32 to i16
    llvm.return %4 : i16
  }]

theorem inst_combine_t7_extrause1   : t7_extrause1_before  ⊑  t7_extrause1_combined := by
  unfold t7_extrause1_before t7_extrause1_combined
  simp_alive_peephole
  sorry
def t8_extrause2_combined := [llvmfunc|
  llvm.func @t8_extrause2(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    llvm.call @use16(%5) : (i16) -> ()
    llvm.call @use16(%6) : (i16) -> ()
    %7 = llvm.lshr %5, %6  : i16
    llvm.return %7 : i16
  }]

theorem inst_combine_t8_extrause2   : t8_extrause2_before  ⊑  t8_extrause2_combined := by
  unfold t8_extrause2_before t8_extrause2_combined
  simp_alive_peephole
  sorry
def t9_lshr_combined := [llvmfunc|
  llvm.func @t9_lshr(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-2 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.lshr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    %7 = llvm.lshr %5, %6  : i16
    llvm.return %7 : i16
  }]

theorem inst_combine_t9_lshr   : t9_lshr_before  ⊑  t9_lshr_combined := by
  unfold t9_lshr_before t9_lshr_combined
  simp_alive_peephole
  sorry
def n10_ashr_lshr_combined := [llvmfunc|
  llvm.func @n10_ashr_lshr(%arg0: i32, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.sub %0, %arg1  : i16
    %3 = llvm.zext %2 : i16 to i32
    %4 = llvm.ashr %arg0, %3  : i32
    %5 = llvm.trunc %4 : i32 to i16
    %6 = llvm.add %arg1, %1  : i16
    %7 = llvm.lshr %5, %6  : i16
    llvm.return %7 : i16
  }]

theorem inst_combine_n10_ashr_lshr   : n10_ashr_lshr_before  ⊑  n10_ashr_lshr_combined := by
  unfold n10_ashr_lshr_before n10_ashr_lshr_combined
  simp_alive_peephole
  sorry
