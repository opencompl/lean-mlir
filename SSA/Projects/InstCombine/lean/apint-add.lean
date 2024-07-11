import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-add
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    %2 = llvm.add %1, %0  : i1
    llvm.return %2 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i47) -> i47 {
    %0 = llvm.mlir.constant(-70368744177664 : i47) : i47
    %1 = llvm.xor %arg0, %0  : i47
    %2 = llvm.add %1, %0  : i47
    llvm.return %2 : i47
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i15) -> i15 {
    %0 = llvm.mlir.constant(-16384 : i15) : i15
    %1 = llvm.xor %arg0, %0  : i15
    %2 = llvm.add %1, %0  : i15
    llvm.return %2 : i15
  }]

def test3vec_before := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi5>) -> vector<2xi5> {
    %0 = llvm.mlir.constant(-16 : i5) : i5
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.add %arg0, %1  : vector<2xi5>
    llvm.return %2 : vector<2xi5>
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i49) -> i49 {
    %0 = llvm.mlir.constant(-2 : i49) : i49
    %1 = llvm.mlir.constant(1 : i49) : i49
    %2 = llvm.and %arg0, %0  : i49
    %3 = llvm.add %2, %1  : i49
    llvm.return %3 : i49
  }]

def sext_before := [llvmfunc|
  llvm.func @sext(%arg0: i4) -> i7 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i7) : i7
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.zext %2 : i4 to i7
    %4 = llvm.add %3, %1 overflow<nsw>  : i7
    llvm.return %4 : i7
  }]

def sext_vec_before := [llvmfunc|
  llvm.func @sext_vec(%arg0: vector<2xi3>) -> vector<2xi10> {
    %0 = llvm.mlir.constant(-4 : i3) : i3
    %1 = llvm.mlir.constant(dense<-4> : vector<2xi3>) : vector<2xi3>
    %2 = llvm.mlir.constant(-4 : i10) : i10
    %3 = llvm.mlir.constant(dense<-4> : vector<2xi10>) : vector<2xi10>
    %4 = llvm.xor %arg0, %1  : vector<2xi3>
    %5 = llvm.zext %4 : vector<2xi3> to vector<2xi10>
    %6 = llvm.add %5, %3 overflow<nsw>  : vector<2xi10>
    llvm.return %6 : vector<2xi10>
  }]

def sext_multiuse_before := [llvmfunc|
  llvm.func @sext_multiuse(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i7) : i7
    %2 = llvm.xor %arg0, %0  : i4
    %3 = llvm.zext %2 : i4 to i7
    %4 = llvm.add %3, %1 overflow<nsw>  : i7
    %5 = llvm.sdiv %3, %4  : i7
    %6 = llvm.trunc %5 : i7 to i4
    %7 = llvm.sdiv %6, %2  : i4
    llvm.return %7 : i4
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i111) -> i111 {
    %0 = llvm.mlir.constant(1 : i111) : i111
    %1 = llvm.mlir.constant(110 : i111) : i111
    %2 = llvm.shl %0, %1  : i111
    %3 = llvm.xor %arg0, %2  : i111
    %4 = llvm.add %3, %2  : i111
    llvm.return %4 : i111
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: i65) -> i65 {
    %0 = llvm.mlir.constant(1 : i65) : i65
    %1 = llvm.mlir.constant(64 : i65) : i65
    %2 = llvm.shl %0, %1  : i65
    %3 = llvm.xor %arg0, %2  : i65
    %4 = llvm.add %3, %2  : i65
    llvm.return %4 : i65
  }]

def test7_before := [llvmfunc|
  llvm.func @test7(%arg0: i1024) -> i1024 {
    %0 = llvm.mlir.constant(1 : i1024) : i1024
    %1 = llvm.mlir.constant(1023 : i1024) : i1024
    %2 = llvm.shl %0, %1  : i1024
    %3 = llvm.xor %arg0, %2  : i1024
    %4 = llvm.add %3, %2  : i1024
    llvm.return %4 : i1024
  }]

def test8_before := [llvmfunc|
  llvm.func @test8(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(1 : i128) : i128
    %1 = llvm.mlir.constant(127 : i128) : i128
    %2 = llvm.mlir.constant(120 : i128) : i128
    %3 = llvm.shl %0, %1  : i128
    %4 = llvm.ashr %3, %2  : i128
    %5 = llvm.xor %arg0, %4  : i128
    %6 = llvm.add %5, %3  : i128
    llvm.return %6 : i128
  }]

