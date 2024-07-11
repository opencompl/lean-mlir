import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sink-not-into-logical-or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.select %arg2, %0, %1 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

def n3_before := [llvmfunc|
  llvm.func @n3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def n4_before := [llvmfunc|
  llvm.func @n4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def n5_before := [llvmfunc|
  llvm.func @n5(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def n6_before := [llvmfunc|
  llvm.func @n6(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    llvm.call @use1(%1) : (i1) -> ()
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.xor %1, %0  : i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %arg2, %arg3 : i32
    %4 = llvm.select %3, %0, %1 : i1, i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }]

def t8_before := [llvmfunc|
  llvm.func @t8(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    %3 = llvm.xor %2, %0  : i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %2, %0, %1 : i1, i1
    %5 = llvm.xor %4, %0  : i1
    llvm.return %5 : i1
  }]

def t9_before := [llvmfunc|
  llvm.func @t9(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.xor %1, %0  : i1
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.icmp "eq" %arg2, %arg3 : i32
    %4 = llvm.xor %3, %0  : i1
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.select %3, %0, %1 : i1, i1
    %6 = llvm.xor %5, %0  : i1
    llvm.return %6 : i1
  }]

def n10_before := [llvmfunc|
  llvm.func @n10(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

def t11_before := [llvmfunc|
  llvm.func @t11(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    %5 = llvm.select %3, %arg4, %arg5 : i1, i1
    llvm.call @use1(%5) : (i1) -> ()
    llvm.return %4 : i1
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.icmp "ne" %arg2, %arg3 : i32
    %3 = llvm.select %2, %1, %0 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i1, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i32
    %2 = llvm.select %1, %0, %arg0 : i1, i1
    %3 = llvm.xor %2, %0  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    %3 = llvm.xor %arg2, %0  : i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def n3_combined := [llvmfunc|
  llvm.func @n3(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg1, %0, %arg0 : i1, i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_n3   : n3_before  ⊑  n3_combined := by
  unfold n3_before n3_combined
  simp_alive_peephole
  sorry
def n4_combined := [llvmfunc|
  llvm.func @n4(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_n4   : n4_before  ⊑  n4_combined := by
  unfold n4_before n4_combined
  simp_alive_peephole
  sorry
def n5_combined := [llvmfunc|
  llvm.func @n5(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ne" %arg0, %arg1 : i32
    %3 = llvm.icmp "eq" %arg2, %arg3 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    %5 = llvm.select %4, %2, %1 : i1, i1
    llvm.return %5 : i1
  }]

theorem inst_combine_n5   : n5_before  ⊑  n5_combined := by
  unfold n5_before n5_combined
  simp_alive_peephole
  sorry
def n6_combined := [llvmfunc|
  llvm.func @n6(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    llvm.call @use1(%1) : (i1) -> ()
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_n6   : n6_before  ⊑  n6_combined := by
  unfold n6_before n6_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg2, %arg3 : i32
    %3 = llvm.select %2, %1, %0 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.icmp "ne" %arg2, %arg3 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %1, %0 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.icmp "ne" %arg2, %arg3 : i32
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %1, %0 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def n10_combined := [llvmfunc|
  llvm.func @n10(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg2, %arg3 : i32
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %3, %0  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_n10   : n10_before  ⊑  n10_combined := by
  unfold n10_before n10_combined
  simp_alive_peephole
  sorry
def t11_combined := [llvmfunc|
  llvm.func @t11(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i1, %arg5: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.icmp "ne" %arg2, %arg3 : i32
    %3 = llvm.select %2, %1, %0 : i1, i1
    %4 = llvm.select %3, %arg5, %arg4 : i1, i1
    llvm.call @use1(%4) : (i1) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_t11   : t11_before  ⊑  t11_combined := by
  unfold t11_before t11_combined
  simp_alive_peephole
  sorry
