import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  exp2-to-ldexp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def exp2_f32_sitofp_i8_before := [llvmfunc|
  llvm.func @exp2_f32_sitofp_i8(%arg0: i8) -> f32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def exp2_f32_sitofp_i8_flags_before := [llvmfunc|
  llvm.func @exp2_f32_sitofp_i8_flags(%arg0: i8) -> f32 {
    %0 = llvm.sitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def exp2_v2f32_sitofp_v2i8_before := [llvmfunc|
  llvm.func @exp2_v2f32_sitofp_v2i8(%arg0: vector<2xi8>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf32>
    %1 = llvm.intr.exp2(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def exp2_f32_uitofp_i8_before := [llvmfunc|
  llvm.func @exp2_f32_uitofp_i8(%arg0: i8) -> f32 {
    %0 = llvm.uitofp %arg0 : i8 to f32
    %1 = llvm.intr.exp2(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def exp2_f16_sitofp_i8_before := [llvmfunc|
  llvm.func @exp2_f16_sitofp_i8(%arg0: i8) -> f16 {
    %0 = llvm.sitofp %arg0 : i8 to f16
    %1 = llvm.intr.exp2(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }]

def exp2_f64_sitofp_i8_before := [llvmfunc|
  llvm.func @exp2_f64_sitofp_i8(%arg0: i8) -> f64 {
    %0 = llvm.sitofp %arg0 : i8 to f64
    %1 = llvm.intr.exp2(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def exp2_fp128_sitofp_i8_before := [llvmfunc|
  llvm.func @exp2_fp128_sitofp_i8(%arg0: i8) -> f128 {
    %0 = llvm.sitofp %arg0 : i8 to f128
    %1 = llvm.intr.exp2(%0)  : (f128) -> f128
    llvm.return %1 : f128
  }]

def exp2_nxv4f32_sitofp_i8_before := [llvmfunc|
  llvm.func @exp2_nxv4f32_sitofp_i8(%arg0: !llvm.vec<? x 4 x  i8>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.sitofp %arg0 : !llvm.vec<? x 4 x  i8> to !llvm.vec<? x 4 x  f32>
    %1 = llvm.intr.exp2(%0)  : (!llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32>
    llvm.return %1 : !llvm.vec<? x 4 x  f32>
  }]

def exp2_f32_sitofp_i8_combined := [llvmfunc|
  llvm.func @exp2_f32_sitofp_i8(%arg0: i8) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.call @ldexpf(%0, %1) : (f32, i32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_exp2_f32_sitofp_i8   : exp2_f32_sitofp_i8_before  ⊑  exp2_f32_sitofp_i8_combined := by
  unfold exp2_f32_sitofp_i8_before exp2_f32_sitofp_i8_combined
  simp_alive_peephole
  sorry
def exp2_f32_sitofp_i8_flags_combined := [llvmfunc|
  llvm.func @exp2_f32_sitofp_i8_flags(%arg0: i8) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.call @ldexpf(%0, %1) {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f32, i32) -> f32]

theorem inst_combine_exp2_f32_sitofp_i8_flags   : exp2_f32_sitofp_i8_flags_before  ⊑  exp2_f32_sitofp_i8_flags_combined := by
  unfold exp2_f32_sitofp_i8_flags_before exp2_f32_sitofp_i8_flags_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : f32
  }]

theorem inst_combine_exp2_f32_sitofp_i8_flags   : exp2_f32_sitofp_i8_flags_before  ⊑  exp2_f32_sitofp_i8_flags_combined := by
  unfold exp2_f32_sitofp_i8_flags_before exp2_f32_sitofp_i8_flags_combined
  simp_alive_peephole
  sorry
def exp2_v2f32_sitofp_v2i8_combined := [llvmfunc|
  llvm.func @exp2_v2f32_sitofp_v2i8(%arg0: vector<2xi8>) -> vector<2xf32> {
    %0 = llvm.sitofp %arg0 : vector<2xi8> to vector<2xf32>
    %1 = llvm.intr.exp2(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_exp2_v2f32_sitofp_v2i8   : exp2_v2f32_sitofp_v2i8_before  ⊑  exp2_v2f32_sitofp_v2i8_combined := by
  unfold exp2_v2f32_sitofp_v2i8_before exp2_v2f32_sitofp_v2i8_combined
  simp_alive_peephole
  sorry
def exp2_f32_uitofp_i8_combined := [llvmfunc|
  llvm.func @exp2_f32_uitofp_i8(%arg0: i8) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.call @ldexpf(%0, %1) : (f32, i32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_exp2_f32_uitofp_i8   : exp2_f32_uitofp_i8_before  ⊑  exp2_f32_uitofp_i8_combined := by
  unfold exp2_f32_uitofp_i8_before exp2_f32_uitofp_i8_combined
  simp_alive_peephole
  sorry
def exp2_f16_sitofp_i8_combined := [llvmfunc|
  llvm.func @exp2_f16_sitofp_i8(%arg0: i8) -> f16 {
    %0 = llvm.sitofp %arg0 : i8 to f16
    %1 = llvm.intr.exp2(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_exp2_f16_sitofp_i8   : exp2_f16_sitofp_i8_before  ⊑  exp2_f16_sitofp_i8_combined := by
  unfold exp2_f16_sitofp_i8_before exp2_f16_sitofp_i8_combined
  simp_alive_peephole
  sorry
def exp2_f64_sitofp_i8_combined := [llvmfunc|
  llvm.func @exp2_f64_sitofp_i8(%arg0: i8) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.call @ldexp(%0, %1) : (f64, i32) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_exp2_f64_sitofp_i8   : exp2_f64_sitofp_i8_before  ⊑  exp2_f64_sitofp_i8_combined := by
  unfold exp2_f64_sitofp_i8_before exp2_f64_sitofp_i8_combined
  simp_alive_peephole
  sorry
def exp2_fp128_sitofp_i8_combined := [llvmfunc|
  llvm.func @exp2_fp128_sitofp_i8(%arg0: i8) -> f128 {
    %0 = llvm.mlir.constant(1.000000e+00 : f128) : f128
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.call @ldexpl(%0, %1) : (f128, i32) -> f128
    llvm.return %2 : f128
  }]

theorem inst_combine_exp2_fp128_sitofp_i8   : exp2_fp128_sitofp_i8_before  ⊑  exp2_fp128_sitofp_i8_combined := by
  unfold exp2_fp128_sitofp_i8_before exp2_fp128_sitofp_i8_combined
  simp_alive_peephole
  sorry
def exp2_nxv4f32_sitofp_i8_combined := [llvmfunc|
  llvm.func @exp2_nxv4f32_sitofp_i8(%arg0: !llvm.vec<? x 4 x  i8>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.sitofp %arg0 : !llvm.vec<? x 4 x  i8> to !llvm.vec<? x 4 x  f32>
    %1 = llvm.intr.exp2(%0)  : (!llvm.vec<? x 4 x  f32>) -> !llvm.vec<? x 4 x  f32>
    llvm.return %1 : !llvm.vec<? x 4 x  f32>
  }]

theorem inst_combine_exp2_nxv4f32_sitofp_i8   : exp2_nxv4f32_sitofp_i8_before  ⊑  exp2_nxv4f32_sitofp_i8_combined := by
  unfold exp2_nxv4f32_sitofp_i8_before exp2_nxv4f32_sitofp_i8_combined
  simp_alive_peephole
  sorry
