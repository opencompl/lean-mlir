import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  struct-assign-tbaa
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr {llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.ptr
    %2 = llvm.mlir.constant(8 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.struct<"struct.test2", (ptr)> {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%3, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.return %3 : !llvm.ptr
  }]

def test3_multiple_fields_before := [llvmfunc|
  llvm.func @test3_multiple_fields(%arg0: !llvm.ptr {llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.mlir.constant(8 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test4_multiple_copy_first_field_before := [llvmfunc|
  llvm.func @test4_multiple_copy_first_field(%arg0: !llvm.ptr {llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test5_multiple_copy_more_than_first_field_before := [llvmfunc|
  llvm.func @test5_multiple_copy_more_than_first_field(%arg0: !llvm.ptr {llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr {llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.load %arg1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    llvm.store %0, %arg0 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : !llvm.ptr
    llvm.store %0, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_multiple_fields_combined := [llvmfunc|
  llvm.func @test3_multiple_fields(%arg0: !llvm.ptr {llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i64
    llvm.store %0, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test3_multiple_fields   : test3_multiple_fields_before  ⊑  test3_multiple_fields_combined := by
  unfold test3_multiple_fields_before test3_multiple_fields_combined
  simp_alive_peephole
  sorry
def test4_multiple_copy_first_field_combined := [llvmfunc|
  llvm.func @test4_multiple_copy_first_field(%arg0: !llvm.ptr {llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test4_multiple_copy_first_field   : test4_multiple_copy_first_field_before  ⊑  test4_multiple_copy_first_field_combined := by
  unfold test4_multiple_copy_first_field_before test4_multiple_copy_first_field_combined
  simp_alive_peephole
  sorry
def test5_multiple_copy_more_than_first_field_combined := [llvmfunc|
  llvm.func @test5_multiple_copy_more_than_first_field(%arg0: !llvm.ptr {llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}) {
    %0 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %0, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test5_multiple_copy_more_than_first_field   : test5_multiple_copy_more_than_first_field_before  ⊑  test5_multiple_copy_more_than_first_field_combined := by
  unfold test5_multiple_copy_more_than_first_field_before test5_multiple_copy_more_than_first_field_combined
  simp_alive_peephole
  sorry
