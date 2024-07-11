import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sincospi
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_instbased_f32_before := [llvmfunc|
  llvm.func @test_instbased_f32() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var32 : !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %3 = llvm.call @__sinpif(%2) : (f32) -> f32
    %4 = llvm.call @__cospif(%2) : (f32) -> f32
    %5 = llvm.fadd %3, %4  : f32
    llvm.return %5 : f32
  }]

def test_instbased_f32_other_user_before := [llvmfunc|
  llvm.func @test_instbased_f32_other_user(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var32 : !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32]

    llvm.store %2, %arg0 {alignment = 4 : i64} : f32, !llvm.ptr]

    %3 = llvm.call @__sinpif(%2) : (f32) -> f32
    %4 = llvm.call @__cospif(%2) : (f32) -> f32
    %5 = llvm.fadd %3, %4  : f32
    llvm.return %5 : f32
  }]

def test_constant_f32_before := [llvmfunc|
  llvm.func @test_constant_f32() -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @__sinpif(%0) : (f32) -> f32
    %2 = llvm.call @__cospif(%0) : (f32) -> f32
    %3 = llvm.fadd %1, %2  : f32
    llvm.return %3 : f32
  }]

def test_instbased_f64_before := [llvmfunc|
  llvm.func @test_instbased_f64() -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.addressof @var64 : !llvm.ptr
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %3 = llvm.call @__sinpi(%2) : (f64) -> f64
    %4 = llvm.call @__cospi(%2) : (f64) -> f64
    %5 = llvm.fadd %3, %4  : f64
    llvm.return %5 : f64
  }]

def test_constant_f64_before := [llvmfunc|
  llvm.func @test_constant_f64() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @__sinpi(%0) : (f64) -> f64
    %2 = llvm.call @__cospi(%0) : (f64) -> f64
    %3 = llvm.fadd %1, %2  : f64
    llvm.return %3 : f64
  }]

def test_fptr_before := [llvmfunc|
  llvm.func @test_fptr(%arg0: !llvm.ptr, %arg1: f64) -> f64 {
    %0 = llvm.call @__sinpi(%arg1) : (f64) -> f64
    %1 = llvm.call %arg0(%arg1) : !llvm.ptr, (f64) -> f64
    %2 = llvm.fadd %0, %1  : f64
    llvm.return %2 : f64
  }]

def test_cospif_used_in_branch_cond_before := [llvmfunc|
  llvm.func @test_cospif_used_in_branch_cond() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.call @__cospif(%0) : (f32) -> f32
    %4 = llvm.fcmp "uno" %3, %0 : f32
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

def test_instbased_f32_combined := [llvmfunc|
  llvm.func @test_instbased_f32() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var32 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_test_instbased_f32   : test_instbased_f32_before  ⊑  test_instbased_f32_combined := by
  unfold test_instbased_f32_before test_instbased_f32_combined
  simp_alive_peephole
  sorry
    %5 = llvm.call @__sincospif_stret(%4) : (f32) -> vector<2xf32>
    %6 = llvm.extractelement %5[%2 : i64] : vector<2xf32>
    %7 = llvm.extractelement %5[%3 : i64] : vector<2xf32>
    %8 = llvm.call @__cospif(%4) : (f32) -> f32
    %9 = llvm.fadd %6, %7  : f32
    llvm.return %9 : f32
  }]

theorem inst_combine_test_instbased_f32   : test_instbased_f32_before  ⊑  test_instbased_f32_combined := by
  unfold test_instbased_f32_before test_instbased_f32_combined
  simp_alive_peephole
  sorry
def test_instbased_f32_other_user_combined := [llvmfunc|
  llvm.func @test_instbased_f32_other_user(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var32 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_test_instbased_f32_other_user   : test_instbased_f32_other_user_before  ⊑  test_instbased_f32_other_user_combined := by
  unfold test_instbased_f32_other_user_before test_instbased_f32_other_user_combined
  simp_alive_peephole
  sorry
    %5 = llvm.call @__sincospif_stret(%4) : (f32) -> vector<2xf32>
    %6 = llvm.extractelement %5[%2 : i64] : vector<2xf32>
    %7 = llvm.extractelement %5[%3 : i64] : vector<2xf32>
    llvm.store %4, %arg0 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_test_instbased_f32_other_user   : test_instbased_f32_other_user_before  ⊑  test_instbased_f32_other_user_combined := by
  unfold test_instbased_f32_other_user_before test_instbased_f32_other_user_combined
  simp_alive_peephole
  sorry
    %8 = llvm.call @__cospif(%4) : (f32) -> f32
    %9 = llvm.fadd %6, %7  : f32
    llvm.return %9 : f32
  }]

