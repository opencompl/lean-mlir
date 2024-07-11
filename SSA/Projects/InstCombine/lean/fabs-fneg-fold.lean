import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fabs-fneg-fold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fabs_fneg_basic_before := [llvmfunc|
  llvm.func @fabs_fneg_basic(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def fabs_fneg_v2f32_before := [llvmfunc|
  llvm.func @fabs_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.intr.fabs(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def fabs_fneg_f64_before := [llvmfunc|
  llvm.func @fabs_fneg_f64(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def fabs_fneg_v4f64_before := [llvmfunc|
  llvm.func @fabs_fneg_v4f64(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.fneg %arg0  : vector<4xf64>
    %1 = llvm.intr.fabs(%0)  : (vector<4xf64>) -> vector<4xf64>
    llvm.return %1 : vector<4xf64>
  }]

def fabs_fneg_f16_before := [llvmfunc|
  llvm.func @fabs_fneg_f16(%arg0: f16) -> f16 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }]

def fabs_copysign_nnan_before := [llvmfunc|
  llvm.func @fabs_copysign_nnan(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def fabs_copysign_ninf_before := [llvmfunc|
  llvm.func @fabs_copysign_ninf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def fabs_copysign_nsz_before := [llvmfunc|
  llvm.func @fabs_copysign_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def fabs_copysign_nnan_negative_before := [llvmfunc|
  llvm.func @fabs_copysign_nnan_negative(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def fabs_copysign_ninf_negative_before := [llvmfunc|
  llvm.func @fabs_copysign_ninf_negative(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def fabs_copysign_nsz_negative_before := [llvmfunc|
  llvm.func @fabs_copysign_nsz_negative(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    %1 = llvm.intr.fabs(%0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def fabs_fneg_no_fabs_before := [llvmfunc|
  llvm.func @fabs_fneg_no_fabs(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.return %0 : f32
  }]

def fabs_fneg_splat_v2f32_before := [llvmfunc|
  llvm.func @fabs_fneg_splat_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-2.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    %2 = llvm.intr.fabs(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def fabs_fneg_splat_poison_v2f32_before := [llvmfunc|
  llvm.func @fabs_fneg_splat_poison_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.fneg %6  : vector<2xf32>
    %8 = llvm.intr.fabs(%7)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %8 : vector<2xf32>
  }]

def fabs_fneg_non_splat_v2f32_before := [llvmfunc|
  llvm.func @fabs_fneg_non_splat_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[2.000000e+00, 3.000000e+00]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    %2 = llvm.intr.fabs(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def fabs_fneg_multi_use_before := [llvmfunc|
  llvm.func @fabs_fneg_multi_use(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def fabs_fneg_basic_combined := [llvmfunc|
  llvm.func @fabs_fneg_basic(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fabs_fneg_basic   : fabs_fneg_basic_before  ⊑  fabs_fneg_basic_combined := by
  unfold fabs_fneg_basic_before fabs_fneg_basic_combined
  simp_alive_peephole
  sorry
def fabs_fneg_v2f32_combined := [llvmfunc|
  llvm.func @fabs_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.intr.fabs(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fabs_fneg_v2f32   : fabs_fneg_v2f32_before  ⊑  fabs_fneg_v2f32_combined := by
  unfold fabs_fneg_v2f32_before fabs_fneg_v2f32_combined
  simp_alive_peephole
  sorry
def fabs_fneg_f64_combined := [llvmfunc|
  llvm.func @fabs_fneg_f64(%arg0: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_fabs_fneg_f64   : fabs_fneg_f64_before  ⊑  fabs_fneg_f64_combined := by
  unfold fabs_fneg_f64_before fabs_fneg_f64_combined
  simp_alive_peephole
  sorry
def fabs_fneg_v4f64_combined := [llvmfunc|
  llvm.func @fabs_fneg_v4f64(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.fneg %arg0  : vector<4xf64>
    %1 = llvm.intr.fabs(%0)  : (vector<4xf64>) -> vector<4xf64>
    llvm.return %1 : vector<4xf64>
  }]

theorem inst_combine_fabs_fneg_v4f64   : fabs_fneg_v4f64_before  ⊑  fabs_fneg_v4f64_combined := by
  unfold fabs_fneg_v4f64_before fabs_fneg_v4f64_combined
  simp_alive_peephole
  sorry
def fabs_fneg_f16_combined := [llvmfunc|
  llvm.func @fabs_fneg_f16(%arg0: f16) -> f16 {
    %0 = llvm.fneg %arg0  : f16
    %1 = llvm.intr.fabs(%0)  : (f16) -> f16
    llvm.return %1 : f16
  }]

theorem inst_combine_fabs_fneg_f16   : fabs_fneg_f16_before  ⊑  fabs_fneg_f16_combined := by
  unfold fabs_fneg_f16_before fabs_fneg_f16_combined
  simp_alive_peephole
  sorry
def fabs_copysign_nnan_combined := [llvmfunc|
  llvm.func @fabs_copysign_nnan(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_copysign_nnan   : fabs_copysign_nnan_before  ⊑  fabs_copysign_nnan_combined := by
  unfold fabs_copysign_nnan_before fabs_copysign_nnan_combined
  simp_alive_peephole
  sorry
def fabs_copysign_ninf_combined := [llvmfunc|
  llvm.func @fabs_copysign_ninf(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_copysign_ninf   : fabs_copysign_ninf_before  ⊑  fabs_copysign_ninf_combined := by
  unfold fabs_copysign_ninf_before fabs_copysign_ninf_combined
  simp_alive_peephole
  sorry
def fabs_copysign_nsz_combined := [llvmfunc|
  llvm.func @fabs_copysign_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_copysign_nsz   : fabs_copysign_nsz_before  ⊑  fabs_copysign_nsz_combined := by
  unfold fabs_copysign_nsz_before fabs_copysign_nsz_combined
  simp_alive_peephole
  sorry
def fabs_copysign_nnan_negative_combined := [llvmfunc|
  llvm.func @fabs_copysign_nnan_negative(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_copysign_nnan_negative   : fabs_copysign_nnan_negative_before  ⊑  fabs_copysign_nnan_negative_combined := by
  unfold fabs_copysign_nnan_negative_before fabs_copysign_nnan_negative_combined
  simp_alive_peephole
  sorry
def fabs_copysign_ninf_negative_combined := [llvmfunc|
  llvm.func @fabs_copysign_ninf_negative(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_copysign_ninf_negative   : fabs_copysign_ninf_negative_before  ⊑  fabs_copysign_ninf_negative_combined := by
  unfold fabs_copysign_ninf_negative_before fabs_copysign_ninf_negative_combined
  simp_alive_peephole
  sorry
def fabs_copysign_nsz_negative_combined := [llvmfunc|
  llvm.func @fabs_copysign_nsz_negative(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nsz>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_copysign_nsz_negative   : fabs_copysign_nsz_negative_before  ⊑  fabs_copysign_nsz_negative_combined := by
  unfold fabs_copysign_nsz_negative_before fabs_copysign_nsz_negative_combined
  simp_alive_peephole
  sorry
def fabs_fneg_no_fabs_combined := [llvmfunc|
  llvm.func @fabs_fneg_no_fabs(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_fneg_no_fabs   : fabs_fneg_no_fabs_before  ⊑  fabs_fneg_no_fabs_combined := by
  unfold fabs_fneg_no_fabs_before fabs_fneg_no_fabs_combined
  simp_alive_peephole
  sorry
def fabs_fneg_splat_v2f32_combined := [llvmfunc|
  llvm.func @fabs_fneg_splat_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<2.000000e+00> : vector<2xf32>) : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fabs_fneg_splat_v2f32   : fabs_fneg_splat_v2f32_before  ⊑  fabs_fneg_splat_v2f32_combined := by
  unfold fabs_fneg_splat_v2f32_before fabs_fneg_splat_v2f32_combined
  simp_alive_peephole
  sorry
def fabs_fneg_splat_poison_v2f32_combined := [llvmfunc|
  llvm.func @fabs_fneg_splat_poison_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.poison : f32
    %1 = llvm.mlir.constant(-2.000000e+00 : f32) : f32
    %2 = llvm.mlir.undef : vector<2xf32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf32>
    %7 = llvm.intr.fabs(%6)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }]

theorem inst_combine_fabs_fneg_splat_poison_v2f32   : fabs_fneg_splat_poison_v2f32_before  ⊑  fabs_fneg_splat_poison_v2f32_combined := by
  unfold fabs_fneg_splat_poison_v2f32_before fabs_fneg_splat_poison_v2f32_combined
  simp_alive_peephole
  sorry
def fabs_fneg_non_splat_v2f32_combined := [llvmfunc|
  llvm.func @fabs_fneg_non_splat_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[2.000000e+00, 3.000000e+00]> : vector<2xf32>) : vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fabs_fneg_non_splat_v2f32   : fabs_fneg_non_splat_v2f32_before  ⊑  fabs_fneg_non_splat_v2f32_combined := by
  unfold fabs_fneg_non_splat_v2f32_before fabs_fneg_non_splat_v2f32_combined
  simp_alive_peephole
  sorry
def fabs_fneg_multi_use_combined := [llvmfunc|
  llvm.func @fabs_fneg_multi_use(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    llvm.call @use(%0) : (f32) -> ()
    %1 = llvm.intr.fabs(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_fabs_fneg_multi_use   : fabs_fneg_multi_use_before  ⊑  fabs_fneg_multi_use_combined := by
  unfold fabs_fneg_multi_use_before fabs_fneg_multi_use_combined
  simp_alive_peephole
  sorry
