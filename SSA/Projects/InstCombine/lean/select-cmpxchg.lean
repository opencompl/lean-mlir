import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-cmpxchg
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def cmpxchg_0_before := [llvmfunc|
  llvm.func @cmpxchg_0(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.cmpxchg %arg0, %arg1, %arg2 seq_cst seq_cst {alignment = 8 : i64} : !llvm.ptr, i64]

    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i64, i1)> 
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    llvm.return %3 : i64
  }]

def cmpxchg_1_before := [llvmfunc|
  llvm.func @cmpxchg_1(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.cmpxchg %arg0, %arg1, %arg2 seq_cst seq_cst {alignment = 8 : i64} : !llvm.ptr, i64]

    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i64, i1)> 
    %3 = llvm.select %1, %2, %arg1 : i1, i64
    llvm.return %3 : i64
  }]

def cmpxchg_2_before := [llvmfunc|
  llvm.func @cmpxchg_2(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.cmpxchg %arg0, %arg1, %arg2 acq_rel monotonic {alignment = 8 : i64} : !llvm.ptr, i64]

    %1 = llvm.extractvalue %0[1] : !llvm.struct<(i64, i1)> 
    %2 = llvm.extractvalue %0[0] : !llvm.struct<(i64, i1)> 
    %3 = llvm.select %1, %arg1, %2 : i1, i64
    %4 = llvm.select %1, %3, %arg1 : i1, i64
    llvm.return %4 : i64
  }]

def cmpxchg_0_combined := [llvmfunc|
  llvm.func @cmpxchg_0(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.cmpxchg %arg0, %arg1, %arg2 seq_cst seq_cst {alignment = 8 : i64} : !llvm.ptr, i64
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i64, i1)> 
    llvm.return %1 : i64
  }]

theorem inst_combine_cmpxchg_0   : cmpxchg_0_before  ⊑  cmpxchg_0_combined := by
  unfold cmpxchg_0_before cmpxchg_0_combined
  simp_alive_peephole
  sorry
def cmpxchg_1_combined := [llvmfunc|
  llvm.func @cmpxchg_1(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.cmpxchg %arg0, %arg1, %arg2 seq_cst seq_cst {alignment = 8 : i64} : !llvm.ptr, i64
    llvm.return %arg1 : i64
  }]

theorem inst_combine_cmpxchg_1   : cmpxchg_1_before  ⊑  cmpxchg_1_combined := by
  unfold cmpxchg_1_before cmpxchg_1_combined
  simp_alive_peephole
  sorry
def cmpxchg_2_combined := [llvmfunc|
  llvm.func @cmpxchg_2(%arg0: !llvm.ptr, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.cmpxchg %arg0, %arg1, %arg2 acq_rel monotonic {alignment = 8 : i64} : !llvm.ptr, i64
    llvm.return %arg1 : i64
  }]

theorem inst_combine_cmpxchg_2   : cmpxchg_2_before  ⊑  cmpxchg_2_combined := by
  unfold cmpxchg_2_before cmpxchg_2_combined
  simp_alive_peephole
  sorry
