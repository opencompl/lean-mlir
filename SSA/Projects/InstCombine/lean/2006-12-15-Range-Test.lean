import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-12-15-Range-Test
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def print_pgm_cond_true_before := [llvmfunc|
  llvm.func @print_pgm_cond_true(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @r : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-31 : i32) : i32
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(true) : i1
    llvm.br ^bb3
  ^bb1:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %5 : i1
  ^bb2:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %4 : i1
  ^bb3:  // pred: ^bb0
    %6 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<17 x i32>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.icmp "slt" %7, %2 : i32
    %9 = llvm.icmp "sgt" %7, %3 : i32
    %10 = llvm.or %8, %9  : i1
    llvm.cond_br %10, ^bb1, ^bb2
  }]

def print_pgm_cond_true_logical_before := [llvmfunc|
  llvm.func @print_pgm_cond_true_logical(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @r : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-31 : i32) : i32
    %3 = llvm.mlir.constant(31 : i32) : i32
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(false) : i1
    llvm.br ^bb3
  ^bb1:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %4 : i1
  ^bb2:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %5 : i1
  ^bb3:  // pred: ^bb0
    %6 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<17 x i32>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.icmp "slt" %7, %2 : i32
    %9 = llvm.icmp "sgt" %7, %3 : i32
    %10 = llvm.select %8, %4, %9 : i1, i1
    llvm.cond_br %10, ^bb1, ^bb2
  }]

def print_pgm_cond_true_combined := [llvmfunc|
  llvm.func @print_pgm_cond_true(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @r : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-32 : i32) : i32
    %3 = llvm.mlir.constant(-63 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(true) : i1
    llvm.br ^bb3
  ^bb1:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %4 : i1
  ^bb3:  // pred: ^bb0
    %6 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<17 x i32>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.add %7, %2  : i32
    %9 = llvm.icmp "ult" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  }]

theorem inst_combine_print_pgm_cond_true   : print_pgm_cond_true_before  ⊑  print_pgm_cond_true_combined := by
  unfold print_pgm_cond_true_before print_pgm_cond_true_combined
  simp_alive_peephole
  sorry
def print_pgm_cond_true_logical_combined := [llvmfunc|
  llvm.func @print_pgm_cond_true_logical(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @r : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-32 : i32) : i32
    %3 = llvm.mlir.constant(-63 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(true) : i1
    llvm.br ^bb3
  ^bb1:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb3
    llvm.store %7, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %4 : i1
  ^bb3:  // pred: ^bb0
    %6 = llvm.getelementptr %0[%1, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<17 x i32>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.add %7, %2  : i32
    %9 = llvm.icmp "ult" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  }]

theorem inst_combine_print_pgm_cond_true_logical   : print_pgm_cond_true_logical_before  ⊑  print_pgm_cond_true_logical_combined := by
  unfold print_pgm_cond_true_logical_before print_pgm_cond_true_logical_combined
  simp_alive_peephole
  sorry
