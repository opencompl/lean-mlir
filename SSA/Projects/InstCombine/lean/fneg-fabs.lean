import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fneg-fabs
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def select_noFMF_nfabs_lt_before := [llvmfunc|
  llvm.func @select_noFMF_nfabs_lt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

def select_nsz_nfabs_lt_fmfProp_before := [llvmfunc|
  llvm.func @select_nsz_nfabs_lt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_nfabs_lt_fmfProp_before := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_lt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nfabs_ult_before := [llvmfunc|
  llvm.func @select_nsz_nfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_nfabs_ult_before := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nfabs_ole_before := [llvmfunc|
  llvm.func @select_nsz_nfabs_ole(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_nfabs_ole_before := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ole(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nfabs_ule_before := [llvmfunc|
  llvm.func @select_nsz_nfabs_ule(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ule" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_nfabs_ule_before := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ule(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ule" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_noFMF_nfabs_gt_before := [llvmfunc|
  llvm.func @select_noFMF_nfabs_gt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

def select_nsz_nfabs_gt_fmfProp_before := [llvmfunc|
  llvm.func @select_nsz_nfabs_gt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_nfabs_gt_fmfProp_before := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_gt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64]

    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nfabs_ogt_before := [llvmfunc|
  llvm.func @select_nsz_nfabs_ogt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_nfabs_ogt_before := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ogt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nfabs_ugt_before := [llvmfunc|
  llvm.func @select_nsz_nfabs_ugt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ugt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_nfabs_ugt_before := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ugt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ugt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nfabs_oge_before := [llvmfunc|
  llvm.func @select_nsz_nfabs_oge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_nfabs_oge_before := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_oge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nfabs_uge_before := [llvmfunc|
  llvm.func @select_nsz_nfabs_uge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_nsz_nnan_nfabs_uge_before := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_uge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f64]

    llvm.return %3 : f64
  }]

def select_noFMF_fsubfabs_le_before := [llvmfunc|
  llvm.func @select_noFMF_fsubfabs_le(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

def select_noFMF_fsubfabs_olt_before := [llvmfunc|
  llvm.func @select_noFMF_fsubfabs_olt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

def select_noFMF_fsubfabs_ult_before := [llvmfunc|
  llvm.func @select_noFMF_fsubfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

def select_nsz_fnegfabs_olt_before := [llvmfunc|
  llvm.func @select_nsz_fnegfabs_olt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f64]

    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

def select_nsz_fnegfabs_ult_before := [llvmfunc|
  llvm.func @select_nsz_fnegfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f64]

    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

def select_noFMF_nfabs_lt_combined := [llvmfunc|
  llvm.func @select_noFMF_nfabs_lt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_noFMF_nfabs_lt   : select_noFMF_nfabs_lt_before  ⊑  select_noFMF_nfabs_lt_combined := by
  unfold select_noFMF_nfabs_lt_before select_noFMF_nfabs_lt_combined
  simp_alive_peephole
  sorry
def select_nsz_nfabs_lt_fmfProp_combined := [llvmfunc|
  llvm.func @select_nsz_nfabs_lt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nfabs_lt_fmfProp   : select_nsz_nfabs_lt_fmfProp_before  ⊑  select_nsz_nfabs_lt_fmfProp_combined := by
  unfold select_nsz_nfabs_lt_fmfProp_before select_nsz_nfabs_lt_fmfProp_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_nfabs_lt_fmfProp_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_lt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nnan_nfabs_lt_fmfProp   : select_nsz_nnan_nfabs_lt_fmfProp_before  ⊑  select_nsz_nnan_nfabs_lt_fmfProp_combined := by
  unfold select_nsz_nnan_nfabs_lt_fmfProp_before select_nsz_nnan_nfabs_lt_fmfProp_combined
  simp_alive_peephole
  sorry
def select_nsz_nfabs_ult_combined := [llvmfunc|
  llvm.func @select_nsz_nfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_nfabs_ult   : select_nsz_nfabs_ult_before  ⊑  select_nsz_nfabs_ult_combined := by
  unfold select_nsz_nfabs_ult_before select_nsz_nfabs_ult_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_nfabs_ult_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nnan_nfabs_ult   : select_nsz_nnan_nfabs_ult_before  ⊑  select_nsz_nnan_nfabs_ult_combined := by
  unfold select_nsz_nnan_nfabs_ult_before select_nsz_nnan_nfabs_ult_combined
  simp_alive_peephole
  sorry
def select_nsz_nfabs_ole_combined := [llvmfunc|
  llvm.func @select_nsz_nfabs_ole(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_nfabs_ole   : select_nsz_nfabs_ole_before  ⊑  select_nsz_nfabs_ole_combined := by
  unfold select_nsz_nfabs_ole_before select_nsz_nfabs_ole_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_nfabs_ole_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ole(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nnan_nfabs_ole   : select_nsz_nnan_nfabs_ole_before  ⊑  select_nsz_nnan_nfabs_ole_combined := by
  unfold select_nsz_nnan_nfabs_ole_before select_nsz_nnan_nfabs_ole_combined
  simp_alive_peephole
  sorry
def select_nsz_nfabs_ule_combined := [llvmfunc|
  llvm.func @select_nsz_nfabs_ule(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ule" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_nfabs_ule   : select_nsz_nfabs_ule_before  ⊑  select_nsz_nfabs_ule_combined := by
  unfold select_nsz_nfabs_ule_before select_nsz_nfabs_ule_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_nfabs_ule_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ule(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nnan_nfabs_ule   : select_nsz_nnan_nfabs_ule_before  ⊑  select_nsz_nnan_nfabs_ule_combined := by
  unfold select_nsz_nnan_nfabs_ule_before select_nsz_nnan_nfabs_ule_combined
  simp_alive_peephole
  sorry
def select_noFMF_nfabs_gt_combined := [llvmfunc|
  llvm.func @select_noFMF_nfabs_gt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_noFMF_nfabs_gt   : select_noFMF_nfabs_gt_before  ⊑  select_noFMF_nfabs_gt_combined := by
  unfold select_noFMF_nfabs_gt_before select_noFMF_nfabs_gt_combined
  simp_alive_peephole
  sorry
def select_nsz_nfabs_gt_fmfProp_combined := [llvmfunc|
  llvm.func @select_nsz_nfabs_gt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nfabs_gt_fmfProp   : select_nsz_nfabs_gt_fmfProp_before  ⊑  select_nsz_nfabs_gt_fmfProp_combined := by
  unfold select_nsz_nfabs_gt_fmfProp_before select_nsz_nfabs_gt_fmfProp_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_nfabs_gt_fmfProp_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_gt_fmfProp(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nnan_nfabs_gt_fmfProp   : select_nsz_nnan_nfabs_gt_fmfProp_before  ⊑  select_nsz_nnan_nfabs_gt_fmfProp_combined := by
  unfold select_nsz_nnan_nfabs_gt_fmfProp_before select_nsz_nnan_nfabs_gt_fmfProp_combined
  simp_alive_peephole
  sorry
def select_nsz_nfabs_ogt_combined := [llvmfunc|
  llvm.func @select_nsz_nfabs_ogt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ogt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_nfabs_ogt   : select_nsz_nfabs_ogt_before  ⊑  select_nsz_nfabs_ogt_combined := by
  unfold select_nsz_nfabs_ogt_before select_nsz_nfabs_ogt_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_nfabs_ogt_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ogt(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nnan_nfabs_ogt   : select_nsz_nnan_nfabs_ogt_before  ⊑  select_nsz_nnan_nfabs_ogt_combined := by
  unfold select_nsz_nnan_nfabs_ogt_before select_nsz_nnan_nfabs_ogt_combined
  simp_alive_peephole
  sorry
def select_nsz_nfabs_ugt_combined := [llvmfunc|
  llvm.func @select_nsz_nfabs_ugt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ugt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_nfabs_ugt   : select_nsz_nfabs_ugt_before  ⊑  select_nsz_nfabs_ugt_combined := by
  unfold select_nsz_nfabs_ugt_before select_nsz_nfabs_ugt_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_nfabs_ugt_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_ugt(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nnan_nfabs_ugt   : select_nsz_nnan_nfabs_ugt_before  ⊑  select_nsz_nnan_nfabs_ugt_combined := by
  unfold select_nsz_nnan_nfabs_ugt_before select_nsz_nnan_nfabs_ugt_combined
  simp_alive_peephole
  sorry
def select_nsz_nfabs_oge_combined := [llvmfunc|
  llvm.func @select_nsz_nfabs_oge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "oge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_nfabs_oge   : select_nsz_nfabs_oge_before  ⊑  select_nsz_nfabs_oge_combined := by
  unfold select_nsz_nfabs_oge_before select_nsz_nfabs_oge_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_nfabs_oge_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_oge(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nnan_nfabs_oge   : select_nsz_nnan_nfabs_oge_before  ⊑  select_nsz_nnan_nfabs_oge_combined := by
  unfold select_nsz_nnan_nfabs_oge_before select_nsz_nnan_nfabs_oge_combined
  simp_alive_peephole
  sorry
def select_nsz_nfabs_uge_combined := [llvmfunc|
  llvm.func @select_nsz_nfabs_uge(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "uge" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  : f64
    %3 = llvm.select %1, %2, %arg0 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_nfabs_uge   : select_nsz_nfabs_uge_before  ⊑  select_nsz_nfabs_uge_combined := by
  unfold select_nsz_nfabs_uge_before select_nsz_nfabs_uge_combined
  simp_alive_peephole
  sorry
def select_nsz_nnan_nfabs_uge_combined := [llvmfunc|
  llvm.func @select_nsz_nnan_nfabs_uge(%arg0: f64) -> f64 {
    %0 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f64) -> f64
    %1 = llvm.fneg %0  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    llvm.return %1 : f64
  }]

theorem inst_combine_select_nsz_nnan_nfabs_uge   : select_nsz_nnan_nfabs_uge_before  ⊑  select_nsz_nnan_nfabs_uge_combined := by
  unfold select_nsz_nnan_nfabs_uge_before select_nsz_nnan_nfabs_uge_combined
  simp_alive_peephole
  sorry
def select_noFMF_fsubfabs_le_combined := [llvmfunc|
  llvm.func @select_noFMF_fsubfabs_le(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ole" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_noFMF_fsubfabs_le   : select_noFMF_fsubfabs_le_before  ⊑  select_noFMF_fsubfabs_le_combined := by
  unfold select_noFMF_fsubfabs_le_before select_noFMF_fsubfabs_le_combined
  simp_alive_peephole
  sorry
def select_noFMF_fsubfabs_olt_combined := [llvmfunc|
  llvm.func @select_noFMF_fsubfabs_olt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_noFMF_fsubfabs_olt   : select_noFMF_fsubfabs_olt_before  ⊑  select_noFMF_fsubfabs_olt_combined := by
  unfold select_noFMF_fsubfabs_olt_before select_noFMF_fsubfabs_olt_combined
  simp_alive_peephole
  sorry
def select_noFMF_fsubfabs_ult_combined := [llvmfunc|
  llvm.func @select_noFMF_fsubfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fsub %0, %arg0  : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_noFMF_fsubfabs_ult   : select_noFMF_fsubfabs_ult_before  ⊑  select_noFMF_fsubfabs_ult_combined := by
  unfold select_noFMF_fsubfabs_ult_before select_noFMF_fsubfabs_ult_combined
  simp_alive_peephole
  sorry
def select_nsz_fnegfabs_olt_combined := [llvmfunc|
  llvm.func @select_nsz_fnegfabs_olt(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "olt" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_fnegfabs_olt   : select_nsz_fnegfabs_olt_before  ⊑  select_nsz_fnegfabs_olt_combined := by
  unfold select_nsz_fnegfabs_olt_before select_nsz_fnegfabs_olt_combined
  simp_alive_peephole
  sorry
def select_nsz_fnegfabs_ult_combined := [llvmfunc|
  llvm.func @select_nsz_fnegfabs_ult(%arg0: f64) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ult" %arg0, %0 : f64
    %2 = llvm.fneg %arg0  {fastmathFlags = #llvm.fastmath<nsz>} : f64
    %3 = llvm.select %1, %arg0, %2 : i1, f64
    llvm.return %3 : f64
  }]

theorem inst_combine_select_nsz_fnegfabs_ult   : select_nsz_fnegfabs_ult_before  ⊑  select_nsz_fnegfabs_ult_combined := by
  unfold select_nsz_fnegfabs_ult_before select_nsz_fnegfabs_ult_combined
  simp_alive_peephole
  sorry
