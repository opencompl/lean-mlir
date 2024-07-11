import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fcmp-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def oeq_before := [llvmfunc|
  llvm.func @oeq(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "oeq" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %0 : i1, f64
    llvm.return %2 : f64
  }]

def oeq_swapped_before := [llvmfunc|
  llvm.func @oeq_swapped(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %0, %arg0 : i1, f32
    llvm.return %2 : f32
  }]

def une_before := [llvmfunc|
  llvm.func @une(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "une" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %0 : i1, f64
    llvm.return %2 : f64
  }]

def une_swapped_before := [llvmfunc|
  llvm.func @une_swapped(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "une" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %0, %arg0 : i1, f64
    llvm.return %2 : f64
  }]

def une_could_be_negzero_before := [llvmfunc|
  llvm.func @une_could_be_negzero(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg0, %arg1 : i1, f64
    llvm.return %1 : f64
  }]

def une_swapped_could_be_negzero_before := [llvmfunc|
  llvm.func @une_swapped_could_be_negzero(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg1, %arg0 : i1, f64
    llvm.return %1 : f64
  }]

def one_before := [llvmfunc|
  llvm.func @one(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.fcmp "one" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %0 : i1, f64
    llvm.return %2 : f64
  }]

def one_swapped_before := [llvmfunc|
  llvm.func @one_swapped(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.fcmp "one" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %0, %arg0 : i1, f64
    llvm.return %2 : f64
  }]

def fcmp_oeq_select_before := [llvmfunc|
  llvm.func @fcmp_oeq_select(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, f32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, f32
    %2 = llvm.fcmp "oeq" %0, %1 : f32
    llvm.return %2 : i1
  }]

def fcmp_uno_select_before := [llvmfunc|
  llvm.func @fcmp_uno_select(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, f32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, f32
    %2 = llvm.fcmp "uno" %0, %1 : f32
    llvm.return %2 : i1
  }]

def fcmp_ogt_select_before := [llvmfunc|
  llvm.func @fcmp_ogt_select(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, f32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, f32
    %2 = llvm.fcmp "ogt" %0, %1 : f32
    llvm.return %2 : i1
  }]

def test_fcmp_select_const_const_before := [llvmfunc|
  llvm.func @test_fcmp_select_const_const(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %2 = llvm.fcmp "ord" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %0 : i1, f64
    %4 = llvm.fcmp "oeq" %3, %0 : f64
    llvm.return %4 : i1
  }]

def test_fcmp_select_var_const_before := [llvmfunc|
  llvm.func @test_fcmp_select_var_const(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.1920928955078125E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %arg1, %1 : i1, f64
    %4 = llvm.fcmp "olt" %3, %0 : f64
    llvm.return %4 : i1
  }]

def test_fcmp_select_var_const_fmf_before := [llvmfunc|
  llvm.func @test_fcmp_select_var_const_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.1920928955078125E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %arg1, %1 : i1, f64
    %4 = llvm.fcmp "olt" %3, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    llvm.return %4 : i1
  }]

def test_fcmp_select_const_const_vec_before := [llvmfunc|
  llvm.func @test_fcmp_select_const_const_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<0xFFFFFFFFFFFFFFFF> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.fcmp "ord" %arg0, %1 : vector<2xf64>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xf64>
    %5 = llvm.fcmp "oeq" %4, %1 : vector<2xf64>
    llvm.return %5 : vector<2xi1>
  }]

def test_fcmp_select_clamp_before := [llvmfunc|
  llvm.func @test_fcmp_select_clamp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(9.000000e-01 : f64) : f64
    %1 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %0, %arg0 : i1, f64
    %4 = llvm.fcmp "olt" %3, %1 : f64
    %5 = llvm.select %4, %1, %3 : i1, f64
    llvm.return %5 : f64
  }]

def test_fcmp_select_maxnum_before := [llvmfunc|
  llvm.func @test_fcmp_select_maxnum(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.550000e+02 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    %4 = llvm.fcmp "olt" %3, %1 : f64
    %5 = llvm.select %4, %3, %1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %5 : f64
  }]

def test_fcmp_select_const_const_multiuse_before := [llvmfunc|
  llvm.func @test_fcmp_select_const_const_multiuse(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %2 = llvm.fcmp "ord" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %0 : i1, f64
    llvm.call @usef64(%3) : (f64) -> ()
    %4 = llvm.fcmp "oeq" %3, %0 : f64
    llvm.return %4 : i1
  }]

def test_fcmp_select_const_const_unordered_before := [llvmfunc|
  llvm.func @test_fcmp_select_const_const_unordered(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %2 = llvm.fcmp "uno" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %0 : i1, f64
    %4 = llvm.fcmp "oeq" %3, %0 : f64
    llvm.return %4 : i1
  }]

def test_fcmp_select_var_const_unordered_before := [llvmfunc|
  llvm.func @test_fcmp_select_var_const_unordered(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.1920928955078125E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f64
    %3 = llvm.select %2, %arg1, %1 : i1, f64
    %4 = llvm.fcmp "ugt" %3, %0 : f64
    llvm.return %4 : i1
  }]

