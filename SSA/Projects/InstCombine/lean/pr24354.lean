import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr24354
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def fn3_before := [llvmfunc|
  llvm.func @fn3() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(255 : i32) : i32
    %5 = llvm.mlir.constant(254 : i32) : i32
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.mlir.addressof @d : !llvm.ptr
    %10 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %11 = llvm.icmp "eq" %10, %0 : i32
    llvm.cond_br %11, ^bb1, ^bb2(%2 : i1)
  ^bb1:  // pred: ^bb0
    %12 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %13 = llvm.add %4, %12 overflow<nsw>  : i32
    %14 = llvm.icmp "ugt" %13, %5 : i32
    llvm.br ^bb2(%14 : i1)
  ^bb2(%15: i1):  // 2 preds: ^bb0, ^bb1
    %16 = llvm.zext %15 : i1 to i32
    %17 = llvm.icmp "eq" %16, %0 : i32
    %18 = llvm.load %7 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %19 = llvm.icmp "ne" %18, %6 : i16
    %20 = llvm.select %17, %8, %19 : i1, i1
    %21 = llvm.zext %20 : i1 to i32
    llvm.store %21, %9 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def fn3_combined := [llvmfunc|
  llvm.func @fn3() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(-255 : i32) : i32
    %5 = llvm.mlir.constant(0 : i16) : i16
    %6 = llvm.mlir.addressof @a : !llvm.ptr
    %7 = llvm.mlir.constant(false) : i1
    %8 = llvm.mlir.addressof @d : !llvm.ptr
    %9 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_fn3   : fn3_before  ⊑  fn3_combined := by
  unfold fn3_before fn3_combined
  simp_alive_peephole
  sorry
    %10 = llvm.icmp "eq" %9, %0 : i32
    llvm.cond_br %10, ^bb1, ^bb2(%2 : i1)
  ^bb1:  // pred: ^bb0
    %11 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_fn3   : fn3_before  ⊑  fn3_combined := by
  unfold fn3_before fn3_combined
  simp_alive_peephole
  sorry
    %12 = llvm.icmp "ult" %11, %4 : i32
    llvm.br ^bb2(%12 : i1)
  ^bb2(%13: i1):  // 2 preds: ^bb0, ^bb1
    %14 = llvm.load %6 {alignment = 2 : i64} : !llvm.ptr -> i16]

theorem inst_combine_fn3   : fn3_before  ⊑  fn3_combined := by
  unfold fn3_before fn3_combined
  simp_alive_peephole
  sorry
    %15 = llvm.icmp "ne" %14, %5 : i16
    %16 = llvm.select %13, %15, %7 : i1, i1
    %17 = llvm.zext %16 : i1 to i32
    llvm.store %17, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_fn3   : fn3_before  ⊑  fn3_combined := by
  unfold fn3_before fn3_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_fn3   : fn3_before  ⊑  fn3_combined := by
  unfold fn3_before fn3_combined
  simp_alive_peephole
  sorry
