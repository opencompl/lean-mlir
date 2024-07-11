import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr44835
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %3 = llvm.icmp "ult" %2, %1 : i32
    %4 = llvm.select %3, %arg1, %arg0 : i1, !llvm.ptr
    "llvm.intr.memcpy"(%arg0, %4, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()]

    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.intr.umin(%1, %0)  : (i32, i32) -> i32
    llvm.store %2, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
