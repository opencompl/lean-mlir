import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-02-28-ICmp
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f1_before := [llvmfunc|
  llvm.func @f1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16711680 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

def f1_logical_before := [llvmfunc|
  llvm.func @f1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16711680 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.trunc %arg0 : i32 to i8
    %5 = llvm.icmp "ne" %4, %0 : i8
    %6 = llvm.and %arg0, %1  : i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    %8 = llvm.select %5, %7, %3 : i1, i1
    llvm.return %8 : i1
  }]

def f1_combined := [llvmfunc|
  llvm.func @f1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16711680 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_f1   : f1_before  ⊑  f1_combined := by
  unfold f1_before f1_combined
  simp_alive_peephole
  sorry
def f1_logical_combined := [llvmfunc|
  llvm.func @f1_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16711680 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.trunc %arg0 : i32 to i8
    %4 = llvm.icmp "ne" %3, %0 : i8
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.and %4, %6  : i1
    llvm.return %7 : i1
  }]

theorem inst_combine_f1_logical   : f1_logical_before  ⊑  f1_logical_combined := by
  unfold f1_logical_before f1_logical_combined
  simp_alive_peephole
  sorry
