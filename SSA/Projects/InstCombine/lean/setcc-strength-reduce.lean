import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  setcc-strength-reduce
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
