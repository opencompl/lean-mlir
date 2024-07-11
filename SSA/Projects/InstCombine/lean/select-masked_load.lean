import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-masked_load
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def masked_load_and_zero_inactive_1_before := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_1(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %4 = llvm.intr.masked.load %arg0, %arg1, %0 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xf32>) -> vector<4xf32>]

    %5 = llvm.select %arg1, %4, %3 : vector<4xi1>, vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def masked_load_and_zero_inactive_2_before := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_2(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %arg1, %1 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

    %4 = llvm.select %arg1, %3, %1 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def masked_load_and_zero_inactive_3_before := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_3(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.intr.masked.load %arg0, %arg1, %arg2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

    %4 = llvm.select %arg1, %3, %2 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def masked_load_and_zero_inactive_4_before := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_4(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %6 = llvm.xor %arg1, %1  : vector<4xi1>
    %7 = llvm.intr.masked.load %arg0, %6, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

    %8 = llvm.select %arg1, %5, %7 : vector<4xi1>, vector<4xi32>
    llvm.return %8 : vector<4xi32>
  }]

def masked_load_and_zero_inactive_5_before := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_5(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.xor %arg1, %1  : vector<4xi1>
    %6 = llvm.intr.masked.load %arg0, %5, %3 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

    %7 = llvm.select %arg1, %3, %6 : vector<4xi1>, vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def masked_load_and_zero_inactive_6_before := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_6(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %5 = llvm.xor %arg1, %1  : vector<4xi1>
    %6 = llvm.intr.masked.load %arg0, %5, %arg2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

    %7 = llvm.select %arg1, %4, %6 : vector<4xi1>, vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

def masked_load_and_zero_inactive_7_before := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_7(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %arg1, %1 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

    %4 = llvm.select %arg2, %1, %3 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

def masked_load_and_zero_inactive_8_before := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_8(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %6 = llvm.xor %arg1, %1  : vector<4xi1>
    %7 = llvm.and %6, %arg2  : vector<4xi1>
    %8 = llvm.intr.masked.load %arg0, %7, %2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xf32>) -> vector<4xf32>]

    %9 = llvm.select %arg1, %5, %8 : vector<4xi1>, vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }]

def masked_load_and_scalar_select_cond_before := [llvmfunc|
  llvm.func @masked_load_and_scalar_select_cond(%arg0: !llvm.ptr, %arg1: vector<8xi1>, %arg2: i1) -> vector<8xf32> {
    %0 = llvm.mlir.undef : vector<8xf32>
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %4 = llvm.intr.masked.load %arg0, %arg1, %0 {alignment = 32 : i32} : (!llvm.ptr, vector<8xi1>, vector<8xf32>) -> vector<8xf32>]

    %5 = llvm.select %arg2, %3, %4 : i1, vector<8xf32>
    llvm.return %5 : vector<8xf32>
  }]

def masked_load_and_zero_inactive_1_combined := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_1(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %arg1, %1 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xf32>) -> vector<4xf32>]

theorem inst_combine_masked_load_and_zero_inactive_1   : masked_load_and_zero_inactive_1_before  ⊑  masked_load_and_zero_inactive_1_combined := by
  unfold masked_load_and_zero_inactive_1_before masked_load_and_zero_inactive_1_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_masked_load_and_zero_inactive_1   : masked_load_and_zero_inactive_1_before  ⊑  masked_load_and_zero_inactive_1_combined := by
  unfold masked_load_and_zero_inactive_1_before masked_load_and_zero_inactive_1_combined
  simp_alive_peephole
  sorry
def masked_load_and_zero_inactive_2_combined := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_2(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %arg1, %1 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_masked_load_and_zero_inactive_2   : masked_load_and_zero_inactive_2_before  ⊑  masked_load_and_zero_inactive_2_combined := by
  unfold masked_load_and_zero_inactive_2_before masked_load_and_zero_inactive_2_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : vector<4xi32>
  }]

theorem inst_combine_masked_load_and_zero_inactive_2   : masked_load_and_zero_inactive_2_before  ⊑  masked_load_and_zero_inactive_2_combined := by
  unfold masked_load_and_zero_inactive_2_before masked_load_and_zero_inactive_2_combined
  simp_alive_peephole
  sorry
def masked_load_and_zero_inactive_3_combined := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_3(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.intr.masked.load %arg0, %arg1, %arg2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_masked_load_and_zero_inactive_3   : masked_load_and_zero_inactive_3_before  ⊑  masked_load_and_zero_inactive_3_combined := by
  unfold masked_load_and_zero_inactive_3_before masked_load_and_zero_inactive_3_combined
  simp_alive_peephole
  sorry
    %4 = llvm.select %arg1, %3, %2 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_masked_load_and_zero_inactive_3   : masked_load_and_zero_inactive_3_before  ⊑  masked_load_and_zero_inactive_3_combined := by
  unfold masked_load_and_zero_inactive_3_before masked_load_and_zero_inactive_3_combined
  simp_alive_peephole
  sorry
def masked_load_and_zero_inactive_4_combined := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_4(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.xor %arg1, %1  : vector<4xi1>
    %6 = llvm.intr.masked.load %arg0, %5, %3 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_masked_load_and_zero_inactive_4   : masked_load_and_zero_inactive_4_before  ⊑  masked_load_and_zero_inactive_4_combined := by
  unfold masked_load_and_zero_inactive_4_before masked_load_and_zero_inactive_4_combined
  simp_alive_peephole
  sorry
    llvm.return %6 : vector<4xi32>
  }]

