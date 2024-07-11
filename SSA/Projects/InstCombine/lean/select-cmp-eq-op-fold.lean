import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-cmp-eq-op-fold
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def replace_with_y_noundef_before := [llvmfunc|
  llvm.func @replace_with_y_noundef(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.and %arg0, %arg1  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

def replace_with_x_noundef_before := [llvmfunc|
  llvm.func @replace_with_x_noundef(%arg0: i8 {llvm.noundef}, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use.i1(%0) : (i1) -> ()
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.select %0, %arg2, %1 : i1, i8
    llvm.return %2 : i8
  }]

def replace_with_x_maybe_undef_fail_before := [llvmfunc|
  llvm.func @replace_with_x_maybe_undef_fail(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use.i1(%0) : (i1) -> ()
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.select %0, %arg2, %1 : i1, i8
    llvm.return %2 : i8
  }]

def replace_with_y_for_new_oneuse_before := [llvmfunc|
  llvm.func @replace_with_y_for_new_oneuse(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    %3 = llvm.add %1, %arg1 overflow<nuw>  : i8
    %4 = llvm.select %2, %3, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

def replace_with_y_for_new_oneuse2_before := [llvmfunc|
  llvm.func @replace_with_y_for_new_oneuse2(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    %3 = llvm.add %1, %arg3 overflow<nuw>  : i8
    %4 = llvm.select %2, %3, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

def replace_with_x_for_new_oneuse_before := [llvmfunc|
  llvm.func @replace_with_x_for_new_oneuse(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.add %arg1, %arg3  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    %4 = llvm.mul %1, %2  : i8
    %5 = llvm.select %3, %4, %arg2 : i1, i8
    llvm.return %5 : i8
  }]

def replace_with_x_for_new_oneuse2_before := [llvmfunc|
  llvm.func @replace_with_x_for_new_oneuse2(%arg0: i8 {llvm.noundef}, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.add %arg1, %arg3  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    %4 = llvm.mul %arg4, %2  : i8
    %5 = llvm.select %3, %4, %arg2 : i1, i8
    llvm.return %5 : i8
  }]

def replace_with_x_for_simple_binop_before := [llvmfunc|
  llvm.func @replace_with_x_for_simple_binop(%arg0: i8 {llvm.noundef}, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.add %arg1, %arg3  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    %4 = llvm.mul %1, %2  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %5 = llvm.select %3, %4, %arg2 : i1, i8
    llvm.return %5 : i8
  }]

def replace_with_none_for_new_oneuse_fail_maybe_undef_before := [llvmfunc|
  llvm.func @replace_with_none_for_new_oneuse_fail_maybe_undef(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    %3 = llvm.mul %1, %arg1  : i8
    %4 = llvm.select %2, %3, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

def replace_with_y_for_simple_binop_before := [llvmfunc|
  llvm.func @replace_with_y_for_simple_binop(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

def replace_with_y_for_simple_binop_fail_multiuse_before := [llvmfunc|
  llvm.func @replace_with_y_for_simple_binop_fail_multiuse(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.call @use.i8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

def replace_with_y_for_simple_binop_fail_before := [llvmfunc|
  llvm.func @replace_with_y_for_simple_binop_fail(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.mul %arg0, %arg3 overflow<nsw>  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

def replace_with_y_noundef_combined := [llvmfunc|
  llvm.func @replace_with_y_noundef(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.and %arg0, %arg1  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_replace_with_y_noundef   : replace_with_y_noundef_before  ⊑  replace_with_y_noundef_combined := by
  unfold replace_with_y_noundef_before replace_with_y_noundef_combined
  simp_alive_peephole
  sorry
def replace_with_x_noundef_combined := [llvmfunc|
  llvm.func @replace_with_x_noundef(%arg0: i8 {llvm.noundef}, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use.i1(%0) : (i1) -> ()
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.select %0, %arg2, %1 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_replace_with_x_noundef   : replace_with_x_noundef_before  ⊑  replace_with_x_noundef_combined := by
  unfold replace_with_x_noundef_before replace_with_x_noundef_combined
  simp_alive_peephole
  sorry
def replace_with_x_maybe_undef_fail_combined := [llvmfunc|
  llvm.func @replace_with_x_maybe_undef_fail(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use.i1(%0) : (i1) -> ()
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.select %0, %arg2, %1 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_replace_with_x_maybe_undef_fail   : replace_with_x_maybe_undef_fail_before  ⊑  replace_with_x_maybe_undef_fail_combined := by
  unfold replace_with_x_maybe_undef_fail_before replace_with_x_maybe_undef_fail_combined
  simp_alive_peephole
  sorry
def replace_with_y_for_new_oneuse_combined := [llvmfunc|
  llvm.func @replace_with_y_for_new_oneuse(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    %3 = llvm.add %1, %arg1 overflow<nuw>  : i8
    %4 = llvm.select %2, %3, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_replace_with_y_for_new_oneuse   : replace_with_y_for_new_oneuse_before  ⊑  replace_with_y_for_new_oneuse_combined := by
  unfold replace_with_y_for_new_oneuse_before replace_with_y_for_new_oneuse_combined
  simp_alive_peephole
  sorry
def replace_with_y_for_new_oneuse2_combined := [llvmfunc|
  llvm.func @replace_with_y_for_new_oneuse2(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    %3 = llvm.add %1, %arg3 overflow<nuw>  : i8
    %4 = llvm.select %2, %3, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_replace_with_y_for_new_oneuse2   : replace_with_y_for_new_oneuse2_before  ⊑  replace_with_y_for_new_oneuse2_combined := by
  unfold replace_with_y_for_new_oneuse2_before replace_with_y_for_new_oneuse2_combined
  simp_alive_peephole
  sorry
def replace_with_x_for_new_oneuse_combined := [llvmfunc|
  llvm.func @replace_with_x_for_new_oneuse(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.add %arg1, %arg3  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    %4 = llvm.mul %1, %2  : i8
    %5 = llvm.select %3, %4, %arg2 : i1, i8
    llvm.return %5 : i8
  }]

theorem inst_combine_replace_with_x_for_new_oneuse   : replace_with_x_for_new_oneuse_before  ⊑  replace_with_x_for_new_oneuse_combined := by
  unfold replace_with_x_for_new_oneuse_before replace_with_x_for_new_oneuse_combined
  simp_alive_peephole
  sorry
def replace_with_x_for_new_oneuse2_combined := [llvmfunc|
  llvm.func @replace_with_x_for_new_oneuse2(%arg0: i8 {llvm.noundef}, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.add %arg1, %arg3  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    %4 = llvm.mul %2, %arg4  : i8
    %5 = llvm.select %3, %4, %arg2 : i1, i8
    llvm.return %5 : i8
  }]

theorem inst_combine_replace_with_x_for_new_oneuse2   : replace_with_x_for_new_oneuse2_before  ⊑  replace_with_x_for_new_oneuse2_combined := by
  unfold replace_with_x_for_new_oneuse2_before replace_with_x_for_new_oneuse2_combined
  simp_alive_peephole
  sorry
def replace_with_x_for_simple_binop_combined := [llvmfunc|
  llvm.func @replace_with_x_for_simple_binop(%arg0: i8 {llvm.noundef}, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.add %arg1, %arg3  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    %4 = llvm.mul %1, %2  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %5 = llvm.select %3, %4, %arg2 : i1, i8
    llvm.return %5 : i8
  }]

theorem inst_combine_replace_with_x_for_simple_binop   : replace_with_x_for_simple_binop_before  ⊑  replace_with_x_for_simple_binop_combined := by
  unfold replace_with_x_for_simple_binop_before replace_with_x_for_simple_binop_combined
  simp_alive_peephole
  sorry
def replace_with_none_for_new_oneuse_fail_maybe_undef_combined := [llvmfunc|
  llvm.func @replace_with_none_for_new_oneuse_fail_maybe_undef(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    %3 = llvm.mul %1, %arg1  : i8
    %4 = llvm.select %2, %3, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_replace_with_none_for_new_oneuse_fail_maybe_undef   : replace_with_none_for_new_oneuse_fail_maybe_undef_before  ⊑  replace_with_none_for_new_oneuse_fail_maybe_undef_combined := by
  unfold replace_with_none_for_new_oneuse_fail_maybe_undef_before replace_with_none_for_new_oneuse_fail_maybe_undef_combined
  simp_alive_peephole
  sorry
def replace_with_y_for_simple_binop_combined := [llvmfunc|
  llvm.func @replace_with_y_for_simple_binop(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_replace_with_y_for_simple_binop   : replace_with_y_for_simple_binop_before  ⊑  replace_with_y_for_simple_binop_combined := by
  unfold replace_with_y_for_simple_binop_before replace_with_y_for_simple_binop_combined
  simp_alive_peephole
  sorry
def replace_with_y_for_simple_binop_fail_multiuse_combined := [llvmfunc|
  llvm.func @replace_with_y_for_simple_binop_fail_multiuse(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.call @use.i8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }]

theorem inst_combine_replace_with_y_for_simple_binop_fail_multiuse   : replace_with_y_for_simple_binop_fail_multiuse_before  ⊑  replace_with_y_for_simple_binop_fail_multiuse_combined := by
  unfold replace_with_y_for_simple_binop_fail_multiuse_before replace_with_y_for_simple_binop_fail_multiuse_combined
  simp_alive_peephole
  sorry
def replace_with_y_for_simple_binop_fail_combined := [llvmfunc|
  llvm.func @replace_with_y_for_simple_binop_fail(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.mul %arg0, %arg3 overflow<nsw>  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.return %2 : i8
  }]

theorem inst_combine_replace_with_y_for_simple_binop_fail   : replace_with_y_for_simple_binop_fail_before  ⊑  replace_with_y_for_simple_binop_fail_combined := by
  unfold replace_with_y_for_simple_binop_fail_before replace_with_y_for_simple_binop_fail_combined
  simp_alive_peephole
  sorry
