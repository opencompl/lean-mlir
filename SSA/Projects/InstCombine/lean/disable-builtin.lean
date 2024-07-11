import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  disable-builtin
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_strcat_before := [llvmfunc|
  llvm.func @test_strcat(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @strcat(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def test_strcat_combined := [llvmfunc|
  llvm.func @test_strcat(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @empty : !llvm.ptr
    %3 = llvm.call @strcat(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_test_strcat   : test_strcat_before  ⊑  test_strcat_combined := by
  unfold test_strcat_before test_strcat_combined
  simp_alive_peephole
  sorry
