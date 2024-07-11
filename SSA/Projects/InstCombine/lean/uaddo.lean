import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  uaddo
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def uaddo_commute1_before := [llvmfunc|
  llvm.func @uaddo_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uaddo_commute2_before := [llvmfunc|
  llvm.func @uaddo_commute2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg1, %0  : vector<2xi32>
    %2 = llvm.add %arg1, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %arg0, %1 : vector<2xi32>
    %4 = llvm.select %3, %arg2, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def uaddo_commute3_before := [llvmfunc|
  llvm.func @uaddo_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uaddo_commute4_before := [llvmfunc|
  llvm.func @uaddo_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uaddo_commute5_before := [llvmfunc|
  llvm.func @uaddo_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }]

def uaddo_commute6_before := [llvmfunc|
  llvm.func @uaddo_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }]

def uaddo_commute7_before := [llvmfunc|
  llvm.func @uaddo_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }]

def uaddo_commute8_before := [llvmfunc|
  llvm.func @uaddo_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }]

def uaddo_wrong_pred1_before := [llvmfunc|
  llvm.func @uaddo_wrong_pred1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %arg0, %1 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uaddo_wrong_pred2_before := [llvmfunc|
  llvm.func @uaddo_wrong_pred2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "uge" %arg0, %1 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }]

def uaddo_1_before := [llvmfunc|
  llvm.func @uaddo_1(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

def uaddo_neg1_before := [llvmfunc|
  llvm.func @uaddo_neg1(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def uaddo_commute1_combined := [llvmfunc|
  llvm.func @uaddo_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uaddo_commute1   : uaddo_commute1_before  ⊑  uaddo_commute1_combined := by
  unfold uaddo_commute1_before uaddo_commute1_combined
  simp_alive_peephole
  sorry
def uaddo_commute2_combined := [llvmfunc|
  llvm.func @uaddo_commute2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg1, %0  : vector<2xi32>
    %2 = llvm.add %arg1, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ult" %1, %arg0 : vector<2xi32>
    %4 = llvm.select %3, %arg2, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

theorem inst_combine_uaddo_commute2   : uaddo_commute2_before  ⊑  uaddo_commute2_combined := by
  unfold uaddo_commute2_before uaddo_commute2_combined
  simp_alive_peephole
  sorry
def uaddo_commute3_combined := [llvmfunc|
  llvm.func @uaddo_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uaddo_commute3   : uaddo_commute3_before  ⊑  uaddo_commute3_combined := by
  unfold uaddo_commute3_before uaddo_commute3_combined
  simp_alive_peephole
  sorry
def uaddo_commute4_combined := [llvmfunc|
  llvm.func @uaddo_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uaddo_commute4   : uaddo_commute4_before  ⊑  uaddo_commute4_combined := by
  unfold uaddo_commute4_before uaddo_commute4_combined
  simp_alive_peephole
  sorry
def uaddo_commute5_combined := [llvmfunc|
  llvm.func @uaddo_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uaddo_commute5   : uaddo_commute5_before  ⊑  uaddo_commute5_combined := by
  unfold uaddo_commute5_before uaddo_commute5_combined
  simp_alive_peephole
  sorry
def uaddo_commute6_combined := [llvmfunc|
  llvm.func @uaddo_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uaddo_commute6   : uaddo_commute6_before  ⊑  uaddo_commute6_combined := by
  unfold uaddo_commute6_before uaddo_commute6_combined
  simp_alive_peephole
  sorry
def uaddo_commute7_combined := [llvmfunc|
  llvm.func @uaddo_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uaddo_commute7   : uaddo_commute7_before  ⊑  uaddo_commute7_combined := by
  unfold uaddo_commute7_before uaddo_commute7_combined
  simp_alive_peephole
  sorry
def uaddo_commute8_combined := [llvmfunc|
  llvm.func @uaddo_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uaddo_commute8   : uaddo_commute8_before  ⊑  uaddo_commute8_combined := by
  unfold uaddo_commute8_before uaddo_commute8_combined
  simp_alive_peephole
  sorry
def uaddo_wrong_pred1_combined := [llvmfunc|
  llvm.func @uaddo_wrong_pred1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ugt" %1, %arg0 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uaddo_wrong_pred1   : uaddo_wrong_pred1_before  ⊑  uaddo_wrong_pred1_combined := by
  unfold uaddo_wrong_pred1_before uaddo_wrong_pred1_combined
  simp_alive_peephole
  sorry
def uaddo_wrong_pred2_combined := [llvmfunc|
  llvm.func @uaddo_wrong_pred2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ugt" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }]

theorem inst_combine_uaddo_wrong_pred2   : uaddo_wrong_pred2_before  ⊑  uaddo_wrong_pred2_combined := by
  unfold uaddo_wrong_pred2_before uaddo_wrong_pred2_combined
  simp_alive_peephole
  sorry
def uaddo_1_combined := [llvmfunc|
  llvm.func @uaddo_1(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.store %2, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_uaddo_1   : uaddo_1_before  ⊑  uaddo_1_combined := by
  unfold uaddo_1_before uaddo_1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_uaddo_1   : uaddo_1_before  ⊑  uaddo_1_combined := by
  unfold uaddo_1_before uaddo_1_combined
  simp_alive_peephole
  sorry
def uaddo_neg1_combined := [llvmfunc|
  llvm.func @uaddo_neg1(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    llvm.store %2, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_uaddo_neg1   : uaddo_neg1_before  ⊑  uaddo_neg1_combined := by
  unfold uaddo_neg1_before uaddo_neg1_combined
  simp_alive_peephole
  sorry
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_uaddo_neg1   : uaddo_neg1_before  ⊑  uaddo_neg1_combined := by
  unfold uaddo_neg1_before uaddo_neg1_combined
  simp_alive_peephole
  sorry
