import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-load-metadata-2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_phi_combine_load_metadata_before := [llvmfunc|
  llvm.func @test_phi_combine_load_metadata(%arg0: i1, %arg1: !llvm.ptr {llvm.dereferenceable = 8 : i64}, %arg2: !llvm.ptr {llvm.dereferenceable = 8 : i64}) -> !llvm.ptr {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    %0 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb3(%0 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @baz() : () -> ()
    %1 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb3(%2: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : !llvm.ptr
  }]

def test_phi_combine_load_metadata_combined := [llvmfunc|
  llvm.func @test_phi_combine_load_metadata(%arg0: i1, %arg1: !llvm.ptr {llvm.dereferenceable = 8 : i64}, %arg2: !llvm.ptr {llvm.dereferenceable = 8 : i64}) -> !llvm.ptr {
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @baz() : () -> ()
    llvm.br ^bb3(%arg2 : !llvm.ptr)
  ^bb3(%0: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %1 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_test_phi_combine_load_metadata   : test_phi_combine_load_metadata_before  ⊑  test_phi_combine_load_metadata_combined := by
  unfold test_phi_combine_load_metadata_before test_phi_combine_load_metadata_combined
  simp_alive_peephole
  sorry
