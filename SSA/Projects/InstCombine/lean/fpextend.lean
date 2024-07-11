import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fpextend
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fadd %1, %0  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: f32, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fmul %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: f32, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fsub %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test4_unary_fneg_before := [llvmfunc|
  llvm.func @test4_unary_fneg(%arg0: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fneg %0  : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: vector<2xf32>) -> vector<2xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %3 = llvm.fadd %2, %1  : vector<2xf64>
    %4 = llvm.fptrunc %3 : vector<2xf64> to vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: vector<2xf32>) -> vector<2xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fadd %1, %0  : vector<2xf64>
    %3 = llvm.fptrunc %2 : vector<2xf64> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def test6_undef_before := [llvmfunc|
  llvm.func @test6_undef(%arg0: vector<2xf32>) -> vector<2xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %8 = llvm.fadd %7, %6  : vector<2xf64>
    %9 = llvm.fptrunc %8 : vector<2xf64> to vector<2xf32>
    llvm.return %9 : vector<2xf32>
  }]

def not_half_shrinkable_before := [llvmfunc|
  llvm.func @not_half_shrinkable(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, 2.049000e+03]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fadd %1, %0  : vector<2xf64>
    %3 = llvm.fptrunc %2 : vector<2xf64> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: f32) -> f16 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: f16, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.fmul %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: f16, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fmul %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fadd %1, %0  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: f32, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.fadd %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: f16, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: f32, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: f16, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: f16, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.frem %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: f32, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.frem %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: f16, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.frem %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def ItoFtoF_s25_f32_f64_before := [llvmfunc|
  llvm.func @ItoFtoF_s25_f32_f64(%arg0: i25) -> f64 {
    %0 = llvm.sitofp %arg0 : i25 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

def ItoFtoF_u24_f32_f128_before := [llvmfunc|
  llvm.func @ItoFtoF_u24_f32_f128(%arg0: i24) -> f128 {
    %0 = llvm.uitofp %arg0 : i24 to f32
    %1 = llvm.fpext %0 : f32 to f128
    llvm.return %1 : f128
  }]

def ItoFtoF_s26_f32_f64_before := [llvmfunc|
  llvm.func @ItoFtoF_s26_f32_f64(%arg0: i26) -> f64 {
    %0 = llvm.sitofp %arg0 : i26 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

def ItoFtoF_u25_f32_f64_before := [llvmfunc|
  llvm.func @ItoFtoF_u25_f32_f64(%arg0: i25) -> f64 {
    %0 = llvm.uitofp %arg0 : i25 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

def FtoItoFtoF_f32_s32_f32_f64_before := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_s32_f32_f64(%arg0: f32) -> f64 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.sitofp %0 : i32 to f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

def FtoItoFtoF_f32_u32_f32_f64_extra_uses_before := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_u32_f32_f64_extra_uses(%arg0: f32) -> f64 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.call @use_i32(%0) : (i32) -> ()
    %1 = llvm.uitofp %0 : i32 to f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

def FtoItoFtoF_v3f16_v3s32_v3f32_v3f64_before := [llvmfunc|
  llvm.func @FtoItoFtoF_v3f16_v3s32_v3f32_v3f64(%arg0: vector<3xf16>) -> vector<3xf64> {
    %0 = llvm.fptosi %arg0 : vector<3xf16> to vector<3xi32>
    %1 = llvm.sitofp %0 : vector<3xi32> to vector<3xf32>
    %2 = llvm.fpext %1 : vector<3xf32> to vector<3xf64>
    llvm.return %2 : vector<3xf64>
  }]

def FtoItoFtoF_f32_s64_f64_f128_before := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_s64_f64_f128(%arg0: f32) -> f128 {
    %0 = llvm.fptosi %arg0 : f32 to i64
    %1 = llvm.sitofp %0 : i64 to f64
    %2 = llvm.fpext %1 : f64 to f128
    llvm.return %2 : f128
  }]

def FtoItoFtoF_f64_u54_f64_f80_before := [llvmfunc|
  llvm.func @FtoItoFtoF_f64_u54_f64_f80(%arg0: f64) -> f80 {
    %0 = llvm.fptoui %arg0 : f64 to i54
    %1 = llvm.uitofp %0 : i54 to f64
    %2 = llvm.fpext %1 : f64 to f80
    llvm.return %2 : f80
  }]

def FtoItoFtoF_f64_u54_f64_p128_before := [llvmfunc|
  llvm.func @FtoItoFtoF_f64_u54_f64_p128(%arg0: f64) -> !llvm.ppc_fp128 {
    %0 = llvm.fptoui %arg0 : f64 to i54
    %1 = llvm.uitofp %0 : i54 to f64
    %2 = llvm.fpext %1 : f64 to !llvm.ppc_fp128
    llvm.return %2 : !llvm.ppc_fp128
  }]

def FtoItoFtoF_f32_us32_f32_f64_before := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_us32_f32_f64(%arg0: f32) -> f64 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    %1 = llvm.sitofp %0 : i32 to f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

def FtoItoFtoF_f32_su32_f32_f64_before := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_su32_f32_f64(%arg0: f32) -> f64 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.uitofp %0 : i32 to f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

def bf16_to_f32_to_f16_before := [llvmfunc|
  llvm.func @bf16_to_f32_to_f16(%arg0: bf16) -> f16 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : bf16 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

def bf16_frem_before := [llvmfunc|
  llvm.func @bf16_frem(%arg0: bf16) -> bf16 {
    %0 = llvm.mlir.constant(6.281250e+00 : f32) : f32
    %1 = llvm.fpext %arg0 : bf16 to f32
    %2 = llvm.frem %1, %0  : f32
    %3 = llvm.fptrunc %2 : f32 to bf16
    llvm.return %3 : bf16
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fadd %arg0, %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: f32, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fmul %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: f32, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fdiv %arg0, %arg1  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fneg %arg0  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test4_unary_fneg_combined := [llvmfunc|
  llvm.func @test4_unary_fneg(%arg0: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fneg %arg0  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test4_unary_fneg   : test4_unary_fneg_before  ⊑  test4_unary_fneg_combined := by
  unfold test4_unary_fneg_before test4_unary_fneg_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: vector<2xf32>) -> vector<2xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fadd %arg0, %1  : vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: vector<2xf32>) -> vector<2xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6_undef_combined := [llvmfunc|
  llvm.func @test6_undef(%arg0: vector<2xf32>) -> vector<2xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fadd %arg0, %6  : vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }]

theorem inst_combine_test6_undef   : test6_undef_before  ⊑  test6_undef_combined := by
  unfold test6_undef_before test6_undef_combined
  simp_alive_peephole
  sorry
def not_half_shrinkable_combined := [llvmfunc|
  llvm.func @not_half_shrinkable(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, 2.049000e+03]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fadd %arg0, %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_not_half_shrinkable   : not_half_shrinkable_before  ⊑  not_half_shrinkable_combined := by
  unfold not_half_shrinkable_before not_half_shrinkable_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: f32) -> f16 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fptrunc %arg0 : f32 to f16
    llvm.return %0 : f16
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f32
    llvm.return %0 : f32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: f16, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.fpext %arg1 : f16 to f32
    %2 = llvm.fmul %0, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: f16, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.fmul %0, %arg1  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fpext %arg0 : f16 to f32
    %2 = llvm.fadd %1, %0  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: f32, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg1 : f16 to f32
    %1 = llvm.fadd %0, %arg0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: f16, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.fdiv %0, %arg1  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: f32, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg1 : f16 to f32
    %1 = llvm.fdiv %arg0, %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: f16, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.fpext %arg1 : f16 to f32
    %2 = llvm.fdiv %0, %1  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: f16, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f32
    %1 = llvm.frem %0, %arg1  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: f32, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg1 : f16 to f32
    %1 = llvm.frem %arg0, %0  : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: f16, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.frem %arg0, %arg1  : f16
    %1 = llvm.fpext %0 : f16 to f32
    llvm.return %1 : f32
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def ItoFtoF_s25_f32_f64_combined := [llvmfunc|
  llvm.func @ItoFtoF_s25_f32_f64(%arg0: i25) -> f64 {
    %0 = llvm.sitofp %arg0 : i25 to f64
    llvm.return %0 : f64
  }]

theorem inst_combine_ItoFtoF_s25_f32_f64   : ItoFtoF_s25_f32_f64_before  ⊑  ItoFtoF_s25_f32_f64_combined := by
  unfold ItoFtoF_s25_f32_f64_before ItoFtoF_s25_f32_f64_combined
  simp_alive_peephole
  sorry
def ItoFtoF_u24_f32_f128_combined := [llvmfunc|
  llvm.func @ItoFtoF_u24_f32_f128(%arg0: i24) -> f128 {
    %0 = llvm.uitofp %arg0 : i24 to f128
    llvm.return %0 : f128
  }]

theorem inst_combine_ItoFtoF_u24_f32_f128   : ItoFtoF_u24_f32_f128_before  ⊑  ItoFtoF_u24_f32_f128_combined := by
  unfold ItoFtoF_u24_f32_f128_before ItoFtoF_u24_f32_f128_combined
  simp_alive_peephole
  sorry
def ItoFtoF_s26_f32_f64_combined := [llvmfunc|
  llvm.func @ItoFtoF_s26_f32_f64(%arg0: i26) -> f64 {
    %0 = llvm.sitofp %arg0 : i26 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

theorem inst_combine_ItoFtoF_s26_f32_f64   : ItoFtoF_s26_f32_f64_before  ⊑  ItoFtoF_s26_f32_f64_combined := by
  unfold ItoFtoF_s26_f32_f64_before ItoFtoF_s26_f32_f64_combined
  simp_alive_peephole
  sorry
def ItoFtoF_u25_f32_f64_combined := [llvmfunc|
  llvm.func @ItoFtoF_u25_f32_f64(%arg0: i25) -> f64 {
    %0 = llvm.uitofp %arg0 : i25 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

theorem inst_combine_ItoFtoF_u25_f32_f64   : ItoFtoF_u25_f32_f64_before  ⊑  ItoFtoF_u25_f32_f64_combined := by
  unfold ItoFtoF_u25_f32_f64_before ItoFtoF_u25_f32_f64_combined
  simp_alive_peephole
  sorry
def FtoItoFtoF_f32_s32_f32_f64_combined := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_s32_f32_f64(%arg0: f32) -> f64 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.sitofp %0 : i32 to f64
    llvm.return %1 : f64
  }]

theorem inst_combine_FtoItoFtoF_f32_s32_f32_f64   : FtoItoFtoF_f32_s32_f32_f64_before  ⊑  FtoItoFtoF_f32_s32_f32_f64_combined := by
  unfold FtoItoFtoF_f32_s32_f32_f64_before FtoItoFtoF_f32_s32_f32_f64_combined
  simp_alive_peephole
  sorry
def FtoItoFtoF_f32_u32_f32_f64_extra_uses_combined := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_u32_f32_f64_extra_uses(%arg0: f32) -> f64 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.call @use_i32(%0) : (i32) -> ()
    %1 = llvm.uitofp %0 : i32 to f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.uitofp %0 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_FtoItoFtoF_f32_u32_f32_f64_extra_uses   : FtoItoFtoF_f32_u32_f32_f64_extra_uses_before  ⊑  FtoItoFtoF_f32_u32_f32_f64_extra_uses_combined := by
  unfold FtoItoFtoF_f32_u32_f32_f64_extra_uses_before FtoItoFtoF_f32_u32_f32_f64_extra_uses_combined
  simp_alive_peephole
  sorry
def FtoItoFtoF_v3f16_v3s32_v3f32_v3f64_combined := [llvmfunc|
  llvm.func @FtoItoFtoF_v3f16_v3s32_v3f32_v3f64(%arg0: vector<3xf16>) -> vector<3xf64> {
    %0 = llvm.fptosi %arg0 : vector<3xf16> to vector<3xi32>
    %1 = llvm.sitofp %0 : vector<3xi32> to vector<3xf64>
    llvm.return %1 : vector<3xf64>
  }]

theorem inst_combine_FtoItoFtoF_v3f16_v3s32_v3f32_v3f64   : FtoItoFtoF_v3f16_v3s32_v3f32_v3f64_before  ⊑  FtoItoFtoF_v3f16_v3s32_v3f32_v3f64_combined := by
  unfold FtoItoFtoF_v3f16_v3s32_v3f32_v3f64_before FtoItoFtoF_v3f16_v3s32_v3f32_v3f64_combined
  simp_alive_peephole
  sorry
def FtoItoFtoF_f32_s64_f64_f128_combined := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_s64_f64_f128(%arg0: f32) -> f128 {
    %0 = llvm.fptosi %arg0 : f32 to i64
    %1 = llvm.sitofp %0 : i64 to f128
    llvm.return %1 : f128
  }]

theorem inst_combine_FtoItoFtoF_f32_s64_f64_f128   : FtoItoFtoF_f32_s64_f64_f128_before  ⊑  FtoItoFtoF_f32_s64_f64_f128_combined := by
  unfold FtoItoFtoF_f32_s64_f64_f128_before FtoItoFtoF_f32_s64_f64_f128_combined
  simp_alive_peephole
  sorry
def FtoItoFtoF_f64_u54_f64_f80_combined := [llvmfunc|
  llvm.func @FtoItoFtoF_f64_u54_f64_f80(%arg0: f64) -> f80 {
    %0 = llvm.fptoui %arg0 : f64 to i54
    %1 = llvm.uitofp %0 : i54 to f80
    llvm.return %1 : f80
  }]

theorem inst_combine_FtoItoFtoF_f64_u54_f64_f80   : FtoItoFtoF_f64_u54_f64_f80_before  ⊑  FtoItoFtoF_f64_u54_f64_f80_combined := by
  unfold FtoItoFtoF_f64_u54_f64_f80_before FtoItoFtoF_f64_u54_f64_f80_combined
  simp_alive_peephole
  sorry
def FtoItoFtoF_f64_u54_f64_p128_combined := [llvmfunc|
  llvm.func @FtoItoFtoF_f64_u54_f64_p128(%arg0: f64) -> !llvm.ppc_fp128 {
    %0 = llvm.fptoui %arg0 : f64 to i54
    %1 = llvm.uitofp %0 : i54 to !llvm.ppc_fp128
    llvm.return %1 : !llvm.ppc_fp128
  }]

theorem inst_combine_FtoItoFtoF_f64_u54_f64_p128   : FtoItoFtoF_f64_u54_f64_p128_before  ⊑  FtoItoFtoF_f64_u54_f64_p128_combined := by
  unfold FtoItoFtoF_f64_u54_f64_p128_before FtoItoFtoF_f64_u54_f64_p128_combined
  simp_alive_peephole
  sorry
def FtoItoFtoF_f32_us32_f32_f64_combined := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_us32_f32_f64(%arg0: f32) -> f64 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    %1 = llvm.sitofp %0 : i32 to f64
    llvm.return %1 : f64
  }]

theorem inst_combine_FtoItoFtoF_f32_us32_f32_f64   : FtoItoFtoF_f32_us32_f32_f64_before  ⊑  FtoItoFtoF_f32_us32_f32_f64_combined := by
  unfold FtoItoFtoF_f32_us32_f32_f64_before FtoItoFtoF_f32_us32_f32_f64_combined
  simp_alive_peephole
  sorry
def FtoItoFtoF_f32_su32_f32_f64_combined := [llvmfunc|
  llvm.func @FtoItoFtoF_f32_su32_f32_f64(%arg0: f32) -> f64 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.uitofp %0 : i32 to f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_FtoItoFtoF_f32_su32_f32_f64   : FtoItoFtoF_f32_su32_f32_f64_before  ⊑  FtoItoFtoF_f32_su32_f32_f64_combined := by
  unfold FtoItoFtoF_f32_su32_f32_f64_before FtoItoFtoF_f32_su32_f32_f64_combined
  simp_alive_peephole
  sorry
def bf16_to_f32_to_f16_combined := [llvmfunc|
  llvm.func @bf16_to_f32_to_f16(%arg0: bf16) -> f16 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : bf16 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_bf16_to_f32_to_f16   : bf16_to_f32_to_f16_before  ⊑  bf16_to_f32_to_f16_combined := by
  unfold bf16_to_f32_to_f16_before bf16_to_f32_to_f16_combined
  simp_alive_peephole
  sorry
def bf16_frem_combined := [llvmfunc|
  llvm.func @bf16_frem(%arg0: bf16) -> bf16 {
    %0 = llvm.mlir.constant(6.281250e+00 : f16) : f16
    %1 = llvm.fpext %arg0 : bf16 to f32
    %2 = llvm.fptrunc %1 : f32 to f16
    %3 = llvm.frem %2, %0  : f16
    %4 = llvm.bitcast %3 : f16 to bf16
    llvm.return %4 : bf16
  }]

theorem inst_combine_bf16_frem   : bf16_frem_before  ⊑  bf16_frem_combined := by
  unfold bf16_frem_before bf16_frem_combined
  simp_alive_peephole
  sorry
