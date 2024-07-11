import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-05-18-CastFoldBug
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def blah_before := [llvmfunc|
  llvm.func @blah(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @objc_msgSend_stret : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

def blah_combined := [llvmfunc|
  llvm.func @blah(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @objc_msgSend_stret : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_blah   : blah_before  ⊑  blah_combined := by
  unfold blah_before blah_combined
  simp_alive_peephole
  sorry
