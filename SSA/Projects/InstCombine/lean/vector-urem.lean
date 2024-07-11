import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vector-urem
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_v4i32_splatconst_pow2_before := [llvmfunc|
  llvm.func @test_v4i32_splatconst_pow2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def test_v4i32_const_pow2_before := [llvmfunc|
  llvm.func @test_v4i32_const_pow2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def test_v4i32_const_pow2_poison_before := [llvmfunc|
  llvm.func @test_v4i32_const_pow2_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.urem %arg0, %12  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

def test_v4i32_one_before := [llvmfunc|
  llvm.func @test_v4i32_one(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %0, %arg0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def test_v4i32_one_poison_before := [llvmfunc|
  llvm.func @test_v4i32_one_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.urem %10, %arg0  : vector<4xi32>
    llvm.return %11 : vector<4xi32>
  }]

def test_v4i32_negconstsplat_before := [llvmfunc|
  llvm.func @test_v4i32_negconstsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def test_v4i32_negconst_before := [llvmfunc|
  llvm.func @test_v4i32_negconst(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-3, -5, -7, -9]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.urem %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def test_v4i32_negconst_poison_before := [llvmfunc|
  llvm.func @test_v4i32_negconst_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.mlir.constant(-5 : i32) : i32
    %3 = llvm.mlir.constant(-3 : i32) : i32
    %4 = llvm.mlir.undef : vector<4xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi32>
    %13 = llvm.urem %arg0, %12  : vector<4xi32>
    llvm.return %13 : vector<4xi32>
  }]

def test_v4i32_splatconst_pow2_combined := [llvmfunc|
  llvm.func @test_v4i32_splatconst_pow2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_test_v4i32_splatconst_pow2   : test_v4i32_splatconst_pow2_before  ⊑  test_v4i32_splatconst_pow2_combined := by
  unfold test_v4i32_splatconst_pow2_before test_v4i32_splatconst_pow2_combined
  simp_alive_peephole
  sorry
def test_v4i32_const_pow2_combined := [llvmfunc|
  llvm.func @test_v4i32_const_pow2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 1, 3, 7]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.and %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_test_v4i32_const_pow2   : test_v4i32_const_pow2_before  ⊑  test_v4i32_const_pow2_combined := by
  unfold test_v4i32_const_pow2_before test_v4i32_const_pow2_combined
  simp_alive_peephole
  sorry
def test_v4i32_const_pow2_poison_combined := [llvmfunc|
  llvm.func @test_v4i32_const_pow2_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_test_v4i32_const_pow2_poison   : test_v4i32_const_pow2_poison_before  ⊑  test_v4i32_const_pow2_poison_combined := by
  unfold test_v4i32_const_pow2_poison_before test_v4i32_const_pow2_poison_combined
  simp_alive_peephole
  sorry
def test_v4i32_one_combined := [llvmfunc|
  llvm.func @test_v4i32_one(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<4xi32>
    %2 = llvm.zext %1 : vector<4xi1> to vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_test_v4i32_one   : test_v4i32_one_before  ⊑  test_v4i32_one_combined := by
  unfold test_v4i32_one_before test_v4i32_one_combined
  simp_alive_peephole
  sorry
def test_v4i32_one_poison_combined := [llvmfunc|
  llvm.func @test_v4i32_one_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.icmp "ne" %arg0, %0 : vector<4xi32>
    %2 = llvm.zext %1 : vector<4xi1> to vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

theorem inst_combine_test_v4i32_one_poison   : test_v4i32_one_poison_before  ⊑  test_v4i32_one_poison_combined := by
  unfold test_v4i32_one_poison_before test_v4i32_one_poison_combined
  simp_alive_peephole
  sorry
def test_v4i32_negconstsplat_combined := [llvmfunc|
  llvm.func @test_v4i32_negconstsplat(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<-3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.freeze %arg0 : vector<4xi32>
    %3 = llvm.icmp "ult" %2, %0 : vector<4xi32>
    %4 = llvm.add %2, %1  : vector<4xi32>
    %5 = llvm.select %3, %2, %4 : vector<4xi1>, vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_test_v4i32_negconstsplat   : test_v4i32_negconstsplat_before  ⊑  test_v4i32_negconstsplat_combined := by
  unfold test_v4i32_negconstsplat_before test_v4i32_negconstsplat_combined
  simp_alive_peephole
  sorry
def test_v4i32_negconst_combined := [llvmfunc|
  llvm.func @test_v4i32_negconst(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[-3, -5, -7, -9]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<[3, 5, 7, 9]> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.freeze %arg0 : vector<4xi32>
    %3 = llvm.icmp "ult" %2, %0 : vector<4xi32>
    %4 = llvm.add %2, %1  : vector<4xi32>
    %5 = llvm.select %3, %2, %4 : vector<4xi1>, vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }]

theorem inst_combine_test_v4i32_negconst   : test_v4i32_negconst_before  ⊑  test_v4i32_negconst_combined := by
  unfold test_v4i32_negconst_before test_v4i32_negconst_combined
  simp_alive_peephole
  sorry
def test_v4i32_negconst_poison_combined := [llvmfunc|
  llvm.func @test_v4i32_negconst_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi32>
    llvm.return %0 : vector<4xi32>
  }]

theorem inst_combine_test_v4i32_negconst_poison   : test_v4i32_negconst_poison_before  ⊑  test_v4i32_negconst_poison_combined := by
  unfold test_v4i32_negconst_poison_before test_v4i32_negconst_poison_combined
  simp_alive_peephole
  sorry
