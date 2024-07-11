import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-07-25-LoadPart
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo() -> i64 {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.constant(dense<[1, 2, 3, 4]> : tensor<4xi32>) : !llvm.array<4 x i32>
    %2 = llvm.mlir.addressof @test : !llvm.ptr
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i64]

    llvm.return %4 : i64
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo() -> i64 {
    %0 = llvm.mlir.constant(844424930263040 : i64) : i64
    llvm.return %0 : i64
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
