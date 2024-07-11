import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  deadcode
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %0, %0  : i1
    llvm.cond_br %2, ^bb1, ^bb2(%arg0 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %1  : i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.intr.stacksave : !llvm.ptr
    %1 = llvm.alloca %arg0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.return %1 : !llvm.ptr
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.intr.lifetime.start -1, %0 : !llvm.ptr
    llvm.intr.lifetime.end -1, %0 : !llvm.ptr
    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i64) -> !llvm.ptr]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() {
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
