import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr63791
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def y_before := [llvmfunc|
  llvm.func @y() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.addressof @j : !llvm.ptr
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(41 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(-1020499714 : i32) : i32
    %7 = llvm.mlir.constant(-1020499638 : i32) : i32
    %8 = llvm.mlir.zero : !llvm.ptr
    %9 = llvm.mlir.constant(0 : i64) : i64
    llvm.br ^bb1(%1 : !llvm.ptr)
  ^bb1(%10: !llvm.ptr):  // 3 preds: ^bb0, ^bb1, ^bb2
    %11 = llvm.load %10 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.cond_br %2, ^bb1(%1 : !llvm.ptr), ^bb3(%11 : i32)
  ^bb2:  // 2 preds: ^bb3, ^bb4
    %12 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %13 = llvm.sext %12 : i32 to i64
    %14 = llvm.icmp "eq" %9, %13 : i64
    llvm.cond_br %14, ^bb1(%8 : !llvm.ptr), ^bb3(%5 : i32)
  ^bb3(%15: i32):  // 2 preds: ^bb1, ^bb2
    %16 = llvm.or %11, %3  : i32
    %17 = llvm.icmp "sgt" %11, %4 : i32
    %18 = llvm.select %17, %16, %5 : i1, i32
    %19 = llvm.add %18, %3  : i32
    %20 = llvm.icmp "sgt" %18, %5 : i32
    %21 = llvm.select %20, %19, %5 : i1, i32
    %22 = llvm.icmp "eq" %19, %5 : i32
    %23 = llvm.or %19, %16  : i32
    %24 = llvm.icmp "sgt" %23, %5 : i32
    %25 = llvm.select %17, %24, %2 : i1, i1
    %26 = llvm.select %25, %5, %21 : i1, i32
    %27 = llvm.select %22, %5, %26 : i1, i32
    %28 = llvm.or %27, %6  : i32
    %29 = llvm.icmp "sgt" %28, %7 : i32
    llvm.cond_br %29, ^bb4, ^bb2
  ^bb4:  // 2 preds: ^bb3, ^bb4
    llvm.cond_br %25, ^bb4, ^bb2
  }]

def y_combined := [llvmfunc|
  llvm.func @y() {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.poison : !llvm.ptr
    %3 = llvm.mlir.poison : i1
    llvm.br ^bb1
  ^bb1:  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.cond_br %0, ^bb1, ^bb3
  ^bb2:  // 2 preds: ^bb3, ^bb4
    llvm.store %1, %2 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.cond_br %0, ^bb4, ^bb2
  ^bb4:  // 2 preds: ^bb3, ^bb4
    llvm.cond_br %0, ^bb4, ^bb2
  }]

theorem inst_combine_y   : y_before  ⊑  y_combined := by
  unfold y_before y_combined
  simp_alive_peephole
  sorry
