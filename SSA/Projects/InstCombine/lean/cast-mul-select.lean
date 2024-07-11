import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cast-mul-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mul_before := [llvmfunc|
  llvm.func @mul(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.trunc %arg0 : i32 to i8
    %1 = llvm.trunc %arg1 : i32 to i8
    %2 = llvm.mul %0, %1  : i8
    %3 = llvm.zext %2 : i8 to i32
    llvm.return %3 : i32
  }]

def select1_before := [llvmfunc|
  llvm.func @select1(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.trunc %arg1 : i32 to i8
    %1 = llvm.trunc %arg2 : i32 to i8
    %2 = llvm.trunc %arg3 : i32 to i8
    %3 = llvm.add %0, %1  : i8
    %4 = llvm.select %arg0, %2, %3 : i1, i8
    %5 = llvm.zext %4 : i8 to i32
    llvm.return %5 : i32
  }]

def select2_before := [llvmfunc|
  llvm.func @select2(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.zext %arg1 : i8 to i32
    %1 = llvm.zext %arg2 : i8 to i32
    %2 = llvm.zext %arg3 : i8 to i32
    %3 = llvm.add %0, %1  : i32
    %4 = llvm.select %arg0, %2, %3 : i1, i32
    %5 = llvm.trunc %4 : i32 to i8
    llvm.return %5 : i8
  }]

def eval_trunc_multi_use_in_one_inst_before := [llvmfunc|
  llvm.func @eval_trunc_multi_use_in_one_inst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i64
    %3 = llvm.mul %2, %2  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }]

def eval_zext_multi_use_in_one_inst_before := [llvmfunc|
  llvm.func @eval_zext_multi_use_in_one_inst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.and %1, %0  : i16
    %3 = llvm.mul %2, %2 overflow<nsw, nuw>  : i16
    %4 = llvm.zext %3 : i16 to i32
    llvm.return %4 : i32
  }]

def eval_sext_multi_use_in_one_inst_before := [llvmfunc|
  llvm.func @eval_sext_multi_use_in_one_inst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(14 : i16) : i16
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.and %2, %0  : i16
    %4 = llvm.mul %3, %3 overflow<nsw, nuw>  : i16
    %5 = llvm.or %4, %1  : i16
    %6 = llvm.sext %5 : i16 to i32
    llvm.return %6 : i32
  }]

def PR36225_before := [llvmfunc|
  llvm.func @PR36225(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: i3, %arg4: i3) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(4 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "eq" %arg1, %0 : i32
    llvm.cond_br %arg2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.switch %arg3 : i3, ^bb6 [
      0: ^bb4(%4 : i8),
      7: ^bb4(%4 : i8)
    ]
  ^bb3:  // pred: ^bb1
    llvm.switch %arg4 : i3, ^bb6 [
      0: ^bb4(%1 : i8),
      7: ^bb4(%1 : i8)
    ]
  ^bb4(%5: i8):  // 4 preds: ^bb2, ^bb2, ^bb3, ^bb3
    %6 = llvm.sext %5 : i8 to i32
    %7 = llvm.icmp "sgt" %arg0, %6 : i32
    llvm.cond_br %7, ^bb6, ^bb5
  ^bb5:  // pred: ^bb4
    llvm.unreachable
  ^bb6:  // 3 preds: ^bb2, ^bb3, ^bb4
    llvm.unreachable
  }]

def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i1 {llvm.zeroext}) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i8
    llvm.return %arg0 : i1
  }]

