import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-07-30-addrsp-bitcast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(2147483647 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : tensor<16xi32>) : !llvm.array<16 x i32>
    %3 = llvm.mlir.addressof @base : !llvm.ptr<3>
    %4 = llvm.addrspacecast %3 : !llvm.ptr<3> to !llvm.ptr
    %5 = llvm.getelementptr %4[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.call @foo(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(8589934588 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : tensor<16xi32>) : !llvm.array<16 x i32>
    %3 = llvm.mlir.addressof @base : !llvm.ptr<3>
    %4 = llvm.addrspacecast %3 : !llvm.ptr<3> to !llvm.ptr
    %5 = llvm.getelementptr %4[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @foo(%5) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
