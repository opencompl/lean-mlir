import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-phi
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def no_crash_before := [llvmfunc|
  llvm.func @no_crash(%arg0: f32, %arg1: i1) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.br ^bb1(%0 : f32)
  ^bb1(%1: f32):  // 2 preds: ^bb0, ^bb2
    %2 = llvm.fadd %1, %arg0  : f32
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb1(%2 : f32)
  ^bb3:  // pred: ^bb1
    llvm.return %2 : f32
  }]

def pr21377_before := [llvmfunc|
  llvm.func @pr21377(%arg0: i32, %arg1: i1) {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb3
    %3 = llvm.zext %arg0 : i32 to i64
    llvm.cond_br %arg1, ^bb3(%0 : i64), ^bb2
  ^bb2:  // pred: ^bb1
    %4 = llvm.or %2, %3  : i64
    %5 = llvm.and %4, %1  : i64
    llvm.br ^bb3(%5 : i64)
  ^bb3(%6: i64):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.or %6, %3  : i64
    llvm.br ^bb1(%7 : i64)
  }]

def no_crash_combined := [llvmfunc|
  llvm.func @no_crash(%arg0: f32, %arg1: i1) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    llvm.br ^bb1(%0 : f32)
  ^bb1(%1: f32):  // 2 preds: ^bb0, ^bb2
    %2 = llvm.fadd %1, %arg0  : f32
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb1(%2 : f32)
  ^bb3:  // pred: ^bb1
    llvm.return %2 : f32
  }]

theorem inst_combine_no_crash   : no_crash_before  ⊑  no_crash_combined := by
  unfold no_crash_before no_crash_combined
  simp_alive_peephole
  sorry
def pr21377_combined := [llvmfunc|
  llvm.func @pr21377(%arg0: i32, %arg1: i1) {
    %0 = llvm.mlir.poison : i64
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    llvm.br ^bb1(%0 : i64)
  ^bb1(%2: i64):  // 2 preds: ^bb0, ^bb3
    %3 = llvm.zext %arg0 : i32 to i64
    llvm.cond_br %arg1, ^bb3(%0 : i64), ^bb2
  ^bb2:  // pred: ^bb1
    %4 = llvm.and %2, %1  : i64
    %5 = llvm.or %4, %3  : i64
    llvm.br ^bb3(%5 : i64)
  ^bb3(%6: i64):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.or %6, %3  : i64
    llvm.br ^bb1(%7 : i64)
  }]

theorem inst_combine_pr21377   : pr21377_before  ⊑  pr21377_combined := by
  unfold pr21377_before pr21377_combined
  simp_alive_peephole
  sorry
