import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cos-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: f64) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fsub %0, %arg0  : f64
    %2 = llvm.call @cos(%1) : (f64) -> f32
    llvm.return %2 : f32
  }]

def test_no_simplify2_before := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: f64) -> f32 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @cos(%0) : (f64) -> f32
    llvm.return %1 : f32
  }]

def bogus_sqrt_before := [llvmfunc|
  llvm.func @bogus_sqrt() -> i8 {
    %0 = llvm.call @sqrt() vararg(!llvm.func<i8 (...)>) : () -> i8
    llvm.return %0 : i8
  }]

def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: f64) -> f32 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @cos(%0) : (f64) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
def test_no_simplify2_combined := [llvmfunc|
  llvm.func @test_no_simplify2(%arg0: f64) -> f32 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @cos(%0) : (f64) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_no_simplify2   : test_no_simplify2_before  ⊑  test_no_simplify2_combined := by
  unfold test_no_simplify2_before test_no_simplify2_combined
  simp_alive_peephole
  sorry
def bogus_sqrt_combined := [llvmfunc|
  llvm.func @bogus_sqrt() -> i8 {
    %0 = llvm.call @sqrt() vararg(!llvm.func<i8 (...)>) : () -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_bogus_sqrt   : bogus_sqrt_before  ⊑  bogus_sqrt_combined := by
  unfold bogus_sqrt_before bogus_sqrt_combined
  simp_alive_peephole
  sorry
