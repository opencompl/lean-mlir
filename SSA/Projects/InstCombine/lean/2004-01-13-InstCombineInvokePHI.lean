import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2004-01-13-InstCombineInvokePHI
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() -> i32 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %1, ^bb3(%0 : !llvm.ptr), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.invoke @test() to ^bb2 unwind ^bb4 : () -> !llvm.ptr
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%3 : !llvm.ptr)
  ^bb3(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb2
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %5 : i32
  ^bb4:  // pred: ^bb1
    %6 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %2 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() -> i32 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.poison : !llvm.ptr
    %3 = llvm.mlir.poison : i32
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.invoke @test() to ^bb2 unwind ^bb3 : () -> !llvm.ptr
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.store %0, %2 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %3 : i32
  ^bb3:  // pred: ^bb1
    %5 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %1 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
