import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def zext_before := [llvmfunc|
  llvm.func @zext(%arg0: i1) -> i41 {
    %0 = llvm.mlir.constant(1 : i41) : i41
    %1 = llvm.mlir.constant(0 : i41) : i41
    %2 = llvm.select %arg0, %0, %1 : i1, i41
    llvm.return %2 : i41
  }]

def sext_before := [llvmfunc|
  llvm.func @sext(%arg0: i1) -> i41 {
    %0 = llvm.mlir.constant(-1 : i41) : i41
    %1 = llvm.mlir.constant(0 : i41) : i41
    %2 = llvm.select %arg0, %0, %1 : i1, i41
    llvm.return %2 : i41
  }]

def not_zext_before := [llvmfunc|
  llvm.func @not_zext(%arg0: i1) -> i999 {
    %0 = llvm.mlir.constant(0 : i999) : i999
    %1 = llvm.mlir.constant(1 : i999) : i999
    %2 = llvm.select %arg0, %0, %1 : i1, i999
    llvm.return %2 : i999
  }]

def not_sext_before := [llvmfunc|
  llvm.func @not_sext(%arg0: i1) -> i999 {
    %0 = llvm.mlir.constant(0 : i999) : i999
    %1 = llvm.mlir.constant(-1 : i999) : i999
    %2 = llvm.select %arg0, %0, %1 : i1, i999
    llvm.return %2 : i999
  }]

def zext_vec_before := [llvmfunc|
  llvm.func @zext_vec(%arg0: vector<2xi1>) -> vector<2xi41> {
    %0 = llvm.mlir.constant(1 : i41) : i41
    %1 = llvm.mlir.constant(dense<1> : vector<2xi41>) : vector<2xi41>
    %2 = llvm.mlir.constant(0 : i41) : i41
    %3 = llvm.mlir.constant(dense<0> : vector<2xi41>) : vector<2xi41>
    %4 = llvm.select %arg0, %1, %3 : vector<2xi1>, vector<2xi41>
    llvm.return %4 : vector<2xi41>
  }]

def sext_vec_before := [llvmfunc|
  llvm.func @sext_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def not_zext_vec_before := [llvmfunc|
  llvm.func @not_zext_vec(%arg0: vector<2xi1>) -> vector<2xi999> {
    %0 = llvm.mlir.constant(0 : i999) : i999
    %1 = llvm.mlir.constant(dense<0> : vector<2xi999>) : vector<2xi999>
    %2 = llvm.mlir.constant(1 : i999) : i999
    %3 = llvm.mlir.constant(dense<1> : vector<2xi999>) : vector<2xi999>
    %4 = llvm.select %arg0, %1, %3 : vector<2xi1>, vector<2xi999>
    llvm.return %4 : vector<2xi999>
  }]

def not_sext_vec_before := [llvmfunc|
  llvm.func @not_sext_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.select %arg0, %1, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

def scalar_select_of_vectors_before := [llvmfunc|
  llvm.func @scalar_select_of_vectors(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %2 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i41) -> i41 {
    %0 = llvm.mlir.constant(0 : i41) : i41
    %1 = llvm.mlir.constant(-1 : i41) : i41
    %2 = llvm.icmp "slt" %arg0, %0 : i41
    %3 = llvm.select %2, %1, %0 : i1, i41
    llvm.return %3 : i41
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i1023) -> i1023 {
    %0 = llvm.mlir.constant(0 : i1023) : i1023
    %1 = llvm.mlir.constant(-1 : i1023) : i1023
    %2 = llvm.icmp "slt" %arg0, %0 : i1023
    %3 = llvm.select %2, %1, %0 : i1, i1023
    llvm.return %3 : i1023
  }]

def zext_combined := [llvmfunc|
  llvm.func @zext(%arg0: i1) -> i41 {
    %0 = llvm.zext %arg0 : i1 to i41
    llvm.return %0 : i41
  }]

theorem inst_combine_zext   : zext_before  ⊑  zext_combined := by
  unfold zext_before zext_combined
  simp_alive_peephole
  sorry
def sext_combined := [llvmfunc|
  llvm.func @sext(%arg0: i1) -> i41 {
    %0 = llvm.sext %arg0 : i1 to i41
    llvm.return %0 : i41
  }]

theorem inst_combine_sext   : sext_before  ⊑  sext_combined := by
  unfold sext_before sext_combined
  simp_alive_peephole
  sorry
def not_zext_combined := [llvmfunc|
  llvm.func @not_zext(%arg0: i1) -> i999 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.zext %1 : i1 to i999
    llvm.return %2 : i999
  }]

theorem inst_combine_not_zext   : not_zext_before  ⊑  not_zext_combined := by
  unfold not_zext_before not_zext_combined
  simp_alive_peephole
  sorry
def not_sext_combined := [llvmfunc|
  llvm.func @not_sext(%arg0: i1) -> i999 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.sext %1 : i1 to i999
    llvm.return %2 : i999
  }]

theorem inst_combine_not_sext   : not_sext_before  ⊑  not_sext_combined := by
  unfold not_sext_before not_sext_combined
  simp_alive_peephole
  sorry
def zext_vec_combined := [llvmfunc|
  llvm.func @zext_vec(%arg0: vector<2xi1>) -> vector<2xi41> {
    %0 = llvm.zext %arg0 : vector<2xi1> to vector<2xi41>
    llvm.return %0 : vector<2xi41>
  }]

theorem inst_combine_zext_vec   : zext_vec_before  ⊑  zext_vec_combined := by
  unfold zext_vec_before zext_vec_combined
  simp_alive_peephole
  sorry
def sext_vec_combined := [llvmfunc|
  llvm.func @sext_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_sext_vec   : sext_vec_before  ⊑  sext_vec_combined := by
  unfold sext_vec_before sext_vec_combined
  simp_alive_peephole
  sorry
def not_zext_vec_combined := [llvmfunc|
  llvm.func @not_zext_vec(%arg0: vector<2xi1>) -> vector<2xi999> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi999>
    llvm.return %3 : vector<2xi999>
  }]

theorem inst_combine_not_zext_vec   : not_zext_vec_before  ⊑  not_zext_vec_combined := by
  unfold not_zext_vec_before not_zext_vec_combined
  simp_alive_peephole
  sorry
def not_sext_vec_combined := [llvmfunc|
  llvm.func @not_sext_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.sext %2 : vector<2xi1> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }]

theorem inst_combine_not_sext_vec   : not_sext_vec_before  ⊑  not_sext_vec_combined := by
  unfold not_sext_vec_before not_sext_vec_combined
  simp_alive_peephole
  sorry
def scalar_select_of_vectors_combined := [llvmfunc|
  llvm.func @scalar_select_of_vectors(%arg0: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.select %arg0, %0, %2 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }]

theorem inst_combine_scalar_select_of_vectors   : scalar_select_of_vectors_before  ⊑  scalar_select_of_vectors_combined := by
  unfold scalar_select_of_vectors_before scalar_select_of_vectors_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i41) -> i41 {
    %0 = llvm.mlir.constant(40 : i41) : i41
    %1 = llvm.ashr %arg0, %0  : i41
    llvm.return %1 : i41
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i1023) -> i1023 {
    %0 = llvm.mlir.constant(1022 : i1023) : i1023
    %1 = llvm.ashr %arg0, %0  : i1023
    llvm.return %1 : i1023
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
