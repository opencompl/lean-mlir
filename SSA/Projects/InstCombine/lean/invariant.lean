import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  invariant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %2 {alignment = 1 : i64} : i8, !llvm.ptr]

    %3 = llvm.intr.invariant.start 1, %2 : !llvm.ptr
    llvm.call @g(%2) : (!llvm.ptr) -> ()
    %4 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> i8]

    llvm.return %4 : i8
  }]

def f_addrspace1_before := [llvmfunc|
  llvm.func @f_addrspace1(%arg0: !llvm.ptr<1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr<1>]

    %1 = llvm.intr.invariant.start 1, %arg0 : !llvm.ptr<1>
    llvm.call @g_addr1(%arg0) : (!llvm.ptr<1>) -> ()
    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr<1> -> i8]

    llvm.return %2 : i8
  }]

def f_combined := [llvmfunc|
  llvm.func @f() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %2 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    %3 = llvm.intr.invariant.start 1, %2 : !llvm.ptr
    llvm.call @g(%2) : (!llvm.ptr) -> ()
    %4 = llvm.load %2 {alignment = 1 : i64} : !llvm.ptr -> i8]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
    llvm.return %4 : i8
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
def f_addrspace1_combined := [llvmfunc|
  llvm.func @f_addrspace1(%arg0: !llvm.ptr<1>) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr<1>]

theorem inst_combine_f_addrspace1   : f_addrspace1_before  ⊑  f_addrspace1_combined := by
  unfold f_addrspace1_before f_addrspace1_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.invariant.start 1, %arg0 : !llvm.ptr<1>
    llvm.call @g_addr1(%arg0) : (!llvm.ptr<1>) -> ()
    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr<1> -> i8]

theorem inst_combine_f_addrspace1   : f_addrspace1_before  ⊑  f_addrspace1_combined := by
  unfold f_addrspace1_before f_addrspace1_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i8
  }]

theorem inst_combine_f_addrspace1   : f_addrspace1_before  ⊑  f_addrspace1_combined := by
  unfold f_addrspace1_before f_addrspace1_combined
  simp_alive_peephole
  sorry
