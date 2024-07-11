import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-calls
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def bar_before := [llvmfunc|
  llvm.func @bar() -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() -> f64 {
    %0 = llvm.mlir.constant(0x7FF0000000000000 : f64) : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %1 : f64
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def bar_combined := [llvmfunc|
  llvm.func @bar() -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.call @sin(%0) : (f64) -> f64
    llvm.return %0 : f64
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
