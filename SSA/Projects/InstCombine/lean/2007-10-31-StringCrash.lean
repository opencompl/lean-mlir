import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-10-31-StringCrash
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _start_before := [llvmfunc|
  llvm.func @_start(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.addressof @__darwin_gcc3_preregister_frame_info : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

