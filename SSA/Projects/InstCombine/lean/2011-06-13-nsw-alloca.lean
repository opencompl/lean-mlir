import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2011-06-13-nsw-alloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fu1_before := [llvmfunc|
  llvm.func @fu1(%arg0: i32) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(2048 : i32) : i32
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    %7 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %10 = llvm.shl %9, %3 overflow<nuw>  : i32
    %11 = llvm.add %10, %4 overflow<nuw>  : i32
    %12 = llvm.alloca %11 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.store %12, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %13 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

def fu2_before := [llvmfunc|
  llvm.func @fu2(%arg0: i32) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(8 : i32) : i32
    %4 = llvm.mlir.constant(2048 : i32) : i32
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    %7 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.icmp "ne" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %10 = llvm.mul %9, %3 overflow<nuw>  : i32
    %11 = llvm.add %10, %4  : i32
    %12 = llvm.alloca %11 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.store %12, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %13 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }]

def fu1_combined := [llvmfunc|
  llvm.func @fu1(%arg0: i32) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(2048 : i32) : i32
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_fu1   : fu1_before  ⊑  fu1_combined := by
  unfold fu1_before fu1_combined
  simp_alive_peephole
  sorry
    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_fu1   : fu1_before  ⊑  fu1_combined := by
  unfold fu1_before fu1_combined
  simp_alive_peephole
  sorry
    llvm.store %arg0, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fu1   : fu1_before  ⊑  fu1_combined := by
  unfold fu1_before fu1_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fu1   : fu1_before  ⊑  fu1_combined := by
  unfold fu1_before fu1_combined
  simp_alive_peephole
  sorry
    %7 = llvm.icmp "eq" %arg0, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_fu1   : fu1_before  ⊑  fu1_combined := by
  unfold fu1_before fu1_combined
  simp_alive_peephole
  sorry
    %9 = llvm.shl %8, %3 overflow<nuw>  : i32
    %10 = llvm.add %9, %4 overflow<nuw>  : i32
    %11 = llvm.alloca %10 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_fu1   : fu1_before  ⊑  fu1_combined := by
  unfold fu1_before fu1_combined
  simp_alive_peephole
  sorry
    llvm.store %11, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fu1   : fu1_before  ⊑  fu1_combined := by
  unfold fu1_before fu1_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %12 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fu1   : fu1_before  ⊑  fu1_combined := by
  unfold fu1_before fu1_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%12) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fu1   : fu1_before  ⊑  fu1_combined := by
  unfold fu1_before fu1_combined
  simp_alive_peephole
  sorry
def fu2_combined := [llvmfunc|
  llvm.func @fu2(%arg0: i32) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(2048 : i32) : i32
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_fu2   : fu2_before  ⊑  fu2_combined := by
  unfold fu2_before fu2_combined
  simp_alive_peephole
  sorry
    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_fu2   : fu2_before  ⊑  fu2_combined := by
  unfold fu2_before fu2_combined
  simp_alive_peephole
  sorry
    llvm.store %arg0, %5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fu2   : fu2_before  ⊑  fu2_combined := by
  unfold fu2_before fu2_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fu2   : fu2_before  ⊑  fu2_combined := by
  unfold fu2_before fu2_combined
  simp_alive_peephole
  sorry
    %7 = llvm.icmp "eq" %arg0, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_fu2   : fu2_before  ⊑  fu2_combined := by
  unfold fu2_before fu2_combined
  simp_alive_peephole
  sorry
    %9 = llvm.shl %8, %3 overflow<nuw>  : i32
    %10 = llvm.add %9, %4  : i32
    %11 = llvm.alloca %10 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_fu2   : fu2_before  ⊑  fu2_combined := by
  unfold fu2_before fu2_combined
  simp_alive_peephole
  sorry
    llvm.store %11, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_fu2   : fu2_before  ⊑  fu2_combined := by
  unfold fu2_before fu2_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %12 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_fu2   : fu2_before  ⊑  fu2_combined := by
  unfold fu2_before fu2_combined
  simp_alive_peephole
  sorry
    llvm.call @bar(%12) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_fu2   : fu2_before  ⊑  fu2_combined := by
  unfold fu2_before fu2_combined
  simp_alive_peephole
  sorry
