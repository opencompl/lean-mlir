import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  unsigned-mul-overflow-check-via-udiv-of-allones
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_basic_before := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def t1_vec_before := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.udiv %0, %arg0  : vector<2xi8>
    %2 = llvm.icmp "ult" %1, %arg1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

def t2_vec_poison_before := [llvmfunc|
  llvm.func @t2_vec_poison(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : vector<3xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi8>
    %9 = llvm.udiv %8, %arg0  : vector<3xi8>
    %10 = llvm.icmp "ult" %9, %arg1 : vector<3xi8>
    llvm.return %10 : vector<3xi1>
  }]

def t3_commutative_before := [llvmfunc|
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.call @gen8() : () -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def n4_extrause_before := [llvmfunc|
  llvm.func @n4_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def n5_not_negone_before := [llvmfunc|
  llvm.func @n5_not_negone(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def n6_wrong_pred0_before := [llvmfunc|
  llvm.func @n6_wrong_pred0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ule" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def n6_wrong_pred1_before := [llvmfunc|
  llvm.func @n6_wrong_pred1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ugt" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

def t0_basic_combined := [llvmfunc|
  llvm.func @t0_basic(%arg0: i8, %arg1: i8) -> i1 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i8, i1)> 
    llvm.return %1 : i1
  }]

theorem inst_combine_t0_basic   : t0_basic_before  ⊑  t0_basic_combined := by
  unfold t0_basic_before t0_basic_combined
  simp_alive_peephole
  sorry
def t1_vec_combined := [llvmfunc|
  llvm.func @t1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (vector<2xi8>, vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(vector<2xi8>, vector<2xi1>)> 
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_t1_vec   : t1_vec_before  ⊑  t1_vec_combined := by
  unfold t1_vec_before t1_vec_combined
  simp_alive_peephole
  sorry
def t2_vec_poison_combined := [llvmfunc|
  llvm.func @t2_vec_poison(%arg0: vector<3xi8>, %arg1: vector<3xi8>) -> vector<3xi1> {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (vector<3xi8>, vector<3xi8>) -> !llvm.struct<(vector<3xi8>, vector<3xi1>)>
    %1 = llvm.extractvalue %0[1] : !llvm.struct<(vector<3xi8>, vector<3xi1>)> 
    llvm.return %1 : vector<3xi1>
  }]

theorem inst_combine_t2_vec_poison   : t2_vec_poison_before  ⊑  t2_vec_poison_combined := by
  unfold t2_vec_poison_before t2_vec_poison_combined
  simp_alive_peephole
  sorry
def t3_commutative_combined := [llvmfunc|
  llvm.func @t3_commutative(%arg0: i8) -> i1 {
    %0 = llvm.call @gen8() : () -> i8
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i8, i1)> 
    llvm.return %2 : i1
  }]

theorem inst_combine_t3_commutative   : t3_commutative_before  ⊑  t3_commutative_combined := by
  unfold t3_commutative_before t3_commutative_combined
  simp_alive_peephole
  sorry
def n4_extrause_combined := [llvmfunc|
  llvm.func @n4_extrause(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n4_extrause   : n4_extrause_before  ⊑  n4_extrause_combined := by
  unfold n4_extrause_before n4_extrause_combined
  simp_alive_peephole
  sorry
def n5_not_negone_combined := [llvmfunc|
  llvm.func @n5_not_negone(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n5_not_negone   : n5_not_negone_before  ⊑  n5_not_negone_combined := by
  unfold n5_not_negone_before n5_not_negone_combined
  simp_alive_peephole
  sorry
def n6_wrong_pred0_combined := [llvmfunc|
  llvm.func @n6_wrong_pred0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ule" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n6_wrong_pred0   : n6_wrong_pred0_before  ⊑  n6_wrong_pred0_combined := by
  unfold n6_wrong_pred0_before n6_wrong_pred0_combined
  simp_alive_peephole
  sorry
def n6_wrong_pred1_combined := [llvmfunc|
  llvm.func @n6_wrong_pred1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.icmp "ugt" %1, %arg1 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_n6_wrong_pred1   : n6_wrong_pred1_before  ⊑  n6_wrong_pred1_combined := by
  unfold n6_wrong_pred1_before n6_wrong_pred1_combined
  simp_alive_peephole
  sorry
