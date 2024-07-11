import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memset2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr<1> {llvm.nocapture}) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(8 : i64) : i64
    %5 = llvm.getelementptr inbounds %arg0[%0, 0, %2] : (!llvm.ptr<1>, i32, i32) -> !llvm.ptr<1>, !llvm.struct<"struct.Moves", (array<9 x i8>, i8, i8, i8, array<5 x i8>)>
    "llvm.intr.memset"(%5, %3, %4) <{isVolatile = false}> : (!llvm.ptr<1>, i8, i64) -> ()]

    llvm.return %1 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr<1> {llvm.nocapture}) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr inbounds %arg0[%0, 0, %2] : (!llvm.ptr<1>, i64, i64) -> !llvm.ptr<1>, !llvm.struct<"struct.Moves", (array<9 x i8>, i8, i8, i8, array<5 x i8>)>
    llvm.store %3, %4 {alignment = 1 : i64} : i64, !llvm.ptr<1>]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.return %1 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
