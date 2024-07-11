import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  cmp-x-vs-neg-x
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t0_commutative_before := [llvmfunc|
  llvm.func @t0_commutative() -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.sub %0, %1 overflow<nsw>  : i8
    %3 = llvm.icmp "slt" %1, %2 : i8
    llvm.return %3 : i1
  }]

def t0_extrause_before := [llvmfunc|
  llvm.func @t0_extrause(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t1_before := [llvmfunc|
  llvm.func @t1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sge" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t2_before := [llvmfunc|
  llvm.func @t2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "slt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t3_before := [llvmfunc|
  llvm.func @t3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sle" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t4_before := [llvmfunc|
  llvm.func @t4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "ugt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t5_before := [llvmfunc|
  llvm.func @t5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "uge" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t6_before := [llvmfunc|
  llvm.func @t6(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "ult" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t7_before := [llvmfunc|
  llvm.func @t7(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "ule" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t8_before := [llvmfunc|
  llvm.func @t8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "eq" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def t9_before := [llvmfunc|
  llvm.func @t9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "ne" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def n10_before := [llvmfunc|
  llvm.func @n10(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def n11_before := [llvmfunc|
  llvm.func @n11(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

def n12_before := [llvmfunc|
  llvm.func @n12(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def t0_commutative_combined := [llvmfunc|
  llvm.func @t0_commutative() -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.call @gen8() : () -> i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t0_commutative   : t0_commutative_before  ⊑  t0_commutative_combined := by
  unfold t0_commutative_before t0_commutative_combined
  simp_alive_peephole
  sorry
def t0_extrause_combined := [llvmfunc|
  llvm.func @t0_extrause(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_t0_extrause   : t0_extrause_before  ⊑  t0_extrause_combined := by
  unfold t0_extrause_before t0_extrause_combined
  simp_alive_peephole
  sorry
def t1_combined := [llvmfunc|
  llvm.func @t1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t1   : t1_before  ⊑  t1_combined := by
  unfold t1_before t1_combined
  simp_alive_peephole
  sorry
def t2_combined := [llvmfunc|
  llvm.func @t2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t2   : t2_before  ⊑  t2_combined := by
  unfold t2_before t2_combined
  simp_alive_peephole
  sorry
def t3_combined := [llvmfunc|
  llvm.func @t3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t3   : t3_before  ⊑  t3_combined := by
  unfold t3_before t3_combined
  simp_alive_peephole
  sorry
def t4_combined := [llvmfunc|
  llvm.func @t4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t4   : t4_before  ⊑  t4_combined := by
  unfold t4_before t4_combined
  simp_alive_peephole
  sorry
def t5_combined := [llvmfunc|
  llvm.func @t5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t5   : t5_before  ⊑  t5_combined := by
  unfold t5_before t5_combined
  simp_alive_peephole
  sorry
def t6_combined := [llvmfunc|
  llvm.func @t6(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t6   : t6_before  ⊑  t6_combined := by
  unfold t6_before t6_combined
  simp_alive_peephole
  sorry
def t7_combined := [llvmfunc|
  llvm.func @t7(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t7   : t7_before  ⊑  t7_combined := by
  unfold t7_before t7_combined
  simp_alive_peephole
  sorry
def t8_combined := [llvmfunc|
  llvm.func @t8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t8   : t8_before  ⊑  t8_combined := by
  unfold t8_before t8_combined
  simp_alive_peephole
  sorry
def t9_combined := [llvmfunc|
  llvm.func @t9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_t9   : t9_before  ⊑  t9_combined := by
  unfold t9_before t9_combined
  simp_alive_peephole
  sorry
def n10_combined := [llvmfunc|
  llvm.func @n10(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n10   : n10_before  ⊑  n10_combined := by
  unfold n10_before n10_combined
  simp_alive_peephole
  sorry
def n11_combined := [llvmfunc|
  llvm.func @n11(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n11   : n11_before  ⊑  n11_combined := by
  unfold n11_before n11_combined
  simp_alive_peephole
  sorry
def n12_combined := [llvmfunc|
  llvm.func @n12(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n12   : n12_before  ⊑  n12_combined := by
  unfold n12_before n12_combined
  simp_alive_peephole
  sorry
