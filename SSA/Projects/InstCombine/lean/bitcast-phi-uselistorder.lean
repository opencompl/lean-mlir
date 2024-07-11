import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitcast-phi-uselistorder
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i1, %arg1: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.addressof @Q : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> i64]

    llvm.br ^bb2(%3 : i64)
  ^bb2(%4: i64):  // 2 preds: ^bb0, ^bb1
    llvm.store %4, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr]

    %5 = llvm.bitcast %4 : i64 to f64
    llvm.return %5 : f64
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i1, %arg1: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.addressof @Q : !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : f64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2(%3 : f64)
  ^bb2(%4: f64):  // 2 preds: ^bb0, ^bb1
    llvm.store %4, %arg1 {alignment = 8 : i64} : f64, !llvm.ptr]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : f64
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
