import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  nonnull-select
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def pr48975(%arg0: !llvm.ptr) -> _before := [llvmfunc|
  llvm.func @pr48975(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    %3 = llvm.select %2, %0, %arg0 : i1, !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

def nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) -> _before := [llvmfunc|
  llvm.func @nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _before := [llvmfunc|
  llvm.func @nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) -> _before := [llvmfunc|
  llvm.func @nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull, llvm.noundef}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _before := [llvmfunc|
  llvm.func @nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull, llvm.noundef}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

def nonnull_call_before := [llvmfunc|
  llvm.func @nonnull_call(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def nonnull_call2_before := [llvmfunc|
  llvm.func @nonnull_call2(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def nonnull_noundef_call_before := [llvmfunc|
  llvm.func @nonnull_noundef_call(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def nonnull_noundef_call2_before := [llvmfunc|
  llvm.func @nonnull_noundef_call2(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def pr48975(%arg0: !llvm.ptr) -> _combined := [llvmfunc|
  llvm.func @pr48975(%arg0: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    %3 = llvm.select %2, %0, %arg0 : i1, !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }]

theorem inst_combine_pr48975(%arg0: !llvm.ptr) ->    : pr48975(%arg0: !llvm.ptr) -> _before  ⊑  pr48975(%arg0: !llvm.ptr) -> _combined := by
  unfold pr48975(%arg0: !llvm.ptr) -> _before pr48975(%arg0: !llvm.ptr) -> _combined
  simp_alive_peephole
  sorry
def nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) -> _combined := [llvmfunc|
  llvm.func @nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) ->    : nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) -> _before  ⊑  nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) -> _combined := by
  unfold nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) -> _before nonnull_ret(%arg0: i1, %arg1: !llvm.ptr) -> _combined
  simp_alive_peephole
  sorry
def nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _combined := [llvmfunc|
  llvm.func @nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) ->    : nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _before  ⊑  nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _combined := by
  unfold nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _before nonnull_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _combined
  simp_alive_peephole
  sorry
def nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) -> _combined := [llvmfunc|
  llvm.func @nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull, llvm.noundef}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) ->    : nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) -> _before  ⊑  nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) -> _combined := by
  unfold nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) -> _before nonnull_noundef_ret(%arg0: i1, %arg1: !llvm.ptr) -> _combined
  simp_alive_peephole
  sorry
def nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _combined := [llvmfunc|
  llvm.func @nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) -> (!llvm.ptr {llvm.nonnull, llvm.noundef}) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }]

theorem inst_combine_nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) ->    : nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _before  ⊑  nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _combined := by
  unfold nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _before nonnull_noundef_ret2(%arg0: i1, %arg1: !llvm.ptr) -> _combined
  simp_alive_peephole
  sorry
def nonnull_call_combined := [llvmfunc|
  llvm.func @nonnull_call(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_nonnull_call   : nonnull_call_before  ⊑  nonnull_call_combined := by
  unfold nonnull_call_before nonnull_call_combined
  simp_alive_peephole
  sorry
def nonnull_call2_combined := [llvmfunc|
  llvm.func @nonnull_call2(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_nonnull_call2   : nonnull_call2_before  ⊑  nonnull_call2_combined := by
  unfold nonnull_call2_before nonnull_call2_combined
  simp_alive_peephole
  sorry
def nonnull_noundef_call_combined := [llvmfunc|
  llvm.func @nonnull_noundef_call(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %arg1, %0 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_nonnull_noundef_call   : nonnull_noundef_call_before  ⊑  nonnull_noundef_call_combined := by
  unfold nonnull_noundef_call_before nonnull_noundef_call_combined
  simp_alive_peephole
  sorry
def nonnull_noundef_call2_combined := [llvmfunc|
  llvm.func @nonnull_noundef_call2(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.select %arg0, %0, %arg1 : i1, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_nonnull_noundef_call2   : nonnull_noundef_call2_before  ⊑  nonnull_noundef_call2_combined := by
  unfold nonnull_noundef_call2_before nonnull_noundef_call2_combined
  simp_alive_peephole
  sorry
