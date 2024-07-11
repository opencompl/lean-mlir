import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trunc-fp-to-int
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def half_fptoui_i17_i16_before := [llvmfunc|
  llvm.func @half_fptoui_i17_i16(%arg0: f16) -> i16 {
    %0 = llvm.fptoui %arg0 : f16 to i17
    %1 = llvm.trunc %0 : i17 to i16
    llvm.return %1 : i16
  }]

def half_fptoui_i17_i15_before := [llvmfunc|
  llvm.func @half_fptoui_i17_i15(%arg0: f16) -> i15 {
    %0 = llvm.fptoui %arg0 : f16 to i17
    %1 = llvm.trunc %0 : i17 to i15
    llvm.return %1 : i15
  }]

def half_fptoui_i32_i16_before := [llvmfunc|
  llvm.func @half_fptoui_i32_i16(%arg0: f16) -> i16 {
    %0 = llvm.fptoui %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i16
    llvm.return %1 : i16
  }]

def half_fptoui_i32_i17_before := [llvmfunc|
  llvm.func @half_fptoui_i32_i17(%arg0: f16) -> i17 {
    %0 = llvm.fptoui %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i17
    llvm.return %1 : i17
  }]

def half_fptoui_4xi32_4xi16_before := [llvmfunc|
  llvm.func @half_fptoui_4xi32_4xi16(%arg0: vector<4xf16>) -> vector<4xi16> {
    %0 = llvm.fptoui %arg0 : vector<4xf16> to vector<4xi32>
    %1 = llvm.trunc %0 : vector<4xi32> to vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def bfloat_fptoui_i129_i128_before := [llvmfunc|
  llvm.func @bfloat_fptoui_i129_i128(%arg0: bf16) -> i128 {
    %0 = llvm.fptoui %arg0 : bf16 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }]

def bfloat_fptoui_i128_i127_before := [llvmfunc|
  llvm.func @bfloat_fptoui_i128_i127(%arg0: bf16) -> i127 {
    %0 = llvm.fptoui %arg0 : bf16 to i128
    %1 = llvm.trunc %0 : i128 to i127
    llvm.return %1 : i127
  }]

def float_fptoui_i129_i128_before := [llvmfunc|
  llvm.func @float_fptoui_i129_i128(%arg0: f32) -> i128 {
    %0 = llvm.fptoui %arg0 : f32 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }]

def float_fptoui_i129_i128_use_before := [llvmfunc|
  llvm.func @float_fptoui_i129_i128_use(%arg0: f32) -> i128 {
    %0 = llvm.fptoui %arg0 : f32 to i129
    llvm.call @use(%0) : (i129) -> ()
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }]

def float_fptoui_i128_i127_before := [llvmfunc|
  llvm.func @float_fptoui_i128_i127(%arg0: f32) -> i127 {
    %0 = llvm.fptoui %arg0 : f32 to i128
    %1 = llvm.trunc %0 : i128 to i127
    llvm.return %1 : i127
  }]

def double_fptoui_i1025_i1024_before := [llvmfunc|
  llvm.func @double_fptoui_i1025_i1024(%arg0: f64) -> i1024 {
    %0 = llvm.fptoui %arg0 : f64 to i1025
    %1 = llvm.trunc %0 : i1025 to i1024
    llvm.return %1 : i1024
  }]

def double_fptoui_i1024_i1023_before := [llvmfunc|
  llvm.func @double_fptoui_i1024_i1023(%arg0: f64) -> i1023 {
    %0 = llvm.fptoui %arg0 : f64 to i1024
    %1 = llvm.trunc %0 : i1024 to i1023
    llvm.return %1 : i1023
  }]

def half_fptosi_i17_i16_before := [llvmfunc|
  llvm.func @half_fptosi_i17_i16(%arg0: f16) -> i16 {
    %0 = llvm.fptosi %arg0 : f16 to i17
    %1 = llvm.trunc %0 : i17 to i16
    llvm.return %1 : i16
  }]

def half_fptosi_i18_i17_before := [llvmfunc|
  llvm.func @half_fptosi_i18_i17(%arg0: f16) -> i17 {
    %0 = llvm.fptosi %arg0 : f16 to i18
    %1 = llvm.trunc %0 : i18 to i17
    llvm.return %1 : i17
  }]

def half_fptosi_i32_i17_before := [llvmfunc|
  llvm.func @half_fptosi_i32_i17(%arg0: f16) -> i17 {
    %0 = llvm.fptosi %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i17
    llvm.return %1 : i17
  }]

def half_fptosi_i32_i18_before := [llvmfunc|
  llvm.func @half_fptosi_i32_i18(%arg0: f16) -> i18 {
    %0 = llvm.fptosi %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i18
    llvm.return %1 : i18
  }]

def half_fptosi_4xi32_4xi17_before := [llvmfunc|
  llvm.func @half_fptosi_4xi32_4xi17(%arg0: vector<4xf16>) -> vector<4xi17> {
    %0 = llvm.fptosi %arg0 : vector<4xf16> to vector<4xi32>
    %1 = llvm.trunc %0 : vector<4xi32> to vector<4xi17>
    llvm.return %1 : vector<4xi17>
  }]

def bfloat_fptosi_i129_i128_before := [llvmfunc|
  llvm.func @bfloat_fptosi_i129_i128(%arg0: bf16) -> i128 {
    %0 = llvm.fptosi %arg0 : bf16 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }]

def bfloat_fptosi_i130_i129_before := [llvmfunc|
  llvm.func @bfloat_fptosi_i130_i129(%arg0: bf16) -> i129 {
    %0 = llvm.fptosi %arg0 : bf16 to i130
    %1 = llvm.trunc %0 : i130 to i129
    llvm.return %1 : i129
  }]

def float_fptosi_i130_i129_before := [llvmfunc|
  llvm.func @float_fptosi_i130_i129(%arg0: f32) -> i129 {
    %0 = llvm.fptosi %arg0 : f32 to i130
    %1 = llvm.trunc %0 : i130 to i129
    llvm.return %1 : i129
  }]

def float_fptosi_i129_i128_before := [llvmfunc|
  llvm.func @float_fptosi_i129_i128(%arg0: f32) -> i128 {
    %0 = llvm.fptosi %arg0 : f32 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }]

def double_fptosi_i1026_i1025_before := [llvmfunc|
  llvm.func @double_fptosi_i1026_i1025(%arg0: f64) -> i1025 {
    %0 = llvm.fptosi %arg0 : f64 to i1026
    %1 = llvm.trunc %0 : i1026 to i1025
    llvm.return %1 : i1025
  }]

def double_fptosi_i1025_i1024_before := [llvmfunc|
  llvm.func @double_fptosi_i1025_i1024(%arg0: f64) -> i1024 {
    %0 = llvm.fptosi %arg0 : f64 to i1025
    %1 = llvm.trunc %0 : i1025 to i1024
    llvm.return %1 : i1024
  }]

def half_fptoui_i17_i16_combined := [llvmfunc|
  llvm.func @half_fptoui_i17_i16(%arg0: f16) -> i16 {
    %0 = llvm.fptoui %arg0 : f16 to i16
    llvm.return %0 : i16
  }]

theorem inst_combine_half_fptoui_i17_i16   : half_fptoui_i17_i16_before  ⊑  half_fptoui_i17_i16_combined := by
  unfold half_fptoui_i17_i16_before half_fptoui_i17_i16_combined
  simp_alive_peephole
  sorry
def half_fptoui_i17_i15_combined := [llvmfunc|
  llvm.func @half_fptoui_i17_i15(%arg0: f16) -> i15 {
    %0 = llvm.fptoui %arg0 : f16 to i17
    %1 = llvm.trunc %0 : i17 to i15
    llvm.return %1 : i15
  }]

theorem inst_combine_half_fptoui_i17_i15   : half_fptoui_i17_i15_before  ⊑  half_fptoui_i17_i15_combined := by
  unfold half_fptoui_i17_i15_before half_fptoui_i17_i15_combined
  simp_alive_peephole
  sorry
def half_fptoui_i32_i16_combined := [llvmfunc|
  llvm.func @half_fptoui_i32_i16(%arg0: f16) -> i16 {
    %0 = llvm.fptoui %arg0 : f16 to i16
    llvm.return %0 : i16
  }]

theorem inst_combine_half_fptoui_i32_i16   : half_fptoui_i32_i16_before  ⊑  half_fptoui_i32_i16_combined := by
  unfold half_fptoui_i32_i16_before half_fptoui_i32_i16_combined
  simp_alive_peephole
  sorry
def half_fptoui_i32_i17_combined := [llvmfunc|
  llvm.func @half_fptoui_i32_i17(%arg0: f16) -> i17 {
    %0 = llvm.fptoui %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i17
    llvm.return %1 : i17
  }]

theorem inst_combine_half_fptoui_i32_i17   : half_fptoui_i32_i17_before  ⊑  half_fptoui_i32_i17_combined := by
  unfold half_fptoui_i32_i17_before half_fptoui_i32_i17_combined
  simp_alive_peephole
  sorry
def half_fptoui_4xi32_4xi16_combined := [llvmfunc|
  llvm.func @half_fptoui_4xi32_4xi16(%arg0: vector<4xf16>) -> vector<4xi16> {
    %0 = llvm.fptoui %arg0 : vector<4xf16> to vector<4xi16>
    llvm.return %0 : vector<4xi16>
  }]

theorem inst_combine_half_fptoui_4xi32_4xi16   : half_fptoui_4xi32_4xi16_before  ⊑  half_fptoui_4xi32_4xi16_combined := by
  unfold half_fptoui_4xi32_4xi16_before half_fptoui_4xi32_4xi16_combined
  simp_alive_peephole
  sorry
def bfloat_fptoui_i129_i128_combined := [llvmfunc|
  llvm.func @bfloat_fptoui_i129_i128(%arg0: bf16) -> i128 {
    %0 = llvm.fptoui %arg0 : bf16 to i128
    llvm.return %0 : i128
  }]

theorem inst_combine_bfloat_fptoui_i129_i128   : bfloat_fptoui_i129_i128_before  ⊑  bfloat_fptoui_i129_i128_combined := by
  unfold bfloat_fptoui_i129_i128_before bfloat_fptoui_i129_i128_combined
  simp_alive_peephole
  sorry
def bfloat_fptoui_i128_i127_combined := [llvmfunc|
  llvm.func @bfloat_fptoui_i128_i127(%arg0: bf16) -> i127 {
    %0 = llvm.fptoui %arg0 : bf16 to i128
    %1 = llvm.trunc %0 : i128 to i127
    llvm.return %1 : i127
  }]

theorem inst_combine_bfloat_fptoui_i128_i127   : bfloat_fptoui_i128_i127_before  ⊑  bfloat_fptoui_i128_i127_combined := by
  unfold bfloat_fptoui_i128_i127_before bfloat_fptoui_i128_i127_combined
  simp_alive_peephole
  sorry
def float_fptoui_i129_i128_combined := [llvmfunc|
  llvm.func @float_fptoui_i129_i128(%arg0: f32) -> i128 {
    %0 = llvm.fptoui %arg0 : f32 to i128
    llvm.return %0 : i128
  }]

theorem inst_combine_float_fptoui_i129_i128   : float_fptoui_i129_i128_before  ⊑  float_fptoui_i129_i128_combined := by
  unfold float_fptoui_i129_i128_before float_fptoui_i129_i128_combined
  simp_alive_peephole
  sorry
def float_fptoui_i129_i128_use_combined := [llvmfunc|
  llvm.func @float_fptoui_i129_i128_use(%arg0: f32) -> i128 {
    %0 = llvm.fptoui %arg0 : f32 to i129
    llvm.call @use(%0) : (i129) -> ()
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }]

theorem inst_combine_float_fptoui_i129_i128_use   : float_fptoui_i129_i128_use_before  ⊑  float_fptoui_i129_i128_use_combined := by
  unfold float_fptoui_i129_i128_use_before float_fptoui_i129_i128_use_combined
  simp_alive_peephole
  sorry
def float_fptoui_i128_i127_combined := [llvmfunc|
  llvm.func @float_fptoui_i128_i127(%arg0: f32) -> i127 {
    %0 = llvm.fptoui %arg0 : f32 to i128
    %1 = llvm.trunc %0 : i128 to i127
    llvm.return %1 : i127
  }]

theorem inst_combine_float_fptoui_i128_i127   : float_fptoui_i128_i127_before  ⊑  float_fptoui_i128_i127_combined := by
  unfold float_fptoui_i128_i127_before float_fptoui_i128_i127_combined
  simp_alive_peephole
  sorry
def double_fptoui_i1025_i1024_combined := [llvmfunc|
  llvm.func @double_fptoui_i1025_i1024(%arg0: f64) -> i1024 {
    %0 = llvm.fptoui %arg0 : f64 to i1024
    llvm.return %0 : i1024
  }]

theorem inst_combine_double_fptoui_i1025_i1024   : double_fptoui_i1025_i1024_before  ⊑  double_fptoui_i1025_i1024_combined := by
  unfold double_fptoui_i1025_i1024_before double_fptoui_i1025_i1024_combined
  simp_alive_peephole
  sorry
def double_fptoui_i1024_i1023_combined := [llvmfunc|
  llvm.func @double_fptoui_i1024_i1023(%arg0: f64) -> i1023 {
    %0 = llvm.fptoui %arg0 : f64 to i1024
    %1 = llvm.trunc %0 : i1024 to i1023
    llvm.return %1 : i1023
  }]

theorem inst_combine_double_fptoui_i1024_i1023   : double_fptoui_i1024_i1023_before  ⊑  double_fptoui_i1024_i1023_combined := by
  unfold double_fptoui_i1024_i1023_before double_fptoui_i1024_i1023_combined
  simp_alive_peephole
  sorry
def half_fptosi_i17_i16_combined := [llvmfunc|
  llvm.func @half_fptosi_i17_i16(%arg0: f16) -> i16 {
    %0 = llvm.fptosi %arg0 : f16 to i17
    %1 = llvm.trunc %0 : i17 to i16
    llvm.return %1 : i16
  }]

theorem inst_combine_half_fptosi_i17_i16   : half_fptosi_i17_i16_before  ⊑  half_fptosi_i17_i16_combined := by
  unfold half_fptosi_i17_i16_before half_fptosi_i17_i16_combined
  simp_alive_peephole
  sorry
def half_fptosi_i18_i17_combined := [llvmfunc|
  llvm.func @half_fptosi_i18_i17(%arg0: f16) -> i17 {
    %0 = llvm.fptosi %arg0 : f16 to i17
    llvm.return %0 : i17
  }]

theorem inst_combine_half_fptosi_i18_i17   : half_fptosi_i18_i17_before  ⊑  half_fptosi_i18_i17_combined := by
  unfold half_fptosi_i18_i17_before half_fptosi_i18_i17_combined
  simp_alive_peephole
  sorry
def half_fptosi_i32_i17_combined := [llvmfunc|
  llvm.func @half_fptosi_i32_i17(%arg0: f16) -> i17 {
    %0 = llvm.fptosi %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i17
    llvm.return %1 : i17
  }]

theorem inst_combine_half_fptosi_i32_i17   : half_fptosi_i32_i17_before  ⊑  half_fptosi_i32_i17_combined := by
  unfold half_fptosi_i32_i17_before half_fptosi_i32_i17_combined
  simp_alive_peephole
  sorry
def half_fptosi_i32_i18_combined := [llvmfunc|
  llvm.func @half_fptosi_i32_i18(%arg0: f16) -> i18 {
    %0 = llvm.fptosi %arg0 : f16 to i32
    %1 = llvm.trunc %0 : i32 to i18
    llvm.return %1 : i18
  }]

theorem inst_combine_half_fptosi_i32_i18   : half_fptosi_i32_i18_before  ⊑  half_fptosi_i32_i18_combined := by
  unfold half_fptosi_i32_i18_before half_fptosi_i32_i18_combined
  simp_alive_peephole
  sorry
def half_fptosi_4xi32_4xi17_combined := [llvmfunc|
  llvm.func @half_fptosi_4xi32_4xi17(%arg0: vector<4xf16>) -> vector<4xi17> {
    %0 = llvm.fptosi %arg0 : vector<4xf16> to vector<4xi17>
    llvm.return %0 : vector<4xi17>
  }]

theorem inst_combine_half_fptosi_4xi32_4xi17   : half_fptosi_4xi32_4xi17_before  ⊑  half_fptosi_4xi32_4xi17_combined := by
  unfold half_fptosi_4xi32_4xi17_before half_fptosi_4xi32_4xi17_combined
  simp_alive_peephole
  sorry
def bfloat_fptosi_i129_i128_combined := [llvmfunc|
  llvm.func @bfloat_fptosi_i129_i128(%arg0: bf16) -> i128 {
    %0 = llvm.fptosi %arg0 : bf16 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }]

theorem inst_combine_bfloat_fptosi_i129_i128   : bfloat_fptosi_i129_i128_before  ⊑  bfloat_fptosi_i129_i128_combined := by
  unfold bfloat_fptosi_i129_i128_before bfloat_fptosi_i129_i128_combined
  simp_alive_peephole
  sorry
def bfloat_fptosi_i130_i129_combined := [llvmfunc|
  llvm.func @bfloat_fptosi_i130_i129(%arg0: bf16) -> i129 {
    %0 = llvm.fptosi %arg0 : bf16 to i129
    llvm.return %0 : i129
  }]

theorem inst_combine_bfloat_fptosi_i130_i129   : bfloat_fptosi_i130_i129_before  ⊑  bfloat_fptosi_i130_i129_combined := by
  unfold bfloat_fptosi_i130_i129_before bfloat_fptosi_i130_i129_combined
  simp_alive_peephole
  sorry
def float_fptosi_i130_i129_combined := [llvmfunc|
  llvm.func @float_fptosi_i130_i129(%arg0: f32) -> i129 {
    %0 = llvm.fptosi %arg0 : f32 to i129
    llvm.return %0 : i129
  }]

theorem inst_combine_float_fptosi_i130_i129   : float_fptosi_i130_i129_before  ⊑  float_fptosi_i130_i129_combined := by
  unfold float_fptosi_i130_i129_before float_fptosi_i130_i129_combined
  simp_alive_peephole
  sorry
def float_fptosi_i129_i128_combined := [llvmfunc|
  llvm.func @float_fptosi_i129_i128(%arg0: f32) -> i128 {
    %0 = llvm.fptosi %arg0 : f32 to i129
    %1 = llvm.trunc %0 : i129 to i128
    llvm.return %1 : i128
  }]

theorem inst_combine_float_fptosi_i129_i128   : float_fptosi_i129_i128_before  ⊑  float_fptosi_i129_i128_combined := by
  unfold float_fptosi_i129_i128_before float_fptosi_i129_i128_combined
  simp_alive_peephole
  sorry
def double_fptosi_i1026_i1025_combined := [llvmfunc|
  llvm.func @double_fptosi_i1026_i1025(%arg0: f64) -> i1025 {
    %0 = llvm.fptosi %arg0 : f64 to i1025
    llvm.return %0 : i1025
  }]

theorem inst_combine_double_fptosi_i1026_i1025   : double_fptosi_i1026_i1025_before  ⊑  double_fptosi_i1026_i1025_combined := by
  unfold double_fptosi_i1026_i1025_before double_fptosi_i1026_i1025_combined
  simp_alive_peephole
  sorry
def double_fptosi_i1025_i1024_combined := [llvmfunc|
  llvm.func @double_fptosi_i1025_i1024(%arg0: f64) -> i1024 {
    %0 = llvm.fptosi %arg0 : f64 to i1025
    %1 = llvm.trunc %0 : i1025 to i1024
    llvm.return %1 : i1024
  }]

theorem inst_combine_double_fptosi_i1025_i1024   : double_fptosi_i1025_i1024_before  ⊑  double_fptosi_i1025_i1024_combined := by
  unfold double_fptosi_i1025_i1024_before double_fptosi_i1025_i1024_combined
  simp_alive_peephole
  sorry
