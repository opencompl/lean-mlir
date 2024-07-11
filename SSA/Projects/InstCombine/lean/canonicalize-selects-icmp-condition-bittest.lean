import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  canonicalize-selects-icmp-condition-bittest
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def p0_before := [llvmfunc|
  llvm.func @p0(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }]

def p1_before := [llvmfunc|
  llvm.func @p1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: !llvm.ptr, %arg6: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.cond_br %arg6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.store %3, %arg5 {alignment = 1 : i64} : i8, !llvm.ptr]

    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %4 = llvm.select %2, %arg3, %arg4 : i1, i8
    llvm.return %4 : i8
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.store %4, %arg5 {alignment = 1 : i64} : i8, !llvm.ptr]

    %5 = llvm.select %3, %arg3, %arg4 : i1, i8
    llvm.return %5 : i8
  }]

def n5_before := [llvmfunc|
  llvm.func @n5(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

def n6_before := [llvmfunc|
  llvm.func @n6(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

def n7_before := [llvmfunc|
  llvm.func @n7(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }]

def n8_before := [llvmfunc|
  llvm.func @n8(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

def p0_combined := [llvmfunc|
  llvm.func @p0(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_p0   : p0_before  ⊑  p0_combined := by
  unfold p0_before p0_combined
  simp_alive_peephole
  sorry
def p1_combined := [llvmfunc|
  llvm.func @p1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_p1   : p1_before  ⊑  p1_combined := by
  unfold p1_before p1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: !llvm.ptr, %arg6: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.cond_br %arg6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    llvm.store %4, %arg5 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %5 = llvm.select %3, %arg4, %arg3 : i1, i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg2, %arg1 : i1, i8
    llvm.store %4, %arg5 {alignment = 1 : i64} : i8, !llvm.ptr
    %5 = llvm.select %3, %arg4, %arg3 : i1, i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def n5_combined := [llvmfunc|
  llvm.func @n5(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    llvm.return %arg2 : i8
  }]

theorem inst_combine_n5   : n5_before  ⊑  n5_combined := by
  unfold n5_before n5_combined
  simp_alive_peephole
  sorry
def n6_combined := [llvmfunc|
  llvm.func @n6(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    llvm.return %arg2 : i8
  }]

theorem inst_combine_n6   : n6_before  ⊑  n6_combined := by
  unfold n6_before n6_combined
  simp_alive_peephole
  sorry
def n7_combined := [llvmfunc|
  llvm.func @n7(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_n7   : n7_before  ⊑  n7_combined := by
  unfold n7_before n7_combined
  simp_alive_peephole
  sorry
def n8_combined := [llvmfunc|
  llvm.func @n8(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }]

theorem inst_combine_n8   : n8_before  ⊑  n8_combined := by
  unfold n8_before n8_combined
  simp_alive_peephole
  sorry
