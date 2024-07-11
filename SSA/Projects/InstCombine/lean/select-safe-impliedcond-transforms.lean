import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-safe-impliedcond-transforms
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_true_implies_b_true_before := [llvmfunc|
  llvm.func @a_true_implies_b_true(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %1 : i8
    %5 = llvm.select %4, %arg1, %arg2 : i1, i1
    %6 = llvm.select %3, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def a_true_implies_b_true_vec_before := [llvmfunc|
  llvm.func @a_true_implies_b_true_vec(%arg0: i8, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<[20, 19]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(10 : i8) : i8
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.insertelement %arg0, %0[%1 : i8] : vector<2xi8>
    %7 = llvm.shufflevector %6, %0 [0, 0] : vector<2xi8> 
    %8 = llvm.icmp "ugt" %7, %2 : vector<2xi8>
    %9 = llvm.icmp "ugt" %arg0, %3 : i8
    %10 = llvm.select %9, %arg1, %arg2 : i1, vector<2xi1>
    %11 = llvm.select %8, %10, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def a_true_implies_b_true2_before := [llvmfunc|
  llvm.func @a_true_implies_b_true2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

def a_true_implies_b_true2_comm_before := [llvmfunc|
  llvm.func @a_true_implies_b_true2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }]

def a_true_implies_b_false_before := [llvmfunc|
  llvm.func @a_true_implies_b_false(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i8
    %4 = llvm.icmp "ult" %arg0, %1 : i8
    %5 = llvm.select %4, %arg1, %arg2 : i1, i1
    %6 = llvm.select %3, %5, %2 : i1, i1
    llvm.return %6 : i1
  }]

def a_true_implies_b_false2_before := [llvmfunc|
  llvm.func @a_true_implies_b_false2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.and %2, %4  : i1
    llvm.return %5 : i1
  }]

def a_true_implies_b_false2_comm_before := [llvmfunc|
  llvm.func @a_true_implies_b_false2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(10 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.and %4, %2  : i1
    llvm.return %5 : i1
  }]

def a_false_implies_b_true_before := [llvmfunc|
  llvm.func @a_false_implies_b_true(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i8
    %4 = llvm.icmp "ult" %arg0, %1 : i8
    %5 = llvm.select %4, %arg1, %arg2 : i1, i1
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def a_false_implies_b_true2_before := [llvmfunc|
  llvm.func @a_false_implies_b_true2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def a_false_implies_b_true2_comm_before := [llvmfunc|
  llvm.func @a_false_implies_b_true2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.or %4, %2  : i1
    llvm.return %5 : i1
  }]

def a_false_implies_b_false_before := [llvmfunc|
  llvm.func @a_false_implies_b_false(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "ugt" %arg0, %0 : i8
    %4 = llvm.icmp "ugt" %arg0, %1 : i8
    %5 = llvm.select %4, %arg1, %arg2 : i1, i1
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def a_false_implies_b_false2_before := [llvmfunc|
  llvm.func @a_false_implies_b_false2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.or %2, %4  : i1
    llvm.return %5 : i1
  }]

def a_false_implies_b_false2_comm_before := [llvmfunc|
  llvm.func @a_false_implies_b_false2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i1
    %5 = llvm.or %4, %2  : i1
    llvm.return %5 : i1
  }]

def a_true_implies_b_true_combined := [llvmfunc|
  llvm.func @a_true_implies_b_true(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_true_implies_b_true   : a_true_implies_b_true_before  ⊑  a_true_implies_b_true_combined := by
  unfold a_true_implies_b_true_before a_true_implies_b_true_combined
  simp_alive_peephole
  sorry
def a_true_implies_b_true_vec_combined := [llvmfunc|
  llvm.func @a_true_implies_b_true_vec(%arg0: i8, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<[20, 19]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(10 : i8) : i8
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.insertelement %arg0, %0[%1 : i64] : vector<2xi8>
    %7 = llvm.shufflevector %6, %0 [0, 0] : vector<2xi8> 
    %8 = llvm.icmp "ugt" %7, %2 : vector<2xi8>
    %9 = llvm.icmp "ugt" %arg0, %3 : i8
    %10 = llvm.select %9, %arg1, %arg2 : i1, vector<2xi1>
    %11 = llvm.select %8, %10, %5 : vector<2xi1>, vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

theorem inst_combine_a_true_implies_b_true_vec   : a_true_implies_b_true_vec_before  ⊑  a_true_implies_b_true_vec_combined := by
  unfold a_true_implies_b_true_vec_before a_true_implies_b_true_vec_combined
  simp_alive_peephole
  sorry
def a_true_implies_b_true2_combined := [llvmfunc|
  llvm.func @a_true_implies_b_true2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_true_implies_b_true2   : a_true_implies_b_true2_before  ⊑  a_true_implies_b_true2_combined := by
  unfold a_true_implies_b_true2_before a_true_implies_b_true2_combined
  simp_alive_peephole
  sorry
def a_true_implies_b_true2_comm_combined := [llvmfunc|
  llvm.func @a_true_implies_b_true2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg1, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_true_implies_b_true2_comm   : a_true_implies_b_true2_comm_before  ⊑  a_true_implies_b_true2_comm_combined := by
  unfold a_true_implies_b_true2_comm_before a_true_implies_b_true2_comm_combined
  simp_alive_peephole
  sorry
def a_true_implies_b_false_combined := [llvmfunc|
  llvm.func @a_true_implies_b_false(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_true_implies_b_false   : a_true_implies_b_false_before  ⊑  a_true_implies_b_false_combined := by
  unfold a_true_implies_b_false_before a_true_implies_b_false_combined
  simp_alive_peephole
  sorry
def a_true_implies_b_false2_combined := [llvmfunc|
  llvm.func @a_true_implies_b_false2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_true_implies_b_false2   : a_true_implies_b_false2_before  ⊑  a_true_implies_b_false2_combined := by
  unfold a_true_implies_b_false2_before a_true_implies_b_false2_combined
  simp_alive_peephole
  sorry
def a_true_implies_b_false2_comm_combined := [llvmfunc|
  llvm.func @a_true_implies_b_false2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(20 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %arg2, %1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_true_implies_b_false2_comm   : a_true_implies_b_false2_comm_before  ⊑  a_true_implies_b_false2_comm_combined := by
  unfold a_true_implies_b_false2_comm_before a_true_implies_b_false2_comm_combined
  simp_alive_peephole
  sorry
def a_false_implies_b_true_combined := [llvmfunc|
  llvm.func @a_false_implies_b_true(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_false_implies_b_true   : a_false_implies_b_true_before  ⊑  a_false_implies_b_true_combined := by
  unfold a_false_implies_b_true_before a_false_implies_b_true_combined
  simp_alive_peephole
  sorry
def a_false_implies_b_true2_combined := [llvmfunc|
  llvm.func @a_false_implies_b_true2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_false_implies_b_true2   : a_false_implies_b_true2_before  ⊑  a_false_implies_b_true2_combined := by
  unfold a_false_implies_b_true2_before a_false_implies_b_true2_combined
  simp_alive_peephole
  sorry
def a_false_implies_b_true2_comm_combined := [llvmfunc|
  llvm.func @a_false_implies_b_true2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_false_implies_b_true2_comm   : a_false_implies_b_true2_comm_before  ⊑  a_false_implies_b_true2_comm_combined := by
  unfold a_false_implies_b_true2_comm_before a_false_implies_b_true2_comm_combined
  simp_alive_peephole
  sorry
def a_false_implies_b_false_combined := [llvmfunc|
  llvm.func @a_false_implies_b_false(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_false_implies_b_false   : a_false_implies_b_false_before  ⊑  a_false_implies_b_false_combined := by
  unfold a_false_implies_b_false_before a_false_implies_b_false_combined
  simp_alive_peephole
  sorry
def a_false_implies_b_false2_combined := [llvmfunc|
  llvm.func @a_false_implies_b_false2(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_false_implies_b_false2   : a_false_implies_b_false2_before  ⊑  a_false_implies_b_false2_combined := by
  unfold a_false_implies_b_false2_before a_false_implies_b_false2_combined
  simp_alive_peephole
  sorry
def a_false_implies_b_false2_comm_combined := [llvmfunc|
  llvm.func @a_false_implies_b_false2_comm(%arg0: i8, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg2 : i1, i1
    llvm.return %3 : i1
  }]

theorem inst_combine_a_false_implies_b_false2_comm   : a_false_implies_b_false2_comm_before  ⊑  a_false_implies_b_false2_comm_combined := by
  unfold a_false_implies_b_false2_comm_before a_false_implies_b_false2_comm_combined
  simp_alive_peephole
  sorry
