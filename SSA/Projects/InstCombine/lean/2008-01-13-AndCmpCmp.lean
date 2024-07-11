import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-01-13-AndCmpCmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(34 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

def test_logical_before := [llvmfunc|
  llvm.func @test_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(34 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.icmp "ne" %arg0, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(34 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test_logical_combined := [llvmfunc|
  llvm.func @test_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(34 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_test_logical   : test_logical_before  ⊑  test_logical_combined := by
  unfold test_logical_before test_logical_combined
  simp_alive_peephole
  sorry
