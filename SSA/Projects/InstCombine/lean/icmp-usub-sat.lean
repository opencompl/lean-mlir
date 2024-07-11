import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-usub-sat
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_eq_basic_positive_before := [llvmfunc|
  llvm.func @icmp_eq_basic_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_ne_basic_positive_before := [llvmfunc|
  llvm.func @icmp_ne_basic_positive(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(9 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "ne" %2, %1 : i16
    llvm.return %3 : i1
  }]

def icmp_ule_basic_positive_before := [llvmfunc|
  llvm.func @icmp_ule_basic_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ule" %2, %1 : i32
    llvm.return %3 : i1
  }]

def icmp_ult_basic_positive_before := [llvmfunc|
  llvm.func @icmp_ult_basic_positive(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i64, i64) -> i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

def icmp_uge_basic_positive_before := [llvmfunc|
  llvm.func @icmp_uge_basic_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }]

def icmp_ugt_basic_positive_before := [llvmfunc|
  llvm.func @icmp_ugt_basic_positive(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "ugt" %2, %1 : i16
    llvm.return %3 : i1
  }]

def icmp_sle_basic_positive_before := [llvmfunc|
  llvm.func @icmp_sle_basic_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "sle" %2, %1 : i32
    llvm.return %3 : i1
  }]

def icmp_slt_basic_positive_before := [llvmfunc|
  llvm.func @icmp_slt_basic_positive(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i64, i64) -> i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }]

def icmp_sge_basic_positive_before := [llvmfunc|
  llvm.func @icmp_sge_basic_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt_basic_positive_before := [llvmfunc|
  llvm.func @icmp_sgt_basic_positive(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "sgt" %2, %1 : i16
    llvm.return %3 : i1
  }]

def icmp_eq_basic_negative_before := [llvmfunc|
  llvm.func @icmp_eq_basic_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-20 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_ne_basic_negative_before := [llvmfunc|
  llvm.func @icmp_ne_basic_negative(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-80 : i16) : i16
    %1 = llvm.mlir.constant(9 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "ne" %2, %1 : i16
    llvm.return %3 : i1
  }]

def icmp_ule_basic_negative_before := [llvmfunc|
  llvm.func @icmp_ule_basic_negative(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ule" %2, %1 : i32
    llvm.return %3 : i1
  }]

def icmp_ult_basic_negative_before := [llvmfunc|
  llvm.func @icmp_ult_basic_negative(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-10 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i64, i64) -> i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

def icmp_uge_basic_negative_before := [llvmfunc|
  llvm.func @icmp_uge_basic_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_ugt_basic_negative_before := [llvmfunc|
  llvm.func @icmp_ugt_basic_negative(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-10 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "ugt" %2, %1 : i16
    llvm.return %3 : i1
  }]

def icmp_sle_basic_negative_before := [llvmfunc|
  llvm.func @icmp_sle_basic_negative(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-10 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "sle" %2, %1 : i32
    llvm.return %3 : i1
  }]

def icmp_slt_basic_negative_before := [llvmfunc|
  llvm.func @icmp_slt_basic_negative(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-24 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i64, i64) -> i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }]

def icmp_sge_basic_negative_before := [llvmfunc|
  llvm.func @icmp_sge_basic_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }]

def icmp_sgt_basic_negative_before := [llvmfunc|
  llvm.func @icmp_sgt_basic_negative(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-20 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "sgt" %2, %1 : i16
    llvm.return %3 : i1
  }]

def icmp_eq_multiuse_positive_before := [llvmfunc|
  llvm.func @icmp_eq_multiuse_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i1
  }]

def icmp_eq_multiuse_negative_before := [llvmfunc|
  llvm.func @icmp_eq_multiuse_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i1
  }]

