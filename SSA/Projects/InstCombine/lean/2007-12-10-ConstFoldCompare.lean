import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-12-10-ConstFoldCompare
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test() -> i1 {
    %0 = llvm.mlir.constant(4294967297 : i64) : i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    %2 = llvm.mlir.constant(5 : i64) : i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    %4 = llvm.icmp "ule" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def test_combined := [llvmfunc|
  llvm.func @test() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
