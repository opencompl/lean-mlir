import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  insert-const-shuf
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR29126_before := [llvmfunc|
  llvm.func @PR29126(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<4xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<4xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %13 = llvm.mlir.constant(3 : i32) : i32
    %14 = llvm.shufflevector %arg0, %11 [0, 5, 6, 3] : vector<4xf32> 
    %15 = llvm.insertelement %12, %14[%13 : i32] : vector<4xf32>
    llvm.return %15 : vector<4xf32>
  }]

def twoInserts_before := [llvmfunc|
  llvm.func @twoInserts(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1.100000e+01 : f32) : f32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.shufflevector %arg0, %1 [0, 5, 6, 3] : vector<4xf32> 
    %7 = llvm.insertelement %2, %6[%3 : i32] : vector<4xf32>
    %8 = llvm.insertelement %4, %7[%5 : i32] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }]

def shuffleRetain_before := [llvmfunc|
  llvm.func @shuffleRetain(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[4, 3, 2, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shufflevector %arg0, %0 [1, 2, -1, 7] : vector<4xi32> 
    llvm.return %1 : vector<4xi32>
  }]

def disguisedSelect_before := [llvmfunc|
  llvm.func @disguisedSelect(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<4xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf32>
    %13 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.shufflevector %arg0, %12 [7, 6, 5, 3] : vector<4xf32> 
    %16 = llvm.insertelement %13, %15[%14 : i32] : vector<4xf32>
    llvm.return %16 : vector<4xf32>
  }]

def notSelectButNoMaskDifference_before := [llvmfunc|
  llvm.func @notSelectButNoMaskDifference(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.undef : vector<4xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf32>
    %13 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %14 = llvm.mlir.constant(3 : i32) : i32
    %15 = llvm.shufflevector %arg0, %12 [1, 5, 6, 3] : vector<4xf32> 
    %16 = llvm.insertelement %13, %15[%14 : i32] : vector<4xf32>
    llvm.return %16 : vector<4xf32>
  }]

def tooRisky_before := [llvmfunc|
  llvm.func @tooRisky(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.shufflevector %arg0, %10 [1, 4, 4, 4] : vector<4xf32> 
    %14 = llvm.insertelement %11, %13[%12 : i32] : vector<4xf32>
    llvm.return %14 : vector<4xf32>
  }]

def twoShufUses_before := [llvmfunc|
  llvm.func @twoShufUses(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : f32
    %3 = llvm.mlir.undef : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xf32>
    %10 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %11 = llvm.mlir.constant(1 : i2) : i2
    %12 = llvm.shufflevector %arg0, %9 [0, 4, 5] : vector<3xf32> 
    %13 = llvm.insertelement %10, %12[%11 : i2] : vector<3xf32>
    %14 = llvm.fadd %12, %13  : vector<3xf32>
    llvm.return %14 : vector<3xf32>
  }]

def longerMask_before := [llvmfunc|
  llvm.func @longerMask(%arg0: vector<3xi8>) -> vector<5xi8> {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.constant(42 : i8) : i8
    %11 = llvm.mlir.constant(4 : i17) : i17
    %12 = llvm.shufflevector %arg0, %9 [2, 1, 4, 3, 0] : vector<3xi8> 
    %13 = llvm.insertelement %10, %12[%11 : i17] : vector<5xi8>
    llvm.return %13 : vector<5xi8>
  }]

def shorterMask_before := [llvmfunc|
  llvm.func @shorterMask(%arg0: vector<5xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.mlir.constant(2 : i8) : i8
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : i8
    %5 = llvm.mlir.undef : vector<5xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<5xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %3, %7[%8 : i32] : vector<5xi8>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %2, %9[%10 : i32] : vector<5xi8>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %1, %11[%12 : i32] : vector<5xi8>
    %14 = llvm.mlir.constant(4 : i32) : i32
    %15 = llvm.insertelement %0, %13[%14 : i32] : vector<5xi8>
    %16 = llvm.mlir.constant(42 : i8) : i8
    %17 = llvm.mlir.constant(0 : i21) : i21
    %18 = llvm.shufflevector %arg0, %15 [2, 1, 4] : vector<5xi8> 
    %19 = llvm.insertelement %16, %18[%17 : i21] : vector<3xi8>
    llvm.return %19 : vector<3xi8>
  }]

def PR29126_combined := [llvmfunc|
  llvm.func @PR29126(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.poison : f32
    %4 = llvm.mlir.undef : vector<4xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf32>
    %13 = llvm.shufflevector %arg0, %12 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %13 : vector<4xf32>
  }]

theorem inst_combine_PR29126   : PR29126_before  ⊑  PR29126_combined := by
  unfold PR29126_before PR29126_combined
  simp_alive_peephole
  sorry
def twoInserts_combined := [llvmfunc|
  llvm.func @twoInserts(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.100000e+01 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.poison : f32
    %4 = llvm.mlir.undef : vector<4xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xf32>
    %13 = llvm.shufflevector %arg0, %12 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %13 : vector<4xf32>
  }]

theorem inst_combine_twoInserts   : twoInserts_before  ⊑  twoInserts_combined := by
  unfold twoInserts_before twoInserts_combined
  simp_alive_peephole
  sorry
def shuffleRetain_combined := [llvmfunc|
  llvm.func @shuffleRetain(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.shufflevector %arg0, %10 [1, 2, -1, 7] : vector<4xi32> 
    llvm.return %11 : vector<4xi32>
  }]

theorem inst_combine_shuffleRetain   : shuffleRetain_before  ⊑  shuffleRetain_combined := by
  unfold shuffleRetain_before shuffleRetain_combined
  simp_alive_peephole
  sorry
def disguisedSelect_combined := [llvmfunc|
  llvm.func @disguisedSelect(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<4xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<4xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %13 = llvm.mlir.constant(0 : i64) : i64
    %14 = llvm.shufflevector %arg0, %11 [-1, 6, 5, 3] : vector<4xf32> 
    %15 = llvm.insertelement %12, %14[%13 : i64] : vector<4xf32>
    llvm.return %15 : vector<4xf32>
  }]

theorem inst_combine_disguisedSelect   : disguisedSelect_before  ⊑  disguisedSelect_combined := by
  unfold disguisedSelect_before disguisedSelect_combined
  simp_alive_peephole
  sorry
def notSelectButNoMaskDifference_combined := [llvmfunc|
  llvm.func @notSelectButNoMaskDifference(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<4xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<4xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %13 = llvm.mlir.constant(3 : i64) : i64
    %14 = llvm.shufflevector %arg0, %11 [1, 5, 6, -1] : vector<4xf32> 
    %15 = llvm.insertelement %12, %14[%13 : i64] : vector<4xf32>
    llvm.return %15 : vector<4xf32>
  }]

theorem inst_combine_notSelectButNoMaskDifference   : notSelectButNoMaskDifference_before  ⊑  notSelectButNoMaskDifference_combined := by
  unfold notSelectButNoMaskDifference_before notSelectButNoMaskDifference_combined
  simp_alive_peephole
  sorry
def tooRisky_combined := [llvmfunc|
  llvm.func @tooRisky(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %12 = llvm.mlir.constant(3 : i64) : i64
    %13 = llvm.shufflevector %arg0, %10 [1, 4, 4, -1] : vector<4xf32> 
    %14 = llvm.insertelement %11, %13[%12 : i64] : vector<4xf32>
    llvm.return %14 : vector<4xf32>
  }]

theorem inst_combine_tooRisky   : tooRisky_before  ⊑  tooRisky_combined := by
  unfold tooRisky_before tooRisky_combined
  simp_alive_peephole
  sorry
def twoShufUses_combined := [llvmfunc|
  llvm.func @twoShufUses(%arg0: vector<3xf32>) -> vector<3xf32> {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.undef : vector<3xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xf32>
    %10 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %11 = llvm.mlir.constant(1 : i64) : i64
    %12 = llvm.shufflevector %arg0, %9 [0, 4, 5] : vector<3xf32> 
    %13 = llvm.insertelement %10, %12[%11 : i64] : vector<3xf32>
    %14 = llvm.fadd %12, %13  : vector<3xf32>
    llvm.return %14 : vector<3xf32>
  }]

theorem inst_combine_twoShufUses   : twoShufUses_before  ⊑  twoShufUses_combined := by
  unfold twoShufUses_before twoShufUses_combined
  simp_alive_peephole
  sorry
def longerMask_combined := [llvmfunc|
  llvm.func @longerMask(%arg0: vector<3xi8>) -> vector<5xi8> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.undef : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.mlir.constant(42 : i8) : i8
    %11 = llvm.mlir.constant(4 : i64) : i64
    %12 = llvm.shufflevector %arg0, %9 [2, 1, 4, 3, -1] : vector<3xi8> 
    %13 = llvm.insertelement %10, %12[%11 : i64] : vector<5xi8>
    llvm.return %13 : vector<5xi8>
  }]

theorem inst_combine_longerMask   : longerMask_before  ⊑  longerMask_combined := by
  unfold longerMask_before longerMask_combined
  simp_alive_peephole
  sorry
def shorterMask_combined := [llvmfunc|
  llvm.func @shorterMask(%arg0: vector<5xi8>) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<5xi8>
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.shufflevector %arg0, %0 [-1, 1, 4] : vector<5xi8> 
    %4 = llvm.insertelement %1, %3[%2 : i64] : vector<3xi8>
    llvm.return %4 : vector<3xi8>
  }]

theorem inst_combine_shorterMask   : shorterMask_before  ⊑  shorterMask_combined := by
  unfold shorterMask_before shorterMask_combined
  simp_alive_peephole
  sorry
