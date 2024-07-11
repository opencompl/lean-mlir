import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  tbaa-store-to-load
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i64]

    llvm.store %0, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr]

    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> i64]

    llvm.return %1 : i64
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i64 {
    %0 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i64
    llvm.store %0, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %0 : i64
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
