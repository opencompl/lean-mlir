import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  zero-point-zero-add
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg0, %0  : f64
    %2 = llvm.fadd %1, %0  : f64
    llvm.return %2 : f64
  }]

def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @fabs(%arg0) : (f64) -> f64
    %2 = llvm.fadd %1, %0  : f64
    llvm.return %2 : f64
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg0, %0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
