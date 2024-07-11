import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  malloc-free-delete-dbginvar
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: !llvm.ptr) attributes {passthrough = ["minsize"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @free(%arg0) : (!llvm.ptr) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }]

