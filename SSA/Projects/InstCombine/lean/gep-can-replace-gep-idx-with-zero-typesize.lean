import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gep-can-replace-gep-idx-with-zero-typesize
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def can_replace_gep_idx_with_zero_typesize_before := [llvmfunc|
  llvm.func @can_replace_gep_idx_with_zero_typesize(%arg0: i64, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %1 = llvm.load %0 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>]

    llvm.call @do_something(%1) : (!llvm.vec<? x 4 x  i32>) -> ()
    llvm.return
  }]

def can_replace_gep_idx_with_zero_typesize_2_before := [llvmfunc|
  llvm.func @can_replace_gep_idx_with_zero_typesize_2(%arg0: i64, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg1[%arg2, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x vec<? x 4 x  i32>>
    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>]

    llvm.call @do_something(%2) : (!llvm.vec<? x 4 x  i32>) -> ()
    llvm.return
  }]

def can_replace_gep_idx_with_zero_typesize_combined := [llvmfunc|
  llvm.func @can_replace_gep_idx_with_zero_typesize(%arg0: i64, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.getelementptr %arg1[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %1 = llvm.load %0 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>]

theorem inst_combine_can_replace_gep_idx_with_zero_typesize   : can_replace_gep_idx_with_zero_typesize_before  ⊑  can_replace_gep_idx_with_zero_typesize_combined := by
  unfold can_replace_gep_idx_with_zero_typesize_before can_replace_gep_idx_with_zero_typesize_combined
  simp_alive_peephole
  sorry
    llvm.call @do_something(%1) : (!llvm.vec<? x 4 x  i32>) -> ()
    llvm.return
  }]

theorem inst_combine_can_replace_gep_idx_with_zero_typesize   : can_replace_gep_idx_with_zero_typesize_before  ⊑  can_replace_gep_idx_with_zero_typesize_combined := by
  unfold can_replace_gep_idx_with_zero_typesize_before can_replace_gep_idx_with_zero_typesize_combined
  simp_alive_peephole
  sorry
def can_replace_gep_idx_with_zero_typesize_2_combined := [llvmfunc|
  llvm.func @can_replace_gep_idx_with_zero_typesize_2(%arg0: i64, %arg1: !llvm.ptr, %arg2: i64) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.getelementptr %arg1[%arg2, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<2 x vec<? x 4 x  i32>>
    %2 = llvm.load %1 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i32>]

theorem inst_combine_can_replace_gep_idx_with_zero_typesize_2   : can_replace_gep_idx_with_zero_typesize_2_before  ⊑  can_replace_gep_idx_with_zero_typesize_2_combined := by
  unfold can_replace_gep_idx_with_zero_typesize_2_before can_replace_gep_idx_with_zero_typesize_2_combined
  simp_alive_peephole
  sorry
    llvm.call @do_something(%2) : (!llvm.vec<? x 4 x  i32>) -> ()
    llvm.return
  }]

theorem inst_combine_can_replace_gep_idx_with_zero_typesize_2   : can_replace_gep_idx_with_zero_typesize_2_before  ⊑  can_replace_gep_idx_with_zero_typesize_2_combined := by
  unfold can_replace_gep_idx_with_zero_typesize_2_before can_replace_gep_idx_with_zero_typesize_2_combined
  simp_alive_peephole
  sorry
