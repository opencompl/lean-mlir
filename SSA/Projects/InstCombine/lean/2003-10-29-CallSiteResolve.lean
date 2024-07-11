import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2003-10-29-CallSiteResolve
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.invoke @bar() to ^bb1 unwind ^bb2 : () -> !llvm.ptr
  ^bb1:  // pred: ^bb0
    llvm.return %1 : !llvm.ptr
  ^bb2:  // pred: ^bb0
    %2 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }]

