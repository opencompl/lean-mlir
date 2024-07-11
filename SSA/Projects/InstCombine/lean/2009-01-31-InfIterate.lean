import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-01-31-InfIterate
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i64, %arg1: i64, %arg2: i1, %arg3: i128, %arg4: i128, %arg5: !llvm.ptr, %arg6: !llvm.ptr) -> i128 {
    %0 = llvm.trunc %arg3 : i128 to i64
    %1 = llvm.trunc %arg4 : i128 to i64
    llvm.store %0, %arg5 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.store %1, %arg6 {alignment = 4 : i64} : i64, !llvm.ptr]

    %2 = llvm.sub %0, %1  : i64
    %3 = llvm.sub %0, %1  : i64
    %4 = llvm.zext %arg2 : i1 to i64
    %5 = llvm.sub %3, %4  : i64
    llvm.br ^bb1(%5 : i64)
  ^bb1(%6: i64):  // pred: ^bb0
    %7 = llvm.zext %6 : i64 to i128
    llvm.return %7 : i128
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i64, %arg1: i64, %arg2: i1, %arg3: i128, %arg4: i128, %arg5: !llvm.ptr, %arg6: !llvm.ptr) -> i128 {
    %0 = llvm.trunc %arg3 : i128 to i64
    %1 = llvm.trunc %arg4 : i128 to i64
    llvm.store %0, %arg5 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %arg6 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    %2 = llvm.sub %0, %1  : i64
    %3 = llvm.sext %arg2 : i1 to i64
    %4 = llvm.add %2, %3  : i64
    llvm.br ^bb1(%4 : i64)
  ^bb1(%5: i64):  // pred: ^bb0
    %6 = llvm.zext %5 : i64 to i128
    llvm.return %6 : i128
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
