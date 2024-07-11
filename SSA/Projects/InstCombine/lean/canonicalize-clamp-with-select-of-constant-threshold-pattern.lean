import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-clamp-with-select-of-constant-threshold-pattern
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_select_cond_and_v0_before := [llvmfunc|
  llvm.func @t0_select_cond_and_v0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.icmp "sge" %arg0, %1 : i32
    %4 = llvm.select %2, %1, %0 : i1, i32
    %5 = llvm.and %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }]

def t0_select_cond_and_v0_logical_before := [llvmfunc|
  llvm.func @t0_select_cond_and_v0_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sle" %arg0, %0 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.select %3, %1, %0 : i1, i32
    %6 = llvm.select %3, %4, %2 : i1, i1
    %7 = llvm.select %6, %arg0, %5 : i1, i32
    llvm.return %7 : i32
  }]

def t1_select_cond_and_v1_before := [llvmfunc|
  llvm.func @t1_select_cond_and_v1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.icmp "sge" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.and %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }]

def t1_select_cond_and_v1_logical_before := [llvmfunc|
  llvm.func @t1_select_cond_and_v1_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "sle" %arg0, %0 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %4, %2 : i1, i1
    %7 = llvm.select %6, %arg0, %5 : i1, i32
    llvm.return %7 : i32
  }]

def t2_select_cond_or_v0_before := [llvmfunc|
  llvm.func @t2_select_cond_or_v0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %1 : i1, i32
    %5 = llvm.or %2, %3  : i1
    %6 = llvm.select %5, %4, %arg0 : i1, i32
    llvm.return %6 : i32
  }]

def t2_select_cond_or_v0_logical_before := [llvmfunc|
  llvm.func @t2_select_cond_or_v0_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %3, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %4 : i1, i1
    %7 = llvm.select %6, %5, %arg0 : i1, i32
    llvm.return %7 : i32
  }]

def t3_select_cond_or_v1_before := [llvmfunc|
  llvm.func @t3_select_cond_or_v1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %1, %0 : i1, i32
    %5 = llvm.or %2, %3  : i1
    %6 = llvm.select %5, %4, %arg0 : i1, i32
    llvm.return %6 : i32
  }]

def t3_select_cond_or_v1_logical_before := [llvmfunc|
  llvm.func @t3_select_cond_or_v1_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.select %4, %1, %0 : i1, i32
    %6 = llvm.select %3, %2, %4 : i1, i1
    %7 = llvm.select %6, %5, %arg0 : i1, i32
    llvm.return %7 : i32
  }]

def t4_select_cond_xor_v0_before := [llvmfunc|
  llvm.func @t4_select_cond_xor_v0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %1 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }]

def t4_select_cond_xor_v1_before := [llvmfunc|
  llvm.func @t4_select_cond_xor_v1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %1 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }]

def t5_select_cond_xor_v2_before := [llvmfunc|
  llvm.func @t5_select_cond_xor_v2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.icmp "sle" %arg0, %1 : i32
    %4 = llvm.select %3, %1, %0 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }]

def t5_select_cond_xor_v3_before := [llvmfunc|
  llvm.func @t5_select_cond_xor_v3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.icmp "sle" %arg0, %1 : i32
    %4 = llvm.select %2, %1, %0 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    %6 = llvm.select %5, %arg0, %4 : i1, i32
    llvm.return %6 : i32
  }]

