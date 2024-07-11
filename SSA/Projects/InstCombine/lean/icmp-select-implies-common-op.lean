import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-select-implies-common-op
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sgt_3_impliesF_eq_2_before := [llvmfunc|
  llvm.func @sgt_3_impliesF_eq_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def sgt_3_impliesT_sgt_2_before := [llvmfunc|
  llvm.func @sgt_3_impliesT_sgt_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "sgt" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

def sgt_x_impliesF_eq_smin_todo_before := [llvmfunc|
  llvm.func @sgt_x_impliesF_eq_smin_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg2 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def slt_x_impliesT_ne_smin_todo_before := [llvmfunc|
  llvm.func @slt_x_impliesT_ne_smin_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg2 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %arg0, %2 : i8
    llvm.return %3 : i1
  }]

def ult_x_impliesT_eq_umax_todo_before := [llvmfunc|
  llvm.func @ult_x_impliesT_eq_umax_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg2, %arg0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def ult_1_impliesF_eq_1_before := [llvmfunc|
  llvm.func @ult_1_impliesF_eq_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %arg0, %2 : i8
    llvm.return %3 : i1
  }]

def ugt_x_impliesF_eq_umin_todo_before := [llvmfunc|
  llvm.func @ugt_x_impliesF_eq_umin_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg2, %arg0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %arg0, %2 : i8
    llvm.return %3 : i1
  }]

def sgt_3_impliesF_eq_2_combined := [llvmfunc|
  llvm.func @sgt_3_impliesF_eq_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_sgt_3_impliesF_eq_2   : sgt_3_impliesF_eq_2_before  ⊑  sgt_3_impliesF_eq_2_combined := by
  unfold sgt_3_impliesF_eq_2_before sgt_3_impliesF_eq_2_combined
  simp_alive_peephole
  sorry
def sgt_3_impliesT_sgt_2_combined := [llvmfunc|
  llvm.func @sgt_3_impliesT_sgt_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "sgt" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_sgt_3_impliesT_sgt_2   : sgt_3_impliesT_sgt_2_before  ⊑  sgt_3_impliesT_sgt_2_combined := by
  unfold sgt_3_impliesT_sgt_2_before sgt_3_impliesT_sgt_2_combined
  simp_alive_peephole
  sorry
def sgt_x_impliesF_eq_smin_todo_combined := [llvmfunc|
  llvm.func @sgt_x_impliesF_eq_smin_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg2 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_x_impliesF_eq_smin_todo   : sgt_x_impliesF_eq_smin_todo_before  ⊑  sgt_x_impliesF_eq_smin_todo_combined := by
  unfold sgt_x_impliesF_eq_smin_todo_before sgt_x_impliesF_eq_smin_todo_combined
  simp_alive_peephole
  sorry
def slt_x_impliesT_ne_smin_todo_combined := [llvmfunc|
  llvm.func @slt_x_impliesT_ne_smin_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg2 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_x_impliesT_ne_smin_todo   : slt_x_impliesT_ne_smin_todo_before  ⊑  slt_x_impliesT_ne_smin_todo_combined := by
  unfold slt_x_impliesT_ne_smin_todo_before slt_x_impliesT_ne_smin_todo_combined
  simp_alive_peephole
  sorry
def ult_x_impliesT_eq_umax_todo_combined := [llvmfunc|
  llvm.func @ult_x_impliesT_eq_umax_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg2, %arg0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ult_x_impliesT_eq_umax_todo   : ult_x_impliesT_eq_umax_todo_before  ⊑  ult_x_impliesT_eq_umax_todo_combined := by
  unfold ult_x_impliesT_eq_umax_todo_before ult_x_impliesT_eq_umax_todo_combined
  simp_alive_peephole
  sorry
def ult_1_impliesF_eq_1_combined := [llvmfunc|
  llvm.func @ult_1_impliesF_eq_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_ult_1_impliesF_eq_1   : ult_1_impliesF_eq_1_before  ⊑  ult_1_impliesF_eq_1_combined := by
  unfold ult_1_impliesF_eq_1_before ult_1_impliesF_eq_1_combined
  simp_alive_peephole
  sorry
def ugt_x_impliesF_eq_umin_todo_combined := [llvmfunc|
  llvm.func @ugt_x_impliesF_eq_umin_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg2, %arg0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ugt_x_impliesF_eq_umin_todo   : ugt_x_impliesF_eq_umin_todo_before  ⊑  ugt_x_impliesF_eq_umin_todo_combined := by
  unfold ugt_x_impliesF_eq_umin_todo_before ugt_x_impliesF_eq_umin_todo_combined
  simp_alive_peephole
  sorry
