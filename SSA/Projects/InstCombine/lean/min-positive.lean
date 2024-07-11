import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  min-positive
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def smin_before := [llvmfunc|
  llvm.func @smin(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %3 = llvm.icmp "slt" %2, %arg0 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def smin_int_before := [llvmfunc|
  llvm.func @smin_int(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %3 = llvm.intr.smin(%2, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    llvm.return %4 : i1
  }]

def smin_vec_before := [llvmfunc|
  llvm.func @smin_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.or %4, %1  : vector<2xi32>
    %6 = llvm.icmp "slt" %5, %arg1 : vector<2xi32>
    %7 = llvm.select %6, %5, %arg1 : vector<2xi1>, vector<2xi32>
    %8 = llvm.icmp "sgt" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }]

def smin_commute_before := [llvmfunc|
  llvm.func @smin_commute(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.select %3, %arg0, %2 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def smin_commute_vec_before := [llvmfunc|
  llvm.func @smin_commute_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.and %arg0, %0  : vector<2xi32>
    %5 = llvm.or %4, %1  : vector<2xi32>
    %6 = llvm.icmp "slt" %arg1, %5 : vector<2xi32>
    %7 = llvm.select %6, %arg1, %5 : vector<2xi1>, vector<2xi32>
    %8 = llvm.icmp "sgt" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }]

def smin_commute_vec_poison_elts_before := [llvmfunc|
  llvm.func @smin_commute_vec_poison_elts(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi32>
    %9 = llvm.and %arg0, %0  : vector<2xi32>
    %10 = llvm.or %9, %1  : vector<2xi32>
    %11 = llvm.icmp "slt" %arg1, %10 : vector<2xi32>
    %12 = llvm.select %11, %arg1, %10 : vector<2xi1>, vector<2xi32>
    %13 = llvm.icmp "sgt" %12, %8 : vector<2xi32>
    llvm.return %13 : vector<2xi1>
  }]

def maybe_not_positive_before := [llvmfunc|
  llvm.func @maybe_not_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %3 = llvm.icmp "slt" %2, %arg0 : i32
    %4 = llvm.select %3, %2, %arg0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %1 : i32
    llvm.return %5 : i1
  }]

def maybe_not_positive_vec_before := [llvmfunc|
  llvm.func @maybe_not_positive_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %arg1 : vector<2xi32>
    %5 = llvm.select %4, %3, %arg1 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi32>
    llvm.return %6 : vector<2xi1>
  }]

def smin_combined := [llvmfunc|
  llvm.func @smin(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_smin   : smin_before  ⊑  smin_combined := by
  unfold smin_before smin_combined
  simp_alive_peephole
  sorry
def smin_int_combined := [llvmfunc|
  llvm.func @smin_int(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_smin_int   : smin_int_before  ⊑  smin_int_combined := by
  unfold smin_int_before smin_int_combined
  simp_alive_peephole
  sorry
def smin_vec_combined := [llvmfunc|
  llvm.func @smin_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg1, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_smin_vec   : smin_vec_before  ⊑  smin_vec_combined := by
  unfold smin_vec_before smin_vec_combined
  simp_alive_peephole
  sorry
def smin_commute_combined := [llvmfunc|
  llvm.func @smin_commute(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_smin_commute   : smin_commute_before  ⊑  smin_commute_combined := by
  unfold smin_commute_before smin_commute_combined
  simp_alive_peephole
  sorry
def smin_commute_vec_combined := [llvmfunc|
  llvm.func @smin_commute_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sgt" %arg1, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_smin_commute_vec   : smin_commute_vec_before  ⊑  smin_commute_vec_combined := by
  unfold smin_commute_vec_before smin_commute_vec_combined
  simp_alive_peephole
  sorry
def smin_commute_vec_poison_elts_combined := [llvmfunc|
  llvm.func @smin_commute_vec_poison_elts(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.icmp "sgt" %arg1, %6 : vector<2xi32>
    llvm.return %7 : vector<2xi1>
  }]

theorem inst_combine_smin_commute_vec_poison_elts   : smin_commute_vec_poison_elts_before  ⊑  smin_commute_vec_poison_elts_combined := by
  unfold smin_commute_vec_poison_elts_before smin_commute_vec_poison_elts_combined
  simp_alive_peephole
  sorry
def maybe_not_positive_combined := [llvmfunc|
  llvm.func @maybe_not_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_maybe_not_positive   : maybe_not_positive_before  ⊑  maybe_not_positive_combined := by
  unfold maybe_not_positive_before maybe_not_positive_combined
  simp_alive_peephole
  sorry
    %3 = llvm.intr.smin(%2, %arg0)  : (i32, i32) -> i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_maybe_not_positive   : maybe_not_positive_before  ⊑  maybe_not_positive_combined := by
  unfold maybe_not_positive_before maybe_not_positive_combined
  simp_alive_peephole
  sorry
def maybe_not_positive_vec_combined := [llvmfunc|
  llvm.func @maybe_not_positive_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.and %arg0, %0  : vector<2xi32>
    %4 = llvm.intr.smin(%3, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = llvm.icmp "sgt" %4, %2 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_maybe_not_positive_vec   : maybe_not_positive_vec_before  ⊑  maybe_not_positive_vec_combined := by
  unfold maybe_not_positive_vec_before maybe_not_positive_vec_combined
  simp_alive_peephole
  sorry
