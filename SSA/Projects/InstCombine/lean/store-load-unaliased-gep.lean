import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  store-load-unaliased-gep
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    llvm.store %arg0, %3 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.store %2, %4 {alignment = 4 : i64} : i32, !llvm.ptr]

    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.return %5 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32) -> i32 {
    llvm.return %arg0 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
