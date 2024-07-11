import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memcpy
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg0, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg0, %0) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(17179869184 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def memcpy_to_constant_before := [llvmfunc|
  llvm.func @memcpy_to_constant(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @UnknownConstant : !llvm.ptr
    %1 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memcpy"(%0, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    "llvm.intr.memcpy"(%arg0, %arg0, %0) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(17179869184 : i64) : i64
    "llvm.intr.memcpy"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
def memcpy_to_constant_combined := [llvmfunc|
  llvm.func @memcpy_to_constant(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_memcpy_to_constant   : memcpy_to_constant_before  ⊑  memcpy_to_constant_combined := by
  unfold memcpy_to_constant_before memcpy_to_constant_combined
  simp_alive_peephole
  sorry
