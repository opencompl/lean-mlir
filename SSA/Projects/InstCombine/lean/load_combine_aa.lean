import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load_combine_aa
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_load_combine_aa_before := [llvmfunc|
  llvm.func @test_load_combine_aa(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test_load_combine_aa_combined := [llvmfunc|
  llvm.func @test_load_combine_aa(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: !llvm.ptr {llvm.noalias}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_load_combine_aa   : test_load_combine_aa_before  ⊑  test_load_combine_aa_combined := by
  unfold test_load_combine_aa_before test_load_combine_aa_combined
  simp_alive_peephole
  sorry
