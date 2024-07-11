import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr27332
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: vector<4xf32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.intr.fabs(%arg0)  : (vector<4xf32>) -> vector<4xf32>
    %3 = llvm.fcmp "olt" %2, %1 : vector<4xf32>
    llvm.return %3 : vector<4xi1>
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @fabsf() : () -> f32
    %2 = llvm.fcmp "olt" %1, %0 : f32
    llvm.return %2 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: vector<4xf32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    llvm.return %1 : vector<4xi1>
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.call @fabsf() : () -> f32
    %2 = llvm.fcmp "olt" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
