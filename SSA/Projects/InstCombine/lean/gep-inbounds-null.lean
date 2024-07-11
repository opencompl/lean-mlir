import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  gep-inbounds-null
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_ne_constants_null_before := [llvmfunc|
  llvm.func @test_ne_constants_null() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def test_ne_constants_nonnull_before := [llvmfunc|
  llvm.func @test_ne_constants_nonnull() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "ne" %2, %0 : !llvm.ptr
    llvm.return %3 : i1
  }]

def test_eq_constants_null_before := [llvmfunc|
  llvm.func @test_eq_constants_null() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def test_eq_constants_nonnull_before := [llvmfunc|
  llvm.func @test_eq_constants_nonnull() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "eq" %2, %0 : !llvm.ptr
    llvm.return %3 : i1
  }]

def test_ne_before := [llvmfunc|
  llvm.func @test_ne(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "ne" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def test_eq_before := [llvmfunc|
  llvm.func @test_eq(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def test_vector_base_before := [llvmfunc|
  llvm.func @test_vector_base(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    %7 = llvm.icmp "eq" %6, %5 : !llvm.vec<2 x ptr>
    llvm.return %7 : vector<2xi1>
  }]

def test_vector_index_before := [llvmfunc|
  llvm.func @test_vector_index(%arg0: !llvm.ptr, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %7 = llvm.icmp "eq" %6, %5 : !llvm.vec<2 x ptr>
    llvm.return %7 : vector<2xi1>
  }]

def test_vector_both_before := [llvmfunc|
  llvm.func @test_vector_both(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %7 = llvm.icmp "eq" %6, %5 : !llvm.vec<2 x ptr>
    llvm.return %7 : vector<2xi1>
  }]

def test_eq_pos_idx_before := [llvmfunc|
  llvm.func @test_eq_pos_idx(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

def test_eq_neg_idx_before := [llvmfunc|
  llvm.func @test_eq_neg_idx(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

def test_size0_before := [llvmfunc|
  llvm.func @test_size0(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<()>
    %2 = llvm.icmp "ne" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def test_size0_nonzero_offset_before := [llvmfunc|
  llvm.func @test_size0_nonzero_offset(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<()>
    %3 = llvm.icmp "ne" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }]

def test_index_type_before := [llvmfunc|
  llvm.func @test_index_type(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %arg0[%arg1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def neq_noinbounds_before := [llvmfunc|
  llvm.func @neq_noinbounds(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "ne" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }]

def neg_objectatnull_before := [llvmfunc|
  llvm.func @neg_objectatnull(%arg0: !llvm.ptr<2>, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr<2>
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr<2>
    llvm.return %2 : i1
  }]

def invalid_bitcast_icmp_addrspacecast_as0_null_before := [llvmfunc|
  llvm.func @invalid_bitcast_icmp_addrspacecast_as0_null(%arg0: !llvm.ptr<5>) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.addrspacecast %1 : !llvm.ptr to !llvm.ptr<5>
    %3 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<5>, i32) -> !llvm.ptr<5>, i32
    %4 = llvm.icmp "eq" %3, %2 : !llvm.ptr<5>
    llvm.return %4 : i1
  }]

def invalid_bitcast_icmp_addrspacecast_as0_null_var_before := [llvmfunc|
  llvm.func @invalid_bitcast_icmp_addrspacecast_as0_null_var(%arg0: !llvm.ptr<5>, %arg1: i32) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.addrspacecast %0 : !llvm.ptr to !llvm.ptr<5>
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<5>, i32) -> !llvm.ptr<5>, i32
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr<5>
    llvm.return %3 : i1
  }]

def test_ne_constants_null_combined := [llvmfunc|
  llvm.func @test_ne_constants_null() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_ne_constants_null   : test_ne_constants_null_before  ⊑  test_ne_constants_null_combined := by
  unfold test_ne_constants_null_before test_ne_constants_null_combined
  simp_alive_peephole
  sorry
def test_ne_constants_nonnull_combined := [llvmfunc|
  llvm.func @test_ne_constants_nonnull() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_ne_constants_nonnull   : test_ne_constants_nonnull_before  ⊑  test_ne_constants_nonnull_combined := by
  unfold test_ne_constants_nonnull_before test_ne_constants_nonnull_combined
  simp_alive_peephole
  sorry
def test_eq_constants_null_combined := [llvmfunc|
  llvm.func @test_eq_constants_null() -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_eq_constants_null   : test_eq_constants_null_before  ⊑  test_eq_constants_null_combined := by
  unfold test_eq_constants_null_before test_eq_constants_null_combined
  simp_alive_peephole
  sorry
def test_eq_constants_nonnull_combined := [llvmfunc|
  llvm.func @test_eq_constants_nonnull() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_eq_constants_nonnull   : test_eq_constants_nonnull_before  ⊑  test_eq_constants_nonnull_combined := by
  unfold test_eq_constants_nonnull_before test_eq_constants_nonnull_combined
  simp_alive_peephole
  sorry
def test_ne_combined := [llvmfunc|
  llvm.func @test_ne(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_test_ne   : test_ne_before  ⊑  test_ne_combined := by
  unfold test_ne_before test_ne_combined
  simp_alive_peephole
  sorry
def test_eq_combined := [llvmfunc|
  llvm.func @test_eq(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_test_eq   : test_eq_before  ⊑  test_eq_combined := by
  unfold test_eq_before test_eq_combined
  simp_alive_peephole
  sorry
def test_vector_base_combined := [llvmfunc|
  llvm.func @test_vector_base(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.icmp "eq" %arg0, %5 : !llvm.vec<2 x ptr>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_test_vector_base   : test_vector_base_before  ⊑  test_vector_base_combined := by
  unfold test_vector_base_before test_vector_base_combined
  simp_alive_peephole
  sorry
def test_vector_index_combined := [llvmfunc|
  llvm.func @test_vector_index(%arg0: !llvm.ptr, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : !llvm.vec<2 x ptr>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.zero : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.poison : vector<2xi1>
    %9 = llvm.insertelement %arg0, %0[%1 : i64] : !llvm.vec<2 x ptr>
    %10 = llvm.icmp "eq" %9, %7 : !llvm.vec<2 x ptr>
    %11 = llvm.shufflevector %10, %8 [0, 0] : vector<2xi1> 
    llvm.return %11 : vector<2xi1>
  }]

theorem inst_combine_test_vector_index   : test_vector_index_before  ⊑  test_vector_index_combined := by
  unfold test_vector_index_before test_vector_index_combined
  simp_alive_peephole
  sorry
def test_vector_both_combined := [llvmfunc|
  llvm.func @test_vector_both(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.icmp "eq" %arg0, %5 : !llvm.vec<2 x ptr>
    llvm.return %6 : vector<2xi1>
  }]

theorem inst_combine_test_vector_both   : test_vector_both_before  ⊑  test_vector_both_combined := by
  unfold test_vector_both_before test_vector_both_combined
  simp_alive_peephole
  sorry
def test_eq_pos_idx_combined := [llvmfunc|
  llvm.func @test_eq_pos_idx(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_eq_pos_idx   : test_eq_pos_idx_before  ⊑  test_eq_pos_idx_combined := by
  unfold test_eq_pos_idx_before test_eq_pos_idx_combined
  simp_alive_peephole
  sorry
def test_eq_neg_idx_combined := [llvmfunc|
  llvm.func @test_eq_neg_idx(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test_eq_neg_idx   : test_eq_neg_idx_before  ⊑  test_eq_neg_idx_combined := by
  unfold test_eq_neg_idx_before test_eq_neg_idx_combined
  simp_alive_peephole
  sorry
def test_size0_combined := [llvmfunc|
  llvm.func @test_size0(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_test_size0   : test_size0_before  ⊑  test_size0_combined := by
  unfold test_size0_before test_size0_combined
  simp_alive_peephole
  sorry
def test_size0_nonzero_offset_combined := [llvmfunc|
  llvm.func @test_size0_nonzero_offset(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_test_size0_nonzero_offset   : test_size0_nonzero_offset_before  ⊑  test_size0_nonzero_offset_combined := by
  unfold test_size0_nonzero_offset_before test_size0_nonzero_offset_combined
  simp_alive_peephole
  sorry
def test_index_type_combined := [llvmfunc|
  llvm.func @test_index_type(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_test_index_type   : test_index_type_before  ⊑  test_index_type_combined := by
  unfold test_index_type_before test_index_type_combined
  simp_alive_peephole
  sorry
def neq_noinbounds_combined := [llvmfunc|
  llvm.func @neq_noinbounds(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "ne" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }]

theorem inst_combine_neq_noinbounds   : neq_noinbounds_before  ⊑  neq_noinbounds_combined := by
  unfold neq_noinbounds_before neq_noinbounds_combined
  simp_alive_peephole
  sorry
def neg_objectatnull_combined := [llvmfunc|
  llvm.func @neg_objectatnull(%arg0: !llvm.ptr<2>, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr<2>
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr<2>
    llvm.return %2 : i1
  }]

theorem inst_combine_neg_objectatnull   : neg_objectatnull_before  ⊑  neg_objectatnull_combined := by
  unfold neg_objectatnull_before neg_objectatnull_combined
  simp_alive_peephole
  sorry
def invalid_bitcast_icmp_addrspacecast_as0_null_combined := [llvmfunc|
  llvm.func @invalid_bitcast_icmp_addrspacecast_as0_null(%arg0: !llvm.ptr<5>) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.addrspacecast %0 : !llvm.ptr to !llvm.ptr<5>
    %2 = llvm.icmp "eq" %arg0, %1 : !llvm.ptr<5>
    llvm.return %2 : i1
  }]

theorem inst_combine_invalid_bitcast_icmp_addrspacecast_as0_null   : invalid_bitcast_icmp_addrspacecast_as0_null_before  ⊑  invalid_bitcast_icmp_addrspacecast_as0_null_combined := by
  unfold invalid_bitcast_icmp_addrspacecast_as0_null_before invalid_bitcast_icmp_addrspacecast_as0_null_combined
  simp_alive_peephole
  sorry
def invalid_bitcast_icmp_addrspacecast_as0_null_var_combined := [llvmfunc|
  llvm.func @invalid_bitcast_icmp_addrspacecast_as0_null_var(%arg0: !llvm.ptr<5>, %arg1: i32) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.addrspacecast %0 : !llvm.ptr to !llvm.ptr<5>
    %2 = llvm.icmp "eq" %arg0, %1 : !llvm.ptr<5>
    llvm.return %2 : i1
  }]

theorem inst_combine_invalid_bitcast_icmp_addrspacecast_as0_null_var   : invalid_bitcast_icmp_addrspacecast_as0_null_var_before  ⊑  invalid_bitcast_icmp_addrspacecast_as0_null_var_combined := by
  unfold invalid_bitcast_icmp_addrspacecast_as0_null_var_before invalid_bitcast_icmp_addrspacecast_as0_null_var_combined
  simp_alive_peephole
  sorry
