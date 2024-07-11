import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  assume-separate_storage
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def simple_folding_before := [llvmfunc|
  llvm.func @simple_folding(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(123 : i64) : i64
    %1 = llvm.mlir.constant(777 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.getelementptr %arg1[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    llvm.return
  }]

def folds_removed_operands_before := [llvmfunc|
  llvm.func @folds_removed_operands(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64) -> i64 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.add %arg2, %arg3  : i64
    %2 = llvm.add %1, %arg3  : i64
    %3 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    "llvm.intr.assume"(%0) : (i1) -> ()
    llvm.return %2 : i64
  }]

def handles_globals_before := [llvmfunc|
  llvm.func @handles_globals(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(777 : i32) : i32
    %1 = llvm.mlir.addressof @some_global : !llvm.ptr
    %2 = llvm.mlir.constant(3 : i65) : i65
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.getelementptr %1[%2] : (!llvm.ptr, i65) -> !llvm.ptr, i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    llvm.return
  }]

def simple_folding_combined := [llvmfunc|
  llvm.func @simple_folding(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(true) : i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    llvm.return
  }]

theorem inst_combine_simple_folding   : simple_folding_before  ⊑  simple_folding_combined := by
  unfold simple_folding_before simple_folding_combined
  simp_alive_peephole
  sorry
def folds_removed_operands_combined := [llvmfunc|
  llvm.func @folds_removed_operands(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i64, %arg3: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.shl %arg3, %0  : i64
    %3 = llvm.add %2, %arg2  : i64
    "llvm.intr.assume"(%1) : (i1) -> ()
    llvm.return %3 : i64
  }]

theorem inst_combine_folds_removed_operands   : folds_removed_operands_before  ⊑  folds_removed_operands_combined := by
  unfold folds_removed_operands_before folds_removed_operands_combined
  simp_alive_peephole
  sorry
def handles_globals_combined := [llvmfunc|
  llvm.func @handles_globals(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(true) : i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    llvm.return
  }]

theorem inst_combine_handles_globals   : handles_globals_before  ⊑  handles_globals_combined := by
  unfold handles_globals_before handles_globals_combined
  simp_alive_peephole
  sorry
