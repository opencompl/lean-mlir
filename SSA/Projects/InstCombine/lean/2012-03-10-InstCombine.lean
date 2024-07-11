import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-03-10-InstCombine
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def func_before := [llvmfunc|
  llvm.func @func(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["noinline", "nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %3 = llvm.icmp "ugt" %2, %arg0 : !llvm.ptr
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.icmp "ule" %2, %arg1 : !llvm.ptr
    %5 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    %6 = llvm.and %4, %5  : i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.br ^bb3(%7 : i32)
  ^bb2:  // pred: ^bb0
    %8 = llvm.icmp "uge" %2, %arg1 : !llvm.ptr
    %9 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %10 = llvm.and %8, %9  : i1
    %11 = llvm.zext %10 : i1 to i32
    llvm.br ^bb3(%11 : i32)
  ^bb3(%12: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %12 : i32
  }]

def func_logical_before := [llvmfunc|
  llvm.func @func_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["noinline", "nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

    %4 = llvm.icmp "ugt" %3, %arg0 : !llvm.ptr
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "ule" %3, %arg1 : !llvm.ptr
    %6 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    %7 = llvm.select %5, %6, %2 : i1, i1
    %8 = llvm.zext %7 : i1 to i32
    llvm.br ^bb3(%8 : i32)
  ^bb2:  // pred: ^bb0
    %9 = llvm.icmp "uge" %3, %arg1 : !llvm.ptr
    %10 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %11 = llvm.select %9, %10, %2 : i1, i1
    %12 = llvm.zext %11 : i1 to i32
    llvm.br ^bb3(%12 : i32)
  ^bb3(%13: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %13 : i32
  }]

def func_combined := [llvmfunc|
  llvm.func @func(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["noinline", "nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 1 : i64} : i8, !llvm.ptr
    %3 = llvm.icmp "ugt" %2, %arg0 : !llvm.ptr
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.icmp "ule" %2, %arg1 : !llvm.ptr
    %5 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    %6 = llvm.and %4, %5  : i1
    llvm.br ^bb3(%6 : i1)
  ^bb2:  // pred: ^bb0
    %7 = llvm.icmp "uge" %2, %arg1 : !llvm.ptr
    %8 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %9 = llvm.and %7, %8  : i1
    llvm.br ^bb3(%9 : i1)
  ^bb3(%10: i1):  // 2 preds: ^bb1, ^bb2
    %11 = llvm.zext %10 : i1 to i32
    llvm.return %11 : i32
  }]

theorem inst_combine_func   : func_before  ⊑  func_combined := by
  unfold func_before func_combined
  simp_alive_peephole
  sorry
def func_logical_combined := [llvmfunc|
  llvm.func @func_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["noinline", "nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 1 : i64} : i8, !llvm.ptr
    %3 = llvm.icmp "ugt" %2, %arg0 : !llvm.ptr
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.icmp "ule" %2, %arg1 : !llvm.ptr
    %5 = llvm.icmp "uge" %arg0, %arg1 : !llvm.ptr
    %6 = llvm.and %4, %5  : i1
    llvm.br ^bb3(%6 : i1)
  ^bb2:  // pred: ^bb0
    %7 = llvm.icmp "uge" %2, %arg1 : !llvm.ptr
    %8 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %9 = llvm.and %7, %8  : i1
    llvm.br ^bb3(%9 : i1)
  ^bb3(%10: i1):  // 2 preds: ^bb1, ^bb2
    %11 = llvm.zext %10 : i1 to i32
    llvm.return %11 : i32
  }]

theorem inst_combine_func_logical   : func_logical_before  ⊑  func_logical_combined := by
  unfold func_logical_before func_logical_combined
  simp_alive_peephole
  sorry
