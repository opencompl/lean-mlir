import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fdiv-sqrt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sqrt_div_fast_before := [llvmfunc|
  llvm.func @sqrt_div_fast(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_div_before := [llvmfunc|
  llvm.func @sqrt_div(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  : f64
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  : f64
    llvm.return %2 : f64
  }]

def sqrt_div_reassoc_arcp_before := [llvmfunc|
  llvm.func @sqrt_div_reassoc_arcp(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_div_reassoc_missing_before := [llvmfunc|
  llvm.func @sqrt_div_reassoc_missing(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_div_reassoc_missing2_before := [llvmfunc|
  llvm.func @sqrt_div_reassoc_missing2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp>} : (f64) -> f64]

    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_div_reassoc_missing3_before := [llvmfunc|
  llvm.func @sqrt_div_reassoc_missing3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_div_arcp_missing_before := [llvmfunc|
  llvm.func @sqrt_div_arcp_missing(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_div_arcp_missing2_before := [llvmfunc|
  llvm.func @sqrt_div_arcp_missing2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_div_arcp_missing3_before := [llvmfunc|
  llvm.func @sqrt_div_arcp_missing3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64]

    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_div_fast_multiple_uses_1_before := [llvmfunc|
  llvm.func @sqrt_div_fast_multiple_uses_1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_div_fast_multiple_uses_2_before := [llvmfunc|
  llvm.func @sqrt_div_fast_multiple_uses_2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    llvm.return %2 : f64
  }]

def sqrt_non_div_operator_before := [llvmfunc|
  llvm.func @sqrt_non_div_operator(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64]

    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

def sqrt_div_fast_combined := [llvmfunc|
  llvm.func @sqrt_div_fast(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_fast   : sqrt_div_fast_before  ⊑  sqrt_div_fast_combined := by
  unfold sqrt_div_fast_before sqrt_div_fast_combined
  simp_alive_peephole
  sorry
def sqrt_div_combined := [llvmfunc|
  llvm.func @sqrt_div(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  : f64
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div   : sqrt_div_before  ⊑  sqrt_div_combined := by
  unfold sqrt_div_before sqrt_div_combined
  simp_alive_peephole
  sorry
def sqrt_div_reassoc_arcp_combined := [llvmfunc|
  llvm.func @sqrt_div_reassoc_arcp(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_reassoc_arcp   : sqrt_div_reassoc_arcp_before  ⊑  sqrt_div_reassoc_arcp_combined := by
  unfold sqrt_div_reassoc_arcp_before sqrt_div_reassoc_arcp_combined
  simp_alive_peephole
  sorry
def sqrt_div_reassoc_missing_combined := [llvmfunc|
  llvm.func @sqrt_div_reassoc_missing(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_reassoc_missing   : sqrt_div_reassoc_missing_before  ⊑  sqrt_div_reassoc_missing_combined := by
  unfold sqrt_div_reassoc_missing_before sqrt_div_reassoc_missing_combined
  simp_alive_peephole
  sorry
def sqrt_div_reassoc_missing2_combined := [llvmfunc|
  llvm.func @sqrt_div_reassoc_missing2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_reassoc_missing2   : sqrt_div_reassoc_missing2_before  ⊑  sqrt_div_reassoc_missing2_combined := by
  unfold sqrt_div_reassoc_missing2_before sqrt_div_reassoc_missing2_combined
  simp_alive_peephole
  sorry
def sqrt_div_reassoc_missing3_combined := [llvmfunc|
  llvm.func @sqrt_div_reassoc_missing3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_reassoc_missing3   : sqrt_div_reassoc_missing3_before  ⊑  sqrt_div_reassoc_missing3_combined := by
  unfold sqrt_div_reassoc_missing3_before sqrt_div_reassoc_missing3_combined
  simp_alive_peephole
  sorry
def sqrt_div_arcp_missing_combined := [llvmfunc|
  llvm.func @sqrt_div_arcp_missing(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_arcp_missing   : sqrt_div_arcp_missing_before  ⊑  sqrt_div_arcp_missing_combined := by
  unfold sqrt_div_arcp_missing_before sqrt_div_arcp_missing_combined
  simp_alive_peephole
  sorry
def sqrt_div_arcp_missing2_combined := [llvmfunc|
  llvm.func @sqrt_div_arcp_missing2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_arcp_missing2   : sqrt_div_arcp_missing2_before  ⊑  sqrt_div_arcp_missing2_combined := by
  unfold sqrt_div_arcp_missing2_before sqrt_div_arcp_missing2_combined
  simp_alive_peephole
  sorry
def sqrt_div_arcp_missing3_combined := [llvmfunc|
  llvm.func @sqrt_div_arcp_missing3(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<arcp, reassoc>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<reassoc>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_arcp_missing3   : sqrt_div_arcp_missing3_before  ⊑  sqrt_div_arcp_missing3_combined := by
  unfold sqrt_div_arcp_missing3_before sqrt_div_arcp_missing3_combined
  simp_alive_peephole
  sorry
def sqrt_div_fast_multiple_uses_1_combined := [llvmfunc|
  llvm.func @sqrt_div_fast_multiple_uses_1(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.call @use(%0) : (f64) -> ()
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_fast_multiple_uses_1   : sqrt_div_fast_multiple_uses_1_before  ⊑  sqrt_div_fast_multiple_uses_1_combined := by
  unfold sqrt_div_fast_multiple_uses_1_before sqrt_div_fast_multiple_uses_1_combined
  simp_alive_peephole
  sorry
def sqrt_div_fast_multiple_uses_2_combined := [llvmfunc|
  llvm.func @sqrt_div_fast_multiple_uses_2(%arg0: f64, %arg1: f64, %arg2: f64) -> f64 {
    %0 = llvm.fdiv %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.call @use(%1) : (f64) -> ()
    %2 = llvm.fdiv %arg0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    llvm.return %2 : f64
  }]

theorem inst_combine_sqrt_div_fast_multiple_uses_2   : sqrt_div_fast_multiple_uses_2_before  ⊑  sqrt_div_fast_multiple_uses_2_combined := by
  unfold sqrt_div_fast_multiple_uses_2_before sqrt_div_fast_multiple_uses_2_combined
  simp_alive_peephole
  sorry
def sqrt_non_div_operator_combined := [llvmfunc|
  llvm.func @sqrt_non_div_operator(%arg0: f32) -> f32 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %2 = llvm.fdiv %0, %1  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }]

theorem inst_combine_sqrt_non_div_operator   : sqrt_non_div_operator_before  ⊑  sqrt_non_div_operator_combined := by
  unfold sqrt_non_div_operator_before sqrt_non_div_operator_combined
  simp_alive_peephole
  sorry
