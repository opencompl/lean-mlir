import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fmul-exp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def exp_a_exp_b_before := [llvmfunc|
  llvm.func @exp_a_exp_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }]

def exp_a_exp_b_multiple_uses_before := [llvmfunc|
  llvm.func @exp_a_exp_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def exp_a_exp_b_multiple_uses_both_before := [llvmfunc|
  llvm.func @exp_a_exp_b_multiple_uses_both(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def exp_a_exp_b_reassoc_before := [llvmfunc|
  llvm.func @exp_a_exp_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def exp_a_a_before := [llvmfunc|
  llvm.func @exp_a_a(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %1 : f64
  }]

def exp_a_a_extra_use_before := [llvmfunc|
  llvm.func @exp_a_a_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %1 : f64
  }]

def exp_a_exp_b_exp_c_exp_d_fast_before := [llvmfunc|
  llvm.func @exp_a_exp_b_exp_c_exp_d_fast(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %3 = llvm.intr.exp(%arg2)  : (f64) -> f64
    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %5 = llvm.intr.exp(%arg3)  : (f64) -> f64
    %6 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %6 : f64
  }]

def exp_a_exp_b_combined := [llvmfunc|
  llvm.func @exp_a_exp_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_exp_a_exp_b   : exp_a_exp_b_before  ⊑  exp_a_exp_b_combined := by
  unfold exp_a_exp_b_before exp_a_exp_b_combined
  simp_alive_peephole
  sorry
def exp_a_exp_b_multiple_uses_combined := [llvmfunc|
  llvm.func @exp_a_exp_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp(%arg1)  : (f64) -> f64
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.exp(%1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_exp_a_exp_b_multiple_uses   : exp_a_exp_b_multiple_uses_before  ⊑  exp_a_exp_b_multiple_uses_combined := by
  unfold exp_a_exp_b_multiple_uses_before exp_a_exp_b_multiple_uses_combined
  simp_alive_peephole
  sorry
def exp_a_exp_b_multiple_uses_both_combined := [llvmfunc|
  llvm.func @exp_a_exp_b_multiple_uses_both(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_exp_a_exp_b_multiple_uses_both   : exp_a_exp_b_multiple_uses_both_before  ⊑  exp_a_exp_b_multiple_uses_both_combined := by
  unfold exp_a_exp_b_multiple_uses_both_before exp_a_exp_b_multiple_uses_both_combined
  simp_alive_peephole
  sorry
def exp_a_exp_b_reassoc_combined := [llvmfunc|
  llvm.func @exp_a_exp_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %1 = llvm.intr.exp(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_exp_a_exp_b_reassoc   : exp_a_exp_b_reassoc_before  ⊑  exp_a_exp_b_reassoc_combined := by
  unfold exp_a_exp_b_reassoc_before exp_a_exp_b_reassoc_combined
  simp_alive_peephole
  sorry
def exp_a_a_combined := [llvmfunc|
  llvm.func @exp_a_a(%arg0: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %1 = llvm.intr.exp(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_exp_a_a   : exp_a_a_before  ⊑  exp_a_a_combined := by
  unfold exp_a_a_before exp_a_a_combined
  simp_alive_peephole
  sorry
def exp_a_a_extra_use_combined := [llvmfunc|
  llvm.func @exp_a_a_extra_use(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_exp_a_a_extra_use   : exp_a_a_extra_use_before  ⊑  exp_a_a_extra_use_combined := by
  unfold exp_a_a_extra_use_before exp_a_a_extra_use_combined
  simp_alive_peephole
  sorry
def exp_a_exp_b_exp_c_exp_d_fast_combined := [llvmfunc|
  llvm.func @exp_a_exp_b_exp_c_exp_d_fast(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.fadd %1, %arg3  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %3 = llvm.intr.exp(%2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %3 : f64
  }]

theorem inst_combine_exp_a_exp_b_exp_c_exp_d_fast   : exp_a_exp_b_exp_c_exp_d_fast_before  ⊑  exp_a_exp_b_exp_c_exp_d_fast_combined := by
  unfold exp_a_exp_b_exp_c_exp_d_fast_before exp_a_exp_b_exp_c_exp_d_fast_combined
  simp_alive_peephole
  sorry
