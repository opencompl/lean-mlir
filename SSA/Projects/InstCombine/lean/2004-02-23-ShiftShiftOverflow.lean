import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2004-02-23-ShiftShiftOverflow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    %2 = llvm.ashr %1, %0  : i32
    llvm.return %2 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.shl %arg0, %0  : i32
    %2 = llvm.shl %1, %0  : i32
    llvm.return %2 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.ashr %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
