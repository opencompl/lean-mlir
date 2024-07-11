import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  xor-of-icmps-with-extra-uses
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def v0_select_of_consts_before := [llvmfunc|
  llvm.func @v0_select_of_consts(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %1 : i1, i32
    llvm.store %4, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }]

def v1_select_of_var_and_const_before := [llvmfunc|
  llvm.func @v1_select_of_var_and_const(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }]

def v2_select_of_const_and_var_before := [llvmfunc|
  llvm.func @v2_select_of_const_and_var(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %arg1 : i1, i32
    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }]

def v3_branch_before := [llvmfunc|
  llvm.func @v3_branch(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %5 = llvm.xor %3, %4  : i1
    llvm.return %5 : i1
  }]

def v4_not_store_before := [llvmfunc|
  llvm.func @v4_not_store(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(-32768 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.xor %3, %1  : i1
    llvm.store %4, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.select %3, %0, %2 : i1, i32
    %7 = llvm.xor %3, %5  : i1
    llvm.return %7 : i1
  }]

def v5_select_and_not_before := [llvmfunc|
  llvm.func @v5_select_and_not(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.select %3, %0, %arg1 : i1, i32
    %6 = llvm.xor %3, %2  : i1
    llvm.store %6, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.xor %3, %4  : i1
    llvm.return %7 : i1
  }]

def n6_select_and_not_before := [llvmfunc|
  llvm.func @n6_select_and_not(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %arg1 : i1, i32
    llvm.store %2, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr]

    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }]

def n7_store_before := [llvmfunc|
  llvm.func @n7_store(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr]

    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %1 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }]

def v0_select_of_consts_combined := [llvmfunc|
  llvm.func @v0_select_of_consts(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    llvm.store %4, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.add %arg0, %0  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_v0_select_of_consts   : v0_select_of_consts_before  ⊑  v0_select_of_consts_combined := by
  unfold v0_select_of_consts_before v0_select_of_consts_combined
  simp_alive_peephole
  sorry
def v1_select_of_var_and_const_combined := [llvmfunc|
  llvm.func @v1_select_of_var_and_const(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(32767 : i32) : i32
    %3 = llvm.mlir.constant(65535 : i32) : i32
    %4 = llvm.icmp "slt" %arg0, %0 : i32
    %5 = llvm.select %4, %1, %arg1 : i1, i32
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.add %arg0, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    llvm.return %7 : i1
  }]

theorem inst_combine_v1_select_of_var_and_const   : v1_select_of_var_and_const_before  ⊑  v1_select_of_var_and_const_combined := by
  unfold v1_select_of_var_and_const_before v1_select_of_var_and_const_combined
  simp_alive_peephole
  sorry
def v2_select_of_const_and_var_combined := [llvmfunc|
  llvm.func @v2_select_of_const_and_var(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(65535 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg1 : i1, i32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %4 = llvm.add %arg0, %0  : i32
    %5 = llvm.icmp "ult" %4, %1 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_v2_select_of_const_and_var   : v2_select_of_const_and_var_before  ⊑  v2_select_of_const_and_var_combined := by
  unfold v2_select_of_const_and_var_before v2_select_of_const_and_var_combined
  simp_alive_peephole
  sorry
def v3_branch_combined := [llvmfunc|
  llvm.func @v3_branch(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(32767 : i32) : i32
    %3 = llvm.mlir.constant(65535 : i32) : i32
    %4 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.cond_br %4, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %5 = llvm.add %arg0, %2  : i32
    %6 = llvm.icmp "ult" %5, %3 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_v3_branch   : v3_branch_before  ⊑  v3_branch_combined := by
  unfold v3_branch_before v3_branch_combined
  simp_alive_peephole
  sorry
def v4_not_store_combined := [llvmfunc|
  llvm.func @v4_not_store(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.store %3, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.icmp "ult" %4, %2 : i32
    llvm.return %5 : i1
  }]

theorem inst_combine_v4_not_store   : v4_not_store_before  ⊑  v4_not_store_combined := by
  unfold v4_not_store_before v4_not_store_combined
  simp_alive_peephole
  sorry
def v5_select_and_not_combined := [llvmfunc|
  llvm.func @v5_select_and_not(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.mlir.constant(65535 : i32) : i32
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %1 : i1, i32
    llvm.store %3, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.add %arg0, %1  : i32
    %6 = llvm.icmp "ult" %5, %2 : i32
    llvm.return %6 : i1
  }]

theorem inst_combine_v5_select_and_not   : v5_select_and_not_before  ⊑  v5_select_and_not_combined := by
  unfold v5_select_and_not_before v5_select_and_not_combined
  simp_alive_peephole
  sorry
def n6_select_and_not_combined := [llvmfunc|
  llvm.func @n6_select_and_not(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %arg1 : i1, i32
    llvm.store %2, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_n6_select_and_not   : n6_select_and_not_before  ⊑  n6_select_and_not_combined := by
  unfold n6_select_and_not_before n6_select_and_not_combined
  simp_alive_peephole
  sorry
def n7_store_combined := [llvmfunc|
  llvm.func @n7_store(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_n7_store   : n7_store_before  ⊑  n7_store_combined := by
  unfold n7_store_before n7_store_combined
  simp_alive_peephole
  sorry
