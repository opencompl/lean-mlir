import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  StoreToNull-DbgCheck
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z3foov_before := [llvmfunc|
  llvm.func @_Z3foov() {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.call %0() : !llvm.ptr, () -> ()
    llvm.return
  }]

def _Z3foov_combined := [llvmfunc|
  llvm.func @_Z3foov() {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr]

theorem inst_combine__Z3foov   : _Z3foov_before  ⊑  _Z3foov_combined := by
  unfold _Z3foov_before _Z3foov_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine__Z3foov   : _Z3foov_before  ⊑  _Z3foov_combined := by
  unfold _Z3foov_before _Z3foov_combined
  simp_alive_peephole
  sorry
