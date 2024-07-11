import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-05-14-Crash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0, 1] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.def", (ptr, struct<"struct.abc", (i32, array<32 x i8>)>)>
    llvm.return %2 : !llvm.ptr
  }]

