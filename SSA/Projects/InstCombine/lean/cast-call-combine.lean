import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-call-combine
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bar_before := [llvmfunc|
  llvm.func @bar() attributes {passthrough = ["noinline", "noreturn"]} {
    llvm.unreachable
  }]

def test_before := [llvmfunc|
  llvm.func @test() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @foo(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def bar_combined := [llvmfunc|
  llvm.func @bar() attributes {passthrough = ["noinline", "noreturn"]} {
    llvm.unreachable
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
def test_combined := [llvmfunc|
  llvm.func @test() {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
