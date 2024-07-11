import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2006-09-15-CastToBool
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.bitcast %3 : i32 to i32
    %5 = llvm.lshr %4, %0  : i32
    %6 = llvm.bitcast %5 : i32 to i32
    %7 = llvm.and %6, %1  : i32
    %8 = llvm.icmp "ne" %7, %2 : i32
    %9 = llvm.zext %8 : i1 to i32
    llvm.return %9 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    %3 = llvm.lshr %2, %0  : i32
    %4 = llvm.and %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
