import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr38915
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR38915_before := [llvmfunc|
  llvm.func @PR38915(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sub %0, %arg1  : i32
    %4 = llvm.icmp "sgt" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.xor %5, %1  : i32
    %7 = llvm.icmp "sgt" %6, %arg2 : i32
    %8 = llvm.select %7, %6, %arg2 : i1, i32
    %9 = llvm.xor %8, %1  : i32
    llvm.return %9 : i32
  }]

def PR38915_combined := [llvmfunc|
  llvm.func @PR38915(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    %2 = llvm.add %arg1, %0  : i32
    %3 = llvm.intr.smin(%1, %2)  : (i32, i32) -> i32
    %4 = llvm.intr.smax(%3, %arg2)  : (i32, i32) -> i32
    %5 = llvm.xor %4, %0  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_PR38915   : PR38915_before  ⊑  PR38915_combined := by
  unfold PR38915_before PR38915_combined
  simp_alive_peephole
  sorry
