import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  odr-linkage
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @g1 : !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.addressof @g2 : !llvm.ptr
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.mlir.addressof @g3 : !llvm.ptr
    %6 = llvm.mlir.constant(4 : i32) : i32
    %7 = llvm.mlir.addressof @g4 : !llvm.ptr
    %8 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %9 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %10 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %12 = llvm.add %8, %9  : i32
    %13 = llvm.add %12, %10  : i32
    %14 = llvm.add %13, %11  : i32
    llvm.return %14 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test() -> i32 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
