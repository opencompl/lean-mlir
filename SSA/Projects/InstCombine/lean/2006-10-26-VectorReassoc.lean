import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-10-26-VectorReassoc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_fmul_before := [llvmfunc|
  llvm.func @test_fmul(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  : vector<4xf32>
    %3 = llvm.fmul %2, %1  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

def test_fmul_fast_before := [llvmfunc|
  llvm.func @test_fmul_fast(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>]

    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>]

    llvm.return %3 : vector<4xf32>
  }]

def test_fmul_reassoc_nsz_before := [llvmfunc|
  llvm.func @test_fmul_reassoc_nsz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

    llvm.return %3 : vector<4xf32>
  }]

def test_fmul_reassoc_before := [llvmfunc|
  llvm.func @test_fmul_reassoc(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>]

    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>]

    llvm.return %3 : vector<4xf32>
  }]

def test_fadd_before := [llvmfunc|
  llvm.func @test_fadd(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %2, %1  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

def test_fadd_fast_before := [llvmfunc|
  llvm.func @test_fadd_fast(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>]

    llvm.return %3 : vector<4xf32>
  }]

def test_fadd_reassoc_nsz_before := [llvmfunc|
  llvm.func @test_fadd_reassoc_nsz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

    llvm.return %3 : vector<4xf32>
  }]

def test_fadd_reassoc_before := [llvmfunc|
  llvm.func @test_fadd_reassoc(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>]

    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>]

    llvm.return %3 : vector<4xf32>
  }]

def test_fadds_cancel__before := [llvmfunc|
  llvm.func @test_fadds_cancel_(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %arg1, %1  : vector<4xf32>
    %4 = llvm.fadd %2, %3  : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

def test_fadds_cancel_fast_before := [llvmfunc|
  llvm.func @test_fadds_cancel_fast(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>]

    %3 = llvm.fadd %arg1, %1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>]

    llvm.return %4 : vector<4xf32>
  }]

def test_fadds_cancel_reassoc_nsz_before := [llvmfunc|
  llvm.func @test_fadds_cancel_reassoc_nsz(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

    %3 = llvm.fadd %arg1, %1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>]

    llvm.return %4 : vector<4xf32>
  }]

def test_fadds_cancel_reassoc_before := [llvmfunc|
  llvm.func @test_fadds_cancel_reassoc(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>]

    %3 = llvm.fadd %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>]

    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>]

    llvm.return %4 : vector<4xf32>
  }]

def test_fmul_combined := [llvmfunc|
  llvm.func @test_fmul(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  : vector<4xf32>
    %3 = llvm.fmul %2, %1  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_test_fmul   : test_fmul_before  ⊑  test_fmul_combined := by
  unfold test_fmul_before test_fmul_combined
  simp_alive_peephole
  sorry
def test_fmul_fast_combined := [llvmfunc|
  llvm.func @test_fmul_fast(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 4.000000e+05, -9.000000e+00, 1.600000e+01]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_test_fmul_fast   : test_fmul_fast_before  ⊑  test_fmul_fast_combined := by
  unfold test_fmul_fast_before test_fmul_fast_combined
  simp_alive_peephole
  sorry
def test_fmul_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test_fmul_reassoc_nsz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 4.000000e+05, -9.000000e+00, 1.600000e+01]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_test_fmul_reassoc_nsz   : test_fmul_reassoc_nsz_before  ⊑  test_fmul_reassoc_nsz_combined := by
  unfold test_fmul_reassoc_nsz_before test_fmul_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test_fmul_reassoc_combined := [llvmfunc|
  llvm.func @test_fmul_reassoc(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+05, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_test_fmul_reassoc   : test_fmul_reassoc_before  ⊑  test_fmul_reassoc_combined := by
  unfold test_fmul_reassoc_before test_fmul_reassoc_combined
  simp_alive_peephole
  sorry
def test_fadd_combined := [llvmfunc|
  llvm.func @test_fadd(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %2, %1  : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_test_fadd   : test_fadd_before  ⊑  test_fadd_combined := by
  unfold test_fadd_before test_fadd_combined
  simp_alive_peephole
  sorry
def test_fadd_fast_combined := [llvmfunc|
  llvm.func @test_fadd_fast(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[2.000000e+00, 4.000000e+00, 0.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_test_fadd_fast   : test_fadd_fast_before  ⊑  test_fadd_fast_combined := by
  unfold test_fadd_fast_before test_fadd_fast_combined
  simp_alive_peephole
  sorry
def test_fadd_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test_fadd_reassoc_nsz(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[2.000000e+00, 4.000000e+00, 0.000000e+00, 8.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }]

theorem inst_combine_test_fadd_reassoc_nsz   : test_fadd_reassoc_nsz_before  ⊑  test_fadd_reassoc_nsz_combined := by
  unfold test_fadd_reassoc_nsz_before test_fadd_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test_fadd_reassoc_combined := [llvmfunc|
  llvm.func @test_fadd_reassoc(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, -3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    %3 = llvm.fadd %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }]

theorem inst_combine_test_fadd_reassoc   : test_fadd_reassoc_before  ⊑  test_fadd_reassoc_combined := by
  unfold test_fadd_reassoc_before test_fadd_reassoc_combined
  simp_alive_peephole
  sorry
def test_fadds_cancel__combined := [llvmfunc|
  llvm.func @test_fadds_cancel_(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.fadd %arg1, %1  : vector<4xf32>
    %4 = llvm.fadd %2, %3  : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_test_fadds_cancel_   : test_fadds_cancel__before  ⊑  test_fadds_cancel__combined := by
  unfold test_fadds_cancel__before test_fadds_cancel__combined
  simp_alive_peephole
  sorry
def test_fadds_cancel_fast_combined := [llvmfunc|
  llvm.func @test_fadds_cancel_fast(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : vector<4xf32>
    llvm.return %0 : vector<4xf32>
  }]

theorem inst_combine_test_fadds_cancel_fast   : test_fadds_cancel_fast_before  ⊑  test_fadds_cancel_fast_combined := by
  unfold test_fadds_cancel_fast_before test_fadds_cancel_fast_combined
  simp_alive_peephole
  sorry
def test_fadds_cancel_reassoc_nsz_combined := [llvmfunc|
  llvm.func @test_fadds_cancel_reassoc_nsz(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : vector<4xf32>
    llvm.return %0 : vector<4xf32>
  }]

theorem inst_combine_test_fadds_cancel_reassoc_nsz   : test_fadds_cancel_reassoc_nsz_before  ⊑  test_fadds_cancel_reassoc_nsz_combined := by
  unfold test_fadds_cancel_reassoc_nsz_before test_fadds_cancel_reassoc_nsz_combined
  simp_alive_peephole
  sorry
def test_fadds_cancel_reassoc_combined := [llvmfunc|
  llvm.func @test_fadds_cancel_reassoc(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<[-1.000000e+00, -2.000000e+00, -3.000000e+00, -4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.fadd %arg0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    %3 = llvm.fadd %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }]

theorem inst_combine_test_fadds_cancel_reassoc   : test_fadds_cancel_reassoc_before  ⊑  test_fadds_cancel_reassoc_combined := by
  unfold test_fadds_cancel_reassoc_before test_fadds_cancel_reassoc_combined
  simp_alive_peephole
  sorry
