import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fmul-exp2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def exp2_a_exp2_b_before := [llvmfunc|
  llvm.func @exp2_a_exp2_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }]

def exp2_a_exp2_b_multiple_uses_before := [llvmfunc|
  llvm.func @exp2_a_exp2_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def exp2_a_a_before := [llvmfunc|
  llvm.func @exp2_a_a(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %1 : f64
  }]

def exp2_a_exp2_b_multiple_uses_both_before := [llvmfunc|
  llvm.func @exp2_a_exp2_b_multiple_uses_both(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def exp2_a_exp2_b_reassoc_before := [llvmfunc|
  llvm.func @exp2_a_exp2_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def exp2_a_exp2_b_exp2_c_exp2_d_before := [llvmfunc|
  llvm.func @exp2_a_exp2_b_exp2_c_exp2_d(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %3 = llvm.intr.exp2(%arg2)  : (f64) -> f64
    %4 = llvm.fmul %2, %3  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %5 = llvm.intr.exp2(%arg3)  : (f64) -> f64
    %6 = llvm.fmul %4, %5  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %6 : f64
  }]

def exp2_a_exp2_b_combined := [llvmfunc|
  llvm.func @exp2_a_exp2_b(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_exp2_a_exp2_b   : exp2_a_exp2_b_before  ⊑  exp2_a_exp2_b_combined := by
  unfold exp2_a_exp2_b_before exp2_a_exp2_b_combined
  simp_alive_peephole
  sorry
def exp2_a_exp2_b_multiple_uses_combined := [llvmfunc|
  llvm.func @exp2_a_exp2_b_multiple_uses(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %1 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_exp2_a_exp2_b_multiple_uses   : exp2_a_exp2_b_multiple_uses_before  ⊑  exp2_a_exp2_b_multiple_uses_combined := by
  unfold exp2_a_exp2_b_multiple_uses_before exp2_a_exp2_b_multiple_uses_combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.exp2(%1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_exp2_a_exp2_b_multiple_uses   : exp2_a_exp2_b_multiple_uses_before  ⊑  exp2_a_exp2_b_multiple_uses_combined := by
  unfold exp2_a_exp2_b_multiple_uses_before exp2_a_exp2_b_multiple_uses_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_exp2_a_exp2_b_multiple_uses   : exp2_a_exp2_b_multiple_uses_before  ⊑  exp2_a_exp2_b_multiple_uses_combined := by
  unfold exp2_a_exp2_b_multiple_uses_before exp2_a_exp2_b_multiple_uses_combined
  simp_alive_peephole
  sorry
def exp2_a_a_combined := [llvmfunc|
  llvm.func @exp2_a_a(%arg0: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_exp2_a_a   : exp2_a_a_before  ⊑  exp2_a_a_combined := by
  unfold exp2_a_a_before exp2_a_a_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_exp2_a_a   : exp2_a_a_before  ⊑  exp2_a_a_combined := by
  unfold exp2_a_a_before exp2_a_a_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_exp2_a_a   : exp2_a_a_before  ⊑  exp2_a_a_combined := by
  unfold exp2_a_a_before exp2_a_a_combined
  simp_alive_peephole
  sorry
def exp2_a_exp2_b_multiple_uses_both_combined := [llvmfunc|
  llvm.func @exp2_a_exp2_b_multiple_uses_both(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.exp2(%arg0)  : (f64) -> f64
    %1 = llvm.intr.exp2(%arg1)  : (f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_exp2_a_exp2_b_multiple_uses_both   : exp2_a_exp2_b_multiple_uses_both_before  ⊑  exp2_a_exp2_b_multiple_uses_both_combined := by
  unfold exp2_a_exp2_b_multiple_uses_both_before exp2_a_exp2_b_multiple_uses_both_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_exp2_a_exp2_b_multiple_uses_both   : exp2_a_exp2_b_multiple_uses_both_before  ⊑  exp2_a_exp2_b_multiple_uses_both_combined := by
  unfold exp2_a_exp2_b_multiple_uses_both_before exp2_a_exp2_b_multiple_uses_both_combined
  simp_alive_peephole
  sorry
def exp2_a_exp2_b_reassoc_combined := [llvmfunc|
  llvm.func @exp2_a_exp2_b_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_exp2_a_exp2_b_reassoc   : exp2_a_exp2_b_reassoc_before  ⊑  exp2_a_exp2_b_reassoc_combined := by
  unfold exp2_a_exp2_b_reassoc_before exp2_a_exp2_b_reassoc_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.exp2(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_exp2_a_exp2_b_reassoc   : exp2_a_exp2_b_reassoc_before  ⊑  exp2_a_exp2_b_reassoc_combined := by
  unfold exp2_a_exp2_b_reassoc_before exp2_a_exp2_b_reassoc_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f64
  }]

theorem inst_combine_exp2_a_exp2_b_reassoc   : exp2_a_exp2_b_reassoc_before  ⊑  exp2_a_exp2_b_reassoc_combined := by
  unfold exp2_a_exp2_b_reassoc_before exp2_a_exp2_b_reassoc_combined
  simp_alive_peephole
  sorry
def exp2_a_exp2_b_exp2_c_exp2_d_combined := [llvmfunc|
  llvm.func @exp2_a_exp2_b_exp2_c_exp2_d(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: f64) -> f64 {
    %0 = llvm.fadd %arg0, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_exp2_a_exp2_b_exp2_c_exp2_d   : exp2_a_exp2_b_exp2_c_exp2_d_before  ⊑  exp2_a_exp2_b_exp2_c_exp2_d_combined := by
  unfold exp2_a_exp2_b_exp2_c_exp2_d_before exp2_a_exp2_b_exp2_c_exp2_d_combined
  simp_alive_peephole
  sorry
    %1 = llvm.fadd %0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_exp2_a_exp2_b_exp2_c_exp2_d   : exp2_a_exp2_b_exp2_c_exp2_d_before  ⊑  exp2_a_exp2_b_exp2_c_exp2_d_combined := by
  unfold exp2_a_exp2_b_exp2_c_exp2_d_before exp2_a_exp2_b_exp2_c_exp2_d_combined
  simp_alive_peephole
  sorry
    %2 = llvm.fadd %1, %arg3  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

theorem inst_combine_exp2_a_exp2_b_exp2_c_exp2_d   : exp2_a_exp2_b_exp2_c_exp2_d_before  ⊑  exp2_a_exp2_b_exp2_c_exp2_d_combined := by
  unfold exp2_a_exp2_b_exp2_c_exp2_d_before exp2_a_exp2_b_exp2_c_exp2_d_combined
  simp_alive_peephole
  sorry
    %3 = llvm.intr.exp2(%2)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

theorem inst_combine_exp2_a_exp2_b_exp2_c_exp2_d   : exp2_a_exp2_b_exp2_c_exp2_d_before  ⊑  exp2_a_exp2_b_exp2_c_exp2_d_combined := by
  unfold exp2_a_exp2_b_exp2_c_exp2_d_before exp2_a_exp2_b_exp2_c_exp2_d_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : f64
  }]

theorem inst_combine_exp2_a_exp2_b_exp2_c_exp2_d   : exp2_a_exp2_b_exp2_c_exp2_d_before  ⊑  exp2_a_exp2_b_exp2_c_exp2_d_combined := by
  unfold exp2_a_exp2_b_exp2_c_exp2_d_before exp2_a_exp2_b_exp2_c_exp2_d_combined
  simp_alive_peephole
  sorry
