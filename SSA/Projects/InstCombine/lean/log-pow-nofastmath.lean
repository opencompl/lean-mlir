import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  log-pow-nofastmath
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mylog_before := [llvmfunc|
  llvm.func @mylog(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def mylog_combined := [llvmfunc|
  llvm.func @mylog(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_mylog   : mylog_before  ⊑  mylog_combined := by
  unfold mylog_before mylog_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) : (f64) -> f64
    %1 = llvm.call @log(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
