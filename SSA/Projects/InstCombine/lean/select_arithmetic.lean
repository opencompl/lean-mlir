import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select_arithmetic
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1a_before := [llvmfunc|
  llvm.func @test1a(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.select %arg0, %0, %1 : i1, f32
    %5 = llvm.select %arg0, %2, %3 : i1, f32
    %6 = llvm.fadd %4, %5  : f32
    llvm.return %6 : f32
  }]

def test1b_before := [llvmfunc|
  llvm.func @test1b(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant(2.500000e-01 : f32) : f32
    %5 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %6 = llvm.select %arg0, %0, %1 : i1, f32
    %7 = llvm.select %arg0, %2, %3 : i1, f32
    %8 = llvm.select %arg0, %4, %5 : i1, f32
    %9 = llvm.fadd %6, %7  : f32
    %10 = llvm.fadd %8, %7  : f32
    %11 = llvm.fadd %10, %9  : f32
    llvm.return %11 : f32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.select %arg0, %0, %1 : i1, f32
    %5 = llvm.select %arg0, %2, %3 : i1, f32
    %6 = llvm.fsub %4, %5  : f32
    llvm.return %6 : f32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.select %arg0, %0, %1 : i1, f32
    %5 = llvm.select %arg0, %2, %3 : i1, f32
    %6 = llvm.fmul %4, %5  : f32
    llvm.return %6 : f32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(9.000000e+00 : f32) : f32
    %4 = llvm.select %arg0, %0, %1 : i1, f32
    %5 = llvm.select %arg0, %2, %3 : i1, f32
    %6 = llvm.fmul %4, %5  : f32
    llvm.call @use_float(%4) : (f32) -> ()
    llvm.return %6 : f32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i1 {llvm.zeroext}, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg1, %0 : i1, f32
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<contract>} : f32]

    llvm.call @use_float(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

def fmul_nnan_nsz_before := [llvmfunc|
  llvm.func @fmul_nnan_nsz(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %arg1, %0 : i1, f32
    %3 = llvm.select %arg0, %1, %arg1 : i1, f32
    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32]

    llvm.return %4 : f32
  }]

def fadd_nsz_before := [llvmfunc|
  llvm.func @fadd_nsz(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xf32>
    %3 = llvm.select %arg0, %1, %arg1 : vector<2xi1>, vector<2xf32>
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz>} : vector<2xf32>]

    llvm.return %4 : vector<2xf32>
  }]

def fsub_nnan_before := [llvmfunc|
  llvm.func @fsub_nnan(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(7.000000e+00 : f64) : f64
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, f64
    %2 = llvm.select %arg0, %arg1, %0 : i1, f64
    %3 = llvm.fsub %1, %2  {fastmathFlags = #llvm.fastmath<nnan>} : f64]

    llvm.return %3 : f64
  }]

def fdiv_nnan_nsz_before := [llvmfunc|
  llvm.func @fdiv_nnan_nsz(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.select %arg0, %arg2, %0 : i1, f64
    %3 = llvm.select %arg0, %1, %arg1 : i1, f64
    %4 = llvm.fdiv %2, %3  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64]

    llvm.return %4 : f64
  }]

def test1a_combined := [llvmfunc|
  llvm.func @test1a(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.500000e+01 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test1a   : test1a_before  ⊑  test1a_combined := by
  unfold test1a_before test1a_combined
  simp_alive_peephole
  sorry
def test1b_combined := [llvmfunc|
  llvm.func @test1b(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(7.250000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.800000e+01 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test1b   : test1b_before  ⊑  test1b_combined := by
  unfold test1b_before test1b_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-3.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.400000e+01 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i1 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(6.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(5.400000e+01 : f32) : f32
    %3 = llvm.select %arg0, %0, %1 : i1, f32
    %4 = llvm.select %arg0, %0, %2 : i1, f32
    llvm.call @use_float(%3) : (f32) -> ()
    llvm.return %4 : f32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i1 {llvm.zeroext}, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.select %arg0, %arg1, %0 : i1, f32
    %2 = llvm.fmul %1, %1  {fastmathFlags = #llvm.fastmath<contract>} : f32
    llvm.call @use_float(%1) : (f32) -> ()
    llvm.return %2 : f32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def fmul_nnan_nsz_combined := [llvmfunc|
  llvm.func @fmul_nnan_nsz(%arg0: i1, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fmul_nnan_nsz   : fmul_nnan_nsz_before  ⊑  fmul_nnan_nsz_combined := by
  unfold fmul_nnan_nsz_before fmul_nnan_nsz_combined
  simp_alive_peephole
  sorry
def fadd_nsz_combined := [llvmfunc|
  llvm.func @fadd_nsz(%arg0: vector<2xi1>, %arg1: vector<2xf32>) -> vector<2xf32> {
    llvm.return %arg1 : vector<2xf32>
  }]

theorem inst_combine_fadd_nsz   : fadd_nsz_before  ⊑  fadd_nsz_combined := by
  unfold fadd_nsz_before fadd_nsz_combined
  simp_alive_peephole
  sorry
def fsub_nnan_combined := [llvmfunc|
  llvm.func @fsub_nnan(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(-7.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg2, %0  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %3 = llvm.select %arg0, %1, %2 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_fsub_nnan   : fsub_nnan_before  ⊑  fsub_nnan_combined := by
  unfold fsub_nnan_before fsub_nnan_combined
  simp_alive_peephole
  sorry
def fdiv_nnan_nsz_combined := [llvmfunc|
  llvm.func @fdiv_nnan_nsz(%arg0: i1, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.select %arg0, %arg2, %0 : i1, f64
    %3 = llvm.select %arg0, %1, %arg1 : i1, f64
    %4 = llvm.fdiv %2, %3  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    llvm.return %4 : f64
  }]

theorem inst_combine_fdiv_nnan_nsz   : fdiv_nnan_nsz_before  ⊑  fdiv_nnan_nsz_combined := by
  unfold fdiv_nnan_nsz_before fdiv_nnan_nsz_combined
  simp_alive_peephole
  sorry
