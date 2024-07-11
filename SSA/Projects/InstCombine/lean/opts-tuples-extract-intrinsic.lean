import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  opts-tuples-extract-intrinsic
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_extract_insert_same_idx_before := [llvmfunc|
  llvm.func @test_extract_insert_same_idx(%arg0: !llvm.vec<? x 64 x  i8>, %arg1: !llvm.vec<? x 16 x  i8>) -> !llvm.vec<? x 16 x  i8> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[48] : !llvm.vec<? x 16 x  i8> into !llvm.vec<? x 64 x  i8>
    %1 = llvm.intr.vector.extract %0[48] : !llvm.vec<? x 16 x  i8> from !llvm.vec<? x 64 x  i8>
    llvm.return %1 : !llvm.vec<? x 16 x  i8>
  }]

def test_extract_insert_dif_idx_before := [llvmfunc|
  llvm.func @test_extract_insert_dif_idx(%arg0: !llvm.vec<? x 64 x  i8>, %arg1: !llvm.vec<? x 16 x  i8>) -> !llvm.vec<? x 16 x  i8> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[48] : !llvm.vec<? x 16 x  i8> into !llvm.vec<? x 64 x  i8>
    %1 = llvm.intr.vector.extract %0[0] : !llvm.vec<? x 16 x  i8> from !llvm.vec<? x 64 x  i8>
    llvm.return %1 : !llvm.vec<? x 16 x  i8>
  }]

def neg_test_extract_insert_same_idx_dif_ret_size_before := [llvmfunc|
  llvm.func @neg_test_extract_insert_same_idx_dif_ret_size(%arg0: !llvm.vec<? x 64 x  i8>, %arg1: !llvm.vec<? x 16 x  i8>) -> !llvm.vec<? x 32 x  i8> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[32] : !llvm.vec<? x 16 x  i8> into !llvm.vec<? x 64 x  i8>
    %1 = llvm.intr.vector.extract %0[32] : !llvm.vec<? x 32 x  i8> from !llvm.vec<? x 64 x  i8>
    llvm.return %1 : !llvm.vec<? x 32 x  i8>
  }]

def test_extract_insert_same_idx_combined := [llvmfunc|
  llvm.func @test_extract_insert_same_idx(%arg0: !llvm.vec<? x 64 x  i8>, %arg1: !llvm.vec<? x 16 x  i8>) -> !llvm.vec<? x 16 x  i8> {
    llvm.return %arg1 : !llvm.vec<? x 16 x  i8>
  }]

theorem inst_combine_test_extract_insert_same_idx   : test_extract_insert_same_idx_before  ⊑  test_extract_insert_same_idx_combined := by
  unfold test_extract_insert_same_idx_before test_extract_insert_same_idx_combined
  simp_alive_peephole
  sorry
def test_extract_insert_dif_idx_combined := [llvmfunc|
  llvm.func @test_extract_insert_dif_idx(%arg0: !llvm.vec<? x 64 x  i8>, %arg1: !llvm.vec<? x 16 x  i8>) -> !llvm.vec<? x 16 x  i8> {
    %0 = llvm.intr.vector.extract %arg0[0] : !llvm.vec<? x 16 x  i8> from !llvm.vec<? x 64 x  i8>
    llvm.return %0 : !llvm.vec<? x 16 x  i8>
  }]

theorem inst_combine_test_extract_insert_dif_idx   : test_extract_insert_dif_idx_before  ⊑  test_extract_insert_dif_idx_combined := by
  unfold test_extract_insert_dif_idx_before test_extract_insert_dif_idx_combined
  simp_alive_peephole
  sorry
def neg_test_extract_insert_same_idx_dif_ret_size_combined := [llvmfunc|
  llvm.func @neg_test_extract_insert_same_idx_dif_ret_size(%arg0: !llvm.vec<? x 64 x  i8>, %arg1: !llvm.vec<? x 16 x  i8>) -> !llvm.vec<? x 32 x  i8> {
    %0 = llvm.intr.vector.insert %arg1, %arg0[32] : !llvm.vec<? x 16 x  i8> into !llvm.vec<? x 64 x  i8>
    %1 = llvm.intr.vector.extract %0[32] : !llvm.vec<? x 32 x  i8> from !llvm.vec<? x 64 x  i8>
    llvm.return %1 : !llvm.vec<? x 32 x  i8>
  }]

theorem inst_combine_neg_test_extract_insert_same_idx_dif_ret_size   : neg_test_extract_insert_same_idx_dif_ret_size_before  ⊑  neg_test_extract_insert_same_idx_dif_ret_size_combined := by
  unfold neg_test_extract_insert_same_idx_dif_ret_size_before neg_test_extract_insert_same_idx_dif_ret_size_combined
  simp_alive_peephole
  sorry
