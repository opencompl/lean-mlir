import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-03-19-BadTruncChangePR1261
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i31) -> i16 {
    %0 = llvm.mlir.constant(16384 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.sext %arg0 : i31 to i32
    %3 = llvm.add %2, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.return %5 : i16
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i31) -> i16 {
    %0 = llvm.mlir.constant(16384 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.zext %arg0 : i31 to i32
    %3 = llvm.add %2, %0 overflow<nuw>  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.trunc %4 : i32 to i16
    llvm.return %5 : i16
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
