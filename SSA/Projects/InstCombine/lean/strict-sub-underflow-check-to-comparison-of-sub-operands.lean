import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strict-sub-underflow-check-to-comparison-of-sub-operands
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ugt" %2, %3 : i8
    llvm.return %4 : i1
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ule" %2, %3 : i8
    llvm.return %4 : i1
  }]

def n4_maybezero_before := [llvmfunc|
  llvm.func @n4_maybezero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

def n5_wrongnonzero_before := [llvmfunc|
  llvm.func @n5_wrongnonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "uge" %2, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.sub %2, %arg0  : i8
    llvm.call @use8(%3) : (i8) -> ()
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def n4_maybezero_combined := [llvmfunc|
  llvm.func @n4_maybezero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_n4_maybezero   : n4_maybezero_before  ⊑  n4_maybezero_combined := by
  unfold n4_maybezero_before n4_maybezero_combined
  simp_alive_peephole
  sorry
def n5_wrongnonzero_combined := [llvmfunc|
  llvm.func @n5_wrongnonzero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %arg0 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_n5_wrongnonzero   : n5_wrongnonzero_before  ⊑  n5_wrongnonzero_combined := by
  unfold n5_wrongnonzero_before n5_wrongnonzero_combined
  simp_alive_peephole
  sorry
