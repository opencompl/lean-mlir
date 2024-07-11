import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-callee-deopt-bundles
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def g_before := [llvmfunc|
  llvm.func @g() {
    %0 = llvm.mlir.addressof @foo : !llvm.ptr
    llvm.call %0() : !llvm.ptr, () -> ()
    llvm.return
  }]

def g_combined := [llvmfunc|
  llvm.func @g() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.call @foo(%0) : (i32) -> ()
    llvm.return
  }]

theorem inst_combine_g   : g_before  ⊑  g_combined := by
  unfold g_before g_combined
  simp_alive_peephole
  sorry
