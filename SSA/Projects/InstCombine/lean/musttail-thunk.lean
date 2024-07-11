import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  musttail-thunk
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def call_thunk_before := [llvmfunc|
  llvm.func @call_thunk(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.addressof @inc_first_arg_thunk : !llvm.ptr
    %1 = llvm.call %0(%arg0, %arg1) : !llvm.ptr, (i32, i32) -> i32
    llvm.return %1 : i32
  }]

def call_thunk_combined := [llvmfunc|
  llvm.func @call_thunk(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.addressof @inc_first_arg_thunk : !llvm.ptr
    %1 = llvm.call %0(%arg0, %arg1) : !llvm.ptr, (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_call_thunk   : call_thunk_before  ⊑  call_thunk_combined := by
  unfold call_thunk_before call_thunk_combined
  simp_alive_peephole
  sorry
