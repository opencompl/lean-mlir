import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sdiv-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sdiv_exact_eq_0_before := [llvmfunc|
  llvm.func @sdiv_exact_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def udiv_exact_ne_0_before := [llvmfunc|
  llvm.func @udiv_exact_ne_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def sdiv_exact_ne_1_before := [llvmfunc|
  llvm.func @sdiv_exact_ne_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def udiv_exact_eq_1_before := [llvmfunc|
  llvm.func @udiv_exact_eq_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def sdiv_exact_eq_9_no_of_before := [llvmfunc|
  llvm.func @sdiv_exact_eq_9_no_of(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.sdiv %arg0, %2  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def sdiv_exact_eq_9_may_of_before := [llvmfunc|
  llvm.func @sdiv_exact_eq_9_may_of(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(9 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def sdiv_exact_eq_9_no_of_fail_multiuse_before := [llvmfunc|
  llvm.func @sdiv_exact_eq_9_no_of_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.sdiv %arg0, %2  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def sdiv_exact_eq_9_must_of_todo_is_false_before := [llvmfunc|
  llvm.func @sdiv_exact_eq_9_must_of_todo_is_false(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(55 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.sdiv %arg0, %2  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

def udiv_exact_ne_30_no_of_before := [llvmfunc|
  llvm.func @udiv_exact_ne_30_no_of(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(30 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.udiv %arg0, %2  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    llvm.return %4 : i1
  }]

def sdiv_exact_eq_0_combined := [llvmfunc|
  llvm.func @sdiv_exact_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sdiv_exact_eq_0   : sdiv_exact_eq_0_before  ⊑  sdiv_exact_eq_0_combined := by
  unfold sdiv_exact_eq_0_before sdiv_exact_eq_0_combined
  simp_alive_peephole
  sorry
def udiv_exact_ne_0_combined := [llvmfunc|
  llvm.func @udiv_exact_ne_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_udiv_exact_ne_0   : udiv_exact_ne_0_before  ⊑  udiv_exact_ne_0_combined := by
  unfold udiv_exact_ne_0_before udiv_exact_ne_0_combined
  simp_alive_peephole
  sorry
def sdiv_exact_ne_1_combined := [llvmfunc|
  llvm.func @sdiv_exact_ne_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sdiv_exact_ne_1   : sdiv_exact_ne_1_before  ⊑  sdiv_exact_ne_1_combined := by
  unfold sdiv_exact_ne_1_before sdiv_exact_ne_1_combined
  simp_alive_peephole
  sorry
def udiv_exact_eq_1_combined := [llvmfunc|
  llvm.func @udiv_exact_eq_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_udiv_exact_eq_1   : udiv_exact_eq_1_before  ⊑  udiv_exact_eq_1_combined := by
  unfold udiv_exact_eq_1_before udiv_exact_eq_1_combined
  simp_alive_peephole
  sorry
def sdiv_exact_eq_9_no_of_combined := [llvmfunc|
  llvm.func @sdiv_exact_eq_9_no_of(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.mul %2, %1 overflow<nsw, nuw>  : i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_sdiv_exact_eq_9_no_of   : sdiv_exact_eq_9_no_of_before  ⊑  sdiv_exact_eq_9_no_of_combined := by
  unfold sdiv_exact_eq_9_no_of_before sdiv_exact_eq_9_no_of_combined
  simp_alive_peephole
  sorry
def sdiv_exact_eq_9_may_of_combined := [llvmfunc|
  llvm.func @sdiv_exact_eq_9_may_of(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(9 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_sdiv_exact_eq_9_may_of   : sdiv_exact_eq_9_may_of_before  ⊑  sdiv_exact_eq_9_may_of_combined := by
  unfold sdiv_exact_eq_9_may_of_before sdiv_exact_eq_9_may_of_combined
  simp_alive_peephole
  sorry
def sdiv_exact_eq_9_no_of_fail_multiuse_combined := [llvmfunc|
  llvm.func @sdiv_exact_eq_9_no_of_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.sdiv %arg0, %2  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_sdiv_exact_eq_9_no_of_fail_multiuse   : sdiv_exact_eq_9_no_of_fail_multiuse_before  ⊑  sdiv_exact_eq_9_no_of_fail_multiuse_combined := by
  unfold sdiv_exact_eq_9_no_of_fail_multiuse_before sdiv_exact_eq_9_no_of_fail_multiuse_combined
  simp_alive_peephole
  sorry
def sdiv_exact_eq_9_must_of_todo_is_false_combined := [llvmfunc|
  llvm.func @sdiv_exact_eq_9_must_of_todo_is_false(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(55 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.sdiv %arg0, %2  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_sdiv_exact_eq_9_must_of_todo_is_false   : sdiv_exact_eq_9_must_of_todo_is_false_before  ⊑  sdiv_exact_eq_9_must_of_todo_is_false_combined := by
  unfold sdiv_exact_eq_9_must_of_todo_is_false_before sdiv_exact_eq_9_must_of_todo_is_false_combined
  simp_alive_peephole
  sorry
def udiv_exact_ne_30_no_of_combined := [llvmfunc|
  llvm.func @udiv_exact_ne_30_no_of(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(30 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.mul %2, %1 overflow<nuw>  : i8
    %4 = llvm.icmp "ne" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_udiv_exact_ne_30_no_of   : udiv_exact_ne_30_no_of_before  ⊑  udiv_exact_ne_30_no_of_combined := by
  unfold udiv_exact_ne_30_no_of_before udiv_exact_ne_30_no_of_combined
  simp_alive_peephole
  sorry
