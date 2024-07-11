import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  no_cgscc_assert
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: f32) -> f32 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.call @sqrtf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

    llvm.return %1 : f32
  }]

def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<fast>} : (f32) -> f32]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
