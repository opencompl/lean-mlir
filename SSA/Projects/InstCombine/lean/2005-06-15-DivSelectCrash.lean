import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2005-06-15-DivSelectCrash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z13func_31585107li_before := [llvmfunc|
  llvm.func @_Z13func_31585107li(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(-1621308501 : i32) : i32
    %4 = llvm.select %0, %1, %2 : i1, i32
    %5 = llvm.udiv %2, %4  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.select %6, %arg1, %3 : i1, i32
    llvm.return %7 : i32
  }]

