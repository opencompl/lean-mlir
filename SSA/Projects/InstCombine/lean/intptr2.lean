import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  intptr2
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.readnone}, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %arg1 : !llvm.ptr
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = llvm.ptrtoint %arg2 : !llvm.ptr to i64
    llvm.br ^bb2(%arg0, %3 : !llvm.ptr, i64)
  ^bb2(%4: !llvm.ptr, %5: i64):  // 2 preds: ^bb1, ^bb2
    %6 = llvm.inttoptr %5 : i64 to !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32]

    %8 = llvm.fmul %7, %0  : f32
    llvm.store %8, %4 {alignment = 4 : i64} : f32, !llvm.ptr]

    %9 = llvm.getelementptr inbounds %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %10 = llvm.ptrtoint %9 : !llvm.ptr to i64
    %11 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %12 = llvm.icmp "ult" %11, %arg1 : !llvm.ptr
    llvm.cond_br %12, ^bb2(%11, %10 : !llvm.ptr, i64), ^bb3
  ^bb3:  // 2 preds: ^bb0, ^bb2
    llvm.return
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.readnone}, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %arg1 : !llvm.ptr
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg0, %arg2 : !llvm.ptr, !llvm.ptr)
  ^bb2(%3: !llvm.ptr, %4: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    %6 = llvm.fmul %5, %0  : f32
    llvm.store %6, %3 {alignment = 4 : i64} : f32, !llvm.ptr]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
    %7 = llvm.getelementptr inbounds %4[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %8 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %9 = llvm.icmp "ult" %8, %arg1 : !llvm.ptr
    llvm.cond_br %9, ^bb2(%8, %7 : !llvm.ptr, !llvm.ptr), ^bb3
  ^bb3:  // 2 preds: ^bb0, ^bb2
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
