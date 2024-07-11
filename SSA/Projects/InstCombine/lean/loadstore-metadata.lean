import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  loadstore-metadata
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_load_cast_combine_tbaa_before := [llvmfunc|
  llvm.func @test_load_cast_combine_tbaa(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> f32]

    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test_load_cast_combine_noalias_before := [llvmfunc|
  llvm.func @test_load_cast_combine_noalias(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alias_scopes = [#alias_scope], alignment = 4 : i64, noalias_scopes = [#alias_scope]} : !llvm.ptr -> f32]

    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test_load_cast_combine_range_before := [llvmfunc|
  llvm.func @test_load_cast_combine_range(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.bitcast %0 : i32 to f32
    llvm.return %1 : f32
  }]

def test_load_cast_combine_invariant_before := [llvmfunc|
  llvm.func @test_load_cast_combine_invariant(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 invariant {alignment = 4 : i64} : !llvm.ptr -> f32]

    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test_load_cast_combine_nontemporal_before := [llvmfunc|
  llvm.func @test_load_cast_combine_nontemporal(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64, nontemporal} : !llvm.ptr -> f32]

    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test_load_cast_combine_align_before := [llvmfunc|
  llvm.func @test_load_cast_combine_align(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.return %0 : !llvm.ptr
  }]

def test_load_cast_combine_deref_before := [llvmfunc|
  llvm.func @test_load_cast_combine_deref(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.return %0 : !llvm.ptr
  }]

def test_load_cast_combine_deref_or_null_before := [llvmfunc|
  llvm.func @test_load_cast_combine_deref_or_null(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.return %0 : !llvm.ptr
  }]

def test_load_cast_combine_loop_before := [llvmfunc|
  llvm.func @test_load_cast_combine_loop(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.getelementptr inbounds %arg0[%2] : (!llvm.ptr, i32) -> !llvm.ptr, f32
    %4 = llvm.getelementptr inbounds %arg1[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %5 = llvm.load %3 {access_groups = [#access_group], alignment = 4 : i64} : !llvm.ptr -> f32]

    %6 = llvm.bitcast %5 : f32 to i32
    llvm.store %6, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %7 = llvm.add %2, %1  : i32
    %8 = llvm.icmp "slt" %7, %arg2 : i32
    llvm.cond_br %8, ^bb1(%7 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def test_load_cast_combine_nonnull_before := [llvmfunc|
  llvm.func @test_load_cast_combine_nonnull(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.ptr
    llvm.store %1, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  }]

def test_load_cast_combine_noundef_before := [llvmfunc|
  llvm.func @test_load_cast_combine_noundef(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %1 = llvm.bitcast %0 : f32 to i32
    llvm.return %1 : i32
  }]

def test_load_cast_combine_tbaa_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_tbaa(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

theorem inst_combine_test_load_cast_combine_tbaa   : test_load_cast_combine_tbaa_before  ⊑  test_load_cast_combine_tbaa_combined := by
  unfold test_load_cast_combine_tbaa_before test_load_cast_combine_tbaa_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_test_load_cast_combine_tbaa   : test_load_cast_combine_tbaa_before  ⊑  test_load_cast_combine_tbaa_combined := by
  unfold test_load_cast_combine_tbaa_before test_load_cast_combine_tbaa_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_noalias_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_noalias(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alias_scopes = [#alias_scope], alignment = 4 : i64, noalias_scopes = [#alias_scope]} : !llvm.ptr -> i32]

theorem inst_combine_test_load_cast_combine_noalias   : test_load_cast_combine_noalias_before  ⊑  test_load_cast_combine_noalias_combined := by
  unfold test_load_cast_combine_noalias_before test_load_cast_combine_noalias_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_test_load_cast_combine_noalias   : test_load_cast_combine_noalias_before  ⊑  test_load_cast_combine_noalias_combined := by
  unfold test_load_cast_combine_noalias_before test_load_cast_combine_noalias_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_range_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_range(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_test_load_cast_combine_range   : test_load_cast_combine_range_before  ⊑  test_load_cast_combine_range_combined := by
  unfold test_load_cast_combine_range_before test_load_cast_combine_range_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : f32
  }]

theorem inst_combine_test_load_cast_combine_range   : test_load_cast_combine_range_before  ⊑  test_load_cast_combine_range_combined := by
  unfold test_load_cast_combine_range_before test_load_cast_combine_range_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_invariant_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_invariant(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 invariant {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_load_cast_combine_invariant   : test_load_cast_combine_invariant_before  ⊑  test_load_cast_combine_invariant_combined := by
  unfold test_load_cast_combine_invariant_before test_load_cast_combine_invariant_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_test_load_cast_combine_invariant   : test_load_cast_combine_invariant_before  ⊑  test_load_cast_combine_invariant_combined := by
  unfold test_load_cast_combine_invariant_before test_load_cast_combine_invariant_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_nontemporal_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_nontemporal(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64, nontemporal} : !llvm.ptr -> i32]

theorem inst_combine_test_load_cast_combine_nontemporal   : test_load_cast_combine_nontemporal_before  ⊑  test_load_cast_combine_nontemporal_combined := by
  unfold test_load_cast_combine_nontemporal_before test_load_cast_combine_nontemporal_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_test_load_cast_combine_nontemporal   : test_load_cast_combine_nontemporal_before  ⊑  test_load_cast_combine_nontemporal_combined := by
  unfold test_load_cast_combine_nontemporal_before test_load_cast_combine_nontemporal_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_align_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_align(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test_load_cast_combine_align   : test_load_cast_combine_align_before  ⊑  test_load_cast_combine_align_combined := by
  unfold test_load_cast_combine_align_before test_load_cast_combine_align_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_load_cast_combine_align   : test_load_cast_combine_align_before  ⊑  test_load_cast_combine_align_combined := by
  unfold test_load_cast_combine_align_before test_load_cast_combine_align_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_deref_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_deref(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test_load_cast_combine_deref   : test_load_cast_combine_deref_before  ⊑  test_load_cast_combine_deref_combined := by
  unfold test_load_cast_combine_deref_before test_load_cast_combine_deref_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_load_cast_combine_deref   : test_load_cast_combine_deref_before  ⊑  test_load_cast_combine_deref_combined := by
  unfold test_load_cast_combine_deref_before test_load_cast_combine_deref_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_deref_or_null_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_deref_or_null(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test_load_cast_combine_deref_or_null   : test_load_cast_combine_deref_or_null_before  ⊑  test_load_cast_combine_deref_or_null_combined := by
  unfold test_load_cast_combine_deref_or_null_before test_load_cast_combine_deref_or_null_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : !llvm.ptr
  }]

theorem inst_combine_test_load_cast_combine_deref_or_null   : test_load_cast_combine_deref_or_null_before  ⊑  test_load_cast_combine_deref_or_null_combined := by
  unfold test_load_cast_combine_deref_or_null_before test_load_cast_combine_deref_or_null_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_loop_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_loop(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.sext %2 : i32 to i64
    %4 = llvm.getelementptr inbounds %arg0[%3] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %5 = llvm.sext %2 : i32 to i64
    %6 = llvm.getelementptr inbounds %arg1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %4 {access_groups = [#access_group], alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_load_cast_combine_loop   : test_load_cast_combine_loop_before  ⊑  test_load_cast_combine_loop_combined := by
  unfold test_load_cast_combine_loop_before test_load_cast_combine_loop_combined
  simp_alive_peephole
  sorry
    llvm.store %7, %6 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test_load_cast_combine_loop   : test_load_cast_combine_loop_before  ⊑  test_load_cast_combine_loop_combined := by
  unfold test_load_cast_combine_loop_before test_load_cast_combine_loop_combined
  simp_alive_peephole
  sorry
    %8 = llvm.add %2, %1  : i32
    %9 = llvm.icmp "slt" %8, %arg2 : i32
    llvm.cond_br %9, ^bb1(%8 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_test_load_cast_combine_loop   : test_load_cast_combine_loop_before  ⊑  test_load_cast_combine_loop_combined := by
  unfold test_load_cast_combine_loop_before test_load_cast_combine_loop_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_nonnull_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_nonnull(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_test_load_cast_combine_nonnull   : test_load_cast_combine_nonnull_before  ⊑  test_load_cast_combine_nonnull_combined := by
  unfold test_load_cast_combine_nonnull_before test_load_cast_combine_nonnull_combined
  simp_alive_peephole
  sorry
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.ptr
    llvm.store %1, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

theorem inst_combine_test_load_cast_combine_nonnull   : test_load_cast_combine_nonnull_before  ⊑  test_load_cast_combine_nonnull_combined := by
  unfold test_load_cast_combine_nonnull_before test_load_cast_combine_nonnull_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test_load_cast_combine_nonnull   : test_load_cast_combine_nonnull_before  ⊑  test_load_cast_combine_nonnull_combined := by
  unfold test_load_cast_combine_nonnull_before test_load_cast_combine_nonnull_combined
  simp_alive_peephole
  sorry
def test_load_cast_combine_noundef_combined := [llvmfunc|
  llvm.func @test_load_cast_combine_noundef(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test_load_cast_combine_noundef   : test_load_cast_combine_noundef_before  ⊑  test_load_cast_combine_noundef_combined := by
  unfold test_load_cast_combine_noundef_before test_load_cast_combine_noundef_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_test_load_cast_combine_noundef   : test_load_cast_combine_noundef_before  ⊑  test_load_cast_combine_noundef_combined := by
  unfold test_load_cast_combine_noundef_before test_load_cast_combine_noundef_combined
  simp_alive_peephole
  sorry
