import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-bitcast-glob
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def icmp_func_before := [llvmfunc|
  llvm.func @icmp_func() -> i1 {
    %0 = llvm.mlir.addressof @f32 : !llvm.ptr
    %1 = llvm.mlir.addressof @f64 : !llvm.ptr
    %2 = llvm.icmp "eq" %0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }]

def icmp_fptr_before := [llvmfunc|
  llvm.func @icmp_fptr(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @f32 : !llvm.ptr
    %1 = llvm.icmp "ne" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }]

def icmp_glob_before := [llvmfunc|
  llvm.func @icmp_glob(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.addressof @icmp_glob : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.icmp "eq" %0, %1 : !llvm.ptr
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    llvm.return %3 : i32
  }]

def icmp_func_combined := [llvmfunc|
  llvm.func @icmp_func() -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_icmp_func   : icmp_func_before  ⊑  icmp_func_combined := by
  unfold icmp_func_before icmp_func_combined
  simp_alive_peephole
  sorry
def icmp_fptr_combined := [llvmfunc|
  llvm.func @icmp_fptr(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @f32 : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_icmp_fptr   : icmp_fptr_before  ⊑  icmp_fptr_combined := by
  unfold icmp_fptr_before icmp_fptr_combined
  simp_alive_peephole
  sorry
def icmp_glob_combined := [llvmfunc|
  llvm.func @icmp_glob(%arg0: i32, %arg1: i32) -> i32 {
    llvm.return %arg1 : i32
  }]

theorem inst_combine_icmp_glob   : icmp_glob_before  ⊑  icmp_glob_combined := by
  unfold icmp_glob_before icmp_glob_combined
  simp_alive_peephole
  sorry
