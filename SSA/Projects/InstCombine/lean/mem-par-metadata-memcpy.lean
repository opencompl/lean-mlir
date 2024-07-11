import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  mem-par-metadata-memcpy
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z4testPcl_before := [llvmfunc|
  llvm.func @_Z4testPcl(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb3
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    llvm.cond_br %3, ^bb2, ^bb4
  ^bb2:  // pred: ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.add %2, %arg1 overflow<nsw>  : i64
    %6 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    "llvm.intr.memcpy"(%4, %6, %1) <{access_groups = [#access_group], isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %7 = llvm.add %2, %1 overflow<nsw>  : i64
    llvm.br ^bb1(%7 : i64) {loop_annotation = #loop_annotation}]

  ^bb4:  // pred: ^bb1
    llvm.return
  }]

def _Z4testPcl_combined := [llvmfunc|
  llvm.func @_Z4testPcl(%arg0: !llvm.ptr, %arg1: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb3
    %3 = llvm.icmp "slt" %2, %arg1 : i64
    llvm.cond_br %3, ^bb2, ^bb4
  ^bb2:  // pred: ^bb1
    %4 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.getelementptr %5[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.load %6 {access_groups = [#access_group], alignment = 1 : i64} : !llvm.ptr -> i16
    llvm.store %7, %4 {access_groups = [#access_group], alignment = 1 : i64} : i16, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %8 = llvm.add %2, %1 overflow<nsw, nuw>  : i64
    llvm.br ^bb1(%8 : i64) {loop_annotation = #loop_annotation}
  ^bb4:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine__Z4testPcl   : _Z4testPcl_before  ⊑  _Z4testPcl_combined := by
  unfold _Z4testPcl_before _Z4testPcl_combined
  simp_alive_peephole
  sorry
