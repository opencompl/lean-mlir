import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr71330
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pr71330_before := [llvmfunc|
  llvm.func @pr71330(%arg0: i32, %arg1: i1, %arg2: i16) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.mlir.constant(true) : i1
    %6 = llvm.mlir.constant(0 : i64) : i64
    llvm.br ^bb1(%0 : i32)
  ^bb1(%7: i32):  // 2 preds: ^bb0, ^bb7
    %8 = llvm.and %7, %1  : i32
    %9 = llvm.add %7, %2  : i32
    %10 = llvm.icmp "eq" %8, %3 : i32
    %11 = llvm.icmp "eq" %9, %3 : i32
    %12 = llvm.and %7, %1  : i32
    %13 = llvm.icmp "eq" %12, %3 : i32
    %14 = llvm.icmp "eq" %9, %3 : i32
    %15 = llvm.select %14, %1, %4 : i1, i32
    llvm.cond_br %arg1, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    llvm.cond_br %10, ^bb3, ^bb4
  ^bb3:  // 2 preds: ^bb2, ^bb3
    %16 = llvm.select %13, %1, %15 : i1, i32
    %17 = llvm.select %11, %3, %16 : i1, i32
    %18 = llvm.add %17, %arg0  : i32
    %19 = llvm.sext %18 : i32 to i64
    %20 = llvm.icmp "slt" %19, %6 : i64
    llvm.cond_br %20, ^bb3, ^bb7
  ^bb4:  // pred: ^bb2
    llvm.return
  ^bb5:  // pred: ^bb1
    %21 = llvm.xor %10, %5  : i1
    %22 = llvm.select %21, %5, %11 : i1, i1
    %23 = llvm.select %13, %1, %15 : i1, i32
    %24 = llvm.select %22, %3, %23 : i1, i32
    %25 = llvm.add %24, %arg0  : i32
    %26 = llvm.sext %25 : i32 to i64
    %27 = llvm.icmp "slt" %26, %6 : i64
    llvm.cond_br %27, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.return
  ^bb7:  // 2 preds: ^bb3, ^bb5
    %28 = llvm.zext %arg2 : i16 to i32
    %29 = llvm.icmp "slt" %28, %3 : i32
    llvm.cond_br %29, ^bb1(%3 : i32), ^bb8
  ^bb8:  // pred: ^bb7
    llvm.return
  }]

def pr71330_combined := [llvmfunc|
  llvm.func @pr71330(%arg0: i32, %arg1: i1, %arg2: i16) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.constant(false) : i1
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb7
    llvm.cond_br %arg1, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    llvm.cond_br %1, ^bb4, ^bb3
  ^bb3:  // 2 preds: ^bb2, ^bb3
    llvm.cond_br %2, ^bb3, ^bb7
  ^bb4:  // pred: ^bb2
    llvm.return
  ^bb5:  // pred: ^bb1
    %4 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.cond_br %4, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.return
  ^bb7:  // 2 preds: ^bb3, ^bb5
    llvm.cond_br %3, ^bb1, ^bb8
  ^bb8:  // pred: ^bb7
    llvm.return
  }]

theorem inst_combine_pr71330   : pr71330_before  ⊑  pr71330_combined := by
  unfold pr71330_before pr71330_combined
  simp_alive_peephole
  sorry
