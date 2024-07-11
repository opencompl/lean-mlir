import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-fsh
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def rotl_eq_0_before := [llvmfunc|
  llvm.func @rotl_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def rotl_ne_0_before := [llvmfunc|
  llvm.func @rotl_ne_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def rotl_eq_n1_before := [llvmfunc|
  llvm.func @rotl_eq_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def rotl_ne_n1_before := [llvmfunc|
  llvm.func @rotl_ne_n1(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi5>
    llvm.return %3 : vector<2xi1>
  }]

def rotl_ne_n1_poison_before := [llvmfunc|
  llvm.func @rotl_ne_n1_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(-1 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "ne" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }]

def rotl_eq_0_poison_before := [llvmfunc|
  llvm.func @rotl_eq_0_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(0 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "eq" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }]

def rotl_eq_1_poison_before := [llvmfunc|
  llvm.func @rotl_eq_1_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.mlir.poison : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "eq" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }]

def rotl_sgt_0_poison_before := [llvmfunc|
  llvm.func @rotl_sgt_0_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(0 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "sgt" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }]

def rotr_eq_0_before := [llvmfunc|
  llvm.func @rotr_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def rotr_ne_0_before := [llvmfunc|
  llvm.func @rotr_ne_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def rotr_eq_n1_before := [llvmfunc|
  llvm.func @rotr_eq_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def rotr_ne_n1_before := [llvmfunc|
  llvm.func @rotr_ne_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def rotr_ne_1_before := [llvmfunc|
  llvm.func @rotr_ne_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def rotr_sgt_n1_before := [llvmfunc|
  llvm.func @rotr_sgt_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

def fshr_sgt_n1_before := [llvmfunc|
  llvm.func @fshr_sgt_n1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def rotl_eq_0_combined := [llvmfunc|
  llvm.func @rotl_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_rotl_eq_0   : rotl_eq_0_before  ⊑  rotl_eq_0_combined := by
  unfold rotl_eq_0_before rotl_eq_0_combined
  simp_alive_peephole
  sorry
def rotl_ne_0_combined := [llvmfunc|
  llvm.func @rotl_ne_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_rotl_ne_0   : rotl_ne_0_before  ⊑  rotl_ne_0_combined := by
  unfold rotl_ne_0_before rotl_ne_0_combined
  simp_alive_peephole
  sorry
def rotl_eq_n1_combined := [llvmfunc|
  llvm.func @rotl_eq_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_rotl_eq_n1   : rotl_eq_n1_before  ⊑  rotl_eq_n1_combined := by
  unfold rotl_eq_n1_before rotl_eq_n1_combined
  simp_alive_peephole
  sorry
def rotl_ne_n1_combined := [llvmfunc|
  llvm.func @rotl_ne_n1(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_rotl_ne_n1   : rotl_ne_n1_before  ⊑  rotl_ne_n1_combined := by
  unfold rotl_ne_n1_before rotl_ne_n1_combined
  simp_alive_peephole
  sorry
def rotl_ne_n1_poison_combined := [llvmfunc|
  llvm.func @rotl_ne_n1_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(-1 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.icmp "ne" %arg0, %6 : vector<2xi5>
    llvm.return %7 : vector<2xi1>
  }]

theorem inst_combine_rotl_ne_n1_poison   : rotl_ne_n1_poison_before  ⊑  rotl_ne_n1_poison_combined := by
  unfold rotl_ne_n1_poison_before rotl_ne_n1_poison_combined
  simp_alive_peephole
  sorry
def rotl_eq_0_poison_combined := [llvmfunc|
  llvm.func @rotl_eq_0_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(0 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.icmp "eq" %arg0, %6 : vector<2xi5>
    llvm.return %7 : vector<2xi1>
  }]

theorem inst_combine_rotl_eq_0_poison   : rotl_eq_0_poison_before  ⊑  rotl_eq_0_poison_combined := by
  unfold rotl_eq_0_poison_before rotl_eq_0_poison_combined
  simp_alive_peephole
  sorry
def rotl_eq_1_poison_combined := [llvmfunc|
  llvm.func @rotl_eq_1_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.mlir.poison : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "eq" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }]

theorem inst_combine_rotl_eq_1_poison   : rotl_eq_1_poison_before  ⊑  rotl_eq_1_poison_combined := by
  unfold rotl_eq_1_poison_before rotl_eq_1_poison_combined
  simp_alive_peephole
  sorry
def rotl_sgt_0_poison_combined := [llvmfunc|
  llvm.func @rotl_sgt_0_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(0 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "sgt" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }]

theorem inst_combine_rotl_sgt_0_poison   : rotl_sgt_0_poison_before  ⊑  rotl_sgt_0_poison_combined := by
  unfold rotl_sgt_0_poison_before rotl_sgt_0_poison_combined
  simp_alive_peephole
  sorry
def rotr_eq_0_combined := [llvmfunc|
  llvm.func @rotr_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_rotr_eq_0   : rotr_eq_0_before  ⊑  rotr_eq_0_combined := by
  unfold rotr_eq_0_before rotr_eq_0_combined
  simp_alive_peephole
  sorry
def rotr_ne_0_combined := [llvmfunc|
  llvm.func @rotr_ne_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_rotr_ne_0   : rotr_ne_0_before  ⊑  rotr_ne_0_combined := by
  unfold rotr_ne_0_before rotr_ne_0_combined
  simp_alive_peephole
  sorry
def rotr_eq_n1_combined := [llvmfunc|
  llvm.func @rotr_eq_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_rotr_eq_n1   : rotr_eq_n1_before  ⊑  rotr_eq_n1_combined := by
  unfold rotr_eq_n1_before rotr_eq_n1_combined
  simp_alive_peephole
  sorry
def rotr_ne_n1_combined := [llvmfunc|
  llvm.func @rotr_ne_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_rotr_ne_n1   : rotr_ne_n1_before  ⊑  rotr_ne_n1_combined := by
  unfold rotr_ne_n1_before rotr_ne_n1_combined
  simp_alive_peephole
  sorry
def rotr_ne_1_combined := [llvmfunc|
  llvm.func @rotr_ne_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_rotr_ne_1   : rotr_ne_1_before  ⊑  rotr_ne_1_combined := by
  unfold rotr_ne_1_before rotr_ne_1_combined
  simp_alive_peephole
  sorry
def rotr_sgt_n1_combined := [llvmfunc|
  llvm.func @rotr_sgt_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_rotr_sgt_n1   : rotr_sgt_n1_before  ⊑  rotr_sgt_n1_combined := by
  unfold rotr_sgt_n1_before rotr_sgt_n1_combined
  simp_alive_peephole
  sorry
def fshr_sgt_n1_combined := [llvmfunc|
  llvm.func @fshr_sgt_n1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_fshr_sgt_n1   : fshr_sgt_n1_before  ⊑  fshr_sgt_n1_combined := by
  unfold fshr_sgt_n1_before fshr_sgt_n1_combined
  simp_alive_peephole
  sorry