def icmp_eq_vector_positive_equal_before := [llvmfunc|
  llvm.func @icmp_eq_vector_positive_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_eq_vector_positive_unequal_before := [llvmfunc|
  llvm.func @icmp_eq_vector_positive_unequal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_ne_vector_positive_equal_before := [llvmfunc|
  llvm.func @icmp_ne_vector_positive_equal(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi16>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_ne_vector_positive_unequal_before := [llvmfunc|
  llvm.func @icmp_ne_vector_positive_unequal(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 33]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi16>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_ule_vector_positive_equal_before := [llvmfunc|
  llvm.func @icmp_ule_vector_positive_equal(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_ule_vector_positive_unequal_before := [llvmfunc|
  llvm.func @icmp_ule_vector_positive_unequal(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 35]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[5, 7]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_sgt_vector_positive_equal_before := [llvmfunc|
  llvm.func @icmp_sgt_vector_positive_equal(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<409623> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1234> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_sgt_vector_positive_unequal_before := [llvmfunc|
  llvm.func @icmp_sgt_vector_positive_unequal(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[320498, 409623]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1234, 3456]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_eq_vector_negative_equal_before := [llvmfunc|
  llvm.func @icmp_eq_vector_negative_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_eq_vector_negative_unequal_before := [llvmfunc|
  llvm.func @icmp_eq_vector_negative_unequal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def icmp_eq_vector_multiuse_positive_equal_before := [llvmfunc|
  llvm.func @icmp_eq_vector_multiuse_positive_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.call @use.v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }]

def icmp_eq_vector_multiuse_negative_equal_before := [llvmfunc|
  llvm.func @icmp_eq_vector_multiuse_negative_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-20> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.call @use.v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }]

def icmp_eq_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_eq_basic_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_eq_basic_positive   : icmp_eq_basic_positive_before  ⊑  icmp_eq_basic_positive_combined := by
  unfold icmp_eq_basic_positive_before icmp_eq_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_ne_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_ne_basic_positive(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(17 : i16) : i16
    %1 = llvm.icmp "ne" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ne_basic_positive   : icmp_ne_basic_positive_before  ⊑  icmp_ne_basic_positive_combined := by
  unfold icmp_ne_basic_positive_before icmp_ne_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_ule_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_ule_basic_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ule_basic_positive   : icmp_ule_basic_positive_before  ⊑  icmp_ule_basic_positive_combined := by
  unfold icmp_ule_basic_positive_before icmp_ule_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_ult_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_ult_basic_positive(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ult_basic_positive   : icmp_ult_basic_positive_before  ⊑  icmp_ult_basic_positive_combined := by
  unfold icmp_ult_basic_positive_before icmp_ult_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_uge_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_uge_basic_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_uge_basic_positive   : icmp_uge_basic_positive_before  ⊑  icmp_uge_basic_positive_combined := by
  unfold icmp_uge_basic_positive_before icmp_uge_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_ugt_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_ugt_basic_positive(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.icmp "ugt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ugt_basic_positive   : icmp_ugt_basic_positive_before  ⊑  icmp_ugt_basic_positive_combined := by
  unfold icmp_ugt_basic_positive_before icmp_ugt_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_sle_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_sle_basic_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483638 : i32) : i32
    %1 = llvm.mlir.constant(-2147483639 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_sle_basic_positive   : icmp_sle_basic_positive_before  ⊑  icmp_sle_basic_positive_combined := by
  unfold icmp_sle_basic_positive_before icmp_sle_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_slt_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_slt_basic_positive(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(9223372036854775784 : i64) : i64
    %1 = llvm.mlir.constant(-9223372036854775803 : i64) : i64
    %2 = llvm.add %arg0, %0  : i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_slt_basic_positive   : icmp_slt_basic_positive_before  ⊑  icmp_slt_basic_positive_combined := by
  unfold icmp_slt_basic_positive_before icmp_slt_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_sge_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_sge_basic_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-5 : i8) : i8
    %1 = llvm.mlir.constant(124 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_sge_basic_positive   : icmp_sge_basic_positive_before  ⊑  icmp_sge_basic_positive_combined := by
  unfold icmp_sge_basic_positive_before icmp_sge_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_sgt_basic_positive_combined := [llvmfunc|
  llvm.func @icmp_sgt_basic_positive(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-8 : i16) : i16
    %1 = llvm.mlir.constant(32762 : i16) : i16
    %2 = llvm.add %arg0, %0  : i16
    %3 = llvm.icmp "ult" %2, %1 : i16
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_sgt_basic_positive   : icmp_sgt_basic_positive_before  ⊑  icmp_sgt_basic_positive_combined := by
  unfold icmp_sgt_basic_positive_before icmp_sgt_basic_positive_combined
  simp_alive_peephole
  sorry
def icmp_eq_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_eq_basic_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-15 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_eq_basic_negative   : icmp_eq_basic_negative_before  ⊑  icmp_eq_basic_negative_combined := by
  unfold icmp_eq_basic_negative_before icmp_eq_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_ne_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_ne_basic_negative(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-71 : i16) : i16
    %1 = llvm.icmp "ne" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ne_basic_negative   : icmp_ne_basic_negative_before  ⊑  icmp_ne_basic_negative_combined := by
  unfold icmp_ne_basic_negative_before icmp_ne_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_ule_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_ule_basic_negative(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ule_basic_negative   : icmp_ule_basic_negative_before  ⊑  icmp_ule_basic_negative_combined := by
  unfold icmp_ule_basic_negative_before icmp_ule_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_ult_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_ult_basic_negative(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-8 : i64) : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ult_basic_negative   : icmp_ult_basic_negative_before  ⊑  icmp_ult_basic_negative_combined := by
  unfold icmp_ult_basic_negative_before icmp_ult_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_uge_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_uge_basic_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_uge_basic_negative   : icmp_uge_basic_negative_before  ⊑  icmp_uge_basic_negative_combined := by
  unfold icmp_uge_basic_negative_before icmp_uge_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_ugt_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_ugt_basic_negative(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-7 : i16) : i16
    %1 = llvm.icmp "ugt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_ugt_basic_negative   : icmp_ugt_basic_negative_before  ⊑  icmp_ugt_basic_negative_combined := by
  unfold icmp_ugt_basic_negative_before icmp_ugt_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_sle_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_sle_basic_negative(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sle_basic_negative   : icmp_sle_basic_negative_before  ⊑  icmp_sle_basic_negative_combined := by
  unfold icmp_sle_basic_negative_before icmp_sle_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_slt_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_slt_basic_negative(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-19 : i64) : i64
    %1 = llvm.icmp "ult" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_slt_basic_negative   : icmp_slt_basic_negative_before  ⊑  icmp_slt_basic_negative_combined := by
  unfold icmp_slt_basic_negative_before icmp_slt_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_sge_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_sge_basic_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-7 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sge_basic_negative   : icmp_sge_basic_negative_before  ⊑  icmp_sge_basic_negative_combined := by
  unfold icmp_sge_basic_negative_before icmp_sge_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_sgt_basic_negative_combined := [llvmfunc|
  llvm.func @icmp_sgt_basic_negative(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-15 : i16) : i16
    %1 = llvm.icmp "ugt" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_sgt_basic_negative   : icmp_sgt_basic_negative_before  ⊑  icmp_sgt_basic_negative_combined := by
  unfold icmp_sgt_basic_negative_before icmp_sgt_basic_negative_combined
  simp_alive_peephole
  sorry
def icmp_eq_multiuse_positive_combined := [llvmfunc|
  llvm.func @icmp_eq_multiuse_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_eq_multiuse_positive   : icmp_eq_multiuse_positive_before  ⊑  icmp_eq_multiuse_positive_combined := by
  unfold icmp_eq_multiuse_positive_before icmp_eq_multiuse_positive_combined
  simp_alive_peephole
  sorry
def icmp_eq_multiuse_negative_combined := [llvmfunc|
  llvm.func @icmp_eq_multiuse_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_icmp_eq_multiuse_negative   : icmp_eq_multiuse_negative_before  ⊑  icmp_eq_multiuse_negative_combined := by
  unfold icmp_eq_multiuse_negative_before icmp_eq_multiuse_negative_combined
  simp_alive_peephole
  sorry
def icmp_eq_vector_positive_equal_combined := [llvmfunc|
  llvm.func @icmp_eq_vector_positive_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_vector_positive_equal   : icmp_eq_vector_positive_equal_before  ⊑  icmp_eq_vector_positive_equal_combined := by
  unfold icmp_eq_vector_positive_equal_before icmp_eq_vector_positive_equal_combined
  simp_alive_peephole
  sorry
def icmp_eq_vector_positive_unequal_combined := [llvmfunc|
  llvm.func @icmp_eq_vector_positive_unequal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_vector_positive_unequal   : icmp_eq_vector_positive_unequal_before  ⊑  icmp_eq_vector_positive_unequal_combined := by
  unfold icmp_eq_vector_positive_unequal_before icmp_eq_vector_positive_unequal_combined
  simp_alive_peephole
  sorry
def icmp_ne_vector_positive_equal_combined := [llvmfunc|
  llvm.func @icmp_ne_vector_positive_equal(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<37> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<2xi16>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_ne_vector_positive_equal   : icmp_ne_vector_positive_equal_before  ⊑  icmp_ne_vector_positive_equal_combined := by
  unfold icmp_ne_vector_positive_equal_before icmp_ne_vector_positive_equal_combined
  simp_alive_peephole
  sorry
def icmp_ne_vector_positive_unequal_combined := [llvmfunc|
  llvm.func @icmp_ne_vector_positive_unequal(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 33]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi16>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_ne_vector_positive_unequal   : icmp_ne_vector_positive_unequal_before  ⊑  icmp_ne_vector_positive_unequal_combined := by
  unfold icmp_ne_vector_positive_unequal_before icmp_ne_vector_positive_unequal_combined
  simp_alive_peephole
  sorry
def icmp_ule_vector_positive_equal_combined := [llvmfunc|
  llvm.func @icmp_ule_vector_positive_equal(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<37> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_ule_vector_positive_equal   : icmp_ule_vector_positive_equal_before  ⊑  icmp_ule_vector_positive_equal_combined := by
  unfold icmp_ule_vector_positive_equal_before icmp_ule_vector_positive_equal_combined
  simp_alive_peephole
  sorry
def icmp_ule_vector_positive_unequal_combined := [llvmfunc|
  llvm.func @icmp_ule_vector_positive_unequal(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 35]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[5, 7]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_ule_vector_positive_unequal   : icmp_ule_vector_positive_unequal_before  ⊑  icmp_ule_vector_positive_unequal_combined := by
  unfold icmp_ule_vector_positive_unequal_before icmp_ule_vector_positive_unequal_combined
  simp_alive_peephole
  sorry
def icmp_sgt_vector_positive_equal_combined := [llvmfunc|
  llvm.func @icmp_sgt_vector_positive_equal(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-410858> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<9223372036854774573> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.add %arg0, %0  : vector<2xi64>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_sgt_vector_positive_equal   : icmp_sgt_vector_positive_equal_before  ⊑  icmp_sgt_vector_positive_equal_combined := by
  unfold icmp_sgt_vector_positive_equal_before icmp_sgt_vector_positive_equal_combined
  simp_alive_peephole
  sorry
def icmp_sgt_vector_positive_unequal_combined := [llvmfunc|
  llvm.func @icmp_sgt_vector_positive_unequal(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[320498, 409623]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1234, 3456]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_sgt_vector_positive_unequal   : icmp_sgt_vector_positive_unequal_before  ⊑  icmp_sgt_vector_positive_unequal_combined := by
  unfold icmp_sgt_vector_positive_unequal_before icmp_sgt_vector_positive_unequal_combined
  simp_alive_peephole
  sorry
def icmp_eq_vector_negative_equal_combined := [llvmfunc|
  llvm.func @icmp_eq_vector_negative_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_vector_negative_equal   : icmp_eq_vector_negative_equal_before  ⊑  icmp_eq_vector_negative_equal_combined := by
  unfold icmp_eq_vector_negative_equal_before icmp_eq_vector_negative_equal_combined
  simp_alive_peephole
  sorry
def icmp_eq_vector_negative_unequal_combined := [llvmfunc|
  llvm.func @icmp_eq_vector_negative_unequal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_vector_negative_unequal   : icmp_eq_vector_negative_unequal_before  ⊑  icmp_eq_vector_negative_unequal_combined := by
  unfold icmp_eq_vector_negative_unequal_before icmp_eq_vector_negative_unequal_combined
  simp_alive_peephole
  sorry
def icmp_eq_vector_multiuse_positive_equal_combined := [llvmfunc|
  llvm.func @icmp_eq_vector_multiuse_positive_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.call @use.v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_vector_multiuse_positive_equal   : icmp_eq_vector_multiuse_positive_equal_before  ⊑  icmp_eq_vector_multiuse_positive_equal_combined := by
  unfold icmp_eq_vector_multiuse_positive_equal_before icmp_eq_vector_multiuse_positive_equal_combined
  simp_alive_peephole
  sorry
def icmp_eq_vector_multiuse_negative_equal_combined := [llvmfunc|
  llvm.func @icmp_eq_vector_multiuse_negative_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-20> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.call @use.v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }]

theorem inst_combine_icmp_eq_vector_multiuse_negative_equal   : icmp_eq_vector_multiuse_negative_equal_before  ⊑  icmp_eq_vector_multiuse_negative_equal_combined := by
  unfold icmp_eq_vector_multiuse_negative_equal_before icmp_eq_vector_multiuse_negative_equal_combined
  simp_alive_peephole
  sorry
