import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-or-icmp-const-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def eq_basic_before := [llvmfunc|
  llvm.func @eq_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ne_basic_equal_5_before := [llvmfunc|
  llvm.func @ne_basic_equal_5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.icmp "ule" %2, %arg1 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def eq_basic_equal_minus_1_before := [llvmfunc|
  llvm.func @eq_basic_equal_minus_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.icmp "ugt" %2, %arg1 : i8
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def ne_basic_equal_minus_7_before := [llvmfunc|
  llvm.func @ne_basic_equal_minus_7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-7 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.icmp "ule" %2, %arg1 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def eq_basic_unequal_before := [llvmfunc|
  llvm.func @eq_basic_unequal(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.icmp "ugt" %2, %arg1 : i8
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def ne_basic_unequal_before := [llvmfunc|
  llvm.func @ne_basic_unequal(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.icmp "ule" %2, %arg1 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

def eq_multi_c1_before := [llvmfunc|
  llvm.func @eq_multi_c1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %3 : i1
  }]

def ne_multi_c2_before := [llvmfunc|
  llvm.func @ne_multi_c2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }]

def eq_vector_before := [llvmfunc|
  llvm.func @eq_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %3 = llvm.icmp "ugt" %arg0, %arg1 : vector<2xi8>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }]

def ne_vector_equal_5_before := [llvmfunc|
  llvm.func @ne_vector_equal_5(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ule" %2, %arg1 : vector<2xi8>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def eq_vector_equal_minus_1_before := [llvmfunc|
  llvm.func @eq_vector_equal_minus_1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ugt" %2, %arg1 : vector<2xi8>
    %5 = llvm.or %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def ne_vector_equal_minus_7_before := [llvmfunc|
  llvm.func @ne_vector_equal_minus_7(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-7> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ule" %2, %arg1 : vector<2xi8>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def eq_vector_unequal1_before := [llvmfunc|
  llvm.func @eq_vector_unequal1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ugt" %2, %arg1 : vector<2xi8>
    %5 = llvm.or %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def ne_vector_unequal2_before := [llvmfunc|
  llvm.func @ne_vector_unequal2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ule" %2, %arg1 : vector<2xi8>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

def eq_vector_poison_icmp_before := [llvmfunc|
  llvm.func @eq_vector_poison_icmp(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.undef : vector<2xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.add %arg0, %0  : vector<2xi8>
    %9 = llvm.icmp "eq" %arg0, %7 : vector<2xi8>
    %10 = llvm.icmp "ugt" %8, %arg1 : vector<2xi8>
    %11 = llvm.or %9, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def eq_vector_poison_add_before := [llvmfunc|
  llvm.func @eq_vector_poison_add(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %8 = llvm.add %arg0, %6  : vector<2xi8>
    %9 = llvm.icmp "eq" %arg0, %7 : vector<2xi8>
    %10 = llvm.icmp "ugt" %8, %arg1 : vector<2xi8>
    %11 = llvm.or %9, %10  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

def eq_commuted_before := [llvmfunc|
  llvm.func @eq_commuted(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(43 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.icmp "ult" %2, %arg0 : i8
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

def ne_commuted_equal_minus_1_before := [llvmfunc|
  llvm.func @ne_commuted_equal_minus_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.sdiv %0, %arg1  : i8
    %4 = llvm.add %arg0, %1  : i8
    %5 = llvm.icmp "ne" %arg0, %2 : i8
    %6 = llvm.icmp "uge" %3, %4 : i8
    %7 = llvm.and %5, %6  : i1
    llvm.return %7 : i1
  }]

def eq_basic_combined := [llvmfunc|
  llvm.func @eq_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "uge" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_eq_basic   : eq_basic_before  ⊑  eq_basic_combined := by
  unfold eq_basic_before eq_basic_combined
  simp_alive_peephole
  sorry
def ne_basic_equal_5_combined := [llvmfunc|
  llvm.func @ne_basic_equal_5(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-6 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_basic_equal_5   : ne_basic_equal_5_before  ⊑  ne_basic_equal_5_combined := by
  unfold ne_basic_equal_5_before ne_basic_equal_5_combined
  simp_alive_peephole
  sorry
def eq_basic_equal_minus_1_combined := [llvmfunc|
  llvm.func @eq_basic_equal_minus_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_eq_basic_equal_minus_1   : eq_basic_equal_minus_1_before  ⊑  eq_basic_equal_minus_1_combined := by
  unfold eq_basic_equal_minus_1_before eq_basic_equal_minus_1_combined
  simp_alive_peephole
  sorry
def ne_basic_equal_minus_7_combined := [llvmfunc|
  llvm.func @ne_basic_equal_minus_7(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_basic_equal_minus_7   : ne_basic_equal_minus_7_before  ⊑  ne_basic_equal_minus_7_combined := by
  unfold ne_basic_equal_minus_7_before ne_basic_equal_minus_7_combined
  simp_alive_peephole
  sorry
def eq_basic_unequal_combined := [llvmfunc|
  llvm.func @eq_basic_unequal(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    %4 = llvm.icmp "ugt" %2, %arg1 : i8
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_eq_basic_unequal   : eq_basic_unequal_before  ⊑  eq_basic_unequal_combined := by
  unfold eq_basic_unequal_before eq_basic_unequal_combined
  simp_alive_peephole
  sorry
def ne_basic_unequal_combined := [llvmfunc|
  llvm.func @ne_basic_unequal(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-4 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    %4 = llvm.icmp "ule" %2, %arg1 : i8
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_ne_basic_unequal   : ne_basic_unequal_before  ⊑  ne_basic_unequal_combined := by
  unfold ne_basic_unequal_before ne_basic_unequal_combined
  simp_alive_peephole
  sorry
def eq_multi_c1_combined := [llvmfunc|
  llvm.func @eq_multi_c1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.add %arg0, %1  : i8
    %4 = llvm.icmp "uge" %3, %arg1 : i8
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %4 : i1
  }]

theorem inst_combine_eq_multi_c1   : eq_multi_c1_before  ⊑  eq_multi_c1_combined := by
  unfold eq_multi_c1_before eq_multi_c1_combined
  simp_alive_peephole
  sorry
def ne_multi_c2_combined := [llvmfunc|
  llvm.func @ne_multi_c2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %arg1 : i8
    llvm.call @use(%1) : (i1) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_ne_multi_c2   : ne_multi_c2_before  ⊑  ne_multi_c2_combined := by
  unfold ne_multi_c2_before ne_multi_c2_combined
  simp_alive_peephole
  sorry
def eq_vector_combined := [llvmfunc|
  llvm.func @eq_vector(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "uge" %1, %arg1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_eq_vector   : eq_vector_before  ⊑  eq_vector_combined := by
  unfold eq_vector_before eq_vector_combined
  simp_alive_peephole
  sorry
def ne_vector_equal_5_combined := [llvmfunc|
  llvm.func @ne_vector_equal_5(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ne_vector_equal_5   : ne_vector_equal_5_before  ⊑  ne_vector_equal_5_combined := by
  unfold ne_vector_equal_5_before ne_vector_equal_5_combined
  simp_alive_peephole
  sorry
def eq_vector_equal_minus_1_combined := [llvmfunc|
  llvm.func @eq_vector_equal_minus_1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.icmp "uge" %arg0, %arg1 : vector<2xi8>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_eq_vector_equal_minus_1   : eq_vector_equal_minus_1_before  ⊑  eq_vector_equal_minus_1_combined := by
  unfold eq_vector_equal_minus_1_before eq_vector_equal_minus_1_combined
  simp_alive_peephole
  sorry
def ne_vector_equal_minus_7_combined := [llvmfunc|
  llvm.func @ne_vector_equal_minus_7(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ne_vector_equal_minus_7   : ne_vector_equal_minus_7_before  ⊑  ne_vector_equal_minus_7_combined := by
  unfold ne_vector_equal_minus_7_before ne_vector_equal_minus_7_combined
  simp_alive_peephole
  sorry
def eq_vector_unequal1_combined := [llvmfunc|
  llvm.func @eq_vector_unequal1(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ugt" %2, %arg1 : vector<2xi8>
    %5 = llvm.or %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_eq_vector_unequal1   : eq_vector_unequal1_before  ⊑  eq_vector_unequal1_combined := by
  unfold eq_vector_unequal1_before eq_vector_unequal1_combined
  simp_alive_peephole
  sorry
def ne_vector_unequal2_combined := [llvmfunc|
  llvm.func @ne_vector_unequal2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    %4 = llvm.icmp "ule" %2, %arg1 : vector<2xi8>
    %5 = llvm.and %3, %4  : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_ne_vector_unequal2   : ne_vector_unequal2_before  ⊑  ne_vector_unequal2_combined := by
  unfold ne_vector_unequal2_before ne_vector_unequal2_combined
  simp_alive_peephole
  sorry
def eq_vector_poison_icmp_combined := [llvmfunc|
  llvm.func @eq_vector_poison_icmp(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "uge" %1, %arg1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_eq_vector_poison_icmp   : eq_vector_poison_icmp_before  ⊑  eq_vector_poison_icmp_combined := by
  unfold eq_vector_poison_icmp_before eq_vector_poison_icmp_combined
  simp_alive_peephole
  sorry
def eq_vector_poison_add_combined := [llvmfunc|
  llvm.func @eq_vector_poison_add(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.icmp "uge" %1, %arg1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_eq_vector_poison_add   : eq_vector_poison_add_before  ⊑  eq_vector_poison_add_combined := by
  unfold eq_vector_poison_add_before eq_vector_poison_add_combined
  simp_alive_peephole
  sorry
def eq_commuted_combined := [llvmfunc|
  llvm.func @eq_commuted(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(43 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.sdiv %0, %arg1  : i8
    %3 = llvm.add %arg0, %1  : i8
    %4 = llvm.icmp "uge" %3, %2 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_eq_commuted   : eq_commuted_before  ⊑  eq_commuted_combined := by
  unfold eq_commuted_before eq_commuted_combined
  simp_alive_peephole
  sorry
def ne_commuted_equal_minus_1_combined := [llvmfunc|
  llvm.func @ne_commuted_equal_minus_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sdiv %0, %arg1  : i8
    %2 = llvm.icmp "ugt" %1, %arg0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_ne_commuted_equal_minus_1   : ne_commuted_equal_minus_1_before  ⊑  ne_commuted_equal_minus_1_combined := by
  unfold ne_commuted_equal_minus_1_before ne_commuted_equal_minus_1_combined
  simp_alive_peephole
  sorry
