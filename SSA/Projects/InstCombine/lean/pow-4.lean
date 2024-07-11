import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow-4
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify_3_before := [llvmfunc|
  llvm.func @test_simplify_3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def test_simplify_4f_before := [llvmfunc|
  llvm.func @test_simplify_4f(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def test_simplify_4_before := [llvmfunc|
  llvm.func @test_simplify_4(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def test_simplify_15_before := [llvmfunc|
  llvm.func @test_simplify_15(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<1.500000e+01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def test_simplify_neg_7_before := [llvmfunc|
  llvm.func @test_simplify_neg_7(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-7.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def test_simplify_neg_19_before := [llvmfunc|
  llvm.func @test_simplify_neg_19(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-1.900000e+01 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def test_simplify_11_23_before := [llvmfunc|
  llvm.func @test_simplify_11_23(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.123000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def test_simplify_32_before := [llvmfunc|
  llvm.func @test_simplify_32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.200000e+01 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def test_simplify_33_before := [llvmfunc|
  llvm.func @test_simplify_33(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3.300000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def test_simplify_16_5_before := [llvmfunc|
  llvm.func @test_simplify_16_5(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.650000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def test_simplify_neg_16_5_before := [llvmfunc|
  llvm.func @test_simplify_neg_16_5(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.650000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def test_simplify_0_5_libcall_before := [llvmfunc|
  llvm.func @test_simplify_0_5_libcall(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def test_simplify_neg_0_5_libcall_before := [llvmfunc|
  llvm.func @test_simplify_neg_0_5_libcall(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-5.000000e-01 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def test_simplify_neg_8_5_before := [llvmfunc|
  llvm.func @test_simplify_neg_8_5(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-8.500000e+00 : f32) : f32
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def test_simplify_7_5_before := [llvmfunc|
  llvm.func @test_simplify_7_5(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<7.500000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, vector<2xf64>) -> vector<2xf64>]

    llvm.return %1 : vector<2xf64>
  }]

def test_simplify_3_5_before := [llvmfunc|
  llvm.func @test_simplify_3_5(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<3.500000e+00> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>]

    llvm.return %1 : vector<4xf32>
  }]

def shrink_pow_libcall_half_before := [llvmfunc|
  llvm.func @shrink_pow_libcall_half(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.call @pow(%1, %0) {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def PR43233_before := [llvmfunc|
  llvm.func @PR43233(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    llvm.return %1 : f64
  }]

def test_simplify_3_combined := [llvmfunc|
  llvm.func @test_simplify_3(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_simplify_3   : test_simplify_3_before  ⊑  test_simplify_3_combined := by
  unfold test_simplify_3_before test_simplify_3_combined
  simp_alive_peephole
  sorry
def test_simplify_4f_combined := [llvmfunc|
  llvm.func @test_simplify_4f(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, i32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_simplify_4f   : test_simplify_4f_before  ⊑  test_simplify_4f_combined := by
  unfold test_simplify_4f_before test_simplify_4f_combined
  simp_alive_peephole
  sorry
def test_simplify_4_combined := [llvmfunc|
  llvm.func @test_simplify_4(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_simplify_4   : test_simplify_4_before  ⊑  test_simplify_4_combined := by
  unfold test_simplify_4_before test_simplify_4_combined
  simp_alive_peephole
  sorry
def test_simplify_15_combined := [llvmfunc|
  llvm.func @test_simplify_15(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf32>, i32) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_test_simplify_15   : test_simplify_15_before  ⊑  test_simplify_15_combined := by
  unfold test_simplify_15_before test_simplify_15_combined
  simp_alive_peephole
  sorry
def test_simplify_neg_7_combined := [llvmfunc|
  llvm.func @test_simplify_neg_7(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(-7 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, i32) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }]

theorem inst_combine_test_simplify_neg_7   : test_simplify_neg_7_before  ⊑  test_simplify_neg_7_combined := by
  unfold test_simplify_neg_7_before test_simplify_neg_7_combined
  simp_alive_peephole
  sorry
def test_simplify_neg_19_combined := [llvmfunc|
  llvm.func @test_simplify_neg_19(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-19 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, i32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_simplify_neg_19   : test_simplify_neg_19_before  ⊑  test_simplify_neg_19_combined := by
  unfold test_simplify_neg_19_before test_simplify_neg_19_combined
  simp_alive_peephole
  sorry
def test_simplify_11_23_combined := [llvmfunc|
  llvm.func @test_simplify_11_23(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.123000e+01 : f64) : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_simplify_11_23   : test_simplify_11_23_before  ⊑  test_simplify_11_23_combined := by
  unfold test_simplify_11_23_before test_simplify_11_23_combined
  simp_alive_peephole
  sorry
def test_simplify_32_combined := [llvmfunc|
  llvm.func @test_simplify_32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, i32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_simplify_32   : test_simplify_32_before  ⊑  test_simplify_32_combined := by
  unfold test_simplify_32_before test_simplify_32_combined
  simp_alive_peephole
  sorry
def test_simplify_33_combined := [llvmfunc|
  llvm.func @test_simplify_33(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(33 : i32) : i32
    %1 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_simplify_33   : test_simplify_33_before  ⊑  test_simplify_33_combined := by
  unfold test_simplify_33_before test_simplify_33_combined
  simp_alive_peephole
  sorry
def test_simplify_16_5_combined := [llvmfunc|
  llvm.func @test_simplify_16_5(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_test_simplify_16_5   : test_simplify_16_5_before  ⊑  test_simplify_16_5_combined := by
  unfold test_simplify_16_5_before test_simplify_16_5_combined
  simp_alive_peephole
  sorry
def test_simplify_neg_16_5_combined := [llvmfunc|
  llvm.func @test_simplify_neg_16_5(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(-17 : i32) : i32
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, i32) -> f64
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_test_simplify_neg_16_5   : test_simplify_neg_16_5_before  ⊑  test_simplify_neg_16_5_combined := by
  unfold test_simplify_neg_16_5_before test_simplify_neg_16_5_combined
  simp_alive_peephole
  sorry
def test_simplify_0_5_libcall_combined := [llvmfunc|
  llvm.func @test_simplify_0_5_libcall(%arg0: f64) -> f64 {
    %0 = llvm.call @sqrt(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_test_simplify_0_5_libcall   : test_simplify_0_5_libcall_before  ⊑  test_simplify_0_5_libcall_combined := by
  unfold test_simplify_0_5_libcall_before test_simplify_0_5_libcall_combined
  simp_alive_peephole
  sorry
def test_simplify_neg_0_5_libcall_combined := [llvmfunc|
  llvm.func @test_simplify_neg_0_5_libcall(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @sqrt(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_simplify_neg_0_5_libcall   : test_simplify_neg_0_5_libcall_before  ⊑  test_simplify_neg_0_5_libcall_combined := by
  unfold test_simplify_neg_0_5_libcall_before test_simplify_neg_0_5_libcall_combined
  simp_alive_peephole
  sorry
def test_simplify_neg_8_5_combined := [llvmfunc|
  llvm.func @test_simplify_neg_8_5(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-9 : i32) : i32
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    %2 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, i32) -> f32
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }]

theorem inst_combine_test_simplify_neg_8_5   : test_simplify_neg_8_5_before  ⊑  test_simplify_neg_8_5_combined := by
  unfold test_simplify_neg_8_5_before test_simplify_neg_8_5_combined
  simp_alive_peephole
  sorry
def test_simplify_7_5_combined := [llvmfunc|
  llvm.func @test_simplify_7_5(%arg0: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>) -> vector<2xf64>
    %2 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<2xf64>, i32) -> vector<2xf64>
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }]

theorem inst_combine_test_simplify_7_5   : test_simplify_7_5_before  ⊑  test_simplify_7_5_combined := by
  unfold test_simplify_7_5_before test_simplify_7_5_combined
  simp_alive_peephole
  sorry
def test_simplify_3_5_combined := [llvmfunc|
  llvm.func @test_simplify_3_5(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.intr.sqrt(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<4xf32>) -> vector<4xf32>
    %2 = llvm.intr.powi(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<4xf32>, i32) -> vector<4xf32>
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_test_simplify_3_5   : test_simplify_3_5_before  ⊑  test_simplify_3_5_combined := by
  unfold test_simplify_3_5_before test_simplify_3_5_combined
  simp_alive_peephole
  sorry
def shrink_pow_libcall_half_combined := [llvmfunc|
  llvm.func @shrink_pow_libcall_half(%arg0: f32) -> f32 {
    %0 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_shrink_pow_libcall_half   : shrink_pow_libcall_half_before  ⊑  shrink_pow_libcall_half_combined := by
  unfold shrink_pow_libcall_half_before shrink_pow_libcall_half_combined
  simp_alive_peephole
  sorry
def PR43233_combined := [llvmfunc|
  llvm.func @PR43233(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_PR43233   : PR43233_before  ⊑  PR43233_combined := by
  unfold PR43233_before PR43233_combined
  simp_alive_peephole
  sorry
