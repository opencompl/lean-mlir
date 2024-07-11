import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  neg-alloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i64) {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(24 : i64) : i64
    %2 = llvm.mul %arg0, %0 overflow<nsw>  : i64
    %3 = llvm.add %2, %1 overflow<nsw>  : i64
    %4 = llvm.alloca %3 x i8 {alignment = 4 : i64} : (i64) -> !llvm.ptr]

    llvm.call @use(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i64) {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(24 : i64) : i64
    %2 = llvm.shl %arg0, %0  : i64
    %3 = llvm.sub %1, %2  : i64
    %4 = llvm.alloca %3 x i8 {alignment = 4 : i64} : (i64) -> !llvm.ptr]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    llvm.call @use(%4) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
