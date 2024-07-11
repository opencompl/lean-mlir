import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-05-28-select-hang
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_before := [llvmfunc|
  llvm.func @func() attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.addressof @a : !llvm.ptr
    %4 = llvm.mlir.constant(-1 : i32) : i32
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(false) : i1
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %10 = llvm.zext %9 : i8 to i32
    %11 = llvm.or %10, %2  : i32
    %12 = llvm.trunc %11 : i32 to i8
    llvm.store %12, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

    %13 = llvm.zext %12 : i8 to i32
    %14 = llvm.xor %13, %4  : i32
    %15 = llvm.and %2, %14  : i32
    %16 = llvm.trunc %15 : i32 to i8
    llvm.store %16, %5 {alignment = 1 : i64} : i8, !llvm.ptr]

    %17 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %18 = llvm.zext %17 : i8 to i32
    %19 = llvm.zext %16 : i8 to i32
    %20 = llvm.icmp "ne" %18, %6 : i32
    llvm.cond_br %20, ^bb1, ^bb2(%7 : i1)
  ^bb1:  // pred: ^bb0
    %21 = llvm.icmp "ne" %19, %6 : i32
    llvm.br ^bb2(%21 : i1)
  ^bb2(%22: i1):  // 2 preds: ^bb0, ^bb1
    %23 = llvm.zext %22 : i1 to i32
    %24 = llvm.mul %8, %23 overflow<nsw>  : i32
    %25 = llvm.trunc %24 : i32 to i8
    llvm.store %25, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.return
  }]

def func_combined := [llvmfunc|
  llvm.func @func() attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.addressof @a : !llvm.ptr
    %4 = llvm.mlir.addressof @b : !llvm.ptr
    %5 = llvm.mlir.constant(true) : i1
    %6 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i8
    %7 = llvm.or %6, %2  : i8
    llvm.store %7, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %0, %4 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.store %0, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
