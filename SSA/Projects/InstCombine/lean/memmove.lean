import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memmove
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    "llvm.intr.memmove"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant("panic: restorelist inconsistency\00") : !llvm.array<33 x i8>
    %1 = llvm.mlir.addressof @S : !llvm.ptr
    "llvm.intr.memmove"(%arg0, %1, %arg1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def test3_before := [llvmfunc|
  llvm.func @test3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("h\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @h : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @hel : !llvm.ptr
    %5 = llvm.mlir.constant("hello_u\00") : !llvm.array<8 x i8>
    %6 = llvm.mlir.addressof @hello_u : !llvm.ptr
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.mlir.constant(4 : i32) : i32
    %9 = llvm.mlir.constant(8 : i32) : i32
    %10 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %11 = llvm.getelementptr %4[%2, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<4 x i8>
    %12 = llvm.getelementptr %6[%2, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<8 x i8>
    %13 = llvm.getelementptr %arg0[%2, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<1024 x i8>
    "llvm.intr.memmove"(%13, %10, %7) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    "llvm.intr.memmove"(%13, %11, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    "llvm.intr.memmove"(%13, %12, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return %2 : i32
  }]

def test4_before := [llvmfunc|
  llvm.func @test4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    "llvm.intr.memmove"(%arg0, %arg0, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def memmove_to_constant_before := [llvmfunc|
  llvm.func @memmove_to_constant(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @UnknownConstant : !llvm.ptr
    %1 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memmove"(%0, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) {
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant("panic: restorelist inconsistency\00") : !llvm.array<33 x i8>
    %1 = llvm.mlir.addressof @S : !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %1, %arg1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

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
  llvm.func @test3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(104 : i16) : i16
    %1 = llvm.mlir.constant(7103848 : i32) : i32
    %2 = llvm.mlir.constant(33037504440198504 : i64) : i64
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
    llvm.store %2, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
    llvm.return %3 : i32
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
def memmove_to_constant_combined := [llvmfunc|
  llvm.func @memmove_to_constant(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_memmove_to_constant   : memmove_to_constant_before  ⊑  memmove_to_constant_combined := by
  unfold memmove_to_constant_before memmove_to_constant_combined
  simp_alive_peephole
  sorry
