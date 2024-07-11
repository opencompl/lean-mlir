import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-03-13-CompareMerge
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    %2 = llvm.or %0, %1  : i1
    llvm.return %2 : i1
  }]

def test_logical_before := [llvmfunc|
  llvm.func @test_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test_logical_combined := [llvmfunc|
  llvm.func @test_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i32
    llvm.return %0 : i1
  }]

theorem inst_combine_test_logical   : test_logical_before  ⊑  test_logical_combined := by
  unfold test_logical_before test_logical_combined
  simp_alive_peephole
  sorry
