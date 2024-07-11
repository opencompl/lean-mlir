import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr21891
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.undef : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.cond_br %2, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %5 = llvm.shl %arg0, %3 overflow<nuw>  : i32
    llvm.br ^bb2(%5 : i32)
  ^bb2(%6: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %6 : i32
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.cond_br %2, ^bb1, ^bb2(%1 : i32)
  ^bb1:  // pred: ^bb0
    %5 = llvm.shl %arg0, %3 overflow<nuw>  : i32
    llvm.br ^bb2(%5 : i32)
  ^bb2(%6: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %6 : i32
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