def oeq_combined := [llvmfunc|
  llvm.func @oeq(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "oeq" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %0 : f64
  }]

theorem inst_combine_oeq   : oeq_before  ⊑  oeq_combined := by
  unfold oeq_before oeq_combined
  simp_alive_peephole
  sorry
def oeq_swapped_combined := [llvmfunc|
  llvm.func @oeq_swapped(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.fcmp "oeq" %arg0, %0 : f32
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %arg0 : f32
  }]

theorem inst_combine_oeq_swapped   : oeq_swapped_before  ⊑  oeq_swapped_combined := by
  unfold oeq_swapped_before oeq_swapped_combined
  simp_alive_peephole
  sorry
def une_combined := [llvmfunc|
  llvm.func @une(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "une" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %arg0 : f64
  }]

theorem inst_combine_une   : une_before  ⊑  une_combined := by
  unfold une_before une_combined
  simp_alive_peephole
  sorry
def une_swapped_combined := [llvmfunc|
  llvm.func @une_swapped(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fcmp "une" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %0 : f64
  }]

theorem inst_combine_une_swapped   : une_swapped_before  ⊑  une_swapped_combined := by
  unfold une_swapped_before une_swapped_combined
  simp_alive_peephole
  sorry
def une_could_be_negzero_combined := [llvmfunc|
  llvm.func @une_could_be_negzero(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg0, %arg1 : i1, f64
    llvm.return %1 : f64
  }]

theorem inst_combine_une_could_be_negzero   : une_could_be_negzero_before  ⊑  une_could_be_negzero_combined := by
  unfold une_could_be_negzero_before une_could_be_negzero_combined
  simp_alive_peephole
  sorry
