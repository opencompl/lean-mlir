import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-12-23-Select-Cmp-Cmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mng_write_basi_before := [llvmfunc|
  llvm.func @mng_write_basi(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.mlir.constant(255 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i16) : i16
    %3 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %4 = llvm.icmp "ugt" %3, %0 : i8
    %5 = llvm.load %arg1 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %6 = llvm.icmp "eq" %5, %1 : i16
    %7 = llvm.icmp "eq" %5, %2 : i16
    %8 = llvm.select %4, %7, %6 : i1, i1
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

