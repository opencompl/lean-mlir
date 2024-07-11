import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr27996
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @cmp : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.addressof @resf : !llvm.ptr
    %5 = llvm.mlir.addressof @resi : !llvm.ptr
    %6 = llvm.mlir.constant(1.100000e+00 : f32) : f32
    %7 = llvm.mlir.addressof @f : !llvm.ptr
    %8 = llvm.mlir.addressof @i : !llvm.ptr
    llvm.br ^bb1(%0 : !llvm.ptr)
  ^bb1(%9: !llvm.ptr):  // 3 preds: ^bb0, ^bb3, ^bb4
    %10 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %11 = llvm.ashr %10, %3  : i32
    llvm.store %11, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %12 = llvm.icmp "ne" %11, %1 : i32
    llvm.cond_br %12, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %13 = llvm.and %11, %3  : i32
    %14 = llvm.icmp "ne" %13, %1 : i32
    llvm.cond_br %14, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb1(%8 : !llvm.ptr)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%7 : !llvm.ptr)
  ^bb5:  // pred: ^bb1
    llvm.store %9, %4 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.store %9, %5 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return %1 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @cmp : !llvm.ptr
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.addressof @i : !llvm.ptr
    %6 = llvm.mlir.constant(1.100000e+00 : f32) : f32
    %7 = llvm.mlir.addressof @f : !llvm.ptr
    %8 = llvm.mlir.addressof @resf : !llvm.ptr
    %9 = llvm.mlir.addressof @resi : !llvm.ptr
    llvm.br ^bb1(%0 : !llvm.ptr)
  ^bb1(%10: !llvm.ptr):  // 3 preds: ^bb0, ^bb3, ^bb4
    %11 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %12 = llvm.ashr %11, %3  : i32
    llvm.store %12, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %13 = llvm.icmp "ult" %11, %4 : i32
    llvm.cond_br %13, ^bb5, ^bb2
  ^bb2:  // pred: ^bb1
    %14 = llvm.and %11, %4  : i32
    %15 = llvm.icmp "eq" %14, %1 : i32
    llvm.cond_br %15, ^bb4, ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb1(%5 : !llvm.ptr)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb1(%7 : !llvm.ptr)
  ^bb5:  // pred: ^bb1
    llvm.store %10, %8 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %10, %9 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %1 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
