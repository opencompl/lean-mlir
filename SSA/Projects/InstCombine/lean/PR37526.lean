import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  PR37526
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR37526_before := [llvmfunc|
  llvm.func @PR37526(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.icmp "slt" %0, %1 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i64]

    llvm.store %4, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

    llvm.return
  }]

def PR37526_combined := [llvmfunc|
  llvm.func @PR37526(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.load %arg2 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_PR37526   : PR37526_before  ⊑  PR37526_combined := by
  unfold PR37526_before PR37526_combined
  simp_alive_peephole
  sorry
    %1 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_PR37526   : PR37526_before  ⊑  PR37526_combined := by
  unfold PR37526_before PR37526_combined
  simp_alive_peephole
  sorry
    %2 = llvm.icmp "slt" %0, %1 : i32
    %3 = llvm.select %2, %arg1, %arg2 : i1, !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i64]

theorem inst_combine_PR37526   : PR37526_before  ⊑  PR37526_combined := by
  unfold PR37526_before PR37526_combined
  simp_alive_peephole
  sorry
    llvm.store %4, %arg0 {alignment = 4 : i64} : i64, !llvm.ptr]

theorem inst_combine_PR37526   : PR37526_before  ⊑  PR37526_combined := by
  unfold PR37526_before PR37526_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine_PR37526   : PR37526_before  ⊑  PR37526_combined := by
  unfold PR37526_before PR37526_combined
  simp_alive_peephole
  sorry
