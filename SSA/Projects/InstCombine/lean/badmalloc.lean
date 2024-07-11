import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  badmalloc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() -> i1 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %1 : !llvm.ptr
    llvm.store %2, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.call @free(%3) : (!llvm.ptr) -> ()
    llvm.return %4 : i1
  }]

def test2() -> _before := [llvmfunc|
  llvm.func @test2() -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %1 : !llvm.ptr
    llvm.cond_br %4, ^bb2(%1 : !llvm.ptr), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %2, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.br ^bb2(%3 : !llvm.ptr)
  ^bb2(%5: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : !llvm.ptr
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2() -> _combined := [llvmfunc|
  llvm.func @test2() -> (!llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.call @malloc(%0) : (i64) -> !llvm.ptr
    %4 = llvm.icmp "eq" %3, %1 : !llvm.ptr
    llvm.cond_br %4, ^bb2(%1 : !llvm.ptr), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %2, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb2(%3 : !llvm.ptr)
  ^bb2(%5: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_test2() ->    : test2() -> _before  ⊑  test2() -> _combined := by
  unfold test2() -> _before test2() -> _combined
  simp_alive_peephole
  sorry
