import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-and-add-sub-xor-p2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def src_add_eq_p2_before := [llvmfunc|
  llvm.func @src_add_eq_p2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.and %3, %2  : i8
    %5 = llvm.icmp "eq" %4, %2 : i8
    llvm.return %5 : i1
  }]

def src_add_eq_p2_fail_multiuse_before := [llvmfunc|
  llvm.func @src_add_eq_p2_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.add %arg0, %2  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.and %3, %2  : i8
    llvm.call @use.i8(%4) : (i8) -> ()
    %5 = llvm.icmp "eq" %4, %2 : i8
    llvm.return %5 : i1
  }]

def src_xor_ne_zero_before := [llvmfunc|
  llvm.func @src_xor_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.xor %arg0, %2  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.and %3, %2  : i8
    %5 = llvm.icmp "ne" %4, %0 : i8
    llvm.return %5 : i1
  }]

def src_xor_ne_zero_fail_different_p2_before := [llvmfunc|
  llvm.func @src_xor_ne_zero_fail_different_p2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.xor %arg0, %3  : i8
    llvm.call @use.i8(%5) : (i8) -> ()
    %6 = llvm.and %5, %4  : i8
    %7 = llvm.icmp "ne" %6, %0 : i8
    llvm.return %7 : i1
  }]

def src_sub_ne_p2_before := [llvmfunc|
  llvm.func @src_sub_ne_p2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg1  : vector<2xi8>
    %3 = llvm.and %2, %arg1  : vector<2xi8>
    %4 = llvm.sub %arg0, %3  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.and %4, %3  : vector<2xi8>
    %6 = llvm.icmp "ne" %5, %3 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }]

def src_sub_eq_zero_before := [llvmfunc|
  llvm.func @src_sub_eq_zero(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg1  : vector<2xi8>
    %4 = llvm.sub %arg0, %3  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.and %4, %3  : vector<2xi8>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }]

def src_sub_eq_zero_fail_commuted_before := [llvmfunc|
  llvm.func @src_sub_eq_zero_fail_commuted(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg1  : vector<2xi8>
    %4 = llvm.sub %3, %arg0  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.and %4, %3  : vector<2xi8>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }]

def src_sub_eq_zero_fail_non_p2_before := [llvmfunc|
  llvm.func @src_sub_eq_zero_fail_non_p2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg1  : vector<2xi8>
    %4 = llvm.sub %arg0, %3  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.and %4, %3  : vector<2xi8>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }]

def src_add_eq_p2_combined := [llvmfunc|
  llvm.func @src_add_eq_p2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.and %2, %arg0  : i8
    %5 = llvm.icmp "eq" %4, %0 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_add_eq_p2   : src_add_eq_p2_before  ⊑  src_add_eq_p2_combined := by
  unfold src_add_eq_p2_before src_add_eq_p2_combined
  simp_alive_peephole
  sorry
def src_add_eq_p2_fail_multiuse_combined := [llvmfunc|
  llvm.func @src_add_eq_p2_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.add %2, %arg0  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.and %3, %2  : i8
    llvm.call @use.i8(%4) : (i8) -> ()
    %5 = llvm.icmp "eq" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_add_eq_p2_fail_multiuse   : src_add_eq_p2_fail_multiuse_before  ⊑  src_add_eq_p2_fail_multiuse_combined := by
  unfold src_add_eq_p2_fail_multiuse_before src_add_eq_p2_fail_multiuse_combined
  simp_alive_peephole
  sorry
def src_xor_ne_zero_combined := [llvmfunc|
  llvm.func @src_xor_ne_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg1  : i8
    %2 = llvm.and %1, %arg1  : i8
    %3 = llvm.xor %2, %arg0  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.and %2, %arg0  : i8
    %5 = llvm.icmp "ne" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_src_xor_ne_zero   : src_xor_ne_zero_before  ⊑  src_xor_ne_zero_combined := by
  unfold src_xor_ne_zero_before src_xor_ne_zero_combined
  simp_alive_peephole
  sorry
def src_xor_ne_zero_fail_different_p2_combined := [llvmfunc|
  llvm.func @src_xor_ne_zero_fail_different_p2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg1  : i8
    %3 = llvm.and %2, %arg1  : i8
    %4 = llvm.shl %3, %1  : i8
    %5 = llvm.xor %3, %arg0  : i8
    llvm.call @use.i8(%5) : (i8) -> ()
    %6 = llvm.and %5, %4  : i8
    %7 = llvm.icmp "ne" %6, %0 : i8
    llvm.return %7 : i1
  }]

theorem inst_combine_src_xor_ne_zero_fail_different_p2   : src_xor_ne_zero_fail_different_p2_before  ⊑  src_xor_ne_zero_fail_different_p2_combined := by
  unfold src_xor_ne_zero_fail_different_p2_before src_xor_ne_zero_fail_different_p2_combined
  simp_alive_peephole
  sorry
def src_sub_ne_p2_combined := [llvmfunc|
  llvm.func @src_sub_ne_p2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.sub %1, %arg1  : vector<2xi8>
    %3 = llvm.and %2, %arg1  : vector<2xi8>
    %4 = llvm.sub %arg0, %3  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.and %3, %arg0  : vector<2xi8>
    %6 = llvm.icmp "ne" %5, %1 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_src_sub_ne_p2   : src_sub_ne_p2_before  ⊑  src_sub_ne_p2_combined := by
  unfold src_sub_ne_p2_before src_sub_ne_p2_combined
  simp_alive_peephole
  sorry
def src_sub_eq_zero_combined := [llvmfunc|
  llvm.func @src_sub_eq_zero(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.shl %0, %arg1  : vector<2xi8>
    %2 = llvm.sub %arg0, %1  : vector<2xi8>
    llvm.call @use.v2i8(%2) : (vector<2xi8>) -> ()
    %3 = llvm.and %1, %arg0  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %1 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_src_sub_eq_zero   : src_sub_eq_zero_before  ⊑  src_sub_eq_zero_combined := by
  unfold src_sub_eq_zero_before src_sub_eq_zero_combined
  simp_alive_peephole
  sorry
def src_sub_eq_zero_fail_commuted_combined := [llvmfunc|
  llvm.func @src_sub_eq_zero_fail_commuted(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg1  : vector<2xi8>
    %4 = llvm.sub %3, %arg0  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.and %4, %3  : vector<2xi8>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_src_sub_eq_zero_fail_commuted   : src_sub_eq_zero_fail_commuted_before  ⊑  src_sub_eq_zero_fail_commuted_combined := by
  unfold src_sub_eq_zero_fail_commuted_before src_sub_eq_zero_fail_commuted_combined
  simp_alive_peephole
  sorry
def src_sub_eq_zero_fail_non_p2_combined := [llvmfunc|
  llvm.func @src_sub_eq_zero_fail_non_p2(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %0, %arg1  : vector<2xi8>
    %4 = llvm.sub %arg0, %3  : vector<2xi8>
    llvm.call @use.v2i8(%4) : (vector<2xi8>) -> ()
    %5 = llvm.and %4, %3  : vector<2xi8>
    %6 = llvm.icmp "eq" %5, %2 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_src_sub_eq_zero_fail_non_p2   : src_sub_eq_zero_fail_non_p2_before  ⊑  src_sub_eq_zero_fail_non_p2_combined := by
  unfold src_sub_eq_zero_fail_non_p2_before src_sub_eq_zero_fail_non_p2_combined
  simp_alive_peephole
  sorry
