import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-imm-canon
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def single_before := [llvmfunc|
  llvm.func @single(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg0 : i1, i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }]

def double_before := [llvmfunc|
  llvm.func @double(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.select %5, %2, %4 : i1, i32
    %7 = llvm.trunc %6 : i32 to i8
    llvm.return %7 : i8
  }]

def thisdoesnotloop_before := [llvmfunc|
  llvm.func @thisdoesnotloop(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(128 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %arg1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }]

def original_before := [llvmfunc|
  llvm.func @original(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %0, %arg0 : i32
    %4 = llvm.icmp "sle" %1, %arg0 : i32
    %5 = llvm.select %3, %0, %1 : i1, i32
    %6 = llvm.xor %3, %2  : i1
    %7 = llvm.and %4, %6  : i1
    %8 = llvm.select %7, %arg0, %5 : i1, i32
    %9 = llvm.trunc %8 : i32 to i8
    llvm.return %9 : i8
  }]

def original_logical_before := [llvmfunc|
  llvm.func @original_logical(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "slt" %0, %arg0 : i32
    %5 = llvm.icmp "sle" %1, %arg0 : i32
    %6 = llvm.select %4, %0, %1 : i1, i32
    %7 = llvm.xor %4, %2  : i1
    %8 = llvm.select %5, %7, %3 : i1, i1
    %9 = llvm.select %8, %arg0, %6 : i1, i32
    %10 = llvm.trunc %9 : i32 to i8
    llvm.return %10 : i8
  }]

def PR49205_before := [llvmfunc|
  llvm.func @PR49205(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.undef : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %5 = llvm.add %arg0, %3  : i32
    %6 = llvm.add %5, %2 overflow<nsw>  : i32
    llvm.br ^bb1(%6 : i32)
  ^bb3:  // pred: ^bb1
    %7 = llvm.icmp "ne" %4, %1 : i32
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.and %4, %8  : i32
    %10 = llvm.sub %4, %9  : i32
    %11 = llvm.icmp "ne" %10, %1 : i32
    %12 = llvm.zext %11 : i1 to i32
    %13 = llvm.sub %12, %10  : i32
    %14 = llvm.and %13, %2  : i32
    llvm.return %14 : i32
  }]

def single_combined := [llvmfunc|
  llvm.func @single(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %2 = llvm.trunc %1 : i32 to i8
    llvm.return %2 : i8
  }]

theorem inst_combine_single   : single_before  ⊑  single_combined := by
  unfold single_before single_combined
  simp_alive_peephole
  sorry
def double_combined := [llvmfunc|
  llvm.func @double(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }]

theorem inst_combine_double   : double_before  ⊑  double_combined := by
  unfold double_before double_combined
  simp_alive_peephole
  sorry
def thisdoesnotloop_combined := [llvmfunc|
  llvm.func @thisdoesnotloop(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.trunc %arg1 : i32 to i8
    %4 = llvm.select %2, %1, %3 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_thisdoesnotloop   : thisdoesnotloop_before  ⊑  thisdoesnotloop_combined := by
  unfold thisdoesnotloop_before thisdoesnotloop_combined
  simp_alive_peephole
  sorry
def original_combined := [llvmfunc|
  llvm.func @original(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }]

theorem inst_combine_original   : original_before  ⊑  original_combined := by
  unfold original_before original_combined
  simp_alive_peephole
  sorry
def original_logical_combined := [llvmfunc|
  llvm.func @original_logical(%arg0: i32, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.return %4 : i8
  }]

theorem inst_combine_original_logical   : original_logical_before  ⊑  original_logical_combined := by
  unfold original_logical_before original_logical_combined
  simp_alive_peephole
  sorry
def PR49205_combined := [llvmfunc|
  llvm.func @PR49205(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb1
  ^bb3:  // pred: ^bb1
    llvm.return %0 : i32
  }]

theorem inst_combine_PR49205   : PR49205_before  ⊑  PR49205_combined := by
  unfold PR49205_before PR49205_combined
  simp_alive_peephole
  sorry
