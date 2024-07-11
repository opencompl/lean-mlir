import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-shl-nsw
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_shl_nsw_sgt_before := [llvmfunc|
  llvm.func @icmp_shl_nsw_sgt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def icmp_shl_nsw_sge0_before := [llvmfunc|
  llvm.func @icmp_shl_nsw_sge0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "sge" %2, %1 : i32
    llvm.return %3 : i1
  }]

def icmp_shl_nsw_sge1_before := [llvmfunc|
  llvm.func @icmp_shl_nsw_sge1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "sge" %2, %1 : i32
    llvm.return %3 : i1
  }]

def icmp_shl_nsw_sge1_vec_before := [llvmfunc|
  llvm.func @icmp_shl_nsw_sge1_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<21> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.icmp "sge" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_shl_nsw_eq_before := [llvmfunc|
  llvm.func @icmp_shl_nsw_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def icmp_shl_nsw_eq_vec_before := [llvmfunc|
  llvm.func @icmp_shl_nsw_eq_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shl %arg0, %0 overflow<nsw>  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def icmp_sgt1_before := [llvmfunc|
  llvm.func @icmp_sgt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt2_before := [llvmfunc|
  llvm.func @icmp_sgt2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt3_before := [llvmfunc|
  llvm.func @icmp_sgt3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-16 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt4_before := [llvmfunc|
  llvm.func @icmp_sgt4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt5_before := [llvmfunc|
  llvm.func @icmp_sgt5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def icmp_sgt6_before := [llvmfunc|
  llvm.func @icmp_sgt6(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt7_before := [llvmfunc|
  llvm.func @icmp_sgt7(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(124 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt8_before := [llvmfunc|
  llvm.func @icmp_sgt8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(125 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt9_before := [llvmfunc|
  llvm.func @icmp_sgt9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt10_before := [llvmfunc|
  llvm.func @icmp_sgt10(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt11_before := [llvmfunc|
  llvm.func @icmp_sgt11(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt11_vec_before := [llvmfunc|
  llvm.func @icmp_sgt11_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_sle1_before := [llvmfunc|
  llvm.func @icmp_sle1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sle2_before := [llvmfunc|
  llvm.func @icmp_sle2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sle3_before := [llvmfunc|
  llvm.func @icmp_sle3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-16 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sle4_before := [llvmfunc|
  llvm.func @icmp_sle4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sle5_before := [llvmfunc|
  llvm.func @icmp_sle5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %2 = llvm.icmp "sle" %1, %0 : i8
    llvm.return %2 : i1
  }]

def icmp_sle6_before := [llvmfunc|
  llvm.func @icmp_sle6(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sle7_before := [llvmfunc|
  llvm.func @icmp_sle7(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(124 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sle8_before := [llvmfunc|
  llvm.func @icmp_sle8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(125 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sle9_before := [llvmfunc|
  llvm.func @icmp_sle9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sle10_before := [llvmfunc|
  llvm.func @icmp_sle10(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sle11_before := [llvmfunc|
  llvm.func @icmp_sle11(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_eq1_before := [llvmfunc|
  llvm.func @icmp_eq1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(12 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_ne1_before := [llvmfunc|
  llvm.func @icmp_ne1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_shl_nsw_sgt_combined := [llvmfunc|
  llvm.func @icmp_shl_nsw_sgt(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_shl_nsw_sgt   : icmp_shl_nsw_sgt_before  ⊑  icmp_shl_nsw_sgt_combined := by
  unfold icmp_shl_nsw_sgt_before icmp_shl_nsw_sgt_combined
  simp_alive_peephole
  sorry
def icmp_shl_nsw_sge0_combined := [llvmfunc|
  llvm.func @icmp_shl_nsw_sge0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_shl_nsw_sge0   : icmp_shl_nsw_sge0_before  ⊑  icmp_shl_nsw_sge0_combined := by
  unfold icmp_shl_nsw_sge0_before icmp_shl_nsw_sge0_combined
  simp_alive_peephole
  sorry
def icmp_shl_nsw_sge1_combined := [llvmfunc|
  llvm.func @icmp_shl_nsw_sge1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_shl_nsw_sge1   : icmp_shl_nsw_sge1_before  ⊑  icmp_shl_nsw_sge1_combined := by
  unfold icmp_shl_nsw_sge1_before icmp_shl_nsw_sge1_combined
  simp_alive_peephole
  sorry
def icmp_shl_nsw_sge1_vec_combined := [llvmfunc|
  llvm.func @icmp_shl_nsw_sge1_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_icmp_shl_nsw_sge1_vec   : icmp_shl_nsw_sge1_vec_before  ⊑  icmp_shl_nsw_sge1_vec_combined := by
  unfold icmp_shl_nsw_sge1_vec_before icmp_shl_nsw_sge1_vec_combined
  simp_alive_peephole
  sorry
def icmp_shl_nsw_eq_combined := [llvmfunc|
  llvm.func @icmp_shl_nsw_eq(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_shl_nsw_eq   : icmp_shl_nsw_eq_before  ⊑  icmp_shl_nsw_eq_combined := by
  unfold icmp_shl_nsw_eq_before icmp_shl_nsw_eq_combined
  simp_alive_peephole
  sorry
def icmp_shl_nsw_eq_vec_combined := [llvmfunc|
  llvm.func @icmp_shl_nsw_eq_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_icmp_shl_nsw_eq_vec   : icmp_shl_nsw_eq_vec_before  ⊑  icmp_shl_nsw_eq_vec_combined := by
  unfold icmp_shl_nsw_eq_vec_before icmp_shl_nsw_eq_vec_combined
  simp_alive_peephole
  sorry
def icmp_sgt1_combined := [llvmfunc|
  llvm.func @icmp_sgt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt1   : icmp_sgt1_before  ⊑  icmp_sgt1_combined := by
  unfold icmp_sgt1_before icmp_sgt1_combined
  simp_alive_peephole
  sorry
def icmp_sgt2_combined := [llvmfunc|
  llvm.func @icmp_sgt2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt2   : icmp_sgt2_before  ⊑  icmp_sgt2_combined := by
  unfold icmp_sgt2_before icmp_sgt2_combined
  simp_alive_peephole
  sorry
def icmp_sgt3_combined := [llvmfunc|
  llvm.func @icmp_sgt3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-8 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt3   : icmp_sgt3_before  ⊑  icmp_sgt3_combined := by
  unfold icmp_sgt3_before icmp_sgt3_combined
  simp_alive_peephole
  sorry
def icmp_sgt4_combined := [llvmfunc|
  llvm.func @icmp_sgt4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt4   : icmp_sgt4_before  ⊑  icmp_sgt4_combined := by
  unfold icmp_sgt4_before icmp_sgt4_combined
  simp_alive_peephole
  sorry
def icmp_sgt5_combined := [llvmfunc|
  llvm.func @icmp_sgt5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt5   : icmp_sgt5_before  ⊑  icmp_sgt5_combined := by
  unfold icmp_sgt5_before icmp_sgt5_combined
  simp_alive_peephole
  sorry
def icmp_sgt6_combined := [llvmfunc|
  llvm.func @icmp_sgt6(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt6   : icmp_sgt6_before  ⊑  icmp_sgt6_combined := by
  unfold icmp_sgt6_before icmp_sgt6_combined
  simp_alive_peephole
  sorry
def icmp_sgt7_combined := [llvmfunc|
  llvm.func @icmp_sgt7(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(62 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt7   : icmp_sgt7_before  ⊑  icmp_sgt7_combined := by
  unfold icmp_sgt7_before icmp_sgt7_combined
  simp_alive_peephole
  sorry
def icmp_sgt8_combined := [llvmfunc|
  llvm.func @icmp_sgt8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt8   : icmp_sgt8_before  ⊑  icmp_sgt8_combined := by
  unfold icmp_sgt8_before icmp_sgt8_combined
  simp_alive_peephole
  sorry
def icmp_sgt9_combined := [llvmfunc|
  llvm.func @icmp_sgt9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt9   : icmp_sgt9_before  ⊑  icmp_sgt9_combined := by
  unfold icmp_sgt9_before icmp_sgt9_combined
  simp_alive_peephole
  sorry
def icmp_sgt10_combined := [llvmfunc|
  llvm.func @icmp_sgt10(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt10   : icmp_sgt10_before  ⊑  icmp_sgt10_combined := by
  unfold icmp_sgt10_before icmp_sgt10_combined
  simp_alive_peephole
  sorry
def icmp_sgt11_combined := [llvmfunc|
  llvm.func @icmp_sgt11(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt11   : icmp_sgt11_before  ⊑  icmp_sgt11_combined := by
  unfold icmp_sgt11_before icmp_sgt11_combined
  simp_alive_peephole
  sorry
def icmp_sgt11_vec_combined := [llvmfunc|
  llvm.func @icmp_sgt11_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_sgt11_vec   : icmp_sgt11_vec_before  ⊑  icmp_sgt11_vec_combined := by
  unfold icmp_sgt11_vec_before icmp_sgt11_vec_combined
  simp_alive_peephole
  sorry
def icmp_sle1_combined := [llvmfunc|
  llvm.func @icmp_sle1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle1   : icmp_sle1_before  ⊑  icmp_sle1_combined := by
  unfold icmp_sle1_before icmp_sle1_combined
  simp_alive_peephole
  sorry
def icmp_sle2_combined := [llvmfunc|
  llvm.func @icmp_sle2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-63 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle2   : icmp_sle2_before  ⊑  icmp_sle2_combined := by
  unfold icmp_sle2_before icmp_sle2_combined
  simp_alive_peephole
  sorry
def icmp_sle3_combined := [llvmfunc|
  llvm.func @icmp_sle3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle3   : icmp_sle3_before  ⊑  icmp_sle3_combined := by
  unfold icmp_sle3_before icmp_sle3_combined
  simp_alive_peephole
  sorry
def icmp_sle4_combined := [llvmfunc|
  llvm.func @icmp_sle4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle4   : icmp_sle4_before  ⊑  icmp_sle4_combined := by
  unfold icmp_sle4_before icmp_sle4_combined
  simp_alive_peephole
  sorry
def icmp_sle5_combined := [llvmfunc|
  llvm.func @icmp_sle5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle5   : icmp_sle5_before  ⊑  icmp_sle5_combined := by
  unfold icmp_sle5_before icmp_sle5_combined
  simp_alive_peephole
  sorry
def icmp_sle6_combined := [llvmfunc|
  llvm.func @icmp_sle6(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(9 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle6   : icmp_sle6_before  ⊑  icmp_sle6_combined := by
  unfold icmp_sle6_before icmp_sle6_combined
  simp_alive_peephole
  sorry
def icmp_sle7_combined := [llvmfunc|
  llvm.func @icmp_sle7(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle7   : icmp_sle7_before  ⊑  icmp_sle7_combined := by
  unfold icmp_sle7_before icmp_sle7_combined
  simp_alive_peephole
  sorry
def icmp_sle8_combined := [llvmfunc|
  llvm.func @icmp_sle8(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle8   : icmp_sle8_before  ⊑  icmp_sle8_combined := by
  unfold icmp_sle8_before icmp_sle8_combined
  simp_alive_peephole
  sorry
def icmp_sle9_combined := [llvmfunc|
  llvm.func @icmp_sle9(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle9   : icmp_sle9_before  ⊑  icmp_sle9_combined := by
  unfold icmp_sle9_before icmp_sle9_combined
  simp_alive_peephole
  sorry
def icmp_sle10_combined := [llvmfunc|
  llvm.func @icmp_sle10(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle10   : icmp_sle10_before  ⊑  icmp_sle10_combined := by
  unfold icmp_sle10_before icmp_sle10_combined
  simp_alive_peephole
  sorry
def icmp_sle11_combined := [llvmfunc|
  llvm.func @icmp_sle11(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle11   : icmp_sle11_before  ⊑  icmp_sle11_combined := by
  unfold icmp_sle11_before icmp_sle11_combined
  simp_alive_peephole
  sorry
def icmp_eq1_combined := [llvmfunc|
  llvm.func @icmp_eq1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_eq1   : icmp_eq1_before  ⊑  icmp_eq1_combined := by
  unfold icmp_eq1_before icmp_eq1_combined
  simp_alive_peephole
  sorry
def icmp_ne1_combined := [llvmfunc|
  llvm.func @icmp_ne1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ne1   : icmp_ne1_before  ⊑  icmp_ne1_combined := by
  unfold icmp_ne1_before icmp_ne1_combined
  simp_alive_peephole
  sorry
