import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr80941
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pr80941_before := [llvmfunc|
  llvm.func @pr80941(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1]

    llvm.cond_br %1, ^bb1, ^bb2(%arg0 : f32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.fpext %arg0 : f32 to f64
    %3 = llvm.intr.copysign(%0, %2)  : (f64, f64) -> f64
    %4 = llvm.fptrunc %3 : f64 to f32
    llvm.br ^bb2(%4 : f32)
  ^bb2(%5: f32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : f32
  }]

def pr80941_combined := [llvmfunc|
  llvm.func @pr80941(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 144 : i32}> : (f32) -> i1
    llvm.cond_br %1, ^bb1, ^bb2(%arg0 : f32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.fpext %arg0 : f32 to f64
    %3 = llvm.intr.copysign(%0, %2)  : (f64, f64) -> f64
    %4 = llvm.fptrunc %3 : f64 to f32
    llvm.br ^bb2(%4 : f32)
  ^bb2(%5: f32):  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : f32
  }]

theorem inst_combine_pr80941   : pr80941_before  ⊑  pr80941_combined := by
  unfold pr80941_before pr80941_combined
  simp_alive_peephole
  sorry
