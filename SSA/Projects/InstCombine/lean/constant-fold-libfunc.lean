import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  constant-fold-libfunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify_acos_before := [llvmfunc|
  llvm.func @test_simplify_acos() -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_acos_nobuiltin_before := [llvmfunc|
  llvm.func @test_acos_nobuiltin() -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_acos_strictfp_before := [llvmfunc|
  llvm.func @test_acos_strictfp() -> f64 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify_acos_combined := [llvmfunc|
  llvm.func @test_simplify_acos() -> f64 {
    %0 = llvm.mlir.constant(3.1415926535897931 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test_simplify_acos   : test_simplify_acos_before  ⊑  test_simplify_acos_combined := by
  unfold test_simplify_acos_before test_simplify_acos_combined
  simp_alive_peephole
  sorry
def test_acos_nobuiltin_combined := [llvmfunc|
  llvm.func @test_acos_nobuiltin() -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_acos_nobuiltin   : test_acos_nobuiltin_before  ⊑  test_acos_nobuiltin_combined := by
  unfold test_acos_nobuiltin_before test_acos_nobuiltin_combined
  simp_alive_peephole
  sorry
def test_acos_strictfp_combined := [llvmfunc|
  llvm.func @test_acos_strictfp() -> f64 attributes {passthrough = ["strictfp"]} {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.call @acos(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_acos_strictfp   : test_acos_strictfp_before  ⊑  test_acos_strictfp_combined := by
  unfold test_acos_strictfp_before test_acos_strictfp_combined
  simp_alive_peephole
  sorry
