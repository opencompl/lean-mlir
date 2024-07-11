import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2010-01-28-NegativeSRem
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f() -> i32 {
    %0 = llvm.mlir.constant(-29 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.srem %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.cond_br %6, ^bb2, ^bb1(%3 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  }]

def f_combined := [llvmfunc|
  llvm.func @f() -> i32 {
    %0 = llvm.mlir.constant(-29 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb1
    %5 = llvm.srem %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    llvm.cond_br %6, ^bb2, ^bb1(%3 : i32)
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
