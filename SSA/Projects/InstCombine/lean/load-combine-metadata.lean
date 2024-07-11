import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-combine-metadata
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_load_load_combine_metadata_before := [llvmfunc|
  llvm.func @test_load_load_combine_metadata(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.load %arg0 {alias_scopes = [#alias_scope], alignment = 4 : i64, noalias_scopes = [#alias_scope1], tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

    %1 = llvm.load %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %1, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def test_load_load_combine_metadata_combined := [llvmfunc|
  llvm.func @test_load_load_combine_metadata(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

theorem inst_combine_test_load_load_combine_metadata   : test_load_load_combine_metadata_before  ⊑  test_load_load_combine_metadata_combined := by
  unfold test_load_load_combine_metadata_before test_load_load_combine_metadata_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test_load_load_combine_metadata   : test_load_load_combine_metadata_before  ⊑  test_load_load_combine_metadata_combined := by
  unfold test_load_load_combine_metadata_before test_load_load_combine_metadata_combined
  simp_alive_peephole
  sorry
    llvm.store %0, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test_load_load_combine_metadata   : test_load_load_combine_metadata_before  ⊑  test_load_load_combine_metadata_combined := by
  unfold test_load_load_combine_metadata_before test_load_load_combine_metadata_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_load_load_combine_metadata   : test_load_load_combine_metadata_before  ⊑  test_load_load_combine_metadata_combined := by
  unfold test_load_load_combine_metadata_before test_load_load_combine_metadata_combined
  simp_alive_peephole
  sorry
