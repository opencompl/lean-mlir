import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  add3
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32) {
    %0 = llvm.mlir.constant(-12 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.inttoptr %3 : i32 to !llvm.ptr
    llvm.store %1, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.add %arg0, %2  : i32
    %6 = llvm.inttoptr %5 : i32 to !llvm.ptr
    %7 = llvm.getelementptr %6[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %9 = llvm.call @callee(%8) : (i32) -> i32
    llvm.return
  }]

def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32) {
    %0 = llvm.mlir.constant(-12 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-16 : i32) : i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.inttoptr %3 : i32 to !llvm.ptr
    llvm.store %1, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.add %arg0, %2  : i32
    %6 = llvm.inttoptr %5 : i32 to !llvm.ptr
    %7 = llvm.getelementptr %6[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %9 = llvm.call @callee(%8) : (i32) -> i32
    llvm.return
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
