import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  lifetime
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def bar_before := [llvmfunc|
  llvm.func @bar(%arg0: i1) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<1 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.array<1 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.start 1, %2 : !llvm.ptr
    llvm.intr.lifetime.end 1, %2 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.start 1, %2 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %2 : !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.start 1, %2 : !llvm.ptr
    llvm.call @foo(%2, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.intr.lifetime.end 1, %2 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }]

def bar_combined := [llvmfunc|
  llvm.func @bar(%arg0: i1) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<1 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.array<1 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5
  ^bb4:  // pred: ^bb0
    llvm.intr.lifetime.start 1, %1 : !llvm.ptr
    llvm.intr.lifetime.start 1, %2 : !llvm.ptr
    llvm.call @foo(%2, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.intr.lifetime.end 1, %2 : !llvm.ptr
    llvm.intr.lifetime.end 1, %1 : !llvm.ptr
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb3, ^bb4
    llvm.return
  }]

theorem inst_combine_bar   : bar_before  ⊑  bar_combined := by
  unfold bar_before bar_combined
  simp_alive_peephole
  sorry
