import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  minmax-of-minmax
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def smax_of_smax_smin_commute0_before := [llvmfunc|
  llvm.func @smax_of_smax_smin_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def smax_of_smax_smin_commute1_before := [llvmfunc|
  llvm.func @smax_of_smax_smin_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def smax_of_smax_smin_commute2_before := [llvmfunc|
  llvm.func @smax_of_smax_smin_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "slt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def smax_of_smax_smin_commute3_before := [llvmfunc|
  llvm.func @smax_of_smax_smin_commute3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg1, %arg0 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "slt" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def smin_of_smin_smax_commute0_before := [llvmfunc|
  llvm.func @smin_of_smin_smax_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def smin_of_smin_smax_commute1_before := [llvmfunc|
  llvm.func @smin_of_smin_smax_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def smin_of_smin_smax_commute2_before := [llvmfunc|
  llvm.func @smin_of_smin_smax_commute2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "slt" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def smin_of_smin_smax_commute3_before := [llvmfunc|
  llvm.func @smin_of_smin_smax_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def umax_of_umax_umin_commute0_before := [llvmfunc|
  llvm.func @umax_of_umax_umin_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ult" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def umax_of_umax_umin_commute1_before := [llvmfunc|
  llvm.func @umax_of_umax_umin_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def umax_of_umax_umin_commute2_before := [llvmfunc|
  llvm.func @umax_of_umax_umin_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ult" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def umax_of_umax_umin_commute3_before := [llvmfunc|
  llvm.func @umax_of_umax_umin_commute3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg1, %arg0 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "ult" %1, %3 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def umin_of_umin_umax_commute0_before := [llvmfunc|
  llvm.func @umin_of_umin_umax_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def umin_of_umin_umax_commute1_before := [llvmfunc|
  llvm.func @umin_of_umin_umax_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ult" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def umin_of_umin_umax_commute2_before := [llvmfunc|
  llvm.func @umin_of_umin_umax_commute2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %arg1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def umin_of_umin_umax_commute3_before := [llvmfunc|
  llvm.func @umin_of_umin_umax_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def umin_of_smin_umax_wrong_pattern_before := [llvmfunc|
  llvm.func @umin_of_smin_umax_wrong_pattern(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg0, %arg1 : i1, i32
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ugt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def smin_of_umin_umax_wrong_pattern2_before := [llvmfunc|
  llvm.func @smin_of_umin_umax_wrong_pattern2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i32
    %1 = llvm.select %0, %arg1, %arg0 : i1, i32
    %2 = llvm.icmp "ult" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "sgt" %1, %3 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def umin_of_umin_umax_wrong_operand_before := [llvmfunc|
  llvm.func @umin_of_umin_umax_wrong_operand(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %arg2 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %arg2 : vector<2xi1>, vector<2xi32>
    %4 = llvm.icmp "ult" %3, %1 : vector<2xi32>
    %5 = llvm.select %4, %3, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

def umin_of_umin_umax_wrong_operand2_before := [llvmfunc|
  llvm.func @umin_of_umin_umax_wrong_operand2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.icmp "ult" %arg0, %arg2 : i32
    %1 = llvm.select %0, %arg2, %arg0 : i1, i32
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    %5 = llvm.select %4, %3, %1 : i1, i32
    llvm.return %5 : i32
  }]

def smax_of_smax_smin_commute0_combined := [llvmfunc|
  llvm.func @smax_of_smax_smin_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smax_of_smax_smin_commute0   : smax_of_smax_smin_commute0_before  ⊑  smax_of_smax_smin_commute0_combined := by
  unfold smax_of_smax_smin_commute0_before smax_of_smax_smin_commute0_combined
  simp_alive_peephole
  sorry
def smax_of_smax_smin_commute1_combined := [llvmfunc|
  llvm.func @smax_of_smax_smin_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smax_of_smax_smin_commute1   : smax_of_smax_smin_commute1_before  ⊑  smax_of_smax_smin_commute1_combined := by
  unfold smax_of_smax_smin_commute1_before smax_of_smax_smin_commute1_combined
  simp_alive_peephole
  sorry
def smax_of_smax_smin_commute2_combined := [llvmfunc|
  llvm.func @smax_of_smax_smin_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smax_of_smax_smin_commute2   : smax_of_smax_smin_commute2_before  ⊑  smax_of_smax_smin_commute2_combined := by
  unfold smax_of_smax_smin_commute2_before smax_of_smax_smin_commute2_combined
  simp_alive_peephole
  sorry
def smax_of_smax_smin_commute3_combined := [llvmfunc|
  llvm.func @smax_of_smax_smin_commute3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_smax_of_smax_smin_commute3   : smax_of_smax_smin_commute3_before  ⊑  smax_of_smax_smin_commute3_combined := by
  unfold smax_of_smax_smin_commute3_before smax_of_smax_smin_commute3_combined
  simp_alive_peephole
  sorry
def smin_of_smin_smax_commute0_combined := [llvmfunc|
  llvm.func @smin_of_smin_smax_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smin_of_smin_smax_commute0   : smin_of_smin_smax_commute0_before  ⊑  smin_of_smin_smax_commute0_combined := by
  unfold smin_of_smin_smax_commute0_before smin_of_smin_smax_commute0_combined
  simp_alive_peephole
  sorry
def smin_of_smin_smax_commute1_combined := [llvmfunc|
  llvm.func @smin_of_smin_smax_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smin_of_smin_smax_commute1   : smin_of_smin_smax_commute1_before  ⊑  smin_of_smin_smax_commute1_combined := by
  unfold smin_of_smin_smax_commute1_before smin_of_smin_smax_commute1_combined
  simp_alive_peephole
  sorry
def smin_of_smin_smax_commute2_combined := [llvmfunc|
  llvm.func @smin_of_smin_smax_commute2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_smin_of_smin_smax_commute2   : smin_of_smin_smax_commute2_before  ⊑  smin_of_smin_smax_commute2_combined := by
  unfold smin_of_smin_smax_commute2_before smin_of_smin_smax_commute2_combined
  simp_alive_peephole
  sorry
def smin_of_smin_smax_commute3_combined := [llvmfunc|
  llvm.func @smin_of_smin_smax_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smin_of_smin_smax_commute3   : smin_of_smin_smax_commute3_before  ⊑  smin_of_smin_smax_commute3_combined := by
  unfold smin_of_smin_smax_commute3_before smin_of_smin_smax_commute3_combined
  simp_alive_peephole
  sorry
def umax_of_umax_umin_commute0_combined := [llvmfunc|
  llvm.func @umax_of_umax_umin_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umax_of_umax_umin_commute0   : umax_of_umax_umin_commute0_before  ⊑  umax_of_umax_umin_commute0_combined := by
  unfold umax_of_umax_umin_commute0_before umax_of_umax_umin_commute0_combined
  simp_alive_peephole
  sorry
def umax_of_umax_umin_commute1_combined := [llvmfunc|
  llvm.func @umax_of_umax_umin_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umax_of_umax_umin_commute1   : umax_of_umax_umin_commute1_before  ⊑  umax_of_umax_umin_commute1_combined := by
  unfold umax_of_umax_umin_commute1_before umax_of_umax_umin_commute1_combined
  simp_alive_peephole
  sorry
def umax_of_umax_umin_commute2_combined := [llvmfunc|
  llvm.func @umax_of_umax_umin_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umax_of_umax_umin_commute2   : umax_of_umax_umin_commute2_before  ⊑  umax_of_umax_umin_commute2_combined := by
  unfold umax_of_umax_umin_commute2_before umax_of_umax_umin_commute2_combined
  simp_alive_peephole
  sorry
def umax_of_umax_umin_commute3_combined := [llvmfunc|
  llvm.func @umax_of_umax_umin_commute3(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_umax_of_umax_umin_commute3   : umax_of_umax_umin_commute3_before  ⊑  umax_of_umax_umin_commute3_combined := by
  unfold umax_of_umax_umin_commute3_before umax_of_umax_umin_commute3_combined
  simp_alive_peephole
  sorry
def umin_of_umin_umax_commute0_combined := [llvmfunc|
  llvm.func @umin_of_umin_umax_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umin_of_umin_umax_commute0   : umin_of_umin_umax_commute0_before  ⊑  umin_of_umin_umax_commute0_combined := by
  unfold umin_of_umin_umax_commute0_before umin_of_umin_umax_commute0_combined
  simp_alive_peephole
  sorry
def umin_of_umin_umax_commute1_combined := [llvmfunc|
  llvm.func @umin_of_umin_umax_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umin_of_umin_umax_commute1   : umin_of_umin_umax_commute1_before  ⊑  umin_of_umin_umax_commute1_combined := by
  unfold umin_of_umin_umax_commute1_before umin_of_umin_umax_commute1_combined
  simp_alive_peephole
  sorry
def umin_of_umin_umax_commute2_combined := [llvmfunc|
  llvm.func @umin_of_umin_umax_commute2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.umin(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_umin_of_umin_umax_commute2   : umin_of_umin_umax_commute2_before  ⊑  umin_of_umin_umax_commute2_combined := by
  unfold umin_of_umin_umax_commute2_before umin_of_umin_umax_commute2_combined
  simp_alive_peephole
  sorry
def umin_of_umin_umax_commute3_combined := [llvmfunc|
  llvm.func @umin_of_umin_umax_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umin_of_umin_umax_commute3   : umin_of_umin_umax_commute3_before  ⊑  umin_of_umin_umax_commute3_combined := by
  unfold umin_of_umin_umax_commute3_before umin_of_umin_umax_commute3_combined
  simp_alive_peephole
  sorry
def umin_of_smin_umax_wrong_pattern_combined := [llvmfunc|
  llvm.func @umin_of_smin_umax_wrong_pattern(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smin(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umin_of_smin_umax_wrong_pattern   : umin_of_smin_umax_wrong_pattern_before  ⊑  umin_of_smin_umax_wrong_pattern_combined := by
  unfold umin_of_smin_umax_wrong_pattern_before umin_of_smin_umax_wrong_pattern_combined
  simp_alive_peephole
  sorry
def smin_of_umin_umax_wrong_pattern2_combined := [llvmfunc|
  llvm.func @smin_of_umin_umax_wrong_pattern2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smin_of_umin_umax_wrong_pattern2   : smin_of_umin_umax_wrong_pattern2_before  ⊑  smin_of_umin_umax_wrong_pattern2_combined := by
  unfold smin_of_umin_umax_wrong_pattern2_before smin_of_umin_umax_wrong_pattern2_combined
  simp_alive_peephole
  sorry
def umin_of_umin_umax_wrong_operand_combined := [llvmfunc|
  llvm.func @umin_of_umin_umax_wrong_operand(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.intr.umin(%arg0, %arg2)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_umin_of_umin_umax_wrong_operand   : umin_of_umin_umax_wrong_operand_before  ⊑  umin_of_umin_umax_wrong_operand_combined := by
  unfold umin_of_umin_umax_wrong_operand_before umin_of_umin_umax_wrong_operand_combined
  simp_alive_peephole
  sorry
def umin_of_umin_umax_wrong_operand2_combined := [llvmfunc|
  llvm.func @umin_of_umin_umax_wrong_operand2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.intr.umin(%arg1, %arg0)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umin_of_umin_umax_wrong_operand2   : umin_of_umin_umax_wrong_operand2_before  ⊑  umin_of_umin_umax_wrong_operand2_combined := by
  unfold umin_of_umin_umax_wrong_operand2_before umin_of_umin_umax_wrong_operand2_combined
  simp_alive_peephole
  sorry
