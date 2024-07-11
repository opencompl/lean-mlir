import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  apint-not
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i33) -> i33 {
    %0 = llvm.mlir.constant(-1 : i33) : i33
    %1 = llvm.xor %arg0, %0  : i33
    %2 = llvm.xor %1, %0  : i33
    llvm.return %2 : i33
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i52, %arg1: i52) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "ule" %arg0, %arg1 : i52
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i33) -> i33 {
    llvm.return %arg0 : i33
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i52, %arg1: i52) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i52
    llvm.return %0 : i1
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
