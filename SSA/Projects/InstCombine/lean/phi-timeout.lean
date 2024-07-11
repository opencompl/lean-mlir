import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-timeout
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def timeout_before := [llvmfunc|
  llvm.func @timeout(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %3 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i16
    %4 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %5 = llvm.icmp "eq" %4, %1 : i16
    llvm.cond_br %5, ^bb2, ^bb3(%4 : i16)
  ^bb2:  // pred: ^bb1
    %6 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr -> i16]

    llvm.br ^bb3(%6 : i16)
  ^bb3(%7: i16):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.trunc %7 : i16 to i8
    %9 = llvm.add %8, %2  : i8
    llvm.store %9, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.br ^bb1
  }]

def timeout_combined := [llvmfunc|
  llvm.func @timeout(%arg0: !llvm.ptr {llvm.nocapture, llvm.readonly}, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(-1 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %3 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i16
    %4 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr -> i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    %6 = llvm.trunc %4 : i16 to i8
    llvm.cond_br %5, ^bb2, ^bb3(%6 : i8)
  ^bb2:  // pred: ^bb1
    %7 = llvm.load %3 {alignment = 2 : i64} : !llvm.ptr -> i16
    %8 = llvm.trunc %7 : i16 to i8
    llvm.br ^bb3(%8 : i8)
  ^bb3(%9: i8):  // 2 preds: ^bb1, ^bb2
    %10 = llvm.add %9, %2  : i8
    llvm.store %10, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb1
  }]

theorem inst_combine_timeout   : timeout_before  ⊑  timeout_combined := by
  unfold timeout_before timeout_combined
  simp_alive_peephole
  sorry
