import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  opaque
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _TwTkV_before := [llvmfunc|
  llvm.func @_TwTkV(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(40 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @rt_swift_slowAlloc(%0, %1) : (i64, i64) -> !llvm.ptr
    llvm.store %2, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    "llvm.intr.memcpy"(%2, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return %2 : !llvm.ptr
  }]

