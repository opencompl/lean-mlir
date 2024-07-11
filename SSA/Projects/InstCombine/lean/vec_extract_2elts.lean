import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vec_extract_2elts
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: vector<4xi32>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : vector<4xi32> to vector<4xi64>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xi64>
    llvm.store %2, %arg1 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.store %2, %arg2 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: vector<4xi32>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<4xi32>
    %2 = llvm.zext %1 : i32 to i64
    llvm.store %2, %arg1 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.store %2, %arg2 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
