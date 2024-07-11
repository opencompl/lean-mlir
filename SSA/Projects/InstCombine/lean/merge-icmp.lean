import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  merge-icmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def and_test1_before := [llvmfunc|
  llvm.func @and_test1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16]

    %4 = llvm.trunc %3 : i16 to i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    %6 = llvm.and %3, %1  : i16
    %7 = llvm.icmp "eq" %6, %2 : i16
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def and_test1_logical_before := [llvmfunc|
  llvm.func @and_test1_logical(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16]

    %5 = llvm.trunc %4 : i16 to i8
    %6 = llvm.icmp "eq" %5, %0 : i8
    %7 = llvm.and %4, %1  : i16
    %8 = llvm.icmp "eq" %7, %2 : i16
    %9 = llvm.select %6, %8, %3 : i1, i1
    llvm.return %9 : i1
  }]

def and_test1_vector_before := [llvmfunc|
  llvm.func @and_test1_vector(%arg0: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-256> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<17664> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>]

    %4 = llvm.trunc %3 : vector<2xi16> to vector<2xi8>
    %5 = llvm.icmp "eq" %4, %0 : vector<2xi8>
    %6 = llvm.and %3, %1  : vector<2xi16>
    %7 = llvm.icmp "eq" %6, %2 : vector<2xi16>
    %8 = llvm.and %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }]

def and_test2_before := [llvmfunc|
  llvm.func @and_test2(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-256 : i16) : i16
    %1 = llvm.mlir.constant(32512 : i16) : i16
    %2 = llvm.mlir.constant(69 : i8) : i8
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16]

    %4 = llvm.and %3, %0  : i16
    %5 = llvm.icmp "eq" %4, %1 : i16
    %6 = llvm.trunc %3 : i16 to i8
    %7 = llvm.icmp "eq" %6, %2 : i8
    %8 = llvm.and %5, %7  : i1
    llvm.return %8 : i1
  }]

def and_test2_logical_before := [llvmfunc|
  llvm.func @and_test2_logical(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-256 : i16) : i16
    %1 = llvm.mlir.constant(32512 : i16) : i16
    %2 = llvm.mlir.constant(69 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16]

    %5 = llvm.and %4, %0  : i16
    %6 = llvm.icmp "eq" %5, %1 : i16
    %7 = llvm.trunc %4 : i16 to i8
    %8 = llvm.icmp "eq" %7, %2 : i8
    %9 = llvm.select %6, %8, %3 : i1, i1
    llvm.return %9 : i1
  }]

def and_test2_vector_before := [llvmfunc|
  llvm.func @and_test2_vector(%arg0: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-256> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<32512> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<69> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>]

    %4 = llvm.and %3, %0  : vector<2xi16>
    %5 = llvm.icmp "eq" %4, %1 : vector<2xi16>
    %6 = llvm.trunc %3 : vector<2xi16> to vector<2xi8>
    %7 = llvm.icmp "eq" %6, %2 : vector<2xi8>
    %8 = llvm.and %5, %7  : vector<2xi1>
    llvm.return %8 : vector<2xi1>
  }]

