import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  add-sitofp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def x_before := [llvmfunc|
  llvm.func @x(%arg0: i32, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.sitofp %3 : i32 to f64
    %5 = llvm.fadd %4, %1  : f64
    llvm.return %5 : f64
  }]

def test_before := [llvmfunc|
  llvm.func @test(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sitofp %2 : i32 to f64
    %4 = llvm.fadd %3, %1  : f64
    llvm.return %4 : f64
  }]

def test_neg_before := [llvmfunc|
  llvm.func @test_neg(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sitofp %2 : i32 to f32
    %4 = llvm.fadd %3, %1  : f32
    llvm.return %4 : f32
  }]

def test_2_before := [llvmfunc|
  llvm.func @test_2(%arg0: i32, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.sitofp %1 : i32 to f64
    %4 = llvm.sitofp %2 : i32 to f64
    %5 = llvm.fadd %3, %4  : f64
    llvm.return %5 : f64
  }]

def test_2_neg_before := [llvmfunc|
  llvm.func @test_2_neg(%arg0: i32, %arg1: i32) -> f32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.sitofp %1 : i32 to f32
    %4 = llvm.sitofp %2 : i32 to f32
    %5 = llvm.fadd %3, %4  : f32
    llvm.return %5 : f32
  }]

def test_3_before := [llvmfunc|
  llvm.func @test_3(%arg0: i32, %arg1: i32) -> f32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.sitofp %3 : i32 to f32
    %5 = llvm.fadd %4, %1  : f32
    llvm.return %5 : f32
  }]

def test_4_before := [llvmfunc|
  llvm.func @test_4(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    %2 = llvm.and %arg1, %0  : vector<4xi32>
    %3 = llvm.sitofp %1 : vector<4xi32> to vector<4xf64>
    %4 = llvm.sitofp %2 : vector<4xi32> to vector<4xf64>
    %5 = llvm.fadd %3, %4  : vector<4xf64>
    llvm.return %5 : vector<4xf64>
  }]

def test_4_neg_before := [llvmfunc|
  llvm.func @test_4_neg(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    %2 = llvm.and %arg1, %0  : vector<4xi32>
    %3 = llvm.sitofp %1 : vector<4xi32> to vector<4xf32>
    %4 = llvm.sitofp %2 : vector<4xi32> to vector<4xf32>
    %5 = llvm.fadd %3, %4  : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

def x_combined := [llvmfunc|
  llvm.func @x(%arg0: i32, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.sitofp %4 : i32 to f64
    llvm.return %5 : f64
  }]

theorem inst_combine_x   : x_before  ⊑  x_combined := by
  unfold x_before x_combined
  simp_alive_peephole
  sorry
def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    %4 = llvm.sitofp %3 : i32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test_neg_combined := [llvmfunc|
  llvm.func @test_neg(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sitofp %2 : i32 to f32
    %4 = llvm.fadd %3, %1  : f32
    llvm.return %4 : f32
  }]

theorem inst_combine_test_neg   : test_neg_before  ⊑  test_neg_combined := by
  unfold test_neg_before test_neg_combined
  simp_alive_peephole
  sorry
def test_2_combined := [llvmfunc|
  llvm.func @test_2(%arg0: i32, %arg1: i32) -> f64 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : i32
    %4 = llvm.sitofp %3 : i32 to f64
    llvm.return %4 : f64
  }]

theorem inst_combine_test_2   : test_2_before  ⊑  test_2_combined := by
  unfold test_2_before test_2_combined
  simp_alive_peephole
  sorry
def test_2_neg_combined := [llvmfunc|
  llvm.func @test_2_neg(%arg0: i32, %arg1: i32) -> f32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.sitofp %1 : i32 to f32
    %4 = llvm.sitofp %2 : i32 to f32
    %5 = llvm.fadd %3, %4  : f32
    llvm.return %5 : f32
  }]

theorem inst_combine_test_2_neg   : test_2_neg_before  ⊑  test_2_neg_combined := by
  unfold test_2_neg_before test_2_neg_combined
  simp_alive_peephole
  sorry
def test_3_combined := [llvmfunc|
  llvm.func @test_3(%arg0: i32, %arg1: i32) -> f32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %arg1  : i32
    %4 = llvm.sitofp %3 : i32 to f32
    %5 = llvm.fadd %4, %1  : f32
    llvm.return %5 : f32
  }]

theorem inst_combine_test_3   : test_3_before  ⊑  test_3_combined := by
  unfold test_3_before test_3_combined
  simp_alive_peephole
  sorry
def test_4_combined := [llvmfunc|
  llvm.func @test_4(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    %2 = llvm.and %arg1, %0  : vector<4xi32>
    %3 = llvm.add %1, %2 overflow<nsw, nuw>  : vector<4xi32>
    %4 = llvm.sitofp %3 : vector<4xi32> to vector<4xf64>
    llvm.return %4 : vector<4xf64>
  }]

theorem inst_combine_test_4   : test_4_before  ⊑  test_4_combined := by
  unfold test_4_before test_4_combined
  simp_alive_peephole
  sorry
def test_4_neg_combined := [llvmfunc|
  llvm.func @test_4_neg(%arg0: vector<4xi32>, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<1073741823> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    %2 = llvm.and %arg1, %0  : vector<4xi32>
    %3 = llvm.sitofp %1 : vector<4xi32> to vector<4xf32>
    %4 = llvm.sitofp %2 : vector<4xi32> to vector<4xf32>
    %5 = llvm.fadd %3, %4  : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }]

theorem inst_combine_test_4_neg   : test_4_neg_before  ⊑  test_4_neg_combined := by
  unfold test_4_neg_before test_4_neg_combined
  simp_alive_peephole
  sorry
