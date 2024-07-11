import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  float-shrink-compare
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @ceil(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test1_intrin_before := [llvmfunc|
  llvm.func @test1_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @fabs(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test2_intrin_before := [llvmfunc|
  llvm.func @test2_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def fmf_test2_before := [llvmfunc|
  llvm.func @fmf_test2(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @fabs(%0) {fastmathFlags = #llvm.fastmath<nnan>} : (f64) -> f64]

    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @floor(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test3_intrin_before := [llvmfunc|
  llvm.func @test3_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.floor(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @nearbyint(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def shrink_nearbyint_intrin_before := [llvmfunc|
  llvm.func @shrink_nearbyint_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.nearbyint(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @rint(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @round(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test6_intrin_before := [llvmfunc|
  llvm.func @test6_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.round(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test6a_before := [llvmfunc|
  llvm.func @test6a(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @roundeven(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test6a_intrin_before := [llvmfunc|
  llvm.func @test6a_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.roundeven(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @trunc(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test7_intrin_before := [llvmfunc|
  llvm.func @test7_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.trunc(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @ceil(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test8_intrin_before := [llvmfunc|
  llvm.func @test8_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.ceil(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fabs(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test9_intrin_before := [llvmfunc|
  llvm.func @test9_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.fabs(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @floor(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %1 : f64
    llvm.return %3 : i1
  }]

def test10_intrin_before := [llvmfunc|
  llvm.func @test10_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.floor(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %1 : f64
    llvm.return %3 : i1
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @nearbyint(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %1 : f64
    llvm.return %3 : i1
  }]

def test11_intrin_before := [llvmfunc|
  llvm.func @test11_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.nearbyint(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %1 : f64
    llvm.return %3 : i1
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @rint(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @round(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test13_intrin_before := [llvmfunc|
  llvm.func @test13_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.round(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test13a_before := [llvmfunc|
  llvm.func @test13a(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @roundeven(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test13a_intrin_before := [llvmfunc|
  llvm.func @test13a_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.roundeven(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @trunc(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test14_intrin_before := [llvmfunc|
  llvm.func @test14_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.trunc(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmin(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fpext %arg2 : f32 to f64
    %4 = llvm.fcmp "oeq" %2, %3 : f64
    llvm.return %4 : i1
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg2 : f32 to f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.call @fmin(%1, %2) : (f64, f64) -> f64
    %4 = llvm.fcmp "oeq" %0, %3 : f64
    llvm.return %4 : i1
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmax(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fpext %arg2 : f32 to f64
    %4 = llvm.fcmp "oeq" %2, %3 : f64
    llvm.return %4 : i1
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg2 : f32 to f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.call @fmax(%1, %2) : (f64, f64) -> f64
    %4 = llvm.fcmp "oeq" %0, %3 : f64
    llvm.return %4 : i1
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @copysign(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fpext %arg2 : f32 to f64
    %4 = llvm.fcmp "oeq" %2, %3 : f64
    llvm.return %4 : i1
  }]

def test20_before := [llvmfunc|
  llvm.func @test20(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fpext %arg0 : f32 to f64
    %3 = llvm.call @fmin(%0, %2) : (f64, f64) -> f64
    %4 = llvm.fcmp "oeq" %1, %3 : f64
    llvm.return %4 : i1
  }]

def test21_before := [llvmfunc|
  llvm.func @test21(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.300000e+00 : f64) : f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fpext %arg0 : f32 to f64
    %3 = llvm.call @fmin(%0, %2) : (f64, f64) -> f64
    %4 = llvm.fcmp "oeq" %1, %3 : f64
    llvm.return %4 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.ceil(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1_intrin_combined := [llvmfunc|
  llvm.func @test1_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.ceil(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test1_intrin   : test1_intrin_before  ⊑  test1_intrin_combined := by
  unfold test1_intrin_before test1_intrin_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2_intrin_combined := [llvmfunc|
  llvm.func @test2_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test2_intrin   : test2_intrin_before  ⊑  test2_intrin_combined := by
  unfold test2_intrin_before test2_intrin_combined
  simp_alive_peephole
  sorry
def fmf_test2_combined := [llvmfunc|
  llvm.func @fmf_test2(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_fmf_test2   : fmf_test2_before  ⊑  fmf_test2_combined := by
  unfold fmf_test2_before fmf_test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.floor(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3_intrin_combined := [llvmfunc|
  llvm.func @test3_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.floor(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test3_intrin   : test3_intrin_before  ⊑  test3_intrin_combined := by
  unfold test3_intrin_before test3_intrin_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def shrink_nearbyint_intrin_combined := [llvmfunc|
  llvm.func @shrink_nearbyint_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_shrink_nearbyint_intrin   : shrink_nearbyint_intrin_before  ⊑  shrink_nearbyint_intrin_combined := by
  unfold shrink_nearbyint_intrin_before shrink_nearbyint_intrin_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.rint(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.round(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6_intrin_combined := [llvmfunc|
  llvm.func @test6_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.round(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test6_intrin   : test6_intrin_before  ⊑  test6_intrin_combined := by
  unfold test6_intrin_before test6_intrin_combined
  simp_alive_peephole
  sorry
def test6a_combined := [llvmfunc|
  llvm.func @test6a(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.roundeven(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test6a   : test6a_before  ⊑  test6a_combined := by
  unfold test6a_before test6a_combined
  simp_alive_peephole
  sorry
def test6a_intrin_combined := [llvmfunc|
  llvm.func @test6a_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.roundeven(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test6a_intrin   : test6a_intrin_before  ⊑  test6a_intrin_combined := by
  unfold test6a_intrin_before test6a_intrin_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.trunc(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test7_intrin_combined := [llvmfunc|
  llvm.func @test7_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.trunc(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test7_intrin   : test7_intrin_before  ⊑  test7_intrin_combined := by
  unfold test7_intrin_before test7_intrin_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.ceil(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test8_intrin_combined := [llvmfunc|
  llvm.func @test8_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.ceil(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test8_intrin   : test8_intrin_before  ⊑  test8_intrin_combined := by
  unfold test8_intrin_before test8_intrin_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9_intrin_combined := [llvmfunc|
  llvm.func @test9_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test9_intrin   : test9_intrin_before  ⊑  test9_intrin_combined := by
  unfold test9_intrin_before test9_intrin_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.floor(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10_intrin_combined := [llvmfunc|
  llvm.func @test10_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.floor(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test10_intrin   : test10_intrin_before  ⊑  test10_intrin_combined := by
  unfold test10_intrin_before test10_intrin_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11_intrin_combined := [llvmfunc|
  llvm.func @test11_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.nearbyint(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test11_intrin   : test11_intrin_before  ⊑  test11_intrin_combined := by
  unfold test11_intrin_before test11_intrin_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.rint(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.round(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test13_intrin_combined := [llvmfunc|
  llvm.func @test13_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.round(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test13_intrin   : test13_intrin_before  ⊑  test13_intrin_combined := by
  unfold test13_intrin_before test13_intrin_combined
  simp_alive_peephole
  sorry
def test13a_combined := [llvmfunc|
  llvm.func @test13a(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.roundeven(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test13a   : test13a_before  ⊑  test13a_combined := by
  unfold test13a_before test13a_combined
  simp_alive_peephole
  sorry
def test13a_intrin_combined := [llvmfunc|
  llvm.func @test13a_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.roundeven(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test13a_intrin   : test13a_intrin_before  ⊑  test13a_intrin_combined := by
  unfold test13a_intrin_before test13a_intrin_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.trunc(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test14_intrin_combined := [llvmfunc|
  llvm.func @test14_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.intr.trunc(%arg0)  : (f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg1 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test14_intrin   : test14_intrin_before  ⊑  test14_intrin_combined := by
  unfold test14_intrin_before test14_intrin_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg2 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg2 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg2 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg2 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.call @copysignf(%arg0, %arg1) : (f32, f32) -> f32
    %1 = llvm.fcmp "oeq" %0, %arg2 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def test20_combined := [llvmfunc|
  llvm.func @test20(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.minnum(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32, f32) -> f32
    %2 = llvm.fcmp "oeq" %1, %arg1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test20   : test20_before  ⊑  test20_combined := by
  unfold test20_before test20_combined
  simp_alive_peephole
  sorry
def test21_combined := [llvmfunc|
  llvm.func @test21(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.300000e+00 : f64) : f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fpext %arg0 : f32 to f64
    %3 = llvm.intr.minnum(%2, %0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f64, f64) -> f64
    %4 = llvm.fcmp "oeq" %3, %1 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_test21   : test21_before  ⊑  test21_combined := by
  unfold test21_before test21_combined
  simp_alive_peephole
  sorry
