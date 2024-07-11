import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr21199
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: i32) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %arg0, %0 : i1, i32
    %5 = llvm.icmp "ult" %1, %4 : i32
    llvm.cond_br %5, ^bb1(%1 : i32), ^bb2
  ^bb1(%6: i32):  // 2 preds: ^bb0, ^bb1
    llvm.call @f(%4) : (i32) -> ()
    %7 = llvm.add %6, %2  : i32
    %8 = llvm.icmp "ult" %7, %4 : i32
    llvm.cond_br %8, ^bb1(%7 : i32), ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: i32) {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.intr.umin(%arg0, %0)  : (i32, i32) -> i32
    %4 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.cond_br %4, ^bb2, ^bb1(%1 : i32)
  ^bb1(%5: i32):  // 2 preds: ^bb0, ^bb1
    llvm.call @f(%3) : (i32) -> ()
    %6 = llvm.add %5, %2  : i32
    %7 = llvm.icmp "ult" %6, %3 : i32
    llvm.cond_br %7, ^bb1(%6 : i32), ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
