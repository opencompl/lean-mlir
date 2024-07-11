import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sitofp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1.280000e+02 : f64) : f64
    %1 = llvm.sitofp %arg0 : i8 to f64
    %2 = llvm.fcmp "ult" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1.281000e+02 : f64) : f64
    %1 = llvm.sitofp %arg0 : i8 to f64
    %2 = llvm.fcmp "ugt" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1.270000e+02 : f64) : f64
    %1 = llvm.sitofp %arg0 : i8 to f64
    %2 = llvm.fcmp "ule" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1.270000e+02 : f64) : f64
    %1 = llvm.sitofp %arg0 : i8 to f64
    %2 = llvm.fcmp "ult" %1, %0 : f64
    llvm.return %2 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.fptosi %0 : f64 to i32
    %2 = llvm.uitofp %1 : i32 to f64
    %3 = llvm.fptoui %2 : f64 to i32
    llvm.return %3 : i32
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.sitofp %2 : i32 to f64
    %5 = llvm.sitofp %3 : i32 to f64
    %6 = llvm.fadd %4, %5  : f64
    %7 = llvm.fptosi %6 : f64 to i32
    llvm.return %7 : i32
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i32 {
    %0 = llvm.sitofp %arg0 : i32 to f64
    %1 = llvm.fptoui %0 : f64 to i32
    llvm.return %1 : i32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i32 {
    %0 = llvm.uitofp %arg0 : i32 to f64
    %1 = llvm.fptosi %0 : f64 to i32
    llvm.return %1 : i32
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i8) -> i32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i8) -> i32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.fptosi %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i8 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.fptosi %0 : f32 to i8
    llvm.return %1 : i8
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i8) -> i32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i25) -> i32 {
    %0 = llvm.uitofp %arg0 : i25 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i24) -> i32 {
    %0 = llvm.uitofp %arg0 : i24 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i32) -> i24 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.fptoui %0 : f32 to i24
    llvm.return %1 : i24
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i25) -> i32 {
    %0 = llvm.sitofp %arg0 : i25 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test17_before := [llvmfunc|
  llvm.func @test17(%arg0: i26) -> i32 {
    %0 = llvm.sitofp %arg0 : i26 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test18_before := [llvmfunc|
  llvm.func @test18(%arg0: i64) -> i54 {
    %0 = llvm.sitofp %arg0 : i64 to f64
    %1 = llvm.fptosi %0 : f64 to i54
    llvm.return %1 : i54
  }]

def test19_before := [llvmfunc|
  llvm.func @test19(%arg0: i64) -> i55 {
    %0 = llvm.sitofp %arg0 : i64 to f64
    %1 = llvm.fptosi %0 : f64 to i55
    llvm.return %1 : i55
  }]

def masked_input_before := [llvmfunc|
  llvm.func @masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(65535 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    %2 = llvm.uitofp %1 : i25 to f32
    %3 = llvm.fptoui %2 : f32 to i25
    llvm.return %3 : i25
  }]

def max_masked_input_before := [llvmfunc|
  llvm.func @max_masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(16777215 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    %2 = llvm.uitofp %1 : i25 to f32
    %3 = llvm.fptoui %2 : f32 to i25
    llvm.return %3 : i25
  }]

def consider_lowbits_masked_input_before := [llvmfunc|
  llvm.func @consider_lowbits_masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(-16777214 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    %2 = llvm.uitofp %1 : i25 to f32
    %3 = llvm.fptoui %2 : f32 to i25
    llvm.return %3 : i25
  }]

def overflow_masked_input_before := [llvmfunc|
  llvm.func @overflow_masked_input(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16777217 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptoui %2 : f32 to i32
    llvm.return %3 : i32
  }]

def low_masked_input_before := [llvmfunc|
  llvm.func @low_masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(-2 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    %2 = llvm.uitofp %1 : i25 to f32
    %3 = llvm.fptoui %2 : f32 to i25
    llvm.return %3 : i25
  }]

def s32_half_s11_before := [llvmfunc|
  llvm.func @s32_half_s11(%arg0: i32) -> i11 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i11
    llvm.return %1 : i11
  }]

def s32_half_u11_before := [llvmfunc|
  llvm.func @s32_half_u11(%arg0: i32) -> i11 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i11
    llvm.return %1 : i11
  }]

def u32_half_s11_before := [llvmfunc|
  llvm.func @u32_half_s11(%arg0: i32) -> i11 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i11
    llvm.return %1 : i11
  }]

def u32_half_u11_before := [llvmfunc|
  llvm.func @u32_half_u11(%arg0: i32) -> i11 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i11
    llvm.return %1 : i11
  }]

def s32_half_s12_before := [llvmfunc|
  llvm.func @s32_half_s12(%arg0: i32) -> i12 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i12
    llvm.return %1 : i12
  }]

def s32_half_u12_before := [llvmfunc|
  llvm.func @s32_half_u12(%arg0: i32) -> i12 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i12
    llvm.return %1 : i12
  }]