def t0_select_cond_and_v0_combined := [llvmfunc|
  llvm.func @t0_select_cond_and_v0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t0_select_cond_and_v0   : t0_select_cond_and_v0_before  ⊑  t0_select_cond_and_v0_combined := by
  unfold t0_select_cond_and_v0_before t0_select_cond_and_v0_combined
  simp_alive_peephole
  sorry
def t0_select_cond_and_v0_logical_combined := [llvmfunc|
  llvm.func @t0_select_cond_and_v0_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t0_select_cond_and_v0_logical   : t0_select_cond_and_v0_logical_before  ⊑  t0_select_cond_and_v0_logical_combined := by
  unfold t0_select_cond_and_v0_logical_before t0_select_cond_and_v0_logical_combined
  simp_alive_peephole
  sorry
def t1_select_cond_and_v1_combined := [llvmfunc|
  llvm.func @t1_select_cond_and_v1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t1_select_cond_and_v1   : t1_select_cond_and_v1_before  ⊑  t1_select_cond_and_v1_combined := by
  unfold t1_select_cond_and_v1_before t1_select_cond_and_v1_combined
  simp_alive_peephole
  sorry
def t1_select_cond_and_v1_logical_combined := [llvmfunc|
  llvm.func @t1_select_cond_and_v1_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t1_select_cond_and_v1_logical   : t1_select_cond_and_v1_logical_before  ⊑  t1_select_cond_and_v1_logical_combined := by
  unfold t1_select_cond_and_v1_logical_before t1_select_cond_and_v1_logical_combined
  simp_alive_peephole
  sorry
def t2_select_cond_or_v0_combined := [llvmfunc|
  llvm.func @t2_select_cond_or_v0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t2_select_cond_or_v0   : t2_select_cond_or_v0_before  ⊑  t2_select_cond_or_v0_combined := by
  unfold t2_select_cond_or_v0_before t2_select_cond_or_v0_combined
  simp_alive_peephole
  sorry
def t2_select_cond_or_v0_logical_combined := [llvmfunc|
  llvm.func @t2_select_cond_or_v0_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t2_select_cond_or_v0_logical   : t2_select_cond_or_v0_logical_before  ⊑  t2_select_cond_or_v0_logical_combined := by
  unfold t2_select_cond_or_v0_logical_before t2_select_cond_or_v0_logical_combined
  simp_alive_peephole
  sorry
def t3_select_cond_or_v1_combined := [llvmfunc|
  llvm.func @t3_select_cond_or_v1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t3_select_cond_or_v1   : t3_select_cond_or_v1_before  ⊑  t3_select_cond_or_v1_combined := by
  unfold t3_select_cond_or_v1_before t3_select_cond_or_v1_combined
  simp_alive_peephole
  sorry
def t3_select_cond_or_v1_logical_combined := [llvmfunc|
  llvm.func @t3_select_cond_or_v1_logical(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t3_select_cond_or_v1_logical   : t3_select_cond_or_v1_logical_before  ⊑  t3_select_cond_or_v1_logical_combined := by
  unfold t3_select_cond_or_v1_logical_before t3_select_cond_or_v1_logical_combined
  simp_alive_peephole
  sorry
def t4_select_cond_xor_v0_combined := [llvmfunc|
  llvm.func @t4_select_cond_xor_v0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t4_select_cond_xor_v0   : t4_select_cond_xor_v0_before  ⊑  t4_select_cond_xor_v0_combined := by
  unfold t4_select_cond_xor_v0_before t4_select_cond_xor_v0_combined
  simp_alive_peephole
  sorry
def t4_select_cond_xor_v1_combined := [llvmfunc|
  llvm.func @t4_select_cond_xor_v1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t4_select_cond_xor_v1   : t4_select_cond_xor_v1_before  ⊑  t4_select_cond_xor_v1_combined := by
  unfold t4_select_cond_xor_v1_before t4_select_cond_xor_v1_combined
  simp_alive_peephole
  sorry
def t5_select_cond_xor_v2_combined := [llvmfunc|
  llvm.func @t5_select_cond_xor_v2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t5_select_cond_xor_v2   : t5_select_cond_xor_v2_before  ⊑  t5_select_cond_xor_v2_combined := by
  unfold t5_select_cond_xor_v2_before t5_select_cond_xor_v2_combined
  simp_alive_peephole
  sorry
def t5_select_cond_xor_v3_combined := [llvmfunc|
  llvm.func @t5_select_cond_xor_v3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-32768 : i32) : i32
    %1 = llvm.mlir.constant(32767 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %1)  : (i32, i32) -> i32
    llvm.return %3 : i32
  }]

theorem inst_combine_t5_select_cond_xor_v3   : t5_select_cond_xor_v3_before  ⊑  t5_select_cond_xor_v3_combined := by
  unfold t5_select_cond_xor_v3_before t5_select_cond_xor_v3_combined
  simp_alive_peephole
  sorry
