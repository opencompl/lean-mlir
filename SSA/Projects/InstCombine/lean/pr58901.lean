import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr58901
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f1_before := [llvmfunc|
  llvm.func @f1(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    %3 = llvm.getelementptr %2[%1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    llvm.return %3 : !llvm.ptr
  }]

def f2_before := [llvmfunc|
  llvm.func @f2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    %2 = llvm.getelementptr %1[%arg1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    llvm.return %2 : !llvm.ptr
  }]

def f1_combined := [llvmfunc|
  llvm.func @f1(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_f1   : f1_before  ⊑  f1_combined := by
  unfold f1_before f1_combined
  simp_alive_peephole
  sorry
def f2_combined := [llvmfunc|
  llvm.func @f2(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    %2 = llvm.getelementptr %1[%arg1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<6 x i32>
    llvm.return %2 : !llvm.ptr
  }]

theorem inst_combine_f2   : f2_before  ⊑  f2_combined := by
  unfold f2_before f2_combined
  simp_alive_peephole
  sorry
