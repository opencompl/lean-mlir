import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  copysign
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def positive_sign_arg_before := [llvmfunc|
  llvm.func @positive_sign_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<arcp>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def positive_sign_arg_vec_splat_before := [llvmfunc|
  llvm.func @positive_sign_arg_vec_splat(%arg0: vector<3xf64>) -> vector<3xf64> {
    %0 = llvm.mlir.constant(dense<4.200000e+01> : vector<3xf64>) : vector<3xf64>
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf>} : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>]

    llvm.return %1 : vector<3xf64>
  }]

def negative_sign_arg_before := [llvmfunc|
  llvm.func @negative_sign_arg(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def negative_sign_arg_vec_splat_before := [llvmfunc|
  llvm.func @negative_sign_arg_vec_splat(%arg0: vector<3xf64>) -> vector<3xf64> {
    %0 = llvm.mlir.constant(dense<-4.200000e+01> : vector<3xf64>) : vector<3xf64>
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>]

    llvm.return %1 : vector<3xf64>
  }]

def known_positive_sign_arg_before := [llvmfunc|
  llvm.func @known_positive_sign_arg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg1)  : (f32) -> f32
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def known_positive_sign_arg_vec_before := [llvmfunc|
  llvm.func @known_positive_sign_arg_vec(%arg0: vector<3xf64>, %arg1: vector<3xi32>) -> vector<3xf64> {
    %0 = llvm.uitofp %arg1 : vector<3xi32> to vector<3xf64>
    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<arcp>} : (vector<3xf64>, vector<3xf64>) -> vector<3xf64>]

    llvm.return %1 : vector<3xf64>
  }]

def not_known_positive_sign_arg_before := [llvmfunc|
  llvm.func @not_known_positive_sign_arg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.maxnum(%arg0, %0)  : (f32, f32) -> f32
    %2 = llvm.intr.copysign(%arg1, %1)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %2 : f32
  }]

def copysign_sign_arg_before := [llvmfunc|
  llvm.func @copysign_sign_arg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg1, %arg2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f32, f32) -> f32]

    %1 = llvm.intr.copysign(%arg0, %0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32]

    llvm.return %1 : f32
  }]

def fneg_mag_before := [llvmfunc|
  llvm.func @fneg_mag(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.intr.copysign(%0, %arg1)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def fabs_mag_before := [llvmfunc|
  llvm.func @fabs_mag(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.intr.copysign(%0, %arg1)  : (f32, f32) -> f32
    llvm.return %1 : f32
  }]

def positive_sign_arg_combined := [llvmfunc|
  llvm.func @positive_sign_arg(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<arcp>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_positive_sign_arg   : positive_sign_arg_before  ⊑  positive_sign_arg_combined := by
  unfold positive_sign_arg_before positive_sign_arg_combined
  simp_alive_peephole
  sorry
def positive_sign_arg_vec_splat_combined := [llvmfunc|
  llvm.func @positive_sign_arg_vec_splat(%arg0: vector<3xf64>) -> vector<3xf64> {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<ninf>} : (vector<3xf64>) -> vector<3xf64>
    llvm.return %0 : vector<3xf64>
  }]

theorem inst_combine_positive_sign_arg_vec_splat   : positive_sign_arg_vec_splat_before  ⊑  positive_sign_arg_vec_splat_combined := by
  unfold positive_sign_arg_vec_splat_before positive_sign_arg_vec_splat_combined
  simp_alive_peephole
  sorry
def negative_sign_arg_combined := [llvmfunc|
  llvm.func @negative_sign_arg(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %1 : f32
  }]

theorem inst_combine_negative_sign_arg   : negative_sign_arg_before  ⊑  negative_sign_arg_combined := by
  unfold negative_sign_arg_before negative_sign_arg_combined
  simp_alive_peephole
  sorry
def negative_sign_arg_vec_splat_combined := [llvmfunc|
  llvm.func @negative_sign_arg_vec_splat(%arg0: vector<3xf64>) -> vector<3xf64> {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (vector<3xf64>) -> vector<3xf64>
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<fast>} : vector<3xf64>
    llvm.return %1 : vector<3xf64>
  }]

theorem inst_combine_negative_sign_arg_vec_splat   : negative_sign_arg_vec_splat_before  ⊑  negative_sign_arg_vec_splat_combined := by
  unfold negative_sign_arg_vec_splat_before negative_sign_arg_vec_splat_combined
  simp_alive_peephole
  sorry
def known_positive_sign_arg_combined := [llvmfunc|
  llvm.func @known_positive_sign_arg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_known_positive_sign_arg   : known_positive_sign_arg_before  ⊑  known_positive_sign_arg_combined := by
  unfold known_positive_sign_arg_before known_positive_sign_arg_combined
  simp_alive_peephole
  sorry
def known_positive_sign_arg_vec_combined := [llvmfunc|
  llvm.func @known_positive_sign_arg_vec(%arg0: vector<3xf64>, %arg1: vector<3xi32>) -> vector<3xf64> {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<arcp>} : (vector<3xf64>) -> vector<3xf64>
    llvm.return %0 : vector<3xf64>
  }]

theorem inst_combine_known_positive_sign_arg_vec   : known_positive_sign_arg_vec_before  ⊑  known_positive_sign_arg_vec_combined := by
  unfold known_positive_sign_arg_vec_before known_positive_sign_arg_vec_combined
  simp_alive_peephole
  sorry
def not_known_positive_sign_arg_combined := [llvmfunc|
  llvm.func @not_known_positive_sign_arg(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.intr.maxnum(%arg0, %0)  : (f32, f32) -> f32
    %2 = llvm.intr.copysign(%arg1, %1)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %2 : f32
  }]

theorem inst_combine_not_known_positive_sign_arg   : not_known_positive_sign_arg_before  ⊑  not_known_positive_sign_arg_combined := by
  unfold not_known_positive_sign_arg_before not_known_positive_sign_arg_combined
  simp_alive_peephole
  sorry
def copysign_sign_arg_combined := [llvmfunc|
  llvm.func @copysign_sign_arg(%arg0: f32, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg2)  {fastmathFlags = #llvm.fastmath<ninf>} : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_copysign_sign_arg   : copysign_sign_arg_before  ⊑  copysign_sign_arg_combined := by
  unfold copysign_sign_arg_before copysign_sign_arg_combined
  simp_alive_peephole
  sorry
def fneg_mag_combined := [llvmfunc|
  llvm.func @fneg_mag(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fneg_mag   : fneg_mag_before  ⊑  fneg_mag_combined := by
  unfold fneg_mag_before fneg_mag_combined
  simp_alive_peephole
  sorry
def fabs_mag_combined := [llvmfunc|
  llvm.func @fabs_mag(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.copysign(%arg0, %arg1)  : (f32, f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_fabs_mag   : fabs_mag_before  ⊑  fabs_mag_combined := by
  unfold fabs_mag_before fabs_mag_combined
  simp_alive_peephole
  sorry
