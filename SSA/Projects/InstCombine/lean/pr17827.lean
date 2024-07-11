import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr17827
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_shift_and_cmp_not_changed1_before := [llvmfunc|
  llvm.func @test_shift_and_cmp_not_changed1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %2 : i8
    llvm.return %5 : i1
  }]

def test_shift_and_cmp_not_changed2_before := [llvmfunc|
  llvm.func @test_shift_and_cmp_not_changed2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.ashr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %2 : i8
    llvm.return %5 : i1
  }]

def test_shift_and_cmp_changed1_before := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(8 : i8) : i8
    %2 = llvm.mlir.constant(5 : i8) : i8
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.and %arg0, %0  : i8
    %5 = llvm.and %arg1, %1  : i8
    %6 = llvm.or %5, %4  : i8
    %7 = llvm.shl %6, %2  : i8
    %8 = llvm.ashr %7, %2  : i8
    %9 = llvm.icmp "slt" %8, %3 : i8
    llvm.return %9 : i1
  }]

def test_shift_and_cmp_changed1_vec_before := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.and %arg0, %0  : vector<2xi8>
    %5 = llvm.and %arg1, %1  : vector<2xi8>
    %6 = llvm.or %5, %4  : vector<2xi8>
    %7 = llvm.shl %6, %2  : vector<2xi8>
    %8 = llvm.ashr %7, %2  : vector<2xi8>
    %9 = llvm.icmp "slt" %8, %3 : vector<2xi8>
    llvm.return %9 : vector<2xi1>
  }]

def test_shift_and_cmp_changed2_before := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "ult" %4, %2 : i8
    llvm.return %5 : i1
  }]

def test_shift_and_cmp_changed2_vec_before := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed2_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %1  : vector<2xi8>
    %5 = llvm.icmp "ult" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def test_shift_and_cmp_changed3_before := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %2 : i8
    llvm.return %5 : i1
  }]

def test_shift_and_cmp_changed4_before := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.lshr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %2 : i8
    llvm.return %5 : i1
  }]

def test_shift_and_cmp_not_changed1_combined := [llvmfunc|
  llvm.func @test_shift_and_cmp_not_changed1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_test_shift_and_cmp_not_changed1   : test_shift_and_cmp_not_changed1_before  ⊑  test_shift_and_cmp_not_changed1_combined := by
  unfold test_shift_and_cmp_not_changed1_before test_shift_and_cmp_not_changed1_combined
  simp_alive_peephole
  sorry
def test_shift_and_cmp_not_changed2_combined := [llvmfunc|
  llvm.func @test_shift_and_cmp_not_changed2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.ashr %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_test_shift_and_cmp_not_changed2   : test_shift_and_cmp_not_changed2_before  ⊑  test_shift_and_cmp_not_changed2_combined := by
  unfold test_shift_and_cmp_not_changed2_before test_shift_and_cmp_not_changed2_combined
  simp_alive_peephole
  sorry
def test_shift_and_cmp_changed1_combined := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.shl %arg0, %0  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_test_shift_and_cmp_changed1   : test_shift_and_cmp_changed1_before  ⊑  test_shift_and_cmp_changed1_combined := by
  unfold test_shift_and_cmp_changed1_before test_shift_and_cmp_changed1_combined
  simp_alive_peephole
  sorry
def test_shift_and_cmp_changed1_vec_combined := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed1_vec(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-64> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<32> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.shl %arg0, %0  : vector<2xi8>
    %4 = llvm.and %3, %1  : vector<2xi8>
    %5 = llvm.icmp "slt" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

theorem inst_combine_test_shift_and_cmp_changed1_vec   : test_shift_and_cmp_changed1_vec_before  ⊑  test_shift_and_cmp_changed1_vec_combined := by
  unfold test_shift_and_cmp_changed1_vec_before test_shift_and_cmp_changed1_vec_combined
  simp_alive_peephole
  sorry
def test_shift_and_cmp_changed2_combined := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_test_shift_and_cmp_changed2   : test_shift_and_cmp_changed2_before  ⊑  test_shift_and_cmp_changed2_combined := by
  unfold test_shift_and_cmp_changed2_before test_shift_and_cmp_changed2_combined
  simp_alive_peephole
  sorry
def test_shift_and_cmp_changed2_vec_combined := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed2_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.and %arg0, %0  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

theorem inst_combine_test_shift_and_cmp_changed2_vec   : test_shift_and_cmp_changed2_vec_before  ⊑  test_shift_and_cmp_changed2_vec_combined := by
  unfold test_shift_and_cmp_changed2_vec_before test_shift_and_cmp_changed2_vec_combined
  simp_alive_peephole
  sorry
def test_shift_and_cmp_changed3_combined := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.shl %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.icmp "slt" %4, %2 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_test_shift_and_cmp_changed3   : test_shift_and_cmp_changed3_before  ⊑  test_shift_and_cmp_changed3_combined := by
  unfold test_shift_and_cmp_changed3_before test_shift_and_cmp_changed3_combined
  simp_alive_peephole
  sorry
def test_shift_and_cmp_changed4_combined := [llvmfunc|
  llvm.func @test_shift_and_cmp_changed4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_shift_and_cmp_changed4   : test_shift_and_cmp_changed4_before  ⊑  test_shift_and_cmp_changed4_combined := by
  unfold test_shift_and_cmp_changed4_before test_shift_and_cmp_changed4_combined
  simp_alive_peephole
  sorry
