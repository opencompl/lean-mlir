import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gepofconstgepi8
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_zero_before := [llvmfunc|
  llvm.func @test_zero(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_nonzero_before := [llvmfunc|
  llvm.func @test_nonzero(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_or_disjoint_before := [llvmfunc|
  llvm.func @test_or_disjoint(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.or %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_zero_multiuse_index_before := [llvmfunc|
  llvm.func @test_zero_multiuse_index(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_zero_multiuse_ptr_before := [llvmfunc|
  llvm.func @test_zero_multiuse_ptr(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @useptr(%2) : (!llvm.ptr) -> ()
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_zero_sext_add_nsw_before := [llvmfunc|
  llvm.func @test_zero_sext_add_nsw(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1 overflow<nsw>  : i32
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_zero_trunc_add_before := [llvmfunc|
  llvm.func @test_zero_trunc_add(%arg0: !llvm.ptr, %arg1: i128) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i128) : i128
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i128
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i128) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_non_i8_before := [llvmfunc|
  llvm.func @test_non_i8(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_non_const_before := [llvmfunc|
  llvm.func @test_non_const(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.add %arg1, %0  : i64
    %3 = llvm.getelementptr %1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

def test_too_many_indices_before := [llvmfunc|
  llvm.func @test_too_many_indices(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.add %arg1, %0  : i64
    %3 = llvm.getelementptr %1[%0, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i32>
    llvm.return %3 : !llvm.ptr
  }]

def test_wrong_op_before := [llvmfunc|
  llvm.func @test_wrong_op(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.xor %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_sext_add_without_nsw_before := [llvmfunc|
  llvm.func @test_sext_add_without_nsw(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i32
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_or_without_disjoint_before := [llvmfunc|
  llvm.func @test_or_without_disjoint(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.or %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_smul_overflow_before := [llvmfunc|
  llvm.func @test_smul_overflow(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(9223372036854775806 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_sadd_overflow_before := [llvmfunc|
  llvm.func @test_sadd_overflow(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(9223372036854775804 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_nonzero_multiuse_index_before := [llvmfunc|
  llvm.func @test_nonzero_multiuse_index(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_nonzero_multiuse_ptr_before := [llvmfunc|
  llvm.func @test_nonzero_multiuse_ptr(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @useptr(%2) : (!llvm.ptr) -> ()
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

def test_scalable_before := [llvmfunc|
  llvm.func @test_scalable(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    llvm.return %4 : !llvm.ptr
  }]

def test_zero_combined := [llvmfunc|
  llvm.func @test_zero(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_zero   : test_zero_before  ⊑  test_zero_combined := by
  unfold test_zero_before test_zero_combined
  simp_alive_peephole
  sorry
def test_nonzero_combined := [llvmfunc|
  llvm.func @test_nonzero(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_nonzero   : test_nonzero_before  ⊑  test_nonzero_combined := by
  unfold test_nonzero_before test_nonzero_combined
  simp_alive_peephole
  sorry
def test_or_disjoint_combined := [llvmfunc|
  llvm.func @test_or_disjoint(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.or %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_or_disjoint   : test_or_disjoint_before  ⊑  test_or_disjoint_combined := by
  unfold test_or_disjoint_before test_or_disjoint_combined
  simp_alive_peephole
  sorry
def test_zero_multiuse_index_combined := [llvmfunc|
  llvm.func @test_zero_multiuse_index(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_zero_multiuse_index   : test_zero_multiuse_index_before  ⊑  test_zero_multiuse_index_combined := by
  unfold test_zero_multiuse_index_before test_zero_multiuse_index_combined
  simp_alive_peephole
  sorry
def test_zero_multiuse_ptr_combined := [llvmfunc|
  llvm.func @test_zero_multiuse_ptr(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @useptr(%2) : (!llvm.ptr) -> ()
    %3 = llvm.getelementptr %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_zero_multiuse_ptr   : test_zero_multiuse_ptr_before  ⊑  test_zero_multiuse_ptr_combined := by
  unfold test_zero_multiuse_ptr_before test_zero_multiuse_ptr_combined
  simp_alive_peephole
  sorry
def test_zero_sext_add_nsw_combined := [llvmfunc|
  llvm.func @test_zero_sext_add_nsw(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.sext %arg1 : i32 to i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %5 = llvm.getelementptr %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_test_zero_sext_add_nsw   : test_zero_sext_add_nsw_before  ⊑  test_zero_sext_add_nsw_combined := by
  unfold test_zero_sext_add_nsw_before test_zero_sext_add_nsw_combined
  simp_alive_peephole
  sorry
def test_zero_trunc_add_combined := [llvmfunc|
  llvm.func @test_zero_trunc_add(%arg0: !llvm.ptr, %arg1: i128) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.trunc %arg1 : i128 to i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %5 = llvm.getelementptr %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_test_zero_trunc_add   : test_zero_trunc_add_before  ⊑  test_zero_trunc_add_combined := by
  unfold test_zero_trunc_add_before test_zero_trunc_add_combined
  simp_alive_peephole
  sorry
def test_non_i8_combined := [llvmfunc|
  llvm.func @test_non_i8(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    %3 = llvm.getelementptr %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_non_i8   : test_non_i8_before  ⊑  test_non_i8_combined := by
  unfold test_non_i8_before test_non_i8_combined
  simp_alive_peephole
  sorry
def test_non_const_combined := [llvmfunc|
  llvm.func @test_non_const(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.getelementptr %1[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test_non_const   : test_non_const_before  ⊑  test_non_const_combined := by
  unfold test_non_const_before test_non_const_combined
  simp_alive_peephole
  sorry
def test_too_many_indices_combined := [llvmfunc|
  llvm.func @test_too_many_indices(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.add %arg1, %0  : i64
    %3 = llvm.getelementptr %1[%0, %2] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<8 x i32>
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test_too_many_indices   : test_too_many_indices_before  ⊑  test_too_many_indices_combined := by
  unfold test_too_many_indices_before test_too_many_indices_combined
  simp_alive_peephole
  sorry
def test_wrong_op_combined := [llvmfunc|
  llvm.func @test_wrong_op(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.xor %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_wrong_op   : test_wrong_op_before  ⊑  test_wrong_op_combined := by
  unfold test_wrong_op_before test_wrong_op_combined
  simp_alive_peephole
  sorry
def test_sext_add_without_nsw_combined := [llvmfunc|
  llvm.func @test_sext_add_without_nsw(%arg0: !llvm.ptr, %arg1: i32) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i32
    %4 = llvm.sext %3 : i32 to i64
    %5 = llvm.getelementptr %2[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_test_sext_add_without_nsw   : test_sext_add_without_nsw_before  ⊑  test_sext_add_without_nsw_combined := by
  unfold test_sext_add_without_nsw_before test_sext_add_without_nsw_combined
  simp_alive_peephole
  sorry
def test_or_without_disjoint_combined := [llvmfunc|
  llvm.func @test_or_without_disjoint(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.or %arg1, %1  : i64
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_or_without_disjoint   : test_or_without_disjoint_before  ⊑  test_or_without_disjoint_combined := by
  unfold test_or_without_disjoint_before test_or_without_disjoint_combined
  simp_alive_peephole
  sorry
def test_smul_overflow_combined := [llvmfunc|
  llvm.func @test_smul_overflow(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(9223372036854775806 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_smul_overflow   : test_smul_overflow_before  ⊑  test_smul_overflow_combined := by
  unfold test_smul_overflow_before test_smul_overflow_combined
  simp_alive_peephole
  sorry
def test_sadd_overflow_combined := [llvmfunc|
  llvm.func @test_sadd_overflow(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(9223372036854775804 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_sadd_overflow   : test_sadd_overflow_before  ⊑  test_sadd_overflow_combined := by
  unfold test_sadd_overflow_before test_sadd_overflow_combined
  simp_alive_peephole
  sorry
def test_nonzero_multiuse_index_combined := [llvmfunc|
  llvm.func @test_nonzero_multiuse_index(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.add %arg1, %1  : i64
    llvm.call @use64(%3) : (i64) -> ()
    %4 = llvm.getelementptr %2[%3] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_nonzero_multiuse_index   : test_nonzero_multiuse_index_before  ⊑  test_nonzero_multiuse_index_combined := by
  unfold test_nonzero_multiuse_index_before test_nonzero_multiuse_index_combined
  simp_alive_peephole
  sorry
def test_nonzero_multiuse_ptr_combined := [llvmfunc|
  llvm.func @test_nonzero_multiuse_ptr(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @useptr(%2) : (!llvm.ptr) -> ()
    %3 = llvm.getelementptr %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_nonzero_multiuse_ptr   : test_nonzero_multiuse_ptr_before  ⊑  test_nonzero_multiuse_ptr_combined := by
  unfold test_nonzero_multiuse_ptr_before test_nonzero_multiuse_ptr_combined
  simp_alive_peephole
  sorry
def test_scalable_combined := [llvmfunc|
  llvm.func @test_scalable(%arg0: !llvm.ptr, %arg1: i64) -> !llvm.ptr {
    %0 = llvm.mlir.constant(-4 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.getelementptr %2[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.vec<? x 4 x  i32>
    llvm.return %4 : !llvm.ptr
  }]

theorem inst_combine_test_scalable   : test_scalable_before  ⊑  test_scalable_combined := by
  unfold test_scalable_before test_scalable_combined
  simp_alive_peephole
  sorry
