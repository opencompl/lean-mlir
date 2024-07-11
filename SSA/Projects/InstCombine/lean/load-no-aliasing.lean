import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  load-no-aliasing
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_load_store_load_combine_before := [llvmfunc|
  llvm.func @test_load_store_load_combine(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

    %1 = llvm.sitofp %0 : i32 to f32
    llvm.store %1, %arg1 {alignment = 4 : i64, tbaa = [#tbaa_tag1]} : f32, !llvm.ptr]

    %2 = llvm.load %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def test_load_store_load_combine_combined := [llvmfunc|
  llvm.func @test_load_store_load_combine(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    %1 = llvm.sitofp %0 : i32 to f32
    llvm.store %1, %arg1 {alignment = 4 : i64, tbaa = [#tbaa_tag1]} : f32, !llvm.ptr
    llvm.return %0 : i32
  }]

theorem inst_combine_test_load_store_load_combine   : test_load_store_load_combine_before  ⊑  test_load_store_load_combine_combined := by
  unfold test_load_store_load_combine_before test_load_store_load_combine_combined
  simp_alive_peephole
  sorry
