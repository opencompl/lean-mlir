import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  call2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bar_before := [llvmfunc|
  llvm.func @bar() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @f : !llvm.ptr
    %2 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.call %1(%2) vararg(!llvm.func<i32 (...)>) : !llvm.ptr, (f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %5 : i32
  }]

def f_before := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %3 : i32
  }]

def bar_combined := [llvmfunc|
  llvm.func @bar() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @f : !llvm.ptr
    %2 = llvm.mlir.constant(3.000000e+00 : f64) : f64
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
    %4 = llvm.call %1(%2) vararg(!llvm.func<i32 (...)>) : !llvm.ptr, (f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i32
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
def f_combined := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i32
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
