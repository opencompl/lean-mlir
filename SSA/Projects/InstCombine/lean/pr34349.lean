import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr34349
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fast_div_201_before := [llvmfunc|
  llvm.func @fast_div_201(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(71 : i16) : i16
    %1 = llvm.mlir.constant(8 : i16) : i16
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(7 : i8) : i8
    %4 = llvm.zext %arg0 : i8 to i16
    %5 = llvm.mul %4, %0  : i16
    %6 = llvm.lshr %5, %1  : i16
    %7 = llvm.trunc %6 : i16 to i8
    %8 = llvm.sub %arg0, %7  : i8
    %9 = llvm.lshr %8, %2  : i8
    %10 = llvm.add %7, %9  : i8
    %11 = llvm.lshr %10, %3  : i8
    llvm.return %11 : i8
  }]

