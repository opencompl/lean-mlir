import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  obfuscated_splat
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_undef_before := [llvmfunc|
  llvm.func @test_undef(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : vector<4xf32>
    %1 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>]

    %2 = llvm.shufflevector %1, %0 [0, 0, -1, -1] : vector<4xf32> 
    %3 = llvm.shufflevector %2, %1 [0, 1, 4, -1] : vector<4xf32> 
    %4 = llvm.shufflevector %3, %1 [0, 1, 2, 4] : vector<4xf32> 
    llvm.store %4, %arg1 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr]

    llvm.return
  }]

def test_poison_before := [llvmfunc|
  llvm.func @test_poison(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>]

    %2 = llvm.shufflevector %1, %0 [0, 0, -1, -1] : vector<4xf32> 
    %3 = llvm.shufflevector %2, %1 [0, 1, 4, -1] : vector<4xf32> 
    %4 = llvm.shufflevector %3, %1 [0, 1, 2, 4] : vector<4xf32> 
    llvm.store %4, %arg1 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr]

    llvm.return
  }]

def test_undef_combined := [llvmfunc|
  llvm.func @test_undef(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>]

theorem inst_combine_test_undef   : test_undef_before  ⊑  test_undef_combined := by
  unfold test_undef_before test_undef_combined
  simp_alive_peephole
  sorry
    %2 = llvm.shufflevector %1, %0 [0, 0, 0, 0] : vector<4xf32> 
    llvm.store %2, %arg1 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr]

theorem inst_combine_test_undef   : test_undef_before  ⊑  test_undef_combined := by
  unfold test_undef_before test_undef_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_undef   : test_undef_before  ⊑  test_undef_combined := by
  unfold test_undef_before test_undef_combined
  simp_alive_peephole
  sorry
def test_poison_combined := [llvmfunc|
  llvm.func @test_poison(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>]

theorem inst_combine_test_poison   : test_poison_before  ⊑  test_poison_combined := by
  unfold test_poison_before test_poison_combined
  simp_alive_peephole
  sorry
    %2 = llvm.shufflevector %1, %0 [0, 0, 0, 0] : vector<4xf32> 
    llvm.store %2, %arg1 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr]

theorem inst_combine_test_poison   : test_poison_before  ⊑  test_poison_combined := by
  unfold test_poison_before test_poison_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_poison   : test_poison_before  ⊑  test_poison_combined := by
  unfold test_poison_before test_poison_combined
  simp_alive_peephole
  sorry