def une_swapped_could_be_negzero_combined := [llvmfunc|
  llvm.func @une_swapped_could_be_negzero(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    llvm.call @use(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg1, %arg0 : i1, f64
    llvm.return %1 : f64
  }]

theorem inst_combine_une_swapped_could_be_negzero   : une_swapped_could_be_negzero_before  ⊑  une_swapped_could_be_negzero_combined := by
  unfold une_swapped_could_be_negzero_before une_swapped_could_be_negzero_combined
  simp_alive_peephole
  sorry
def one_combined := [llvmfunc|
  llvm.func @one(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.fcmp "one" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %0 : i1, f64
    llvm.return %2 : f64
  }]

theorem inst_combine_one   : one_before  ⊑  one_combined := by
  unfold one_before one_combined
  simp_alive_peephole
  sorry
def one_swapped_combined := [llvmfunc|
  llvm.func @one_swapped(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.fcmp "one" %arg0, %0 : f64
    llvm.call @use(%1) : (i1) -> ()
    %2 = llvm.select %1, %0, %arg0 : i1, f64
    llvm.return %2 : f64
  }]

theorem inst_combine_one_swapped   : one_swapped_before  ⊑  one_swapped_combined := by
  unfold one_swapped_before one_swapped_combined
  simp_alive_peephole
  sorry
def fcmp_oeq_select_combined := [llvmfunc|
  llvm.func @fcmp_oeq_select(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, f32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, f32
    %2 = llvm.fcmp "oeq" %0, %1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_oeq_select   : fcmp_oeq_select_before  ⊑  fcmp_oeq_select_combined := by
  unfold fcmp_oeq_select_before fcmp_oeq_select_combined
  simp_alive_peephole
  sorry
def fcmp_uno_select_combined := [llvmfunc|
  llvm.func @fcmp_uno_select(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, f32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, f32
    %2 = llvm.fcmp "uno" %0, %1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_uno_select   : fcmp_uno_select_before  ⊑  fcmp_uno_select_combined := by
  unfold fcmp_uno_select_before fcmp_uno_select_combined
  simp_alive_peephole
  sorry
def fcmp_ogt_select_combined := [llvmfunc|
  llvm.func @fcmp_ogt_select(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, f32
    %1 = llvm.select %arg0, %arg2, %arg1 : i1, f32
    %2 = llvm.fcmp "ogt" %0, %1 : f32
    llvm.return %2 : i1
  }]

theorem inst_combine_fcmp_ogt_select   : fcmp_ogt_select_before  ⊑  fcmp_ogt_select_combined := by
  unfold fcmp_ogt_select_before fcmp_ogt_select_combined
  simp_alive_peephole
  sorry
def test_fcmp_select_const_const_combined := [llvmfunc|
  llvm.func @test_fcmp_select_const_const(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %2 = llvm.fcmp "ord" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %0 : i1, f64
    %4 = llvm.fcmp "oeq" %3, %0 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_test_fcmp_select_const_const   : test_fcmp_select_const_const_before  ⊑  test_fcmp_select_const_const_combined := by
  unfold test_fcmp_select_const_const_before test_fcmp_select_const_const_combined
  simp_alive_peephole
  sorry
def test_fcmp_select_var_const_combined := [llvmfunc|
  llvm.func @test_fcmp_select_var_const(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.1920928955078125E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %arg1, %1 : i1, f64
    %4 = llvm.fcmp "olt" %3, %0 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_test_fcmp_select_var_const   : test_fcmp_select_var_const_before  ⊑  test_fcmp_select_var_const_combined := by
  unfold test_fcmp_select_var_const_before test_fcmp_select_var_const_combined
  simp_alive_peephole
  sorry
def test_fcmp_select_var_const_fmf_combined := [llvmfunc|
  llvm.func @test_fcmp_select_var_const_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.1920928955078125E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %arg1, %1 : i1, f64
    %4 = llvm.fcmp "olt" %3, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_test_fcmp_select_var_const_fmf   : test_fcmp_select_var_const_fmf_before  ⊑  test_fcmp_select_var_const_fmf_combined := by
  unfold test_fcmp_select_var_const_fmf_before test_fcmp_select_var_const_fmf_combined
  simp_alive_peephole
  sorry
def test_fcmp_select_const_const_vec_combined := [llvmfunc|
  llvm.func @test_fcmp_select_const_const_vec(%arg0: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.mlir.constant(dense<0xFFFFFFFFFFFFFFFF> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.fcmp "ord" %arg0, %1 : vector<2xf64>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xf64>
    %5 = llvm.fcmp "oeq" %4, %1 : vector<2xf64>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_test_fcmp_select_const_const_vec   : test_fcmp_select_const_const_vec_before  ⊑  test_fcmp_select_const_const_vec_combined := by
  unfold test_fcmp_select_const_const_vec_before test_fcmp_select_const_const_vec_combined
  simp_alive_peephole
  sorry
def test_fcmp_select_clamp_combined := [llvmfunc|
  llvm.func @test_fcmp_select_clamp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(9.000000e-01 : f64) : f64
    %1 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %2 = llvm.fcmp "ogt" %arg0, %0 : f64
    %3 = llvm.select %2, %0, %arg0 : i1, f64
    %4 = llvm.fcmp "olt" %3, %1 : f64
    %5 = llvm.select %4, %1, %3 : i1, f64
    llvm.return %5 : f64
  }]

theorem inst_combine_test_fcmp_select_clamp   : test_fcmp_select_clamp_before  ⊑  test_fcmp_select_clamp_combined := by
  unfold test_fcmp_select_clamp_before test_fcmp_select_clamp_combined
  simp_alive_peephole
  sorry
def test_fcmp_select_maxnum_combined := [llvmfunc|
  llvm.func @test_fcmp_select_maxnum(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.550000e+02 : f64) : f64
    %2 = llvm.intr.maxnum(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64, f64) -> f64
    %3 = llvm.intr.minnum(%2, %1)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64, f64) -> f64
    llvm.return %3 : f64
  }]

theorem inst_combine_test_fcmp_select_maxnum   : test_fcmp_select_maxnum_before  ⊑  test_fcmp_select_maxnum_combined := by
  unfold test_fcmp_select_maxnum_before test_fcmp_select_maxnum_combined
  simp_alive_peephole
  sorry
def test_fcmp_select_const_const_multiuse_combined := [llvmfunc|
  llvm.func @test_fcmp_select_const_const_multiuse(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %2 = llvm.fcmp "ord" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %0 : i1, f64
    llvm.call @usef64(%3) : (f64) -> ()
    %4 = llvm.fcmp "oeq" %3, %0 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_test_fcmp_select_const_const_multiuse   : test_fcmp_select_const_const_multiuse_before  ⊑  test_fcmp_select_const_const_multiuse_combined := by
  unfold test_fcmp_select_const_const_multiuse_before test_fcmp_select_const_const_multiuse_combined
  simp_alive_peephole
  sorry
def test_fcmp_select_const_const_unordered_combined := [llvmfunc|
  llvm.func @test_fcmp_select_const_const_unordered(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0xFFFFFFFFFFFFFFFF : f64) : f64
    %2 = llvm.fcmp "uno" %arg0, %0 : f64
    %3 = llvm.select %2, %1, %0 : i1, f64
    %4 = llvm.fcmp "oeq" %3, %0 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_test_fcmp_select_const_const_unordered   : test_fcmp_select_const_const_unordered_before  ⊑  test_fcmp_select_const_const_unordered_combined := by
  unfold test_fcmp_select_const_const_unordered_before test_fcmp_select_const_const_unordered_combined
  simp_alive_peephole
  sorry
def test_fcmp_select_var_const_unordered_combined := [llvmfunc|
  llvm.func @test_fcmp_select_var_const_unordered(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(1.1920928955078125E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f64
    %3 = llvm.select %2, %arg1, %1 : i1, f64
    %4 = llvm.fcmp "ugt" %3, %0 : f64
    llvm.return %4 : i1
  }]

theorem inst_combine_test_fcmp_select_var_const_unordered   : test_fcmp_select_var_const_unordered_before  ⊑  test_fcmp_select_var_const_unordered_combined := by
  unfold test_fcmp_select_var_const_unordered_before test_fcmp_select_var_const_unordered_combined
  simp_alive_peephole
  sorry
