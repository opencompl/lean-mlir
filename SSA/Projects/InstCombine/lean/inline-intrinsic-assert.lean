import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  inline-intrinsic-assert
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: f32) -> f32 {
    %0 = llvm.call @bar(%arg0) : (f32) -> f32
    llvm.return %0 : f32
  }]

def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: f32) -> f32 {
    %0 = llvm.call @sqr(%arg0) : (f32) -> f32
    %1 = llvm.call @sqrtf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def sqr_before := [llvmfunc|
  llvm.func @sqr(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %0 : f32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32
    llvm.return %0 : f32
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
def sqr_combined := [llvmfunc|
  llvm.func @sqr(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %0 : f32
  }]

theorem inst_combine_sqr   : sqr_before  ⊑  sqr_combined := by
  unfold sqr_before sqr_combined
  simp_alive_peephole
  sorry
