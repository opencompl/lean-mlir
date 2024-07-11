import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cos-sin-intrinsic
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def undef_arg_before := [llvmfunc|
  llvm.func @undef_arg() -> f64 {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.intr.cos(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }]

def undef_arg2_before := [llvmfunc|
  llvm.func @undef_arg2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.intr.cos(%arg0)  : (f32) -> f32
    %2 = llvm.intr.cos(%0)  : (f32) -> f32
    %3 = llvm.fadd %2, %1  : f32
    llvm.return %3 : f32
  }]

def fneg_f32_before := [llvmfunc|
  llvm.func @fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.fsub %0, %arg0  : f32
    %2 = llvm.intr.cos(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

def unary_fneg_f32_before := [llvmfunc|
  llvm.func @unary_fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.cos(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def fneg_v2f32_before := [llvmfunc|
  llvm.func @fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.intr.cos(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def unary_fneg_v2f32_before := [llvmfunc|
  llvm.func @unary_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.intr.cos(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def fneg_cos_fmf_before := [llvmfunc|
  llvm.func @fneg_cos_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %2 = llvm.intr.cos(%1)  {fastmathFlags = #llvm.fastmath<nnan, afn>} : (vector<2xf32>) -> vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def unary_fneg_cos_fmf_before := [llvmfunc|
  llvm.func @unary_fneg_cos_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %1 = llvm.intr.cos(%0)  {fastmathFlags = #llvm.fastmath<nnan, afn>} : (vector<2xf32>) -> vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def fabs_f32_before := [llvmfunc|
  llvm.func @fabs_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.cos(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }]

def fabs_fneg_f32_before := [llvmfunc|
  llvm.func @fabs_fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fsub %0, %1  : f32
    %3 = llvm.intr.cos(%2)  : (f32) -> f32
    llvm.return %3 : f32
  }]

def fabs_unary_fneg_f32_before := [llvmfunc|
  llvm.func @fabs_unary_fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.fneg %0  : f32
    %2 = llvm.intr.cos(%1)  : (f32) -> f32
    llvm.return %2 : f32
  }]

def fabs_fneg_v2f32_before := [llvmfunc|
  llvm.func @fabs_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %2 = llvm.fsub %0, %1  : vector<2xf32>
    %3 = llvm.intr.cos(%2)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }]

def fabs_unary_fneg_v2f32_before := [llvmfunc|
  llvm.func @fabs_unary_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    %2 = llvm.intr.cos(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def fneg_sin_before := [llvmfunc|
  llvm.func @fneg_sin(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.intr.sin(%1)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %2 : vector<2xf32>
  }]

def unary_fneg_sin_before := [llvmfunc|
  llvm.func @unary_fneg_sin(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  : vector<2xf32>
    %1 = llvm.intr.sin(%0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

def fneg_sin_fmf_before := [llvmfunc|
  llvm.func @fneg_sin_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %2 = llvm.intr.sin(%1)  {fastmathFlags = #llvm.fastmath<nnan, arcp, afn>} : (vector<2xf32>) -> vector<2xf32>]

    llvm.return %2 : vector<2xf32>
  }]

def unary_fneg_sin_fmf_before := [llvmfunc|
  llvm.func @unary_fneg_sin_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : vector<2xf32>]

    %1 = llvm.intr.sin(%0)  {fastmathFlags = #llvm.fastmath<nnan, arcp, afn>} : (vector<2xf32>) -> vector<2xf32>]

    llvm.return %1 : vector<2xf32>
  }]

def undef_arg_combined := [llvmfunc|
  llvm.func @undef_arg() -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    llvm.return %0 : f64
  }]

theorem inst_combine_undef_arg   : undef_arg_before  ⊑  undef_arg_combined := by
  unfold undef_arg_before undef_arg_combined
  simp_alive_peephole
  sorry
def undef_arg2_combined := [llvmfunc|
  llvm.func @undef_arg2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.cos(%arg0)  : (f32) -> f32
    %2 = llvm.fadd %1, %0  : f32
    llvm.return %2 : f32
  }]

theorem inst_combine_undef_arg2   : undef_arg2_before  ⊑  undef_arg2_combined := by
  unfold undef_arg2_before undef_arg2_combined
  simp_alive_peephole
  sorry
def fneg_f32_combined := [llvmfunc|
  llvm.func @fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.cos(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fneg_f32   : fneg_f32_before  ⊑  fneg_f32_combined := by
  unfold fneg_f32_before fneg_f32_combined
  simp_alive_peephole
  sorry
def unary_fneg_f32_combined := [llvmfunc|
  llvm.func @unary_fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.cos(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_unary_fneg_f32   : unary_fneg_f32_before  ⊑  unary_fneg_f32_combined := by
  unfold unary_fneg_f32_before unary_fneg_f32_combined
  simp_alive_peephole
  sorry
def fneg_v2f32_combined := [llvmfunc|
  llvm.func @fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.cos(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fneg_v2f32   : fneg_v2f32_before  ⊑  fneg_v2f32_combined := by
  unfold fneg_v2f32_before fneg_v2f32_combined
  simp_alive_peephole
  sorry
def unary_fneg_v2f32_combined := [llvmfunc|
  llvm.func @unary_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.cos(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_unary_fneg_v2f32   : unary_fneg_v2f32_before  ⊑  unary_fneg_v2f32_combined := by
  unfold unary_fneg_v2f32_before unary_fneg_v2f32_combined
  simp_alive_peephole
  sorry
def fneg_cos_fmf_combined := [llvmfunc|
  llvm.func @fneg_cos_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, afn>} : (vector<2xf32>) -> vector<2xf32>]

theorem inst_combine_fneg_cos_fmf   : fneg_cos_fmf_before  ⊑  fneg_cos_fmf_combined := by
  unfold fneg_cos_fmf_before fneg_cos_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fneg_cos_fmf   : fneg_cos_fmf_before  ⊑  fneg_cos_fmf_combined := by
  unfold fneg_cos_fmf_before fneg_cos_fmf_combined
  simp_alive_peephole
  sorry
def unary_fneg_cos_fmf_combined := [llvmfunc|
  llvm.func @unary_fneg_cos_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.cos(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, afn>} : (vector<2xf32>) -> vector<2xf32>]

theorem inst_combine_unary_fneg_cos_fmf   : unary_fneg_cos_fmf_before  ⊑  unary_fneg_cos_fmf_combined := by
  unfold unary_fneg_cos_fmf_before unary_fneg_cos_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_unary_fneg_cos_fmf   : unary_fneg_cos_fmf_before  ⊑  unary_fneg_cos_fmf_combined := by
  unfold unary_fneg_cos_fmf_before unary_fneg_cos_fmf_combined
  simp_alive_peephole
  sorry
def fabs_f32_combined := [llvmfunc|
  llvm.func @fabs_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.cos(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_f32   : fabs_f32_before  ⊑  fabs_f32_combined := by
  unfold fabs_f32_before fabs_f32_combined
  simp_alive_peephole
  sorry
def fabs_fneg_f32_combined := [llvmfunc|
  llvm.func @fabs_fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.cos(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_fneg_f32   : fabs_fneg_f32_before  ⊑  fabs_fneg_f32_combined := by
  unfold fabs_fneg_f32_before fabs_fneg_f32_combined
  simp_alive_peephole
  sorry
def fabs_unary_fneg_f32_combined := [llvmfunc|
  llvm.func @fabs_unary_fneg_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.cos(%arg0)  : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_unary_fneg_f32   : fabs_unary_fneg_f32_before  ⊑  fabs_unary_fneg_f32_combined := by
  unfold fabs_unary_fneg_f32_before fabs_unary_fneg_f32_combined
  simp_alive_peephole
  sorry
def fabs_fneg_v2f32_combined := [llvmfunc|
  llvm.func @fabs_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.cos(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fabs_fneg_v2f32   : fabs_fneg_v2f32_before  ⊑  fabs_fneg_v2f32_combined := by
  unfold fabs_fneg_v2f32_before fabs_fneg_v2f32_combined
  simp_alive_peephole
  sorry
def fabs_unary_fneg_v2f32_combined := [llvmfunc|
  llvm.func @fabs_unary_fneg_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.cos(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %0 : vector<2xf32>
  }]

theorem inst_combine_fabs_unary_fneg_v2f32   : fabs_unary_fneg_v2f32_before  ⊑  fabs_unary_fneg_v2f32_combined := by
  unfold fabs_unary_fneg_v2f32_before fabs_unary_fneg_v2f32_combined
  simp_alive_peephole
  sorry
def fneg_sin_combined := [llvmfunc|
  llvm.func @fneg_sin(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.sin(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fneg_sin   : fneg_sin_before  ⊑  fneg_sin_combined := by
  unfold fneg_sin_before fneg_sin_combined
  simp_alive_peephole
  sorry
def unary_fneg_sin_combined := [llvmfunc|
  llvm.func @unary_fneg_sin(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.sin(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.fneg %0  : vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_unary_fneg_sin   : unary_fneg_sin_before  ⊑  unary_fneg_sin_combined := by
  unfold unary_fneg_sin_before unary_fneg_sin_combined
  simp_alive_peephole
  sorry
def fneg_sin_fmf_combined := [llvmfunc|
  llvm.func @fneg_sin_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, arcp, afn>} : (vector<2xf32>) -> vector<2xf32>]

theorem inst_combine_fneg_sin_fmf   : fneg_sin_fmf_before  ⊑  fneg_sin_fmf_combined := by
  unfold fneg_sin_fmf_before fneg_sin_fmf_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, arcp, afn>} : vector<2xf32>]

theorem inst_combine_fneg_sin_fmf   : fneg_sin_fmf_before  ⊑  fneg_sin_fmf_combined := by
  unfold fneg_sin_fmf_before fneg_sin_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_fneg_sin_fmf   : fneg_sin_fmf_before  ⊑  fneg_sin_fmf_combined := by
  unfold fneg_sin_fmf_before fneg_sin_fmf_combined
  simp_alive_peephole
  sorry
def unary_fneg_sin_fmf_combined := [llvmfunc|
  llvm.func @unary_fneg_sin_fmf(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.sin(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, arcp, afn>} : (vector<2xf32>) -> vector<2xf32>]

theorem inst_combine_unary_fneg_sin_fmf   : unary_fneg_sin_fmf_before  ⊑  unary_fneg_sin_fmf_combined := by
  unfold unary_fneg_sin_fmf_before unary_fneg_sin_fmf_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, arcp, afn>} : vector<2xf32>]

theorem inst_combine_unary_fneg_sin_fmf   : unary_fneg_sin_fmf_before  ⊑  unary_fneg_sin_fmf_combined := by
  unfold unary_fneg_sin_fmf_before unary_fneg_sin_fmf_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : vector<2xf32>
  }]

theorem inst_combine_unary_fneg_sin_fmf   : unary_fneg_sin_fmf_before  ⊑  unary_fneg_sin_fmf_combined := by
  unfold unary_fneg_sin_fmf_before unary_fneg_sin_fmf_combined
  simp_alive_peephole
  sorry
