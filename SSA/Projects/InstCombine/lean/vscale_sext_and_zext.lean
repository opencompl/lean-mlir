import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vscale_sext_and_zext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vscale_SExt_i8toi32() -> i32 vscale_range_before := [llvmfunc|
  llvm.func @vscale_SExt_i8toi32() -> i32 vscale_range(1, 64) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.sext %0 : i8 to i32
    llvm.return %1 : i32
  }]

def vscale_SExt_i8toi32_poison() -> i32 vscale_range_before := [llvmfunc|
  llvm.func @vscale_SExt_i8toi32_poison() -> i32 vscale_range(1, 128) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.sext %0 : i8 to i32
    llvm.return %1 : i32
  }]

def vscale_ZExt_i8toi32() -> i32 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ZExt_i8toi32() -> i32 vscale_range(1, 128) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

def vscale_ZExt_i8toi32_poison() -> i32 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ZExt_i8toi32_poison() -> i32 vscale_range(1, 256) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

def vscale_ZExt_i8toi32_unknown_before := [llvmfunc|
  llvm.func @vscale_ZExt_i8toi32_unknown() -> i32 {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

def vscale_SExt_i8toi32_unbounded() -> i32 vscale_range_before := [llvmfunc|
  llvm.func @vscale_SExt_i8toi32_unbounded() -> i32 vscale_range(1, 0) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.sext %0 : i8 to i32
    llvm.return %1 : i32
  }]

def vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range_before := [llvmfunc|
  llvm.func @vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range(1, 0) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

def vscale_SExt_i8toi32() -> i32 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_SExt_i8toi32() -> i32 vscale_range(1, 64) {
    %0 = "llvm.intr.vscale"() : () -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_vscale_SExt_i8toi32() -> i32 vscale_range   : vscale_SExt_i8toi32() -> i32 vscale_range_before  ⊑  vscale_SExt_i8toi32() -> i32 vscale_range_combined := by
  unfold vscale_SExt_i8toi32() -> i32 vscale_range_before vscale_SExt_i8toi32() -> i32 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_SExt_i8toi32_poison() -> i32 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_SExt_i8toi32_poison() -> i32 vscale_range(1, 128) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.sext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_vscale_SExt_i8toi32_poison() -> i32 vscale_range   : vscale_SExt_i8toi32_poison() -> i32 vscale_range_before  ⊑  vscale_SExt_i8toi32_poison() -> i32 vscale_range_combined := by
  unfold vscale_SExt_i8toi32_poison() -> i32 vscale_range_before vscale_SExt_i8toi32_poison() -> i32 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ZExt_i8toi32() -> i32 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ZExt_i8toi32() -> i32 vscale_range(1, 128) {
    %0 = "llvm.intr.vscale"() : () -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_vscale_ZExt_i8toi32() -> i32 vscale_range   : vscale_ZExt_i8toi32() -> i32 vscale_range_before  ⊑  vscale_ZExt_i8toi32() -> i32 vscale_range_combined := by
  unfold vscale_ZExt_i8toi32() -> i32 vscale_range_before vscale_ZExt_i8toi32() -> i32 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ZExt_i8toi32_poison() -> i32 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ZExt_i8toi32_poison() -> i32 vscale_range(1, 256) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_vscale_ZExt_i8toi32_poison() -> i32 vscale_range   : vscale_ZExt_i8toi32_poison() -> i32 vscale_range_before  ⊑  vscale_ZExt_i8toi32_poison() -> i32 vscale_range_combined := by
  unfold vscale_ZExt_i8toi32_poison() -> i32 vscale_range_before vscale_ZExt_i8toi32_poison() -> i32 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ZExt_i8toi32_unknown_combined := [llvmfunc|
  llvm.func @vscale_ZExt_i8toi32_unknown() -> i32 {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_vscale_ZExt_i8toi32_unknown   : vscale_ZExt_i8toi32_unknown_before  ⊑  vscale_ZExt_i8toi32_unknown_combined := by
  unfold vscale_ZExt_i8toi32_unknown_before vscale_ZExt_i8toi32_unknown_combined
  simp_alive_peephole
  sorry
def vscale_SExt_i8toi32_unbounded() -> i32 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_SExt_i8toi32_unbounded() -> i32 vscale_range(1, 0) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.sext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_vscale_SExt_i8toi32_unbounded() -> i32 vscale_range   : vscale_SExt_i8toi32_unbounded() -> i32 vscale_range_before  ⊑  vscale_SExt_i8toi32_unbounded() -> i32 vscale_range_combined := by
  unfold vscale_SExt_i8toi32_unbounded() -> i32 vscale_range_before vscale_SExt_i8toi32_unbounded() -> i32 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range(1, 0) {
    %0 = "llvm.intr.vscale"() : () -> i8
    %1 = llvm.zext %0 : i8 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range   : vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range_before  ⊑  vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range_combined := by
  unfold vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range_before vscale_ZExt_i8toi32_unbounded() -> i32 vscale_range_combined
  simp_alive_peephole
  sorry
