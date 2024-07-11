import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  implies
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def or_implies_sle_before := [llvmfunc|
  llvm.func @or_implies_sle(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "sle" %1, %arg1 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def or_implies_sle_fail_before := [llvmfunc|
  llvm.func @or_implies_sle_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-34 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "sle" %1, %arg1 : i8
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def or_distjoint_implies_ule_before := [llvmfunc|
  llvm.func @or_distjoint_implies_ule(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.icmp "ule" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "ule" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def or_distjoint_implies_ule_fail_before := [llvmfunc|
  llvm.func @or_distjoint_implies_ule_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(28 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.icmp "ule" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "ule" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def or_prove_distjoin_implies_ule_before := [llvmfunc|
  llvm.func @or_prove_distjoin_implies_ule(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(10 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.or %3, %2  : i8
    %6 = llvm.icmp "ule" %5, %arg1 : i8
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.icmp "ule" %4, %arg1 : i8
    llvm.return %7 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def src_or_distjoint_implies_sle_before := [llvmfunc|
  llvm.func @src_or_distjoint_implies_sle(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.icmp "sle" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "sle" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def src_or_distjoint_implies_sle_fail_before := [llvmfunc|
  llvm.func @src_or_distjoint_implies_sle_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg0, %1  : i8
    %4 = llvm.icmp "sle" %arg1, %3 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "sle" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def src_addnsw_implies_sle_before := [llvmfunc|
  llvm.func @src_addnsw_implies_sle(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.add %arg0, %1 overflow<nsw>  : i8
    %4 = llvm.icmp "sle" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "sle" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def src_addnsw_implies_sle_fail_before := [llvmfunc|
  llvm.func @src_addnsw_implies_sle_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.add %arg0, %1 overflow<nsw>  : i8
    %4 = llvm.icmp "sle" %3, %arg1 : i8
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "sle" %2, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def src_and_implies_ult_before := [llvmfunc|
  llvm.func @src_and_implies_ult(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

def src_and_implies_ult_fail_before := [llvmfunc|
  llvm.func @src_and_implies_ult_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg0, %arg2  : i8
    %2 = llvm.icmp "ult" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

def src_and_implies_slt_fail_before := [llvmfunc|
  llvm.func @src_and_implies_slt_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg0, %arg1  : i8
    %2 = llvm.icmp "slt" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

def src_or_implies_ule_before := [llvmfunc|
  llvm.func @src_or_implies_ule(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.icmp "uge" %arg2, %0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

def src_or_implies_false_ugt_todo_before := [llvmfunc|
  llvm.func @src_or_implies_false_ugt_todo(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %0, %arg2 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %arg3 : i1
  ^bb2:  // pred: ^bb0
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i8
    llvm.return %2 : i1
  }]

def src_udiv_implies_ult_before := [llvmfunc|
  llvm.func @src_udiv_implies_ult(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

def src_udiv_implies_ult2_before := [llvmfunc|
  llvm.func @src_udiv_implies_ult2(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %arg2 : i1
  ^bb2:  // pred: ^bb0
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.return %3 : i1
  }]

def src_smin_implies_sle_before := [llvmfunc|
  llvm.func @src_smin_implies_sle(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "sle" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

def src_umin_implies_ule_before := [llvmfunc|
  llvm.func @src_umin_implies_ule(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.icmp "ule" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

def src_umax_implies_ule_before := [llvmfunc|
  llvm.func @src_umax_implies_ule(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.icmp "ule" %0, %arg2 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

def src_smax_implies_sle_before := [llvmfunc|
  llvm.func @src_smax_implies_sle(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.icmp "sle" %0, %arg2 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "sle" %arg0, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

def or_implies_sle_combined := [llvmfunc|
  llvm.func @or_implies_sle(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "sgt" %1, %arg1 : i8
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_or_implies_sle   : or_implies_sle_before  ⊑  or_implies_sle_combined := by
  unfold or_implies_sle_before or_implies_sle_combined
  simp_alive_peephole
  sorry
def or_implies_sle_fail_combined := [llvmfunc|
  llvm.func @or_implies_sle_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-34 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "sgt" %1, %arg1 : i8
    llvm.cond_br %2, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_or_implies_sle_fail   : or_implies_sle_fail_before  ⊑  or_implies_sle_fail_combined := by
  unfold or_implies_sle_fail_before or_implies_sle_fail_combined
  simp_alive_peephole
  sorry
def or_distjoint_implies_ule_combined := [llvmfunc|
  llvm.func @or_distjoint_implies_ule(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %arg1 : i8
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.or %arg0, %1  : i8
    %5 = llvm.icmp "ule" %4, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_or_distjoint_implies_ule   : or_distjoint_implies_ule_before  ⊑  or_distjoint_implies_ule_combined := by
  unfold or_distjoint_implies_ule_before or_distjoint_implies_ule_combined
  simp_alive_peephole
  sorry
def or_distjoint_implies_ule_fail_combined := [llvmfunc|
  llvm.func @or_distjoint_implies_ule_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(28 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %arg1 : i8
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.or %arg0, %1  : i8
    %5 = llvm.icmp "ule" %4, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_or_distjoint_implies_ule_fail   : or_distjoint_implies_ule_fail_before  ⊑  or_distjoint_implies_ule_fail_combined := by
  unfold or_distjoint_implies_ule_fail_before or_distjoint_implies_ule_fail_combined
  simp_alive_peephole
  sorry
def or_prove_distjoin_implies_ule_combined := [llvmfunc|
  llvm.func @or_prove_distjoin_implies_ule(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.or %3, %1  : i8
    %5 = llvm.icmp "ugt" %4, %arg1 : i8
    llvm.cond_br %5, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_or_prove_distjoin_implies_ule   : or_prove_distjoin_implies_ule_before  ⊑  or_prove_distjoin_implies_ule_combined := by
  unfold or_prove_distjoin_implies_ule_before or_prove_distjoin_implies_ule_combined
  simp_alive_peephole
  sorry
def src_or_distjoint_implies_sle_combined := [llvmfunc|
  llvm.func @src_or_distjoint_implies_sle(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %arg1 : i8
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.or %arg0, %1  : i8
    %5 = llvm.icmp "sle" %4, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_src_or_distjoint_implies_sle   : src_or_distjoint_implies_sle_before  ⊑  src_or_distjoint_implies_sle_combined := by
  unfold src_or_distjoint_implies_sle_before src_or_distjoint_implies_sle_combined
  simp_alive_peephole
  sorry
def src_or_distjoint_implies_sle_fail_combined := [llvmfunc|
  llvm.func @src_or_distjoint_implies_sle_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %arg1 : i8
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.or %arg0, %1  : i8
    %5 = llvm.icmp "sle" %4, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_src_or_distjoint_implies_sle_fail   : src_or_distjoint_implies_sle_fail_before  ⊑  src_or_distjoint_implies_sle_fail_combined := by
  unfold src_or_distjoint_implies_sle_fail_before src_or_distjoint_implies_sle_fail_combined
  simp_alive_peephole
  sorry
def src_addnsw_implies_sle_combined := [llvmfunc|
  llvm.func @src_addnsw_implies_sle(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(23 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %arg1 : i8
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %arg0, %1 overflow<nsw>  : i8
    %5 = llvm.icmp "sle" %4, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_src_addnsw_implies_sle   : src_addnsw_implies_sle_before  ⊑  src_addnsw_implies_sle_combined := by
  unfold src_addnsw_implies_sle_before src_addnsw_implies_sle_combined
  simp_alive_peephole
  sorry
def src_addnsw_implies_sle_fail_combined := [llvmfunc|
  llvm.func @src_addnsw_implies_sle_fail(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(23 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %arg1 : i8
    llvm.cond_br %3, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %arg0, %1 overflow<nsw>  : i8
    %5 = llvm.icmp "sle" %4, %arg1 : i8
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_src_addnsw_implies_sle_fail   : src_addnsw_implies_sle_fail_before  ⊑  src_addnsw_implies_sle_fail_combined := by
  unfold src_addnsw_implies_sle_fail_before src_addnsw_implies_sle_fail_combined
  simp_alive_peephole
  sorry
def src_and_implies_ult_combined := [llvmfunc|
  llvm.func @src_and_implies_ult(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg2, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

theorem inst_combine_src_and_implies_ult   : src_and_implies_ult_before  ⊑  src_and_implies_ult_combined := by
  unfold src_and_implies_ult_before src_and_implies_ult_combined
  simp_alive_peephole
  sorry
def src_and_implies_ult_fail_combined := [llvmfunc|
  llvm.func @src_and_implies_ult_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg0, %arg2  : i8
    %2 = llvm.icmp "ne" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

theorem inst_combine_src_and_implies_ult_fail   : src_and_implies_ult_fail_before  ⊑  src_and_implies_ult_fail_combined := by
  unfold src_and_implies_ult_fail_before src_and_implies_ult_fail_combined
  simp_alive_peephole
  sorry
def src_and_implies_slt_fail_combined := [llvmfunc|
  llvm.func @src_and_implies_slt_fail(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg2 : i8
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg0, %arg1  : i8
    %2 = llvm.icmp "slt" %1, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

theorem inst_combine_src_and_implies_slt_fail   : src_and_implies_slt_fail_before  ⊑  src_and_implies_slt_fail_combined := by
  unfold src_and_implies_slt_fail_before src_and_implies_slt_fail_combined
  simp_alive_peephole
  sorry
def src_or_implies_ule_combined := [llvmfunc|
  llvm.func @src_or_implies_ule(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.or %arg1, %arg0  : i8
    %1 = llvm.icmp "ugt" %0, %arg2 : i8
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

theorem inst_combine_src_or_implies_ule   : src_or_implies_ule_before  ⊑  src_or_implies_ule_combined := by
  unfold src_or_implies_ule_before src_or_implies_ule_combined
  simp_alive_peephole
  sorry
def src_or_implies_false_ugt_todo_combined := [llvmfunc|
  llvm.func @src_or_implies_false_ugt_todo(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.or %arg0, %arg1  : i8
    %1 = llvm.icmp "ugt" %0, %arg2 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %arg3 : i1
  ^bb2:  // pred: ^bb0
    %2 = llvm.icmp "ugt" %arg0, %arg2 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_src_or_implies_false_ugt_todo   : src_or_implies_false_ugt_todo_before  ⊑  src_or_implies_false_ugt_todo_combined := by
  unfold src_or_implies_false_ugt_todo_before src_or_implies_false_ugt_todo_combined
  simp_alive_peephole
  sorry
def src_udiv_implies_ult_combined := [llvmfunc|
  llvm.func @src_udiv_implies_ult(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg2 : i1
  }]

theorem inst_combine_src_udiv_implies_ult   : src_udiv_implies_ult_before  ⊑  src_udiv_implies_ult_combined := by
  unfold src_udiv_implies_ult_before src_udiv_implies_ult_combined
  simp_alive_peephole
  sorry
def src_udiv_implies_ult2_combined := [llvmfunc|
  llvm.func @src_udiv_implies_ult2(%arg0: i8, %arg1: i8, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %arg2 : i1
  ^bb2:  // pred: ^bb0
    %2 = llvm.udiv %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_src_udiv_implies_ult2   : src_udiv_implies_ult2_before  ⊑  src_udiv_implies_ult2_combined := by
  unfold src_udiv_implies_ult2_before src_udiv_implies_ult2_combined
  simp_alive_peephole
  sorry
def src_smin_implies_sle_combined := [llvmfunc|
  llvm.func @src_smin_implies_sle(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "sgt" %arg0, %arg2 : i8
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

theorem inst_combine_src_smin_implies_sle   : src_smin_implies_sle_before  ⊑  src_smin_implies_sle_combined := by
  unfold src_smin_implies_sle_before src_smin_implies_sle_combined
  simp_alive_peephole
  sorry
def src_umin_implies_ule_combined := [llvmfunc|
  llvm.func @src_umin_implies_ule(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ugt" %arg0, %arg2 : i8
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

theorem inst_combine_src_umin_implies_ule   : src_umin_implies_ule_before  ⊑  src_umin_implies_ule_combined := by
  unfold src_umin_implies_ule_before src_umin_implies_ule_combined
  simp_alive_peephole
  sorry
def src_umax_implies_ule_combined := [llvmfunc|
  llvm.func @src_umax_implies_ule(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.icmp "ugt" %0, %arg2 : i8
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "ule" %arg0, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

theorem inst_combine_src_umax_implies_ule   : src_umax_implies_ule_before  ⊑  src_umax_implies_ule_combined := by
  unfold src_umax_implies_ule_before src_umax_implies_ule_combined
  simp_alive_peephole
  sorry
def src_smax_implies_sle_combined := [llvmfunc|
  llvm.func @src_smax_implies_sle(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i1) -> i1 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %1 = llvm.icmp "sgt" %0, %arg2 : i8
    llvm.cond_br %1, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %2 = llvm.icmp "sle" %arg0, %arg2 : i8
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %arg3 : i1
  }]

theorem inst_combine_src_smax_implies_sle   : src_smax_implies_sle_before  ⊑  src_smax_implies_sle_combined := by
  unfold src_smax_implies_sle_before src_smax_implies_sle_combined
  simp_alive_peephole
  sorry
