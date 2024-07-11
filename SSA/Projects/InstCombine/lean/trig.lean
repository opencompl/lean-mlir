import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  trig
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def tanAtanInverseFast_before := [llvmfunc|
  llvm.func @tanAtanInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @atanf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.call @tanf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def atanhTanhInverseFast_before := [llvmfunc|
  llvm.func @atanhTanhInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @tanhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.call @atanhf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def sinhAsinhInverseFast_before := [llvmfunc|
  llvm.func @sinhAsinhInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @asinhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.call @sinhf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def asinhSinhInverseFast_before := [llvmfunc|
  llvm.func @asinhSinhInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @sinhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.call @asinhf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def coshAcoshInverseFast_before := [llvmfunc|
  llvm.func @coshAcoshInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @acoshf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    %1 = llvm.call @coshf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def indirectTanCall_before := [llvmfunc|
  llvm.func @indirectTanCall(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.call %arg0() {fastmathFlags = #llvm.fastmath<fast>} : !llvm.ptr, () -> f32]

    %1 = llvm.call @tanf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def tanAtanInverse_before := [llvmfunc|
  llvm.func @tanAtanInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @atanf(%arg0) : (f32) -> f32
    %1 = llvm.call @tanf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def atanhTanhInverse_before := [llvmfunc|
  llvm.func @atanhTanhInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @tanhf(%arg0) : (f32) -> f32
    %1 = llvm.call @atanhf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def sinhAsinhInverse_before := [llvmfunc|
  llvm.func @sinhAsinhInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @asinhf(%arg0) : (f32) -> f32
    %1 = llvm.call @sinhf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def asinhSinhInverse_before := [llvmfunc|
  llvm.func @asinhSinhInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @sinhf(%arg0) : (f32) -> f32
    %1 = llvm.call @asinhf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def coshAcoshInverse_before := [llvmfunc|
  llvm.func @coshAcoshInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @acoshf(%arg0) : (f32) -> f32
    %1 = llvm.call @coshf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

def tanAtanInverseFast_combined := [llvmfunc|
  llvm.func @tanAtanInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @atanf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_tanAtanInverseFast   : tanAtanInverseFast_before  ⊑  tanAtanInverseFast_combined := by
  unfold tanAtanInverseFast_before tanAtanInverseFast_combined
  simp_alive_peephole
  sorry
    llvm.return %arg0 : f32
  }]

theorem inst_combine_tanAtanInverseFast   : tanAtanInverseFast_before  ⊑  tanAtanInverseFast_combined := by
  unfold tanAtanInverseFast_before tanAtanInverseFast_combined
  simp_alive_peephole
  sorry
def atanhTanhInverseFast_combined := [llvmfunc|
  llvm.func @atanhTanhInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @tanhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_atanhTanhInverseFast   : atanhTanhInverseFast_before  ⊑  atanhTanhInverseFast_combined := by
  unfold atanhTanhInverseFast_before atanhTanhInverseFast_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @atanhf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_atanhTanhInverseFast   : atanhTanhInverseFast_before  ⊑  atanhTanhInverseFast_combined := by
  unfold atanhTanhInverseFast_before atanhTanhInverseFast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_atanhTanhInverseFast   : atanhTanhInverseFast_before  ⊑  atanhTanhInverseFast_combined := by
  unfold atanhTanhInverseFast_before atanhTanhInverseFast_combined
  simp_alive_peephole
  sorry
def sinhAsinhInverseFast_combined := [llvmfunc|
  llvm.func @sinhAsinhInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @asinhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_sinhAsinhInverseFast   : sinhAsinhInverseFast_before  ⊑  sinhAsinhInverseFast_combined := by
  unfold sinhAsinhInverseFast_before sinhAsinhInverseFast_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @sinhf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_sinhAsinhInverseFast   : sinhAsinhInverseFast_before  ⊑  sinhAsinhInverseFast_combined := by
  unfold sinhAsinhInverseFast_before sinhAsinhInverseFast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_sinhAsinhInverseFast   : sinhAsinhInverseFast_before  ⊑  sinhAsinhInverseFast_combined := by
  unfold sinhAsinhInverseFast_before sinhAsinhInverseFast_combined
  simp_alive_peephole
  sorry
def asinhSinhInverseFast_combined := [llvmfunc|
  llvm.func @asinhSinhInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @sinhf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_asinhSinhInverseFast   : asinhSinhInverseFast_before  ⊑  asinhSinhInverseFast_combined := by
  unfold asinhSinhInverseFast_before asinhSinhInverseFast_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @asinhf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_asinhSinhInverseFast   : asinhSinhInverseFast_before  ⊑  asinhSinhInverseFast_combined := by
  unfold asinhSinhInverseFast_before asinhSinhInverseFast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_asinhSinhInverseFast   : asinhSinhInverseFast_before  ⊑  asinhSinhInverseFast_combined := by
  unfold asinhSinhInverseFast_before asinhSinhInverseFast_combined
  simp_alive_peephole
  sorry
def coshAcoshInverseFast_combined := [llvmfunc|
  llvm.func @coshAcoshInverseFast(%arg0: f32) -> f32 {
    %0 = llvm.call @acoshf(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_coshAcoshInverseFast   : coshAcoshInverseFast_before  ⊑  coshAcoshInverseFast_combined := by
  unfold coshAcoshInverseFast_before coshAcoshInverseFast_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @coshf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_coshAcoshInverseFast   : coshAcoshInverseFast_before  ⊑  coshAcoshInverseFast_combined := by
  unfold coshAcoshInverseFast_before coshAcoshInverseFast_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_coshAcoshInverseFast   : coshAcoshInverseFast_before  ⊑  coshAcoshInverseFast_combined := by
  unfold coshAcoshInverseFast_before coshAcoshInverseFast_combined
  simp_alive_peephole
  sorry
def indirectTanCall_combined := [llvmfunc|
  llvm.func @indirectTanCall(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.call %arg0() {fastmathFlags = #llvm.fastmath<fast>} : !llvm.ptr, () -> f32]

theorem inst_combine_indirectTanCall   : indirectTanCall_before  ⊑  indirectTanCall_combined := by
  unfold indirectTanCall_before indirectTanCall_combined
  simp_alive_peephole
  sorry
    %1 = llvm.call @tanf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_indirectTanCall   : indirectTanCall_before  ⊑  indirectTanCall_combined := by
  unfold indirectTanCall_before indirectTanCall_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_indirectTanCall   : indirectTanCall_before  ⊑  indirectTanCall_combined := by
  unfold indirectTanCall_before indirectTanCall_combined
  simp_alive_peephole
  sorry
def tanAtanInverse_combined := [llvmfunc|
  llvm.func @tanAtanInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @atanf(%arg0) : (f32) -> f32
    %1 = llvm.call @tanf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_tanAtanInverse   : tanAtanInverse_before  ⊑  tanAtanInverse_combined := by
  unfold tanAtanInverse_before tanAtanInverse_combined
  simp_alive_peephole
  sorry
def atanhTanhInverse_combined := [llvmfunc|
  llvm.func @atanhTanhInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @tanhf(%arg0) : (f32) -> f32
    %1 = llvm.call @atanhf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_atanhTanhInverse   : atanhTanhInverse_before  ⊑  atanhTanhInverse_combined := by
  unfold atanhTanhInverse_before atanhTanhInverse_combined
  simp_alive_peephole
  sorry
def sinhAsinhInverse_combined := [llvmfunc|
  llvm.func @sinhAsinhInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @asinhf(%arg0) : (f32) -> f32
    %1 = llvm.call @sinhf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_sinhAsinhInverse   : sinhAsinhInverse_before  ⊑  sinhAsinhInverse_combined := by
  unfold sinhAsinhInverse_before sinhAsinhInverse_combined
  simp_alive_peephole
  sorry
def asinhSinhInverse_combined := [llvmfunc|
  llvm.func @asinhSinhInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @sinhf(%arg0) : (f32) -> f32
    %1 = llvm.call @asinhf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_asinhSinhInverse   : asinhSinhInverse_before  ⊑  asinhSinhInverse_combined := by
  unfold asinhSinhInverse_before asinhSinhInverse_combined
  simp_alive_peephole
  sorry
def coshAcoshInverse_combined := [llvmfunc|
  llvm.func @coshAcoshInverse(%arg0: f32) -> f32 {
    %0 = llvm.call @acoshf(%arg0) : (f32) -> f32
    %1 = llvm.call @coshf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }]

theorem inst_combine_coshAcoshInverse   : coshAcoshInverse_before  ⊑  coshAcoshInverse_combined := by
  unfold coshAcoshInverse_before coshAcoshInverse_combined
  simp_alive_peephole
  sorry
