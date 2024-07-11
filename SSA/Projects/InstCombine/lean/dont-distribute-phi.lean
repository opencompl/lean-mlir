import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  dont-distribute-phi
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(37 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.mlir.undef : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%2 : i1)
  ^bb2:  // pred: ^bb0
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.br ^bb3(%5 : i1)
  ^bb3(%6: i1):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.xor %4, %3  : i1
    %8 = llvm.and %6, %7  : i1
    llvm.return %8 : i1
  }]

def foo_logical(%arg0: i32) -> _before := [llvmfunc|
  llvm.func @foo_logical(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(37 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.mlir.undef : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%2 : i1)
  ^bb2:  // pred: ^bb0
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.br ^bb3(%6 : i1)
  ^bb3(%7: i1):  // 2 preds: ^bb1, ^bb2
    %8 = llvm.xor %5, %3  : i1
    %9 = llvm.select %7, %8, %4 : i1, i1
    llvm.return %9 : i1
  }]

def foo(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @foo(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(37 : i32) : i32
    %1 = llvm.mlir.undef : i1
    %2 = llvm.mlir.constant(17 : i32) : i32
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %4 = llvm.icmp "slt" %arg0, %2 : i32
    llvm.br ^bb3(%4 : i1)
  ^bb3(%5: i1):  // 2 preds: ^bb1, ^bb2
    %6 = llvm.and %5, %3  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_foo(%arg0: i32) ->    : foo(%arg0: i32) -> _before  ⊑  foo(%arg0: i32) -> _combined := by
  unfold foo(%arg0: i32) -> _before foo(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
def foo_logical(%arg0: i32) -> _combined := [llvmfunc|
  llvm.func @foo_logical(%arg0: i32) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(37 : i32) : i32
    %1 = llvm.mlir.undef : i1
    %2 = llvm.mlir.constant(17 : i32) : i32
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    %4 = llvm.icmp "slt" %arg0, %2 : i32
    llvm.br ^bb3(%4 : i1)
  ^bb3(%5: i1):  // 2 preds: ^bb1, ^bb2
    %6 = llvm.and %5, %3  : i1
    llvm.return %6 : i1
  }]

theorem inst_combine_foo_logical(%arg0: i32) ->    : foo_logical(%arg0: i32) -> _before  ⊑  foo_logical(%arg0: i32) -> _combined := by
  unfold foo_logical(%arg0: i32) -> _before foo_logical(%arg0: i32) -> _combined
  simp_alive_peephole
  sorry
