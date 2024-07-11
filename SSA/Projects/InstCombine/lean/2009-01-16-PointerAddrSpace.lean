import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-01-16-PointerAddrSpace
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr<1>]

    llvm.return %0 : i32
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.addrspacecast %arg0 : !llvm.ptr to !llvm.ptr<1>
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr<1>]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.return %0 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
