import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  assume-align
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f1_before := [llvmfunc|
  llvm.func @f1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(1 : i8) : i8
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.and %7, %1  : i64
    %9 = llvm.icmp "eq" %8, %2 : i64
    llvm.cond_br %9, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    "llvm.intr.assume"(%3) : (i1) -> ()
    %10 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %11 = llvm.and %10, %1  : i64
    %12 = llvm.icmp "eq" %11, %2 : i64
    llvm.cond_br %12, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.store %5, %6 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb4
  ^bb3:  // pred: ^bb1
    llvm.store %4, %6 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return
  }]

def f2_before := [llvmfunc|
  llvm.func @f2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(15 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i8) : i8
    %5 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.assume"(%0) : (i1) -> ()
    %6 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.and %7, %2  : i64
    %9 = llvm.icmp "eq" %8, %3 : i64
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %5, %6 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %4, %6 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }]

def f3_before := [llvmfunc|
  llvm.func @f3(%arg0: i64, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    "llvm.intr.assume"(%0) : (i1) -> ()
    %2 = llvm.add %arg0, %1  : i64
    llvm.call @g(%2) : (i64) -> ()
    llvm.return
  }]

def assume_align_zero_before := [llvmfunc|
  llvm.func @assume_align_zero(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %1 : i8
  }]

def assume_align_non_pow2_before := [llvmfunc|
  llvm.func @assume_align_non_pow2(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %1 : i8
  }]

def f1_combined := [llvmfunc|
  llvm.func @f1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.and %6, %1  : i64
    %8 = llvm.icmp "eq" %7, %2 : i64
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    "llvm.intr.assume"(%3) : (i1) -> ()
    llvm.store %4, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }]

theorem inst_combine_f1   : f1_before  ⊑  f1_combined := by
  unfold f1_before f1_combined
  simp_alive_peephole
  sorry
def f2_combined := [llvmfunc|
  llvm.func @f2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.assume"(%0) : (i1) -> ()
    %5 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.and %6, %1  : i64
    %8 = llvm.icmp "eq" %7, %2 : i64
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %4, %5 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %3, %5 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }]

theorem inst_combine_f2   : f2_before  ⊑  f2_combined := by
  unfold f2_before f2_combined
  simp_alive_peephole
  sorry
def f3_combined := [llvmfunc|
  llvm.func @f3(%arg0: i64, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    "llvm.intr.assume"(%0) : (i1) -> ()
    %2 = llvm.add %1, %arg0  : i64
    llvm.call @g(%2) : (i64) -> ()
    llvm.return
  }]

theorem inst_combine_f3   : f3_before  ⊑  f3_combined := by
  unfold f3_before f3_combined
  simp_alive_peephole
  sorry
def assume_align_zero_combined := [llvmfunc|
  llvm.func @assume_align_zero(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_assume_align_zero   : assume_align_zero_before  ⊑  assume_align_zero_combined := by
  unfold assume_align_zero_before assume_align_zero_combined
  simp_alive_peephole
  sorry
def assume_align_non_pow2_combined := [llvmfunc|
  llvm.func @assume_align_non_pow2(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %1 : i8
  }]

theorem inst_combine_assume_align_non_pow2   : assume_align_non_pow2_before  ⊑  assume_align_non_pow2_combined := by
  unfold assume_align_non_pow2_before assume_align_non_pow2_combined
  simp_alive_peephole
  sorry
