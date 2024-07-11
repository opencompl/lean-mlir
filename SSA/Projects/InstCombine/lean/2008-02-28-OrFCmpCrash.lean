import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-02-28-OrFCmpCrash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: f32, %arg1: f80) -> f32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f80) : f80
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "uno" %arg1, %0 : f80
    %3 = llvm.fcmp "uno" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : f32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : f32
  }]

def test_logical_before := [llvmfunc|
  llvm.func @test_logical(%arg0: f32, %arg1: f80) -> f32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f80) : f80
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.fcmp "uno" %arg1, %0 : f80
    %4 = llvm.fcmp "uno" %arg0, %1 : f32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : f32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : f32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: f32, %arg1: f80) -> f32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f80) : f80
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "uno" %arg1, %0 : f80
    %3 = llvm.fcmp "uno" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : f32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : f32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test_logical_combined := [llvmfunc|
  llvm.func @test_logical(%arg0: f32, %arg1: f80) -> f32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f80) : f80
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.fcmp "uno" %arg1, %0 : f80
    %4 = llvm.fcmp "uno" %arg0, %1 : f32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : f32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : f32
  }]

theorem inst_combine_test_logical   : test_logical_before  ⊑  test_logical_combined := by
  unfold test_logical_before test_logical_combined
  simp_alive_peephole
  sorry
