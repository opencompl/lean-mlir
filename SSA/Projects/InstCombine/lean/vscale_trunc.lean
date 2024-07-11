import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vscale_trunc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vscale_trunc_i32toi8() -> i8 vscale_range_before := [llvmfunc|
  llvm.func @vscale_trunc_i32toi8() -> i8 vscale_range(1, 128) {
    %0 = "llvm.intr.vscale"() : () -> i32
    %1 = llvm.trunc %0 : i32 to i8
    llvm.return %1 : i8
  }]

def vscale_trunc_i32toi8_poison() -> i8 vscale_range_before := [llvmfunc|
  llvm.func @vscale_trunc_i32toi8_poison() -> i8 vscale_range(1, 256) {
    %0 = "llvm.intr.vscale"() : () -> i32
    %1 = llvm.trunc %0 : i32 to i8
    llvm.return %1 : i8
  }]

def vscale_trunc_i32toi8_noAttr_before := [llvmfunc|
  llvm.func @vscale_trunc_i32toi8_noAttr() -> i8 {
    %0 = "llvm.intr.vscale"() : () -> i32
    %1 = llvm.trunc %0 : i32 to i8
    llvm.return %1 : i8
  }]

def vscale_trunc_i32toi8() -> i8 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_trunc_i32toi8() -> i8 vscale_range(1, 128) {
    %0 = "llvm.intr.vscale"() : () -> i8
    llvm.return %0 : i8
  }]

theorem inst_combine_vscale_trunc_i32toi8() -> i8 vscale_range   : vscale_trunc_i32toi8() -> i8 vscale_range_before  ⊑  vscale_trunc_i32toi8() -> i8 vscale_range_combined := by
  unfold vscale_trunc_i32toi8() -> i8 vscale_range_before vscale_trunc_i32toi8() -> i8 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_trunc_i32toi8_poison() -> i8 vscale_range_combined := [llvmfunc|
  llvm.func @vscale_trunc_i32toi8_poison() -> i8 vscale_range(1, 256) {
    %0 = "llvm.intr.vscale"() : () -> i32
    %1 = llvm.trunc %0 : i32 to i8
    llvm.return %1 : i8
  }]

theorem inst_combine_vscale_trunc_i32toi8_poison() -> i8 vscale_range   : vscale_trunc_i32toi8_poison() -> i8 vscale_range_before  ⊑  vscale_trunc_i32toi8_poison() -> i8 vscale_range_combined := by
  unfold vscale_trunc_i32toi8_poison() -> i8 vscale_range_before vscale_trunc_i32toi8_poison() -> i8 vscale_range_combined
  simp_alive_peephole
  sorry
def vscale_trunc_i32toi8_noAttr_combined := [llvmfunc|
  llvm.func @vscale_trunc_i32toi8_noAttr() -> i8 {
    %0 = "llvm.intr.vscale"() : () -> i32
    %1 = llvm.trunc %0 : i32 to i8
    llvm.return %1 : i8
  }]

theorem inst_combine_vscale_trunc_i32toi8_noAttr   : vscale_trunc_i32toi8_noAttr_before  ⊑  vscale_trunc_i32toi8_noAttr_combined := by
  unfold vscale_trunc_i32toi8_noAttr_before vscale_trunc_i32toi8_noAttr_combined
  simp_alive_peephole
  sorry
