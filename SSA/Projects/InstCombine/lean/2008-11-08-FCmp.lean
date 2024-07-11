import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-11-08-FCmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "ole" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "olt" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "oge" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-4.400000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "ogt" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-4.400000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "olt" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3.200000e+00 : f64) : f64
    %1 = llvm.uitofp %arg0 : i32 to f64
    %2 = llvm.fcmp "oge" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
