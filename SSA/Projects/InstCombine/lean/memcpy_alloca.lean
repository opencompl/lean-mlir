import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcpy_alloca
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%arg0, %2, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %3 {alignment = 1 : i64} : i8, !llvm.ptr]

    "llvm.intr.memcpy"(%arg0, %3, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%arg0, %2, %1) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%arg0, %2, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test5_before := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    "llvm.intr.memcpy"(%arg0, %3, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test6_before := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.getelementptr %3[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i16
    llvm.store %1, %4 {alignment = 2 : i64} : i16, !llvm.ptr]

    "llvm.intr.memcpy"(%arg0, %4, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(7 : i64) : i64
    %3 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %3, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %2, %1) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def test4_combined := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_test4   : test4_before  ⊑  test4_combined := by
  unfold test4_before test4_combined
  simp_alive_peephole
  sorry
def test5_combined := [llvmfunc|
  llvm.func @test5(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_test5   : test5_before  ⊑  test5_combined := by
  unfold test5_before test5_combined
  simp_alive_peephole
  sorry
def test6_combined := [llvmfunc|
  llvm.func @test6(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(42 : i16) : i16
    %3 = llvm.mlir.constant(7 : i64) : i64
    %4 = llvm.alloca %0 x !llvm.array<7 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i16
    llvm.store %2, %5 {alignment = 2 : i64} : i16, !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %5, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }]

theorem inst_combine_test6   : test6_before  ⊑  test6_combined := by
  unfold test6_before test6_combined
  simp_alive_peephole
  sorry
