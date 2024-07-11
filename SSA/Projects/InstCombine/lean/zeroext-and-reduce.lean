import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  zeroext-and-reduce
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(65544 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
