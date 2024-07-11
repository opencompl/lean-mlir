import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unordered-fcmp-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def select_max_ugt_before := [llvmfunc|
  llvm.func @select_max_ugt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : f32]

    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_max_uge_before := [llvmfunc|
  llvm.func @select_max_uge(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_min_ugt_before := [llvmfunc|
  llvm.func @select_min_ugt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<reassoc>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_min_uge_before := [llvmfunc|
  llvm.func @select_min_uge(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_max_ult_before := [llvmfunc|
  llvm.func @select_max_ult(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : f32]

    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nnan, ninf>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_max_ule_before := [llvmfunc|
  llvm.func @select_max_ule(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f32]

    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_min_ult_before := [llvmfunc|
  llvm.func @select_min_ult(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_min_ule_before := [llvmfunc|
  llvm.func @select_min_ule(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : f32]

    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_fcmp_une_before := [llvmfunc|
  llvm.func @select_fcmp_une(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_fcmp_ueq_before := [llvmfunc|
  llvm.func @select_fcmp_ueq(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, arcp>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_max_ugt_2_use_cmp_before := [llvmfunc|
  llvm.func @select_max_ugt_2_use_cmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

    llvm.call @foo(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_min_uge_2_use_cmp_before := [llvmfunc|
  llvm.func @select_min_uge_2_use_cmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

    llvm.call @foo(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32]

    llvm.return %1 : f32
  }]

def select_max_ugt_combined := [llvmfunc|
  llvm.func @select_max_ugt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : f32]

theorem inst_combine_select_max_ugt   : select_max_ugt_before  ⊑  select_max_ugt_combined := by
  unfold select_max_ugt_before select_max_ugt_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<arcp>} : i1, f32]

theorem inst_combine_select_max_ugt   : select_max_ugt_before  ⊑  select_max_ugt_combined := by
  unfold select_max_ugt_before select_max_ugt_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_max_ugt   : select_max_ugt_before  ⊑  select_max_ugt_combined := by
  unfold select_max_ugt_before select_max_ugt_combined
  simp_alive_peephole
  sorry
def select_max_uge_combined := [llvmfunc|
  llvm.func @select_max_uge(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f32]

theorem inst_combine_select_max_uge   : select_max_uge_before  ⊑  select_max_uge_combined := by
  unfold select_max_uge_before select_max_uge_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32]

theorem inst_combine_select_max_uge   : select_max_uge_before  ⊑  select_max_uge_combined := by
  unfold select_max_uge_before select_max_uge_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_max_uge   : select_max_uge_before  ⊑  select_max_uge_combined := by
  unfold select_max_uge_before select_max_uge_combined
  simp_alive_peephole
  sorry
def select_min_ugt_combined := [llvmfunc|
  llvm.func @select_min_ugt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.minnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_select_min_ugt   : select_min_ugt_before  ⊑  select_min_ugt_combined := by
  unfold select_min_ugt_before select_min_ugt_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_select_min_ugt   : select_min_ugt_before  ⊑  select_min_ugt_combined := by
  unfold select_min_ugt_before select_min_ugt_combined
  simp_alive_peephole
  sorry
def select_min_uge_combined := [llvmfunc|
  llvm.func @select_min_uge(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

theorem inst_combine_select_min_uge   : select_min_uge_before  ⊑  select_min_uge_combined := by
  unfold select_min_uge_before select_min_uge_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32]

theorem inst_combine_select_min_uge   : select_min_uge_before  ⊑  select_min_uge_combined := by
  unfold select_min_uge_before select_min_uge_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_min_uge   : select_min_uge_before  ⊑  select_min_uge_combined := by
  unfold select_min_uge_before select_min_uge_combined
  simp_alive_peephole
  sorry
def select_max_ult_combined := [llvmfunc|
  llvm.func @select_max_ult(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : f32]

theorem inst_combine_select_max_ult   : select_max_ult_before  ⊑  select_max_ult_combined := by
  unfold select_max_ult_before select_max_ult_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : i1, f32]

theorem inst_combine_select_max_ult   : select_max_ult_before  ⊑  select_max_ult_combined := by
  unfold select_max_ult_before select_max_ult_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_max_ult   : select_max_ult_before  ⊑  select_max_ult_combined := by
  unfold select_max_ult_before select_max_ult_combined
  simp_alive_peephole
  sorry
def select_max_ule_combined := [llvmfunc|
  llvm.func @select_max_ule(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.intr.maxnum(%arg0, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f32, f32) -> f32]

theorem inst_combine_select_max_ule   : select_max_ule_before  ⊑  select_max_ule_combined := by
  unfold select_max_ule_before select_max_ule_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_select_max_ule   : select_max_ule_before  ⊑  select_max_ule_combined := by
  unfold select_max_ule_before select_max_ule_combined
  simp_alive_peephole
  sorry
def select_min_ult_combined := [llvmfunc|
  llvm.func @select_min_ult(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : f32]

theorem inst_combine_select_min_ult   : select_min_ult_before  ⊑  select_min_ult_combined := by
  unfold select_min_ult_before select_min_ult_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32]

theorem inst_combine_select_min_ult   : select_min_ult_before  ⊑  select_min_ult_combined := by
  unfold select_min_ult_before select_min_ult_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_min_ult   : select_min_ult_before  ⊑  select_min_ult_combined := by
  unfold select_min_ult_before select_min_ult_combined
  simp_alive_peephole
  sorry
def select_min_ule_combined := [llvmfunc|
  llvm.func @select_min_ule(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<arcp>} : f32]

theorem inst_combine_select_min_ule   : select_min_ule_before  ⊑  select_min_ule_combined := by
  unfold select_min_ule_before select_min_ule_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<arcp>} : i1, f32]

theorem inst_combine_select_min_ule   : select_min_ule_before  ⊑  select_min_ule_combined := by
  unfold select_min_ule_before select_min_ule_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_min_ule   : select_min_ule_before  ⊑  select_min_ule_combined := by
  unfold select_min_ule_before select_min_ule_combined
  simp_alive_peephole
  sorry
def select_fcmp_une_combined := [llvmfunc|
  llvm.func @select_fcmp_une(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_select_fcmp_une   : select_fcmp_une_before  ⊑  select_fcmp_une_combined := by
  unfold select_fcmp_une_before select_fcmp_une_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<reassoc>} : i1, f32]

theorem inst_combine_select_fcmp_une   : select_fcmp_une_before  ⊑  select_fcmp_une_combined := by
  unfold select_fcmp_une_before select_fcmp_une_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_fcmp_une   : select_fcmp_une_before  ⊑  select_fcmp_une_combined := by
  unfold select_fcmp_une_before select_fcmp_une_combined
  simp_alive_peephole
  sorry
def select_fcmp_ueq_combined := [llvmfunc|
  llvm.func @select_fcmp_ueq(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_select_fcmp_ueq   : select_fcmp_ueq_before  ⊑  select_fcmp_ueq_combined := by
  unfold select_fcmp_ueq_before select_fcmp_ueq_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<reassoc>} : i1, f32]

theorem inst_combine_select_fcmp_ueq   : select_fcmp_ueq_before  ⊑  select_fcmp_ueq_combined := by
  unfold select_fcmp_ueq_before select_fcmp_ueq_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_fcmp_ueq   : select_fcmp_ueq_before  ⊑  select_fcmp_ueq_combined := by
  unfold select_fcmp_ueq_before select_fcmp_ueq_combined
  simp_alive_peephole
  sorry
def select_max_ugt_2_use_cmp_combined := [llvmfunc|
  llvm.func @select_max_ugt_2_use_cmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<reassoc>} : f32]

theorem inst_combine_select_max_ugt_2_use_cmp   : select_max_ugt_2_use_cmp_before  ⊑  select_max_ugt_2_use_cmp_combined := by
  unfold select_max_ugt_2_use_cmp_before select_max_ugt_2_use_cmp_combined
  simp_alive_peephole
  sorry
    llvm.call @foo(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : i1, f32]

theorem inst_combine_select_max_ugt_2_use_cmp   : select_max_ugt_2_use_cmp_before  ⊑  select_max_ugt_2_use_cmp_combined := by
  unfold select_max_ugt_2_use_cmp_before select_max_ugt_2_use_cmp_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_max_ugt_2_use_cmp   : select_max_ugt_2_use_cmp_before  ⊑  select_max_ugt_2_use_cmp_combined := by
  unfold select_max_ugt_2_use_cmp_before select_max_ugt_2_use_cmp_combined
  simp_alive_peephole
  sorry
def select_min_uge_2_use_cmp_combined := [llvmfunc|
  llvm.func @select_min_uge_2_use_cmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : f32]

theorem inst_combine_select_min_uge_2_use_cmp   : select_min_uge_2_use_cmp_before  ⊑  select_min_uge_2_use_cmp_combined := by
  unfold select_min_uge_2_use_cmp_before select_min_uge_2_use_cmp_combined
  simp_alive_peephole
  sorry
    llvm.call @foo(%0) : (i1) -> ()
    %1 = llvm.select %0, %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32]

theorem inst_combine_select_min_uge_2_use_cmp   : select_min_uge_2_use_cmp_before  ⊑  select_min_uge_2_use_cmp_combined := by
  unfold select_min_uge_2_use_cmp_before select_min_uge_2_use_cmp_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : f32
  }]

theorem inst_combine_select_min_uge_2_use_cmp   : select_min_uge_2_use_cmp_before  ⊑  select_min_uge_2_use_cmp_combined := by
  unfold select_min_uge_2_use_cmp_before select_min_uge_2_use_cmp_combined
  simp_alive_peephole
  sorry