theorem inst_combine_test_instbased_f32_other_user   : test_instbased_f32_other_user_before  ⊑  test_instbased_f32_other_user_combined := by
  unfold test_instbased_f32_other_user_before test_instbased_f32_other_user_combined
  simp_alive_peephole
  sorry
def test_constant_f32_combined := [llvmfunc|
  llvm.func @test_constant_f32() -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.call @__sincospif_stret(%0) : (f32) -> vector<2xf32>
    %4 = llvm.extractelement %3[%1 : i64] : vector<2xf32>
    %5 = llvm.extractelement %3[%2 : i64] : vector<2xf32>
    %6 = llvm.call @__cospif(%0) : (f32) -> f32
    %7 = llvm.fadd %4, %5  : f32
    llvm.return %7 : f32
  }]

theorem inst_combine_test_constant_f32   : test_constant_f32_before  ⊑  test_constant_f32_combined := by
  unfold test_constant_f32_before test_constant_f32_combined
  simp_alive_peephole
  sorry
def test_instbased_f64_combined := [llvmfunc|
  llvm.func @test_instbased_f64() -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.addressof @var64 : !llvm.ptr
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine_test_instbased_f64   : test_instbased_f64_before  ⊑  test_instbased_f64_combined := by
  unfold test_instbased_f64_before test_instbased_f64_combined
  simp_alive_peephole
  sorry
    %3 = llvm.call @__sincospi_stret(%2) : (f64) -> !llvm.struct<(f64, f64)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(f64, f64)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(f64, f64)> 
    %6 = llvm.call @__cospi(%2) : (f64) -> f64
    %7 = llvm.fadd %4, %5  : f64
    llvm.return %7 : f64
  }]

theorem inst_combine_test_instbased_f64   : test_instbased_f64_before  ⊑  test_instbased_f64_combined := by
  unfold test_instbased_f64_before test_instbased_f64_combined
  simp_alive_peephole
  sorry
def test_constant_f64_combined := [llvmfunc|
  llvm.func @test_constant_f64() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @__sincospi_stret(%0) : (f64) -> !llvm.struct<(f64, f64)>
    %2 = llvm.extractvalue %1[0] : !llvm.struct<(f64, f64)> 
    %3 = llvm.extractvalue %1[1] : !llvm.struct<(f64, f64)> 
    %4 = llvm.call @__cospi(%0) : (f64) -> f64
    %5 = llvm.fadd %2, %3  : f64
    llvm.return %5 : f64
  }]

theorem inst_combine_test_constant_f64   : test_constant_f64_before  ⊑  test_constant_f64_combined := by
  unfold test_constant_f64_before test_constant_f64_combined
  simp_alive_peephole
  sorry
def test_fptr_combined := [llvmfunc|
  llvm.func @test_fptr(%arg0: !llvm.ptr, %arg1: f64) -> f64 {
    %0 = llvm.call @__sinpi(%arg1) : (f64) -> f64
    %1 = llvm.call %arg0(%arg1) : !llvm.ptr, (f64) -> f64
    %2 = llvm.fadd %0, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_fptr   : test_fptr_before  ⊑  test_fptr_combined := by
  unfold test_fptr_before test_fptr_combined
  simp_alive_peephole
  sorry
def test_cospif_used_in_branch_cond_combined := [llvmfunc|
  llvm.func @test_cospif_used_in_branch_cond() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.call @__cospif(%0) : (f32) -> f32
    %4 = llvm.fcmp "uno" %3, %0 : f32
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }]

theorem inst_combine_test_cospif_used_in_branch_cond   : test_cospif_used_in_branch_cond_before  ⊑  test_cospif_used_in_branch_cond_combined := by
  unfold test_cospif_used_in_branch_cond_before test_cospif_used_in_branch_cond_combined
  simp_alive_peephole
  sorry
