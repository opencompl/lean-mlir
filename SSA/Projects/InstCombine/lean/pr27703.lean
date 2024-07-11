import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr27703
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def mem_before := [llvmfunc|
  llvm.func @mem() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.br ^bb1(%0 : !llvm.ptr)
  ^bb1(%1: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %3 = llvm.bitcast %2 : !llvm.ptr to !llvm.ptr
    %4 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %5 = llvm.bitcast %4 : !llvm.ptr to !llvm.ptr
    llvm.br ^bb1(%5 : !llvm.ptr)
  }]

def mem_combined := [llvmfunc|
  llvm.func @mem() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.br ^bb1(%0 : !llvm.ptr)
  ^bb1(%1: !llvm.ptr):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_mem   : mem_before  ⊑  mem_combined := by
  unfold mem_before mem_combined
  simp_alive_peephole
  sorry
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine_mem   : mem_before  ⊑  mem_combined := by
  unfold mem_before mem_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb1(%3 : !llvm.ptr)
  }]

theorem inst_combine_mem   : mem_before  ⊑  mem_combined := by
  unfold mem_before mem_combined
  simp_alive_peephole
  sorry
