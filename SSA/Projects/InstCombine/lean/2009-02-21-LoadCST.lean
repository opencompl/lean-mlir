import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-02-21-LoadCST
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant("\B5%8\00") : !llvm.array<4 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant(3679669 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
