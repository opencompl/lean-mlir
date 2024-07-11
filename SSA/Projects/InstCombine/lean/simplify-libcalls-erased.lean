import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  simplify-libcalls-erased
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pow_exp_before := [llvmfunc|
  llvm.func @pow_exp(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i1 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %3 = llvm.intr.pow(%2, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64]

    %4 = llvm.fcmp "ule" %2, %3 : f64
    llvm.store %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.return %3 : f64
  }]

def pow_exp_combined := [llvmfunc|
  llvm.func @pow_exp(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

theorem inst_combine_pow_exp   : pow_exp_before  ⊑  pow_exp_combined := by
  unfold pow_exp_before pow_exp_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.exp(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

theorem inst_combine_pow_exp   : pow_exp_before  ⊑  pow_exp_combined := by
  unfold pow_exp_before pow_exp_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_exp   : pow_exp_before  ⊑  pow_exp_combined := by
  unfold pow_exp_before pow_exp_combined
  simp_alive_peephole
  sorry
