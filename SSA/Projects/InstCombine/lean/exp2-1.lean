import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  exp2-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify2_before := [llvmfunc|
  llvm.func @test_simplify2(%arg0: i16 {llvm.signext}) -> f64 {
    %0 = llvm.sitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify3_before := [llvmfunc|
  llvm.func @test_simplify3(%arg0: i8 {llvm.signext}) -> f64 {
    %0 = llvm.sitofp %arg0 : i8 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify4_before := [llvmfunc|
  llvm.func @test_simplify4(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.call @exp2f(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def test_no_simplify1_before := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify6_before := [llvmfunc|
  llvm.func @test_simplify6(%arg0: i16 {llvm.zeroext}) -> f64 {
    %0 = llvm.uitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify7_before := [llvmfunc|
  llvm.func @test_simplify7(%arg0: i8 {llvm.zeroext}) -> f64 {
    %0 = llvm.uitofp %arg0 : i8 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify8_before := [llvmfunc|
  llvm.func @test_simplify8(%arg0: i8 {llvm.zeroext}) -> f32 {
    %0 = llvm.uitofp %arg0 : i8 to f32
    %1 = llvm.call @exp2f(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def test_simplify9_before := [llvmfunc|
  llvm.func @test_simplify9(%arg0: i8 {llvm.zeroext}) -> f64 {
    %0 = llvm.uitofp %arg0 : i8 to f64
    %1 = llvm.intr.exp2(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_simplify10_before := [llvmfunc|
  llvm.func @test_simplify10(%arg0: i8 {llvm.zeroext}) -> f32 {
    %0 = llvm.uitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def sitofp_scalar_intrinsic_with_FMF_before := [llvmfunc|
  llvm.func @sitofp_scalar_intrinsic_with_FMF(%arg0: i8) -> f32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def sitofp_vector_intrinsic_with_FMF_before := [llvmfunc|
  llvm.func @sitofp_vector_intrinsic_with_FMF(%arg0: vector<2xi8>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf32>
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<2xf32>) -> vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def test_readonly_exp2_f64_of_sitofp_before := [llvmfunc|
  llvm.func @test_readonly_exp2_f64_of_sitofp(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def test_readonly_exp2f_f32_of_sitofp_before := [llvmfunc|
  llvm.func @test_readonly_exp2f_f32_of_sitofp(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.call @exp2f(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def test_readonly_exp2l_fp128_of_sitofp_before := [llvmfunc|
  llvm.func @test_readonly_exp2l_fp128_of_sitofp(%arg0: i32) -> f128 {
    %0 = llvm.sitofp %arg0 : i32 to f128
    %1 = llvm.call @exp2l(%0) : (f128) -> f128
    llvm.return %1 : f128
  }]

def test_readonly_exp2f_f32_of_sitofp_flags_before := [llvmfunc|
  llvm.func @test_readonly_exp2f_f32_of_sitofp_flags(%arg0: i32) -> f32 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.call @exp2f(%0) {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @ldexp(%0, %arg0) : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify2_combined := [llvmfunc|
  llvm.func @test_simplify2(%arg0: i16 {llvm.signext}) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.call @ldexp(%0, %1) : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_simplify2   : test_simplify2_before  ⊑  test_simplify2_combined := by
  unfold test_simplify2_before test_simplify2_combined
  simp_alive_peephole
  sorry
def test_simplify3_combined := [llvmfunc|
  llvm.func @test_simplify3(%arg0: i8 {llvm.signext}) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.call @ldexp(%0, %1) : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_simplify3   : test_simplify3_before  ⊑  test_simplify3_combined := by
  unfold test_simplify3_before test_simplify3_combined
  simp_alive_peephole
  sorry
def test_simplify4_combined := [llvmfunc|
  llvm.func @test_simplify4(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @ldexpf(%0, %arg0) : (f32, i32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_simplify4   : test_simplify4_before  ⊑  test_simplify4_combined := by
  unfold test_simplify4_before test_simplify4_combined
  simp_alive_peephole
  sorry
def test_no_simplify1_combined := [llvmfunc|
  llvm.func @test_no_simplify1(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_no_simplify1   : test_no_simplify1_before  ⊑  test_no_simplify1_combined := by
  unfold test_no_simplify1_before test_no_simplify1_combined
  simp_alive_peephole
  sorry
def test_simplify6_combined := [llvmfunc|
  llvm.func @test_simplify6(%arg0: i16 {llvm.zeroext}) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.call @ldexp(%0, %1) : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_simplify6   : test_simplify6_before  ⊑  test_simplify6_combined := by
  unfold test_simplify6_before test_simplify6_combined
  simp_alive_peephole
  sorry
def test_simplify7_combined := [llvmfunc|
  llvm.func @test_simplify7(%arg0: i8 {llvm.zeroext}) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.call @ldexp(%0, %1) : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_simplify7   : test_simplify7_before  ⊑  test_simplify7_combined := by
  unfold test_simplify7_before test_simplify7_combined
  simp_alive_peephole
  sorry
def test_simplify8_combined := [llvmfunc|
  llvm.func @test_simplify8(%arg0: i8 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.call @ldexpf(%0, %1) : (f32, i32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test_simplify8   : test_simplify8_before  ⊑  test_simplify8_combined := by
  unfold test_simplify8_before test_simplify8_combined
  simp_alive_peephole
  sorry
def test_simplify9_combined := [llvmfunc|
  llvm.func @test_simplify9(%arg0: i8 {llvm.zeroext}) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.call @ldexp(%0, %1) : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_test_simplify9   : test_simplify9_before  ⊑  test_simplify9_combined := by
  unfold test_simplify9_before test_simplify9_combined
  simp_alive_peephole
  sorry
def test_simplify10_combined := [llvmfunc|
  llvm.func @test_simplify10(%arg0: i8 {llvm.zeroext}) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.call @ldexpf(%0, %1) : (f32, i32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test_simplify10   : test_simplify10_before  ⊑  test_simplify10_combined := by
  unfold test_simplify10_before test_simplify10_combined
  simp_alive_peephole
  sorry
def sitofp_scalar_intrinsic_with_FMF_combined := [llvmfunc|
  llvm.func @sitofp_scalar_intrinsic_with_FMF(%arg0: i8) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.call @ldexpf(%0, %1) {fastmathFlags = #llvm.fastmath<nnan>} : (f32, i32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_sitofp_scalar_intrinsic_with_FMF   : sitofp_scalar_intrinsic_with_FMF_before  ⊑  sitofp_scalar_intrinsic_with_FMF_combined := by
  unfold sitofp_scalar_intrinsic_with_FMF_before sitofp_scalar_intrinsic_with_FMF_combined
  simp_alive_peephole
  sorry
def sitofp_vector_intrinsic_with_FMF_combined := [llvmfunc|
  llvm.func @sitofp_vector_intrinsic_with_FMF(%arg0: vector<2xi8>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf32>
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<nnan>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_sitofp_vector_intrinsic_with_FMF   : sitofp_vector_intrinsic_with_FMF_before  ⊑  sitofp_vector_intrinsic_with_FMF_combined := by
  unfold sitofp_vector_intrinsic_with_FMF_before sitofp_vector_intrinsic_with_FMF_combined
  simp_alive_peephole
  sorry
def test_readonly_exp2_f64_of_sitofp_combined := [llvmfunc|
  llvm.func @test_readonly_exp2_f64_of_sitofp(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @ldexp(%0, %arg0) : (f64, i32) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_test_readonly_exp2_f64_of_sitofp   : test_readonly_exp2_f64_of_sitofp_before  ⊑  test_readonly_exp2_f64_of_sitofp_combined := by
  unfold test_readonly_exp2_f64_of_sitofp_before test_readonly_exp2_f64_of_sitofp_combined
  simp_alive_peephole
  sorry
def test_readonly_exp2f_f32_of_sitofp_combined := [llvmfunc|
  llvm.func @test_readonly_exp2f_f32_of_sitofp(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @ldexpf(%0, %arg0) : (f32, i32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_readonly_exp2f_f32_of_sitofp   : test_readonly_exp2f_f32_of_sitofp_before  ⊑  test_readonly_exp2f_f32_of_sitofp_combined := by
  unfold test_readonly_exp2f_f32_of_sitofp_before test_readonly_exp2f_f32_of_sitofp_combined
  simp_alive_peephole
  sorry
def test_readonly_exp2l_fp128_of_sitofp_combined := [llvmfunc|
  llvm.func @test_readonly_exp2l_fp128_of_sitofp(%arg0: i32) -> f128 {
    %0 = llvm.mlir.constant(1.000000e+00 : f128) : f128
    %1 = llvm.call @ldexpl(%0, %arg0) : (f128, i32) -> f128
    llvm.return %1 : f128
  }]

theorem inst_combine_test_readonly_exp2l_fp128_of_sitofp   : test_readonly_exp2l_fp128_of_sitofp_before  ⊑  test_readonly_exp2l_fp128_of_sitofp_combined := by
  unfold test_readonly_exp2l_fp128_of_sitofp_before test_readonly_exp2l_fp128_of_sitofp_combined
  simp_alive_peephole
  sorry
def test_readonly_exp2f_f32_of_sitofp_flags_combined := [llvmfunc|
  llvm.func @test_readonly_exp2f_f32_of_sitofp_flags(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @ldexpf(%0, %arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32, i32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test_readonly_exp2f_f32_of_sitofp_flags   : test_readonly_exp2f_f32_of_sitofp_flags_before  ⊑  test_readonly_exp2f_f32_of_sitofp_flags_combined := by
  unfold test_readonly_exp2f_f32_of_sitofp_flags_before test_readonly_exp2f_f32_of_sitofp_flags_combined
  simp_alive_peephole
  sorry
