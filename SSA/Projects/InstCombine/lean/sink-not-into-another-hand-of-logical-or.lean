import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sink-not-into-another-hand-of-logical-or
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.select %3, %arg3, %arg4 : i1, i8
    llvm.return %4 : i8
  }]

def t0_commutative_before := [llvmfunc|
  llvm.func @t0_commutative(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %1, %0, %2 : i1, i1
    %4 = llvm.select %3, %arg3, %arg4 : i1, i8
    llvm.return %4 : i8
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg2, %arg3 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %3 = llvm.xor %1, %0  : i1
    %4 = llvm.select %3, %0, %2 : i1, i1
    %5 = llvm.select %4, %arg4, %arg5 : i1, i8
    llvm.return %5 : i8
  }]

def t1_commutative_before := [llvmfunc|
  llvm.func @t1_commutative(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg2, %arg3 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %3 = llvm.xor %1, %0  : i1
    %4 = llvm.select %2, %0, %3 : i1, i1
    %5 = llvm.select %4, %arg4, %arg5 : i1, i8
    llvm.return %5 : i8
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.return %3 : i1
  }]

def n3_before := [llvmfunc|
  llvm.func @n3(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.select %3, %arg3, %arg4 : i1, i8
    llvm.return %4 : i8
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8, %arg6: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg3, %arg4 : i1, i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %3, %0, %1 : i1, i1
    %5 = llvm.select %4, %arg5, %arg6 : i1, i8
    llvm.return %5 : i8
  }]

def t4_commutative_before := [llvmfunc|
  llvm.func @t4_commutative(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8, %arg6: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg3, %arg4 : i1, i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.xor %arg0, %0  : i1
    %4 = llvm.select %1, %0, %3 : i1, i1
    %5 = llvm.select %4, %arg5, %arg6 : i1, i8
    llvm.return %5 : i8
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.select %arg0, %1, %0 : i1, i1
    %3 = llvm.select %2, %arg4, %arg3 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t0_commutative_combined := [llvmfunc|
  llvm.func @t0_commutative(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg0, %0 : i1, i1
    %3 = llvm.select %2, %arg4, %arg3 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_t0_commutative   : t0_commutative_before  ⊑  t0_commutative_combined := by
  unfold t0_commutative_before t0_commutative_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg2, %arg3 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %3 = llvm.select %1, %2, %0 : i1, i1
    %4 = llvm.select %3, %arg5, %arg4 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t1_commutative_combined := [llvmfunc|
  llvm.func @t1_commutative(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "eq" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg2, %arg3 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %3 = llvm.select %2, %1, %0 : i1, i1
    %4 = llvm.select %3, %arg5, %arg4 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t1_commutative   : t1_commutative_before  ⊑  t1_commutative_combined := by
  unfold t1_commutative_before t1_commutative_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def n3_combined := [llvmfunc|
  llvm.func @n3(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "eq" %arg1, %arg2 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.xor %arg0, %0  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    %4 = llvm.select %3, %arg3, %arg4 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_n3   : n3_before  ⊑  n3_combined := by
  unfold n3_before n3_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8, %arg6: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg4, %arg3 : i1, i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.select %arg0, %1, %0 : i1, i1
    %4 = llvm.select %3, %arg6, %arg5 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def t4_commutative_combined := [llvmfunc|
  llvm.func @t4_commutative(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: i8, %arg6: i8) -> i8 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.icmp "ne" %arg1, %arg2 : i8
    %2 = llvm.select %1, %arg4, %arg3 : i1, i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.select %1, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %arg6, %arg5 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_t4_commutative   : t4_commutative_before  ⊑  t4_commutative_combined := by
  unfold t4_commutative_before t4_commutative_combined
  simp_alive_peephole
  sorry