theorem inst_combine_masked_load_and_zero_inactive_4   : masked_load_and_zero_inactive_4_before  ⊑  masked_load_and_zero_inactive_4_combined := by
  unfold masked_load_and_zero_inactive_4_before masked_load_and_zero_inactive_4_combined
  simp_alive_peephole
  sorry
def masked_load_and_zero_inactive_5_combined := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_5(%arg0: !llvm.ptr, %arg1: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.xor %arg1, %1  : vector<4xi1>
    %6 = llvm.intr.masked.load %arg0, %5, %3 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_masked_load_and_zero_inactive_5   : masked_load_and_zero_inactive_5_before  ⊑  masked_load_and_zero_inactive_5_combined := by
  unfold masked_load_and_zero_inactive_5_before masked_load_and_zero_inactive_5_combined
  simp_alive_peephole
  sorry
    llvm.return %6 : vector<4xi32>
  }]

theorem inst_combine_masked_load_and_zero_inactive_5   : masked_load_and_zero_inactive_5_before  ⊑  masked_load_and_zero_inactive_5_combined := by
  unfold masked_load_and_zero_inactive_5_before masked_load_and_zero_inactive_5_combined
  simp_alive_peephole
  sorry
def masked_load_and_zero_inactive_6_combined := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_6(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %5 = llvm.xor %arg1, %1  : vector<4xi1>
    %6 = llvm.intr.masked.load %arg0, %5, %arg2 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_masked_load_and_zero_inactive_6   : masked_load_and_zero_inactive_6_before  ⊑  masked_load_and_zero_inactive_6_combined := by
  unfold masked_load_and_zero_inactive_6_before masked_load_and_zero_inactive_6_combined
  simp_alive_peephole
  sorry
    %7 = llvm.select %arg1, %4, %6 : vector<4xi1>, vector<4xi32>
    llvm.return %7 : vector<4xi32>
  }]

theorem inst_combine_masked_load_and_zero_inactive_6   : masked_load_and_zero_inactive_6_before  ⊑  masked_load_and_zero_inactive_6_combined := by
  unfold masked_load_and_zero_inactive_6_before masked_load_and_zero_inactive_6_combined
  simp_alive_peephole
  sorry
def masked_load_and_zero_inactive_7_combined := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_7(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %arg1, %1 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xi32>) -> vector<4xi32>]

theorem inst_combine_masked_load_and_zero_inactive_7   : masked_load_and_zero_inactive_7_before  ⊑  masked_load_and_zero_inactive_7_combined := by
  unfold masked_load_and_zero_inactive_7_before masked_load_and_zero_inactive_7_combined
  simp_alive_peephole
  sorry
    %4 = llvm.select %arg2, %1, %3 : vector<4xi1>, vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }]

theorem inst_combine_masked_load_and_zero_inactive_7   : masked_load_and_zero_inactive_7_before  ⊑  masked_load_and_zero_inactive_7_combined := by
  unfold masked_load_and_zero_inactive_7_before masked_load_and_zero_inactive_7_combined
  simp_alive_peephole
  sorry
def masked_load_and_zero_inactive_8_combined := [llvmfunc|
  llvm.func @masked_load_and_zero_inactive_8(%arg0: !llvm.ptr, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.xor %arg1, %1  : vector<4xi1>
    %6 = llvm.and %5, %arg2  : vector<4xi1>
    %7 = llvm.intr.masked.load %arg0, %6, %3 {alignment = 4 : i32} : (!llvm.ptr, vector<4xi1>, vector<4xf32>) -> vector<4xf32>]

theorem inst_combine_masked_load_and_zero_inactive_8   : masked_load_and_zero_inactive_8_before  ⊑  masked_load_and_zero_inactive_8_combined := by
  unfold masked_load_and_zero_inactive_8_before masked_load_and_zero_inactive_8_combined
  simp_alive_peephole
  sorry
    llvm.return %7 : vector<4xf32>
  }]

theorem inst_combine_masked_load_and_zero_inactive_8   : masked_load_and_zero_inactive_8_before  ⊑  masked_load_and_zero_inactive_8_combined := by
  unfold masked_load_and_zero_inactive_8_before masked_load_and_zero_inactive_8_combined
  simp_alive_peephole
  sorry
def masked_load_and_scalar_select_cond_combined := [llvmfunc|
  llvm.func @masked_load_and_scalar_select_cond(%arg0: !llvm.ptr, %arg1: vector<8xi1>, %arg2: i1) -> vector<8xf32> {
    %0 = llvm.mlir.undef : vector<8xf32>
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<8xf32>) : vector<8xf32>
    %4 = llvm.intr.masked.load %arg0, %arg1, %0 {alignment = 32 : i32} : (!llvm.ptr, vector<8xi1>, vector<8xf32>) -> vector<8xf32>]

theorem inst_combine_masked_load_and_scalar_select_cond   : masked_load_and_scalar_select_cond_before  ⊑  masked_load_and_scalar_select_cond_combined := by
  unfold masked_load_and_scalar_select_cond_before masked_load_and_scalar_select_cond_combined
  simp_alive_peephole
  sorry
    %5 = llvm.select %arg2, %3, %4 : i1, vector<8xf32>
    llvm.return %5 : vector<8xf32>
  }]

theorem inst_combine_masked_load_and_scalar_select_cond   : masked_load_and_scalar_select_cond_before  ⊑  masked_load_and_scalar_select_cond_combined := by
  unfold masked_load_and_scalar_select_cond_before masked_load_and_scalar_select_cond_combined
  simp_alive_peephole
  sorry
