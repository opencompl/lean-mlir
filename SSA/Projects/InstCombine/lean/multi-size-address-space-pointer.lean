import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  multi-size-address-space-pointer
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_as0_before := [llvmfunc|
  llvm.func @test_as0(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %2 : i32
  }]

def test_as1_before := [llvmfunc|
  llvm.func @test_as1(%arg0: !llvm.ptr<1>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<1>, i32) -> !llvm.ptr<1>, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<1> -> i32]

    llvm.return %2 : i32
  }]

def test_as2_before := [llvmfunc|
  llvm.func @test_as2(%arg0: !llvm.ptr<2>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<2> -> i32]

    llvm.return %2 : i32
  }]

def test_as3_before := [llvmfunc|
  llvm.func @test_as3(%arg0: !llvm.ptr<3>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<3> -> i32]

    llvm.return %2 : i32
  }]

def test_combine_ptrtoint_before := [llvmfunc|
  llvm.func @test_combine_ptrtoint(%arg0: !llvm.ptr<2>) -> i32 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<2> to i8
    %1 = llvm.inttoptr %0 : i8 to !llvm.ptr<2>
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<2> -> i32]

    llvm.return %2 : i32
  }]

def test_combine_inttoptr_before := [llvmfunc|
  llvm.func @test_combine_inttoptr(%arg0: i8) -> i8 {
    %0 = llvm.inttoptr %arg0 : i8 to !llvm.ptr<2>
    %1 = llvm.ptrtoint %0 : !llvm.ptr<2> to i8
    llvm.return %1 : i8
  }]

def test_combine_vector_ptrtoint_before := [llvmfunc|
  llvm.func @test_combine_vector_ptrtoint(%arg0: !llvm.vec<2 x ptr<2>>) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ptrtoint %arg0 : !llvm.vec<2 x ptr<2>> to vector<2xi8>
    %2 = llvm.inttoptr %1 : vector<2xi8> to !llvm.vec<2 x ptr<2>>
    %3 = llvm.extractelement %2[%0 : i32] : !llvm.vec<2 x ptr<2>>
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr<2> -> i32]

    llvm.return %4 : i32
  }]

def test_combine_vector_inttoptr_before := [llvmfunc|
  llvm.func @test_combine_vector_inttoptr(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.inttoptr %arg0 : vector<2xi8> to !llvm.vec<2 x ptr<2>>
    %1 = llvm.ptrtoint %0 : !llvm.vec<2 x ptr<2>> to vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

def shrink_gep_constant_index_64_as2_before := [llvmfunc|
  llvm.func @shrink_gep_constant_index_64_as2(%arg0: !llvm.ptr<2>) -> !llvm.ptr<2> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i32
    llvm.return %1 : !llvm.ptr<2>
  }]

def shrink_gep_constant_index_32_as2_before := [llvmfunc|
  llvm.func @shrink_gep_constant_index_32_as2(%arg0: !llvm.ptr<2>) -> !llvm.ptr<2> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i32) -> !llvm.ptr<2>, i32
    llvm.return %1 : !llvm.ptr<2>
  }]

def shrink_gep_constant_index_64_as3_before := [llvmfunc|
  llvm.func @shrink_gep_constant_index_64_as3(%arg0: !llvm.ptr<3>) -> !llvm.ptr<3> {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<3>, i64) -> !llvm.ptr<3>, i32
    llvm.return %1 : !llvm.ptr<3>
  }]

def shrink_gep_variable_index_64_as2_before := [llvmfunc|
  llvm.func @shrink_gep_variable_index_64_as2(%arg0: !llvm.ptr<2>, %arg1: i64) -> !llvm.ptr<2> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i32
    llvm.return %0 : !llvm.ptr<2>
  }]

def grow_gep_variable_index_8_as1_before := [llvmfunc|
  llvm.func @grow_gep_variable_index_8_as1(%arg0: !llvm.ptr<1>, %arg1: i8) -> !llvm.ptr<1> {
    %0 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr<1>, i8) -> !llvm.ptr<1>, i32
    llvm.return %0 : !llvm.ptr<1>
  }]

