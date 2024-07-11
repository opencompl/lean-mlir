import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-or-and
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.or %2, %3  : i32
    %5 = llvm.and %4, %0  : i32
    llvm.return %5 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %arg1, %0  : i32
    %2 = llvm.or %arg0, %1  : i32
    %3 = llvm.and %2, %0  : i32
    llvm.return %3 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

def or_test1_before := [llvmfunc|
  llvm.func @or_test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }]

def or_test2_before := [llvmfunc|
  llvm.func @or_test2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg0, %0  : i8
    %3 = llvm.or %2, %1  : i8
    llvm.return %3 : i8
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(65536 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def or_test1_combined := [llvmfunc|
  llvm.func @or_test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_or_test1   : or_test1_before  ⊑  or_test1_combined := by
  unfold or_test1_before or_test1_combined
  simp_alive_peephole
  sorry
def or_test2_combined := [llvmfunc|
  llvm.func @or_test2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    llvm.return %0 : i8
  }]

theorem inst_combine_or_test2   : or_test2_before  ⊑  or_test2_combined := by
  unfold or_test2_before or_test2_combined
  simp_alive_peephole
  sorry