def mul_combined := [llvmfunc|
  llvm.func @mul(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mul %arg0, %arg1  : i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_mul   : mul_before  ⊑  mul_combined := by
  unfold mul_before mul_combined
  simp_alive_peephole
  sorry
def select1_combined := [llvmfunc|
  llvm.func @select1(%arg0: i1, %arg1: i32, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.add %arg1, %arg2  : i32
    %2 = llvm.select %arg0, %arg3, %1 : i1, i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_select1   : select1_before  ⊑  select1_combined := by
  unfold select1_before select1_combined
  simp_alive_peephole
  sorry
def select2_combined := [llvmfunc|
  llvm.func @select2(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2  : i8
    %1 = llvm.select %arg0, %arg3, %0 : i1, i8
    llvm.return %1 : i8
  }]

theorem inst_combine_select2   : select2_before  ⊑  select2_combined := by
  unfold select2_before select2_combined
  simp_alive_peephole
  sorry
def eval_trunc_multi_use_in_one_inst_combined := [llvmfunc|
  llvm.func @eval_trunc_multi_use_in_one_inst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i64
    %3 = llvm.mul %2, %2  : i64
    %4 = llvm.trunc %3 : i64 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_eval_trunc_multi_use_in_one_inst   : eval_trunc_multi_use_in_one_inst_before  ⊑  eval_trunc_multi_use_in_one_inst_combined := by
  unfold eval_trunc_multi_use_in_one_inst_before eval_trunc_multi_use_in_one_inst_combined
  simp_alive_peephole
  sorry
def eval_zext_multi_use_in_one_inst_combined := [llvmfunc|
  llvm.func @eval_zext_multi_use_in_one_inst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.and %1, %0  : i16
    %3 = llvm.mul %2, %2 overflow<nsw, nuw>  : i16
    %4 = llvm.zext %3 : i16 to i32
    llvm.return %4 : i32
  }]

theorem inst_combine_eval_zext_multi_use_in_one_inst   : eval_zext_multi_use_in_one_inst_before  ⊑  eval_zext_multi_use_in_one_inst_combined := by
  unfold eval_zext_multi_use_in_one_inst_before eval_zext_multi_use_in_one_inst_combined
  simp_alive_peephole
  sorry
def eval_sext_multi_use_in_one_inst_combined := [llvmfunc|
  llvm.func @eval_sext_multi_use_in_one_inst(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(14 : i16) : i16
    %1 = llvm.mlir.constant(-32768 : i16) : i16
    %2 = llvm.trunc %arg0 : i32 to i16
    %3 = llvm.and %2, %0  : i16
    %4 = llvm.mul %3, %3 overflow<nsw, nuw>  : i16
    %5 = llvm.or %4, %1  : i16
    %6 = llvm.sext %5 : i16 to i32
    llvm.return %6 : i32
  }]

theorem inst_combine_eval_sext_multi_use_in_one_inst   : eval_sext_multi_use_in_one_inst_before  ⊑  eval_sext_multi_use_in_one_inst_combined := by
  unfold eval_sext_multi_use_in_one_inst_before eval_sext_multi_use_in_one_inst_combined
  simp_alive_peephole
  sorry
def PR36225_combined := [llvmfunc|
  llvm.func @PR36225(%arg0: i32, %arg1: i32, %arg2: i1, %arg3: i3, %arg4: i3) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %3 = llvm.icmp "eq" %arg1, %1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i8
    llvm.switch %arg3 : i3, ^bb6 [
      0: ^bb4(%4 : i8),
      7: ^bb4(%4 : i8)
    ]
  ^bb3:  // pred: ^bb1
    llvm.switch %arg4 : i3, ^bb6 [
      0: ^bb4(%0 : i8),
      7: ^bb4(%0 : i8)
    ]
  ^bb4(%5: i8):  // 4 preds: ^bb2, ^bb2, ^bb3, ^bb3
    %6 = llvm.zext %5 : i8 to i32
    %7 = llvm.icmp "slt" %6, %arg0 : i32
    llvm.cond_br %7, ^bb6, ^bb5
  ^bb5:  // pred: ^bb4
    llvm.unreachable
  ^bb6:  // 3 preds: ^bb2, ^bb3, ^bb4
    llvm.unreachable
  }]

theorem inst_combine_PR36225   : PR36225_before  ⊑  PR36225_combined := by
  unfold PR36225_before PR36225_combined
  simp_alive_peephole
  sorry
def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i1 {llvm.zeroext}) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
