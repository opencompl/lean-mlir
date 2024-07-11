import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-fops-into-selects
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i1) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    %3 = llvm.fsub %0, %2  : f32
    llvm.return %3 : f32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fadd %1, %2  : f32
    llvm.return %3 : f32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fsub %1, %2  : f32
    llvm.return %3 : f32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fmul %1, %2  : f32
    llvm.return %3 : f32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fdiv %1, %2  : f32
    llvm.return %3 : f32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fdiv %2, %1  : f32
    llvm.return %3 : f32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %arg1 : i1, f32
    %3 = llvm.fdiv %2, %1  : f32
    llvm.return %3 : f32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i1) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %2 = llvm.fadd %arg1, %0  : f32
    %3 = llvm.select %arg0, %1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fsub %0, %arg1  : f32
    %3 = llvm.select %arg0, %1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg1, %0  : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %1 = llvm.fdiv %0, %arg1  : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.fmul %arg1, %0  : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.333333343 : f32) : f32
    %2 = llvm.fdiv %arg1, %0  : f32
    %3 = llvm.select %arg0, %1, %2 : i1, f32
    llvm.return %3 : f32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
