import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr80597
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pr80597_before := [llvmfunc|
  llvm.func @pr80597(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(4294967293 : i64) : i64
    %2 = llvm.mlir.constant(32 : i64) : i64
    %3 = llvm.mlir.constant(8836839514384105472 : i64) : i64
    %4 = llvm.mlir.constant(-34359738368 : i64) : i64
    %5 = llvm.mlir.constant(8836839522974040064 : i64) : i64
    %6 = llvm.mlir.constant(1 : i64) : i64
    %7 = llvm.select %arg0, %0, %1 : i1, i64
    %8 = llvm.shl %7, %2  : i64
    %9 = llvm.add %8, %3  : i64
    %10 = llvm.icmp "ult" %9, %4 : i64
    llvm.cond_br %10, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %11 = llvm.or %8, %5  : i64
    %12 = llvm.ashr %11, %6  : i64
    llvm.return %12 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i64
  }]

def pr80597_combined := [llvmfunc|
  llvm.func @pr80597(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-12884901888 : i64) : i64
    %2 = llvm.mlir.constant(8836839514384105472 : i64) : i64
    %3 = llvm.mlir.constant(-34359738368 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(4418419761487020032 : i64) : i64
    %6 = llvm.select %arg0, %0, %1 : i1, i64
    %7 = llvm.add %6, %2 overflow<nsw>  : i64
    %8 = llvm.icmp "ult" %7, %3 : i64
    llvm.cond_br %8, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %9 = llvm.ashr %6, %4  : i64
    %10 = llvm.or %9, %5  : i64
    llvm.return %10 : i64
  ^bb2:  // pred: ^bb0
    llvm.return %0 : i64
  }]

theorem inst_combine_pr80597   : pr80597_before  ⊑  pr80597_combined := by
  unfold pr80597_before pr80597_combined
  simp_alive_peephole
  sorry
