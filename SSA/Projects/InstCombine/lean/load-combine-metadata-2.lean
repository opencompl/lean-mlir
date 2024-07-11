import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-combine-metadata-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_load_load_combine_metadata_before := [llvmfunc|
  llvm.func @test_load_load_combine_metadata(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %2 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %0, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test_load_load_combine_metadata_combined := [llvmfunc|
  llvm.func @test_load_load_combine_metadata(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test_load_load_combine_metadata   : test_load_load_combine_metadata_before  ⊑  test_load_load_combine_metadata_combined := by
  unfold test_load_load_combine_metadata_before test_load_load_combine_metadata_combined
  simp_alive_peephole
  sorry
