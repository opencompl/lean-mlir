import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-04-28-ShiftShiftLongLong
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.ashr %1, %0  : i64
    llvm.return %2 : i64
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    %2 = llvm.ashr %1, %0  : i64
    llvm.return %2 : i64
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
