import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-01-11-OpaqueBitcastCrash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bar_before := [llvmfunc|
  llvm.func @bar() {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    llvm.call @foo(%0) : (!llvm.ptr) -> ()
    llvm.return
  }]

