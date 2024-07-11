import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fcmp-range-check-idiom
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_and_olt_before := [llvmfunc|
  llvm.func @test_and_olt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_ole_before := [llvmfunc|
  llvm.func @test_and_ole(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 : f32
    %3 = llvm.fcmp "oge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_or_ogt_before := [llvmfunc|
  llvm.func @test_or_ogt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.fcmp "olt" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_or_oge_before := [llvmfunc|
  llvm.func @test_or_oge(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 : f32
    %3 = llvm.fcmp "ole" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_ult_before := [llvmfunc|
  llvm.func @test_and_ult(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fcmp "ugt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_ule_before := [llvmfunc|
  llvm.func @test_and_ule(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ule" %arg0, %0 : f32
    %3 = llvm.fcmp "uge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_or_ugt_before := [llvmfunc|
  llvm.func @test_or_ugt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.fcmp "ult" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_or_uge_before := [llvmfunc|
  llvm.func @test_or_uge(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "uge" %arg0, %0 : f32
    %3 = llvm.fcmp "ule" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_commuted_before := [llvmfunc|
  llvm.func @test_and_olt_commuted(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_subnormal_before := [llvmfunc|
  llvm.func @test_and_olt_subnormal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.401300e-45 : f32) : f32
    %1 = llvm.mlir.constant(-1.401300e-45 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_infinity_before := [llvmfunc|
  llvm.func @test_and_olt_infinity(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_zero_before := [llvmfunc|
  llvm.func @test_and_olt_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_ole_zero_before := [llvmfunc|
  llvm.func @test_and_ole_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 : f32
    %3 = llvm.fcmp "oge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_logical_before := [llvmfunc|
  llvm.func @test_and_olt_logical(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    %4 = llvm.fcmp "ogt" %arg0, %1 : f32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def test_and_olt_poison_before := [llvmfunc|
  llvm.func @test_and_olt_poison(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %8 = llvm.mlir.undef : vector<2xf32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xf32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xf32>
    %13 = llvm.fcmp "olt" %arg0, %6 : vector<2xf32>
    %14 = llvm.fcmp "ogt" %arg0, %12 : vector<2xf32>
    %15 = llvm.and %13, %14  : vector<2xi1>
    llvm.return %15 : vector<2xi1>
  }]

def test_and_olt_nan_before := [llvmfunc|
  llvm.func @test_and_olt_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %1 = llvm.mlir.constant(0xFFC00000 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_ult_nan_before := [llvmfunc|
  llvm.func @test_and_ult_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800001 : f32) : f32
    %1 = llvm.mlir.constant(0xFF800001 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fcmp "ugt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_or_ogt_nan_before := [llvmfunc|
  llvm.func @test_or_ogt_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800001 : f32) : f32
    %1 = llvm.mlir.constant(0xFF800001 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.fcmp "olt" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_or_ugt_nan_before := [llvmfunc|
  llvm.func @test_or_ugt_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800001 : f32) : f32
    %1 = llvm.mlir.constant(0xFF800001 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.fcmp "ult" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_ogt_before := [llvmfunc|
  llvm.func @test_and_ogt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.fcmp "olt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_or_olt_before := [llvmfunc|
  llvm.func @test_or_olt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_multiuse_before := [llvmfunc|
  llvm.func @test_and_olt_multiuse(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_mismatched_lhs_before := [llvmfunc|
  llvm.func @test_and_olt_mismatched_lhs(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg1, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_same_sign_before := [llvmfunc|
  llvm.func @test_and_olt_same_sign(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.fcmp "olt" %arg0, %0 : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def test_and_olt_mismatched_mag_before := [llvmfunc|
  llvm.func @test_and_olt_mismatched_mag(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.77555756E-17 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_wrong_pred2_before := [llvmfunc|
  llvm.func @test_and_olt_wrong_pred2(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "oge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_fmf_propagation_before := [llvmfunc|
  llvm.func @test_and_olt_fmf_propagation(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32]

    %3 = llvm.fcmp "ogt" %arg0, %1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32]

    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_fmf_propagation_union_before := [llvmfunc|
  llvm.func @test_and_olt_fmf_propagation_union(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f32]

    %3 = llvm.fcmp "ogt" %arg0, %1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_and_olt_combined := [llvmfunc|
  llvm.func @test_and_olt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt   : test_and_olt_before  ⊑  test_and_olt_combined := by
  unfold test_and_olt_before test_and_olt_combined
  simp_alive_peephole
  sorry
def test_and_ole_combined := [llvmfunc|
  llvm.func @test_and_ole(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ole" %arg0, %0 : f32
    %3 = llvm.fcmp "oge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_ole   : test_and_ole_before  ⊑  test_and_ole_combined := by
  unfold test_and_ole_before test_and_ole_combined
  simp_alive_peephole
  sorry
def test_or_ogt_combined := [llvmfunc|
  llvm.func @test_or_ogt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.fcmp "olt" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_or_ogt   : test_or_ogt_before  ⊑  test_or_ogt_combined := by
  unfold test_or_ogt_before test_or_ogt_combined
  simp_alive_peephole
  sorry
def test_or_oge_combined := [llvmfunc|
  llvm.func @test_or_oge(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "oge" %arg0, %0 : f32
    %3 = llvm.fcmp "ole" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_or_oge   : test_or_oge_before  ⊑  test_or_oge_combined := by
  unfold test_or_oge_before test_or_oge_combined
  simp_alive_peephole
  sorry
def test_and_ult_combined := [llvmfunc|
  llvm.func @test_and_ult(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fcmp "ugt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_ult   : test_and_ult_before  ⊑  test_and_ult_combined := by
  unfold test_and_ult_before test_and_ult_combined
  simp_alive_peephole
  sorry
def test_and_ule_combined := [llvmfunc|
  llvm.func @test_and_ule(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ule" %arg0, %0 : f32
    %3 = llvm.fcmp "uge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_ule   : test_and_ule_before  ⊑  test_and_ule_combined := by
  unfold test_and_ule_before test_and_ule_combined
  simp_alive_peephole
  sorry
def test_or_ugt_combined := [llvmfunc|
  llvm.func @test_or_ugt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.fcmp "ult" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_or_ugt   : test_or_ugt_before  ⊑  test_or_ugt_combined := by
  unfold test_or_ugt_before test_or_ugt_combined
  simp_alive_peephole
  sorry
def test_or_uge_combined := [llvmfunc|
  llvm.func @test_or_uge(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "uge" %arg0, %0 : f32
    %3 = llvm.fcmp "ule" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_or_uge   : test_or_uge_before  ⊑  test_or_uge_combined := by
  unfold test_or_uge_before test_or_uge_combined
  simp_alive_peephole
  sorry
def test_and_olt_commuted_combined := [llvmfunc|
  llvm.func @test_and_olt_commuted(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt_commuted   : test_and_olt_commuted_before  ⊑  test_and_olt_commuted_combined := by
  unfold test_and_olt_commuted_before test_and_olt_commuted_combined
  simp_alive_peephole
  sorry
def test_and_olt_subnormal_combined := [llvmfunc|
  llvm.func @test_and_olt_subnormal(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.401300e-45 : f32) : f32
    %1 = llvm.mlir.constant(-1.401300e-45 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt_subnormal   : test_and_olt_subnormal_before  ⊑  test_and_olt_subnormal_combined := by
  unfold test_and_olt_subnormal_before test_and_olt_subnormal_combined
  simp_alive_peephole
  sorry
def test_and_olt_infinity_combined := [llvmfunc|
  llvm.func @test_and_olt_infinity(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_test_and_olt_infinity   : test_and_olt_infinity_before  ⊑  test_and_olt_infinity_combined := by
  unfold test_and_olt_infinity_before test_and_olt_infinity_combined
  simp_alive_peephole
  sorry
def test_and_olt_zero_combined := [llvmfunc|
  llvm.func @test_and_olt_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_and_olt_zero   : test_and_olt_zero_before  ⊑  test_and_olt_zero_combined := by
  unfold test_and_olt_zero_before test_and_olt_zero_combined
  simp_alive_peephole
  sorry
def test_and_ole_zero_combined := [llvmfunc|
  llvm.func @test_and_ole_zero(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.return %1 : i1
  }]

theorem inst_combine_test_and_ole_zero   : test_and_ole_zero_before  ⊑  test_and_ole_zero_combined := by
  unfold test_and_ole_zero_before test_and_ole_zero_combined
  simp_alive_peephole
  sorry
def test_and_olt_logical_combined := [llvmfunc|
  llvm.func @test_and_olt_logical(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt_logical   : test_and_olt_logical_before  ⊑  test_and_olt_logical_combined := by
  unfold test_and_olt_logical_before test_and_olt_logical_combined
  simp_alive_peephole
  sorry
def test_and_olt_poison_combined := [llvmfunc|
  llvm.func @test_and_olt_poison(%arg0: vector<2xf32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %8 = llvm.mlir.undef : vector<2xf32>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xf32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xf32>
    %13 = llvm.fcmp "olt" %arg0, %6 : vector<2xf32>
    %14 = llvm.fcmp "ogt" %arg0, %12 : vector<2xf32>
    %15 = llvm.and %13, %14  : vector<2xi1>
    llvm.return %15 : vector<2xi1>
  }]

theorem inst_combine_test_and_olt_poison   : test_and_olt_poison_before  ⊑  test_and_olt_poison_combined := by
  unfold test_and_olt_poison_before test_and_olt_poison_combined
  simp_alive_peephole
  sorry
def test_and_olt_nan_combined := [llvmfunc|
  llvm.func @test_and_olt_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_and_olt_nan   : test_and_olt_nan_before  ⊑  test_and_olt_nan_combined := by
  unfold test_and_olt_nan_before test_and_olt_nan_combined
  simp_alive_peephole
  sorry
def test_and_ult_nan_combined := [llvmfunc|
  llvm.func @test_and_ult_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_and_ult_nan   : test_and_ult_nan_before  ⊑  test_and_ult_nan_combined := by
  unfold test_and_ult_nan_before test_and_ult_nan_combined
  simp_alive_peephole
  sorry
def test_or_ogt_nan_combined := [llvmfunc|
  llvm.func @test_or_ogt_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_or_ogt_nan   : test_or_ogt_nan_before  ⊑  test_or_ogt_nan_combined := by
  unfold test_or_ogt_nan_before test_or_ogt_nan_combined
  simp_alive_peephole
  sorry
def test_or_ugt_nan_combined := [llvmfunc|
  llvm.func @test_or_ugt_nan(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_or_ugt_nan   : test_or_ugt_nan_before  ⊑  test_or_ugt_nan_combined := by
  unfold test_or_ugt_nan_before test_or_ugt_nan_combined
  simp_alive_peephole
  sorry
def test_and_ogt_combined := [llvmfunc|
  llvm.func @test_and_ogt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.fcmp "olt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_ogt   : test_and_ogt_before  ⊑  test_and_ogt_combined := by
  unfold test_and_ogt_before test_and_ogt_combined
  simp_alive_peephole
  sorry
def test_or_olt_combined := [llvmfunc|
  llvm.func @test_or_olt(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_or_olt   : test_or_olt_before  ⊑  test_or_olt_combined := by
  unfold test_or_olt_before test_or_olt_combined
  simp_alive_peephole
  sorry
def test_and_olt_multiuse_combined := [llvmfunc|
  llvm.func @test_and_olt_multiuse(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt_multiuse   : test_and_olt_multiuse_before  ⊑  test_and_olt_multiuse_combined := by
  unfold test_and_olt_multiuse_before test_and_olt_multiuse_combined
  simp_alive_peephole
  sorry
def test_and_olt_mismatched_lhs_combined := [llvmfunc|
  llvm.func @test_and_olt_mismatched_lhs(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg1, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt_mismatched_lhs   : test_and_olt_mismatched_lhs_before  ⊑  test_and_olt_mismatched_lhs_combined := by
  unfold test_and_olt_mismatched_lhs_before test_and_olt_mismatched_lhs_combined
  simp_alive_peephole
  sorry
def test_and_olt_same_sign_combined := [llvmfunc|
  llvm.func @test_and_olt_same_sign(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_and_olt_same_sign   : test_and_olt_same_sign_before  ⊑  test_and_olt_same_sign_combined := by
  unfold test_and_olt_same_sign_before test_and_olt_same_sign_combined
  simp_alive_peephole
  sorry
def test_and_olt_mismatched_mag_combined := [llvmfunc|
  llvm.func @test_and_olt_mismatched_mag(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(2.77555756E-17 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "ogt" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt_mismatched_mag   : test_and_olt_mismatched_mag_before  ⊑  test_and_olt_mismatched_mag_combined := by
  unfold test_and_olt_mismatched_mag_before test_and_olt_mismatched_mag_combined
  simp_alive_peephole
  sorry
def test_and_olt_wrong_pred2_combined := [llvmfunc|
  llvm.func @test_and_olt_wrong_pred2(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.fcmp "oge" %arg0, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt_wrong_pred2   : test_and_olt_wrong_pred2_before  ⊑  test_and_olt_wrong_pred2_combined := by
  unfold test_and_olt_wrong_pred2_before test_and_olt_wrong_pred2_combined
  simp_alive_peephole
  sorry
def test_and_olt_fmf_propagation_combined := [llvmfunc|
  llvm.func @test_and_olt_fmf_propagation(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32]

theorem inst_combine_test_and_olt_fmf_propagation   : test_and_olt_fmf_propagation_before  ⊑  test_and_olt_fmf_propagation_combined := by
  unfold test_and_olt_fmf_propagation_before test_and_olt_fmf_propagation_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ogt" %arg0, %1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f32]

theorem inst_combine_test_and_olt_fmf_propagation   : test_and_olt_fmf_propagation_before  ⊑  test_and_olt_fmf_propagation_combined := by
  unfold test_and_olt_fmf_propagation_before test_and_olt_fmf_propagation_combined
  simp_alive_peephole
  sorry
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt_fmf_propagation   : test_and_olt_fmf_propagation_before  ⊑  test_and_olt_fmf_propagation_combined := by
  unfold test_and_olt_fmf_propagation_before test_and_olt_fmf_propagation_combined
  simp_alive_peephole
  sorry
def test_and_olt_fmf_propagation_union_combined := [llvmfunc|
  llvm.func @test_and_olt_fmf_propagation_union(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(1.08420217E-19 : f32) : f32
    %1 = llvm.mlir.constant(-1.08420217E-19 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f32]

theorem inst_combine_test_and_olt_fmf_propagation_union   : test_and_olt_fmf_propagation_union_before  ⊑  test_and_olt_fmf_propagation_union_combined := by
  unfold test_and_olt_fmf_propagation_union_before test_and_olt_fmf_propagation_union_combined
  simp_alive_peephole
  sorry
    %3 = llvm.fcmp "ogt" %arg0, %1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

theorem inst_combine_test_and_olt_fmf_propagation_union   : test_and_olt_fmf_propagation_union_before  ⊑  test_and_olt_fmf_propagation_union_combined := by
  unfold test_and_olt_fmf_propagation_union_before test_and_olt_fmf_propagation_union_combined
  simp_alive_peephole
  sorry
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_and_olt_fmf_propagation_union   : test_and_olt_fmf_propagation_union_before  ⊑  test_and_olt_fmf_propagation_union_combined := by
  unfold test_and_olt_fmf_propagation_union_before test_and_olt_fmf_propagation_union_combined
  simp_alive_peephole
  sorry
