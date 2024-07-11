import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  mul-min-max
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def umul_min_max_before := [llvmfunc|
  llvm.func @umul_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }]

def umul_min_max_comm_before := [llvmfunc|
  llvm.func @umul_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }]

def umul_min_max_nuw_nsw_before := [llvmfunc|
  llvm.func @umul_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.umax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.umin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }]

def smul_min_max_before := [llvmfunc|
  llvm.func @smul_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }]

def smul_min_max_comm_before := [llvmfunc|
  llvm.func @smul_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg1, %arg0)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0  : i32
    llvm.return %2 : i32
  }]

def smul_min_max_nuw_nsw_before := [llvmfunc|
  llvm.func @smul_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smax(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %2 = llvm.mul %1, %0 overflow<nsw, nuw>  : i32
    llvm.return %2 : i32
  }]

def umul_min_max_combined := [llvmfunc|
  llvm.func @umul_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umul_min_max   : umul_min_max_before  ⊑  umul_min_max_combined := by
  unfold umul_min_max_before umul_min_max_combined
  simp_alive_peephole
  sorry
def umul_min_max_comm_combined := [llvmfunc|
  llvm.func @umul_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umul_min_max_comm   : umul_min_max_comm_before  ⊑  umul_min_max_comm_combined := by
  unfold umul_min_max_comm_before umul_min_max_comm_combined
  simp_alive_peephole
  sorry
def umul_min_max_nuw_nsw_combined := [llvmfunc|
  llvm.func @umul_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw, nuw>  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_umul_min_max_nuw_nsw   : umul_min_max_nuw_nsw_before  ⊑  umul_min_max_nuw_nsw_combined := by
  unfold umul_min_max_nuw_nsw_before umul_min_max_nuw_nsw_combined
  simp_alive_peephole
  sorry
def smul_min_max_combined := [llvmfunc|
  llvm.func @smul_min_max(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smul_min_max   : smul_min_max_before  ⊑  smul_min_max_combined := by
  unfold smul_min_max_before smul_min_max_combined
  simp_alive_peephole
  sorry
def smul_min_max_comm_combined := [llvmfunc|
  llvm.func @smul_min_max_comm(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smul_min_max_comm   : smul_min_max_comm_before  ⊑  smul_min_max_comm_combined := by
  unfold smul_min_max_comm_before smul_min_max_comm_combined
  simp_alive_peephole
  sorry
def smul_min_max_nuw_nsw_combined := [llvmfunc|
  llvm.func @smul_min_max_nuw_nsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mul %arg0, %arg1 overflow<nsw, nuw>  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_smul_min_max_nuw_nsw   : smul_min_max_nuw_nsw_before  ⊑  smul_min_max_nuw_nsw_combined := by
  unfold smul_min_max_nuw_nsw_before smul_min_max_nuw_nsw_combined
  simp_alive_peephole
  sorry
