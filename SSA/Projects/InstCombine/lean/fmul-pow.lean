import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fmul-pow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pow_ab_a_before := [llvmfunc|
  llvm.func @pow_ab_a(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  : f64
    llvm.return %1 : f64
  }]

def pow_ab_a_reassoc_before := [llvmfunc|
  llvm.func @pow_ab_a_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %1 : f64
  }]

def pow_ab_a_reassoc_commute_before := [llvmfunc|
  llvm.func @pow_ab_a_reassoc_commute(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.fadd %arg0, %0  : f64
    %2 = llvm.intr.pow(%1, %arg1)  : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %3 : f64
  }]

def pow_ab_a_reassoc_use_before := [llvmfunc|
  llvm.func @pow_ab_a_reassoc_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }]

def pow_ab_recip_a_before := [llvmfunc|
  llvm.func @pow_ab_recip_a(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  : f64
    llvm.return %3 : f64
  }]

def pow_ab_recip_a_reassoc_before := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64]

    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %3 : f64
  }]

def pow_ab_recip_a_reassoc_commute_before := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc_commute(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64]

    %3 = llvm.fmul %2, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %3 : f64
  }]

def pow_ab_recip_a_reassoc_use1_before := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc_use1(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64]

    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%1) : (f64) -> ()
    llvm.return %3 : f64
  }]

def pow_ab_recip_a_reassoc_use2_before := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc_use2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64]

    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%2) : (f64) -> ()
    llvm.return %3 : f64
  }]

def pow_ab_recip_a_reassoc_use3_before := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc_use3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64]

    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%1) : (f64) -> ()
    llvm.call @use(%2) : (f64) -> ()
    llvm.return %3 : f64
  }]

def pow_ab_pow_cb_before := [llvmfunc|
  llvm.func @pow_ab_pow_cb(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }]