def u32_half_s12_before := [llvmfunc|
  llvm.func @u32_half_s12(%arg0: i32) -> i12 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i12
    llvm.return %1 : i12
  }]

def u32_half_u12_before := [llvmfunc|
  llvm.func @u32_half_u12(%arg0: i32) -> i12 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i12
    llvm.return %1 : i12
  }]

def i8_vec_sitofp_test1_before := [llvmfunc|
  llvm.func @i8_vec_sitofp_test1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.280000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ult" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

def i8_vec_sitofp_test2_before := [llvmfunc|
  llvm.func @i8_vec_sitofp_test2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1.281000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ugt" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

def i8_vec_sitofp_test3_before := [llvmfunc|
  llvm.func @i8_vec_sitofp_test3(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.270000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ule" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

def i8_vec_sitofp_test4_before := [llvmfunc|
  llvm.func @i8_vec_sitofp_test4(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.270000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ult" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(39 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i8) -> i32 {
    %0 = llvm.sext %arg0 : i8 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i8 {
    %0 = llvm.trunc %arg0 : i32 to i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i8) -> i32 {
    %0 = llvm.zext %arg0 : i8 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i25) -> i32 {
    %0 = llvm.uitofp %arg0 : i25 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i24) -> i32 {
    %0 = llvm.zext %arg0 : i24 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i32) -> i24 {
    %0 = llvm.trunc %arg0 : i32 to i24
    llvm.return %0 : i24
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i25) -> i32 {
    %0 = llvm.zext %arg0 : i25 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test17_combined := [llvmfunc|
  llvm.func @test17(%arg0: i26) -> i32 {
    %0 = llvm.sitofp %arg0 : i26 to f32
    %1 = llvm.fptoui %0 : f32 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test17   : test17_before  ⊑  test17_combined := by
  unfold test17_before test17_combined
  simp_alive_peephole
  sorry
def test18_combined := [llvmfunc|
  llvm.func @test18(%arg0: i64) -> i54 {
    %0 = llvm.sitofp %arg0 : i64 to f64
    %1 = llvm.fptosi %0 : f64 to i54
    llvm.return %1 : i54
  }]

theorem inst_combine_test18   : test18_before  ⊑  test18_combined := by
  unfold test18_before test18_combined
  simp_alive_peephole
  sorry
def test19_combined := [llvmfunc|
  llvm.func @test19(%arg0: i64) -> i55 {
    %0 = llvm.sitofp %arg0 : i64 to f64
    %1 = llvm.fptosi %0 : f64 to i55
    llvm.return %1 : i55
  }]

theorem inst_combine_test19   : test19_before  ⊑  test19_combined := by
  unfold test19_before test19_combined
  simp_alive_peephole
  sorry
def masked_input_combined := [llvmfunc|
  llvm.func @masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(65535 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    llvm.return %1 : i25
  }]

theorem inst_combine_masked_input   : masked_input_before  ⊑  masked_input_combined := by
  unfold masked_input_before masked_input_combined
  simp_alive_peephole
  sorry
def max_masked_input_combined := [llvmfunc|
  llvm.func @max_masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(16777215 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    llvm.return %1 : i25
  }]

theorem inst_combine_max_masked_input   : max_masked_input_before  ⊑  max_masked_input_combined := by
  unfold max_masked_input_before max_masked_input_combined
  simp_alive_peephole
  sorry
def consider_lowbits_masked_input_combined := [llvmfunc|
  llvm.func @consider_lowbits_masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(-16777214 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    llvm.return %1 : i25
  }]

theorem inst_combine_consider_lowbits_masked_input   : consider_lowbits_masked_input_before  ⊑  consider_lowbits_masked_input_combined := by
  unfold consider_lowbits_masked_input_before consider_lowbits_masked_input_combined
  simp_alive_peephole
  sorry
def overflow_masked_input_combined := [llvmfunc|
  llvm.func @overflow_masked_input(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(16777217 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptoui %2 : f32 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_overflow_masked_input   : overflow_masked_input_before  ⊑  overflow_masked_input_combined := by
  unfold overflow_masked_input_before overflow_masked_input_combined
  simp_alive_peephole
  sorry
def low_masked_input_combined := [llvmfunc|
  llvm.func @low_masked_input(%arg0: i25) -> i25 {
    %0 = llvm.mlir.constant(-2 : i25) : i25
    %1 = llvm.and %arg0, %0  : i25
    llvm.return %1 : i25
  }]

theorem inst_combine_low_masked_input   : low_masked_input_before  ⊑  low_masked_input_combined := by
  unfold low_masked_input_before low_masked_input_combined
  simp_alive_peephole
  sorry
def s32_half_s11_combined := [llvmfunc|
  llvm.func @s32_half_s11(%arg0: i32) -> i11 {
    %0 = llvm.trunc %arg0 : i32 to i11
    llvm.return %0 : i11
  }]

theorem inst_combine_s32_half_s11   : s32_half_s11_before  ⊑  s32_half_s11_combined := by
  unfold s32_half_s11_before s32_half_s11_combined
  simp_alive_peephole
  sorry
def s32_half_u11_combined := [llvmfunc|
  llvm.func @s32_half_u11(%arg0: i32) -> i11 {
    %0 = llvm.trunc %arg0 : i32 to i11
    llvm.return %0 : i11
  }]

theorem inst_combine_s32_half_u11   : s32_half_u11_before  ⊑  s32_half_u11_combined := by
  unfold s32_half_u11_before s32_half_u11_combined
  simp_alive_peephole
  sorry
def u32_half_s11_combined := [llvmfunc|
  llvm.func @u32_half_s11(%arg0: i32) -> i11 {
    %0 = llvm.trunc %arg0 : i32 to i11
    llvm.return %0 : i11
  }]

theorem inst_combine_u32_half_s11   : u32_half_s11_before  ⊑  u32_half_s11_combined := by
  unfold u32_half_s11_before u32_half_s11_combined
  simp_alive_peephole
  sorry
def u32_half_u11_combined := [llvmfunc|
  llvm.func @u32_half_u11(%arg0: i32) -> i11 {
    %0 = llvm.trunc %arg0 : i32 to i11
    llvm.return %0 : i11
  }]

theorem inst_combine_u32_half_u11   : u32_half_u11_before  ⊑  u32_half_u11_combined := by
  unfold u32_half_u11_before u32_half_u11_combined
  simp_alive_peephole
  sorry
def s32_half_s12_combined := [llvmfunc|
  llvm.func @s32_half_s12(%arg0: i32) -> i12 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i12
    llvm.return %1 : i12
  }]

theorem inst_combine_s32_half_s12   : s32_half_s12_before  ⊑  s32_half_s12_combined := by
  unfold s32_half_s12_before s32_half_s12_combined
  simp_alive_peephole
  sorry
def s32_half_u12_combined := [llvmfunc|
  llvm.func @s32_half_u12(%arg0: i32) -> i12 {
    %0 = llvm.sitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i12
    llvm.return %1 : i12
  }]

theorem inst_combine_s32_half_u12   : s32_half_u12_before  ⊑  s32_half_u12_combined := by
  unfold s32_half_u12_before s32_half_u12_combined
  simp_alive_peephole
  sorry
def u32_half_s12_combined := [llvmfunc|
  llvm.func @u32_half_s12(%arg0: i32) -> i12 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptosi %0 : f16 to i12
    llvm.return %1 : i12
  }]

theorem inst_combine_u32_half_s12   : u32_half_s12_before  ⊑  u32_half_s12_combined := by
  unfold u32_half_s12_before u32_half_s12_combined
  simp_alive_peephole
  sorry
def u32_half_u12_combined := [llvmfunc|
  llvm.func @u32_half_u12(%arg0: i32) -> i12 {
    %0 = llvm.uitofp %arg0 : i32 to f16
    %1 = llvm.fptoui %0 : f16 to i12
    llvm.return %1 : i12
  }]

theorem inst_combine_u32_half_u12   : u32_half_u12_before  ⊑  u32_half_u12_combined := by
  unfold u32_half_u12_before u32_half_u12_combined
  simp_alive_peephole
  sorry
def i8_vec_sitofp_test1_combined := [llvmfunc|
  llvm.func @i8_vec_sitofp_test1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.280000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ult" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i8_vec_sitofp_test1   : i8_vec_sitofp_test1_before  ⊑  i8_vec_sitofp_test1_combined := by
  unfold i8_vec_sitofp_test1_before i8_vec_sitofp_test1_combined
  simp_alive_peephole
  sorry
def i8_vec_sitofp_test2_combined := [llvmfunc|
  llvm.func @i8_vec_sitofp_test2(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1.281000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ugt" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i8_vec_sitofp_test2   : i8_vec_sitofp_test2_before  ⊑  i8_vec_sitofp_test2_combined := by
  unfold i8_vec_sitofp_test2_before i8_vec_sitofp_test2_combined
  simp_alive_peephole
  sorry
def i8_vec_sitofp_test3_combined := [llvmfunc|
  llvm.func @i8_vec_sitofp_test3(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.270000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ule" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i8_vec_sitofp_test3   : i8_vec_sitofp_test3_before  ⊑  i8_vec_sitofp_test3_combined := by
  unfold i8_vec_sitofp_test3_before i8_vec_sitofp_test3_combined
  simp_alive_peephole
  sorry
def i8_vec_sitofp_test4_combined := [llvmfunc|
  llvm.func @i8_vec_sitofp_test4(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1.270000e+02> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf64>
    %2 = llvm.fcmp "ult" %1, %0 : vector<2xf64>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_i8_vec_sitofp_test4   : i8_vec_sitofp_test4_before  ⊑  i8_vec_sitofp_test4_combined := by
  unfold i8_vec_sitofp_test4_before i8_vec_sitofp_test4_combined
  simp_alive_peephole
  sorry
