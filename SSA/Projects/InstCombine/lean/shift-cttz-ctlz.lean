import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shift-cttz-ctlz
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def shl_cttz_false_before := [llvmfunc|
  llvm.func @shl_cttz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def shl_ctlz_false_before := [llvmfunc|
  llvm.func @shl_ctlz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.ctlz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def lshr_cttz_false_before := [llvmfunc|
  llvm.func @lshr_cttz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def ashr_cttz_false_before := [llvmfunc|
  llvm.func @ashr_cttz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def shl_cttz_false_multiuse_before := [llvmfunc|
  llvm.func @shl_cttz_false_multiuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

def shl_cttz_as_lhs_before := [llvmfunc|
  llvm.func @shl_cttz_as_lhs(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

    %1 = llvm.shl %0, %arg0  : i32
    llvm.return %1 : i32
  }]

def shl_cttz_false_combined := [llvmfunc|
  llvm.func @shl_cttz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_shl_cttz_false   : shl_cttz_false_before  ⊑  shl_cttz_false_combined := by
  unfold shl_cttz_false_before shl_cttz_false_combined
  simp_alive_peephole
  sorry
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_cttz_false   : shl_cttz_false_before  ⊑  shl_cttz_false_combined := by
  unfold shl_cttz_false_before shl_cttz_false_combined
  simp_alive_peephole
  sorry
def shl_ctlz_false_combined := [llvmfunc|
  llvm.func @shl_ctlz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.ctlz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_shl_ctlz_false   : shl_ctlz_false_before  ⊑  shl_ctlz_false_combined := by
  unfold shl_ctlz_false_before shl_ctlz_false_combined
  simp_alive_peephole
  sorry
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_ctlz_false   : shl_ctlz_false_before  ⊑  shl_ctlz_false_combined := by
  unfold shl_ctlz_false_before shl_ctlz_false_combined
  simp_alive_peephole
  sorry
def lshr_cttz_false_combined := [llvmfunc|
  llvm.func @lshr_cttz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_lshr_cttz_false   : lshr_cttz_false_before  ⊑  lshr_cttz_false_combined := by
  unfold lshr_cttz_false_before lshr_cttz_false_combined
  simp_alive_peephole
  sorry
    %1 = llvm.lshr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_lshr_cttz_false   : lshr_cttz_false_before  ⊑  lshr_cttz_false_combined := by
  unfold lshr_cttz_false_before lshr_cttz_false_combined
  simp_alive_peephole
  sorry
def ashr_cttz_false_combined := [llvmfunc|
  llvm.func @ashr_cttz_false(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_ashr_cttz_false   : ashr_cttz_false_before  ⊑  ashr_cttz_false_combined := by
  unfold ashr_cttz_false_before ashr_cttz_false_combined
  simp_alive_peephole
  sorry
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_ashr_cttz_false   : ashr_cttz_false_before  ⊑  ashr_cttz_false_combined := by
  unfold ashr_cttz_false_before ashr_cttz_false_combined
  simp_alive_peephole
  sorry
def shl_cttz_false_multiuse_combined := [llvmfunc|
  llvm.func @shl_cttz_false_multiuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_shl_cttz_false_multiuse   : shl_cttz_false_multiuse_before  ⊑  shl_cttz_false_multiuse_combined := by
  unfold shl_cttz_false_multiuse_before shl_cttz_false_multiuse_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.shl %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_cttz_false_multiuse   : shl_cttz_false_multiuse_before  ⊑  shl_cttz_false_multiuse_combined := by
  unfold shl_cttz_false_multiuse_before shl_cttz_false_multiuse_combined
  simp_alive_peephole
  sorry
def shl_cttz_as_lhs_combined := [llvmfunc|
  llvm.func @shl_cttz_as_lhs(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg1) <{is_zero_poison = false}> : (i32) -> i32]

theorem inst_combine_shl_cttz_as_lhs   : shl_cttz_as_lhs_before  ⊑  shl_cttz_as_lhs_combined := by
  unfold shl_cttz_as_lhs_before shl_cttz_as_lhs_combined
  simp_alive_peephole
  sorry
    %1 = llvm.shl %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_shl_cttz_as_lhs   : shl_cttz_as_lhs_before  ⊑  shl_cttz_as_lhs_combined := by
  unfold shl_cttz_as_lhs_before shl_cttz_as_lhs_combined
  simp_alive_peephole
  sorry