def pow_ab_pow_cb_reassoc_before := [llvmfunc|
  llvm.func @pow_ab_pow_cb_reassoc(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def pow_ab_pow_cb_reassoc_use1_before := [llvmfunc|
  llvm.func @pow_ab_pow_cb_reassoc_use1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }]

def pow_ab_pow_cb_reassoc_use2_before := [llvmfunc|
  llvm.func @pow_ab_pow_cb_reassoc_use2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def pow_ab_pow_cb_reassoc_use3_before := [llvmfunc|
  llvm.func @pow_ab_pow_cb_reassoc_use3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def pow_ab_pow_ac_before := [llvmfunc|
  llvm.func @pow_ab_pow_ac(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }]

def pow_ab_x_pow_ac_reassoc_before := [llvmfunc|
  llvm.func @pow_ab_x_pow_ac_reassoc(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def pow_ab_reassoc_before := [llvmfunc|
  llvm.func @pow_ab_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %1 : f64
  }]

def pow_ab_reassoc_extra_use_before := [llvmfunc|
  llvm.func @pow_ab_reassoc_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }]

def pow_ab_x_pow_ac_reassoc_extra_use_before := [llvmfunc|
  llvm.func @pow_ab_x_pow_ac_reassoc_extra_use(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }]

def pow_ab_x_pow_ac_reassoc_multiple_uses_before := [llvmfunc|
  llvm.func @pow_ab_x_pow_ac_reassoc_multiple_uses(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

def pow_ab_a_combined := [llvmfunc|
  llvm.func @pow_ab_a(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_ab_a   : pow_ab_a_before  ⊑  pow_ab_a_combined := by
  unfold pow_ab_a_before pow_ab_a_combined
  simp_alive_peephole
  sorry
def pow_ab_a_reassoc_combined := [llvmfunc|
  llvm.func @pow_ab_a_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_a_reassoc   : pow_ab_a_reassoc_before  ⊑  pow_ab_a_reassoc_combined := by
  unfold pow_ab_a_reassoc_before pow_ab_a_reassoc_combined
  simp_alive_peephole
  sorry
def pow_ab_a_reassoc_commute_combined := [llvmfunc|
  llvm.func @pow_ab_a_reassoc_commute(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.fadd %arg0, %0  : f64
    %3 = llvm.fadd %arg1, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %4 = llvm.intr.pow(%2, %3)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.return %4 : f64
  }]

theorem inst_combine_pow_ab_a_reassoc_commute   : pow_ab_a_reassoc_commute_before  ⊑  pow_ab_a_reassoc_commute_combined := by
  unfold pow_ab_a_reassoc_commute_before pow_ab_a_reassoc_commute_combined
  simp_alive_peephole
  sorry
def pow_ab_a_reassoc_use_combined := [llvmfunc|
  llvm.func @pow_ab_a_reassoc_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_ab_a_reassoc_use   : pow_ab_a_reassoc_use_before  ⊑  pow_ab_a_reassoc_use_combined := by
  unfold pow_ab_a_reassoc_use_before pow_ab_a_reassoc_use_combined
  simp_alive_peephole
  sorry
def pow_ab_recip_a_combined := [llvmfunc|
  llvm.func @pow_ab_recip_a(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  : f64
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_ab_recip_a   : pow_ab_recip_a_before  ⊑  pow_ab_recip_a_combined := by
  unfold pow_ab_recip_a_before pow_ab_recip_a_combined
  simp_alive_peephole
  sorry
def pow_ab_recip_a_reassoc_combined := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_recip_a_reassoc   : pow_ab_recip_a_reassoc_before  ⊑  pow_ab_recip_a_reassoc_combined := by
  unfold pow_ab_recip_a_reassoc_before pow_ab_recip_a_reassoc_combined
  simp_alive_peephole
  sorry
def pow_ab_recip_a_reassoc_commute_combined := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc_commute(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.fadd %arg1, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_recip_a_reassoc_commute   : pow_ab_recip_a_reassoc_commute_before  ⊑  pow_ab_recip_a_reassoc_commute_combined := by
  unfold pow_ab_recip_a_reassoc_commute_before pow_ab_recip_a_reassoc_commute_combined
  simp_alive_peephole
  sorry
def pow_ab_recip_a_reassoc_use1_combined := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc_use1(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_ab_recip_a_reassoc_use1   : pow_ab_recip_a_reassoc_use1_before  ⊑  pow_ab_recip_a_reassoc_use1_combined := by
  unfold pow_ab_recip_a_reassoc_use1_before pow_ab_recip_a_reassoc_use1_combined
  simp_alive_peephole
  sorry
def pow_ab_recip_a_reassoc_use2_combined := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc_use2(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_ab_recip_a_reassoc_use2   : pow_ab_recip_a_reassoc_use2_before  ⊑  pow_ab_recip_a_reassoc_use2_combined := by
  unfold pow_ab_recip_a_reassoc_use2_before pow_ab_recip_a_reassoc_use2_combined
  simp_alive_peephole
  sorry
def pow_ab_recip_a_reassoc_use3_combined := [llvmfunc|
  llvm.func @pow_ab_recip_a_reassoc_use3(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fdiv %0, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    %3 = llvm.fmul %1, %2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%1) : (f64) -> ()
    llvm.call @use(%2) : (f64) -> ()
    llvm.return %3 : f64
  }]

theorem inst_combine_pow_ab_recip_a_reassoc_use3   : pow_ab_recip_a_reassoc_use3_before  ⊑  pow_ab_recip_a_reassoc_use3_combined := by
  unfold pow_ab_recip_a_reassoc_use3_before pow_ab_recip_a_reassoc_use3_combined
  simp_alive_peephole
  sorry
def pow_ab_pow_cb_combined := [llvmfunc|
  llvm.func @pow_ab_pow_cb(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_pow_cb   : pow_ab_pow_cb_before  ⊑  pow_ab_pow_cb_combined := by
  unfold pow_ab_pow_cb_before pow_ab_pow_cb_combined
  simp_alive_peephole
  sorry
def pow_ab_pow_cb_reassoc_combined := [llvmfunc|
  llvm.func @pow_ab_pow_cb_reassoc(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fmul %arg2, %arg0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %1 = llvm.intr.pow(%0, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_ab_pow_cb_reassoc   : pow_ab_pow_cb_reassoc_before  ⊑  pow_ab_pow_cb_reassoc_combined := by
  unfold pow_ab_pow_cb_reassoc_before pow_ab_pow_cb_reassoc_combined
  simp_alive_peephole
  sorry
def pow_ab_pow_cb_reassoc_use1_combined := [llvmfunc|
  llvm.func @pow_ab_pow_cb_reassoc_use1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%1, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_pow_cb_reassoc_use1   : pow_ab_pow_cb_reassoc_use1_before  ⊑  pow_ab_pow_cb_reassoc_use1_combined := by
  unfold pow_ab_pow_cb_reassoc_use1_before pow_ab_pow_cb_reassoc_use1_combined
  simp_alive_peephole
  sorry
def pow_ab_pow_cb_reassoc_use2_combined := [llvmfunc|
  llvm.func @pow_ab_pow_cb_reassoc_use2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %arg0, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%1, %arg1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_pow_cb_reassoc_use2   : pow_ab_pow_cb_reassoc_use2_before  ⊑  pow_ab_pow_cb_reassoc_use2_combined := by
  unfold pow_ab_pow_cb_reassoc_use2_before pow_ab_pow_cb_reassoc_use2_combined
  simp_alive_peephole
  sorry
def pow_ab_pow_cb_reassoc_use3_combined := [llvmfunc|
  llvm.func @pow_ab_pow_cb_reassoc_use3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg2, %arg1)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_pow_cb_reassoc_use3   : pow_ab_pow_cb_reassoc_use3_before  ⊑  pow_ab_pow_cb_reassoc_use3_combined := by
  unfold pow_ab_pow_cb_reassoc_use3_before pow_ab_pow_cb_reassoc_use3_combined
  simp_alive_peephole
  sorry
def pow_ab_pow_ac_combined := [llvmfunc|
  llvm.func @pow_ab_pow_ac(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %1, %0  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_pow_ac   : pow_ab_pow_ac_before  ⊑  pow_ab_pow_ac_combined := by
  unfold pow_ab_pow_ac_before pow_ab_pow_ac_combined
  simp_alive_peephole
  sorry
def pow_ab_x_pow_ac_reassoc_combined := [llvmfunc|
  llvm.func @pow_ab_x_pow_ac_reassoc(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fadd %arg2, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_ab_x_pow_ac_reassoc   : pow_ab_x_pow_ac_reassoc_before  ⊑  pow_ab_x_pow_ac_reassoc_combined := by
  unfold pow_ab_x_pow_ac_reassoc_before pow_ab_x_pow_ac_reassoc_combined
  simp_alive_peephole
  sorry
def pow_ab_reassoc_combined := [llvmfunc|
  llvm.func @pow_ab_reassoc(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fadd %arg1, %arg1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %1 = llvm.intr.pow(%arg0, %0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_ab_reassoc   : pow_ab_reassoc_before  ⊑  pow_ab_reassoc_combined := by
  unfold pow_ab_reassoc_before pow_ab_reassoc_combined
  simp_alive_peephole
  sorry
def pow_ab_reassoc_extra_use_combined := [llvmfunc|
  llvm.func @pow_ab_reassoc_extra_use(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fmul %0, %0  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %1 : f64
  }]

theorem inst_combine_pow_ab_reassoc_extra_use   : pow_ab_reassoc_extra_use_before  ⊑  pow_ab_reassoc_extra_use_combined := by
  unfold pow_ab_reassoc_extra_use_before pow_ab_reassoc_extra_use_combined
  simp_alive_peephole
  sorry
def pow_ab_x_pow_ac_reassoc_extra_use_combined := [llvmfunc|
  llvm.func @pow_ab_x_pow_ac_reassoc_extra_use(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %2 = llvm.intr.pow(%arg0, %1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64, f64) -> f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_x_pow_ac_reassoc_extra_use   : pow_ab_x_pow_ac_reassoc_extra_use_before  ⊑  pow_ab_x_pow_ac_reassoc_extra_use_combined := by
  unfold pow_ab_x_pow_ac_reassoc_extra_use_before pow_ab_x_pow_ac_reassoc_extra_use_combined
  simp_alive_peephole
  sorry
def pow_ab_x_pow_ac_reassoc_multiple_uses_combined := [llvmfunc|
  llvm.func @pow_ab_x_pow_ac_reassoc_multiple_uses(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.intr.pow(%arg0, %arg1)  : (f64, f64) -> f64
    %1 = llvm.intr.pow(%arg0, %arg2)  : (f64, f64) -> f64
    %2 = llvm.fmul %0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.call @use(%0) : (f64) -> ()
    llvm.call @use(%1) : (f64) -> ()
    llvm.return %2 : f64
  }]

theorem inst_combine_pow_ab_x_pow_ac_reassoc_multiple_uses   : pow_ab_x_pow_ac_reassoc_multiple_uses_before  ⊑  pow_ab_x_pow_ac_reassoc_multiple_uses_combined := by
  unfold pow_ab_x_pow_ac_reassoc_multiple_uses_before pow_ab_x_pow_ac_reassoc_multiple_uses_combined
  simp_alive_peephole
  sorry
