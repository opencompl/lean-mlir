import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-02-11-NotInitialized
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def use_before := [llvmfunc|
  llvm.func @use(%arg0: !llvm.ptr) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i64
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

def use_combined := [llvmfunc|
  llvm.func @use(%arg0: !llvm.ptr) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nofree", "nounwind"]} {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i64
    %1 = llvm.trunc %0 : i64 to i32
    llvm.return %1 : i32
  }]

theorem inst_combine_use   : use_before  ⊑  use_combined := by
  unfold use_before use_combined
  simp_alive_peephole
  sorry
