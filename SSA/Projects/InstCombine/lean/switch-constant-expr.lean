import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  switch-constant-expr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def single_case_before := [llvmfunc|
  llvm.func @single_case() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    %4 = llvm.add %3, %0  : i32
    llvm.switch %4 : i32, ^bb1 [
    ]
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  }]

def multiple_cases_before := [llvmfunc|
  llvm.func @multiple_cases() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    %4 = llvm.add %3, %0  : i32
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    llvm.switch %4 : i32, ^bb1 [
      1: ^bb2,
      2: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %6 : i32
  ^bb3:  // pred: ^bb0
    llvm.return %5 : i32
  }]

def single_case_combined := [llvmfunc|
  llvm.func @single_case() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    %4 = llvm.add %3, %0  : i32
    llvm.switch %4 : i32, ^bb1 [
    ]
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  }]

theorem inst_combine_single_case   : single_case_before  ⊑  single_case_combined := by
  unfold single_case_before single_case_combined
  simp_alive_peephole
  sorry
def multiple_cases_combined := [llvmfunc|
  llvm.func @multiple_cases() -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    %4 = llvm.add %3, %0  : i32
    %5 = llvm.mlir.constant(2 : i32) : i32
    %6 = llvm.mlir.constant(1 : i32) : i32
    llvm.switch %4 : i32, ^bb1 [
      1: ^bb2,
      2: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %6 : i32
  ^bb3:  // pred: ^bb0
    llvm.return %5 : i32
  }]

theorem inst_combine_multiple_cases   : multiple_cases_before  ⊑  multiple_cases_combined := by
  unfold multiple_cases_before multiple_cases_combined
  simp_alive_peephole
  sorry
