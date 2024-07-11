import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  result-of-add-of-negative-is-non-zero-and-no-underflow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_bad_before := [llvmfunc|
  llvm.func @t0_bad(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ult" %1, %arg0 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def t0_bad_logical_before := [llvmfunc|
  llvm.func @t0_bad_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def t1_logical_before := [llvmfunc|
  llvm.func @t1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def t2_logical_before := [llvmfunc|
  llvm.func @t2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t3_oneuse0_before := [llvmfunc|
  llvm.func @t3_oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def t3_oneuse0_logical_before := [llvmfunc|
  llvm.func @t3_oneuse0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t4_oneuse1_before := [llvmfunc|
  llvm.func @t4_oneuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def t4_oneuse1_logical_before := [llvmfunc|
  llvm.func @t4_oneuse1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t5_oneuse2_bad_before := [llvmfunc|
  llvm.func @t5_oneuse2_bad(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def t5_oneuse2_bad_logical_before := [llvmfunc|
  llvm.func @t5_oneuse2_bad_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t6_commutativity0_before := [llvmfunc|
  llvm.func @t6_commutativity0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def t6_commutativity0_logical_before := [llvmfunc|
  llvm.func @t6_commutativity0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg0 : i8
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t7_commutativity1_before := [llvmfunc|
  llvm.func @t7_commutativity1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %2 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def t7_commutativity1_logical_before := [llvmfunc|
  llvm.func @t7_commutativity1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ugt" %arg0, %3 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t7_commutativity3_before := [llvmfunc|
  llvm.func @t7_commutativity3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %2 : i8
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }]

def t7_commutativity3_logical_before := [llvmfunc|
  llvm.func @t7_commutativity3_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ugt" %arg0, %3 : i8
    %6 = llvm.select %5, %4, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t8_before := [llvmfunc|
  llvm.func @t8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %0 : i8
    %4 = llvm.icmp "uge" %2, %arg0 : i8
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def t8_logical_before := [llvmfunc|
  llvm.func @t8_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %3, %0 : i8
    %5 = llvm.icmp "uge" %3, %arg0 : i8
    %6 = llvm.select %4, %1, %5 : i1, i1
    llvm.return %6 : i1
  }]

def t9_before := [llvmfunc|
  llvm.func @t9(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    %4 = llvm.icmp "ult" %2, %arg1 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def t9_logical_before := [llvmfunc|
  llvm.func @t9_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.icmp "ult" %3, %arg1 : i8
    %6 = llvm.select %4, %5, %1 : i1, i1
    llvm.return %6 : i1
  }]

def t0_bad_combined := [llvmfunc|
  llvm.func @t0_bad(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ult" %1, %arg0 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_t0_bad   : t0_bad_before  ⊑  t0_bad_combined := by
  unfold t0_bad_before t0_bad_combined
  simp_alive_peephole
  sorry
def t0_bad_logical_combined := [llvmfunc|
  llvm.func @t0_bad_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.icmp "ult" %1, %arg0 : i8
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_t0_bad_logical   : t0_bad_logical_before  ⊑  t0_bad_logical_combined := by
  unfold t0_bad_logical_before t0_bad_logical_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t1_logical_combined := [llvmfunc|
  llvm.func @t1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t1_logical   : t1_logical_before  ⊑  t1_logical_combined := by
  unfold t1_logical_before t1_logical_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t2_logical_combined := [llvmfunc|
  llvm.func @t2_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg1  : i8
    %4 = llvm.icmp "ult" %3, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t2_logical   : t2_logical_before  ⊑  t2_logical_combined := by
  unfold t2_logical_before t2_logical_combined
  simp_alive_peephole
  sorry
def t3_oneuse0_combined := [llvmfunc|
  llvm.func @t3_oneuse0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.sub %0, %arg0  : i8
    %5 = llvm.icmp "ult" %4, %arg1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_t3_oneuse0   : t3_oneuse0_before  ⊑  t3_oneuse0_combined := by
  unfold t3_oneuse0_before t3_oneuse0_combined
  simp_alive_peephole
  sorry
def t3_oneuse0_logical_combined := [llvmfunc|
  llvm.func @t3_oneuse0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.sub %0, %arg0  : i8
    %5 = llvm.icmp "ult" %4, %arg1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_t3_oneuse0_logical   : t3_oneuse0_logical_before  ⊑  t3_oneuse0_logical_combined := by
  unfold t3_oneuse0_logical_before t3_oneuse0_logical_combined
  simp_alive_peephole
  sorry
def t4_oneuse1_combined := [llvmfunc|
  llvm.func @t4_oneuse1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.sub %0, %arg0  : i8
    %5 = llvm.icmp "ult" %4, %arg1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_t4_oneuse1   : t4_oneuse1_before  ⊑  t4_oneuse1_combined := by
  unfold t4_oneuse1_before t4_oneuse1_combined
  simp_alive_peephole
  sorry
def t4_oneuse1_logical_combined := [llvmfunc|
  llvm.func @t4_oneuse1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.sub %0, %arg0  : i8
    %5 = llvm.icmp "ult" %4, %arg1 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_t4_oneuse1_logical   : t4_oneuse1_logical_before  ⊑  t4_oneuse1_logical_combined := by
  unfold t4_oneuse1_logical_before t4_oneuse1_logical_combined
  simp_alive_peephole
  sorry
def t5_oneuse2_bad_combined := [llvmfunc|
  llvm.func @t5_oneuse2_bad(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_t5_oneuse2_bad   : t5_oneuse2_bad_before  ⊑  t5_oneuse2_bad_combined := by
  unfold t5_oneuse2_bad_before t5_oneuse2_bad_combined
  simp_alive_peephole
  sorry
def t5_oneuse2_bad_logical_combined := [llvmfunc|
  llvm.func @t5_oneuse2_bad_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_t5_oneuse2_bad_logical   : t5_oneuse2_bad_logical_before  ⊑  t5_oneuse2_bad_logical_combined := by
  unfold t5_oneuse2_bad_logical_before t5_oneuse2_bad_logical_combined
  simp_alive_peephole
  sorry
def t6_commutativity0_combined := [llvmfunc|
  llvm.func @t6_commutativity0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t6_commutativity0   : t6_commutativity0_before  ⊑  t6_commutativity0_combined := by
  unfold t6_commutativity0_before t6_commutativity0_combined
  simp_alive_peephole
  sorry
def t6_commutativity0_logical_combined := [llvmfunc|
  llvm.func @t6_commutativity0_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t6_commutativity0_logical   : t6_commutativity0_logical_before  ⊑  t6_commutativity0_logical_combined := by
  unfold t6_commutativity0_logical_before t6_commutativity0_logical_combined
  simp_alive_peephole
  sorry
def t7_commutativity1_combined := [llvmfunc|
  llvm.func @t7_commutativity1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t7_commutativity1   : t7_commutativity1_before  ⊑  t7_commutativity1_combined := by
  unfold t7_commutativity1_before t7_commutativity1_combined
  simp_alive_peephole
  sorry
def t7_commutativity1_logical_combined := [llvmfunc|
  llvm.func @t7_commutativity1_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t7_commutativity1_logical   : t7_commutativity1_logical_before  ⊑  t7_commutativity1_logical_combined := by
  unfold t7_commutativity1_logical_before t7_commutativity1_logical_combined
  simp_alive_peephole
  sorry
def t7_commutativity3_combined := [llvmfunc|
  llvm.func @t7_commutativity3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t7_commutativity3   : t7_commutativity3_before  ⊑  t7_commutativity3_combined := by
  unfold t7_commutativity3_before t7_commutativity3_combined
  simp_alive_peephole
  sorry
def t7_commutativity3_logical_combined := [llvmfunc|
  llvm.func @t7_commutativity3_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t7_commutativity3_logical   : t7_commutativity3_logical_before  ⊑  t7_commutativity3_logical_combined := by
  unfold t7_commutativity3_logical_before t7_commutativity3_logical_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "uge" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t8_logical_combined := [llvmfunc|
  llvm.func @t8_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "uge" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t8_logical   : t8_logical_before  ⊑  t8_logical_combined := by
  unfold t8_logical_before t8_logical_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def t9_logical_combined := [llvmfunc|
  llvm.func @t9_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.add %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.icmp "ult" %3, %arg1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t9_logical   : t9_logical_before  ⊑  t9_logical_combined := by
  unfold t9_logical_before t9_logical_combined
  simp_alive_peephole
  sorry
