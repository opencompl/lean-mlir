import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  alloca-big
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_bigalloc_before := [llvmfunc|
  llvm.func @test_bigalloc(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(-4294967296 : i864) : i864
    %1 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i864) -> !llvm.ptr]

    llvm.store %1, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test_bigalloc_combined := [llvmfunc|
  llvm.func @test_bigalloc(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<0 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_test_bigalloc   : test_bigalloc_before  ⊑  test_bigalloc_combined := by
  unfold test_bigalloc_before test_bigalloc_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg0 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test_bigalloc   : test_bigalloc_before  ⊑  test_bigalloc_combined := by
  unfold test_bigalloc_before test_bigalloc_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_bigalloc   : test_bigalloc_before  ⊑  test_bigalloc_combined := by
  unfold test_bigalloc_before test_bigalloc_combined
  simp_alive_peephole
  sorry
