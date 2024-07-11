import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-cast-and-cast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i43) -> i19 {
    %0 = llvm.mlir.constant(1 : i43) : i43
    %1 = llvm.bitcast %arg0 : i43 to i43
    %2 = llvm.and %1, %0  : i43
    %3 = llvm.trunc %2 : i43 to i19
    llvm.return %3 : i19
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i677) -> i73 {
    %0 = llvm.mlir.constant(1 : i677) : i677
    %1 = llvm.bitcast %arg0 : i677 to i677
    %2 = llvm.and %1, %0  : i677
    %3 = llvm.trunc %2 : i677 to i73
    llvm.return %3 : i73
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i43) -> i19 {
    %0 = llvm.mlir.constant(1 : i19) : i19
    %1 = llvm.trunc %arg0 : i43 to i19
    %2 = llvm.and %1, %0  : i19
    llvm.return %2 : i19
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i677) -> i73 {
    %0 = llvm.mlir.constant(1 : i73) : i73
    %1 = llvm.trunc %arg0 : i677 to i73
    %2 = llvm.and %1, %0  : i73
    llvm.return %2 : i73
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
