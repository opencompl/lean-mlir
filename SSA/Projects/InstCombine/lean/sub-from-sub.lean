import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sub-from-sub
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }]

def t1_flags_before := [llvmfunc|
  llvm.func @t1_flags(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw, nuw>  : i8
    %1 = llvm.sub %0, %arg2 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }]

def t1_flags_nuw_only_before := [llvmfunc|
  llvm.func @t1_flags_nuw_only(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.sub %0, %arg2 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

def t1_flags_sub_nsw_sub_before := [llvmfunc|
  llvm.func @t1_flags_sub_nsw_sub(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }]

def t1_flags_nuw_first_before := [llvmfunc|
  llvm.func @t1_flags_nuw_first(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }]

def t1_flags_nuw_second_before := [llvmfunc|
  llvm.func @t1_flags_nuw_second(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %0, %arg2 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

def t1_flags_nuw_nsw_first_before := [llvmfunc|
  llvm.func @t1_flags_nuw_nsw_first(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw, nuw>  : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }]

def t1_flags_nuw_nsw_second_before := [llvmfunc|
  llvm.func @t1_flags_nuw_nsw_second(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %0, %arg2 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }]

def t3_c0_before := [llvmfunc|
  llvm.func @t3_c0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def t4_c1_before := [llvmfunc|
  llvm.func @t4_c1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %arg0, %0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def t5_c2_before := [llvmfunc|
  llvm.func @t5_c2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.sub %1, %0  : i8
    llvm.return %2 : i8
  }]

def t6_c0_extrause_before := [llvmfunc|
  llvm.func @t6_c0_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def t7_c1_extrause_before := [llvmfunc|
  llvm.func @t7_c1_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }]

def t8_c2_extrause_before := [llvmfunc|
  llvm.func @t8_c2_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %0  : i8
    llvm.return %2 : i8
  }]

def t9_c0_c2_before := [llvmfunc|
  llvm.func @t9_c0_c2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }]

def t10_c1_c2_before := [llvmfunc|
  llvm.func @t10_c1_c2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.sub %arg0, %0  : i8
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }]

def t11_c0_c2_extrause_before := [llvmfunc|
  llvm.func @t11_c0_c2_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }]

def t12_c1_c2_exrause_before := [llvmfunc|
  llvm.func @t12_c1_c2_exrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.sub %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }]

