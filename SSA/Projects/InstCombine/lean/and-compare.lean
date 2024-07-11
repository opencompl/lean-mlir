import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-compare
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    llvm.return %3 : i1
  }]

def test1vec_before := [llvmfunc|
  llvm.func @test1vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.and %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def test2vec_before := [llvmfunc|
  llvm.func @test2vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.and %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

def test3vec_before := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.and %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

def test_ne_cp2_before := [llvmfunc|
  llvm.func @test_ne_cp2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

def test_ne_cp2_2_before := [llvmfunc|
  llvm.func @test_ne_cp2_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }]

def test_ne_cp2_other_okay_all_ones_before := [llvmfunc|
  llvm.func @test_ne_cp2_other_okay_all_ones(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

def test_ne_cp2_other_fail2_before := [llvmfunc|
  llvm.func @test_ne_cp2_other_fail2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

def test_ne_cp2_other_okay_before := [llvmfunc|
  llvm.func @test_ne_cp2_other_okay(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

def test_ne_cp2_other_okay2_before := [llvmfunc|
  llvm.func @test_ne_cp2_other_okay2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %2 : i8
    llvm.return %4 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %arg1  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.return %4 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test1vec_combined := [llvmfunc|
  llvm.func @test1vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.xor %arg0, %arg1  : vector<2xi32>
    %4 = llvm.and %3, %0  : vector<2xi32>
    %5 = llvm.icmp "ne" %4, %2 : vector<2xi32>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_test1vec   : test1vec_before  ⊑  test1vec_combined := by
  unfold test1vec_before test1vec_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test2vec_combined := [llvmfunc|
  llvm.func @test2vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.and %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test2vec   : test2vec_before  ⊑  test2vec_combined := by
  unfold test2vec_before test2vec_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3vec_combined := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.and %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test3vec   : test3vec_before  ⊑  test3vec_combined := by
  unfold test3vec_before test3vec_combined
  simp_alive_peephole
  sorry
def test_ne_cp2_combined := [llvmfunc|
  llvm.func @test_ne_cp2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_test_ne_cp2   : test_ne_cp2_before  ⊑  test_ne_cp2_combined := by
  unfold test_ne_cp2_before test_ne_cp2_combined
  simp_alive_peephole
  sorry
def test_ne_cp2_2_combined := [llvmfunc|
  llvm.func @test_ne_cp2_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_test_ne_cp2_2   : test_ne_cp2_2_before  ⊑  test_ne_cp2_2_combined := by
  unfold test_ne_cp2_2_before test_ne_cp2_2_combined
  simp_alive_peephole
  sorry
def test_ne_cp2_other_okay_all_ones_combined := [llvmfunc|
  llvm.func @test_ne_cp2_other_okay_all_ones(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_test_ne_cp2_other_okay_all_ones   : test_ne_cp2_other_okay_all_ones_before  ⊑  test_ne_cp2_other_okay_all_ones_combined := by
  unfold test_ne_cp2_other_okay_all_ones_before test_ne_cp2_other_okay_all_ones_combined
  simp_alive_peephole
  sorry
def test_ne_cp2_other_fail2_combined := [llvmfunc|
  llvm.func @test_ne_cp2_other_fail2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_test_ne_cp2_other_fail2   : test_ne_cp2_other_fail2_before  ⊑  test_ne_cp2_other_fail2_combined := by
  unfold test_ne_cp2_other_fail2_before test_ne_cp2_other_fail2_combined
  simp_alive_peephole
  sorry
def test_ne_cp2_other_okay_combined := [llvmfunc|
  llvm.func @test_ne_cp2_other_okay(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_test_ne_cp2_other_okay   : test_ne_cp2_other_okay_before  ⊑  test_ne_cp2_other_okay_combined := by
  unfold test_ne_cp2_other_okay_before test_ne_cp2_other_okay_combined
  simp_alive_peephole
  sorry
def test_ne_cp2_other_okay2_combined := [llvmfunc|
  llvm.func @test_ne_cp2_other_okay2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %2 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_test_ne_cp2_other_okay2   : test_ne_cp2_other_okay2_before  ⊑  test_ne_cp2_other_okay2_combined := by
  unfold test_ne_cp2_other_okay2_before test_ne_cp2_other_okay2_combined
  simp_alive_peephole
  sorry
