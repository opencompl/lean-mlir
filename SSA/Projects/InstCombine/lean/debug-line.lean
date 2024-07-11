import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  debug-line
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant("%c\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.mlir.constant(97 : i32) : i32
    %3 = llvm.call @printf(%1, %2) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i32) -> i32
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(97 : i32) : i32
    %1 = llvm.call @putchar(%0) : (i32) -> i32
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
