import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr49688
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.ashr %1, %arg0  : i32
    %5 = llvm.icmp "sgt" %arg0, %4 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

def f2_before := [llvmfunc|
  llvm.func @f2(%arg0: i32 {llvm.signext}, %arg1: i32 {llvm.zeroext}) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.ashr %1, %arg1  : i32
    %5 = llvm.icmp "sgt" %arg0, %4 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.lshr %1, %arg0  : i32
    %5 = llvm.icmp "slt" %4, %arg0 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.return %6 : i1
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
def f2_combined := [llvmfunc|
  llvm.func @f2(%arg0: i32 {llvm.signext}, %arg1: i32 {llvm.zeroext}) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.lshr %1, %arg1  : i32
    %5 = llvm.icmp "slt" %4, %arg0 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_f2   : f2_before  ⊑  f2_combined := by
  unfold f2_before f2_combined
  simp_alive_peephole
  sorry