def pr49870_before := [llvmfunc|
  llvm.func @pr49870(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.addressof @g0 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.xor %arg0, %0  : i64
    %4 = llvm.add %3, %2  : i64
    llvm.return %4 : i64
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2  : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_flags_combined := [llvmfunc|
  llvm.func @t1_flags(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2 overflow<nsw, nuw>  : i8
    %1 = llvm.sub %arg0, %0 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t1_flags   : t1_flags_before  ⊑  t1_flags_combined := by
  unfold t1_flags_before t1_flags_combined
  simp_alive_peephole
  sorry
def t1_flags_nuw_only_combined := [llvmfunc|
  llvm.func @t1_flags_nuw_only(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2 overflow<nuw>  : i8
    %1 = llvm.sub %arg0, %0 overflow<nuw>  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t1_flags_nuw_only   : t1_flags_nuw_only_before  ⊑  t1_flags_nuw_only_combined := by
  unfold t1_flags_nuw_only_before t1_flags_nuw_only_combined
  simp_alive_peephole
  sorry
def t1_flags_sub_nsw_sub_combined := [llvmfunc|
  llvm.func @t1_flags_sub_nsw_sub(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2  : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t1_flags_sub_nsw_sub   : t1_flags_sub_nsw_sub_before  ⊑  t1_flags_sub_nsw_sub_combined := by
  unfold t1_flags_sub_nsw_sub_before t1_flags_sub_nsw_sub_combined
  simp_alive_peephole
  sorry
def t1_flags_nuw_first_combined := [llvmfunc|
  llvm.func @t1_flags_nuw_first(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2  : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t1_flags_nuw_first   : t1_flags_nuw_first_before  ⊑  t1_flags_nuw_first_combined := by
  unfold t1_flags_nuw_first_before t1_flags_nuw_first_combined
  simp_alive_peephole
  sorry
def t1_flags_nuw_second_combined := [llvmfunc|
  llvm.func @t1_flags_nuw_second(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2  : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t1_flags_nuw_second   : t1_flags_nuw_second_before  ⊑  t1_flags_nuw_second_combined := by
  unfold t1_flags_nuw_second_before t1_flags_nuw_second_combined
  simp_alive_peephole
  sorry
def t1_flags_nuw_nsw_first_combined := [llvmfunc|
  llvm.func @t1_flags_nuw_nsw_first(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2  : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t1_flags_nuw_nsw_first   : t1_flags_nuw_nsw_first_before  ⊑  t1_flags_nuw_nsw_first_combined := by
  unfold t1_flags_nuw_nsw_first_before t1_flags_nuw_nsw_first_combined
  simp_alive_peephole
  sorry
def t1_flags_nuw_nsw_second_combined := [llvmfunc|
  llvm.func @t1_flags_nuw_nsw_second(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.add %arg1, %arg2  : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t1_flags_nuw_nsw_second   : t1_flags_nuw_nsw_second_before  ⊑  t1_flags_nuw_nsw_second_combined := by
  unfold t1_flags_nuw_nsw_second_before t1_flags_nuw_nsw_second_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def t3_c0_combined := [llvmfunc|
  llvm.func @t3_c0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    %2 = llvm.sub %0, %1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t3_c0   : t3_c0_before  ⊑  t3_c0_combined := by
  unfold t3_c0_before t3_c0_combined
  simp_alive_peephole
  sorry
def t4_c1_combined := [llvmfunc|
  llvm.func @t4_c1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t4_c1   : t4_c1_before  ⊑  t4_c1_combined := by
  unfold t4_c1_before t4_c1_combined
  simp_alive_peephole
  sorry
def t5_c2_combined := [llvmfunc|
  llvm.func @t5_c2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.add %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t5_c2   : t5_c2_before  ⊑  t5_c2_combined := by
  unfold t5_c2_before t5_c2_combined
  simp_alive_peephole
  sorry
def t6_c0_extrause_combined := [llvmfunc|
  llvm.func @t6_c0_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t6_c0_extrause   : t6_c0_extrause_before  ⊑  t6_c0_extrause_combined := by
  unfold t6_c0_extrause_before t6_c0_extrause_combined
  simp_alive_peephole
  sorry
def t7_c1_extrause_combined := [llvmfunc|
  llvm.func @t7_c1_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t7_c1_extrause   : t7_c1_extrause_before  ⊑  t7_c1_extrause_combined := by
  unfold t7_c1_extrause_before t7_c1_extrause_combined
  simp_alive_peephole
  sorry
def t8_c2_extrause_combined := [llvmfunc|
  llvm.func @t8_c2_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.add %1, %0  : i8
    llvm.return %2 : i8
  }]

theorem inst_combine_t8_c2_extrause   : t8_c2_extrause_before  ⊑  t8_c2_extrause_combined := by
  unfold t8_c2_extrause_before t8_c2_extrause_combined
  simp_alive_peephole
  sorry
def t9_c0_c2_combined := [llvmfunc|
  llvm.func @t9_c0_c2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(18 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t9_c0_c2   : t9_c0_c2_before  ⊑  t9_c0_c2_combined := by
  unfold t9_c0_c2_before t9_c0_c2_combined
  simp_alive_peephole
  sorry
def t10_c1_c2_combined := [llvmfunc|
  llvm.func @t10_c1_c2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-66 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.return %1 : i8
  }]

theorem inst_combine_t10_c1_c2   : t10_c1_c2_before  ⊑  t10_c1_c2_combined := by
  unfold t10_c1_c2_before t10_c1_c2_combined
  simp_alive_peephole
  sorry
def t11_c0_c2_extrause_combined := [llvmfunc|
  llvm.func @t11_c0_c2_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(18 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %1, %arg0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t11_c0_c2_extrause   : t11_c0_c2_extrause_before  ⊑  t11_c0_c2_extrause_combined := by
  unfold t11_c0_c2_extrause_before t11_c0_c2_extrause_combined
  simp_alive_peephole
  sorry
def t12_c1_c2_exrause_combined := [llvmfunc|
  llvm.func @t12_c1_c2_exrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(-66 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.add %arg0, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t12_c1_c2_exrause   : t12_c1_c2_exrause_before  ⊑  t12_c1_c2_exrause_combined := by
  unfold t12_c1_c2_exrause_before t12_c1_c2_exrause_combined
  simp_alive_peephole
  sorry
def pr49870_combined := [llvmfunc|
  llvm.func @pr49870(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.addressof @g0 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.xor %arg0, %0  : i64
    %4 = llvm.add %3, %2  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_pr49870   : pr49870_before  ⊑  pr49870_combined := by
  unfold pr49870_before pr49870_combined
  simp_alive_peephole
  sorry
