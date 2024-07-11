import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  compare-udiv
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.udiv %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test1vec_before := [llvmfunc|
  llvm.func @test1vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test2vec_before := [llvmfunc|
  llvm.func @test2vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[64, 63]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.udiv %0, %arg0  : vector<2xi32>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.udiv %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test3vec_before := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test4vec_before := [llvmfunc|
  llvm.func @test4vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[64, 65]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.udiv %0, %arg0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test5vec_before := [llvmfunc|
  llvm.func @test5vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.udiv %0, %arg0  : vector<2xi32>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test6vec_before := [llvmfunc|
  llvm.func @test6vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.udiv %0, %arg0  : vector<2xi32>
    %4 = llvm.icmp "ugt" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.icmp "ugt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test7vec_before := [llvmfunc|
  llvm.func @test7vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.udiv %0, %arg0  : vector<2xi32>
    %2 = llvm.icmp "ugt" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test8vec_before := [llvmfunc|
  llvm.func @test8vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test9vec_before := [llvmfunc|
  llvm.func @test9vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test10_before := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test10vec_before := [llvmfunc|
  llvm.func @test10vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test11_before := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test11vec_before := [llvmfunc|
  llvm.func @test11vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test12_before := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test12vec_before := [llvmfunc|
  llvm.func @test12vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test13_before := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test13vec_before := [llvmfunc|
  llvm.func @test13vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test14_before := [llvmfunc|
  llvm.func @test14(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.udiv %0, %arg0  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

def test14vec_before := [llvmfunc|
  llvm.func @test14vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.udiv %0, %arg0  : vector<2xi32>
    %2 = llvm.icmp "ult" %1, %0 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

def test15_before := [llvmfunc|
  llvm.func @test15(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test15vec_before := [llvmfunc|
  llvm.func @test15vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test16_before := [llvmfunc|
  llvm.func @test16(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.icmp "ult" %2, %1 : i32
    llvm.return %3 : i1
  }]

def test16vec_before := [llvmfunc|
  llvm.func @test16vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.udiv %0, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1vec_combined := [llvmfunc|
  llvm.func @test1vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : vector<2xi32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test1vec   : test1vec_before  ⊑  test1vec_combined := by
  unfold test1vec_before test1vec_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(64 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2vec_combined := [llvmfunc|
  llvm.func @test2vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[64, 63]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test2vec   : test2vec_before  ⊑  test2vec_combined := by
  unfold test2vec_before test2vec_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "ule" %arg1, %arg0 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3vec_combined := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.icmp "ule" %arg1, %arg0 : vector<2xi32>
    llvm.return %0 : vector<2xi1>
  }]

theorem inst_combine_test3vec   : test3vec_before  ⊑  test3vec_combined := by
  unfold test3vec_before test3vec_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(65 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test4vec_combined := [llvmfunc|
  llvm.func @test4vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[65, 66]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test4vec   : test4vec_before  ⊑  test4vec_combined := by
  unfold test4vec_before test4vec_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test5vec_combined := [llvmfunc|
  llvm.func @test5vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test5vec   : test5vec_before  ⊑  test5vec_combined := by
  unfold test5vec_before test5vec_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test6vec_combined := [llvmfunc|
  llvm.func @test6vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test6vec   : test6vec_before  ⊑  test6vec_combined := by
  unfold test6vec_before test6vec_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test7vec_combined := [llvmfunc|
  llvm.func @test7vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test7vec   : test7vec_before  ⊑  test7vec_combined := by
  unfold test7vec_before test7vec_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test8vec_combined := [llvmfunc|
  llvm.func @test8vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test8vec   : test8vec_before  ⊑  test8vec_combined := by
  unfold test8vec_before test8vec_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
def test9vec_combined := [llvmfunc|
  llvm.func @test9vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test9vec   : test9vec_before  ⊑  test9vec_combined := by
  unfold test9vec_before test9vec_combined
  simp_alive_peephole
  sorry
def test10_combined := [llvmfunc|
  llvm.func @test10(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test10   : test10_before  ⊑  test10_combined := by
  unfold test10_before test10_combined
  simp_alive_peephole
  sorry
def test10vec_combined := [llvmfunc|
  llvm.func @test10vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test10vec   : test10vec_before  ⊑  test10vec_combined := by
  unfold test10vec_before test10vec_combined
  simp_alive_peephole
  sorry
def test11_combined := [llvmfunc|
  llvm.func @test11(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test11   : test11_before  ⊑  test11_combined := by
  unfold test11_before test11_combined
  simp_alive_peephole
  sorry
def test11vec_combined := [llvmfunc|
  llvm.func @test11vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test11vec   : test11vec_before  ⊑  test11vec_combined := by
  unfold test11vec_before test11vec_combined
  simp_alive_peephole
  sorry
def test12_combined := [llvmfunc|
  llvm.func @test12(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test12   : test12_before  ⊑  test12_combined := by
  unfold test12_before test12_combined
  simp_alive_peephole
  sorry
def test12vec_combined := [llvmfunc|
  llvm.func @test12vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test12vec   : test12vec_before  ⊑  test12vec_combined := by
  unfold test12vec_before test12vec_combined
  simp_alive_peephole
  sorry
def test13_combined := [llvmfunc|
  llvm.func @test13(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test13   : test13_before  ⊑  test13_combined := by
  unfold test13_before test13_combined
  simp_alive_peephole
  sorry
def test13vec_combined := [llvmfunc|
  llvm.func @test13vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test13vec   : test13vec_before  ⊑  test13vec_combined := by
  unfold test13vec_before test13vec_combined
  simp_alive_peephole
  sorry
def test14_combined := [llvmfunc|
  llvm.func @test14(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test14   : test14_before  ⊑  test14_combined := by
  unfold test14_before test14_combined
  simp_alive_peephole
  sorry
def test14vec_combined := [llvmfunc|
  llvm.func @test14vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test14vec   : test14vec_before  ⊑  test14vec_combined := by
  unfold test14vec_before test14vec_combined
  simp_alive_peephole
  sorry
def test15_combined := [llvmfunc|
  llvm.func @test15(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test15   : test15_before  ⊑  test15_combined := by
  unfold test15_before test15_combined
  simp_alive_peephole
  sorry
def test15vec_combined := [llvmfunc|
  llvm.func @test15vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test15vec   : test15vec_before  ⊑  test15vec_combined := by
  unfold test15vec_before test15vec_combined
  simp_alive_peephole
  sorry
def test16_combined := [llvmfunc|
  llvm.func @test16(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test16   : test16_before  ⊑  test16_combined := by
  unfold test16_before test16_combined
  simp_alive_peephole
  sorry
def test16vec_combined := [llvmfunc|
  llvm.func @test16vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_test16vec   : test16vec_before  ⊑  test16vec_combined := by
  unfold test16vec_before test16vec_combined
  simp_alive_peephole
  sorry
