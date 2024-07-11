import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vscale
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def promote_vscale_i32_to_i64_before := [llvmfunc|
  llvm.func @promote_vscale_i32_to_i64() -> i64 {
    %0 = "llvm.intr.vscale"() : () -> i32
    %1 = llvm.zext %0 : i32 to i64
    llvm.return %1 : i64
  }]

def pomote_zext_shl_vscale_i32_to_i64_before := [llvmfunc|
  llvm.func @pomote_zext_shl_vscale_i32_to_i64() -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = "llvm.intr.vscale"() : () -> i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def free_zext_vscale_shl_i32_to_i64() -> i64 vscale_range_before := [llvmfunc|
  llvm.func @free_zext_vscale_shl_i32_to_i64() -> i64 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = "llvm.intr.vscale"() : () -> i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }]

def promote_vscale_i32_to_i64_combined := [llvmfunc|
  llvm.func @promote_vscale_i32_to_i64() -> i64 {
    %0 = llvm.mlir.constant(4294967295 : i64) : i64
    %1 = "llvm.intr.vscale"() : () -> i64
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_promote_vscale_i32_to_i64   : promote_vscale_i32_to_i64_before  ⊑  promote_vscale_i32_to_i64_combined := by
  unfold promote_vscale_i32_to_i64_before promote_vscale_i32_to_i64_combined
  simp_alive_peephole
  sorry
def pomote_zext_shl_vscale_i32_to_i64_combined := [llvmfunc|
  llvm.func @pomote_zext_shl_vscale_i32_to_i64() -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(4294967288 : i64) : i64
    %2 = "llvm.intr.vscale"() : () -> i64
    %3 = llvm.shl %2, %0  : i64
    %4 = llvm.and %3, %1  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_pomote_zext_shl_vscale_i32_to_i64   : pomote_zext_shl_vscale_i32_to_i64_before  ⊑  pomote_zext_shl_vscale_i32_to_i64_combined := by
  unfold pomote_zext_shl_vscale_i32_to_i64_before pomote_zext_shl_vscale_i32_to_i64_combined
  simp_alive_peephole
  sorry
def free_zext_vscale_shl_i32_to_i64() -> i64 vscale_range_combined := [llvmfunc|
  llvm.func @free_zext_vscale_shl_i32_to_i64() -> i64 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = "llvm.intr.vscale"() : () -> i64
    %2 = llvm.shl %1, %0 overflow<nsw, nuw>  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_free_zext_vscale_shl_i32_to_i64() -> i64 vscale_range   : free_zext_vscale_shl_i32_to_i64() -> i64 vscale_range_before  ⊑  free_zext_vscale_shl_i32_to_i64() -> i64 vscale_range_combined := by
  unfold free_zext_vscale_shl_i32_to_i64() -> i64 vscale_range_before free_zext_vscale_shl_i32_to_i64() -> i64 vscale_range_combined
  simp_alive_peephole
  sorry
