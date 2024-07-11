import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-04-22-ByValBitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(3 : i32) : i32
    llvm.call @bar(%0, %arg0) vararg(!llvm.func<void (i32, ...)>) : (i32, !llvm.ptr) -> ()
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(3 : i32) : i32
    llvm.call @bar(%0, %arg0) vararg(!llvm.func<void (i32, ...)>) : (i32, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
