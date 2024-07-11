import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fpextend_x86
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fadd %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fsub %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fmul %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: f64, %arg1: f16) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f16 to f80
    %2 = llvm.fmul %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fdiv %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fadd %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fsub %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fmul %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: f64, %arg1: f16) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg1 : f16 to f64
    %1 = llvm.fmul %0, %arg0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: f64, %arg1: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f64 to f80
    %1 = llvm.fpext %arg1 : f64 to f80
    %2 = llvm.fdiv %0, %1  : f80
    %3 = llvm.fptrunc %2 : f80 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
