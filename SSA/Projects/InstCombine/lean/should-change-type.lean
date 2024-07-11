import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  should-change-type
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.zext %arg0 : i8 to i64
    %1 = llvm.zext %arg1 : i8 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i8
    llvm.return %3 : i8
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i64
    %1 = llvm.zext %arg1 : i16 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i16
    llvm.return %3 : i16
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i9, %arg1: i9) -> i9 {
    %0 = llvm.zext %arg0 : i9 to i64
    %1 = llvm.zext %arg1 : i9 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i9
    llvm.return %3 : i9
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.add %arg0, %arg1  : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.add %arg0, %arg1  : i16
    llvm.return %0 : i16
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i9, %arg1: i9) -> i9 {
    %0 = llvm.zext %arg0 : i9 to i64
    %1 = llvm.zext %arg1 : i9 to i64
    %2 = llvm.add %0, %1 overflow<nsw, nuw>  : i64
    %3 = llvm.trunc %2 : i64 to i9
    llvm.return %3 : i9
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
