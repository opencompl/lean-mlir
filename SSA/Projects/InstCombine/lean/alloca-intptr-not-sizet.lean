import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  alloca-intptr-not-sizet
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_array_alloca_intptr_not_sizet_before := [llvmfunc|
  llvm.func @test_array_alloca_intptr_not_sizet(%arg0: i64, %arg1: !llvm.ptr) {
    %0 = llvm.alloca %arg0 x i8 {alignment = 1 : i64} : (i64) -> !llvm.ptr<7>]

    llvm.store %0, %arg1 {alignment = 16 : i64} : !llvm.ptr<7>, !llvm.ptr]

    llvm.return
  }]

def test_array_alloca_intptr_not_sizet_combined := [llvmfunc|
  llvm.func @test_array_alloca_intptr_not_sizet(%arg0: i64, %arg1: !llvm.ptr) {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr<7>]

theorem inst_combine_test_array_alloca_intptr_not_sizet   : test_array_alloca_intptr_not_sizet_before  ⊑  test_array_alloca_intptr_not_sizet_combined := by
  unfold test_array_alloca_intptr_not_sizet_before test_array_alloca_intptr_not_sizet_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg1 {alignment = 16 : i64} : !llvm.ptr<7>, !llvm.ptr]

theorem inst_combine_test_array_alloca_intptr_not_sizet   : test_array_alloca_intptr_not_sizet_before  ⊑  test_array_alloca_intptr_not_sizet_combined := by
  unfold test_array_alloca_intptr_not_sizet_before test_array_alloca_intptr_not_sizet_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_array_alloca_intptr_not_sizet   : test_array_alloca_intptr_not_sizet_before  ⊑  test_array_alloca_intptr_not_sizet_combined := by
  unfold test_array_alloca_intptr_not_sizet_before test_array_alloca_intptr_not_sizet_combined
  simp_alive_peephole
  sorry
