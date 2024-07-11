import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-equality-rotate
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def cmpeq_rorr_to_rorl_before := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def cmpeq_rorr_to_rorl_non_equality_fail_before := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl_non_equality_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail_before := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "ult" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

def cmpeq_rorr_to_rorl_non_ror_fail_before := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl_non_ror_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg1, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def cmpeq_rorr_to_rorl_multiuse_fail_before := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl_multiuse_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def cmpne_rorr_rorr_before := [llvmfunc|
  llvm.func @cmpne_rorr_rorr(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }]

def cmpne_rorrX_rorrY_before := [llvmfunc|
  llvm.func @cmpne_rorrX_rorrY(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg1, %arg1, %arg3)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }]

def cmpne_rorr_rorr_non_equality_fail_before := [llvmfunc|
  llvm.func @cmpne_rorr_rorr_non_equality_fail(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "sge" %0, %1 : i8
    llvm.return %2 : i1
  }]

def cmpne_rorr_rorl_todo_mismatch_C_before := [llvmfunc|
  llvm.func @cmpne_rorr_rorl_todo_mismatch_C(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

def cmpne_rorl_rorl_multiuse1_fail_before := [llvmfunc|
  llvm.func @cmpne_rorl_rorl_multiuse1_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

def cmpeq_rorlXC_rorlYC_multiuse1_before := [llvmfunc|
  llvm.func @cmpeq_rorlXC_rorlYC_multiuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.intr.fshl(%arg1, %arg1, %1)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }]

def cmpeq_rorlC_rorlC_multiuse2_fail_before := [llvmfunc|
  llvm.func @cmpeq_rorlC_rorlC_multiuse2_fail(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.intr.fshl(%arg0, %arg0, %1)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }]

def cmpeq_rorr_to_rorl_combined := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_cmpeq_rorr_to_rorl   : cmpeq_rorr_to_rorl_before  ⊑  cmpeq_rorr_to_rorl_combined := by
  unfold cmpeq_rorr_to_rorl_before cmpeq_rorr_to_rorl_combined
  simp_alive_peephole
  sorry
def cmpeq_rorr_to_rorl_non_equality_fail_combined := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl_non_equality_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_cmpeq_rorr_to_rorl_non_equality_fail   : cmpeq_rorr_to_rorl_non_equality_fail_before  ⊑  cmpeq_rorr_to_rorl_non_equality_fail_combined := by
  unfold cmpeq_rorr_to_rorl_non_equality_fail_before cmpeq_rorr_to_rorl_non_equality_fail_combined
  simp_alive_peephole
  sorry
def cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail_combined := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "ult" %0, %arg1 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail   : cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail_before  ⊑  cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail_combined := by
  unfold cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail_before cmpeq_rorr_to_rorl_cmp_against_wrong_val_fail_combined
  simp_alive_peephole
  sorry
def cmpeq_rorr_to_rorl_non_ror_fail_combined := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl_non_ror_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg1, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_cmpeq_rorr_to_rorl_non_ror_fail   : cmpeq_rorr_to_rorl_non_ror_fail_before  ⊑  cmpeq_rorr_to_rorl_non_ror_fail_combined := by
  unfold cmpeq_rorr_to_rorl_non_ror_fail_before cmpeq_rorr_to_rorl_non_ror_fail_combined
  simp_alive_peephole
  sorry
def cmpeq_rorr_to_rorl_multiuse_fail_combined := [llvmfunc|
  llvm.func @cmpeq_rorr_to_rorl_multiuse_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%0) : (i8) -> ()
    %1 = llvm.icmp "eq" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_cmpeq_rorr_to_rorl_multiuse_fail   : cmpeq_rorr_to_rorl_multiuse_fail_before  ⊑  cmpeq_rorr_to_rorl_multiuse_fail_combined := by
  unfold cmpeq_rorr_to_rorl_multiuse_fail_before cmpeq_rorr_to_rorl_multiuse_fail_combined
  simp_alive_peephole
  sorry
def cmpne_rorr_rorr_combined := [llvmfunc|
  llvm.func @cmpne_rorr_rorr(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.sub %arg1, %arg2  : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_cmpne_rorr_rorr   : cmpne_rorr_rorr_before  ⊑  cmpne_rorr_rorr_combined := by
  unfold cmpne_rorr_rorr_before cmpne_rorr_rorr_combined
  simp_alive_peephole
  sorry
def cmpne_rorrX_rorrY_combined := [llvmfunc|
  llvm.func @cmpne_rorrX_rorrY(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.sub %arg2, %arg3  : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_cmpne_rorrX_rorrY   : cmpne_rorrX_rorrY_before  ⊑  cmpne_rorrX_rorrY_combined := by
  unfold cmpne_rorrX_rorrY_before cmpne_rorrX_rorrY_combined
  simp_alive_peephole
  sorry
def cmpne_rorr_rorr_non_equality_fail_combined := [llvmfunc|
  llvm.func @cmpne_rorr_rorr_non_equality_fail(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "sge" %0, %1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_cmpne_rorr_rorr_non_equality_fail   : cmpne_rorr_rorr_non_equality_fail_before  ⊑  cmpne_rorr_rorr_non_equality_fail_combined := by
  unfold cmpne_rorr_rorr_non_equality_fail_before cmpne_rorr_rorr_non_equality_fail_combined
  simp_alive_peephole
  sorry
def cmpne_rorr_rorl_todo_mismatch_C_combined := [llvmfunc|
  llvm.func @cmpne_rorr_rorl_todo_mismatch_C(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_cmpne_rorr_rorl_todo_mismatch_C   : cmpne_rorr_rorl_todo_mismatch_C_before  ⊑  cmpne_rorr_rorl_todo_mismatch_C_combined := by
  unfold cmpne_rorr_rorl_todo_mismatch_C_before cmpne_rorr_rorl_todo_mismatch_C_combined
  simp_alive_peephole
  sorry
def cmpne_rorl_rorl_multiuse1_fail_combined := [llvmfunc|
  llvm.func @cmpne_rorl_rorl_multiuse1_fail(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %1, %2 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_cmpne_rorl_rorl_multiuse1_fail   : cmpne_rorl_rorl_multiuse1_fail_before  ⊑  cmpne_rorl_rorl_multiuse1_fail_combined := by
  unfold cmpne_rorl_rorl_multiuse1_fail_before cmpne_rorl_rorl_multiuse1_fail_combined
  simp_alive_peephole
  sorry
def cmpeq_rorlXC_rorlYC_multiuse1_combined := [llvmfunc|
  llvm.func @cmpeq_rorlXC_rorlYC_multiuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %0)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%1) : (i8) -> ()
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_cmpeq_rorlXC_rorlYC_multiuse1   : cmpeq_rorlXC_rorlYC_multiuse1_before  ⊑  cmpeq_rorlXC_rorlYC_multiuse1_combined := by
  unfold cmpeq_rorlXC_rorlYC_multiuse1_before cmpeq_rorlXC_rorlYC_multiuse1_combined
  simp_alive_peephole
  sorry
def cmpeq_rorlC_rorlC_multiuse2_fail_combined := [llvmfunc|
  llvm.func @cmpeq_rorlC_rorlC_multiuse2_fail(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.intr.fshl(%arg0, %arg0, %1)  : (i8, i8, i8) -> i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_cmpeq_rorlC_rorlC_multiuse2_fail   : cmpeq_rorlC_rorlC_multiuse2_fail_before  ⊑  cmpeq_rorlC_rorlC_multiuse2_fail_combined := by
  unfold cmpeq_rorlC_rorlC_multiuse2_fail_before cmpeq_rorlC_rorlC_multiuse2_fail_combined
  simp_alive_peephole
  sorry
