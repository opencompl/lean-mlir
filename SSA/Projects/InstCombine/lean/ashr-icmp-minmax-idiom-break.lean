import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ashr-icmp-minmax-idiom-break
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def dont_break_minmax_i64_before := [llvmfunc|
  llvm.func @dont_break_minmax_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(348731 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mul %arg0, %arg1 overflow<nsw>  : i64
    %4 = llvm.ashr %3, %0  : i64
    %5 = llvm.icmp "sgt" %4, %1 : i64
    %6 = llvm.icmp "ult" %5, %2 : i1
    %7 = llvm.select %6, %4, %1 : i1, i64
    llvm.return %7 : i64
  }]

def dont_break_minmax_i64_combined := [llvmfunc|
  llvm.func @dont_break_minmax_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(348731 : i64) : i64
    %2 = llvm.mul %arg0, %arg1 overflow<nsw>  : i64
    %3 = llvm.ashr %2, %0  : i64
    %4 = llvm.intr.smin(%3, %1)  : (i64, i64) -> i64
    llvm.return %4 : i64
  }]

theorem inst_combine_dont_break_minmax_i64   : dont_break_minmax_i64_before  ⊑  dont_break_minmax_i64_combined := by
  unfold dont_break_minmax_i64_before dont_break_minmax_i64_combined
  simp_alive_peephole
  sorry
