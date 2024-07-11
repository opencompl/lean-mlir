import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fpcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() -> i8 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.fptoui %0 : f32 to i8
    llvm.return %1 : i8
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() -> i8 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.fptosi %0 : f32 to i8
    llvm.return %1 : i8
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: f32) -> f16 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

def fneg_fptrunc_before := [llvmfunc|
  llvm.func @fneg_fptrunc(%arg0: f32) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }]

def unary_fneg_fptrunc_before := [llvmfunc|
  llvm.func @unary_fneg_fptrunc(%arg0: f32) -> f16 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

def fneg_fptrunc_vec_poison_before := [llvmfunc|
  llvm.func @fneg_fptrunc_vec_poison(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fsub %6, %arg0  : vector<2xf32>
    %8 = llvm.fptrunc %7 : vector<2xf32> to vector<2xf16>
    llvm.return %8 : vector<2xf16>
  }]

def unary_fneg_fptrunc_vec_before := [llvmfunc|
  llvm.func @unary_fneg_fptrunc_vec(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.fptrunc %0 : vector<2xf32> to vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

def "test4-fast"_before := [llvmfunc|
  llvm.func @"test4-fast"(%arg0: f32) -> f16 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %2 = llvm.fptrunc %1 : f32 to f16
    llvm.return %2 : f16
  }]

def "test4_unary_fneg-fast"_before := [llvmfunc|
  llvm.func @"test4_unary_fneg-fast"(%arg0: f32) -> f16 {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: f32, %arg1: f32, %arg2: f32) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %2 = llvm.select %1, %arg2, %0 : i1, f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: vector<1xf64>) -> vector<1xf32> {
    %0 = llvm.frem %arg0, %arg0  : vector<1xf64>
    %1 = llvm.fptrunc %0 : vector<1xf64> to vector<1xf32>
    llvm.return %1 : vector<1xf32>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: f64) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.frem %arg0, %0  : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.frem %1, %0  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def test_fptrunc_fptrunc_before := [llvmfunc|
  llvm.func @test_fptrunc_fptrunc(%arg0: f64) -> f16 {
    %0 = llvm.fptrunc %arg0 : f64 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

def sint_to_fptrunc_before := [llvmfunc|
  llvm.func @sint_to_fptrunc(%arg0: i32) -> f16 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

def masked_sint_to_fptrunc1_before := [llvmfunc|
  llvm.func @masked_sint_to_fptrunc1(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

def masked_sint_to_fptrunc2_before := [llvmfunc|
  llvm.func @masked_sint_to_fptrunc2(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

def masked_sint_to_fptrunc3_before := [llvmfunc|
  llvm.func @masked_sint_to_fptrunc3(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

def sint_to_fpext_before := [llvmfunc|
  llvm.func @sint_to_fpext(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

def masked_sint_to_fpext1_before := [llvmfunc|
  llvm.func @masked_sint_to_fpext1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def masked_sint_to_fpext2_before := [llvmfunc|
  llvm.func @masked_sint_to_fpext2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def masked_sint_to_fpext3_before := [llvmfunc|
  llvm.func @masked_sint_to_fpext3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def uint_to_fptrunc_before := [llvmfunc|
  llvm.func @uint_to_fptrunc(%arg0: i32) -> f16 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

def masked_uint_to_fptrunc1_before := [llvmfunc|
  llvm.func @masked_uint_to_fptrunc1(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

def masked_uint_to_fptrunc2_before := [llvmfunc|
  llvm.func @masked_uint_to_fptrunc2(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

def masked_uint_to_fptrunc3_before := [llvmfunc|
  llvm.func @masked_uint_to_fptrunc3(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

def uint_to_fpext_before := [llvmfunc|
  llvm.func @uint_to_fpext(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

def masked_uint_to_fpext1_before := [llvmfunc|
  llvm.func @masked_uint_to_fpext1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def masked_uint_to_fpext2_before := [llvmfunc|
  llvm.func @masked_uint_to_fpext2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def masked_uint_to_fpext3_before := [llvmfunc|
  llvm.func @masked_uint_to_fpext3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

def fptosi_nonnorm_before := [llvmfunc|
  llvm.func @fptosi_nonnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

def fptoui_nonnorm_before := [llvmfunc|
  llvm.func @fptoui_nonnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

def fptosi_nonnnorm_before := [llvmfunc|
  llvm.func @fptosi_nonnnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

def fptoui_nonnnorm_before := [llvmfunc|
  llvm.func @fptoui_nonnnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

def fptosi_nonnorm_copysign_before := [llvmfunc|
  llvm.func @fptosi_nonnorm_copysign(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%0, %arg0)  : (f32, f32) -> f32
    %2 = llvm.fptosi %1 : f32 to i32
    llvm.return %2 : i32
  }]

def fptosi_nonnorm_copysign_vec_before := [llvmfunc|
  llvm.func @fptosi_nonnorm_copysign_vec(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.copysign(%1, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fptosi %2 : vector<2xf32> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def fptosi_nonnorm_fmul_before := [llvmfunc|
  llvm.func @fptosi_nonnorm_fmul(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fptosi %1 : f32 to i32
    llvm.return %2 : i32
  }]

def fptosi_select_before := [llvmfunc|
  llvm.func @fptosi_select(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    %3 = llvm.fptosi %2 : f32 to i32
    llvm.return %3 : i32
  }]

def mul_pos_zero_convert_before := [llvmfunc|
  llvm.func @mul_pos_zero_convert(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fptosi %2 : f32 to i32
    llvm.return %3 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: f32) -> f16 {
    %0 = llvm.fptrunc %arg0 : f32 to f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def fneg_fptrunc_combined := [llvmfunc|
  llvm.func @fneg_fptrunc(%arg0: f32) -> f16 {
    %0 = llvm.fptrunc %arg0 : f32 to f16
    %1 = llvm.fneg %0  : f16
    llvm.return %1 : f16
  }]

theorem inst_combine_fneg_fptrunc   : fneg_fptrunc_before  ⊑  fneg_fptrunc_combined := by
  unfold fneg_fptrunc_before fneg_fptrunc_combined
  simp_alive_peephole
  sorry
def unary_fneg_fptrunc_combined := [llvmfunc|
  llvm.func @unary_fneg_fptrunc(%arg0: f32) -> f16 {
    %0 = llvm.fptrunc %arg0 : f32 to f16
    %1 = llvm.fneg %0  : f16
    llvm.return %1 : f16
  }]

theorem inst_combine_unary_fneg_fptrunc   : unary_fneg_fptrunc_before  ⊑  unary_fneg_fptrunc_combined := by
  unfold unary_fneg_fptrunc_before unary_fneg_fptrunc_combined
  simp_alive_peephole
  sorry
def fneg_fptrunc_vec_poison_combined := [llvmfunc|
  llvm.func @fneg_fptrunc_vec_poison(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = llvm.fptrunc %arg0 : vector<2xf32> to vector<2xf16>
    %1 = llvm.fneg %0  : vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

theorem inst_combine_fneg_fptrunc_vec_poison   : fneg_fptrunc_vec_poison_before  ⊑  fneg_fptrunc_vec_poison_combined := by
  unfold fneg_fptrunc_vec_poison_before fneg_fptrunc_vec_poison_combined
  simp_alive_peephole
  sorry
def unary_fneg_fptrunc_vec_combined := [llvmfunc|
  llvm.func @unary_fneg_fptrunc_vec(%arg0: vector<2xf32>) -> vector<2xf16> {
    %0 = llvm.fptrunc %arg0 : vector<2xf32> to vector<2xf16>
    %1 = llvm.fneg %0  : vector<2xf16>
    llvm.return %1 : vector<2xf16>
  }]

theorem inst_combine_unary_fneg_fptrunc_vec   : unary_fneg_fptrunc_vec_before  ⊑  unary_fneg_fptrunc_vec_combined := by
  unfold unary_fneg_fptrunc_vec_before unary_fneg_fptrunc_vec_combined
  simp_alive_peephole
  sorry
def "test4-fast"_combined := [llvmfunc|
  llvm.func @"test4-fast"(%arg0: f32) -> f16 {
    %0 = llvm.fptrunc %arg0 : f32 to f16
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_"test4-fast"   : "test4-fast"_before  ⊑  "test4-fast"_combined := by
  unfold "test4-fast"_before "test4-fast"_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_"test4-fast"   : "test4-fast"_before  ⊑  "test4-fast"_combined := by
  unfold "test4-fast"_before "test4-fast"_combined
  simp_alive_peephole
  sorry
def "test4_unary_fneg-fast"_combined := [llvmfunc|
  llvm.func @"test4_unary_fneg-fast"(%arg0: f32) -> f16 {
    %0 = llvm.fptrunc %arg0 : f32 to f16
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : f16]

theorem inst_combine_"test4_unary_fneg-fast"   : "test4_unary_fneg-fast"_before  ⊑  "test4_unary_fneg-fast"_combined := by
  unfold "test4_unary_fneg-fast"_before "test4_unary_fneg-fast"_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f16
  }]

theorem inst_combine_"test4_unary_fneg-fast"   : "test4_unary_fneg-fast"_before  ⊑  "test4_unary_fneg-fast"_combined := by
  unfold "test4_unary_fneg-fast"_before "test4_unary_fneg-fast"_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: f32, %arg1: f32, %arg2: f32) -> f16 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %2 = llvm.select %1, %arg2, %0 : i1, f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: vector<1xf64>) -> vector<1xf32> {
    %0 = llvm.frem %arg0, %arg0  : vector<1xf64>
    %1 = llvm.fptrunc %0 : vector<1xf64> to vector<1xf32>
    llvm.return %1 : vector<1xf32>
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: f64) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.frem %arg0, %0  : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.frem %1, %0  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test_fptrunc_fptrunc_combined := [llvmfunc|
  llvm.func @test_fptrunc_fptrunc(%arg0: f64) -> f16 {
    %0 = llvm.fptrunc %arg0 : f64 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_test_fptrunc_fptrunc   : test_fptrunc_fptrunc_before  ⊑  test_fptrunc_fptrunc_combined := by
  unfold test_fptrunc_fptrunc_before test_fptrunc_fptrunc_combined
  simp_alive_peephole
  sorry
def sint_to_fptrunc_combined := [llvmfunc|
  llvm.func @sint_to_fptrunc(%arg0: i32) -> f16 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_sint_to_fptrunc   : sint_to_fptrunc_before  ⊑  sint_to_fptrunc_combined := by
  unfold sint_to_fptrunc_before sint_to_fptrunc_combined
  simp_alive_peephole
  sorry
def masked_sint_to_fptrunc1_combined := [llvmfunc|
  llvm.func @masked_sint_to_fptrunc1(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f16
    llvm.return %2 : f16
  }]

theorem inst_combine_masked_sint_to_fptrunc1   : masked_sint_to_fptrunc1_before  ⊑  masked_sint_to_fptrunc1_combined := by
  unfold masked_sint_to_fptrunc1_before masked_sint_to_fptrunc1_combined
  simp_alive_peephole
  sorry
def masked_sint_to_fptrunc2_combined := [llvmfunc|
  llvm.func @masked_sint_to_fptrunc2(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f16
    llvm.return %2 : f16
  }]

theorem inst_combine_masked_sint_to_fptrunc2   : masked_sint_to_fptrunc2_before  ⊑  masked_sint_to_fptrunc2_combined := by
  unfold masked_sint_to_fptrunc2_before masked_sint_to_fptrunc2_combined
  simp_alive_peephole
  sorry
def masked_sint_to_fptrunc3_combined := [llvmfunc|
  llvm.func @masked_sint_to_fptrunc3(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

theorem inst_combine_masked_sint_to_fptrunc3   : masked_sint_to_fptrunc3_before  ⊑  masked_sint_to_fptrunc3_combined := by
  unfold masked_sint_to_fptrunc3_before masked_sint_to_fptrunc3_combined
  simp_alive_peephole
  sorry
def sint_to_fpext_combined := [llvmfunc|
  llvm.func @sint_to_fpext(%arg0: i32) -> f64 {
    %0 = llvm.sitofp %arg0 : i32 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

theorem inst_combine_sint_to_fpext   : sint_to_fpext_before  ⊑  sint_to_fpext_combined := by
  unfold sint_to_fpext_before sint_to_fpext_combined
  simp_alive_peephole
  sorry
def masked_sint_to_fpext1_combined := [llvmfunc|
  llvm.func @masked_sint_to_fpext1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_masked_sint_to_fpext1   : masked_sint_to_fpext1_before  ⊑  masked_sint_to_fpext1_combined := by
  unfold masked_sint_to_fpext1_before masked_sint_to_fpext1_combined
  simp_alive_peephole
  sorry
def masked_sint_to_fpext2_combined := [llvmfunc|
  llvm.func @masked_sint_to_fpext2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_masked_sint_to_fpext2   : masked_sint_to_fpext2_before  ⊑  masked_sint_to_fpext2_combined := by
  unfold masked_sint_to_fpext2_before masked_sint_to_fpext2_combined
  simp_alive_peephole
  sorry
def masked_sint_to_fpext3_combined := [llvmfunc|
  llvm.func @masked_sint_to_fpext3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.sitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_masked_sint_to_fpext3   : masked_sint_to_fpext3_before  ⊑  masked_sint_to_fpext3_combined := by
  unfold masked_sint_to_fpext3_before masked_sint_to_fpext3_combined
  simp_alive_peephole
  sorry
def uint_to_fptrunc_combined := [llvmfunc|
  llvm.func @uint_to_fptrunc(%arg0: i32) -> f16 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }]

theorem inst_combine_uint_to_fptrunc   : uint_to_fptrunc_before  ⊑  uint_to_fptrunc_combined := by
  unfold uint_to_fptrunc_before uint_to_fptrunc_combined
  simp_alive_peephole
  sorry
def masked_uint_to_fptrunc1_combined := [llvmfunc|
  llvm.func @masked_uint_to_fptrunc1(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f16
    llvm.return %2 : f16
  }]

theorem inst_combine_masked_uint_to_fptrunc1   : masked_uint_to_fptrunc1_before  ⊑  masked_uint_to_fptrunc1_combined := by
  unfold masked_uint_to_fptrunc1_before masked_uint_to_fptrunc1_combined
  simp_alive_peephole
  sorry
def masked_uint_to_fptrunc2_combined := [llvmfunc|
  llvm.func @masked_uint_to_fptrunc2(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f16
    llvm.return %2 : f16
  }]

theorem inst_combine_masked_uint_to_fptrunc2   : masked_uint_to_fptrunc2_before  ⊑  masked_uint_to_fptrunc2_combined := by
  unfold masked_uint_to_fptrunc2_before masked_uint_to_fptrunc2_combined
  simp_alive_peephole
  sorry
def masked_uint_to_fptrunc3_combined := [llvmfunc|
  llvm.func @masked_uint_to_fptrunc3(%arg0: i32) -> f16 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fptrunc %2 : f32 to f16
    llvm.return %3 : f16
  }]

theorem inst_combine_masked_uint_to_fptrunc3   : masked_uint_to_fptrunc3_before  ⊑  masked_uint_to_fptrunc3_combined := by
  unfold masked_uint_to_fptrunc3_before masked_uint_to_fptrunc3_combined
  simp_alive_peephole
  sorry
def uint_to_fpext_combined := [llvmfunc|
  llvm.func @uint_to_fpext(%arg0: i32) -> f64 {
    %0 = llvm.uitofp %arg0 : i32 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }]

theorem inst_combine_uint_to_fpext   : uint_to_fpext_before  ⊑  uint_to_fpext_combined := by
  unfold uint_to_fpext_before uint_to_fpext_combined
  simp_alive_peephole
  sorry
def masked_uint_to_fpext1_combined := [llvmfunc|
  llvm.func @masked_uint_to_fpext1(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(16777215 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_masked_uint_to_fpext1   : masked_uint_to_fpext1_before  ⊑  masked_uint_to_fpext1_combined := by
  unfold masked_uint_to_fpext1_before masked_uint_to_fpext1_combined
  simp_alive_peephole
  sorry
def masked_uint_to_fpext2_combined := [llvmfunc|
  llvm.func @masked_uint_to_fpext2(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f64
    llvm.return %2 : f64
  }]

theorem inst_combine_masked_uint_to_fpext2   : masked_uint_to_fpext2_before  ⊑  masked_uint_to_fpext2_combined := by
  unfold masked_uint_to_fpext2_before masked_uint_to_fpext2_combined
  simp_alive_peephole
  sorry
def masked_uint_to_fpext3_combined := [llvmfunc|
  llvm.func @masked_uint_to_fpext3(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.uitofp %1 : i32 to f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }]

theorem inst_combine_masked_uint_to_fpext3   : masked_uint_to_fpext3_before  ⊑  masked_uint_to_fpext3_combined := by
  unfold masked_uint_to_fpext3_before masked_uint_to_fpext3_combined
  simp_alive_peephole
  sorry
def fptosi_nonnorm_combined := [llvmfunc|
  llvm.func @fptosi_nonnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fptosi_nonnorm   : fptosi_nonnorm_before  ⊑  fptosi_nonnorm_combined := by
  unfold fptosi_nonnorm_before fptosi_nonnorm_combined
  simp_alive_peephole
  sorry
def fptoui_nonnorm_combined := [llvmfunc|
  llvm.func @fptoui_nonnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fptoui_nonnorm   : fptoui_nonnorm_before  ⊑  fptoui_nonnorm_combined := by
  unfold fptoui_nonnorm_before fptoui_nonnorm_combined
  simp_alive_peephole
  sorry
def fptosi_nonnnorm_combined := [llvmfunc|
  llvm.func @fptosi_nonnnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fptosi_nonnnorm   : fptosi_nonnnorm_before  ⊑  fptosi_nonnnorm_combined := by
  unfold fptosi_nonnnorm_before fptosi_nonnnorm_combined
  simp_alive_peephole
  sorry
def fptoui_nonnnorm_combined := [llvmfunc|
  llvm.func @fptoui_nonnnorm(%arg0: f32) -> i32 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.return %0 : i32
  }]

theorem inst_combine_fptoui_nonnnorm   : fptoui_nonnnorm_before  ⊑  fptoui_nonnnorm_combined := by
  unfold fptoui_nonnnorm_before fptoui_nonnnorm_combined
  simp_alive_peephole
  sorry
def fptosi_nonnorm_copysign_combined := [llvmfunc|
  llvm.func @fptosi_nonnorm_copysign(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%0, %arg0)  : (f32, f32) -> f32
    %2 = llvm.fptosi %1 : f32 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fptosi_nonnorm_copysign   : fptosi_nonnorm_copysign_before  ⊑  fptosi_nonnorm_copysign_combined := by
  unfold fptosi_nonnorm_copysign_before fptosi_nonnorm_copysign_combined
  simp_alive_peephole
  sorry
def fptosi_nonnorm_copysign_vec_combined := [llvmfunc|
  llvm.func @fptosi_nonnorm_copysign_vec(%arg0: vector<2xf32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.intr.copysign(%1, %arg0)  : (vector<2xf32>, vector<2xf32>) -> vector<2xf32>
    %3 = llvm.fptosi %2 : vector<2xf32> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_fptosi_nonnorm_copysign_vec   : fptosi_nonnorm_copysign_vec_before  ⊑  fptosi_nonnorm_copysign_vec_combined := by
  unfold fptosi_nonnorm_copysign_vec_before fptosi_nonnorm_copysign_vec_combined
  simp_alive_peephole
  sorry
def fptosi_nonnorm_fmul_combined := [llvmfunc|
  llvm.func @fptosi_nonnorm_fmul(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fmul %arg0, %0  : f32
    %2 = llvm.fptosi %1 : f32 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fptosi_nonnorm_fmul   : fptosi_nonnorm_fmul_before  ⊑  fptosi_nonnorm_fmul_combined := by
  unfold fptosi_nonnorm_fmul_before fptosi_nonnorm_fmul_combined
  simp_alive_peephole
  sorry
def fptosi_select_combined := [llvmfunc|
  llvm.func @fptosi_select(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }]

theorem inst_combine_fptosi_select   : fptosi_select_before  ⊑  fptosi_select_combined := by
  unfold fptosi_select_before fptosi_select_combined
  simp_alive_peephole
  sorry
def mul_pos_zero_convert_combined := [llvmfunc|
  llvm.func @mul_pos_zero_convert(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fmul %1, %0  : f32
    %3 = llvm.fptosi %2 : f32 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_mul_pos_zero_convert   : mul_pos_zero_convert_before  ⊑  mul_pos_zero_convert_combined := by
  unfold mul_pos_zero_convert_before mul_pos_zero_convert_combined
  simp_alive_peephole
  sorry
