import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  PR30597
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def dot_ref_s_before := [llvmfunc|
  llvm.func @dot_ref_s(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64, llvm.noalias, llvm.nocapture, llvm.readonly}) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.inttoptr %2 : i64 to !llvm.ptr
    %4 = llvm.icmp "eq" %3, %0 : !llvm.ptr
    llvm.return %4 : i1
  }]

def function_before := [llvmfunc|
  llvm.func @function(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64, llvm.noalias, llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def dot_ref_s_combined := [llvmfunc|
  llvm.func @dot_ref_s(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64, llvm.noalias, llvm.nocapture, llvm.readonly}) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_dot_ref_s   : dot_ref_s_before  ⊑  dot_ref_s_combined := by
  unfold dot_ref_s_before dot_ref_s_combined
  simp_alive_peephole
  sorry
def function_combined := [llvmfunc|
  llvm.func @function(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64, llvm.noalias, llvm.nocapture, llvm.readonly}) -> !llvm.ptr {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.inttoptr %0 : i64 to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_function   : function_before  ⊑  function_combined := by
  unfold function_before function_combined
  simp_alive_peephole
  sorry
