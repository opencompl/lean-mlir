import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sprintf-void
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_simplify1_before := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    llvm.call @sprintf(%arg0, %1) vararg(!llvm.func<void (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

def test_simplify1_combined := [llvmfunc|
  llvm.func @test_simplify1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant("hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @hello_world : !llvm.ptr
    llvm.call @sprintf(%arg0, %1) vararg(!llvm.func<void (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test_simplify1   : test_simplify1_before  ⊑  test_simplify1_combined := by
  unfold test_simplify1_before test_simplify1_combined
  simp_alive_peephole
  sorry