def test_as0_combined := [llvmfunc|
  llvm.func @test_as0(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_as0   : test_as0_before  ⊑  test_as0_combined := by
  unfold test_as0_before test_as0_combined
  simp_alive_peephole
  sorry
def test_as1_combined := [llvmfunc|
  llvm.func @test_as1(%arg0: !llvm.ptr<1>) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_as1   : test_as1_before  ⊑  test_as1_combined := by
  unfold test_as1_before test_as1_combined
  simp_alive_peephole
  sorry
def test_as2_combined := [llvmfunc|
  llvm.func @test_as2(%arg0: !llvm.ptr<2>) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i8) -> !llvm.ptr<2>, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<2> -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_as2   : test_as2_before  ⊑  test_as2_combined := by
  unfold test_as2_before test_as2_combined
  simp_alive_peephole
  sorry
def test_as3_combined := [llvmfunc|
  llvm.func @test_as3(%arg0: !llvm.ptr<3>) -> i32 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<3>, i16) -> !llvm.ptr<3>, i32
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_as3   : test_as3_before  ⊑  test_as3_combined := by
  unfold test_as3_before test_as3_combined
  simp_alive_peephole
  sorry
def test_combine_ptrtoint_combined := [llvmfunc|
  llvm.func @test_combine_ptrtoint(%arg0: !llvm.ptr<2>) -> i32 {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr<2> -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_combine_ptrtoint   : test_combine_ptrtoint_before  ⊑  test_combine_ptrtoint_combined := by
  unfold test_combine_ptrtoint_before test_combine_ptrtoint_combined
  simp_alive_peephole
  sorry
def test_combine_inttoptr_combined := [llvmfunc|
  llvm.func @test_combine_inttoptr(%arg0: i8) -> i8 {
    llvm.return %arg0 : i8
  }]

theorem inst_combine_test_combine_inttoptr   : test_combine_inttoptr_before  ⊑  test_combine_inttoptr_combined := by
  unfold test_combine_inttoptr_before test_combine_inttoptr_combined
  simp_alive_peephole
  sorry
def test_combine_vector_ptrtoint_combined := [llvmfunc|
  llvm.func @test_combine_vector_ptrtoint(%arg0: !llvm.vec<2 x ptr<2>>) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : !llvm.vec<2 x ptr<2>>
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<2> -> i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_combine_vector_ptrtoint   : test_combine_vector_ptrtoint_before  ⊑  test_combine_vector_ptrtoint_combined := by
  unfold test_combine_vector_ptrtoint_before test_combine_vector_ptrtoint_combined
  simp_alive_peephole
  sorry
def test_combine_vector_inttoptr_combined := [llvmfunc|
  llvm.func @test_combine_vector_inttoptr(%arg0: vector<2xi8>) -> vector<2xi8> {
    llvm.return %arg0 : vector<2xi8>
  }]

theorem inst_combine_test_combine_vector_inttoptr   : test_combine_vector_inttoptr_before  ⊑  test_combine_vector_inttoptr_combined := by
  unfold test_combine_vector_inttoptr_before test_combine_vector_inttoptr_combined
  simp_alive_peephole
  sorry
def shrink_gep_constant_index_64_as2_combined := [llvmfunc|
  llvm.func @shrink_gep_constant_index_64_as2(%arg0: !llvm.ptr<2>) -> !llvm.ptr<2> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i8) -> !llvm.ptr<2>, i32
    llvm.return %1 : !llvm.ptr<2>
  }]

theorem inst_combine_shrink_gep_constant_index_64_as2   : shrink_gep_constant_index_64_as2_before  ⊑  shrink_gep_constant_index_64_as2_combined := by
  unfold shrink_gep_constant_index_64_as2_before shrink_gep_constant_index_64_as2_combined
  simp_alive_peephole
  sorry
def shrink_gep_constant_index_32_as2_combined := [llvmfunc|
  llvm.func @shrink_gep_constant_index_32_as2(%arg0: !llvm.ptr<2>) -> !llvm.ptr<2> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i8) -> !llvm.ptr<2>, i32
    llvm.return %1 : !llvm.ptr<2>
  }]

theorem inst_combine_shrink_gep_constant_index_32_as2   : shrink_gep_constant_index_32_as2_before  ⊑  shrink_gep_constant_index_32_as2_combined := by
  unfold shrink_gep_constant_index_32_as2_before shrink_gep_constant_index_32_as2_combined
  simp_alive_peephole
  sorry
def shrink_gep_constant_index_64_as3_combined := [llvmfunc|
  llvm.func @shrink_gep_constant_index_64_as3(%arg0: !llvm.ptr<3>) -> !llvm.ptr<3> {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<3>, i16) -> !llvm.ptr<3>, i32
    llvm.return %1 : !llvm.ptr<3>
  }]

theorem inst_combine_shrink_gep_constant_index_64_as3   : shrink_gep_constant_index_64_as3_before  ⊑  shrink_gep_constant_index_64_as3_combined := by
  unfold shrink_gep_constant_index_64_as3_before shrink_gep_constant_index_64_as3_combined
  simp_alive_peephole
  sorry
def shrink_gep_variable_index_64_as2_combined := [llvmfunc|
  llvm.func @shrink_gep_variable_index_64_as2(%arg0: !llvm.ptr<2>, %arg1: i64) -> !llvm.ptr<2> {
    %0 = llvm.trunc %arg1 : i64 to i8
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<2>, i8) -> !llvm.ptr<2>, i32
    llvm.return %1 : !llvm.ptr<2>
  }]

theorem inst_combine_shrink_gep_variable_index_64_as2   : shrink_gep_variable_index_64_as2_before  ⊑  shrink_gep_variable_index_64_as2_combined := by
  unfold shrink_gep_variable_index_64_as2_before shrink_gep_variable_index_64_as2_combined
  simp_alive_peephole
  sorry
def grow_gep_variable_index_8_as1_combined := [llvmfunc|
  llvm.func @grow_gep_variable_index_8_as1(%arg0: !llvm.ptr<1>, %arg1: i8) -> !llvm.ptr<1> {
    %0 = llvm.sext %arg1 : i8 to i64
    %1 = llvm.getelementptr %arg0[%0] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, i32
    llvm.return %1 : !llvm.ptr<1>
  }]

theorem inst_combine_grow_gep_variable_index_8_as1   : grow_gep_variable_index_8_as1_before  ⊑  grow_gep_variable_index_8_as1_combined := by
  unfold grow_gep_variable_index_8_as1_before grow_gep_variable_index_8_as1_combined
  simp_alive_peephole
  sorry
