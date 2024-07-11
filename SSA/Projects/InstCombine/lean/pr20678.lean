import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr20678
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, true, true, true, true, true, true, true, false, false, false, false, false, false, false, false]> : vector<16xi1>) : vector<16xi1>
    %3 = llvm.bitcast %2 : vector<16xi1> to i16
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.icmp "ne" %3, %4 : i16
    llvm.return %5 : i1
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
