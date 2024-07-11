import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-05-18-FoldIntToPtr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f1_before := [llvmfunc|
  llvm.func @f1() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def f2_before := [llvmfunc|
  llvm.func @f2() -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.inttoptr %0 : i16 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i16) : i16
    %3 = llvm.inttoptr %2 : i16 to !llvm.ptr
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    llvm.return %4 : i1
  }]

def f1_combined := [llvmfunc|
  llvm.func @f1() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_f1   : f1_before  ⊑  f1_combined := by
  unfold f1_before f1_combined
  simp_alive_peephole
  sorry
def f2_combined := [llvmfunc|
  llvm.func @f2() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_f2   : f2_before  ⊑  f2_combined := by
  unfold f2_before f2_combined
  simp_alive_peephole
  sorry
