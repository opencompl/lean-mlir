import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  no_sink_instruction
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.sdiv %arg1, %arg2  : i32
    %1 = llvm.add %arg2, %arg1  : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.sdiv %arg1, %arg2  : i32
    %1 = llvm.add %arg2, %arg1  : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i32
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
