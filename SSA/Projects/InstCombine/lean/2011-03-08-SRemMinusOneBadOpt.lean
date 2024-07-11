import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2011-03-08-SRemMinusOneBadOpt
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i64) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4294967294 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.srem %3, %1  : i32
    llvm.return %4 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i64) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
