import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pow-to-sqrt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pow_to_sqrt_before := [llvmfunc|
  llvm.func @pow_to_sqrt(%arg0: f64) {
    %0 = llvm.mlir.constant(1.500000e+00 : f64) : f64
    %1 = llvm.call @pow(%arg0, %0) {fastmathFlags = #llvm.fastmath<afn>} : (f64, f64) -> f64]

    llvm.return
  }]

def pow_to_sqrt_combined := [llvmfunc|
  llvm.func @pow_to_sqrt(%arg0: f64) {
    %0 = llvm.call @sqrt(%arg0) {fastmathFlags = #llvm.fastmath<afn>} : (f64) -> f64
    llvm.return
  }]

theorem inst_combine_pow_to_sqrt   : pow_to_sqrt_before  ⊑  pow_to_sqrt_combined := by
  unfold pow_to_sqrt_before pow_to_sqrt_combined
  simp_alive_peephole
  sorry
