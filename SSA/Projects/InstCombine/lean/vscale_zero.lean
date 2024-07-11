import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vscale_zero
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def iszero_before := [llvmfunc|
  llvm.func @iszero() -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.vscale"() : () -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def iszero_range() -> i1 vscale_range_before := [llvmfunc|
  llvm.func @iszero_range() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.vscale"() : () -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def iszero_combined := [llvmfunc|
  llvm.func @iszero() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_iszero   : iszero_before  ⊑  iszero_combined := by
  unfold iszero_before iszero_combined
  simp_alive_peephole
  sorry
def iszero_range() -> i1 vscale_range_combined := [llvmfunc|
  llvm.func @iszero_range() -> i1 vscale_range(1, 16) {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_iszero_range() -> i1 vscale_range   : iszero_range() -> i1 vscale_range_before  ⊑  iszero_range() -> i1 vscale_range_combined := by
  unfold iszero_range() -> i1 vscale_range_before iszero_range() -> i1 vscale_range_combined
  simp_alive_peephole
  sorry
