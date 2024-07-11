import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  broadcast-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def good1_before := [llvmfunc|
  llvm.func @good1(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }]

def good2_before := [llvmfunc|
  llvm.func @good2(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }]

def good3_before := [llvmfunc|
  llvm.func @good3(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.insertelement %arg0, %1[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg0, %8[%5 : i32] : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }]

def good4_before := [llvmfunc|
  llvm.func @good4(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.insertelement %arg0, %1[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg0, %8[%5 : i32] : vector<4xf32>
    %10 = llvm.fadd %9, %9  : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }]

def good5_before := [llvmfunc|
  llvm.func @good5(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.fadd %5, %5  : vector<4xf32>
    %7 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg0, %8[%4 : i32] : vector<4xf32>
    %10 = llvm.fadd %6, %9  : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }]

def splat_undef1_before := [llvmfunc|
  llvm.func @splat_undef1(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg0, %4[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    llvm.return %7 : vector<4xf32>
  }]

def splat_undef2_before := [llvmfunc|
  llvm.func @splat_undef2(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%3 : i32] : vector<4xf32>
    llvm.return %6 : vector<4xf32>
  }]

def bad3_before := [llvmfunc|
  llvm.func @bad3(%arg0: f32, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }]

def bad4_before := [llvmfunc|
  llvm.func @bad4(%arg0: f32) -> vector<1xf32> {
    %0 = llvm.mlir.poison : vector<1xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<1xf32>
    llvm.return %2 : vector<1xf32>
  }]

def splat_undef3_before := [llvmfunc|
  llvm.func @splat_undef3(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i32] : vector<4xf32>
    %9 = llvm.fadd %8, %6  : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }]

def bad6_before := [llvmfunc|
  llvm.func @bad6(%arg0: f32, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%arg1 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i32] : vector<4xf32>
    llvm.return %7 : vector<4xf32>
  }]

def bad7_before := [llvmfunc|
  llvm.func @bad7(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %6 = llvm.fadd %5, %5  : vector<4xf32>
    %7 = llvm.insertelement %arg0, %5[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg0, %8[%4 : i32] : vector<4xf32>
    %10 = llvm.fadd %6, %9  : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }]

def good1_combined := [llvmfunc|
  llvm.func @good1(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0, 0, 0] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_good1   : good1_before  ⊑  good1_combined := by
  unfold good1_before good1_combined
  simp_alive_peephole
  sorry
def good2_combined := [llvmfunc|
  llvm.func @good2(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0, 0, 0] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_good2   : good2_before  ⊑  good2_combined := by
  unfold good2_before good2_combined
  simp_alive_peephole
  sorry
def good3_combined := [llvmfunc|
  llvm.func @good3(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0, 0, 0] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_good3   : good3_before  ⊑  good3_combined := by
  unfold good3_before good3_combined
  simp_alive_peephole
  sorry
def good4_combined := [llvmfunc|
  llvm.func @good4(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.fadd %2, %2  : vector<4xf32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_good4   : good4_before  ⊑  good4_combined := by
  unfold good4_before good4_combined
  simp_alive_peephole
  sorry
def good5_combined := [llvmfunc|
  llvm.func @good5(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.fadd %2, %2  : vector<4xf32>
    %4 = llvm.shufflevector %2, %0 [0, 0, 0, 0] : vector<4xf32> 
    %5 = llvm.fadd %3, %4  : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

theorem inst_combine_good5   : good5_before  ⊑  good5_combined := by
  unfold good5_before good5_combined
  simp_alive_peephole
  sorry
def splat_undef1_combined := [llvmfunc|
  llvm.func @splat_undef1(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [-1, 0, 0, 0] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_splat_undef1   : splat_undef1_before  ⊑  splat_undef1_combined := by
  unfold splat_undef1_before splat_undef1_combined
  simp_alive_peephole
  sorry
def splat_undef2_combined := [llvmfunc|
  llvm.func @splat_undef2(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [0, -1, 0, 0] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_splat_undef2   : splat_undef2_before  ⊑  splat_undef2_combined := by
  unfold splat_undef2_before splat_undef2_combined
  simp_alive_peephole
  sorry
def bad3_combined := [llvmfunc|
  llvm.func @bad3(%arg0: f32, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %6 = llvm.insertelement %arg1, %5[%2 : i64] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i64] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%4 : i64] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }]

theorem inst_combine_bad3   : bad3_before  ⊑  bad3_combined := by
  unfold bad3_before bad3_combined
  simp_alive_peephole
  sorry
def bad4_combined := [llvmfunc|
  llvm.func @bad4(%arg0: f32) -> vector<1xf32> {
    %0 = llvm.mlir.poison : vector<1xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<1xf32>
    llvm.return %2 : vector<1xf32>
  }]

theorem inst_combine_bad4   : bad4_before  ⊑  bad4_combined := by
  unfold bad4_before bad4_combined
  simp_alive_peephole
  sorry
def splat_undef3_combined := [llvmfunc|
  llvm.func @splat_undef3(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [0, 0, -1, -1] : vector<4xf32> 
    %4 = llvm.shufflevector %2, %0 [0, 0, 0, 0] : vector<4xf32> 
    %5 = llvm.fadd %4, %3  : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

theorem inst_combine_splat_undef3   : splat_undef3_before  ⊑  splat_undef3_combined := by
  unfold splat_undef3_before splat_undef3_combined
  simp_alive_peephole
  sorry
def bad6_combined := [llvmfunc|
  llvm.func @bad6(%arg0: f32, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %5 = llvm.insertelement %arg0, %4[%2 : i64] : vector<4xf32>
    %6 = llvm.insertelement %arg0, %5[%arg1 : i32] : vector<4xf32>
    %7 = llvm.insertelement %arg0, %6[%3 : i64] : vector<4xf32>
    llvm.return %7 : vector<4xf32>
  }]

theorem inst_combine_bad6   : bad6_before  ⊑  bad6_combined := by
  unfold bad6_before bad6_combined
  simp_alive_peephole
  sorry
def bad7_combined := [llvmfunc|
  llvm.func @bad7(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.mlir.constant(3 : i64) : i64
    %5 = llvm.insertelement %arg0, %0[%1 : i64] : vector<4xf32>
    %6 = llvm.fadd %5, %5  : vector<4xf32>
    %7 = llvm.insertelement %arg0, %5[%2 : i64] : vector<4xf32>
    %8 = llvm.insertelement %arg0, %7[%3 : i64] : vector<4xf32>
    %9 = llvm.insertelement %arg0, %8[%4 : i64] : vector<4xf32>
    %10 = llvm.fadd %6, %9  : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }]

theorem inst_combine_bad7   : bad7_before  ⊑  bad7_combined := by
  unfold bad7_before bad7_combined
  simp_alive_peephole
  sorry
