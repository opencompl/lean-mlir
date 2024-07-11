import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr55228
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.addressof @g : !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.mlir.addressof @c : !llvm.ptr
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    "llvm.intr.memcpy"(%6, %4, %5) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

    %7 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> !llvm.ptr]

    %8 = llvm.icmp "eq" %arg0, %7 : !llvm.ptr
    llvm.return %8 : i1
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "eq" %arg0, %2 : !llvm.ptr
    llvm.return %3 : i1
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
