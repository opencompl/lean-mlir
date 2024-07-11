import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vector_insertelt_shuffle
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %2, %4[%3 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.insertelement %arg1, %arg0[%0 : i32] : vector<4xf32>
    %4 = llvm.insertelement %1, %3[%2 : i32] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

def baz_before := [llvmfunc|
  llvm.func @baz(%arg0: vector<4xf32>, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %4 = llvm.insertelement %2, %3[%arg1 : i32] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

def bazz_before := [llvmfunc|
  llvm.func @bazz(%arg0: vector<4xf32>, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %7 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %8 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %9 = llvm.insertelement %2, %8[%arg1 : i32] : vector<4xf32>
    %10 = llvm.insertelement %3, %9[%4 : i32] : vector<4xf32>
    %11 = llvm.insertelement %0, %10[%5 : i32] : vector<4xf32>
    %12 = llvm.insertelement %6, %11[%4 : i32] : vector<4xf32>
    %13 = llvm.insertelement %7, %12[%arg1 : i32] : vector<4xf32>
    llvm.return %13 : vector<4xf32>
  }]

def bazzz_before := [llvmfunc|
  llvm.func @bazzz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %2, %4[%3 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def bazzzz_before := [llvmfunc|
  llvm.func @bazzzz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %5 = llvm.insertelement %2, %4[%3 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def bazzzzz_before := [llvmfunc|
  llvm.func @bazzzzz() -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.insertelement %1, %0[%2 : i32] : vector<4xf32>
    %6 = llvm.insertelement %3, %5[%4 : i32] : vector<4xf32>
    llvm.return %6 : vector<4xf32>
  }]

def bazzzzzz_before := [llvmfunc|
  llvm.func @bazzzzzz(%arg0: vector<4xf32>, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.undef : f32
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<4xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %12, %11[%13 : i32] : vector<4xf32>
    llvm.return %14 : vector<4xf32>
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: vector<4xf32>) -> vector<4xf32> {
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
    %12 = llvm.shufflevector %arg0, %11 [0, 5, 6, 3] : vector<4xf32> 
    llvm.return %12 : vector<4xf32>
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: vector<4xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    %4 = llvm.insertelement %arg1, %3[%2 : i64] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
def baz_combined := [llvmfunc|
  llvm.func @baz(%arg0: vector<4xf32>, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %3 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    %4 = llvm.insertelement %2, %3[%arg1 : i32] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_baz   : baz_before  ⊑  baz_combined := by
  unfold baz_before baz_combined
  simp_alive_peephole
  sorry
def bazz_combined := [llvmfunc|
  llvm.func @bazz(%arg0: vector<4xf32>, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %3 = llvm.mlir.poison : f32
    %4 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %5 = llvm.mlir.undef : vector<4xf32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %3, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %4, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %3, %11[%12 : i32] : vector<4xf32>
    %14 = llvm.mlir.constant(7.000000e+00 : f32) : f32
    %15 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf32>
    %16 = llvm.insertelement %2, %15[%arg1 : i32] : vector<4xf32>
    %17 = llvm.shufflevector %16, %13 [0, 5, 6, 3] : vector<4xf32> 
    %18 = llvm.insertelement %14, %17[%arg1 : i32] : vector<4xf32>
    llvm.return %18 : vector<4xf32>
  }]

theorem inst_combine_bazz   : bazz_before  ⊑  bazz_combined := by
  unfold bazz_before bazz_combined
  simp_alive_peephole
  sorry
def bazzz_combined := [llvmfunc|
  llvm.func @bazzz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }]

theorem inst_combine_bazzz   : bazzz_before  ⊑  bazzz_combined := by
  unfold bazzz_before bazzz_combined
  simp_alive_peephole
  sorry
def bazzzz_combined := [llvmfunc|
  llvm.func @bazzzz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<4xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xf32>
    llvm.return %10 : vector<4xf32>
  }]

theorem inst_combine_bazzzz   : bazzzz_before  ⊑  bazzzz_combined := by
  unfold bazzzz_before bazzzz_combined
  simp_alive_peephole
  sorry
def bazzzzz_combined := [llvmfunc|
  llvm.func @bazzzzz() -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 5.000000e+00, 1.000000e+01, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    llvm.return %0 : vector<4xf32>
  }]

theorem inst_combine_bazzzzz   : bazzzzz_before  ⊑  bazzzzz_combined := by
  unfold bazzzzz_before bazzzzz_combined
  simp_alive_peephole
  sorry
def bazzzzzz_combined := [llvmfunc|
  llvm.func @bazzzzzz(%arg0: vector<4xf32>, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.undef : f32
    %2 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %3 = llvm.mlir.undef : vector<4xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %0, %9[%10 : i32] : vector<4xf32>
    llvm.return %11 : vector<4xf32>
  }]

theorem inst_combine_bazzzzzz   : bazzzzzz_before  ⊑  bazzzzzz_combined := by
  unfold bazzzzzz_before bazzzzzz_combined
  simp_alive_peephole
  sorry
