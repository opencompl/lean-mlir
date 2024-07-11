import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2007-03-26-BadShiftMask
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: !llvm.ptr, %arg5: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.mlir.constant(true) : i1
    %7 = llvm.and %arg2, %0  : i32
    %8 = llvm.shl %7, %1  : i32
    %9 = llvm.ashr %arg2, %0  : i32
    %10 = llvm.shl %9, %1  : i32
    %11 = llvm.ashr %8, %2  : i32
    llvm.store %11, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %12 = llvm.ashr %10, %2  : i32
    llvm.store %12, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %13 = llvm.icmp "eq" %arg3, %3 : i32
    %14 = llvm.zext %13 : i1 to i8
    %15 = llvm.icmp "ne" %14, %4 : i8
    llvm.cond_br %15, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %8, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %10, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %6 : i1
  ^bb2:  // pred: ^bb0
    llvm.store %8, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %10, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %5 : i1
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: i32, %arg4: !llvm.ptr, %arg5: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(-8 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(false) : i1
    %6 = llvm.mlir.constant(true) : i1
    %7 = llvm.shl %arg2, %0  : i32
    %8 = llvm.and %7, %1  : i32
    %9 = llvm.shl %arg2, %2  : i32
    %10 = llvm.and %9, %3  : i32
    %11 = llvm.lshr %8, %2  : i32
    llvm.store %11, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    %12 = llvm.ashr %10, %2  : i32
    llvm.store %12, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    %13 = llvm.icmp "eq" %arg3, %4 : i32
    llvm.cond_br %13, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %8, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.store %10, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.return %6 : i1
  ^bb2:  // pred: ^bb0
    llvm.store %8, %arg4 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.store %10, %arg5 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.return %5 : i1
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