def test9_before := [llvmfunc|
  llvm.func @test9(%arg0: i77) -> i77 {
    %0 = llvm.mlir.constant(562949953421310 : i77) : i77
    %1 = llvm.mlir.constant(1 : i77) : i77
    %2 = llvm.and %arg0, %0  : i77
    %3 = llvm.add %2, %1  : i77
    llvm.return %3 : i77
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i1) -> i1 {
    llvm.return %arg0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i47) -> i47 {
    llvm.return %arg0 : i47
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i15) -> i15 {
    llvm.return %arg0 : i15
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test3vec_combined := [llvmfunc|
  llvm.func @test3vec(%arg0: vector<2xi5>) -> vector<2xi5> {
    %0 = llvm.mlir.constant(-16 : i5) : i5
    %1 = llvm.mlir.constant(dense<-16> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.xor %arg0, %1  : vector<2xi5>
    llvm.return %2 : vector<2xi5>
  }]

theorem inst_combine_test3vec   : test3vec_before  ⊑  test3vec_combined := by
  unfold test3vec_before test3vec_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i49) -> i49 {
    %0 = llvm.mlir.constant(1 : i49) : i49
    %1 = llvm.or %arg0, %0  : i49
    llvm.return %1 : i49
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def sext_combined := [llvmfunc|
  llvm.func @sext(%arg0: i4) -> i7 {
    %0 = llvm.sext %arg0 : i4 to i7
    llvm.return %0 : i7
  }]

theorem inst_combine_sext   : sext_before  ⊑  sext_combined := by
  unfold sext_before sext_combined
  simp_alive_peephole
  sorry
def sext_vec_combined := [llvmfunc|
  llvm.func @sext_vec(%arg0: vector<2xi3>) -> vector<2xi10> {
    %0 = llvm.sext %arg0 : vector<2xi3> to vector<2xi10>
    llvm.return %0 : vector<2xi10>
  }]

theorem inst_combine_sext_vec   : sext_vec_before  ⊑  sext_vec_combined := by
  unfold sext_vec_before sext_vec_combined
  simp_alive_peephole
  sorry
def sext_multiuse_combined := [llvmfunc|
  llvm.func @sext_multiuse(%arg0: i4) -> i4 {
    %0 = llvm.mlir.constant(-8 : i4) : i4
    %1 = llvm.xor %arg0, %0  : i4
    %2 = llvm.zext %1 : i4 to i7
    %3 = llvm.sext %arg0 : i4 to i7
    %4 = llvm.sdiv %2, %3  : i7
    %5 = llvm.trunc %4 : i7 to i4
    %6 = llvm.sdiv %5, %1  : i4
    llvm.return %6 : i4
  }]

theorem inst_combine_sext_multiuse   : sext_multiuse_before  ⊑  sext_multiuse_combined := by
  unfold sext_multiuse_before sext_multiuse_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i111) -> i111 {
    llvm.return %arg0 : i111
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: i65) -> i65 {
    llvm.return %arg0 : i65
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
def test7_combined := [llvmfunc|
  llvm.func @test7(%arg0: i1024) -> i1024 {
    llvm.return %arg0 : i1024
  }]

theorem inst_combine_test7   : test7_before  ⊑  test7_combined := by
  unfold test7_before test7_combined
  simp_alive_peephole
  sorry
def test8_combined := [llvmfunc|
  llvm.func @test8(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(170141183460469231731687303715884105600 : i128) : i128
    %1 = llvm.xor %arg0, %0  : i128
    llvm.return %1 : i128
  }]

theorem inst_combine_test8   : test8_before  ⊑  test8_combined := by
  unfold test8_before test8_combined
  simp_alive_peephole
  sorry
def test9_combined := [llvmfunc|
  llvm.func @test9(%arg0: i77) -> i77 {
    %0 = llvm.mlir.constant(562949953421310 : i77) : i77
    %1 = llvm.mlir.constant(1 : i77) : i77
    %2 = llvm.and %arg0, %0  : i77
    %3 = llvm.or %2, %1  : i77
    llvm.return %3 : i77
  }]

theorem inst_combine_test9   : test9_before  ⊑  test9_combined := by
  unfold test9_before test9_combined
  simp_alive_peephole
  sorry
