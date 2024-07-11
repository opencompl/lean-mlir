import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  kcfi-operand-bundles
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f1_before := [llvmfunc|
  llvm.func @f1() attributes {passthrough = ["kcfi-target"]} {
    llvm.return
  }]

def g_before := [llvmfunc|
  llvm.func @g(%arg0: !llvm.ptr {llvm.noundef}) attributes {passthrough = ["kcfi-target"]} {
    llvm.call %arg0() : !llvm.ptr, () -> ()
    llvm.call @f1() : () -> ()
    llvm.call @f2() : () -> ()
    llvm.return
  }]

def f1_combined := [llvmfunc|
  llvm.func @f1() attributes {passthrough = ["kcfi-target"]} {
    llvm.return
  }]

theorem inst_combine_f1   : f1_before  ⊑  f1_combined := by
  unfold f1_before f1_combined
  simp_alive_peephole
  sorry
def g_combined := [llvmfunc|
  llvm.func @g(%arg0: !llvm.ptr {llvm.noundef}) attributes {passthrough = ["kcfi-target"]} {
    llvm.call %arg0() : !llvm.ptr, () -> ()
    llvm.call @f1() : () -> ()
    llvm.call @f2() : () -> ()
    llvm.return
  }]

theorem inst_combine_g   : g_before  ⊑  g_combined := by
  unfold g_before g_combined
  simp_alive_peephole
  sorry
