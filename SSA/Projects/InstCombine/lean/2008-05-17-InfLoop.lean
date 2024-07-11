import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-05-17-InfLoop
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %4 = llvm.ptrtoint %3 : !llvm.ptr to i32
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    %6 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %7 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %7, %6 {alignment = 4 : i64} : i32, !llvm.ptr]

    %8 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %9 = llvm.add %8, %1  : i32
    %10 = llvm.mul %9, %4  : i32
    llvm.call @BZALLOC(%10) : (i32) -> ()
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }]

