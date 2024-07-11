import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  debuginfo-dce2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) {
    llvm.intr.dbg.value #di_local_variable = %arg0 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable1 = %arg0 : !llvm.ptr
    llvm.call @use_as_void(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) {
    llvm.intr.dbg.value #di_local_variable = %arg0 : !llvm.ptr
    llvm.intr.dbg.value #di_local_variable1 = %arg0 : !llvm.ptr
    llvm.call @use_as_void(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