def or_basic_before := [llvmfunc|
  llvm.func @or_basic(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_basic_commuted_before := [llvmfunc|
  llvm.func @or_basic_commuted(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-256 : i16) : i16
    %1 = llvm.mlir.constant(32512 : i16) : i16
    %2 = llvm.mlir.constant(69 : i8) : i8
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.icmp "ne" %3, %1 : i16
    %5 = llvm.trunc %arg0 : i16 to i8
    %6 = llvm.icmp "ne" %5, %2 : i8
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_vector_before := [llvmfunc|
  llvm.func @or_vector(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-256> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.mlir.constant(dense<17664> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.trunc %arg0 : vector<2xi16> to vector<2xi8>
    %4 = llvm.icmp "ne" %3, %0 : vector<2xi8>
    %5 = llvm.and %arg0, %1  : vector<2xi16>
    %6 = llvm.icmp "ne" %5, %2 : vector<2xi16>
    %7 = llvm.or %4, %6  : vector<2xi1>
    llvm.return %7 : vector<2xi1>
  }]

def or_nontrivial_mask1_before := [llvmfunc|
  llvm.func @or_nontrivial_mask1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(3840 : i16) : i16
    %2 = llvm.mlir.constant(1280 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_nontrivial_mask2_before := [llvmfunc|
  llvm.func @or_nontrivial_mask2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_extra_use1_before := [llvmfunc|
  llvm.func @or_extra_use1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    llvm.call @use.i1(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_extra_use2_before := [llvmfunc|
  llvm.func @or_extra_use2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    llvm.call @use.i1(%6) : (i1) -> ()
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_extra_use3_before := [llvmfunc|
  llvm.func @or_extra_use3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_extra_use4_before := [llvmfunc|
  llvm.func @or_extra_use4(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    llvm.call @use.i16(%5) : (i16) -> ()
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_wrong_pred1_before := [llvmfunc|
  llvm.func @or_wrong_pred1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "eq" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_wrong_pred2_before := [llvmfunc|
  llvm.func @or_wrong_pred2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_wrong_pred3_before := [llvmfunc|
  llvm.func @or_wrong_pred3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "eq" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_wrong_op_before := [llvmfunc|
  llvm.func @or_wrong_op(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg1, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_wrong_const1_before := [llvmfunc|
  llvm.func @or_wrong_const1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17665 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def or_wrong_const2_before := [llvmfunc|
  llvm.func @or_wrong_const2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-255 : i16) : i16
    %2 = llvm.mlir.constant(17665 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

def and_test1_combined := [llvmfunc|
  llvm.func @and_test1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(17791 : i16) : i16
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_and_test1   : and_test1_before  ⊑  and_test1_combined := by
  unfold and_test1_before and_test1_combined
  simp_alive_peephole
  sorry
def and_test1_logical_combined := [llvmfunc|
  llvm.func @and_test1_logical(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(17791 : i16) : i16
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_and_test1_logical   : and_test1_logical_before  ⊑  and_test1_logical_combined := by
  unfold and_test1_logical_before and_test1_logical_combined
  simp_alive_peephole
  sorry
def and_test1_vector_combined := [llvmfunc|
  llvm.func @and_test1_vector(%arg0: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<17791> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi16>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_and_test1_vector   : and_test1_vector_before  ⊑  and_test1_vector_combined := by
  unfold and_test1_vector_before and_test1_vector_combined
  simp_alive_peephole
  sorry
def and_test2_combined := [llvmfunc|
  llvm.func @and_test2(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32581 : i16) : i16
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_and_test2   : and_test2_before  ⊑  and_test2_combined := by
  unfold and_test2_before and_test2_combined
  simp_alive_peephole
  sorry
def and_test2_logical_combined := [llvmfunc|
  llvm.func @and_test2_logical(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32581 : i16) : i16
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i16
    %2 = llvm.icmp "eq" %1, %0 : i16
    llvm.return %2 : i1
  }]

theorem inst_combine_and_test2_logical   : and_test2_logical_before  ⊑  and_test2_logical_combined := by
  unfold and_test2_logical_before and_test2_logical_combined
  simp_alive_peephole
  sorry
def and_test2_vector_combined := [llvmfunc|
  llvm.func @and_test2_vector(%arg0: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32581> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>
    %2 = llvm.icmp "eq" %1, %0 : vector<2xi16>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_and_test2_vector   : and_test2_vector_before  ⊑  and_test2_vector_combined := by
  unfold and_test2_vector_before and_test2_vector_combined
  simp_alive_peephole
  sorry
def or_basic_combined := [llvmfunc|
  llvm.func @or_basic(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(17791 : i16) : i16
    %1 = llvm.icmp "ne" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_or_basic   : or_basic_before  ⊑  or_basic_combined := by
  unfold or_basic_before or_basic_combined
  simp_alive_peephole
  sorry
def or_basic_commuted_combined := [llvmfunc|
  llvm.func @or_basic_commuted(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(32581 : i16) : i16
    %1 = llvm.icmp "ne" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_or_basic_commuted   : or_basic_commuted_before  ⊑  or_basic_commuted_combined := by
  unfold or_basic_commuted_before or_basic_commuted_combined
  simp_alive_peephole
  sorry
def or_vector_combined := [llvmfunc|
  llvm.func @or_vector(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<17791> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi16>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_or_vector   : or_vector_before  ⊑  or_vector_combined := by
  unfold or_vector_before or_vector_combined
  simp_alive_peephole
  sorry
def or_nontrivial_mask1_combined := [llvmfunc|
  llvm.func @or_nontrivial_mask1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(4095 : i16) : i16
    %1 = llvm.mlir.constant(1407 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.icmp "ne" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_or_nontrivial_mask1   : or_nontrivial_mask1_before  ⊑  or_nontrivial_mask1_combined := by
  unfold or_nontrivial_mask1_before or_nontrivial_mask1_combined
  simp_alive_peephole
  sorry
def or_nontrivial_mask2_combined := [llvmfunc|
  llvm.func @or_nontrivial_mask2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-3841 : i16) : i16
    %1 = llvm.mlir.constant(20607 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.icmp "ne" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_or_nontrivial_mask2   : or_nontrivial_mask2_before  ⊑  or_nontrivial_mask2_combined := by
  unfold or_nontrivial_mask2_before or_nontrivial_mask2_combined
  simp_alive_peephole
  sorry
def or_extra_use1_combined := [llvmfunc|
  llvm.func @or_extra_use1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    llvm.call @use.i1(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_or_extra_use1   : or_extra_use1_before  ⊑  or_extra_use1_combined := by
  unfold or_extra_use1_before or_extra_use1_combined
  simp_alive_peephole
  sorry
def or_extra_use2_combined := [llvmfunc|
  llvm.func @or_extra_use2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-4096 : i16) : i16
    %2 = llvm.mlir.constant(20480 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    llvm.call @use.i1(%6) : (i1) -> ()
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_or_extra_use2   : or_extra_use2_before  ⊑  or_extra_use2_combined := by
  unfold or_extra_use2_before or_extra_use2_combined
  simp_alive_peephole
  sorry
def or_extra_use3_combined := [llvmfunc|
  llvm.func @or_extra_use3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-3841 : i16) : i16
    %1 = llvm.mlir.constant(20607 : i16) : i16
    %2 = llvm.trunc %arg0 : i16 to i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.icmp "ne" %3, %1 : i16
    llvm.return %4 : i1
  }]

theorem inst_combine_or_extra_use3   : or_extra_use3_before  ⊑  or_extra_use3_combined := by
  unfold or_extra_use3_before or_extra_use3_combined
  simp_alive_peephole
  sorry
def or_extra_use4_combined := [llvmfunc|
  llvm.func @or_extra_use4(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-4096 : i16) : i16
    %1 = llvm.mlir.constant(-3841 : i16) : i16
    %2 = llvm.mlir.constant(20607 : i16) : i16
    %3 = llvm.and %arg0, %0  : i16
    llvm.call @use.i16(%3) : (i16) -> ()
    %4 = llvm.and %arg0, %1  : i16
    %5 = llvm.icmp "ne" %4, %2 : i16
    llvm.return %5 : i1
  }]

theorem inst_combine_or_extra_use4   : or_extra_use4_before  ⊑  or_extra_use4_combined := by
  unfold or_extra_use4_before or_extra_use4_combined
  simp_alive_peephole
  sorry
def or_wrong_pred1_combined := [llvmfunc|
  llvm.func @or_wrong_pred1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "eq" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_or_wrong_pred1   : or_wrong_pred1_before  ⊑  or_wrong_pred1_combined := by
  unfold or_wrong_pred1_before or_wrong_pred1_combined
  simp_alive_peephole
  sorry
def or_wrong_pred2_combined := [llvmfunc|
  llvm.func @or_wrong_pred2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_or_wrong_pred2   : or_wrong_pred2_before  ⊑  or_wrong_pred2_combined := by
  unfold or_wrong_pred2_before or_wrong_pred2_combined
  simp_alive_peephole
  sorry
def or_wrong_pred3_combined := [llvmfunc|
  llvm.func @or_wrong_pred3(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "eq" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "eq" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_or_wrong_pred3   : or_wrong_pred3_before  ⊑  or_wrong_pred3_combined := by
  unfold or_wrong_pred3_before or_wrong_pred3_combined
  simp_alive_peephole
  sorry
def or_wrong_op_combined := [llvmfunc|
  llvm.func @or_wrong_op(%arg0: i16, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-256 : i16) : i16
    %2 = llvm.mlir.constant(17664 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg1, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_or_wrong_op   : or_wrong_op_before  ⊑  or_wrong_op_combined := by
  unfold or_wrong_op_before or_wrong_op_combined
  simp_alive_peephole
  sorry
def or_wrong_const1_combined := [llvmfunc|
  llvm.func @or_wrong_const1(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_or_wrong_const1   : or_wrong_const1_before  ⊑  or_wrong_const1_combined := by
  unfold or_wrong_const1_before or_wrong_const1_combined
  simp_alive_peephole
  sorry
def or_wrong_const2_combined := [llvmfunc|
  llvm.func @or_wrong_const2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-255 : i16) : i16
    %2 = llvm.mlir.constant(17665 : i16) : i16
    %3 = llvm.trunc %arg0 : i16 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i16
    %6 = llvm.icmp "ne" %5, %2 : i16
    %7 = llvm.or %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_or_wrong_const2   : or_wrong_const2_before  ⊑  or_wrong_const2_combined := by
  unfold or_wrong_const2_before or_wrong_const2_combined
  simp_alive_peephole
  sorry
