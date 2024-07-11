import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  add-min-max
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def uadd_min_max_before := [llvmfunc|
  llvm.func @uadd_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

def uadd_min_max_comm_before := [llvmfunc|
  llvm.func @uadd_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

def uadd_min_max_nuw_nsw_before := [llvmfunc|
  llvm.func @uadd_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }]

def sadd_min_max_before := [llvmfunc|
  llvm.func @sadd_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

def sadd_min_max_comm_before := [llvmfunc|
  llvm.func @sadd_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }]

def sadd_min_max_nuw_nsw_before := [llvmfunc|
  llvm.func @sadd_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.add %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }]

def uadd_min_max_combined := [llvmfunc|
  llvm.func @uadd_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_min_max   : uadd_min_max_before  ⊑  uadd_min_max_combined := by
  unfold uadd_min_max_before uadd_min_max_combined
  simp_alive_peephole
  sorry
def uadd_min_max_comm_combined := [llvmfunc|
  llvm.func @uadd_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_min_max_comm   : uadd_min_max_comm_before  ⊑  uadd_min_max_comm_combined := by
  unfold uadd_min_max_comm_before uadd_min_max_comm_combined
  simp_alive_peephole
  sorry
def uadd_min_max_nuw_nsw_combined := [llvmfunc|
  llvm.func @uadd_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1 overflow<nsw, nuw>  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_uadd_min_max_nuw_nsw   : uadd_min_max_nuw_nsw_before  ⊑  uadd_min_max_nuw_nsw_combined := by
  unfold uadd_min_max_nuw_nsw_before uadd_min_max_nuw_nsw_combined
  simp_alive_peephole
  sorry
def sadd_min_max_combined := [llvmfunc|
  llvm.func @sadd_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sadd_min_max   : sadd_min_max_before  ⊑  sadd_min_max_combined := by
  unfold sadd_min_max_before sadd_min_max_combined
  simp_alive_peephole
  sorry
def sadd_min_max_comm_combined := [llvmfunc|
  llvm.func @sadd_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sadd_min_max_comm   : sadd_min_max_comm_before  ⊑  sadd_min_max_comm_combined := by
  unfold sadd_min_max_comm_before sadd_min_max_comm_combined
  simp_alive_peephole
  sorry
def sadd_min_max_nuw_nsw_combined := [llvmfunc|
  llvm.func @sadd_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.add %arg0, %arg1 overflow<nsw, nuw>  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_sadd_min_max_nuw_nsw   : sadd_min_max_nuw_nsw_before  ⊑  sadd_min_max_nuw_nsw_combined := by
  unfold sadd_min_max_nuw_nsw_before sadd_min_max_nuw_nsw_combined
  simp_alive_peephole
  sorry
