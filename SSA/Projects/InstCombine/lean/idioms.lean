import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  idioms
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_asr_before := [llvmfunc|
  llvm.func @test_asr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.sub %0, %arg0  : i32
    %4 = llvm.sub %3, %1  : i32
    %5 = llvm.ashr %4, %arg1  : i32
    %6 = llvm.sub %0, %5  : i32
    %7 = llvm.sub %6, %1  : i32
    llvm.br ^bb3(%7 : i32)
  ^bb2:  // pred: ^bb0
    %8 = llvm.ashr %arg0, %arg1  : i32
    llvm.br ^bb3(%8 : i32)
  ^bb3(%9: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %9 : i32
  }]

def test_asr_combined := [llvmfunc|
  llvm.func @test_asr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.ashr %arg0, %arg1  : i32
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.lshr %arg0, %arg1  : i32
    llvm.br ^bb3(%3 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i32
  }]

theorem inst_combine_test_asr   : test_asr_before  ⊑  test_asr_combined := by
  unfold test_asr_before test_asr_combined
  simp_alive_peephole
  sorry
