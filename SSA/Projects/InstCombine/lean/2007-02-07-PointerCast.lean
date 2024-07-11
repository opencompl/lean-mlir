import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-02-07-PointerCast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("%llx\0A\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @str : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i32, i64) -> !llvm.ptr, !llvm.array<6 x i8>
    %5 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    %6 = llvm.ptrtoint %5 : !llvm.ptr to i32
    %7 = llvm.zext %6 : i32 to i64
    %8 = llvm.call @printf(%4, %7) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i64) -> i32
    llvm.return %2 : i32
  }]

