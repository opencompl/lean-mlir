import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  math-odd-even-parity
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_erf_before := [llvmfunc|
  llvm.func @test_erf(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @erf(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %2 = llvm.fneg %1  : f64
    llvm.return %2 : f64
  }]

def test_cos_fabs_before := [llvmfunc|
  llvm.func @test_cos_fabs(%arg0: f64) -> f64 {
    %0 = llvm.call @fabs(%arg0) : (f64) -> f64
    %1 = llvm.call @cos(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    llvm.return %1 : f64
  }]

def test_erf_multi_use_before := [llvmfunc|
  llvm.func @test_erf_multi_use(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.call @erf(%0) : (f64) -> f64
    %2 = llvm.fneg %1  : f64
    llvm.return %2 : f64
  }]

def test_erf_combined := [llvmfunc|
  llvm.func @test_erf(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.call @erf(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fneg %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_erf   : test_erf_before  ⊑  test_erf_combined := by
  unfold test_erf_before test_erf_combined
  simp_alive_peephole
  sorry
def test_cos_fabs_combined := [llvmfunc|
  llvm.func @test_cos_fabs(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %1 = llvm.call @cos(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_cos_fabs   : test_cos_fabs_before  ⊑  test_cos_fabs_combined := by
  unfold test_cos_fabs_before test_cos_fabs_combined
  simp_alive_peephole
  sorry
def test_erf_multi_use_combined := [llvmfunc|
  llvm.func @test_erf_multi_use(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.call @erf(%0) : (f64) -> f64
    %2 = llvm.fneg %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_erf_multi_use   : test_erf_multi_use_before  ⊑  test_erf_multi_use_combined := by
  unfold test_erf_multi_use_before test_erf_multi_use_combined
  simp_alive_peephole
  sorry
