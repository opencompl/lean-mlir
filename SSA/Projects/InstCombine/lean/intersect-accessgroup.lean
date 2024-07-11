import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  intersect-accessgroup
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_before := [llvmfunc|
  llvm.func @func(%arg0: i64, %arg1: !llvm.ptr {llvm.noalias, llvm.nonnull}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb8
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    llvm.cond_br %4, ^bb2(%0 : i32), ^bb9
  ^bb2(%5: i32):  // 2 preds: ^bb1, ^bb7
    %6 = llvm.sext %5 : i32 to i64
    %7 = llvm.icmp "slt" %6, %arg0 : i64
    llvm.cond_br %7, ^bb3(%0 : i32), ^bb8
  ^bb3(%8: i32):  // 2 preds: ^bb2, ^bb6
    %9 = llvm.sext %8 : i32 to i64
    %10 = llvm.icmp "slt" %9, %arg0 : i64
    llvm.cond_br %10, ^bb4(%0 : i32), ^bb7
  ^bb4(%11: i32):  // 2 preds: ^bb3, ^bb5
    %12 = llvm.sext %11 : i32 to i64
    %13 = llvm.icmp "slt" %12, %arg0 : i64
    llvm.cond_br %13, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %14 = llvm.add %2, %5 overflow<nsw>  : i32
    %15 = llvm.add %14, %8 overflow<nsw>  : i32
    %16 = llvm.add %15, %11 overflow<nsw>  : i32
    %17 = llvm.sext %16 : i32 to i64
    %18 = llvm.getelementptr inbounds %arg1[%17] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %19 = llvm.load %18 {access_groups = [#access_group, #access_group1], alignment = 8 : i64} : !llvm.ptr -> f64]

    %20 = llvm.load %18 {access_groups = [#access_group, #access_group2], alignment = 8 : i64} : !llvm.ptr -> f64]

    %21 = llvm.fadd %19, %20  : f64
    llvm.call @arg(%21) {access_groups = [#access_group, #access_group2, #access_group1]} : (f64) -> ()]

    %22 = llvm.add %11, %1 overflow<nsw>  : i32
    llvm.br ^bb4(%22 : i32) {loop_annotation = #loop_annotation}]

  ^bb6:  // pred: ^bb4
    %23 = llvm.add %8, %1 overflow<nsw>  : i32
    llvm.br ^bb3(%23 : i32) {loop_annotation = #loop_annotation1}]

  ^bb7:  // pred: ^bb3
    %24 = llvm.add %5, %1 overflow<nsw>  : i32
    llvm.br ^bb2(%24 : i32) {loop_annotation = #loop_annotation2}]

  ^bb8:  // pred: ^bb2
    %25 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.br ^bb1(%25 : i32) {loop_annotation = #loop_annotation3}]

  ^bb9:  // pred: ^bb1
    llvm.return
  }]

def func_combined := [llvmfunc|
  llvm.func @func(%arg0: i64, %arg1: !llvm.ptr {llvm.noalias, llvm.nonnull}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb8
    %3 = llvm.zext %2 : i32 to i64
    %4 = llvm.icmp "slt" %3, %arg0 : i64
    llvm.cond_br %4, ^bb2(%0 : i32), ^bb9
  ^bb2(%5: i32):  // 2 preds: ^bb1, ^bb7
    %6 = llvm.zext %5 : i32 to i64
    %7 = llvm.icmp "slt" %6, %arg0 : i64
    llvm.cond_br %7, ^bb3(%0 : i32), ^bb8
  ^bb3(%8: i32):  // 2 preds: ^bb2, ^bb6
    %9 = llvm.zext %8 : i32 to i64
    %10 = llvm.icmp "slt" %9, %arg0 : i64
    llvm.cond_br %10, ^bb4(%0 : i32), ^bb7
  ^bb4(%11: i32):  // 2 preds: ^bb3, ^bb5
    %12 = llvm.zext %11 : i32 to i64
    %13 = llvm.icmp "slt" %12, %arg0 : i64
    llvm.cond_br %13, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    %14 = llvm.add %2, %5 overflow<nsw, nuw>  : i32
    %15 = llvm.add %14, %8 overflow<nsw, nuw>  : i32
    %16 = llvm.add %15, %11 overflow<nsw, nuw>  : i32
    %17 = llvm.zext %16 : i32 to i64
    %18 = llvm.getelementptr inbounds %arg1[%17] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %19 = llvm.load %18 {access_groups = [#access_group], alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
    %20 = llvm.fadd %19, %19  : f64
    llvm.call @arg(%20) {access_groups = [#access_group, #access_group1, #access_group2]} : (f64) -> ()]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
    %21 = llvm.add %11, %1 overflow<nsw, nuw>  : i32
    llvm.br ^bb4(%21 : i32) {loop_annotation = #loop_annotation}]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
  ^bb6:  // pred: ^bb4
    %22 = llvm.add %8, %1 overflow<nsw, nuw>  : i32
    llvm.br ^bb3(%22 : i32) {loop_annotation = #loop_annotation1}]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
  ^bb7:  // pred: ^bb3
    %23 = llvm.add %5, %1 overflow<nsw, nuw>  : i32
    llvm.br ^bb2(%23 : i32) {loop_annotation = #loop_annotation2}]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
  ^bb8:  // pred: ^bb2
    %24 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.br ^bb1(%24 : i32) {loop_annotation = #loop_annotation3}]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
  ^bb9:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
