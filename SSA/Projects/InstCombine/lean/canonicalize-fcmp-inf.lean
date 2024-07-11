import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-fcmp-inf
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def olt_pinf_before := [llvmfunc|
  llvm.func @olt_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ole_pinf_before := [llvmfunc|
  llvm.func @ole_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ole" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ogt_pinf_before := [llvmfunc|
  llvm.func @ogt_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ogt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def oge_pinf_before := [llvmfunc|
  llvm.func @oge_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ult_pinf_before := [llvmfunc|
  llvm.func @ult_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ult" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ule_pinf_before := [llvmfunc|
  llvm.func @ule_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ule" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ugt_pinf_before := [llvmfunc|
  llvm.func @ugt_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ugt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def uge_pinf_before := [llvmfunc|
  llvm.func @uge_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def olt_ninf_before := [llvmfunc|
  llvm.func @olt_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ole_ninf_before := [llvmfunc|
  llvm.func @ole_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ole" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ogt_ninf_before := [llvmfunc|
  llvm.func @ogt_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ogt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def oge_ninf_before := [llvmfunc|
  llvm.func @oge_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ult_ninf_before := [llvmfunc|
  llvm.func @ult_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ult" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ule_ninf_before := [llvmfunc|
  llvm.func @ule_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ule" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ugt_ninf_before := [llvmfunc|
  llvm.func @ugt_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ugt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def uge_ninf_before := [llvmfunc|
  llvm.func @uge_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def olt_pinf_fmf_before := [llvmfunc|
  llvm.func @olt_pinf_fmf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16]

    llvm.return %1 : i1
  }]

def oge_pinf_fmf_before := [llvmfunc|
  llvm.func @oge_pinf_fmf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f16]

    llvm.return %1 : i1
  }]

def olt_pinf_vec_before := [llvmfunc|
  llvm.func @olt_pinf_vec(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7C00> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fcmp "olt" %arg0, %0 : vector<2xf16>
    llvm.return %1 : vector<2xi1>
  }]

def oge_ninf_vec_before := [llvmfunc|
  llvm.func @oge_ninf_vec(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0xFC00> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fcmp "oge" %arg0, %0 : vector<2xf16>
    llvm.return %1 : vector<2xi1>
  }]

def ord_pinf_before := [llvmfunc|
  llvm.func @ord_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def uno_pinf_before := [llvmfunc|
  llvm.func @uno_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "uno" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def true_pinf_before := [llvmfunc|
  llvm.func @true_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "_true" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def false_pinf_before := [llvmfunc|
  llvm.func @false_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "_false" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def ord_ninf_before := [llvmfunc|
  llvm.func @ord_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def uno_ninf_before := [llvmfunc|
  llvm.func @uno_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "uno" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def true_ninf_before := [llvmfunc|
  llvm.func @true_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "_true" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def false_ninf_before := [llvmfunc|
  llvm.func @false_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "_false" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def olt_one_before := [llvmfunc|
  llvm.func @olt_one(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

def olt_pinf_combined := [llvmfunc|
  llvm.func @olt_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_olt_pinf   : olt_pinf_before  ⊑  olt_pinf_combined := by
  unfold olt_pinf_before olt_pinf_combined
  simp_alive_peephole
  sorry
def ole_pinf_combined := [llvmfunc|
  llvm.func @ole_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ole" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ole_pinf   : ole_pinf_before  ⊑  ole_pinf_combined := by
  unfold ole_pinf_before ole_pinf_combined
  simp_alive_peephole
  sorry
def ogt_pinf_combined := [llvmfunc|
  llvm.func @ogt_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ogt_pinf   : ogt_pinf_before  ⊑  ogt_pinf_combined := by
  unfold ogt_pinf_before ogt_pinf_combined
  simp_alive_peephole
  sorry
def oge_pinf_combined := [llvmfunc|
  llvm.func @oge_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_oge_pinf   : oge_pinf_before  ⊑  oge_pinf_combined := by
  unfold oge_pinf_before oge_pinf_combined
  simp_alive_peephole
  sorry
def ult_pinf_combined := [llvmfunc|
  llvm.func @ult_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ult" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_pinf   : ult_pinf_before  ⊑  ult_pinf_combined := by
  unfold ult_pinf_before ult_pinf_combined
  simp_alive_peephole
  sorry
def ule_pinf_combined := [llvmfunc|
  llvm.func @ule_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_pinf   : ule_pinf_before  ⊑  ule_pinf_combined := by
  unfold ule_pinf_before ule_pinf_combined
  simp_alive_peephole
  sorry
def ugt_pinf_combined := [llvmfunc|
  llvm.func @ugt_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "ugt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_pinf   : ugt_pinf_before  ⊑  ugt_pinf_combined := by
  unfold ugt_pinf_before ugt_pinf_combined
  simp_alive_peephole
  sorry
def uge_pinf_combined := [llvmfunc|
  llvm.func @uge_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "uge" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_pinf   : uge_pinf_before  ⊑  uge_pinf_combined := by
  unfold uge_pinf_before uge_pinf_combined
  simp_alive_peephole
  sorry
def olt_ninf_combined := [llvmfunc|
  llvm.func @olt_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_olt_ninf   : olt_ninf_before  ⊑  olt_ninf_combined := by
  unfold olt_ninf_before olt_ninf_combined
  simp_alive_peephole
  sorry
def ole_ninf_combined := [llvmfunc|
  llvm.func @ole_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ole" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ole_ninf   : ole_ninf_before  ⊑  ole_ninf_combined := by
  unfold ole_ninf_before ole_ninf_combined
  simp_alive_peephole
  sorry
def ogt_ninf_combined := [llvmfunc|
  llvm.func @ogt_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ogt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ogt_ninf   : ogt_ninf_before  ⊑  ogt_ninf_combined := by
  unfold ogt_ninf_before ogt_ninf_combined
  simp_alive_peephole
  sorry
def oge_ninf_combined := [llvmfunc|
  llvm.func @oge_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_oge_ninf   : oge_ninf_before  ⊑  oge_ninf_combined := by
  unfold oge_ninf_before oge_ninf_combined
  simp_alive_peephole
  sorry
def ult_ninf_combined := [llvmfunc|
  llvm.func @ult_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ult" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_ninf   : ult_ninf_before  ⊑  ult_ninf_combined := by
  unfold ult_ninf_before ult_ninf_combined
  simp_alive_peephole
  sorry
def ule_ninf_combined := [llvmfunc|
  llvm.func @ule_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ule" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_ninf   : ule_ninf_before  ⊑  ule_ninf_combined := by
  unfold ule_ninf_before ule_ninf_combined
  simp_alive_peephole
  sorry
def ugt_ninf_combined := [llvmfunc|
  llvm.func @ugt_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0xFC00 : f16) : f16
    %1 = llvm.fcmp "ugt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_ninf   : ugt_ninf_before  ⊑  ugt_ninf_combined := by
  unfold ugt_ninf_before ugt_ninf_combined
  simp_alive_peephole
  sorry
def uge_ninf_combined := [llvmfunc|
  llvm.func @uge_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_ninf   : uge_ninf_before  ⊑  uge_ninf_combined := by
  unfold uge_ninf_before uge_ninf_combined
  simp_alive_peephole
  sorry
def olt_pinf_fmf_combined := [llvmfunc|
  llvm.func @olt_pinf_fmf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_olt_pinf_fmf   : olt_pinf_fmf_before  ⊑  olt_pinf_fmf_combined := by
  unfold olt_pinf_fmf_before olt_pinf_fmf_combined
  simp_alive_peephole
  sorry
def oge_pinf_fmf_combined := [llvmfunc|
  llvm.func @oge_pinf_fmf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0x7C00 : f16) : f16
    %1 = llvm.fcmp "oge" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_oge_pinf_fmf   : oge_pinf_fmf_before  ⊑  oge_pinf_fmf_combined := by
  unfold oge_pinf_fmf_before oge_pinf_fmf_combined
  simp_alive_peephole
  sorry
def olt_pinf_vec_combined := [llvmfunc|
  llvm.func @olt_pinf_vec(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7C00> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fcmp "olt" %arg0, %0 : vector<2xf16>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_olt_pinf_vec   : olt_pinf_vec_before  ⊑  olt_pinf_vec_combined := by
  unfold olt_pinf_vec_before olt_pinf_vec_combined
  simp_alive_peephole
  sorry
def oge_ninf_vec_combined := [llvmfunc|
  llvm.func @oge_ninf_vec(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0xFC00> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fcmp "oge" %arg0, %0 : vector<2xf16>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_oge_ninf_vec   : oge_ninf_vec_before  ⊑  oge_ninf_vec_combined := by
  unfold oge_ninf_vec_before oge_ninf_vec_combined
  simp_alive_peephole
  sorry
def ord_pinf_combined := [llvmfunc|
  llvm.func @ord_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ord_pinf   : ord_pinf_before  ⊑  ord_pinf_combined := by
  unfold ord_pinf_before ord_pinf_combined
  simp_alive_peephole
  sorry
def uno_pinf_combined := [llvmfunc|
  llvm.func @uno_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uno" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_uno_pinf   : uno_pinf_before  ⊑  uno_pinf_combined := by
  unfold uno_pinf_before uno_pinf_combined
  simp_alive_peephole
  sorry
def true_pinf_combined := [llvmfunc|
  llvm.func @true_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_true_pinf   : true_pinf_before  ⊑  true_pinf_combined := by
  unfold true_pinf_before true_pinf_combined
  simp_alive_peephole
  sorry
def false_pinf_combined := [llvmfunc|
  llvm.func @false_pinf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_false_pinf   : false_pinf_before  ⊑  false_pinf_combined := by
  unfold false_pinf_before false_pinf_combined
  simp_alive_peephole
  sorry
def ord_ninf_combined := [llvmfunc|
  llvm.func @ord_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "ord" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_ord_ninf   : ord_ninf_before  ⊑  ord_ninf_combined := by
  unfold ord_ninf_before ord_ninf_combined
  simp_alive_peephole
  sorry
def uno_ninf_combined := [llvmfunc|
  llvm.func @uno_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.fcmp "uno" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_uno_ninf   : uno_ninf_before  ⊑  uno_ninf_combined := by
  unfold uno_ninf_before uno_ninf_combined
  simp_alive_peephole
  sorry
def true_ninf_combined := [llvmfunc|
  llvm.func @true_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_true_ninf   : true_ninf_before  ⊑  true_ninf_combined := by
  unfold true_ninf_before true_ninf_combined
  simp_alive_peephole
  sorry
def false_ninf_combined := [llvmfunc|
  llvm.func @false_ninf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_false_ninf   : false_ninf_before  ⊑  false_ninf_combined := by
  unfold false_ninf_before false_ninf_combined
  simp_alive_peephole
  sorry
def olt_one_combined := [llvmfunc|
  llvm.func @olt_one(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f16) : f16
    %1 = llvm.fcmp "olt" %arg0, %0 : f16
    llvm.return %1 : i1
  }]

theorem inst_combine_olt_one   : olt_one_before  ⊑  olt_one_combined := by
  unfold olt_one_before olt_one_combined
  simp_alive_peephole
  sorry
