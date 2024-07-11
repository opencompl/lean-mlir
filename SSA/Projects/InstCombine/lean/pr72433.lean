import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr72433
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def widget_before := [llvmfunc|
  llvm.func @widget(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(20 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.zext %4 : i1 to i32
    %6 = llvm.sub %1, %5  : i32
    %7 = llvm.mul %2, %6  : i32
    %8 = llvm.zext %4 : i1 to i32
    %9 = llvm.xor %8, %3  : i32
    %10 = llvm.add %7, %9  : i32
    %11 = llvm.mul %10, %6  : i32
    llvm.return %11 : i32
  }]

def widget_combined := [llvmfunc|
  llvm.func @widget(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.shl %1, %3 overflow<nsw, nuw>  : i32
    %5 = llvm.zext %2 : i1 to i32
    %6 = llvm.or %4, %5  : i32
    %7 = llvm.zext %2 : i1 to i32
    %8 = llvm.shl %6, %7 overflow<nsw, nuw>  : i32
    llvm.return %8 : i32
  }]

theorem inst_combine_widget   : widget_before  ⊑  widget_combined := by
  unfold widget_before widget_combined
  simp_alive_peephole
  sorry
