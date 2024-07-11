import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-combine-metadata-dominance
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def combine_metadata_dominance1_before := [llvmfunc|
  llvm.func @combine_metadata_dominance1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def combine_metadata_dominance2_before := [llvmfunc|
  llvm.func @combine_metadata_dominance2(%arg0: !llvm.ptr, %arg1: i1) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

def combine_metadata_dominance3_before := [llvmfunc|
  llvm.func @combine_metadata_dominance3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def combine_metadata_dominance4_before := [llvmfunc|
  llvm.func @combine_metadata_dominance4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def combine_metadata_dominance5_before := [llvmfunc|
  llvm.func @combine_metadata_dominance5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def combine_metadata_dominance6_before := [llvmfunc|
  llvm.func @combine_metadata_dominance6(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def combine_metadata_dominance1_combined := [llvmfunc|
  llvm.func @combine_metadata_dominance1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_combine_metadata_dominance1   : combine_metadata_dominance1_before  ⊑  combine_metadata_dominance1_combined := by
  unfold combine_metadata_dominance1_before combine_metadata_dominance1_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_combine_metadata_dominance1   : combine_metadata_dominance1_before  ⊑  combine_metadata_dominance1_combined := by
  unfold combine_metadata_dominance1_before combine_metadata_dominance1_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_combine_metadata_dominance1   : combine_metadata_dominance1_before  ⊑  combine_metadata_dominance1_combined := by
  unfold combine_metadata_dominance1_before combine_metadata_dominance1_combined
  simp_alive_peephole
  sorry
def combine_metadata_dominance2_combined := [llvmfunc|
  llvm.func @combine_metadata_dominance2(%arg0: !llvm.ptr, %arg1: i1) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_combine_metadata_dominance2   : combine_metadata_dominance2_before  ⊑  combine_metadata_dominance2_combined := by
  unfold combine_metadata_dominance2_before combine_metadata_dominance2_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_combine_metadata_dominance2   : combine_metadata_dominance2_before  ⊑  combine_metadata_dominance2_combined := by
  unfold combine_metadata_dominance2_before combine_metadata_dominance2_combined
  simp_alive_peephole
  sorry
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }]

theorem inst_combine_combine_metadata_dominance2   : combine_metadata_dominance2_before  ⊑  combine_metadata_dominance2_combined := by
  unfold combine_metadata_dominance2_before combine_metadata_dominance2_combined
  simp_alive_peephole
  sorry
def combine_metadata_dominance3_combined := [llvmfunc|
  llvm.func @combine_metadata_dominance3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_combine_metadata_dominance3   : combine_metadata_dominance3_before  ⊑  combine_metadata_dominance3_combined := by
  unfold combine_metadata_dominance3_before combine_metadata_dominance3_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_combine_metadata_dominance3   : combine_metadata_dominance3_before  ⊑  combine_metadata_dominance3_combined := by
  unfold combine_metadata_dominance3_before combine_metadata_dominance3_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_combine_metadata_dominance3   : combine_metadata_dominance3_before  ⊑  combine_metadata_dominance3_combined := by
  unfold combine_metadata_dominance3_before combine_metadata_dominance3_combined
  simp_alive_peephole
  sorry
def combine_metadata_dominance4_combined := [llvmfunc|
  llvm.func @combine_metadata_dominance4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_combine_metadata_dominance4   : combine_metadata_dominance4_before  ⊑  combine_metadata_dominance4_combined := by
  unfold combine_metadata_dominance4_before combine_metadata_dominance4_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_combine_metadata_dominance4   : combine_metadata_dominance4_before  ⊑  combine_metadata_dominance4_combined := by
  unfold combine_metadata_dominance4_before combine_metadata_dominance4_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_combine_metadata_dominance4   : combine_metadata_dominance4_before  ⊑  combine_metadata_dominance4_combined := by
  unfold combine_metadata_dominance4_before combine_metadata_dominance4_combined
  simp_alive_peephole
  sorry
def combine_metadata_dominance5_combined := [llvmfunc|
  llvm.func @combine_metadata_dominance5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_combine_metadata_dominance5   : combine_metadata_dominance5_before  ⊑  combine_metadata_dominance5_combined := by
  unfold combine_metadata_dominance5_before combine_metadata_dominance5_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_combine_metadata_dominance5   : combine_metadata_dominance5_before  ⊑  combine_metadata_dominance5_combined := by
  unfold combine_metadata_dominance5_before combine_metadata_dominance5_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_combine_metadata_dominance5   : combine_metadata_dominance5_before  ⊑  combine_metadata_dominance5_combined := by
  unfold combine_metadata_dominance5_before combine_metadata_dominance5_combined
  simp_alive_peephole
  sorry
def combine_metadata_dominance6_combined := [llvmfunc|
  llvm.func @combine_metadata_dominance6(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_combine_metadata_dominance6   : combine_metadata_dominance6_before  ⊑  combine_metadata_dominance6_combined := by
  unfold combine_metadata_dominance6_before combine_metadata_dominance6_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_combine_metadata_dominance6   : combine_metadata_dominance6_before  ⊑  combine_metadata_dominance6_combined := by
  unfold combine_metadata_dominance6_before combine_metadata_dominance6_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_combine_metadata_dominance6   : combine_metadata_dominance6_before  ⊑  combine_metadata_dominance6_combined := by
  unfold combine_metadata_dominance6_before combine_metadata_dominance6_combined
  simp_alive_peephole
  sorry
